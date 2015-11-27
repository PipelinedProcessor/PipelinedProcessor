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


--Forward: 00 -- 选择原信号
--			  01 -- 选择来自ALU阶段输出的数据 
--			  10 -- 选择来自MEM阶段输出的数据(即从MEM读出来的数据 与 ALU运算结果 的二选一)

entity ForwardUnit is
	port(
		--旁路传回的控制信号
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		
		--给出的选择信号
		ForwardRA: out std_logic_vector(1 downto 0);
		ForwardT: out std_logic_vector(1 downto 0);
		ForwardSP: out std_logic_vector(1 downto 0);
		ForwardIH: out std_logic_vector(1 downto 0);
		ForwardRD1: out std_logic_vector(1 downto 0);
		ForwardRD2: out std_logic_vector(1 downto 0)
	);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin

	ForwardSP <= "01" when RegDstE = "0001" -- 上条要写SP
			else	 "10" when RegDstM = "0001" -- 上上条要写SP
			else	 "00";
			
	ForwardIH <= "01" when RegDstE = "0010" -- 上条要写IH
			else	 "10" when RegDstM = "0010" -- 上上条要写IH
			else	 "00";
	
	ForwardT <= "01" when RegDstE = "0011" -- 上条要写T
			else	"10" when RegDstM = "0011" -- 上上条要写T
			else	"00";
			
	ForwardRA <= "01" when RegDstE = "0100" -- 上条要写RA
			else	 "10" when RegDstM = "0100" -- 上上条要写RA
			else	 "00";
			
	ForwardRD1 <= "01" when RegDstE(3) = '1' and A1 = RegDstE(2 downto 0)-- 上条写通用寄存器 && 通用寄存器相同
			else	  "10" when RegDstM(3) = '1' and A1 = RegDstM(2 downto 0)-- 上上条要写通用寄存器 && 通用寄存器相同
			else	  "00";
	
	ForwardRD2 <= "01" when RegDstE(3) = '1' and A2 = RegDstE(2 downto 0)-- 上条写通用寄存器 && 通用寄存器相同
			else	  "10" when RegDstM(3) = '1' and A2 = RegDstM(2 downto 0)-- 上上条要写通用寄存器 && 通用寄存器相同
			else	  "00";

end Behavioral;

