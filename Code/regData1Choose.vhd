----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:02:42 11/21/2015 
-- Design Name: 
-- Module Name:    regData1Choose - Behavioral 
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

--IH, SP, RD1, PCPlus1四选一选择器

--ALUSrc1: control signal

--IH
--SP
--RD1
--PCPlus1
--regData1: 选择的结果

entity regData1Choose is
	port(
		--control signal
		ALUSrc1: in std_logic_vector(1 downto 0);
		
		IH, SP, RD1, PCPlus1: in std_logic_vector(15 downto 0);
		regData1: out std_logic_vector(15 downto 0)
	);
end regData1Choose;

architecture Behavioral of regData1Choose is
	
begin
	with ALUSrc1 select
		regData1 <= RD1 when "00",
						SP when "01",
						IH when "10",
						PCPlus1 when "11",
						(others => '0') when others;

end Behavioral;

