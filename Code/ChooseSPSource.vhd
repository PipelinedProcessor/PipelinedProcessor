----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:42 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseSPSource - Behavioral 
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

--SP: SP寄存器中的值
--ALUResultE：上条指令要写回的SP值，取自EXE阶段ALU的输出
--MemtoRegChooseM: 上上条指令要写回的SP值，取自传至MEM阶段ALU输出与内存读出结果的二选一

--ChooseSP： 输出，应选择的SP值


entity ChooseSPSource is
	port(
		--control
		ForwardSP: in std_logic_vector(1 downto 0);
		
		SP: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseSP: out std_logic_vector(15 downto 0)
	);	
end ChooseSPSource;

architecture Behavioral of ChooseSPSource is

begin
	ChooseSP <= ALUResultE when ForwardSP(0) = '1'
			else	MemtoRegChooseM when ForwardSP(1) = '1'
			else 	SP;

end Behavioral;

