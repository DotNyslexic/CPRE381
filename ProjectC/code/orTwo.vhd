library IEEE;
use IEEE.std_logic_1164.all;

entity orTwo is

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end orTwo;

architecture behavior of orTwo is

begin

o_F <= i_A or i_B;

end behavior;