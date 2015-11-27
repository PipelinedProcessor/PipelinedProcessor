----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:58 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseRD2Source - Behavioral 
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

--RD2: RD2�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�RD2ֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM: ������ָ��Ҫд�ص�RD2ֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseRD2�� �����Ӧѡ���RD2ֵ

entity ChooseRD2Source is
	port(
		--control
		ForwardRD2: in std_logic_vector(1 downto 0);
		
		RD2: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD2: out std_logic_vector(15 downto 0)
	);	
	
end ChooseRD2Source;

architecture Behavioral of ChooseRD2Source is

begin
	ChooseRD2 <= ALUResultE when ForwardRD2(0) = '1'
			else	MemtoRegChooseM when ForwardRD2(1) = '1'
			else 	RD2;

end Behavioral;

