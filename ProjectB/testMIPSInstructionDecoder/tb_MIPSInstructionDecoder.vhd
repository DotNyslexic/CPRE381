library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MIPSInstructionDecoder is

end tb_MIPSInstructionDecoder;

architecture behavior of tb_MIPSInstructionDecoder is

component MIPSInstructionDecoder

port( i_instruction_function : in std_logic_vector(5 downto 0);
	i_instruction_opcode : in std_logic_vector(5 downto 0);
--------------------------------------------
	o_reg_Dst : out std_logic;
	o_reg_Jump : out std_logic;
	o_Branch : out std_logic;
	o_Mem_To_Reg : out std_logic;
	o_Mem_Write : out std_logic;
	o_ALU_Src : out std_logic;
	o_Reg_Write : out std_logic;
	o_LUI : out std_logic;
	o_Sign_Extend_Choice : out std_logic;
---------------------------------------------
        o_ALU_Op : out std_logic_vector(2 downto 0);
	o_ALUn_AddSub : out std_logic;
	o_Shifter_Mux_Control : out std_logic;
	o_Arithmetic : out std_logic;
	o_Sign_Extended : out std_logic;
	o_Left_Shift : out std_logic;
	o_Variable_Shift : out std_logic);

end component;

signal s_instruction_function, s_instruction_opcode : std_logic_vector(5 downto 0);
signal s_reg_Dst, s_reg_Jump, s_Branch, s_Mem_To_Reg, s_Mem_Write, s_ALU_Src, s_Reg_Write, s_LUI, s_Sign_Extend_Choice, s_ALUn_AddSub, s_Shifter_Mux_Control, s_Arithmetic, s_Sign_Extended, s_Left_Shift, s_Variable_Shift : std_logic;
signal s_ALU_Op : std_logic_vector(2 downto 0);

begin

DUT: MIPSInstructionDecoder
port map( i_instruction_function => s_instruction_function,
	i_instruction_opcode => s_instruction_opcode,
	o_reg_Dst => s_reg_Dst,
	o_reg_Jump => s_reg_Jump,
	o_Branch => s_Branch,
	o_Mem_To_Reg => s_Mem_To_Reg,
	o_Mem_Write => s_Mem_Write,
	o_ALU_Src => s_ALU_Src,
	o_Reg_Write => s_Reg_Write,
	o_LUI => s_LUI,
	o_Sign_Extend_Choice => s_Sign_Extend_Choice,
	o_ALU_Op => s_ALU_Op,
	o_ALUn_AddSub => s_ALUn_AddSub,
	o_Shifter_Mux_Control => s_Shifter_Mux_Control,
	o_Arithmetic => s_Arithmetic,
	o_Sign_Extended => s_Sign_Extended,
	o_Left_Shift => s_Left_Shift,
	o_Variable_Shift => s_Variable_Shift);

process
begin

-- ADDI
s_instruction_function <= "000000";
s_instruction_opcode <= "001000";

wait for 100 ns;

-- LUI
s_instruction_function <= "000000";
s_instruction_opcode <= "001111";

wait for 100 ns;

-- SW
s_instruction_function <= "000000";
s_instruction_opcode <= "101011";

wait for 100 ns;


-- AND
s_instruction_function <= "100100";
s_instruction_opcode <= "000000";

wait for 100 ns;


-- SUB
s_instruction_function <= "100010";
s_instruction_opcode <= "000000";

wait for 100 ns;


-- SLT
s_instruction_function <= "101010";
s_instruction_opcode <= "000000";

wait for 100 ns;


-- ADDIU
s_instruction_function <= "101010";
s_instruction_opcode <= "001001";

wait for 100 ns;


-- SRAV
s_instruction_function <= "000111";
s_instruction_opcode <= "000000";

wait for 100 ns;


-- OR
s_instruction_function <= "100101";
s_instruction_opcode <= "000000";

wait for 100 ns;

-- XOR
s_instruction_function <= "100110";
s_instruction_opcode <= "000000";

wait for 100 ns;

-- AND
s_instruction_function <= "100100";
s_instruction_opcode <= "000000";

wait for 100 ns;
wait;
end process;

end behavior;
