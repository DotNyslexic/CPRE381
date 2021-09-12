-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

component MIPSAppBarrelShiftALU

port(i_MIPSCLK   : in std_logic; -- Input clock to the processor
	-- Register file inputs
	i_RegFileReadRS, i_RegFileReadRT   : in std_logic_vector(4 downto 0);  -- Register read and write addresses
	i_RegFileWriteEnable, i_ALUInputBsrc, i_ALUnAddSub  : in std_logic; -- Register write enable, immediate vs RT source select for ALU, and ALU add sub control
	i_RegFileRes : in std_logic_vector(31 downto 0); -- Register reset control
	i_MIPSImmediate   : in std_logic_vector(15 downto 0); -- MIPS immediate value to be added
	i_RegFileDataInput : in std_logic_vector(N-1 downto 0); -- Data input to registers
	o_OutputRegisterTwo : out std_logic_vector(N-1 downto 0); -- Output value of register 2 to halt program
	-- Register file outputs
	o_RegFileOutputRS,o_RegFileOutputRT  : out std_logic_vector(31 downto 0); -- Output RS and RT of register file
	-- RAM write enable
	i_RAMwe : in std_logic; -- Write enable for ram
	-- OP control for ALU
	i_ALUOpControl : in std_logic_vector(2 downto 0); -- operation control for ALU
	-- Cotrol signal for LUI
	i_LUI : in std_logic;
	i_ChooseSignExtend : in std_logic;
	-- Input signal for register write
	i_writeSignal : in std_logic_vector(4 downto 0);
	-- Barrel shifter inputs
	i_sign_extended_barrel : in std_logic; -- Sign extender for barrel shifter control
	i_left_shift_barrel : in std_logic; -- shift left and shift right commands for barrel shifter
	i_arithmetic_barrel : in std_logic;
	i_shift_amt_barrel : in std_logic_vector(4 downto 0); -- How much to shift the input to the barrel shifter 
	i_shifterRTInputSelect : in std_logic; -- Select whether we want RS to be shifted or not
	-- ALU outputs
	o_signedExtenderOutput : out std_logic_vector(N-1 downto 0);
	o_Zero : out std_logic; -- Whether the output of the ALU is zero
	o_Overflow : out std_logic; -- Whether the output of the ALU has overflow
	o_Cout : out std_logic;
	o_signExtended : out std_logic; -- The final carry of the last arithmetic operation for the ALU
	o_ALUOutput : out std_logic_vector(N-1 downto 0));
end component;

component ThirtyTwoBitALU
port (i_A, i_B : in std_logic_vector(N-1 downto 0);
	i_AddSubMaster : in std_logic;
	i_OpControl : in std_logic_vector(2 downto 0);
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

component andg2
port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component invg
  port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;


component TwoToOneMux
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Z  : in std_logic;
       o_RES  : out std_logic);
end component;

component FourToOneMuxNBitDataflow
port(i_A,i_B,i_C,i_D : in std_logic_vector(N-1 downto 0);
     i_S0,i_S1       : in std_logic;
     o_Z             : out std_logic_vector(N-1 downto 0));
end component;

component FiveBitFourToOneMux
port(i_A,i_B,i_C,i_D : in std_logic_vector(4 downto 0);
     i_S0,i_S1       : in std_logic;
     o_Z             : out std_logic_vector(4 downto 0));
end component;

component TwoBitLeftShift
port (i_In : in std_logic_vector(N-1 downto 0);
      o_Out : out std_logic_vector(N-1 downto 0));
end component;

component ProgramCounter
port(i_CLK		: in std_logic;
             i_Reset		: in std_logic;
             i_PCInput   	: in std_logic_vector(N-1 downto 0);
	     o_PCOutput   	: out std_logic_vector(N-1 downto 0);
             o_PCPlusFour   	: out std_logic_vector(N-1 downto 0));
end component;

