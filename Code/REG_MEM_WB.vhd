----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:16 11/20/2015 
-- Design Name: 
-- Module Name:    REG_MEM_WB - Behavioral 
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

entity REG_MEM_WB is
	port(
		rst, clk, stall: in std_logic;
		--control signal
		Mem2RegM: in std_logic;
		RegDstM: in std_logic_vector(3 downto 0);
		--data
		MemOutM: in std_logic_vector(15 downto 0);
		ALUOutM: in std_logic_vector(15 downto 0);
		
		--control signal
		Mem2RegW: out std_logic;
		RegDstW: out std_logic_vector(3 downto 0);
		--data
		MemOutW: out std_logic_vector(15 downto 0);
		ALUOutW: out std_logic_vector(15 downto 0)
	);
end REG_MEM_WB;

architecture Behavioral of REG_MEM_WB is
	--control signal
	signal Mem2Reg: std_logic;
	signal RegDst: std_logic_vector(3 downto 0);
	
	--data
	signal MemOut: std_logic_vector(15 downto 0);
	signal ALUOut: std_logic_vector(15 downto 0);
	
begin
	--control signal
	Mem2RegW <= Mem2Reg;
	RegDstW <= RegDst;
	
	--data
	MemOutW <= MemOut;
	ALUOutW <= ALUOut;
	
	process(rst, clk, stall)
	begin
		if rst = '0' then -- Òì²½ÇåÁã
			--control signal
			Mem2Reg <= '0';
			RegDst <= (others => '0');
			
			--data
			MemOut <= (others => '0');
			ALUOut <= (others => '0');
			
		elsif rising_edge(clk) then
			if stall = '0' then
				--control signal
				Mem2Reg <= Mem2RegM;
				RegDst <= RegDstM;
				
				--data
				MemOut <= MemOutM;
				ALUOut <= ALUOutM;
				
			else	--doing nothing
				
				--control signal
				Mem2Reg <= Mem2Reg;
				RegDst <= RegDst;
				
				--data
				MemOut <= MemOut;
				ALUOut <= ALUOut;
				
			end if;
		
		end if;
	end process;

end Behavioral;

