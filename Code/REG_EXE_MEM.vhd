----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:39 11/20/2015 
-- Design Name: 
-- Module Name:    REG_EXE_MEM - Behavioral 
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


entity REG_EXE_MEM is
	Port(
		rst, clk, stall: in std_logic;
		--control signal
		MemReadE: in std_logic;
		MemWriteE: in std_logic;
		Mem2RegE: in std_logic;
		RegDstE: in std_logic_vector(3 downto 0);
		--data
		ALUOutE: in std_logic_vector(15 downto 0);
		WriteDataE: in std_logic_vector(15 downto 0);
		
		--control signal
		MemReadM: out std_logic;
		MemWriteM: out std_logic;
		Mem2RegM: out std_logic;
		RegDstM: out std_logic_vector(3 downto 0);
		--data
		ALUOutM: out std_logic_vector(15 downto 0);
		WriteDataM: out std_logic_vector(15 downto 0)
	);
end REG_EXE_MEM;

architecture Behavioral of REG_EXE_MEM is
	--control signal
	signal MemRead: std_logic; 
	signal MemWrite: std_logic;
	signal Mem2Reg: std_logic;
	signal RegDst: std_logic_vector(3 downto 0);
	
	--data
	signal ALUOut: std_logic_vector(15 downto 0);
	signal WriteData: std_logic_vector(15 downto 0);
	
begin
	--control signal
	MemReadM <= MemRead;
	MemWriteM <= MemWrite;
	Mem2RegM <= Mem2Reg;
	RegDstM <= RegDst;
	
	--data
	ALUOutM <= ALUOut;
	WriteDataM <= WriteData;
	
	process(rst, clk, stall)
	begin
		if rst = '0' then -- 异步清零
			--control signal
			MemRead <= '0';
			MemWrite <= '0';
			Mem2Reg <= '0';
			RegDst <= (others => '0');
			
			--data
			ALUOut <= (others => '0');
			WriteData <= (others => '0');
			
		elsif rising_edge(clk) then
			if stall = '0' then
				--control signal
				MemRead <= MemReadE;
				MemWrite <= MemWriteE;
				Mem2Reg <= Mem2RegE;
				RegDst <= RegDstE;
				
				--data
				ALUOut <= ALUOutE;
				WriteData <= WriteDataE;
				
			else	--doing nothing
				
				--control signal
				MemRead <= MemRead;
				MemWrite <= MemWrite;
				Mem2Reg <= Mem2Reg;
				RegDst <= RegDst;
				
				--data
				ALUOut <= ALUOut;
				WriteData <= WriteData;
				
			end if;
		
		end if;
	end process;

end Behavioral;

