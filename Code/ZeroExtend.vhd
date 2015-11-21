----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:28:51 11/20/2015 
-- Design Name: 
-- Module Name:    ZeroExtend - Behavioral 
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

--零扩展器

--ZE_7_0_in/ZE_7_0_out: 输入为8位的数组，零扩展为16位

entity ZeroExtend is
	port(
		ZE_7_0_in: in std_logic_vector(7 downto 0);
		ZE_7_0_out: out std_logic_vector(15 downto 0)
	);
end ZeroExtend;

architecture Behavioral of ZeroExtend is

begin
	ZE_7_0_out <= B"0000_0000" & ZE_7_0_in;
	
end Behavioral;


