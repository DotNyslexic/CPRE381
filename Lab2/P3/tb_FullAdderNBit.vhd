library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- This is an empty entity so we don't need to declare ports
entity tb_FullAdderNBit is
generic(N : integer := 32);
end tb_FullAdderNBit;

architecture behavior of tb_FullAdderNBit is

-- Declare the component we are going to instantiate
component FullAdderNBit
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : std_logic_vector(N-1 downto 0);
       i_Carin  : in std_logic;
       o_C  : out std_logic_vector(N-1 downto 0);
       o_Carout  : out std_logic);
end component;

component FullAdderNBitDataflow
port(i_X   :   in signed(N-1 downto 0);
     i_Y   :   in signed(N-1 downto 0);
     o_Z   :   out signed(N-1 downto 0));
end component;


signal s_A, s_B, s_F  : std_logic_vector(N-1 downto 0);
signal s_Carin, s_Carout : std_logic;
signal s_X, s_Y, s_Z   :  signed(N-1 downto 0);

begin

DUT: FullAdderNBit 
  port map(i_A  => s_A,
  	        i_B  => s_B,
  	        o_C  => s_F,
		i_Carin => s_Carin,
		o_Carout => s_Carout);

  process
  begin

    s_A <= "01100111101111111100100110101001";
    s_B <= "00100001011111000011111111101100";
    s_Carin <= '1';
    wait for 100 ns;

    s_A <= "01000001110001011111111001010110";
    s_B <= "01011010101000110010111010000000";
    s_Carin <= '0';
    wait for 100 ns;

    s_A <= "10000011110001000010001010110101";
    s_B <= "00110101010101010011101100001111";
    s_Carin <= '0';
    wait for 100 ns;

    s_A <= "10000011110001000010001010110101";
    s_B <= "00110101010101010011101100001111";
    s_Carin <= '1';
    wait for 100 ns;

  end process;

DUTTWO: FullAdderNBitDataflow 
  port map(i_X  => s_X,
  	        i_Y  => s_Y,
  	        o_Z  => s_Z);

  process
  begin

    s_X <= "01100111101111111100100110101001";
    s_Y <= "00100001011111000011111111101101";
    wait for 100 ns;

    s_X <= "01000001110001011111111001010110";
    s_Y <= "01011010101000110010111010000000";
    wait for 100 ns;

    s_X <= "10000011110001000010001010110101";
    s_Y <= "00110101010101010011101100001111";
    wait for 100 ns;

    s_X <= "10000011110001000010001010110110";
    s_Y <= "00110101010101010011101100001111";
    wait for 100 ns;

  end process;
  
  
end behavior;