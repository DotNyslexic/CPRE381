library IEEE;
use IEEE.std_logic_1164.all;

entity SetLessThan is

port (i_A : in std_logic;
	o_F : out std_logic);
end SetLessThan;

architecture behavior of SetLessThan is

begin

-- For the 32 bit module, we just need to get the input value to the port
o_F <= i_A;

end behavior;