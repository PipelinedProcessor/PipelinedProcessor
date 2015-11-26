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

--�Ĵ�����

--RegDst��Ӧ�ļĴ������
--8��ͨ�üĴ�����r0 1000; r1 1001; r2 1010; r3 1011; r4 1100; r5 1101; r6 1110; r7 1111
--4������Ĵ�����SP 0001; IH 0010; T 0011; RA 0100;  
--��д��: 0000

--rst: �첽�����־������⵽rstΪ0ʱ�����мĴ�������
--clk: ��ʱ��
--A1����ȡ��ͨ�üĴ������
--A2����ȡ��ͨ�üĴ������
--RegDst��д�صļĴ������
--RegDstData��д�ص�����

--RD1��������ͨ�üĴ���A1��ֵ
--RD2��������ͨ�üĴ���A2��ֵ
--SP_out��������SP�Ĵ�����ֵ
--IH_out��������IH�Ĵ�����ֵ
--T_out��������T�Ĵ�����ֵ
--RA_out��������RA�Ĵ�����ֵ

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
	signal r0, r1, r2, r3, r4, r5, r6, r7: std_logic_vector(15 downto 0) := (others => '0');--ͨ�üĴ���
	signal SP, IH, RA: std_logic_vector(15 downto 0) := (others => '0');--����Ĵ���
	signal T: std_logic;--����Ĵ���
	
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
	
	--����RD2
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
	
	SP_out <= SP; --����SP
	IH_out <= IH; --����IH
	T_out  <= T;  --����T
	RA_out <= RA; --����RA
	
	--д�ؼĴ���
	process(rst, clk, RegDst, RegDstData)
	begin
		if rst = '0' then  --�첽���㣨rst����Ϊ0��
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
				when "1000" => r0 <= RegDstData; --д��r0
				when "1001" => r1 <= RegDstData; --д��r1
				when "1010" => r2 <= RegDstData; --д��r2
				when "1011" => r3 <= RegDstData; --д��r3
				when "1100" => r4 <= RegDstData; --д��r4
				when "1101" => r5 <= RegDstData; --д��r5
				when "1110" => r6 <= RegDstData; --д��r6
				when "1111" => r7 <= RegDstData; --д��r7
				
				when "0001" => SP <= RegDstData; --д��SP
				when "0010" => IH <= RegDstData; --д��IH
				when "0011" => T  <= RegDstData(0); --д��T
				when "0100" => RA <= RegDstData; --д��RA
					
				when others => r0 <= r0;			--ֵ����
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










