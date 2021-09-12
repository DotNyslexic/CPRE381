library IEEE;
use IEEE.std_logic_1164.all;

entity RegisterFile is

generic(N: integer := 32);
	port(i_WriteSignal   : in std_logic_vector(4 downto 0);
		i_InputData   : in std_logic_vector(N-1 downto 0);
		i_CLK   : in std_logic;
		i_MasterWriteEn   : in std_logic;
		i_MasterRes   : in std_logic_vector(N-1 downto 0);
		i_ReadRS   : in std_logic_vector(4 downto 0);
		i_ReadRT   : in std_logic_vector(4 downto 0);
		o_OutputRS   : out std_logic_vector(N-1 downto 0);
		o_OutputRT   : out std_logic_vector(N-1 downto 0));

end RegisterFile;

architecture structure of RegisterFile is

component ThirtyTwoToOneMux

port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31   :   in std_logic_vector(31 downto 0);
	SEL   :   in std_logic_vector(4 downto 0);
o_selection   :   out std_logic_vector(31 downto 0));

end component;


component ThirtyTwoBitDecoder

port(i_input   :  in std_logic_vector(5 downto 0);
	o_output   :   out std_logic_vector(31 downto 0));
end component;


component NBitRegister

port(i_Clock        : in std_logic;     -- Clock input
       i_WriteEn         : in std_logic;     -- Write enable input
       i_Reset        : in std_logic;     -- Reset input
       i_Data          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Output          : out std_logic_vector(N-1 downto 0));   -- Data value output

end component;

signal inputSignals   : std_logic_vector(5 downto 0);
signal decoderSelection   : std_logic_vector(N-1 downto 0);
type RegisterOutputs is array(0 to N-1) of std_logic_vector(N-1 downto 0);
    signal RegisterToMux : RegisterOutputs;
signal forceZero   : std_logic;


begin

inputSignals(0) <= i_MasterWriteEn;
inputSignals(1) <= i_WriteSignal(0);
inputSignals(2) <= i_WriteSignal(1);
inputSignals(3) <= i_WriteSignal(2);
inputSignals(4) <= i_WriteSignal(3);
inputSignals(5) <= i_WriteSignal(4);

G1: for i in 0 to 0 generate
	WriteSelect : ThirtyTwoBitDecoder
	port map(i_input => inputSignals,
		o_output => decoderSelection);
end generate;


G2: for i in 0 to N-1 generate
	BuildRegisters : NBitRegister
	port map( i_Clock => i_CLK,
		i_WriteEn => decoderSelection(i),
		i_Reset => i_MasterRes(i),
		i_Data => i_InputData,
		o_Output => RegisterToMux(i));
end generate;


G3: for i in 0 to 0 generate
	MakeMuxRS : ThirtyTwoToOneMux
	port map(SEL => i_ReadRS,
		i0 => RegisterToMux(i),
		i1 => RegisterToMux(i+1),
		i2 => RegisterToMux(i+2),
		i3 => RegisterToMux(i+3),
		i4 => RegisterToMux(i+4),
		i5 => RegisterToMux(i+5),
		i6 => RegisterToMux(i+6),
		i7 => RegisterToMux(i+7),
		i8 => RegisterToMux(i+8),
		i9 => RegisterToMux(i+9),
		i10 => RegisterToMux(i+10),
		i11 => RegisterToMux(i+11),
		i12 => RegisterToMux(i+12),
		i13 => RegisterToMux(i+13),
		i14 => RegisterToMux(i+14),
		i15 => RegisterToMux(i+15),
		i16 => RegisterToMux(i+16),
		i17 => RegisterToMux(i+17),
		i18 => RegisterToMux(i+18),
		i19 => RegisterToMux(i+19),
		i20 => RegisterToMux(i+20),
		i21 => RegisterToMux(i+21),
		i22 => RegisterToMux(i+22),
		i23 => RegisterToMux(i+23),
		i24 => RegisterToMux(i+24),
		i25 => RegisterToMux(i+25),
		i26 => RegisterToMux(i+26),
		i27 => RegisterToMux(i+27),
		i28 => RegisterToMux(i+28),
		i29 => RegisterToMux(i+29),
		i30 => RegisterToMux(i+30),
		i31 => RegisterToMux(i+31),
	o_selection => o_OutputRS);
end generate;


G4: for i in 0 to 0 generate
	MakeMuxRT : ThirtyTwoToOneMux
	port map(SEL => i_ReadRT,
		i0 => RegisterToMux(i),
		i1 => RegisterToMux(i+1),
		i2 => RegisterToMux(i+2),
		i3 => RegisterToMux(i+3),
		i4 => RegisterToMux(i+4),
		i5 => RegisterToMux(i+5),
		i6 => RegisterToMux(i+6),
		i7 => RegisterToMux(i+7),
		i8 => RegisterToMux(i+8),
		i9 => RegisterToMux(i+9),
		i10 => RegisterToMux(i+10),
		i11 => RegisterToMux(i+11),
		i12 => RegisterToMux(i+12),
		i13 => RegisterToMux(i+13),
		i14 => RegisterToMux(i+14),
		i15 => RegisterToMux(i+15),
		i16 => RegisterToMux(i+16),
		i17 => RegisterToMux(i+17),
		i18 => RegisterToMux(i+18),
		i19 => RegisterToMux(i+19),
		i20 => RegisterToMux(i+20),
		i21 => RegisterToMux(i+21),
		i22 => RegisterToMux(i+22),
		i23 => RegisterToMux(i+23),
		i24 => RegisterToMux(i+24),
		i25 => RegisterToMux(i+25),
		i26 => RegisterToMux(i+26),
		i27 => RegisterToMux(i+27),
		i28 => RegisterToMux(i+28),
		i29 => RegisterToMux(i+29),
		i30 => RegisterToMux(i+30),
		i31 => RegisterToMux(i+31),
	o_selection => o_OutputRT);
end generate;


end structure;