library IEEE;
use IEEE.std_logic_1164.all;

entity checkEqualityOfRegisters is

port ( i_A   :   in std_logic_vector(31 downto 0);
		i_B   :   in std_logic_vector(31 downto 0);
		o_F   :   out std_logic);
		
end checkEqualityOfRegisters;

architecture behavior of checkEqualityOfRegisters is

begin

o_F <= '1' when i_A = i_B else '0';

end behavior;