library IEEE;
use IEEE.std_logic_1164.all;

entity MIPSAppBarrelShiftALU is

generic(N: integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

port(i_MIPSCLK   : in std_logic; -- Input clock to the processor
	-- Register file inputs
	i_RegFileReadRS, i_RegFileReadRT   : in std_logic_vector(4 downto 0);  -- Register read and write addresses
	i_RegFileWriteEnable, i_ALUInputBsrc  : in std_logic; -- Register write enable, immediate vs RT source select for ALU, and ALU add sub control
	i_RegFileRes : in std_logic_vector(31 downto 0); -- Register reset control
	i_MIPSImmediate   : in std_logic_vector(15 downto 0); -- MIPS immediate value to be added
	i_RegFileDataInput : in std_logic_vector(N-1 downto 0); -- Data input to registers
	o_OutputRegisterTwo : out std_logic_vector(N-1 downto 0); -- Output value of register 2 to halt program
	
	-- Register file outputs
	o_RegFileOutputRS,o_RegFileOutputRT  : out std_logic_vector(31 downto 0); -- Output RS and RT of register file
	
	o_OutputDetermineBranch   :   out std_logic;
	o_InstructionImmediateSignExtended   : out std_logic_vector(31 downto 0);
	
	-- Pipeline inputs and outputs
	i_StallIDEX, i_FlushIDEX   :  in std_logic;

	i_reg_Dst : in std_logic_vector(1 downto 0);
	i_reg_Jump : in std_logic;
	i_Mem_To_Reg : in std_Logic_vector(1 downto 0);
	i_Mem_Write : in std_logic;
	i_Reg_writeIDEX : in std_logic;
	i_Sign_Extend_Choice : in std_logic;
	i_ALU_Op : in std_logic_vector(2 downto 0);
	i_ALUn_AddSub : in std_logic;
	i_Shifter_Mux_Control : in std_logic;
	i_Arithmetic : in std_logic;
	i_Sign_Extended : in std_logic;
	i_Left_Shift : in std_logic;
	i_Variable_Shift : in std_logic;
	i_IDEXRegWriteAddress : in std_logic_vector(4 downto 0);
	i_isJR : in std_logic;
	
	i_PCOutputPlusFour : in std_logic_vector(31 downto 0);
	o_PCOutputPlusFour : out std_logic_vector(31 downto 0);
	
	o_IDEXReg_DST, o_IDEXMem_To_Reg : out std_logic_vector (1 downto 0);
	o_IDEXReg_Write, o_IDEXMem_write : out std_logic;
	o_IDEXRegisterWriteSignal : out std_logic_vector(4 downto 0);
	o_IDEXOutputRT : out std_logic_vector(31 downto 0);
	o_isJR : out std_logic;
	
	-- Cotrol signal for LUI
	i_LUI : in std_logic;
	
	-- Input signal for register write
	i_writeSignal : in std_logic_vector(4 downto 0);
	
	-- Barrel shifter inputs
	i_shift_amt_barrel : in std_logic_vector(4 downto 0); -- How much to shift the input to the barrel shifter 
	
	-- ALU outputs
    o_signedExtenderOutput : out std_logic_vector(N-1 downto 0);
	o_Zero : out std_logic; -- Whether the output of the ALU is zero
	o_Overflow : out std_logic; -- Whether the output of the ALU has overflow
	o_Cout : out std_logic;
	o_signExtended : out std_logic; -- The final carry of the last arithmetic operation for the ALU
	o_ALUOutput : out std_logic_vector(N-1 downto 0));
end MIPSAppBarrelShiftALU;

architecture structure of MIPSAppBarrelShiftALU is

component RegisterFile
port(i_WriteSignal   : in std_logic_vector(4 downto 0);
		i_InputData   : in std_logic_vector(N-1 downto 0);
		i_CLK   : in std_logic;
		i_MasterWriteEn   : in std_logic;
		i_MasterRes   : in std_logic_vector(N-1 downto 0);
		i_ReadRS   : in std_logic_vector(4 downto 0);
		i_ReadRT   : in std_logic_vector(4 downto 0);
		o_OutputRS   : out std_logic_vector(N-1 downto 0);
		o_OutputRT   : out std_logic_vector(N-1 downto 0);
		o_OutputRegisterTwo : out std_logic_vector(N-1 downto 0));
end component;

component shifterALU
port (-- barrelshifter input
      i_sign_extended : in  STD_LOGIC;
      i_left_shift  : in  STD_LOGIC;
      i_arithmetic  : in  STD_LOGIC;
      i_shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0); 
      -- both 32 bit inputs          
      i_inputRS     : in  STD_LOGIC_VECTOR (N-1 downto 0);
      i_inputRT     : in  STD_LOGIC_VECTOR (N-1 downto 0);
      -- 32 bit ALU controls
      i_AddSubMaster : in std_logic;
      i_OpControl : in std_logic_vector(2 downto 0);
      -- Shifter mux control
      i_shifterMuxControl : in std_logic;
      -- final outputs
      o_Zero : out std_logic;
      o_Overflow : out std_logic;
      o_Cout : out std_logic;
      o_BiggerALU : out std_logic_vector(N-1 downto 0));
