library IEEE;
use IEEE.std_logic_1164.all;

entity NBitRegisterStackPointer is

generic(N : integer := 32);
  port(i_Clock        : in std_logic;     -- Clock input
       i_WriteEn         : in std_logic;     -- Write enable input
       i_Reset        : in std_logic;     -- Reset input
       i_Data          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Output          : out std_logic_vector(N-1 downto 0));   -- Data value output

end NBitRegisterStackPointer;

architecture structure of NBitRegisterStackPointer is

component ResetOnedff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

component ResetZerodff
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin
  
  dFlipFlopLowResetOne : ResetZerodff
    port map( i_CLK => i_Clock,
	i_RST => i_Reset,
	i_WE => i_WriteEn,
	i_D => i_Data(31),
	o_Q => o_Output(31));
  
G1: for i in 13 to 30 generate
	dFlipFlopsHighReset : ResetOnedff
    port map( i_CLK => i_Clock,
	i_RST => i_Reset,
	i_WE => i_WriteEn,
	i_D => i_Data(i),
	o_Q => o_Output(i));
end generate;

    dFlipFlopLowResetTwo : ResetZerodff
    port map( i_CLK => i_Clock,
	i_RST => i_Reset,
	i_WE => i_WriteEn,
	i_D => i_Data(12),
	o_Q => o_Output(12));

G2: for i in 2 to 11 generate
	dFlipFlopsHighReset : ResetOnedff
    port map( i_CLK => i_Clock,
	i_RST => i_Reset,
	i_WE => i_WriteEn,
	i_D => i_Data(i),
	o_Q => o_Output(i));
end generate;

    G3: for i in 0 to 1 generate
    dFlipFlopsLowReset : ResetZerodff
    port map( i_CLK => i_Clock,
	i_RST => i_Reset,
	i_WE => i_WriteEn,
	i_D => i_Data(i),
	o_Q => o_Output(i));
	end generate;
 
end structure;