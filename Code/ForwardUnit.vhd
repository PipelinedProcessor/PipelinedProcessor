----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:49:49 11/23/2015 
-- Design Name: 
-- Module Name:    HazardUnit - Behavioral 
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

--ForwardUnitλ�ã�ID��

--RegDstE: EXE�׶ε�RegDst�����źţ�������ָ��Ŀ����ź�
--RegDstM: MEM�׶ε�RegDst�����źţ���������ָ��Ŀ����ź�
--ALUSrc1: ��ǰָ������Ŀ����ź�ALUSrc1
--A1����ȡ��ͨ�üĴ������(rs)
--A2����ȡ��ͨ�üĴ������(rt)


--Forward: 00 -- ѡ��ԭ�ź�
--			  01 -- ѡ������ALU�׶���������� 
--			  10 -- ѡ������MEM�׶����������(����MEM������������ �� ALU������ �Ķ�ѡһ)

entity ForwardUnit is
	port(
		--��·���صĿ����ź�
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		
		--������ѡ���ź�
		ForwardRA: out std_logic_vector(1 downto 0);
		ForwardT: out std_logic_vector(1 downto 0);
		ForwardSP: out std_logic_vector(1 downto 0);
		ForwardIH: out std_logic_vector(1 downto 0);
		ForwardRD1: out std_logic_vector(1 downto 0);
		ForwardRD2: out std_logic_vector(1 downto 0)
	);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin

	ForwardSP <= "01" when RegDstE = "0001" -- ����ҪдSP
			else	 "10" when RegDstM = "0001" -- ������ҪдSP
			else	 "00";
			
	ForwardIH <= "01" when RegDstE = "0010" -- ����ҪдIH
			else	 "10" when RegDstM = "0010" -- ������ҪдIH
			else	 "00";
	
	ForwardT <= "01" when RegDstE = "0011" -- ����ҪдT
			else	"10" when RegDstM = "0011" -- ������ҪдT
			else	"00";
			
	ForwardRA <= "01" when RegDstE = "0100" -- ����ҪдRA
			else	 "10" when RegDstM = "0100" -- ������ҪдRA
			else	 "00";
			
	ForwardRD1 <= "01" when RegDstE(3) = '1' and A1 = RegDstE(2 downto 0)-- ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
			else	  "10" when RegDstM(3) = '1' and A1 = RegDstM(2 downto 0)-- ������Ҫдͨ�üĴ��� && ͨ�üĴ�����ͬ
			else	  "00";
	
	ForwardRD2 <= "01" when RegDstE(3) = '1' and A2 = RegDstE(2 downto 0)-- ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
			else	  "10" when RegDstM(3) = '1' and A2 = RegDstM(2 downto 0)-- ������Ҫдͨ�üĴ��� && ͨ�üĴ�����ͬ
			else	  "00";

end Behavioral;

