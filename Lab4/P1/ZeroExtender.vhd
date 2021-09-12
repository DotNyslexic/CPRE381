library ieee;
use ieee.std_logic_1164.all;

entity ZeroExtender is

 port( i_input	: in	std_logic_vector(15 downto 0);
	o_output	: out std_logic_vector(31 downto 0));

end ZeroExtender;

architecture dataflow of ZeroExtender is

signal extended	:	std_logic_vector(31 downto 0);

begin

extended(15 downto 0) <= i_input(15 downto 0);
extended(31 downto 16) <= "0000000000000000";

o_output <= extended;

end dataflow;