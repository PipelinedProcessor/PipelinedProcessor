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

--RegDstE: EXE�׶ε�RegDst��������ָ���RegDst
--RegDSTM��MEM�׶ε�RegDst����������ָ���RegDst
--RegDSTW��WB�׶ε�RegDst������������ָ���RegDst

--T: T�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�Tֵ��ȡ��EXE�׶�ALU�����
--ALUResultM: ������ָ��Ҫд�ص�Tֵ��ȡ�Դ���MEM�׶�ALU�����
--ALUResultW�� ��������ָ��Ҫд�ص�Tֵ��ȡ�Դ���WB�׶�ALU�����

--ChooseT�� �����Ӧѡ���Tֵ

entity ChooseTSource is
	port(
		--control
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		RegDstW: in std_logic_vector(3 downto 0);
		
		--data
		T: in std_logic;
		ALUResultE: in std_logic_vector(15 downto 0);
		ALUResultM: in std_logic_vector(15 downto 0);
		ALUResultW: in std_logic_vector(15 downto 0);
		
		ChooseT: out std_logic
	);
end ChooseTSource;

architecture Behavioral of ChooseTSource is

begin
	ChooseT <= ALUResultE(0) when RegDstE = "0011"	--����ҪдT
		 else	  ALUResultM(0) when RegDstM = "0011"  --������ҪдT
		 else	  ALUResultW(0) when RegDstW = "0011"  --��������ҪдT
		 else   T;

end Behavioral;

