library IEEE;
use IEEE.std_logic_1164.all;

entity NORTwo is

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end NORTwo;

architecture behavior of NORTwo is

begin

o_F <= i_A nor i_B;

end behavior;