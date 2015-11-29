----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:09:28 11/20/2015 
-- Design Name: 
-- Module Name:    REG_IF_ID - Behavioral 
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

--rst: 异步清零标志，当检测到rst为0时，所有寄存器清零
--clk: 时钟上升沿更新锁存器
--stall: 当stall为1时，时钟上升沿锁存器保持原值

--data
--Instr: 获取到的指令
--PCPlus1： PC加4

entity REG_IF_ID is
	port(
		rst, clk, stall: in std_logic;
		--data
		InstrF: in std_logic_vector(15 downto 0);
		PCPlus1F: in std_logic_vector(15 downto 0);
		
		--data
		InstrD: out std_logic_vector(15 downto 0);
		PCPlus1D: out std_logic_vector(15 downto 0)
	);
end REG_IF_ID;

architecture Behavioral of REG_IF_ID is
	signal Instr: std_logic_vector(15 downto 0);
	signal PCPlus1: std_logic_vector(15 downto 0);
begin
	InstrD <= Instr;
	PCPlus1D <= PCPlus1;
	
	process(rst, clk, stall)
	begin
		if rst = '0' then -- 异步清零
			Instr <= (others => '0');
			PCPlus1 <= (others => '0');
			
		elsif rising_edge(clk) then
			if stall = '0' then
				Instr <= InstrF;
				PCPlus1 <= PCPlus1F;
			else
				--doing nothing
				Instr <= Instr;
				PCPlus1 <= PCPlus1;
			end if;
		
		end if;
	end process;
	
end Behavioral;

