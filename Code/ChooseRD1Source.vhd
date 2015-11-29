----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:13 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseRD1Source - Behavioral 
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

--Forward: 00 -- ѡ��ԭ�ź�
--			  01 -- ѡ������ALU�׶���������� 
--			  10 -- ѡ������MEM�׶����������(����MEM������������ �� ALU������ �Ķ�ѡһ)

--RD1: RD1�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�RD1ֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM: ������ָ��Ҫд�ص�RD1ֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseRD1�� �����Ӧѡ���RD1ֵ

entity ChooseRD1Source is
	port(
		--control
		ForwardRD1: in std_logic_vector(1 downto 0);
		
		RD1: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD1: out std_logic_vector(15 downto 0)
	);	
end ChooseRD1Source;

architecture Behavioral of ChooseRD1Source is

begin
	ChooseRD1 <= ALUResultE when ForwardRD1(0) = '1'
			else	MemtoRegChooseM when ForwardRD1(1) = '1'
			else 	RD1;

end Behavioral;

