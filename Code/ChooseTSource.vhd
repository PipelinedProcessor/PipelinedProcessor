----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:33 11/24/2015 
-- Design Name: 
-- Module Name:    ChooseTSource - Behavioral 
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

--T: T�Ĵ����е�ֵ
--ALUResultE_0������ָ��Ҫд�ص�Tֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM_0: ������ָ��Ҫд�ص�Tֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseT�� �����Ӧѡ���Tֵ

entity ChooseTSource is
	port(
		--control
		ForwardT: in std_logic_vector(1 downto 0);
		
		--data
		T: in std_logic;
		ALUResultE_0: in std_logic;
		MemtoRegChooseM_0: in std_logic;
		
		ChooseT: out std_logic
	);
end ChooseTSource;

architecture Behavioral of ChooseTSource is

begin
	ChooseT <= 	ALUResultE_0 when ForwardT(0) = '1'
			else	MemtoRegChooseM_0 when ForwardT(1) = '1'
			else 	T;
			
end Behavioral;

