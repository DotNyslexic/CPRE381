library IEEE;
use IEEE.std_logic_1164.all;


--Assign inputs / outputs of multiple 2:1 MUXes

entity TwoToOneMuxNBitDataflow is
generic(N : integer := 32);
  port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));
end TwoToOneMuxNBitDataflow;


--Define architecture of 2:1 MUX

architecture dataflow of TwoToOneMuxNBitDataflow is


--Intermediate signals to store logic values of gates

signal logicValueAndOne, logicValueAndTwo : std_logic_vector(N-1 downto 0);
signal  negated_X : std_logic;

begin


--Store inverted X signal

	negated_X <= not i_X;

--Store value of first AND logic

G1: for i in 0 to N-1 generate
logicValueAndOne(i) <= i_Y(i) and negated_X;

--Store value of second AND logic

logicValueAndTwo(i) <= i_Z(i) AND i_X;

--Output value of final OR logic

o_RES(i) <= logicValueAndOne(i) OR logicValueAndTwo(i);
end generate;

end dataflow;