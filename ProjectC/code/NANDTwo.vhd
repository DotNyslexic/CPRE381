library IEEE;
use IEEE.std_logic_1164.all;

entity NANDTwo is

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end NANDTwo;

architecture behavior of NANDTwo is

begin

o_F <= i_A nand i_B;

end behavior;