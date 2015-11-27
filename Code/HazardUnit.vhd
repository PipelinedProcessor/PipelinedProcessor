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

--HazardUnit位置：ID段

--RegDstE: EXE阶段的RegDst控制信号，即上条指令的RegDst控制信号
--MemReadE: EXE阶段的MemReadE控制信号，即上条指令的MemReadE控制信号
--ALUSrc1： 当前指令产生的控制信号ALUSrc1
--ALUSrc2: 当前指令产生的控制信号ALUSrc2
--bubble： 当bubble置'1'时，插入气泡

--A1：读取的通用寄存器编号(rs)
--A2：读取的通用寄存器编号(rt)

--stallF: PC阶段寄存器保持不变
--stallD: reg_IF_ID阶段寄存器保持不变
--FlushE: reg_ID_EXE阶段寄存器清零

entity HazardUnit is
	port(
		--control signal
		RegDstE: in std_logic_vector(3 downto 0);
		MemReadE: in std_logic;
		ALUSrc1: in std_logic_vector(1 downto 0);
		ALUSrc2: in std_logic;
		bubble: in std_logic;
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		INST_15_11: in std_logic_vector(4 downto 0);
	
		stallF: out std_logic;
		stallD: out std_logic;
		FlushE: out std_logic
	);
end HazardUnit;

architecture Behavioral of HazardUnit is
	signal needLWBubble: BOOLEAN;
begin
	
	needLWBubble <= MemReadE = '1' 	--上条是 读内存到寄存器 指令（LW, LW_SP）
				 and (						--且 本条读的寄存器 与 上条写的寄存器 相同
							--（本条为SW_SP（要将RD1写入内存） 或 本条RD1读通用寄存器） && 上条写通用寄存器 && 通用寄存器相同
							( (INST_15_11 = "11010" or ALUSrc1 = "00") and RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) ) 
							--本条RD1读SP寄存器 && 上条写SP寄存器
						or	( ALUSrc1 = "01" and RegDstE = "0001" ) 
						
						--（本条为SW（要将RD2写入内存） 或 本条RD2读通用寄存器） && 上条写通用寄存器 && 通用寄存器相同
						or ( (INST_15_11 = "11011" or ALUSrc2 = '0') and RegDstE(3) = '1' and A2 = RegDstE(2 downto 0) ) 
					  ); 
	
	process(bubble, needLWBubble)
	begin
		if (bubble = '1' or needLWBubble) then
			stallF <= '1';
			stallD <= '1';
			FlushE <= '1';
		else
			stallF <= '0';
			stallD <= '0';
			FlushE <= '0';
		
		end if;
	
	end process;
	
end Behavioral;

