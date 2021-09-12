library IEEE;
use IEEE.std_logic_1164.all;


entity Einstein is

  port(iCLK             : in std_logic;
       im 		            : in integer;
       oE 		            : out integer);

end Einstein;

architecture structure of Einstein is
  
  component Multiplier
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;


  constant c : integer := 9487;

  signal mc : integer;

begin

g_Mult1: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => im,
             iB               => c,
             oC               => mc);

g_Mult2: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => mc,
             iB               => c,
             oC               => oE);

end structure;