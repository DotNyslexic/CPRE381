library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FirstMIPSApp is

generic(N : integer := 32;
        gCLK_HPER   : time := 50 ns);

end tb_FirstMIPSApp;

architecture behavior of tb_FirstMIPSApp is

constant cCLK_PER  : time := gCLK_HPER * 2;

component firstMIPSApp
port(i_MIPSCLK   : in std_logic;
	i_MIPSReadRS, i_MIPSReadRT, i_MIPSWriteAddress   : in std_logic_vector(4 downto 0);
	i_MIPSWriteEnable, i_ALUSRC, i_MIPSnAddSub  : in std_logic;
	i_MIPSRes : in std_logic_vector(31 downto 0);
	i_MIPSImmediate   : in std_logic_vector(31 downto 0);
	o_MIPSOutputRS,o_MIPSOutputRT   : out std_logic_vector(31 downto 0));
end component;

signal s_MIPSCLK, s_MIPSWriteEnable, s_ALUsrc, s_MIPSnAddSub : std_logic;
signal s_MIPSReadRS, s_MIPSReadRT, s_MIPSWriteAddress : std_logic_vector(4 downto 0);
signal s_MIPSRes : std_logic_vector(31 downto 0);
signal s_MIPSInputData, s_MIPSImmediate : std_logic_vector(31 downto 0);
signal s_OutputRS, s_OutputRT : std_logic_vector(31 downto 0);

begin

DUT : FirstMIPSApp
port map(i_MIPSCLK => s_MIPSCLK,
	i_MIPSReadRS => s_MIPSReadRS,
	i_MIPSReadRT => s_MIPSReadRT,
	i_MIPSWriteAddress => s_MIPSWriteAddress,
	i_MIPSWriteEnable => s_MIPSWriteEnable,
	i_ALUSRC => s_ALUsrc,
	i_MIPSnAddSub => s_MIPSnAddSub,
	i_MIPSRes => s_MIPSRes,
	i_MIPSImmediate => s_MIPSImmediate,
	o_MIPSOutputRS => s_OutputRS,
	o_MIPSOutputRT => s_OutputRT);

P_CLK: process
  begin
    s_MIPSCLK <= '0';
    wait for gCLK_HPER;
    s_MIPSCLK <= '1';
    wait for gCLK_HPER;
  end process;

S_VALUES: process
begin



wait for gCLK_HPER;

--load 1 into $1
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000001";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

----load 2 into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000010";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

----load 3 into $3
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000011";
s_MIPSWriteAddress <= "00011";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

----load 4 into $4
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000100";
s_MIPSWriteAddress <= "00100";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

----load 5 into $5
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000101";
s_MIPSWriteAddress <= "00101";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

----load 6 into $6
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000110";
s_MIPSWriteAddress <= "00110";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--load 7 into $7
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000111";
s_MIPSWriteAddress <= "00111";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--load 8 into $8
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000001000";
s_MIPSWriteAddress <= "01000";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--load 9 into $9
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000001001";
s_MIPSWriteAddress <= "01001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--load 10 into $10
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000001010";
s_MIPSWriteAddress <= "01010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$11 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "01011";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$12 = $11 - $3
s_ALUsrc <= '0';
s_MIPSnAddSub <= '1';
s_MIPSReadRS <= "01011";
s_MIPSReadRT <= "00011";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "01100";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$13 = $12 + $4
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01100";
s_MIPSReadRT <= "00100";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "01101";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$14 = $13 - $5
s_ALUsrc <= '0';
s_MIPSnAddSub <= '1';
s_MIPSReadRS <= "01101";
s_MIPSReadRT <= "00101";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "01110";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$15 = $14 + $6
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01110";
s_MIPSReadRT <= "00110";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "01111";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$16 = $15 - $7
s_ALUsrc <= '0';
s_MIPSnAddSub <= '1';
s_MIPSReadRS <= "01111";
s_MIPSReadRT <= "00111";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "10000";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$17 = $16 + $8
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "10000";
s_MIPSReadRT <= "01000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "10001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$18 = $17 - $9
s_ALUsrc <= '0';
s_MIPSnAddSub <= '1';
s_MIPSReadRS <= "10001";
s_MIPSReadRT <= "01001";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "10010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$19 = $18 + $10
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "10010";
s_MIPSReadRT <= "01010";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "10011";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--load 35 into $20
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000100011";
s_MIPSWriteAddress <= "10100";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--$21 = $19 + $20
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "10011";
s_MIPSReadRT <= "10100";
s_MIPSImmediate <= "00000000000000000000000000100011";
s_MIPSWriteAddress <= "10101";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $1 and $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $11
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01011";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $11 and $3
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01011";
s_MIPSReadRT <= "00011";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $12
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01100";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $12 and $4
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01100";
s_MIPSReadRT <= "00100";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $13
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01101";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $13 and $5
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01101";
s_MIPSReadRT <= "00101";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $14
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01110";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $14 and $6
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01110";
s_MIPSReadRT <= "00110";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $15
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "01111";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $20
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "10100";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--Read $21
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "10101";
s_MIPSReadRT <= "00000";
s_MIPSImmediate <= "00000000000000000000000000000000";
s_MIPSWriteAddress <= "00000";
s_MIPSWriteEnable <= '0';
s_MIPSRes <= "00000000000000000000000000000001";

wait for gCLK_HPER;

--low
wait for gCLK_HPER;

wait;
end process;
end behavior;