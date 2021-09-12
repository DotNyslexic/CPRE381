library ieee;
use ieee.std_logic_1164.all;

entity tb_ZeroExtender is

end tb_ZeroExtender;

architecture behavior of tb_ZeroExtender is

component ZeroExtender is

 port( i_input	: in	std_logic_vector(15 downto 0);
	o_output	: out std_logic_vector(31 downto 0));

end component;

signal s_input	:	std_logic_vector(15 downto 0);
signal s_output	:	std_logic_vector(31 downto 0);

begin

DUT : ZeroExtender
	port map(i_input => s_input,
	o_output => s_output);

process
begin

s_input <= "0011100100011010";
wait for 100 ns;

s_input <= "1011100100011010";
wait for 100 ns;

s_input <= "1111111111111111";
wait for 100 ns;

s_input <= "0111111111111111";
wait for 100 ns;

s_input <= "0000000000000000";
wait for 100 ns;

end process;
end behavior;