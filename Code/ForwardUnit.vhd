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


--Forward1: 00 -- ѡ��regData1
--				01 -- ѡ������WB�׶ε����� (����MEM������������ �� ALU������ �Ķ�ѡһ)
--				10 -- ѡ������MEM�׶ε�����(��ALU��������)

--Forward2: 00 -- ѡ��regData2
--				01 -- ѡ������WB�׶ε����� (����MEM������������ �� ALU������ �Ķ�ѡһ)
--				10 -- ѡ������MEM�׶ε�����(��ALU��������)


--ForwardRx: 00 -- ѡ��RD1��ͨ�üĴ������ڣ�
--				01 -- ѡ������WB�׶ε����� (����MEM������������ �� ALU������ �Ķ�ѡһ)
--				10 -- ѡ������MEM�׶ε�����(��ALU��������)

entity ForwardUnit is
	port(
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		ALUSrc1: in std_logic_vector(1 downto 0);
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		
		Forward1: out std_logic_vector(1 downto 0);
		Forward2: out std_logic_vector(1 downto 0);
		ForwardRx: out std_logic_vector(1 downto 0)
	);
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin

	Forward1 <= "10" when ( ALUSrc1 = "00" and RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) ) --������ͨ�üĴ��� && ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
								or	( ALUSrc1 = "01" and RegDstE = "0001" ) --������SP�Ĵ��� && ����дSP�Ĵ���
								or ( ALUSrc1 = "10" and RegDstE = "0010" ) --������IH�Ĵ��� && ����дIH�Ĵ���
								
				else "01" when ( ALUSrc1 = "00" and RegDstM(3) = '1' and A1 = RegDstM(2 downto 0) ) --������ͨ�üĴ��� && ������дͨ�üĴ��� && ͨ�üĴ�����ͬ
								or ( ALUSrc1 = "01" and RegDstM = "0001" ) --������SP�Ĵ��� && ������дSP�Ĵ���
								or ( ALUSrc1 = "10" and RegDstM = "0010" ) --������IH�Ĵ��� && ������дIH�Ĵ���
								
				else "00";
				
	Forward2 <= "10" when RegDstE(3) = '1' and A2 = RegDstE(2 downto 0) -- ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
	
				else "01" when RegDstM(3) = '1' and A2 = RegDstM(2 downto 0) --������дͨ�üĴ��� && ͨ�üĴ�����ͬ
				
				else "00";
	
	ForwardRx <= "10" when RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) -- ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
	
				else "01" when RegDstM(3) = '1' and A1 = RegDstM(2 downto 0) --������дͨ�üĴ��� && ͨ�üĴ�����ͬ
				
				else "00";
	
end Behavioral;

