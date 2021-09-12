library IEEE;
use IEEE.std_logic_1164.all;

entity FiveBitTwoToOneMux is

port(i_A, i_B   :   in std_logic_vector(4 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(4 downto 0));
end FiveBitTwoToOneMux;

architecture dataflow of FiveBitTwoToOneMux is

begin

with i_SELECT select
	o_OUTPUT <= i_A when '0',
		    i_B when '1',
"00000" when others;

end dataflow;