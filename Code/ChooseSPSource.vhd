----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:42 11/27/2015 
-- Design Name: 
-- Module Name:    ChooseSPSource - Behavioral 
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

--SP: SP�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�SPֵ��ȡ��EXE�׶�ALU�����
--MemtoRegChooseM: ������ָ��Ҫд�ص�SPֵ��ȡ�Դ���MEM�׶�ALU������ڴ��������Ķ�ѡһ

--ChooseSP�� �����Ӧѡ���SPֵ


entity ChooseSPSource is
	port(
		--control
		ForwardSP: in std_logic_vector(1 downto 0);
		
		SP: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseSP: out std_logic_vector(15 downto 0)
	);	
end ChooseSPSource;

architecture Behavioral of ChooseSPSource is

begin
	ChooseSP <= ALUResultE when ForwardSP(0) = '1'
			else	MemtoRegChooseM when ForwardSP(1) = '1'
			else 	SP;

end Behavioral;

