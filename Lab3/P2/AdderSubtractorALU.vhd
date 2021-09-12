library IEEE;
use IEEE.std_logic_1164.all;

entity AdderSubtractorALU is
generic(N : integer := 32);
port( i_Aalu  :  in std_logic_vector(N-1 downto 0);
	i_Balu :  in std_logic_vector(N-1 downto 0);
	nAdd_Sub :  in std_logic;
	o_Falu :  out std_logic_vector(N-1 downto 0);
	o_carOutalu : out std_logic);
end AdderSubtractorALU;

architecture structure of AdderSubtractorALU is

component FullAdderNBit
port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : std_logic_vector(N-1 downto 0);
       i_Carin  : in std_logic;
       o_C  : out std_logic_vector(N-1 downto 0);
       o_Carout  : out std_logic);
end component;

component OnesComplement
port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component TwoToOneMuxNBit
port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));
end component;

signal signal_A, signal_B, signal_Binv, AddSubSelectOutput, SumDifferenceOutput: std_logic_vector(N-1 downto 0);
signal AdderCarryOutput: std_logic;

begin

signal_A <= i_Aalu;
signal_B <= i_Balu;

G1: for i in 0 to 0 generate

	Inverter : OnesComplement
port map( i_A => signal_B,
	o_F => signal_Binv);
	
	AddSubSelectOne : TwoToOneMuxNBit
	port map( i_X => nAdd_Sub,
		i_Y => signal_B,
		i_Z => signal_Binv,
		o_RES => AddSubSelectOutput);

	FullAdderOne : FullAdderNBit
	port map( i_A => signal_A,
		i_B => AddSubSelectOutput,
		i_Carin => nAdd_Sub,
		o_C => SumDifferenceOutput,
		o_Carout => AdderCarryOutput);

		
end generate;

o_Falu <= SumDifferenceOutput;
o_carOutalu <= AdderCarryOutput;

end structure;
