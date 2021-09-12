library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRegisterIDEX is

generic(N : integer := 32);
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

end NBitRegisterIDEX;

architecture structure of NBitRegisterIDEX is

component PPLdff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_STALL         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin
  
OutputRS: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_OutputRS(i),
	o_Q => o_OutputRS(i));
end generate;

OutputRT: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_OutputRT(i),
	o_Q => o_OutputRT(i));
end generate;

ImmediateValue: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ExtendedImmediate(i),
	o_Q => o_ExtendedImmediate(i));
end generate;

ShifterInput: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ShifterInput(i),
	o_Q => o_ShifterInput(i));
end generate;

ffregDest: for i in 0 to 1 generate
dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_reg_Dst(i),
	o_Q => o_reg_Dst(i));
end generate;
	
ffMemToReg: for i in 0 to 1 generate
dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Mem_To_Reg(i),
	o_Q => o_Mem_To_Reg(i));
end generate;
	
ffMemWrite : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Mem_Write,
	o_Q => o_Mem_Write);
	
ffALUSrc : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ALU_Src,
	o_Q => o_ALU_Src);
	
ffRegWrite : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Reg_Write,
	o_Q => o_Reg_Write);
	
ffLUI : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_LUI,
	o_Q => o_LUI);
	
ffSignExtendChoice : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Sign_Extend_Choice,
	o_Q => o_Sign_Extend_Choice);
	
ALUOpInput: for i in 0 to 2 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ALU_Op(i),
	o_Q => o_ALU_Op(i));
end generate;

ffnAddSub : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ALUn_AddSub,
	o_Q => o_ALUn_AddSub);
	
ffShiftMuxControl : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Shifter_Mux_Control,
	o_Q => o_Shifter_Mux_Control);
	
ffArithmetic : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Arithmetic,
	o_Q => o_Arithmetic);
	
ffSignExtended : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Sign_Extended,
	o_Q => o_Sign_Extended);
	
ffLeftShift : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Left_Shift,
	o_Q => o_Left_Shift);
	
ffVariableShift : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Variable_Shift,
	o_Q => o_Variable_Shift);
	
BarrelShifterSHAMT: for i in 0 to 4 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Shift_Amount(i),
	o_Q => o_Shift_Amount(i));
end generate;

RegisterWriteSignal: for i in 0 to 4 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_RegisterWriteSignal(i),
	o_Q => o_RegisterWriteSignal(i));
end generate;

PCOutputPlusFour: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_PCOutputPlusFour(i),
	o_Q => o_PCOutputPlusFour(i));
end generate;

ffisJR : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_IDEXisJR,
	o_Q => o_isJRIDEX);


end structure;