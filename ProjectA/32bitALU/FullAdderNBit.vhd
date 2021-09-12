library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdderNBit is
generic(N : integer := 1);
	port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : std_logic_vector(N-1 downto 0);
       i_Carin  : in std_logic;
       o_C  : out std_logic_vector(N-1 downto 0);
       o_Carout  : out std_logic);
end FullAdderNBit;

architecture structure of FullAdderNBit is

component FullAdder
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Cin  : in std_logic;
       o_Z  : out std_logic;
       o_Cout  : out std_logic);
end component;

signal carry : std_logic_vector(N downto 0);

begin 

carry(0) <= i_Carin;

G1: for i in 0 to N-1 generate
	numAdders : FullAdder
    port map( i_X => i_A(i),
	i_Y => i_B(i),
	o_Z => o_C(i),
	O_Cout => carry(i+1),
	i_Cin => carry(i));
end generate;

o_Carout <= carry(1);

end structure;