component FiveBitTwoToOneMux
port(i_A, i_B   :   in std_logic_vector(4 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(4 downto 0));
end component;

component TwentySixBitTwoBitLeftShift
port(i_In : in std_logic_vector(25 downto 0);
	o_Out : out std_logic_vector(27 downto 0));
end component;

component MIPSInstructionDecoder
port( i_instruction_function : in std_logic_vector(5 downto 0);
	i_instruction_opcode : in std_logic_vector(5 downto 0);
--------------------------------------------
	o_reg_Dst : out std_logic_vector(1 downto 0);
	o_reg_Jump : out std_logic;
	o_Branch : out std_logic;
	o_Mem_To_Reg : out std_logic_vector(1 downto 0);
	o_Mem_Write : out std_logic;
	o_ALU_Src : out std_logic;
	o_Reg_Write : out std_logic;
	o_LUI : out std_logic;
	o_Sign_Extend_Choice : out std_logic;
---------------------------------------------
        o_ALU_Op : out std_logic_vector(2 downto 0);
	o_ALUn_AddSub : out std_logic;
	o_Shifter_Mux_Control : out std_logic;
	o_Arithmetic : out std_logic;
	o_Sign_Extended : out std_logic;
	o_Left_Shift : out std_logic;
	o_Variable_Shift : out std_logic;
---------------------------------------------
	o_isBranch : out std_logic;
	o_isBNE : out std_logic;
        o_isJump : out std_logic;
        o_isJR : out std_logic);
end component;

component FullAdderNBit
	port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : std_logic_vector(N-1 downto 0);
       i_Carin  : in std_logic;
       o_C  : out std_logic_vector(N-1 downto 0);
       o_Carout  : out std_logic);
end component;

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

signal s_ReadAddress, s_ALUOutput, s_WritebackData : std_logic_vector(N-1 downto 0);
signal s_PCOutput, s_PCOutputPlusFour : std_logic_vector(N-1 downto 0);
signal s_PCInput : std_logic_vector(N-1 downto 0);
signal s_isBranch, s_isBNE, s_isJump, s_isJR, s_reg_Jump, s_Branch, s_Mem_Write, s_ALU_src, s_Reg_Write, s_ALUn_AddSub, s_Shifter_Mux_Control, s_Arithmetic, s_Sign_Extend_Barrel, s_Sign_Extend_Choice, s_Left_shift, s_LUI, s_Variable_Shift : std_logic;
signal s_reg_Dst, s_Mem_to_Reg : std_logic_vector(1 downto 0);
signal s_ALU_OP : std_logic_vector(2 downto 0);
signal s_Shamt : std_logic_vector(4 downto 0);
signal s_OutputRS, s_OutputRT, s_OutputRSVariableAccounted : std_logic_vector(N-1 downto 0);
signal s_RegFileReset : std_logic_vector(N-1 downto 0);
signal s_Zero, s_INVzero, s_BNEselected, s_BranchTypeSelect, s_Overflow, s_Cout, s_SignExtended : std_logic;
signal s_ReadRS : std_logic_vector(4 downto 0);
signal s_InstructionsShifted : std_logic_vector(27 downto 0);
signal s_jumpAddress, s_BranchAddress, s_SignExtenderShifted, s_selectedBranchAddress, s_selectedJumpOrBranch, s_SignExtenderOutput : std_logic_vector(31 downto 0);

begin

  -- concatonating two signals for the jump address 
  s_jumpAddress <= s_PCOutputPlusFour(31 downto 28) & s_InstructionsShifted;

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  s_Halt <= '1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  CreateCounter: ProgramCounter
	port map(i_CLK => iCLK,
		i_Reset => iRST,
		i_PCInput => s_PCInput,
		o_PCOutput => s_NextInstAddr,
		o_PCPlusFour => s_PCOutputPlusFour);


--Create 4:1 MUX at output of data memory
--0 = memory, 1 = ALU, 2 = PC+4, 3 = 0 (no means to be selected)
GRegfilesel: for i in 0 to 0 generate
	REGFILEWRITEBACKMUX : FourToOneMuxNBitDataflow
