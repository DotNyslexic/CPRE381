library IEEE;
use IEEE.std_logic_1164.all;

entity MIPSAppBarrelShiftALU is

generic(N: integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

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

signal s_OutputRS, s_OutputRT, s_ALUMUXBInput, s_ExtendedImmed, s_SignExtended, s_ZeroExtended : std_logic_vector(31 downto 0);
signal s_ALUCarryOut : std_logic;

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


--Create signed extender
Gsignextender: for i in 0 to 0 generate
	EXTEND: SignedNumberExtender
port map( i_input => i_MIPSImmediate,
	o_output => s_SignExtended);
end generate;

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
	i_SELECT => i_ChooseSignExtend,
	o_OUTPUT => s_ExtendedImmed);
end generate;

--Create 2:1 MUX in front of ALU
--0 = OutputRT, 1 = ExtendedImmediate
GALUsel: for i in 0 to 0 generate
	ALUMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => s_OutputRT,
	i_B => s_ExtendedImmed,
	i_SELECT => i_ALUInputBsrc,
	o_OUTPUT => s_ALUMUXBInput);
end generate;

--Create ALU with MUXed input
GALU: for i in 0 to 0 generate
	BuildALU : shifterALU
port map( -- barrelshifter input
      i_sign_extended => i_sign_extended_barrel,
      i_left_shift  => i_left_shift_barrel,
      i_arithmetic  => i_arithmetic_barrel,
      i_shift_amt   => i_shift_amt_barrel, 
      -- both 32 bit inputs          
      i_inputRS     => s_OutputRS,
      i_inputRT     => s_ALUMUXBInput,
      -- 32 bit ALU controls
      i_AddSubMaster => i_ALUnAddSub,
      i_OpControl => i_ALUOpControl,
      -- Shifter mux control
      i_shifterMuxControl => i_shifterRTInputSelect,
      -- final outputs
      o_Zero => o_Zero,
      o_Overflow => o_Overflow,
      o_Cout => o_Cout,
      o_BiggerALU => o_ALUOutput);
end generate;


end structure;