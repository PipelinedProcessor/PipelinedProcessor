----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:07 11/20/2015 
-- Design Name: 
-- Module Name:    register - Behavioral 
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

--寄存器堆

--RegDst对应的寄存器编号
--8个通用寄存器：r0 1000; r1 1001; r2 1010; r3 1011; r4 1100; r5 1101; r6 1110; r7 1111
--4个特殊寄存器：SP 0001; IH 0010; T 0011; RA 0100;  
--不写回: 0000

--rst: 异步清零标志，当检测到rst为0时，所有寄存器清零
--clk: 主时钟
--A1：读取的通用寄存器编号
--A2：读取的通用寄存器编号
--RegDst：写回的寄存器编号
--RegDstData：写回的数据

--RD1：读出的通用寄存器A1的值
--RD2：读出的通用寄存器A2的值
--SP_out：读出的SP寄存器的值
--IH_out：读出的IH寄存器的值
--T_out：读出的T寄存器的值
--RA_out：读出的RA寄存器的值

entity reg_controller is
	port(
		rst, clk: in std_logic;
		A1, A2: in std_logic_vector(2 downto 0);
		RegDst: in std_logic_vector(3 downto 0);
		RegDstData: in std_logic_vector(15 downto 0);
		RD1, RD2, SP_out, IH_out, RA_out: out std_logic_vector(15 downto 0);
		T_out: out std_logic;
		l : out std_logic_vector(15 downto 0)
	);
end reg_controller;

architecture Behavioral of reg_controller is
	signal r0, r1, r2, r3, r4, r5, r6, r7: std_logic_vector(15 downto 0) := (others => '0');--通用寄存器
	signal SP, IH, RA: std_logic_vector(15 downto 0) := (others => '0');--特殊寄存器
	signal T: std_logic;--特殊寄存器
	
begin
	l <= r1;
	with A1 select
	RD1 <= r0 when "000",
			 r1 when "001",
			 r2 when "010",
			 r3 when "011",
			 r4 when "100",
			 r5 when "101",
			 r6 when "110",
			 r7 when "111",
			 (others => '0') when others;
	
	--读出RD2
	with A2 select
	RD2 <= r0 when "000",
			 r1 when "001",
			 r2 when "010",
			 r3 when "011",
			 r4 when "100",
			 r5 when "101",
			 r6 when "110",
			 r7 when "111",
			 (others => '0') when others;
	
	SP_out <= SP; --读出SP
	IH_out <= IH; --读出IH
	T_out  <= T;  --读出T
	RA_out <= RA; --读出RA
	
	--写回寄存器
	process(rst, clk, RegDst, RegDstData)
	begin
		if rst = '0' then  --异步清零（rst按下为0）
			r0 <= (others => '0');
			r1 <= (others => '0');
			r2 <= (others => '0');
			r3 <= (others => '0');
			r4 <= (others => '0');
			r5 <= (others => '0');
			r6 <= (others => '0');
			r7 <= (others => '0');
			SP <= (others => '0');
			IH <= (others => '0');
			T 	<= '0';
			RA <= (others => '0');
			
		elsif falling_edge(clk) then
			case RegDst is
				when "1000" => r0 <= RegDstData; --写回r0
				when "1001" => r1 <= RegDstData; --写回r1
				when "1010" => r2 <= RegDstData; --写回r2
				when "1011" => r3 <= RegDstData; --写回r3
				when "1100" => r4 <= RegDstData; --写回r4
				when "1101" => r5 <= RegDstData; --写回r5
				when "1110" => r6 <= RegDstData; --写回r6
				when "1111" => r7 <= RegDstData; --写回r7
				
				when "0001" => SP <= RegDstData; --写回SP
				when "0010" => IH <= RegDstData; --写回IH
				when "0011" => T  <= RegDstData(0); --写回T
				when "0100" => RA <= RegDstData; --写回RA
					
				when others => r0 <= r0;			--值不变
									r1 <= r1;
									r2 <= r2;
									r3 <= r3;
									r4 <= r4;
									r5 <= r5;
									r6 <= r6;
									r7 <= r7;
									
									SP <= SP;
									IH <= IH;
									T  <= T;
									RA <= RA;
			end case;
		
		end if;
	end process;

end Behavioral;










