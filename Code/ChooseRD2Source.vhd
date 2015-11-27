----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:58 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseRD2Source - Behavioral 
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

--RD2: RD2寄存器中的值
--ALUResultE：上条指令要写回的RD2值，取自EXE阶段ALU的输出
--MemtoRegChooseM: 上上条指令要写回的RD2值，取自传至MEM阶段ALU输出与内存读出结果的二选一

--ChooseRD2： 输出，应选择的RD2值

entity ChooseRD2Source is
	port(
		--control
		ForwardRD2: in std_logic_vector(1 downto 0);
		
		RD2: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD2: out std_logic_vector(15 downto 0)
	);	
	
end ChooseRD2Source;

architecture Behavioral of ChooseRD2Source is

begin
	ChooseRD2 <= ALUResultE when ForwardRD2(0) = '1'
			else	MemtoRegChooseM when ForwardRD2(1) = '1'
			else 	RD2;

end Behavioral;

