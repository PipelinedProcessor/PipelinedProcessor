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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--rst: �첽�����־������⵽rstΪ0ʱ�����мĴ�������
--clk: ��ʱ�ӣ�������д��Ĵ���

--ALUSrc1: control signal
--ImmLen: control signal
--ImmExtend: control signal
--JumpDst: control signal

--A1����ȡ��ͨ�üĴ������
--A2����ȡ��ͨ�üĴ������
--RegDst��д�صļĴ������
--RegDstData��д�ص�����
--PCPlus1: PC+1

--E_3_0_in�� ����չ������������
--E_4_0_in�� ����չ������������
--E_4_2_in�� ����չ������������
--E_7_0_in�� ����չ������������
--E_10_0_in�� ����չ������������

--RA_out�� �����ͻ�������ȷ��RAֵ
--T_out�������ͻ���������ȷTֵ
--regData1������EXE�׶�Src1�ļĴ������ݣ��Ѿ��� �����ź�ALUSrc1 ��ɸѡ
--regData2������EXE�׶�Src2�ļĴ������ݣ�ֱ��ȡ��RD2
--ExtendChooseOut������չ���������Ѿ��� �����ź�ImmLen��ImmExtend ��ɸѡ
--SE_10_0_out��E_10_0_in ���ݵķ�����չ
--PCBranch: Ҫ��ת�ĵ�ַ

entity ID is
	port(
		rst: in std_logic;
		clk: in std_logic;
		
		--control signal
		ALUSrc1: in std_logic_vector(1 downto 0);
		ImmLen: in std_logic_vector(1 downto 0);
		ImmExtend: in std_logic;
		JumpDst: in std_logic_vector(1 downto 0);
		
		--slove conflict
		ForwardRA: in std_logic_vector(1 downto 0);
		ForwardT: in std_logic_vector(1 downto 0);
		ForwardSP: in std_logic_vector(1 downto 0);
		ForwardIH: in std_logic_vector(1 downto 0);
		ForwardRD1: in std_logic_vector(1 downto 0);
		ForwardRD2: in std_logic_vector(1 downto 0);
		
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
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
		
		T_out: out std_logic;
		RD1_out: out std_logic_vector(15 downto 0);
		regData1: out std_logic_vector(15 downto 0);
		regData2: out std_logic_vector(15 downto 0);
		ExtendChooseOut: out std_logic_vector(15 downto 0);
		PCBranch: out std_logic_vector(15 downto 0)
		
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
	
	component ChooseRASource is
	port(
		--control
		ForwardRA: in std_logic_vector(1 downto 0);
		
		RA: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRA: out std_logic_vector(15 downto 0)
	);	
	end component;
	
	component ChooseTSource is
	port(
		--control
		ForwardT: in std_logic_vector(1 downto 0);
		
		--data
		T: in std_logic;
		ALUResultE_0: in std_logic;
		MemtoRegChooseM_0: in std_logic;
		
		ChooseT: out std_logic
	);
	end component;
	
	component ChooseSPSource is
	port(
		--control
		ForwardSP: in std_logic_vector(1 downto 0);
		
		SP: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseSP: out std_logic_vector(15 downto 0)
	);	
	end component;

	component ChooseIHSource is
	port(
		--control
		ForwardIH: in std_logic_vector(1 downto 0);
		
		IH: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseIH: out std_logic_vector(15 downto 0)
	);	
	end component;
	
	component ChooseRD1Source is
	port(
		--control
		ForwardRD1: in std_logic_vector(1 downto 0);
		
		RD1: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD1: out std_logic_vector(15 downto 0)
	);	
	end component;
	
	component ChooseRD2Source is
	port(
		--control
		ForwardRD2: in std_logic_vector(1 downto 0);
		
		RD2: in std_logic_vector(15 downto 0);
		ALUResultE: in std_logic_vector(15 downto 0);
		MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
		ChooseRD2: out std_logic_vector(15 downto 0)
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
	
	component ID_Jump is
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
	end component;
	
	signal SE_3_0_out, SE_4_0_out, SE_4_2_out, SE_7_0_out: std_logic_vector(15 downto 0); 
	signal ZE_7_0_out: std_logic_vector(15 downto 0);
	signal Z_S_7_0_out: std_logic_vector(15 downto 0);
	signal SE_10_0: std_logic_vector(15 downto 0);
	
	signal RA: std_logic_vector(15 downto 0);
	signal ChooseRA: std_logic_vector(15 downto 0);
	
	signal T: std_logic;
	signal ChooseT: std_logic;
	
	signal SP: std_logic_vector(15 downto 0);
	signal ChooseSP: std_logic_vector(15 downto 0);
	
	signal IH: std_logic_vector(15 downto 0);
	signal ChooseIH: std_logic_vector(15 downto 0);
	
	signal RD1: std_logic_vector(15 downto 0);
	signal ChooseRD1: std_logic_vector(15 downto 0);
	
	signal RD2: std_logic_vector(15 downto 0);
	signal ChooseRD2: std_logic_vector(15 downto 0);
	
begin

	--���Ĵ���
	u1: reg_controller port map(rst, clk, A1, A2, RegDst, RegDstData, RD1, RD2, SP, IH, RA, T);
	
	--������·ѡ����
	u2: ChooseRASource port map(ForwardRA, RA, ALUResultE, MemtoRegChooseM, ChooseRA);
	u3: ChooseTSource port map(ForwardT, T, ALUResultE(0), MemtoRegChooseM(0), ChooseT);
	u4: ChooseSPSource port map(ForwardSP, SP, ALUResultE, MemtoRegChooseM, ChooseSP);
	u5: ChooseIHSource port map(ForwardIH, IH, ALUResultE, MemtoRegChooseM, ChooseIH);
	u6: ChooseRD1Source port map(ForwardRD1, RD1, ALUResultE, MemtoRegChooseM, ChooseRD1);
	u7: ChooseRD2Source port map(ForwardRD2, RD2, ALUResultE, MemtoRegChooseM, ChooseRD2);
	
	--regData1������ѡһѡ���������
	u8: regData1Choose port map(ALUSrc1, ChooseIH, ChooseSP, ChooseRD1, PCPlus1, regData1);
	
	--���regData2
	regData2 <= ChooseRD2;
	
	--���ChooseRD1
	RD1_out <= ChooseRD1;
	
	--���ChooseT
	T_out <= ChooseT;
	
	--��������չ
	u9: SignedExtend port map(E_3_0_in, E_4_0_in, E_4_2_in, E_7_0_in, E_10_0_in, SE_3_0_out, SE_4_0_out, SE_4_2_out, SE_7_0_out, SE_10_0);
	u10: ZeroExtend port map(E_7_0_in, ZE_7_0_out);
	u11: ZeroSignedChoose port map(ImmExtend, ZE_7_0_out, SE_7_0_out, Z_S_7_0_out);
	u12: ExtendChoose port map(ImmLen, SE_3_0_out, SE_4_0_out, SE_4_2_out, Z_S_7_0_out, ExtendChooseOut);
	
	--������ת
	u13: ID_Jump port map(JumpDst, SE_7_0_out, SE_10_0, ChooseRD1, ChooseRA, PCPlus1, PCBranch);
	
	
	
end Behavioral;

