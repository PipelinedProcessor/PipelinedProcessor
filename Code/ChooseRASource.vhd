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

--RegDstE: EXE�׶ε�RegDst��������ָ���RegDst
--RegDSTM��MEM�׶ε�RegDst����������ָ���RegDst
--RegDSTW��WB�׶ε�RegDst������������ָ���RegDst

--RA: RA�Ĵ����е�ֵ
--ALUResultE������ָ��Ҫд�ص�RAֵ��ȡ��EXE�׶�ALU�����
--ALUResultM: ������ָ��Ҫд�ص�RAֵ��ȡ�Դ���MEM�׶�ALU�����
--ALUResultW�� ��������ָ��Ҫд�ص�RAֵ��ȡ�Դ���WB�׶�ALU�����

--ChooseRA�� �����Ӧѡ���RAֵ

entity ChooseRASource is
	port(
		--control
		RegDstE: in std_logic_vector(3 downto 0);
		RegDstM: in std_logic_vector(3 downto 0);
		RegDstW: in std_logic_vector(3 downto 0);
		
		RA: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		ALUResultM: in std_logic_vector(15 downto 0);
		ALUResultW: in std_logic_vector(15 downto 0);
		
		ChooseRA: out std_logic_vector(15 downto 0)
	);	
end ChooseRASource;

architecture Behavioral of ChooseRASource is

begin
	ChooseRA <= ALUResultE when RegDstE = "0100"		--����ҪдRA
			else	ALUResultM when RegDstM = "0100"		--������ҪдRA
			else	ALUResultW when RegDstW = "0100"		--��������ҪдRA
			else	RA;

end Behavioral;

