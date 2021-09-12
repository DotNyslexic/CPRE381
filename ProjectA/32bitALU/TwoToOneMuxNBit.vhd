library IEEE;
use IEEE.std_logic_1164.all;


--Assign inputs / outputs of multiple 2:1 MUXes

entity TwoToOneMuxNBit is
generic(N : integer := 1);
  port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));
end TwoToOneMuxNBit;


--Define architecture of 2:1 MUX

architecture structure of TwoToOneMuxNBit is


--NOT gate

component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;


--OR gate

component org2

port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;


--AND gate

component andg2

port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;


--Intermediate signals to store logic values of gates

signal logicValueAndOne, logicValueAndTwo : std_logic_vector(N-1 downto 0);
signal  negated_X : std_logic;

begin


--Store inverted X signal

InvertX : invg
port MAP(
	i_A => i_X,
	o_F => negated_X);


--Store value of first AND logic, generate input bits

G1: for i in 0 to N-1 generate
     logicOne : andg2 
    port map(i_A  => i_Y(i),
	     i_B => negated_X,
  	     o_F  => logicValueAndOne(i));


--Store value of second AND logic


     logicTwo : andg2 
    port map(i_A  => i_Z(i),
	     i_B => i_X,
  	     o_F  => logicValueAndTwo(i));


--Output value of final OR logic


     logicOutput : org2 
    port map(i_A  => logicValueAndOne(i),
	     i_B => logicValueAndTwo(i),
  	     o_F  => o_RES(i));
end generate;

end structure;