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

--WB模块

--MemtoReg: control signal

--MemOut: 内存读出的数据
--ALUOut： ALU计算出的数据
--RegDstData：写回寄存器的数据

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

