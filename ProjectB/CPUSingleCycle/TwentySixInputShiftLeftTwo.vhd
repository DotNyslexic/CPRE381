library ieee;
use ieee.std_logic_1164.all;

entity TwentySixInputShiftLeftTwo is

port (i_input : in std_logic_vector(25 downto 0);
	o_output : out std_logic_vector(27 downto 0));

end TwentySixInputShiftLeftTwo;

architecture behavior of TwentySixInputShiftLeftTwo is

signal s_outputExtended : std_logic_vector(27 downto 0);
signal leftmost : std_logic;
begin

leftmost <= i_input(25);

s_outputExtended(25 downto 0) <= i_input(25 downto 0);

with leftmost select
		s_outputExtended(1 downto 0) <= "11" when '1',
				  "00" when '0',
				  "00" when others;
o_output <= s_outputExtended;

end behavior;