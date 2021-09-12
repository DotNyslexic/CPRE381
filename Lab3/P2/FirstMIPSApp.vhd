library IEEE;
use IEEE.std_logic_1164.all;

entity FirstMIPSApp is

generic(N: integer := 32);
port(i_MIPSCLK   : in std_logic;
	i_MIPSReadRS, i_MIPSReadRT, i_MIPSWriteAddress   : in std_logic_vector(4 downto 0);
	i_MIPSWriteEnable, i_ALUSRC, i_MIPSnAddSub  : in std_logic;
	i_MIPSRes : in std_logic_vector(31 downto 0);
	i_MIPSImmediate   : in std_logic_vector(31 downto 0);
	o_MIPSOutputRS,o_MIPSOutputRT   : out std_logic_vector(31 downto 0));
end FirstMIPSApp;

architecture structure of FirstMIPSApp is

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

component AdderSubtractorALU
port( i_Aalu  :  in std_logic_vector(N-1 downto 0);
	i_Balu :  in std_logic_vector(N-1 downto 0);
	nAdd_Sub :  in std_logic;
	o_Falu :  out std_logic_vector(N-1 downto 0);
	o_carOutalu : out std_logic);
end component;

component ThirtyTwoBitTwoToOneMux
port(i_A, i_B   :   in std_logic_vector(31 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(31 downto 0));
end component;


signal s_OutputRS, s_OutputRT, s_ALUMUXOutput, s_RouteALUData : std_logic_vector(31 downto 0);
signal s_ALUCarryOut : std_logic;

begin



--Create register file
G1: for i in 0 to 0 generate
	BuildRegister : RegisterFile
port map( i_WriteSignal => i_MIPSWriteAddress,
	i_InputData => s_RouteALUData,
	i_CLK => i_MIPSCLK,
	i_MasterWriteEn => i_MIPSWriteEnable,
	i_MasterRes => i_MIPSRes,
	i_ReadRS => i_MIPSReadRS,
	i_ReadRT => i_MIPSReadRT,
	o_OutputRS => s_OutputRS,
	o_OutputRT => s_OutputRT);
end generate;

o_MIPSOutputRS <= s_OutputRS;
o_MIPSOutputRT <= s_OutputRT;

--Create 2:1 MUX in front of ALU
G2: for i in 0 to 0 generate
	ALUMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => s_OutputRT,
	i_B => i_MIPSImmediate,
	i_SELECT => i_ALUsrc,
	o_OUTPUT => s_ALUMUXOutput);
end generate;


--Create ALU with MUXed input
G3: for i in 0 to 0 generate
	BuildALU : AdderSubtractorALU
port map( i_Aalu => s_OutputRS,
	i_Balu => s_ALUMUXOutput,
	nAdd_Sub => i_MIPSnAddSub,
	o_Falu => s_RouteALUData,
	o_carOutalu => s_ALUCarryOut);
end generate;


end structure;