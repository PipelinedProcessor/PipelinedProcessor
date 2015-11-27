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
		RegDstM: in std_logic_vector(3 downto 0);
		--data
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		--control signal
		RegDstW: out std_logic_vector(3 downto 0);
		--data
		MemtoRegChooseW: out std_logic_vector(15 downto 0)
	);
end REG_MEM_WB;

architecture Behavioral of REG_MEM_WB is
	--control signal
	signal RegDst: std_logic_vector(3 downto 0);
	
	--data
	signal MemtoRegChoose: std_logic_vector(15 downto 0);
	
begin
	--control signal
	RegDstW <= RegDst;
	
	--data
	MemtoRegChooseW <= MemtoRegChoose;
	
	process(rst, clk, stall)
	begin
		if rst = '0' then -- Òì²½ÇåÁã
			--control signal
			RegDst <= (others => '0');
			
			--data
			MemtoRegChoose <= (others => '0');
			
		elsif rising_edge(clk) then
			if stall = '0' then
				--control signal
				RegDst <= RegDstM;
				
				--data
				MemtoRegChoose <= MemtoRegChooseM;
				
			else	--doing nothing
				
				--control signal
				RegDst <= RegDst;
				
				--data
				MemtoRegChoose <= MemtoRegChoose;
				
			end if;
		
		end if;
	end process;

end Behavioral;

