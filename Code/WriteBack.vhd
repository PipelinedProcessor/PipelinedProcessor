----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:05 11/20/2015 
-- Design Name: 
-- Module Name:    WriteBack - Behavioral 
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

--WBģ��

--MemtoReg: control signal

--MemOut: �ڴ����������
--ALUOut�� ALU�����������
--RegDstData��д�ؼĴ���������

entity WriteBack is
	port(
		--control signal
		MemtoReg: in std_logic;
		
		MemOut: in std_logic_vector(15 downto 0);
		ALUOut: in std_logic_vector(15 downto 0);
		
		RegDstData: out std_logic_vector(15 downto 0) 
	);
end WriteBack;

architecture Behavioral of WriteBack is
begin
	with MemtoReg select
	RegDstData <= MemOut when '1',
				     ALUOut when '0',
				    (others => '0') when others;

end Behavioral;

