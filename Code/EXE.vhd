----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:11:46 11/22/2015 
-- Design Name: 
-- Module Name:    EXE - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EXE is
	port( Rx, imm, Src1, Ry: in std_logic_vector (15 downto 0);
			op: in std_logic_vector(3 downto 0);
			WriteDataSrc: in std_logic; -- control signal to select which reg to write back to memory
			ALUSrc2: in std_logic; -- control signal to select if ry or imm is the second source for ALU
			ALUResult: out std_logic_vector(15 downto 0);
			WriteData: out std_logic_vector(15 downto 0)
			--l : out STD_LOGIC_VECTOR(15 downto 0)
		 );
end EXE;

architecture Behavioral of EXE is
	component ALU is
	Port ( A, B: in std_logic_vector (15 downto 0);
			 op: in std_logic_vector(3 downto 0);
			 result: out std_logic_vector(15 downto 0)
	);
	end component;
	signal Src2: std_logic_vector(15 downto 0);
begin
	Src2 <= Ry when ALUSrc2 = '0'
		else   imm;
	--l(15 downto 8) <= Src1(7 downto 0);
	--l(7 downto 0) <= Src2(7 downto 0);
	ALU0 : ALU port map (Src1,Src2,op,ALUResult);
	WriteData <= Ry when WriteDataSrc = '0'
			else	 Rx;
end Behavioral;

