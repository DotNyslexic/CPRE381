library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ThirtyTwoBitDecoder is
 
end tb_ThirtyTwoBitDecoder;

architecture behavior of tb_ThirtyTwoBitDecoder is
  
component ThirtyTwoBitDecoder
port(i_input   :  in std_logic_vector(5 downto 0);
	o_output   :   out std_logic_vector(31 downto 0));
end component;

signal s_input   :   std_logic_vector(5 downto 0);
signal s_output   :   std_logic_vector(31 downto 0);
  
begin

  DUT: ThirtyTwoBitDecoder 
  port map(i_input => s_input,
	o_output => s_output);
 
  process
  begin

    s_input <= "000001";
    wait for 100 ns;

    s_input <= "000011";
    wait for 100 ns;

     s_input <= "001111";
    wait for 100 ns;

     s_input <= "100000";
    wait for 100 ns;

     s_input <= "100011";
    wait for 100 ns;

     s_input <= "110010";
    wait for 100 ns;

     s_input <= "111110";
    wait for 100 ns;

     s_input <= "000010";
    wait for 100 ns;

  end process;
  
end behavior;