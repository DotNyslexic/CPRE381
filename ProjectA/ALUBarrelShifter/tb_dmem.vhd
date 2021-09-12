library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_dmem is

generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10;
		gCLK_HPER   : time := 50 ns
	);

end tb_dmem;

architecture behavior of tb_dmem is

constant cCLK_PER  : time := gCLK_HPER * 2;

component mem

port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;

signal s_data : std_logic_vector((DATA_WIDTH - 1) downto 0);
signal s_addr : std_logic_vector((ADDR_WIDTH - 1) downto 0);
signal s_clk : std_logic;
signal s_we : std_logic;
signal s_q : std_logic_vector((DATA_WIDTH - 1) downto 0);
signal DATA_STORE : std_logic_vector((DATA_WIDTH - 1) downto 0);

begin 

dmem : mem
port map(clk => s_clk,
	addr => s_addr,
	data => s_data,
	we => s_we,
	q => s_q);


p_clk: process
  begin
    s_clk <= '0';
    wait for gCLK_HPER;
    s_clk <= '1';
    wait for gCLK_HPER;
  end process;

p_tb: process
  begin
	
--low
s_we <= '0';
wait for gCLK_HPER;

--high
s_addr <= "0000000000";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000001";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000010";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000011";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000100";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000101";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000110";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000111";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000001000";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000001001";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0000000000";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000000";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000001";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000001";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000010";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000010";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000011";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000011";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000100";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000100";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000101";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000101";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000110";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000110";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000000111";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100000111";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000001000";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100001000";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_we <= '0';
s_addr <= "0000001001";
wait for gCLK_HPER;

--low
DATA_STORE <= s_q;
wait for gCLK_HPER;

--high
s_addr <= "0100001001";
s_data <= DATA_STORE;
s_we <= '1';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000000";
s_we <= '0';
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000001";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000010";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000011";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000100";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000101";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000110";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100000111";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100001000";
wait for gCLK_HPER;

--low
wait for gCLK_HPER;

--high
s_addr <= "0100001001";
wait for gCLK_HPER;



wait;
end process;

end behavior;

