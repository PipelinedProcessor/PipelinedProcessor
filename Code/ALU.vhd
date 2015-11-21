----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:18 10/13/2015 
-- Design Name: 
-- Module Name:    calculate - Behavioral 
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	port(A, B: in std_logic_vector (15 downto 0);
			op: in std_logic_vector(3 downto 0);
			result: out std_logic_vector(15 downto 0)
			);
end ALU;

architecture Behavioral of ALU is
signal res0,res1,res2,res3,res4,res5,res6,res8,res9,res10:std_logic_vector(15 downto 0);
signal tmp20,tmp21,tmp30,tmp31:std_logic_vector(15 downto 0);
begin
-- A + B
	res0 <= A + B;
-- A - B
	res1 <= A - B;
-- A << B
	tmp20 <=
		A(14 downto 0) & '0' when B(0) = '1'
		else A;
	tmp21 <=
		tmp20(13 downto 0) & "00" when B(1) = '1'
		else tmp20;
	res2 <=
		tmp21(11 downto 0) & "0000" when B(2) = '1'
		else A(7 downto 0) & "00000000" when B(2) = '0' and B(1) = '0' and B(0) = '0'
		else tmp21;
-- A >> B	
	tmp30 <=
		A(15) & A(15 downto 1) when B(0) = '1'
		else A;
	tmp31 <=
		A(15) & A(15) & tmp30(15 downto 2) when B(1) = '1'
		else tmp30;
	res3 <=
		A(15) & A(15) & A(15) & A(15) & tmp31(15 downto 4) when B(2) = '1'
		else A(15) & A(15) & A(15) & A(15) & A(15) & A(15) & A(15) & A(15) & A(7 downto 0) when B(2) = '0' and B(1) = '0' and B(0) = '0'
		else tmp31;
-- A == B	
	res4 <= 
		(0 => '1', others => '0') when A = B
		else (others => '0');
-- A < B
	res6 <= 
		(0 => '1', others => '0') when A < B
		else (others => '0');
-- A != B
	res5 <= 
		(others => '0') when A = B
		else (0 => '1', others => '0');
-- A & B	
	res8 <= A and B;
-- A | B
	res9 <= A or B;
-- A++
	res10 <= A + "1";

	with op select
		result <= res0 when "0010",
					 res1 when "0011",
					 res2 when "1010",
					 res3 when "1011",
					 res4 when "0100",
					 res5 when "0101",
					 res6 when "0110",
					 res8 when "1000",
					 res9 when "1001",
					 A when "1100",
					 B when "1101",
					 res10 when "1110",
					 (others => '0') when others;
	
end Behavioral;

