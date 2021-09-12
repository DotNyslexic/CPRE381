library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ThirtyTwoBitALU is

generic(N : integer := 32);

end tb_ThirtyTwoBitALU;

architecture behavior of tb_ThirtyTwoBitALU is

component ThirtyTwoBitALU
port (i_A, i_B : in std_logic_vector(N-1 downto 0);
	i_AddSubMaster : in std_logic;
	i_OpControl : in std_logic_vector(2 downto 0);
	o_Zero : out std_logic;
	o_Overflow : out std_logic;
	o_Cout : out std_logic;
	o_BiggerALU : out std_logic_vector(N-1 downto 0));
end component;

signal s_A, s_B, s_ALUOutput : std_logic_vector(N-1 downto 0);
signal s_AddSub, s_Zero, s_Overflow, s_Cout : std_logic;
signal s_OpControl : std_logic_vector(2 downto 0);

begin

TestBench: ThirtyTwoBitALU

	port map(i_A => s_A,
		i_B => s_B,
		i_AddSubMaster => s_AddSub,
		i_OpControl => s_OpControl,
		o_Zero => s_Zero,
		o_Overflow => s_Overflow,
		o_Cout => s_Cout,
		o_BiggerALU => s_ALUOutput);

process
begin

-- test addition
s_A <= "00000000000000000000111100001111";
s_B <= "11111111000000000000000011110000";
s_AddSub <= '0';
s_OpControl <= "000";
wait for 100 ns;

-- test addition carry
s_A <= "00000000000000000000111111111111";
s_B <= "00000000000000000000111100000000";
s_AddSub <= '0';
s_OpControl <= "000";
wait for 100 ns;


-- test subtraction
s_A <= "00000000000000000000111111111111";
s_B <= "00000000000000000000111100000000";
s_AddSub <= '1';
s_OpControl <= "000";
wait for 100 ns;

-- test subtraction where B is bigger than A
s_A <= "00000000000000000000111111111111";
s_B <= "00000000001110000000000000000000";
s_AddSub <= '1';
s_OpControl <= "000";
wait for 100 ns;

-- test set less than where A (positive) is bigger than B (positive)
s_A <= "00000000000000000000111111111111";
s_B <= "00000000000000000000000000100000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

wait for 100 ns;

-- test set less than where A (positive) is bigger than B (negative)
s_A <= "00000000000000000000111111111111";
s_B <= "10000000111111111111111111110000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

-- test set less than where A (negative) is bigger than B (negative)
s_A <= "11110000000000000000000000000000";
s_B <= "10000000111111111111111111110000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

-- test set less than where A (negative) is smaller than B (negative)
s_A <= "10000000000011111111111111110000";
s_B <= "10000000111111111111111111110000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

-- test set less than where A (negative) is smaller than B (positive)
s_A <= "10000000000011111111111111110000";
s_B <= "00001111000011110000000000000000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

-- test set less than where A (positive) is smaller than B (positive)
s_A <= "00000000000011111111000000000000";
s_B <= "00001111000011110000000000000000";
s_AddSub <= '1'; -- s_AddSub needs to be set for SLT to work properly
s_OpControl <= "001";
wait for 100 ns;

s_AddSub <= '0'; -- set s_AddSub back to 0, no longer needed for testing

-- test bitwise AND
s_A <= "00000000000011111111000000000110";
s_B <= "00001111000011110000000000000100";
s_OpControl <= "010";
wait for 100 ns;

-- test bitwise OR
s_A <= "00000000111111111000000001010110";
s_B <= "00001111000011110000000000000100";
s_OpControl <= "011";
wait for 100 ns;

-- test bitwise XOR
s_A <= "00000000111111111000000001010110";
s_B <= "00001111000011110000000000000100";
s_OpControl <= "100";
wait for 100 ns;

-- test bitwise NAND
s_A <= "11111111000000001111000010100011";
s_B <= "11111111001100011000001110001101";
s_OpControl <= "101";
wait for 100 ns;

-- test bitwise NOR
s_A <= "11111111000000001111000010100011";
s_B <= "11111111001100011000001110001101";
s_OpControl <= "110";
wait for 100 ns;

wait;

end process;
end behavior;