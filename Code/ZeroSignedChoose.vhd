----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:06:28 11/21/2015 
-- Design Name: 
-- Module Name:    ZeroSignedChoose - Behavioral 
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

--符号扩展与零扩展二选一选择器

--ImmExtend: control signal

--ZE_7_0：经零扩展后的数据
--SE_7_0：经符号扩展后的数据
--Z_S_7_0_out：输出

entity ZeroSignedChoose is
	port(
		--control signal
		ImmExtend: in std_logic;
		
		ZE_7_0: in std_logic_vector(15 downto 0);
		SE_7_0: in std_logic_vector(15 downto 0);
		Z_S_7_0_out: out std_logic_vector(15 downto 0) 
	);
end ZeroSignedChoose;

architecture Behavioral of ZeroSignedChoose is
	
begin
	with ImmExtend select
	Z_S_7_0_out <= ZE_7_0 when '0',
						SE_7_0 when '1',
						(others => '0') when others;

end Behavioral;

