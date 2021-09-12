library IEEE;
use IEEE.std_logic_1164.all;

entity andTwo is

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end andTwo;

architecture behavior of andTwo is

begin

o_F <= i_A and i_B;

end behavior;