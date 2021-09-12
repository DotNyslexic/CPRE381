library IEEE;
use IEEE.numeric_std.all;

entity FullAdderNBitDataflow is
generic(N : integer := 32);
port(i_X   :   in signed(N-1 downto 0);
     i_Y   :   in signed(N-1 downto 0);
     o_Z   :   out signed(N-1 downto 0));

end FullAdderNBitDataflow;

architecture dataflow of FullAdderNBitDataflow is

begin

o_Z <= i_X + i_Y;

end dataflow;