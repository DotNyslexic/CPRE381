library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_AdderSubtractorALU is
generic(N : integer := 32);
end tb_AdderSubtractorALU;

architecture behavior of tb_AdderSubtractorALU is

component AdderSubtractorALU
port( i_Aalu  :  in std_logic_vector(N-1 downto 0);
	i_Balu :  in std_logic_vector(N-1 downto 0);
	nAdd_Sub :  in std_logic;
	o_Falu :  out std_logic_vector(N-1 downto 0);
	o_carOutalu : out std_logic);
end component;


signal s_A, s_B, s_F  : std_logic_vector(N-1 downto 0);
signal s_carOutalu, s_nAdd_Sub : std_logic;

begin

DUT: AdderSubtractorALU 
  port map(i_Aalu  => s_A,
  	        i_Balu  => s_B,
		nAdd_Sub => s_nAdd_Sub,
  	        o_Falu  => s_F,
		o_carOutAlu => s_carOutalu);

  process
  begin

    s_A <= "00011001001011000001001101011010";
    s_B <= "00000100100100101100111001010000";
	s_nAdd_Sub <= '0';
    wait for 100 ns;

    s_A <= "00011001001011000001001101011010";
    s_B <= "00000100100100101100111001010000";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

    s_A <= "00000000000000000000000000000000";
    s_B <= "00000000000000000000000000000000";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

    s_A <= "00000000000000000000000000000000";
    s_B <= "00000000000000000000000000000000";
	s_nAdd_Sub <= '0';
    wait for 100 ns;

    s_A <= "00000000000000000000000001011001";
    s_B <= "00000000000000000000000011001010";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

    s_A <= "00000000000000000000000011001010";
    s_B <= "00000000000000000000000001011001";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

    s_A <= "00000000000000000000000111110100";
    s_B <= "11111111111111111111110110101000";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

    s_A <= "00000000000000000000000111110100";
    s_B <= "00000000000000000000001001011000";
	s_nAdd_Sub <= '1';
    wait for 100 ns;

  end process;

end behavior;