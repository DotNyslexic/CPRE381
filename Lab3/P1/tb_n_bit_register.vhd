library IEEE;
use IEEE.std_logic_1164.all;

entity tb_n_bit_register is
generic(N : integer := 32;
        gCLK_HPER   : time := 50 ns);
end tb_n_bit_register;

architecture behavior of tb_n_bit_register is

constant cCLK_PER  : time := gCLK_HPER * 2;

component NBitRegister
  port(i_Clock        : in std_logic;     -- Clock input
       i_WriteEn         : in std_logic;     -- Write enable input
       i_Reset        : in std_logic;     -- Reset input
       i_Data          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Output          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

signal s_Clock, s_WriteEn, s_Reset   : std_logic;
signal s_Data, s_Output   : std_logic_vector(N-1 downto 0);

begin
  
DUT: NBitRegister 
  port map(i_Clock => s_Clock,
	i_WriteEn => s_WriteEn,
	i_Reset => s_Reset,
	i_Data => s_Data,
	o_Output => s_Output);

P_CLK: process
  begin
    s_Clock <= '0';
    wait for gCLK_HPER;
    s_Clock <= '1';
    wait for gCLK_HPER;
  end process;

S_VALUES: process
begin

s_WriteEn <= '0';
s_Reset <= '1';
s_Data <= "00010111010110110111000010100110";
wait for gCLK_HPER;

s_WriteEn <= '1';
s_Reset <= '0';
s_Data <= "00010111010110110111000010100110";
wait for gCLK_HPER;

s_WriteEn <= '1';
s_Reset <= '0';
s_Data <= "00010111010110110111000010100110";
wait for gCLK_HPER;


s_WriteEn <= '0';
s_Reset <= '0';
s_Data <= "00010111010110110111000010100110";
wait for gCLK_HPER;


s_WriteEn <= '1';
s_Reset <= '0';
s_Data <= "00111111000000110000010001010000";
wait for gCLK_HPER;


s_WriteEn <= '0';
s_Reset <= '0';
s_Data <= "00111111000000110000010001010000";
wait for gCLK_HPER;


s_WriteEn <= '1';
s_Reset <= '0';
s_Data <= "00111111000000110000010001010000";
wait for gCLK_HPER;

s_WriteEn <= '1';
s_Reset <= '1';
s_Data <= "00111111000000110000010001010000";
wait for gCLK_HPER;

wait;
end process;

 
end behavior;