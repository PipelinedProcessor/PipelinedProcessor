----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:49:49 11/23/2015 
-- Design Name: 
-- Module Name:    HazardUnit - Behavioral 
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

--ForwardUnit位置：ID段

--RegDstE: EXE阶段的RegDst控制信号，即上条指令的控制信号
--RegDstM: MEM阶段的RegDst控制信号，即上上条指令的控制信号
--ALUSrc1: 当前指令产生的控制信号ALUSrc1
--A1：读取的通用寄存器编号(rs)
--A2：读取的通用寄存器编号(rt)


--Forward1: 00 -- 选择regData1
--				01 -- 选择来自WB阶段的数据 (即从MEM读出来的数据 与 ALU运算结果 的二选一)
--				10 -- 选择来自MEM阶段的数据(即ALU的运算结果)

--Forward2: 00 -- 选择regData2
--				01 -- 选择来自WB阶段的数据 (即从MEM读出来的数据 与 ALU运算结果 的二选一)
--				10 -- 选择来自MEM阶段的数据(即ALU的运算结果)


--ForwardRx: 00 -- 选择RD1（通用寄存器出口）
--				01 -- 选择来自WB阶段的数据 (即从MEM读出来的数据 与 ALU运算结果 的二选一)
--				10 -- 选择来自MEM阶段的数据(即ALU的运算结果)

entity ForwardUnit is
	port(
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		ALUSrc1: in std_logic_vector(1 downto 0);
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		
		Forward1: out std_logic_vector(1 downto 0);
		Forward2: out std_logic_vector(1 downto 0);
		ForwardRx: out std_logic_vector(1 downto 0)
	);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin

	Forward1 <= "10" when ( ALUSrc1 = "00" and RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) ) --本条读通用寄存器 && 上条写通用寄存器 && 通用寄存器相同
								or	( ALUSrc1 = "01" and RegDstE = "0001" ) --本条读SP寄存器 && 上条写SP寄存器
								or ( ALUSrc1 = "10" and RegDstE = "0010" ) --本条读IH寄存器 && 上条写IH寄存器
								
				else "01" when ( ALUSrc1 = "00" and RegDstM(3) = '1' and A1 = RegDstM(2 downto 0) ) --本条读通用寄存器 && 上上条写通用寄存器 && 通用寄存器相同
								or ( ALUSrc1 = "01" and RegDstM = "0001" ) --本条读SP寄存器 && 上上条写SP寄存器
								or ( ALUSrc1 = "10" and RegDstM = "0010" ) --本条读IH寄存器 && 上上条写IH寄存器
								
				else "00";
				
	Forward2 <= "10" when RegDstE(3) = '1' and A2 = RegDstE(2 downto 0) -- 上条写通用寄存器 && 通用寄存器相同
	
				else "01" when RegDstM(3) = '1' and A2 = RegDstM(2 downto 0) --上上条写通用寄存器 && 通用寄存器相同
				
				else "00";
	
	ForwardRx <= "10" when RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) -- 上条写通用寄存器 && 通用寄存器相同
	
				else "01" when RegDstM(3) = '1' and A1 = RegDstM(2 downto 0) --上上条写通用寄存器 && 通用寄存器相同
				
				else "00";
	
end Behavioral;

