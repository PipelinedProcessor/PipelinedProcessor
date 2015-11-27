----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:15:26 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseIHSource - Behavioral 
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

--IH: IH�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�IHֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM: ������ָ��Ҫд�ص�IHֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseIH�� �����Ӧѡ���IHֵ

entity ChooseIHSource is
	port(
		--control
		ForwardIH: in std_logic_vector(1 downto 0);
		
		IH: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseIH: out std_logic_vector(15 downto 0)
	);	
end ChooseIHSource;

architecture Behavioral of ChooseIHSource is

begin
	ChooseIH <= ALUResultE when ForwardIH(0) = '1'
			else	MemtoRegChooseM when ForwardIH(1) = '1'
			else 	IH;

end Behavioral;

