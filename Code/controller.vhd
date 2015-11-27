----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:44:37 11/20/2015 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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

entity controller is
    Port ( INST : in  STD_LOGIC_VECTOR (15 downto 0);
			  Branch : out STD_LOGIC; --set to 1 when current instruction is BEQZ
			  NBranch : out STD_LOGIC; --set to 1 when current instruction is BNQZ
			  TBranch : out STD_LOGIC; --set to 1 when current instruction is BTEQZ
			  DirectJmp : out STD_LOGIC; --set to 1 when current instruction is B, JR or JRRA
			  MemRead : out STD_LOGIC; --set to 1 when reading memory, the addr will be the output of ALU
			  MemWrite : out STD_LOGIC; --set to 1 when writing memory, the addr will be the output of ALU
			  MemtoReg : out STD_LOGIC; --set to 1 when the writing back value is from memory, set to 0 when is from ALU
			  ALUSrc1 : out STD_LOGIC_VECTOR (1 downto 0); --00->rs 01->SP 10->IH 11->PC
			  ALUSrc2 : out STD_LOGIC; --set to 1 when the second operator is imm, set to 0 when is reg
			  ALUOp : out STD_LOGIC_VECTOR (3 downto 0);
			  ImmExtend : out STD_LOGIC; --set to 0 when zero extend, set to 1 when sign extend
			  ImmLen : out STD_LOGIC_VECTOR (1 downto 0); --00 -> 3:0 01 -> 4:0 10 -> 4:2 11 -> 8:0
			  JumpDst : out STD_LOGIC_VECTOR (1 downto 0); --00 -> B 01 -> BNQZ/BTNQZ/BEQZ 10 -> JR 11 -> JRRA
			  RegDst : out STD_LOGIC_VECTOR (3 downto 0); --(8:15) -> universal reg, 0000 -> None, 0001 -> SP, 0010 -> IH, 0011 -> T, 0100 -> RA
			  WriteDataSrc : out STD_LOGIC -- 0 -> rx 1 -> sp
			);
end controller;

architecture Behavioral of controller is