end component;

component ThirtyTwoBitTwoToOneMux
port(i_A, i_B   :   in std_logic_vector(31 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(31 downto 0));
end component;

component FiveBitTwoToOneMux
port(i_A, i_B   :   in std_logic_vector(4 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(4 downto 0));
end component;

component SignedNumberExtender

port( i_input	: in	std_logic_vector(15 downto 0);
	o_output	: out std_logic_vector(31 downto 0));

end component;

component zeroExtender

  port( i_input	: in	std_logic_vector(15 downto 0);
	i_LUI : in std_logic;
	o_output	: out std_logic_vector(31 downto 0));

end component;

component NBitRegisterIDEX

port(i_Clock        : in std_logic;     -- Clock input
       i_Stall         : in std_logic;     -- Cause values in pipeline to freeze
       i_Flush        : in std_logic;     -- Clear values in the pipeline
       i_OutputRS         : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_OutputRT         : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_ExtendedImmediate : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_ShifterInput : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_reg_Dst : in std_logic_vector(1 downto 0);
	   i_reg_Jump : in std_logic;
	   i_Mem_To_Reg : in std_logic_vector(1 downto 0);
	   i_Mem_Write : in std_logic;
	   i_RegisterWriteSignal : in std_logic_vector(4 downto 0);
	   i_ALU_Src : in std_logic;
	   i_Reg_Write : in std_logic;
	   i_LUI : in std_logic;
	   i_Sign_Extend_Choice : in std_logic;
	   i_ALU_Op : in std_logic_vector(2 downto 0);
	   i_ALUn_AddSub : in std_logic;
	   i_Shifter_Mux_Control : in std_logic;
	   i_Arithmetic : in std_logic;
	   i_Sign_Extended: in std_logic;
	   i_Left_Shift : in std_logic;
	   i_Variable_Shift : in std_logic;
	   i_Shift_Amount  :  in std_logic_vector(4 downto 0);
	   i_PCOutputPlusFour : in std_logic_vector(31 downto 0);
	   i_IDEXisJR : in std_logic;
	   o_OutputRS         : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_OutputRT         : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_ExtendedImmediate : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_ShifterInput : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_reg_Dst : out std_logic_vector(1 downto 0);
	   o_reg_Jump : out std_logic;
	   o_Mem_To_Reg : out std_logic_vector(1 downto 0);
	   o_Mem_Write : out std_logic;
	   o_ALU_Src : out std_logic;
	   o_Reg_Write : out std_logic;
	   o_LUI : out std_logic;
	   o_Sign_Extend_Choice : out std_logic;
	   o_ALU_Op : out std_logic_vector(2 downto 0);
	   o_ALUn_AddSub : out std_logic;
	   o_Shifter_Mux_Control : out std_logic;
	   o_Arithmetic : out std_logic;
	   o_Sign_Extended: out std_logic;
	   o_Left_Shift : out std_logic;
	   o_Variable_Shift : out std_logic;
	   o_Shift_Amount : out std_logic_vector(4 downto 0);
	   o_RegisterWriteSignal : out std_logic_vector(4 downto 0);
	   o_PCOutputPlusFour : out std_logic_vector(31 downto 0);
	   o_isJRIDEX : out std_logic);   -- Data value output
	   
end component;

component checkEqualityOfRegisters

port ( i_A   :   in std_logic_vector(31 downto 0);
		i_B   :   in std_logic_vector(31 downto 0);
		o_F   :   out std_logic);
		
end component;

signal s_OutputRS, s_OutputRT, s_ALUMUXBInput, s_ExtendedImmed, s_SignExtended, s_ZeroExtended : std_logic_vector(31 downto 0);
signal s_ALUCarryOut : std_logic;
signal s_DetermineBranch : std_logic;
signal IDEXReg_Jump, IDEXMem_write, IDEXALU_src, IDEXReg_write, IDEXLUI, IDEXSign_Extend_Choice, IDEXALUn_AddSub, IDEXShifter_Mux_Control, IDEXArithmetic, IDEXSign_Extended, IDEXLeft_Shift, IDEXVariable_Shift : std_logic;
signal IDEXOutputRS, IDEXOutputRT, IDEXExtendedImmediate, IDEXShifterInput : std_logic_vector(31 downto 0);
signal IDEXReg_DST, IDEXMem_to_Reg : std_logic_vector (1 downto 0);
signal IDEXALU_Op : std_logic_vector (2 downto 0);
signal IDEXShiftAmt, IDEXRegWriteSignal : std_logic_vector(4 downto 0);
signal s_IDEXisJR : std_logic;

begin

o_signedExtenderOutput <= s_SignExtended;

--Create register file
GRegisters: for i in 0 to 0 generate
	BuildRegister : RegisterFile
port map( i_WriteSignal => i_writeSignal,
	i_InputData => i_RegFileDataInput,
	i_CLK => i_MIPSCLK,
	i_MasterWriteEn => i_RegFileWriteEnable,
	i_MasterRes => i_RegFileRes,
	i_ReadRS => i_RegFileReadRS,
	i_ReadRT => i_RegFileReadRT,
	o_OutputRS => s_OutputRS,
	o_OutputRT => s_OutputRT,
	o_OutputRegisterTwo => o_OutputRegisterTwo);
end generate;

o_RegFileOutputRS <= s_OutputRS;
o_RegFileOutputRT <= s_OutputRT;

CheckBranch : checkEqualityOfRegisters
port map(i_A => s_OutputRS,
		i_B => s_OutputRT,
		o_F => s_DetermineBranch);
		
		o_OutputDetermineBranch <= s_DetermineBranch;
		
PipelineTwo : NBitRegisterIDEX
port map(i_Clock        => i_MIPSCLK,
       i_Stall         => i_StallIDEX,
       i_Flush        => i_FlushIDEX,
       i_OutputRS         => s_OutputRS,
	   i_OutputRT         => s_OutputRT,
	   i_ExtendedImmediate => s_ExtendedImmed,     
	   i_ShifterInput => s_OutputRT,  -- maybe redundant
	   i_reg_Dst => i_reg_Dst,
	   i_reg_Jump => i_reg_Jump, -- maybe redundant
	   i_Mem_To_Reg => i_Mem_To_Reg,
	   i_Mem_Write => i_Mem_Write,
	   i_ALU_Src => i_ALUInputBsrc,
	   i_Reg_Write => i_Reg_writeIDEX,
	   i_RegisterWriteSignal => i_IDEXRegWriteAddress,
	   i_LUI => i_LUI, -- maybe redundant
	   i_Sign_Extend_Choice => i_Sign_Extend_Choice, -- maybe redundant
	   i_ALU_Op => i_ALU_Op,
	   i_ALUn_AddSub => i_ALUn_AddSub,
	   i_Shifter_Mux_Control => i_Shifter_Mux_Control, -- maybe redundant
	   i_Arithmetic => i_Arithmetic,
	   i_Sign_Extended => i_Sign_Extended,
	   i_Left_Shift => i_Left_Shift,
	   i_Variable_Shift => i_Variable_Shift,
	   i_Shift_Amount => i_shift_amt_barrel,
	   i_PCOutputPlusFour => i_PCOutputPlusFour,
	   i_IDEXisJR => i_isJR,
	   o_OutputRS => IDEXOutputRS,    
	   o_OutputRT => IDEXOutputRT,     
	   o_ExtendedImmediate => IDEXExtendedImmediate,     
	   o_ShifterInput => IDEXShifterInput,    -- maybe redundant 
	   o_reg_Dst => IDEXReg_DST,
	   o_reg_Jump => IDEXReg_Jump, -- maybe redundant
	   o_Mem_To_Reg => IDEXMem_to_Reg,
	   o_Mem_Write => IDEXMem_write,
	   o_ALU_Src => IDEXALU_Src,
	   o_Reg_Write => IDEXReg_write,
	   o_LUI => IDEXLUI, -- maybe redundant
	   o_Sign_Extend_Choice => IDEXSign_Extend_Choice,
	   o_ALU_Op => IDEXALU_Op,
	   o_ALUn_AddSub => IDEXALUn_AddSub,
	   o_Shifter_Mux_Control => IDEXShifter_Mux_Control, -- maybe redundant
	   o_Arithmetic => IDEXArithmetic,
	   o_Sign_Extended => IDEXSign_Extended,
	   o_Left_Shift => IDEXLeft_Shift,
	   o_Variable_Shift => IDEXVariable_Shift,
	   o_Shift_Amount => IDEXShiftAmt,
	   o_RegisterWriteSignal => IDEXRegWriteSignal,
	   o_PCOutputPlusFour => o_PCOutputPlusFour,
	   o_isJRIDEX => s_IDEXisJR);
	   
	   
	   o_IDEXOutputRT <= IDEXOutputRT;
	   o_isJR <= s_IDEXisJR;
	   

--Create signed extender

	EXTEND: SignedNumberExtender
port map( i_input => i_MIPSImmediate,
	o_output => s_SignExtended);


o_InstructionImmediateSignExtended <= s_SignExtended;

--Create zero extender
Gzeroextender: for i in 0 to 0 generate
	EXTEND: ZeroExtender
port map( i_input => i_MIPSImmediate,
	  i_LUI => i_LUI,
	o_output => s_ZeroExtended);
end generate;

--Create 2:1 MUX to select immediate
--0 = SignExtended, 1 = ZeroExtended
GEXTENDsel: for i in 0 to 0 generate
	EXTENDERMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => s_SignExtended,
	i_B => s_ZeroExtended,
	i_SELECT => i_Sign_Extend_Choice,
	o_OUTPUT => s_ExtendedImmed);
end generate;

--Create 2:1 MUX in front of ALU
--0 = OutputRT, 1 = ExtendedImmediate
GALUsel: for i in 0 to 0 generate
	ALUMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => IDEXOutputRT,
	i_B => IDEXExtendedImmediate,
	i_SELECT => IDEXALU_Src,
	o_OUTPUT => s_ALUMUXBInput);
