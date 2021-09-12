library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ThirtyTwoToOneMux is
 
end tb_ThirtyTwoToOneMux;

architecture behavior of tb_ThirtyTwoToOneMux is
  
component ThirtyTwoToOneMux
port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31   :   in std_logic_vector(31 downto 0);
	SEL   :   in std_logic_vector(4 downto 0);
o_selection   :   out std_logic_vector(31 downto 0));
end component;

signal si0, si1, si2, si3, si4, si5, si6, si7, si8, si9, si10, si11, si12, si13, si14, si15, si16, si17, si18, si19, si20, si21, si22, si23, si24, si25, si26, si27, si28, si29, si30, si31 :   std_logic_vector(31 downto 0);
signal s_SEL   :   std_logic_vector(4 downto 0);
signal s_selection   :   std_logic_vector(31 downto 0);
  
begin

  DUT: ThirtyTwoToOneMux 
  port map(i0 => si0,
	i1 => si1,
	i2 => si2,
	i3 => si3,
	i4 => si4,
	i5 => si5,
	i6 => si6,
	i7 => si7,
	i8 => si8,
	i9 => si9,
	i10 => si10,
	i11 => si11,
	i12 => si12,
	i13 => si13,
	i14 => si14,
	i15 => si15,
	i16 => si16,
	i17 => si17,
	i18 => si18,
	i19 => si19,
	i20 => si20,
	i21 => si21,
	i22 => si22,
	i23 => si23,
	i24 => si24,
	i25 => si25,
	i26 => si26,
	i27 => si27,
	i28 => si28,
	i29 => si29,
	i30 => si30,
	i31 => si31,
	SEL => s_SEL,
	o_selection => s_selection);
 
  process
  begin

    si0 <= "01010011000101000111010111000001";
    s_SEL <= "00000";
    wait for 100 ns;

    si23 <= "00011011111001000000000000100000";
    s_SEL <= "10111";
    wait for 100 ns;

     si7 <= "01001100101110000001111010001001";
    s_SEL <= "00111";
    wait for 100 ns;

     si10 <= "10000000110000110101010010110100";
    s_SEL <= "01010";
    wait for 100 ns;

      si15 <= "11010011011101010010001101111101";
    s_SEL <= "10111";
    wait for 100 ns;

      si2 <= "00011100110010111010111111110010";
    s_SEL <= "00010";
    wait for 100 ns;

  end process;
  
end behavior;