----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:36 11/21/2015 
-- Design Name: 
-- Module Name:    ID - Behavioral 
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

--rst: �첽�����־������⵽rstΪ0ʱ�����мĴ�������
--clk: ��ʱ�ӣ�������д��Ĵ���

--ALUSrc1: control signal
--ImmLen: control signal
--ImmExtend: control signal

--A1����ȡ��ͨ�üĴ������
--A2����ȡ��ͨ�üĴ������
--RegDst��д�صļĴ������
--RegDstData��д�ص�����

--E_3_0_in�� ����չ������������
--E_4_0_in�� ����չ������������
--E_4_2_in�� ����չ������������
--E_7_0_in�� ����չ������������
--E_10_0_in�� ����չ������������

--RA_out�� RA�Ĵ��������
--T_out��T�Ĵ��������
--regData1������EXE�׶�Src1�ļĴ������ݣ��Ѿ��� �����ź�ALUSrc1 ��ɸѡ
--regData2������EXE�׶�Src2�ļĴ������ݣ�ֱ��ȡ��RD2
--ExtendChooseOut������չ���������Ѿ��� �����ź�ImmLen��ImmExtend ��ɸѡ
--SE_10_0_out��E_10_0_in ���ݵķ�����չ

entity ID is
	port(
		rst: in std_logic;
		clk: in std_logic;
		
		--control signal
		ALUSrc1: in std_logic_vector(1 downto 0);
		ImmLen: in std_logic_vector(1 downto 0);
		ImmExtend: in std_logic;
		
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		RegDst: in std_logic_vector(3 downto 0);
		RegDstData: in std_logic_vector(15 downto 0);
		PCPlus1: in std_logic_vector(15 downto 0);
		
		E_3_0_in: in std_logic_vector(3 downto 0);
		E_4_0_in: in std_logic_vector(4 downto 0); 
		E_4_2_in: in std_logic_vector(4 downto 2); 
		E_7_0_in: in std_logic_vector(7 downto 0); 
		E_10_0_in: in std_logic_vector(10 downto 0);
		
		RA_out: out std_logic_vector(15 downto 0);
		T_out: out std_logic;
		regData1: out std_logic_vector(15 downto 0);
		regData2: out std_logic_vector(15 downto 0);
		ExtendChooseOut: out std_logic_vector(15 downto 0);
		SE_10_0_out: out std_logic_vector(15 downto 0)
		
	);
end ID;

architecture Behavioral of ID is

	component reg_controller is
	port(
		rst, clk: in std_logic;
		A1, A2: in std_logic_vector(2 downto 0);
		RegDst: in std_logic_vector(3 downto 0);
		RegDstData: in std_logic_vector(15 downto 0);
		RD1, RD2, SP_out, IH_out, RA_out: out std_logic_vector(15 downto 0);
		T_out: out std_logic
	);
	end component;
	
	component regData1Choose is
	port(
		--control signal
		ALUSrc1: in std_logic_vector(1 downto 0);
		
		IH, SP, RD1, PCPlus1: in std_logic_vector(15 downto 0);
		regData1: out std_logic_vector(15 downto 0)
	);
	end component;
	
	component SignedExtend is
	port(
		SE_3_0_in: in std_logic_vector(3 downto 0);
		SE_4_0_in: in std_logic_vector(4 downto 0); 
		SE_4_2_in: in std_logic_vector(4 downto 2); 
		SE_7_0_in: in std_logic_vector(7 downto 0); 
		SE_10_0_in: in std_logic_vector(10 downto 0);
			
		SE_3_0_out: out std_logic_vector(15 downto 0);
		SE_4_0_out: out std_logic_vector(15 downto 0);
		SE_4_2_out: out std_logic_vector(15 downto 0);
		SE_7_0_out: out std_logic_vector(15 downto 0);
		SE_10_0_out: out std_logic_vector(15 downto 0)
	);
	end component;
	
	component ZeroExtend is
	port(
		ZE_7_0_in: in std_logic_vector(7 downto 0);
		ZE_7_0_out: out std_logic_vector(15 downto 0)
	);
	end component;
	
	component ZeroSignedChoose is
	port(
		--control signal
		ImmExtend: in std_logic;
		
		ZE_7_0: in std_logic_vector(15 downto 0);
		SE_7_0: in std_logic_vector(15 downto 0);
		Z_S_7_0_out: out std_logic_vector(15 downto 0) 
	);
	end component;
	
	component ExtendChoose is
	port(
		--control signal
		ImmLen: in std_logic_vector(1 downto 0);
		
		SE_3_0: in std_logic_vector(15 downto 0);
		SE_4_0: in std_logic_vector(15 downto 0); 
		SE_4_2: in std_logic_vector(15 downto 0);
		Z_S_7_0: in std_logic_vector(15 downto 0);
		
		ExtendChooseOut: out std_logic_vector(15 downto 0)
	);
	end component;
	
	signal RD1, SP_out, IH_out: std_logic_vector(15 downto 0);
	signal SE_3_0_out, SE_4_0_out, SE_4_2_out, SE_7_0_out: std_logic_vector(15 downto 0); 
	signal ZE_7_0_out: std_logic_vector(15 downto 0);
	signal Z_S_7_0_out: std_logic_vector(15 downto 0);
	
begin
	
	u1: reg_controller port map(rst, clk, A1, A2, RegDst, RegDstData, RD1, regData2, SP_out, IH_out, RA_out, T_out);
	u2: regData1Choose port map(ALUSrc1, IH_out, SP_out, RD1, PCPlus1, regData1);
	
	u3: SignedExtend port map(E_3_0_in, E_4_0_in, E_4_2_in, E_7_0_in, E_10_0_in, SE_3_0_out, SE_4_0_out, SE_4_2_out, SE_7_0_out, SE_10_0_out);
	u4: ZeroExtend port map(E_7_0_in, ZE_7_0_out);
	u5: ZeroSignedChoose port map(ImmExtend, ZE_7_0_out, SE_7_0_out, Z_S_7_0_out);
	u6: ExtendChoose port map(ImmLen, SE_3_0_out, SE_4_0_out, SE_4_2_out, Z_S_7_0_out, ExtendChooseOut);
	
end Behavioral;

