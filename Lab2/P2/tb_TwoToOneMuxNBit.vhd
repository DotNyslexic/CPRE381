library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_TwoToOneMuxNBit is
generic(N : integer := 32);
end tb_TwoToOneMuxNBit;

architecture behavior of tb_TwoToOneMuxNBit is

-- Declare the component we are going to instantiate
component TwoToOneMuxNBit is
  port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));
end component;

component TwoToOneMuxNBitDataflow
  port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));
end component;

-- Signals to connect to the andg2 module
signal s_X : std_logic;
signal s_Y, s_Z, s_RESst, s_RESda  : std_logic_vector(N-1 downto 0);

begin

DUT: TwoToOneMuxNBit 
  port map(i_X  => s_X,
	   i_Y => s_Y,
	   i_Z => s_Z,
  	        o_RES  => s_RESst);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_X <= '0';
    s_Y <= "00100001011001111000010101101001";
    s_Z <= "11111111000111010111111001001111";

    wait for 100 ns;

    s_X <= '1';
    s_Y <= "00100001011001111000010101101001";
    s_Z <= "11111111000111010111111001001111";

    wait for 100 ns;

    s_X <= '1';
    s_Y <= "11111011001010100111011100111001";
    s_Z <= "00000001110010001001100010111101";

    wait for 100 ns;

    s_X <= '0';
    s_Y <= "11111011001010100111011100111001";
    s_Z <= "00000001110010001001100010111101";

    wait for 100 ns;


  end process;
  
DUTTWO: TwoToOneMuxNBitDataflow
  port map(i_X  => s_X,
	   i_Y => s_Y,
	   i_Z => s_Z,
  	        o_RES  => s_RESda);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_X <= '0';
    s_Y <= "00100001011001111000010101101001";
    s_Z <= "11111111000111010111111001001111";

    wait for 100 ns;

    s_X <= '1';
    s_Y <= "00100001011001111000010101101001";
    s_Z <= "11111111000111010111111001001111";

    wait for 100 ns;

    s_X <= '1';
    s_Y <= "11111011001010100111011100111001";
    s_Z <= "00000001110010001001100010111101";

    wait for 100 ns;

    s_X <= '0';
    s_Y <= "11111011001010100111011100111001";
    s_Z <= "00000001110010001001100010111101";

    wait for 100 ns;


  end process;
end behavior;