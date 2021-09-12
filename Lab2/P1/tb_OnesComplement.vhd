library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_OnesComplement is
generic(N : integer := 32);
end tb_OnesComplement;

architecture behavior of tb_OnesComplement is

-- Declare the component we are going to instantiate
component OnesComplement
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component OnesComplementDataflow
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end component;

-- Signals to connect to the andg2 module
signal s_A, s_F, s_Fd  : std_logic_vector(N-1 downto 0);

begin

DUT: OnesComplement 
  port map(i_A  => s_A,
  	        o_F  => s_F);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= "01000110011101100010011001000110";

    wait for 100 ns;

    s_A <= "01100110011001100110011001100110";

    wait for 100 ns;

    s_A <= "10000000011111111100000000110010";

    wait for 100 ns;

    s_A <= "10101010101010101011110000111100";

    wait for 100 ns;


  end process;
  
DUTTWO: OnesComplementDataflow
  port map(i_A  => s_A,
  	        o_F  => s_Fd);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= "01000110011101100010011001000110";

    wait for 100 ns;

    s_A <= "01100110011001100110011001100110";

    wait for 100 ns;

    s_A <= "10000000011111111100000000110010";

    wait for 100 ns;

    s_A <= "10101010101010101011110000111100";

    wait for 100 ns;


  end process;
end behavior;