--port map(i_A => s_ALUOutput,
--	i_B => s_DMemOut,
--	i_SELECT => s_Mem_to_Reg,
--	o_OUTPUT => s_WritebackData);

port map(i_A => s_ALUOutput,
        i_B => s_DMemOut,
	i_C => s_PCOutputPlusFour,	
	i_D => "00000000000000000000000000000000",
    	i_S0 => s_Mem_to_Reg(0),
	i_S1 => s_Mem_to_Reg(1),
     	o_Z => s_WritebackData);

end generate;

s_RegFileReset(31) <= iRST;
s_RegFileReset(30) <= iRST;
s_RegFileReset(29) <= iRST;
s_RegFileReset(28) <= iRST;
s_RegFileReset(27) <= iRST;
s_RegFileReset(26) <= iRST;
s_RegFileReset(25) <= iRST;
s_RegFileReset(24) <= iRST;
s_RegFileReset(23) <= iRST;
s_RegFileReset(22) <= iRST;
s_RegFileReset(21) <= iRST;
s_RegFileReset(20) <= iRST;
s_RegFileReset(19) <= iRST;
s_RegFileReset(18) <= iRST;
s_RegFileReset(17) <= iRST;
s_RegFileReset(16) <= iRST;
s_RegFileReset(15) <= iRST;
s_RegFileReset(14) <= iRST;
s_RegFileReset(13) <= iRST;
s_RegFileReset(12) <= iRST;
s_RegFileReset(11) <= iRST;
s_RegFileReset(10) <= iRST;
s_RegFileReset(9) <= iRST;
s_RegFileReset(8) <= iRST;
s_RegFileReset(7) <= iRST;
s_RegFileReset(6) <= iRST;
s_RegFileReset(5) <= iRST;
s_RegFileReset(4) <= iRST;
s_RegFileReset(3) <= iRST;
s_RegFileReset(2) <= iRST;
s_RegFileReset(1) <= iRST;
s_RegFileReset(0) <= '1';


CreateDecoder: MIPSInstructionDecoder
	port map(i_instruction_function => s_Inst(5 downto 0),
		i_instruction_opcode => s_Inst(31 downto 26),
		o_reg_Dst => s_reg_Dst,
		o_reg_Jump => s_reg_Jump,
		o_Branch => s_Branch,
		o_Mem_to_Reg => s_Mem_to_Reg,
		o_Mem_Write => s_DMemWr,
		o_ALU_Src => s_ALU_src,
		o_Reg_Write => s_Reg_Write,
		o_LUI => s_LUI,
		o_Sign_Extend_Choice => s_Sign_Extend_Choice,
		o_ALU_Op => s_ALU_OP,
		o_ALUn_AddSub => s_ALUn_AddSub,
		o_Shifter_Mux_Control => s_Shifter_Mux_Control,
		o_Arithmetic => s_Arithmetic,
		o_Sign_Extended => s_Sign_Extend_Barrel,
		o_Left_Shift => s_Left_Shift,
		o_Variable_Shift => s_Variable_Shift,
		o_isBranch => s_isBranch,
		o_isBNE => s_isBNE,
        	o_isJump => s_isJump,
        	o_isJR => s_isJR);

--0 = non-variable shift, 1 = variable shift
ShiftSelect: FiveBitTwoToOneMux
	port map( i_A => s_Inst(10 downto 6),
		i_B => s_Inst(25 downto 21),
		i_SELECT => s_Variable_Shift,
		o_OUTPUT => s_Shamt);

--0 = non-variable shift, 1 = variable shift
RSReadSelect: FiveBitTwoToOneMux
	port map( i_A => s_Inst(25 downto 21),
		i_B => s_Inst(10 downto 6),
		i_SELECT => s_Variable_Shift,
		o_OUTPUT => s_ReadRS);


