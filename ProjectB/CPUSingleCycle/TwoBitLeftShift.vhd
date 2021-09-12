library IEEE;
use IEEE.std_logic_1164.all;

entity TwoBitLeftShift is
generic(N : integer := 32);

port (i_In : in std_logic_vector(N-1 downto 0);
	o_Out : out std_logic_vector(N-1 downto 0));

end TwoBitLeftShift;

architecture bhv of TwoBitLeftShift is

begin

o_Out <= i_In(29 DOWNTO 0) & "00";

end bhv;
