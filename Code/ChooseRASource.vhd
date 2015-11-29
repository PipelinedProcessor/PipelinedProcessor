----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:24 11/24/2015 
-- Design Name: 
-- Module Name:    ChooseRASource - Behavioral 
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

--RA: RA�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�RAֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM: ������ָ��Ҫд�ص�RAֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseRA�� �����Ӧѡ���RAֵ

entity ChooseRASource is
	port(
		--control
		ForwardRA: in std_logic_vector(1 downto 0);
		
		RA: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRA: out std_logic_vector(15 downto 0)
	);	
end ChooseRASource;

architecture Behavioral of ChooseRASource is

begin
	ChooseRA <= ALUResultE when ForwardRA(0) = '1'
			else	MemtoRegChooseM when ForwardRA(1) = '1'
			else RA;

end Behavioral;

