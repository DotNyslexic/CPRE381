library IEEE;
use IEEE.std_logic_1164.all;

entity tb_oneBitALU is

end tb_oneBitALU;

architecture behavior of tb_oneBitALU is

component oneBitALU
port (i_A : in std_logic;
	i_B : in std_logic;
	i_AddSub : in std_logic;
	c_out : out std_logic;
	i_OpSelect : in std_logic_vector(2 downto 0);
	o_ALU : out std_logic);
end component;

signal s_A, s_B, s_AddSub, s_Cout, s_oAlu : std_logic;
signal s_OpSelect : std_logic_vector(2 downto 0);

begin

TestOneBitALU: oneBitAlu
	port map(i_A => s_A,
		i_B => s_B,
		i_AddSub => s_AddSub,
		c_Out => s_Cout,
		i_OpSelect => s_OpSelect,
		o_ALU => s_oAlu);

process
begin

-- Test 0 + 1
s_A <= '0';
s_B <= '1';
s_AddSub <= '0';
s_OpSelect <= "000";
wait for 100 ns;

-- Test 0 - 1
s_A <= '0';
s_B <= '1';
s_AddSub <= '1';
s_OpSelect <= "000";
wait for 100 ns;

-- Test 0 < 1
s_A <= '0';
s_B <= '1';
s_OpSelect <= "001";
wait for 100 ns;

-- Test 1 < 0
s_A <= '1';
s_B <= '0';
s_OpSelect <= "001";
wait for 100 ns;

-- Test 0 & 1
s_A <= '1';
s_B <= '0';
s_OpSelect <= "010";
wait for 100 ns;

-- Test 1 & 1
s_A <= '1';
s_B <= '1';
s_OpSelect <= "010";
wait for 100 ns;

-- Test 0 | 1
s_A <= '0';
s_B <= '1';
s_OpSelect <= "011";
wait for 100 ns;

-- Test 0 | 0
s_A <= '0';
s_B <= '0';
s_OpSelect <= "011";
wait for 100 ns;

-- Test 1 xor 0
s_A <= '1';
s_B <= '0';
s_OpSelect <= "100";
wait for 100 ns;

-- Test 1 xor 1
s_A <= '1';
s_B <= '1';
s_OpSelect <= "100";
wait for 100 ns;

-- Test 0 nand 1
s_A <= '0';
s_B <= '1';
s_OpSelect <= "101";
wait for 100 ns;

-- Test 1 nand 1
s_A <= '1';
s_B <= '1';
s_OpSelect <= "101";
wait for 100 ns;

-- Test 0 nor 1
s_A <= '0';
s_B <= '1';
s_OpSelect <= "110";
wait for 100 ns;

-- Test 0 nor 0
s_A <= '0';
s_B <= '0';
s_OpSelect <= "110";
wait for 100 ns;


wait;
end process;

end behavior;