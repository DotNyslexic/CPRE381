library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_barrelShifter is

end tb_barrelShifter;

architecture Behavioral of tb_barrelShifter is
    component barrelShifter is
    Port ( i_sign_extend : in  STD_LOGIC;
           i_left_shift  : in  STD_LOGIC;
           i_arithmetic  : in  STD_LOGIC;
           i_shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0);           
           i_data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
           o_data_out    : out STD_LOGIC_VECTOR (31 downto 0));
    end component;  
  
    signal s_clk         : STD_LOGIC    := '0';
    signal s_sign_extend : STD_LOGIC    := '0';
    signal s_left_shift  : STD_LOGIC    := '0';
    signal s_arithmetic  : STD_LOGIC	:= '0';
    signal s_shift_amt   : STD_LOGIC_VECTOR (4 downto 0)  := (others => '0');           
    signal s_data_in     : STD_LOGIC_VECTOR (31 downto 0) := x"FF0000FF"; 
    signal s_data_out    : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

process
    begin
        s_clk <= not s_clk;
        wait for 25 ns;
    end process;
    
process(s_clk)
    begin
        if rising_edge(s_clk) then
            if s_shift_amt = "11111" and s_left_shift = '1' then
                s_sign_extend <= not s_sign_extend;
            end if;

            if s_shift_amt = "11111" and s_left_shift = '0' and s_arithmetic = '0' then
		s_arithmetic <= not s_arithmetic;
	    end if;
            
            if s_shift_amt = "11111" then
                s_left_shift <= not s_left_shift; 
            end if;

            
            s_shift_amt <= std_logic_vector(unsigned(s_shift_amt)+1);
        end if;
    end process;
    
shifterTest: barrelShifter port map (
    i_sign_extend  => s_sign_extend,
    i_left_shift   => s_left_shift,
    i_arithmetic   => s_arithmetic,
    i_shift_amt    => s_shift_amt,
    i_data_in      => s_data_in,
    o_data_out     => s_data_out);

end Behavioral;