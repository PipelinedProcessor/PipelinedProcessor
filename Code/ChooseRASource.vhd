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

--Forward: 00 -- 选择原信号
--			  01 -- 选择来自ALU阶段输出的数据 
--			  10 -- 选择来自MEM阶段输出的数据(即从MEM读出来的数据 与 ALU运算结果 的二选一)

--RA: RA寄存器中的值
--ALUResultE：上条指令要写回的RA值，取自EXE阶段ALU的输出
--MemtoRegChooseM: 上上条指令要写回的RA值，取自传至MEM阶段ALU输出与内存读出结果的二选一

--ChooseRA： 输出，应选择的RA值

entity ChooseRASource is
	port(
		--control
		ForwardRA: in std_logic_vector(1 downto 0);
		
		RA: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRA: out std_logic_vector(15 downto 0)
	);	
end ChooseRASource;

architecture Behavioral of ChooseRASource is

begin
	ChooseRA <= ALUResultE when ForwardRA(0) = '1'
			else	MemtoRegChooseM when ForwardRA(1) = '1'
			else RA;

end Behavioral;

