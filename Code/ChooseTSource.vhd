----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:33 11/24/2015 
-- Design Name: 
-- Module Name:    ChooseTSource - Behavioral 
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

--T: T寄存器中的值
--ALUResultE：上条指令要写回的T值，取自EXE阶段ALU的输出
--ALUResultM: 上上条指令要写回的T值，取自传至MEM阶段ALU的输出
--ALUResultW： 上上上条指令要写回的T值，取自传至WB阶段ALU的输出

--ChooseT： 输出，应选择的T值

entity ChooseTSource is
	port(
		--control
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		RegDstW: in std_logic_vector(3 downto 0);
		
		--data
		T: in std_logic;
		ALUResultE_0: in std_logic;
		ALUResultM_0: in std_logic;
		ALUResultW_0: in std_logic;
		
		ChooseT: out std_logic
	);
end ChooseTSource;

architecture Behavioral of ChooseTSource is

begin
	ChooseT <= ALUResultE_0 when RegDstE = "0011"	--上条要写T
		 else	  ALUResultM_0 when RegDstM = "0011"  --上上条要写T
		 else	  ALUResultW_0 when RegDstW = "0011"  --上上上条要写T
		 else   T;

end Behavioral;

