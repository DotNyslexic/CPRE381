library IEEE;
use IEEE.std_logic_1164.all;

entity MuxEightToOne is

port (i_A : in std_logic;
	i_B : in std_logic;
	i_C : in std_logic;
	i_D : in std_logic;
	i_E : in std_logic;
	i_F : in std_logic;
	i_G : in std_logic;
	i_H : in std_logic;
	i_Sel : in std_logic_vector(2 downto 0);
	o_F : out std_logic);

end MuxEightToOne;

architecture behavior of MuxEightToOne is

begin

with i_Sel select

	o_F <= i_A when "000",
		i_B when "001",
		i_C when "010",
		i_D when "011",
		i_E when "100",
		i_F when "101",
		i_G when "110",
		i_H when "111",
		'0' when others;

end behavior;