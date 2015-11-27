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

--Forward: 00 -- 选择原信号
--			  01 -- 选择来自ALU阶段输出的数据 
--			  10 -- 选择来自MEM阶段输出的数据(即从MEM读出来的数据 与 ALU运算结果 的二选一)

--T: T寄存器中的值
--ALUResultE_0：上条指令要写回的T值，取自EXE阶段ALU的输出
--MemtoRegChooseM_0: 上上条指令要写回的T值，取自传至MEM阶段ALU输出与内存读出结果的二选一

--ChooseT： 输出，应选择的T值

entity ChooseTSource is
	port(
		--control
		ForwardT: in std_logic_vector(1 downto 0);
		
		--data
		T: in std_logic;
		ALUResultE_0: in std_logic;
		MemtoRegChooseM_0: in std_logic;
		
		ChooseT: out std_logic
	);
end ChooseTSource;

architecture Behavioral of ChooseTSource is

begin
	ChooseT <= 	ALUResultE_0 when ForwardT(0) = '1'
			else	MemtoRegChooseM_0 when ForwardT(1) = '1'
			else 	T;
			
end Behavioral;

