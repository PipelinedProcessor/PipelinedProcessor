----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:44:49 11/20/2015 
-- Design Name: 
-- Module Name:    SignedExtend - Behavioral 
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

--符号扩展器

--SE_3_0_in/SE_3_0_out: 输入为4位的数组，符号扩展为16位
--SE_4_0_in/SE_4_0_out: 输入为5位的数组，符号扩展为16位
--SE_4_2_in/SE_4_2_out: 输入为3位的数组，符号扩展为16位
--SE_7_0_in/SE_7_0_out: 输入为8位的数组，符号扩展为16位
--SE_10_0_in/SE_10_0_out: 输入为11位的数组，符号扩展为16位

entity SignedExtend is
	port(
		SE_3_0_in: in std_logic_vector(3 downto 0);
		SE_4_0_in: in std_logic_vector(4 downto 0); 
		SE_4_2_in: in std_logic_vector(4 downto 2); 
		SE_7_0_in: in std_logic_vector(7 downto 0); 
		SE_10_0_in: in std_logic_vector(10 downto 0);
			
		SE_3_0_out: out std_logic_vector(15 downto 0);
		SE_4_0_out: out std_logic_vector(15 downto 0);
		SE_4_2_out: out std_logic_vector(15 downto 0);
		SE_7_0_out: out std_logic_vector(15 downto 0);
		SE_10_0_out: out std_logic_vector(15 downto 0)
	);
end SignedExtend;

architecture Behavioral of SignedExtend is
	
begin
	with SE_3_0_in(3) select
		SE_3_0_out <= B"1111_1111_1111" & SE_3_0_in when '1',
						  B"0000_0000_0000" & SE_3_0_in when '0',
						  B"0000_0000_0000_0000" when others;
		
	with SE_4_0_in(4) select
		SE_4_0_out <= B"1111_1111_111" & SE_4_0_in when '1',
						  B"0000_0000_000" & SE_4_0_in when '0',
						  B"0000_0000_0000_0000" when others;
						  
	with SE_4_2_in(4) select
		SE_4_2_out <= B"1111_1111_1111_1" & SE_4_2_in when '1',
						  B"0000_0000_0000_0" & SE_4_2_in when '0',
						  B"0000_0000_0000_0000" when others;
	
	with SE_7_0_in(7) select
		SE_7_0_out <= B"1111_1111" & SE_7_0_in when '1',
						  B"0000_0000" & SE_7_0_in when '0',
						  B"0000_0000_0000_0000" when others;
						  
	with SE_10_0_in(10) select
		SE_10_0_out <= B"1111_1" & SE_10_0_in when '1',
						   B"0000_0" & SE_10_0_in when '0',
						   B"0000_0000_0000_0000" when others;	
							
						

end Behavioral;