--Create 4:1 MUX at input to write register signal
--0 = rt, 1 = rd, 2 = reg 31, 3 = 0 (not meant to be chosen)
REGFILEWRITESEL : FiveBitFourToOneMux
port map(i_A => s_Inst(20 downto 16),
        i_B => s_Inst(15 downto 11),
	i_C => "11111",	
	i_D => "00000",
    	i_S0 => s_reg_Dst(0),
	i_S1 => s_reg_Dst(1),
     	o_Z => s_RegWrAddr);

CreateRegisterFileAndALU: MIPSAppBarrelShiftALU
	port map(i_MIPSCLK => iCLK,
		i_RegFileReadRS => s_ReadRS,
		i_RegFileReadRT => s_Inst(20 downto 16),
		i_writeSignal => s_RegWrAddr,
		i_RegFileDataInput => s_RegWrData,
		i_MIPSImmediate => s_Inst(15 downto 0),
		i_RegFileWriteEnable => s_RegWr,
		o_OutputRegisterTwo => v0,
		i_ALUInputBsrc => s_ALU_src,
		i_ALUnAddSub => s_ALUn_AddSub,
		i_RegFileRes => s_RegFileReset,
		o_RegFileOutputRS => s_OutputRS,
		o_RegFileOutputRT => s_OutputRT,
		i_RAMwe => s_Mem_Write,
		i_LUI => s_LUI,
		i_ChooseSignExtend => s_Sign_Extend_Choice,
		i_ALUOpControl => s_ALU_OP,
		i_sign_extended_barrel => s_Sign_Extend_Barrel,
		i_left_shift_barrel => s_Left_Shift,
		i_arithmetic_barrel => s_Arithmetic,
		i_shift_amt_barrel => s_Shamt,
		i_shifterRTInputSelect => s_Shifter_Mux_Control,
        o_signedExtenderOutput => s_SignExtenderOutput,
		o_Zero => s_Zero, 
		o_Overflow => s_Overflow,
		o_Cout => s_Cout,
		o_signExtended => s_SignExtended,
		o_ALUOutput => s_ALUOutput);

s_DMemAddr <= s_AluOutput;
s_DMemData <= s_OutputRT;
s_RegWr <= s_Reg_Write;
oALUOut <= s_ALUOutput;
s_RegWrData <= s_WritebackData;

-- Shifter for (25-0) of instruction
InstructionShift : TwentySixBitTwoBitLeftShift
port map(i_In => s_Inst(25 downto 0),
	o_Out => s_InstructionsShifted);

-- Sign extender for 2nd input of branch ALU
SignExtenderShift : TwoBitLeftShift
port map(i_In => s_SignExtenderOutput,
       o_Out => s_SignExtenderShifted);

-- Branch Address ALU
BranchALU : FullAdderNBit
port map(i_A => s_PCOutputPlusFour,
		i_Carin => '0',
     i_B => s_SignExtenderShifted,
     o_C => s_BranchAddress);

-- NOT gate for negating ALU signal zero
InverseZero : invg
port map(i_A => s_zero,
       o_F => s_INVzero);

signalSelectMux : TwoToOneMux
port map(i_X => s_isBNE,
       i_Y => s_zero,
       i_Z => s_INVzero,
       o_RES => s_BNEselected);

signalAND : andg2
port map(i_A => s_isBranch,
       i_B => s_BNEselected,
       o_F => s_BranchTypeSelect);

BranchAddressSelect : ThirtyTwoBitTwoToOneMux
port map(i_A => s_PCOutputPlusFour, 
	i_B => s_BranchAddress,
	i_SELECT => s_BranchTypeSelect,
	o_OUTPUT => s_selectedBranchAddress);

isJumpSelect : ThirtyTwoBitTwoToOneMux
port map(i_A => s_selectedBranchAddress, 
	i_B => s_jumpAddress,
	i_SELECT => s_isJump,
	o_OUTPUT => s_selectedJumpOrBranch);

isJR : ThirtyTwoBitTwoToOneMux
port map(i_A => s_selectedJumpOrBranch, 
	i_B => s_WritebackData,
	i_SELECT => s_isJR,
	o_OUTPUT => s_PCInput);

end structure;
