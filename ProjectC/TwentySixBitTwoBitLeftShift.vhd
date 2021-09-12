library IEEE;
use IEEE.std_logic_1164.all;

entity TwentySixBitTwoBitLeftShift is

port (i_In : in std_logic_vector(25 downto 0);
	o_Out : out std_logic_vector(27 downto 0));

end TwentySixBitTwoBitLeftShift;

architecture bhv of TwentySixBitTwoBitLeftShift is

signal s_firstTwentySix : std_logic_vector(25 downto 0);

begin

s_firstTwentySix <= i_In(25 downto 0);
o_Out <= s_firstTwentySix(25 DOWNTO 0) & "00";

end bhv;