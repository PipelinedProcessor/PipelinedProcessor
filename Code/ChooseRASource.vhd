----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:24 11/24/2015 
-- Design Name: 
-- Module Name:    ChooseRASource - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--RegDstE: EXE阶段的RegDst，即上条指令的RegDst
--RegDSTM：MEM阶段的RegDst，即上上条指令的RegDst
--RegDSTW：WB阶段的RegDst，即上上上条指令的RegDst

--RA: RA寄存器中的值
--ALUResultE：上条指令要写回的RA值，取自EXE阶段ALU的输出
--ALUResultM: 上上条指令要写回的RA值，取自传至MEM阶段ALU的输出
--ALUResultW： 上上上条指令要写回的RA值，取自传至WB阶段ALU的输出

--ChooseRA： 输出，应选择的RA值

entity ChooseRASource is
	port(
		--control
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		RegDstW: in std_logic_vector(3 downto 0);
		
		RA: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		ALUResultM: in std_logic_vector(15 downto 0);
		ALUResultW: in std_logic_vector(15 downto 0);
		
		ChooseRA: out std_logic_vector(15 downto 0)
	);	
end ChooseRASource;

architecture Behavioral of ChooseRASource is

begin
	ChooseRA <= ALUResultE when RegDstE = "0100"		--上条要写RA
			else	ALUResultM when RegDstM = "0100"		--上上条要写RA
			else	ALUResultW when RegDstW = "0100"		--上上上条要写RA
			else	RA;

end Behavioral;

