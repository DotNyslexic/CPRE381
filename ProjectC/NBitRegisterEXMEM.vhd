library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRegisterEXMEM is

generic(N : integer := 32);
  port(i_Clock        : in std_logic;     -- Clock input
       i_Stall         : in std_logic;     -- Cause values in pipeline to freeze
       i_Flush        : in std_logic;     -- Clear values in the pipeline
       i_OutputRT          : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_ALUOutput          : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_PCOutputPlusFour   : in std_logic_vector(N-1 downto 0);
	   i_Mem_To_Reg   : in std_logic_vector(1 downto 0);
	   i_Mem_WE   : in std_logic;
	   i_Reg_WE   : in std_logic;
	   i_Reg_Write_Addr : in std_logic_vector(4 downto 0);
	   i_isJR : in std_logic;
	   o_OutputRT          : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_ALUOutput          : out std_logic_vector(N-1 downto 0);     -- Data value input
	   o_Mem_To_Reg   : out std_logic_vector(1 downto 0);
	   o_Mem_WE   : out std_logic;
	   o_Reg_WE   : out std_logic;
	   o_PCOutputPlusFour : out std_logic_vector(N-1 downto 0);
	   o_Reg_Write_Addr : out std_logic_vector(4 downto 0);
	   o_isJR : out std_logic);   

end NBitRegisterEXMEM;

architecture structure of NBitRegisterEXMEM is

component PPLdff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_STALL         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

ffOutputRT: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_OutputRT(i),
	o_Q => o_OutputRT(i));
end generate;

ffOutputALU: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_ALUOutput(i),
	o_Q => o_ALUOutput(i));
end generate;

ffMemToReg: for i in 0 to 1 generate
ffMemToReg : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Mem_To_Reg(i),
	o_Q => o_Mem_To_Reg(i));
end generate;

ffMemWE : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Mem_WE,
	o_Q => o_Mem_WE);
	
ffRegWE : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Reg_WE,
	o_Q => o_Reg_WE);
	
ffPCOutputPlusFour: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_PCOutputPlusFour(i),
	o_Q => o_PCOutputPlusFour(i));
end generate;

ffRegWriteSignal: for i in 0 to 4 generate
ffMemToReg : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Reg_Write_Addr(i),
	o_Q => o_Reg_Write_Addr(i));
end generate;

ffisJR : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_isJR,
	o_Q => o_isJR);
 
end structure;