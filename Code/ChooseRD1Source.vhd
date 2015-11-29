----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:13 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseRD1Source - Behavioral 
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

--RD1: RD1寄存器中的值
--ALUResultE：上条指令要写回的RD1值，取自EXE阶段ALU的输出
--MemtoRegChooseM: 上上条指令要写回的RD1值，取自传至MEM阶段ALU输出与内存读出结果的二选一

--ChooseRD1： 输出，应选择的RD1值

entity ChooseRD1Source is
	port(
		--control
		ForwardRD1: in std_logic_vector(1 downto 0);
		
		RD1: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD1: out std_logic_vector(15 downto 0)
	);	
end ChooseRD1Source;

architecture Behavioral of ChooseRD1Source is

begin
	ChooseRD1 <= ALUResultE when ForwardRD1(0) = '1'
			else	MemtoRegChooseM when ForwardRD1(1) = '1'
			else 	RD1;

end Behavioral;

