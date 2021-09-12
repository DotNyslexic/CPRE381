library IEEE;
use IEEE.std_logic_1164.all;

entity oneBitALU is

generic(N : integer := 1);

port (i_A : in std_logic;
	i_B : in std_logic;
	i_AddSub : in std_logic;
	c_out : out std_logic;
	i_OpSelect : in std_logic_vector(2 downto 0);
	o_ALU : out std_logic);
end oneBitALU;

architecture structure of oneBitALU is

component FullAdder
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Cin  : in std_logic;
       o_Z  : out std_logic;
       o_Cout  : out std_logic);
end component;

component invg
port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

component TwoToOneMux
  port(i_X  : in std_logic;
       i_Y  : in std_logic;
       i_Z  : in std_logic;
       o_RES  : out std_logic);
end component;

component SetLessThan
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component andTwo
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component orTwo
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component xorGateTwo
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component NANDTwo
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component NORTwo
port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

component MuxEightToOne
port (i_A : in std_logic;
	i_B : in std_logic;
	i_C : in std_logic;
	i_D : in std_logic;
	i_E : in std_logic;
	i_F : in std_logic;
	i_G : in std_logic;
	i_H : in std_logic;
	i_Sel : in std_logic_vector(2 downto 0);
	o_F : out std_logic);
end component;

signal s_AddSub, s_SLT, s_AND, s_OR, s_XOR, s_NAND, s_NOR, s_AddSubInputB, s_AddSubMuxInputInv : std_logic;

begin

GenerateModules: for i in 0 to 0 generate

	AddSubLogic: FullAdder
	port map( i_X => i_A,
		i_Y => s_AddSubInputB,
		i_Cin => i_AddSub,
		o_Z => s_AddSub,
		o_Cout => C_out);

	Inverter: invg
	port map( i_A => i_B,
		o_F => s_AddSubMuxInputInv);

	SelectAddSub: TwoToOneMux
	port map( i_X => i_AddSub,
		i_Y => i_B,
		i_Z => s_AddSubMuxInputInv,
		o_RES => s_AddSubInputB);

	SLTLogic: SetLessThan
	port map(i_A => i_A,
		i_B => i_B,
		o_F => s_SLT);

	ANDlogic: andTwo
	port map(i_A => i_A,
		i_B => i_B, 
		o_F => s_AND);

	ORlogic: orTwo
	port map(i_A => i_A,
		i_B => i_B,
		o_F => s_OR);
	
	XORlogic: xorGateTwo
	port map(i_A => i_A,
		i_B => i_B,
		o_F => s_XOR);

	NANDlogic: NANDTwo
	port map(i_A => i_A,
		i_B => i_B,
		o_F => s_NAND);

	NORlogic: NORTwo
	port map(i_A => i_A,
		i_B => i_B,
		o_F => s_NOR);
	
	opSelect: MuxEightToOne
	port map(i_A => s_AddSub,
		i_B => s_SLT,
		i_C => s_AND,
		i_D => s_OR,
		i_E => s_XOR,
		i_F => s_NAND,
		i_G => s_NOR,
		i_H => '0',
		i_Sel => i_OpSelect,
		o_F => o_ALU);
end generate;

end structure;