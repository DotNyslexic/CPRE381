library IEEE;
use IEEE.std_logic_1164.all;


--Assign inputs / outputs of 2:1 MUX

entity TwoToOneMux is
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Z  : in std_logic;
       o_RES  : out std_logic);
end TwoToOneMux;


--Define architecture of 2:1 MUX

architecture structure of TwoToOneMux is


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

signal logicValueAndOne, logicValueAndTwo, negated_X : std_logic;

begin

--Store inverted X signal

InvertX : invg
port MAP(
	i_A => i_X,
	o_F => negated_X);

--Store value of first AND logic

logicOne : andg2
port MAP(
	i_A => i_Y,
	i_B => negated_X,
	o_F => logicValueAndOne);

--Store value of second AND logic

logicTwo : andg2
port MAP(
	i_A => i_Z,
	i_B => i_X,
	o_F => logicValueAndTwo);

--Output value of final OR logic

logicOutput : org2
port MAP(
	i_A => logicValueAndOne,
	i_B => logicValueAndTwo,
	o_F => o_RES);

end structure;