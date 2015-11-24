----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:28 11/23/2015 
-- Design Name: 
-- Module Name:    ID_Jump - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--JumpDst: control signal

--SE_7_0: ������չ�����
--SE_10_0: ������չ�����
--RD1�� ������ͨ�üĴ���A1��ֵ
--RA�� ����������Ĵ���T��ֵ
--PCPlus1: PC+1
--PCBranch: Ҫ��ת�ĵ�ַ

entity ID_Jump is
	port(
		--control sigal
		JumpDst: in std_logic_vector(1 downto 0);
		
		--data
		SE_7_0: in std_logic_vector(15 downto 0); 
		SE_10_0: in std_logic_vector(15 downto 0);
		RD1: in std_logic_vector(15 downto 0);
		RA: in std_logic_vector(15 downto 0);
		PCPlus1: in std_logic_vector(15 downto 0);
		
		PCBranch: out std_logic_vector(15 downto 0)
	);
end ID_Jump;

architecture Behavioral of ID_Jump is

begin
	with JumpDst select
	PCBranch <= SE_10_0 + PCPlus1 when "00",
					SE_7_0  + PCPlus1 when "01",
					RD1					when "10",
					RA						when "11",
					(others => '0')	when others;

end Behavioral;

