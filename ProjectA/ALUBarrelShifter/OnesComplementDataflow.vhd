library IEEE;
use IEEE.std_logic_1164.all;

entity OnesComplementDataflow is
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end OnesComplementDataflow;

architecture dataflow of OnesComplementDataflow is

begin

o_F <= not i_A;

end dataflow;