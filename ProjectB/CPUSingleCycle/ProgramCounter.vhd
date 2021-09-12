library IEEE;
use IEEE.std_logic_1164.all;

entity ProgramCounter is
generic(N: integer := 32);
	port(i_CLK		: in std_logic;
             i_Reset		: in std_logic;
             i_PCInput   	: in std_logic_vector(N-1 downto 0);
	         o_PCOutput   	: out std_logic_vector(N-1 downto 0);
             o_PCPlusFour   	: out std_logic_vector(N-1 downto 0));
end ProgramCounter;

architecture structure of ProgramCounter is

component NBitRegisterPC
	port(i_Clock  		: in std_logic;
             i_WriteEn      	: in std_logic;
             i_Reset        	: in std_logic;
             i_Data             : in std_logic_vector(N-1 downto 0);
             o_Output       	: out std_logic_vector(N-1 downto 0));
end component;

component AdderSubtractorALU
	port(i_Aalu  		:  in std_logic_vector(N-1 downto 0);
	     i_Balu 		:  in std_logic_vector(N-1 downto 0);
	     nAdd_Sub 		:  in std_logic;
	     o_Falu 		:  out std_logic_vector(N-1 downto 0);
	     o_carOutalu 	:  out std_logic);
end component;

signal PCregister : std_logic_vector(N-1 downto 0);

begin

RegisterFile : NBitRegisterPC
port map(i_Clock => i_CLK,
         i_WriteEn => '1',
         i_Reset => i_Reset, 
         i_Data => i_PCInput,
         o_Output => PCregister);

o_PCOutput <= PCregister;

Adder : AdderSubtractorALU
port map(i_Aalu => PCregister,
	 i_Balu => "00000000000000000000000000000100", -- hard coded to 4
	 nAdd_Sub => '0',
	 o_Falu => o_PCPlusFour);

end structure;