end generate;

--Create ALU with MUXed input
GALU: for i in 0 to 0 generate
	BuildALU : shifterALU
port map( -- barrelshifter input
      i_sign_extended => IDEXSign_Extended,
      i_left_shift  => IDEXLeft_Shift,
      i_arithmetic  => IDEXArithmetic,
      i_shift_amt   => IDEXShiftAmt, 
      -- both 32 bit inputs          
      i_inputRS     => IDEXOutputRS,
      i_inputRT     => s_ALUMUXBInput,
      -- 32 bit ALU controls
      i_AddSubMaster => IDEXALUn_AddSub,
      i_OpControl => IDEXALU_Op,
      -- Shifter mux control
      i_shifterMuxControl => IDEXShifter_Mux_Control,
      -- final outputs
      o_Zero => o_Zero,
      o_Overflow => o_Overflow,
      o_Cout => o_Cout,
      o_BiggerALU => o_ALUOutput);
end generate;

o_IDEXReg_DST <= IDEXReg_DST;
o_IDEXMem_To_Reg <= IDEXMem_To_Reg;
o_IDEXMem_write <= IDEXMem_Write;
o_IDEXReg_write <= IDEXReg_Write;
o_IDEXRegisterWriteSignal <= IDEXRegWriteSignal;


end structure;