begin
	Branch <= 
		'1' when INST(15 downto 11) = "00100"
		else '0';
	
	NBranch <=
		'1' when INST(15 downto 11) = "00101"
		else '0';
	
	TBranch <=
		'1' when INST(15 downto 8) = "01100000"
		else '0';
	
	DirectJmp <=
		'1' when INST(15 downto 11) = "00010"
		else '0';
	
	MemRead <=
		'1' when INST(15 downto 12) = "1001"
		else '0';
	
	MemWrite <=
		'1' when INST(15 downto 12) = "1101"
		else '0'; 
	
	MemtoReg <= 
		'1' when INST(15 downto 12) = "1001"
		else '0';
	
	ALUSrc1 <=
			  "01" when (INST(15 downto 8) = "01100011") -- ADDSP
					 or   (INST(15) = '1' and INST(13 downto 11) = "010") -- LW_SP / SW_SP 
		else "10" when (INST(15 downto 11) = "11110" and INST(0) = '0') -- MFIH
		else "11" when (INST(15 downto 11) = "11101" and INST(6 downto 0) = "1000000") -- MFPC / JALR
		else "00";
	
	ALUSrc2 <=
			  '0' when (INST(15 downto 11) = "11100") -- ADDU / SUBU
					or   (INST(15 downto 11) = "11101" and INST(3) = '1') -- AND / CMP / OR
					or   (INST(15 downto 11) = "01111") -- MOVE
					or   (INST(15 downto 10) = "011001") -- MTSP
		else '1';
	
	ALUOp <=
			  "0010" when (INST(15 downto 12) = "0100") -- ADDIU / ADDIU3
						or   (INST(15 downto 8) = "01100011") -- ADDSP
						or   (INST(15 downto 11) = "11100" and INST(1) = '0') -- ADDU
						or   (INST(15) = '1' and INST(13 downto 12) = "01") -- LW_SP / SW_SP / LW / SW
		else "0011" when (INST(15 downto 11) = "11100" and INST(1) = '1') -- SUBU
		else "0101" when (INST(15 downto 11) = "11101" and INST(4 downto 0) = "01010") -- CMP
						or   (INST(15 downto 11) = "01110") -- CMPI
		else "0110" when (INST(15 downto 11) = "01011") -- SLTUI
		else "1000" when (INST(15 downto 11) = "11101" and INST(4 downto 0) = "01100") -- AND
		else "1001" when (INST(15 downto 11) = "11101" and INST(4 downto 0) = "01101") -- OR
		else "1010" when (INST(15 downto 11) = "00110" and INST(0) = '0') -- SLL
		else "1011" when (INST(15 downto 11) = "00110" and INST(0) = '1') -- SRA
		else "1100" when   (INST(15 downto 11) = "11101" and INST(7 downto 0) = "01000000") -- MFPC
						or   (INST(15 downto 11) = "11110") -- MFIH / MTIH
		else "1101" when (INST(15 downto 11) = "01101") -- LI
						or   (INST(15 downto 8) = "01100100") -- MTSP
						or   (INST(15 downto 11) = "01111") -- MOVE
		else "1110" when (INST(15 downto 11) = "11101" and INST(7 downto 0) = "11000000") -- JALR
		else "0000";
	
	ImmExtend <=
			  '0' when (INST(15 downto 11) = "01101") -- LI
					or   (INST(15 downto 11) = "00110") -- SLL / SRA
					or   (INST(15 downto 11) = "01011") -- SLTUI
		else '1';
	
	ImmLen <=
			  "00" when (INST(15 downto 11) = "01000") -- ADDIU
		else "01" when (INST(15) = '1' and INST(13 downto 11) = "011") -- LW / SW
		else "10" when (INST(15 downto 11) = "00110") -- SLL / SRA
		else "11";
	
	JumpDst <=
			  "00" when (INST(15 downto 11) = "00010")
		else "01" when (INST(15 downto 12) = "0010") or (INST(15 downto 8) = "01100000")
		else "10" when (INST(15 downto 11) = "11101" and INST(7 downto 0) = "00000000")
		else "11";
	
	RegDst <=
			  '1' & INST(10 downto 8)  when (INST(15 downto 11) = "01001") -- ADDIU
												or   (INST(15 downto 11) = "11101" and INST(4 downto 1) = "0110") -- AND / OR
												or   (INST(15 downto 11) = "01101") -- LI
												or   (INST(15 downto 11) = "10010") -- LW_SP
												or   (INST(15 downto 11) = "11110" and INST(0) = '0') -- MFIH
												or   (INST(15 downto 11) = "00110") -- SLL / SRA
												or   (INST(15 downto 11) = "01111") -- MOVE
												-- hy add
												or	  (INST(15 downto 11) = "11101" and INST(4 downto 1) = "0000") -- MFPC
												
		else '1' & INST(7 downto 5)   when (INST(15 downto 11) = "01000") -- ADDIU3
												or   (INST(15 downto 11) = "10011") -- LW
		else '1' & INST(4 downto 2)   when (INST(15 downto 11) = "11100") -- ADDU / SUBU
		else "0001"							when (INST(15 downto 8) = "01100011") -- ADDSP
											   or   (INST(15 downto 8) = "01100100") -- MTSP
		else "0010"							when (INST(15 downto 11) = "11110" and INST(0) = '1') -- MTIH
		else "0011"							when (INST(15 downto 11) = "11101" and INST(4 downto 0) = "01010") -- CMP
												or   (INST(15 downto 11) = "01110") -- CMPI
												or   (INST(15 downto 11) = "01011") -- SLTUI
		else "0100"							when (INST(15 downto 11) = "11101" and INST(7 downto 0) = "11000000") -- JALR
		else "0000";
		
	WriteDataSrc <=
							'1' when INST(15 downto 11) = "11010"
					else  '0';
	
end Behavioral;

