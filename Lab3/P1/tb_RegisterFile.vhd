library IEEE;
use IEEE.std_logic_1164.all;

entity tb_RegisterFile is

generic(N: integer := 32;
gCLK_HPER   : time := 50 ns);

end tb_RegisterFile;

architecture behavior of tb_RegisterFile is

constant cCLK_PER  : time := gCLK_HPER * 2;

component RegisterFile 
port(i_WriteSignal   : in std_logic_vector(4 downto 0);
		i_InputData   : in std_logic_vector(N-1 downto 0);
		i_CLK   : in std_logic;
		i_MasterWriteEn   : in std_logic;
		i_MasterRes   : in std_logic_vector(N-1 downto 0);
		i_ReadRS   : in std_logic_vector(4 downto 0);
		i_ReadRT   : in std_logic_vector(4 downto 0);
		o_OutputRS   : out std_logic_vector(N-1 downto 0);
		o_OutputRT   : out std_logic_vector(N-1 downto 0));
end component;

signal s_ReadRS, s_ReadRT : std_logic_vector(4 downto 0);
signal s_WriteSignal : std_logic_vector(4 downto 0);
signal s_CLK, s_MasterWriteEn : std_logic;
signal s_MasterRes, s_OutputRS, s_OutputRT, s_InputData : std_logic_vector(N-1 downto 0);

begin



DUT: RegisterFile
port map( i_InputData => s_InputData,
	i_WriteSignal => s_WriteSignal,
	i_CLK => s_CLK,
	i_MasterWriteEn => s_MasterWriteEn,
	i_MasterRes => s_MasterRes,
	i_ReadRS => s_ReadRS,
	i_ReadRT => s_ReadRT,
	o_OutputRS => s_OutputRS,
	o_OutputRT => s_OutputRT);

P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

P_VALUES: process
begin

s_InputData <= "11100110110011001101110110000101";
s_WriteSignal <= "00001";
s_MasterWriteEn <= '1';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "00000";
s_ReadRT <= "00000";
wait for gCLK_HPER;

s_InputData <= "11101110011001101011100011011000";
s_WriteSignal <= "10000";
s_MasterWriteEn <= '1';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "00001";
s_ReadRT <= "00000";
wait for gCLK_HPER;

s_InputData <= "10101110010000001000100110010101";
s_WriteSignal <= "00100";
s_MasterWriteEn <= '0';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "10000";
s_ReadRT <= "00001";
wait for gCLK_HPER;

s_InputData <= "10010000101001000011110101110101";
s_WriteSignal <= "00000";
s_MasterWriteEn <= '1';
s_MasterRes <= "00000000000000010000000000000001";
s_ReadRS <= "00100";
s_ReadRT <= "10000";
wait for gCLK_HPER;

s_InputData <= "00111101100011000011010110110010";
s_WriteSignal <= "10000";
s_MasterWriteEn <= '1';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "00000";
s_ReadRT <= "00100";
wait for gCLK_HPER;

s_InputData <= "10100011001011011110011110001011";
s_WriteSignal <= "01100";
s_MasterWriteEn <= '1';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "10000";
s_ReadRT <= "00000";
wait for gCLK_HPER;

wait for gCLK_HPER;

s_InputData <= "10100011001011011110011110001011";
s_WriteSignal <= "10100";
s_MasterWriteEn <= '0';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "00000";
s_ReadRT <= "00000";
wait for gCLK_HPER;

s_InputData <= "10100011001011011110011110001011";
s_WriteSignal <= "00000";
s_MasterWriteEn <= '0';
s_MasterRes <= "00000000000000000000000000000001";
s_ReadRS <= "10100";
s_ReadRT <= "00000";
wait for gCLK_HPER;

wait;
end process;

end behavior;