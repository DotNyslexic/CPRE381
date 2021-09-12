library IEEE;
use IEEE.std_logic_1164.all;

entity ThirtyTwoBitALU is

generic(N : integer := 32);

port (i_A, i_B : in std_logic_vector(N-1 downto 0);
	i_AddSubMaster : in std_logic;
	i_OpControl : in std_logic_vector(2 downto 0);
	o_Zero : out std_logic;
	o_Overflow : out std_logic;
	o_Cout : out std_logic;
	o_BiggerALU : out std_logic_vector(N-1 downto 0));

end ThirtyTwoBitALU;


architecture structure of ThirtyTwoBitALU is


component oneBitALU

port (i_A : in std_logic;
	i_B : in std_logic;
	i_LessThan : in std_logic;
	i_AddSub : in std_logic;
	i_BInvert : in std_logic;
	c_out : out std_logic;
	i_OpSelect : in std_logic_vector(2 downto 0);
	o_Set : out std_logic;
	o_ALU : out std_logic);

end component;


component ThirtyTwoInputOr

port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31 : in std_logic;
	output : out std_logic);

end component;


component xorGateTwo

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);

end component;

component orTwo

port (i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);

end component;

component invg
port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

signal s_SetLessThan : std_logic;
signal s_Carry : std_logic_vector(N downto 0);
signal s_Set : std_logic_vector(N-1 downto 0);
signal s_ALUOutput : std_logic_vector(N-1 downto 0);
signal s_Overflow : std_logic;
signal s_SetThirtyOne : std_logic;
signal s_Zero: std_logic;

begin

s_Carry(0) <= i_AddSubMaster;

GenerateFirstUnit: for i in 0 to 0 generate

	GenerateAluLogic: oneBitAlu
	port map(i_A => i_A(i),
		i_B => i_B(i),
		i_LessThan => s_SetLessThan,
		i_AddSub => s_Carry(i),
		i_BInvert => i_AddSubMaster,
		i_OpSelect => i_OpControl,
		c_out => s_Carry(i+1),
		o_Set => s_Set(i),
		o_ALU => s_ALUOutput(i));

end generate;

GenerateRestOfUnits: for i in 1 to N-1 generate


	GenerateAluLogic: oneBitAlu
	port map(i_A => i_A(i),
		i_B => i_B(i),
		i_LessThan => '0',
		i_AddSub => s_Carry(i), -- i_AddSub = i_CarryIn
		i_BInvert => i_AddSubMaster,
		i_OpSelect => i_OpControl,
		c_out => s_Carry(i+1),
		o_Set => s_Set(i),
		o_ALU => s_ALUOutput(i));

end generate;

s_SetThirtyOne <= s_Set(31);
o_BiggerALU(N-1 downto 0) <= s_ALUOutput(N-1 downto 0);

GenerateZeroOutput: for i in 0 to 0 generate
	
	ALUOutputsToOr: ThirtyTwoInputOr
	port map(i0 => s_ALUOutput(i),
	i1 => s_ALUOutput(i + 1),
	i2 => s_ALUOutput(i + 2),
	i3 => s_ALUOutput(i + 3),
	i4 => s_ALUOutput(i + 4),
	i5 => s_ALUOutput(i + 5),
	i6 => s_ALUOutput(i + 6),
	i7 => s_ALUOutput(i + 7),
	i8 => s_ALUOutput(i + 8),
	i9 => s_ALUOutput(i + 9),
	i10 => s_ALUOutput(i + 10),
	i11 => s_ALUOutput(i + 11),
	i12 => s_ALUOutput(i + 12),
	i13 => s_ALUOutput(i + 13),
	i14 => s_ALUOutput(i + 14),
	i15 => s_ALUOutput(i + 15),
	i16 => s_ALUOutput(i + 16),
	i17 => s_ALUOutput(i + 17),
	i18 => s_ALUOutput(i + 18),
	i19 => s_ALUOutput(i + 19),
	i20 => s_ALUOutput(i + 20),
	i21 => s_ALUOutput(i + 21),
	i22 => s_ALUOutput(i + 22),
	i23 => s_ALUOutput(i + 23),
	i24 => s_ALUOutput(i + 24),
	i25 => s_ALUOutput(i + 25),
	i26 => s_ALUOutput(i + 26),
	i27 => s_ALUOutput(i + 27),
	i28 => s_ALUOutput(i + 28),
	i29 => s_ALUOutput(i + 29),
	i30 => s_ALUOutput(i + 30),
	i31 => s_ALUOutput(i + 31),
	output => s_Zero);

	InvertZeroOutput: invg
	port map(i_A => s_Zero,
		o_F => o_Zero);

end generate;
		

GenerateOverflowOutput: for i in 0 to 0 generate

	ALUOutputOverflow: xorGateTwo
	port map(i_A => s_Carry(i + 31),
		i_B => s_Carry(i + 32),
		o_F => s_Overflow);

end generate;

GenerateSetLessThanLogic: for i in 0 to 0 generate

	OrLogicSetLessThan: orTwo
	port map(i_A => s_Overflow,
		i_B => s_SetThirtyOne,
		o_F => s_SetLessThan);
end generate;

o_Overflow <= s_Overflow;
o_Cout <= s_Carry(32);

end structure;
