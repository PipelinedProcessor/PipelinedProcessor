----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:09:09 11/21/2015 
-- Design Name: 
-- Module Name:    ExtendChoose - Behavioral 
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

--��������չ��ѡһѡ����

--ImmLen�� control signal

--SE_3_0
--SE_4_0
--SE_4_2
--Z_S_7_0: ZeroSignedChoose(������չ������չ��ѡһѡ����)��ѡ����
--ExtendChooseOut�����

entity ExtendChoose is
	port(
		--control signal
		ImmLen: in std_logic_vector(1 downto 0);
		
		SE_3_0: in std_logic_vector(15 downto 0);
		SE_4_0: in std_logic_vector(15 downto 0); 
		SE_4_2: in std_logic_vector(15 downto 0);
		Z_S_7_0: in std_logic_vector(15 downto 0);
		
		ExtendChooseOut: out std_logic_vector(15 downto 0)
	);
end ExtendChoose;

architecture Behavioral of ExtendChoose is
	
begin
	with ImmLen select 
	ExtendChooseOut <= SE_3_0 when "00",
							 SE_4_0 when "01",
							 SE_4_2 when "10",
							 Z_S_7_0 when "11",
							 (others => '0') when others;

end Behavioral;

