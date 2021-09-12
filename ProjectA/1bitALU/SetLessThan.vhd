library IEEE;
use IEEE.std_logic_1164.all;

entity SetLessThan is

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end SetLessThan;

architecture behavior of SetLessThan is

begin

ALessThanB:
process(i_A, i_B)
begin

    if i_A = '0' and i_B = '1' then
	o_F <= '1';
    else 
	o_F <= '0';

end if;
end process;

end behavior;