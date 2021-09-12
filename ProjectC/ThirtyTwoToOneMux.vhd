library IEEE;
use IEEE.std_logic_1164.all;

entity ThirtyTwoToOneMux is

  port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31   :   in std_logic_vector(31 downto 0);
	SEL   :   in std_logic_vector(4 downto 0);
o_selection   :   out std_logic_vector(31 downto 0));

end ThirtyTwoToOneMux;

architecture dataflow of ThirtyTwoToOneMux is

begin
  
with SEL select
	o_selection <=  i0 when "00000",
			i1 when "00001",
			i2 when "00010",
			i3 when "00011",
			i4 when "00100",
			i5 when "00101",
			i6 when "00110",
			i7 when "00111",
			i8 when "01000",
			i9 when "01001",
			i10 when "01010",
			i11 when "01011",
			i12 when "01100",
			i13 when "01101",
			i14 when "01110",
			i15 when "01111",
			i16 when "10000",
			i17 when "10001",
			i18 when "10010",
			i19 when "10011",
			i20 when "10100",
			i21 when "10101",
			i22 when "10110",
			i23 when "10111",
			i24 when "11000",
			i25 when "11001",
			i26 when "11010",
			i27 when "11011",
			i28 when "11100",
			i29 when "11101",
                        i30 when "11110",
			i31 when "11111",
			"00000000000000000000000000000000" when others;
 
end dataflow;