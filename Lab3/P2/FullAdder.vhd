library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Cin  : in std_logic;
       o_Z  : out std_logic;
       o_Cout  : out std_logic);
end FullAdder;

architecture structure of FullAdder is

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

--XOR gate

component xorg2

port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

--Intermediate signals

signal outputXorXY, outputAndXorCin, outputAndXY : std_logic;

begin

--Calculate output signal and carry out signal

XorSignalOne : xorg2
    port map(i_A => i_X,
	     i_B => i_Y,
  	     o_F  => outputXorXY);

AndSignalOne : andg2
    port map(i_A => outputXorXY,
	     i_B => i_Cin,
  	     o_F  => outputAndXorCin);

AndSignalTwo : andg2
    port map(i_A => i_X,
	     i_B => i_Y,
  	     o_F  => outputAndXY);

sumOutput : xorg2
	port map(i_A => i_Cin,
		 i_B => outputXorXY,
		o_F => o_Z);

carryOutput : org2
port map(i_A => outputAndXorCin,
	 i_B => outputAndXY,
	 o_F => o_Cout);

end structure;


