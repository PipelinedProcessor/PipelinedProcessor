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

--HazardUnitλ�ã�ID��

--RegDstE: EXE�׶ε�RegDst�����źţ�������ָ���RegDst�����ź�
--MemReadE: EXE�׶ε�MemReadE�����źţ�������ָ���MemReadE�����ź�
--ALUSrc1�� ��ǰָ������Ŀ����ź�ALUSrc1
--ALUSrc2: ��ǰָ������Ŀ����ź�ALUSrc2
--bubble�� ��bubble��'1'ʱ����������

--A1����ȡ��ͨ�üĴ������(rs)
--A2����ȡ��ͨ�üĴ������(rt)

--stallF: PC�׶μĴ������ֲ���
--stallD: reg_IF_ID�׶μĴ������ֲ���
--FlushE: reg_ID_EXE�׶μĴ�������

entity HazardUnit is
	port(
		--control signal
		RegDstE: in std_logic_vector(3 downto 0);
		MemReadE: in std_logic;
		ALUSrc1: in std_logic_vector(1 downto 0);
		ALUSrc2: in std_logic;
		bubble: in std_logic;
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		INST_15_11: in std_logic_vector(4 downto 0);
	
		stallF: out std_logic;
		stallD: out std_logic;
		FlushE: out std_logic
	);
end HazardUnit;

architecture Behavioral of HazardUnit is
	signal needLWBubble: BOOLEAN;
begin
	
	needLWBubble <= MemReadE = '1' 	--������ ���ڴ浽�Ĵ��� ָ�LW, LW_SP��
				 and (						--�� �������ļĴ��� �� ����д�ļĴ��� ��ͬ
							--������ΪSW_SP��Ҫ��RD1д���ڴ棩 �� ����RD1��ͨ�üĴ����� && ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
							( (INST_15_11 = "11010" or ALUSrc1 = "00") and RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) ) 
							--����RD1��SP�Ĵ��� && ����дSP�Ĵ���
						or	( ALUSrc1 = "01" and RegDstE = "0001" ) 
						
						--������ΪSW��Ҫ��RD2д���ڴ棩 �� ����RD2��ͨ�üĴ����� && ����дͨ�üĴ��� && ͨ�üĴ�����ͬ
						or ( (INST_15_11 = "11011" or ALUSrc2 = '0') and RegDstE(3) = '1' and A2 = RegDstE(2 downto 0) ) 
					  ); 
	
	process(bubble, needLWBubble)
	begin
		if (bubble = '1' or needLWBubble) then
			stallF <= '1';
			stallD <= '1';
			FlushE <= '1';
		else
			stallF <= '0';
			stallD <= '0';
			FlushE <= '0';
		
		end if;
	
	end process;
	
end Behavioral;

