library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRegisterIFID is

generic(N : integer := 32);
  port(i_Clock        : in std_logic;     -- Clock input
       i_Stall         : in std_logic;     -- Cause values in pipeline to freeze
       i_Flush        : in std_logic;     -- Clear values in the pipeline
       i_Instruction          : in std_logic_vector(N-1 downto 0);     -- Data value input
	   i_PCPlusFour     : in std_logic_vector(N-1 downto 0);
       o_OutputPCPlusFour       : out std_logic_vector(N-1 downto 0);
	   o_OutputInstruction    : out std_logic_vector(N-1 downto 0));   -- Data value output

end NBitRegisterIFID;

architecture structure of NBitRegisterIFID is

component PPLdff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_STALL         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

InstructionInput: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_Instruction(i),
	o_Q => o_OutputInstruction(i));
end generate;

PCPlusFour: for i in 0 to N-1 generate
	dFlipFlops : PPLdff
    port map( i_CLK => i_Clock,
	i_RST => i_Flush,
	i_STALL => i_Stall,
	i_D => i_PCPlusFour(i),
	o_Q => o_OutputPCPlusFour(i));
end generate;


 
end structure;