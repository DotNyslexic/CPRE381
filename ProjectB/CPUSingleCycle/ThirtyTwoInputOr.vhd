library IEEE;
use IEEE.std_logic_1164.all;

entity ThirtyTwoInputOr is

port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31 : in std_logic;
	output : out std_logic);

end ThirtyTwoInputOr;

architecture dataflow of ThirtyTwoInputOr is

begin

output <= i0 or i1 or i2 or i3 or i4 or i5 or i6 or i7 or i8 or i9 or i10 or i11 or i12 or i13 or i14 or i15 or i16 or i17 or i18 or i19 or i20 or i21 or i22 or i23 or i24 or i25 or i26 or i27 or i28 or i29 or i30 or i31;

end dataflow;