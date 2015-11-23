----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:59:49 11/20/2015 
-- Design Name: 
-- Module Name:    REG_ID_EXE - Behavioral 
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
--clk: ʱ�������ظ���������
--stall: ��stallΪ1ʱ��ʱ������������������ԭֵ

--control signal
--MemRead��
--MemWrite
--Mem2Reg
--ALUOp
--ALUSrc2
--RegDst
    
--data
--regData1: IH, SP, RD1, PCPlus1��ѡһѡ������Data
--regData2: RD2
--extendData: ������չ�������

entity REG_ID_EXE is
    Port(
        rst, clk, stall: in std_logic;
        --control signal
        MemReadD: in std_logic;
        MemWriteD: in std_logic;
        Mem2RegD: in std_logic;
        ALUOpD: in std_logic_vector(3 downto 0);
        ALUSrc2D: in std_logic;
        RegDstD: in std_logic_vector(3 downto 0);
        WriteDataSrcD : in STD_LOGIC;
        --data
        regData1D: in std_logic_vector(15 downto 0); 
        regData2D: in std_logic_vector(15 downto 0); 
        extendDataD: in std_logic_vector(15 downto 0); 
        SPoutD : in STD_LOGIC_VECTOR(15 downto 0);
				RxD : in STD_LOGIC_VECTOR(15 downto 0);
        --control signal
        MemReadE: out std_logic;
        MemWriteE: out std_logic;
        Mem2RegE: out std_logic;
        ALUOpE: out std_logic_vector(3 downto 0);
        ALUSrc2E: out std_logic;
        RegDstE: out std_logic_vector(3 downto 0);
        WriteDataSrcE : out STD_LOGIC;
        --data
        regData1E: out std_logic_vector(15 downto 0); 
        regData2E: out std_logic_vector(15 downto 0); 
        extendDataE: out std_logic_vector(15 downto 0);
        SPoutE : out STD_LOGIC_VECTOR(15 downto 0);
        RxE : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture Behavioral of REG_ID_EXE is
    --control signal
    signal MemRead: std_logic; 
    signal MemWrite: std_logic;
    signal Mem2Reg: std_logic;
    signal ALUOp: std_logic_vector(3 downto 0);
    signal ALUSrc2: std_logic;
    signal RegDst: std_logic_vector(3 downto 0);
    signal WriteDataSrc : STD_LOGIC;
    
    --data
    signal regData1: std_logic_vector(15 downto 0); 
    signal regData2: std_logic_vector(15 downto 0); 
    signal extendData: std_logic_vector(15 downto 0); 
    signal SPout : STD_LOGIC_VECTOR(15 downto 0);
		signal Rx : STD_LOGIC_VECTOR(15 downto 0);
begin
    --control signal
    MemReadE <= MemRead;
    MemWriteE <= MemWrite;
    Mem2RegE <= Mem2Reg;
    ALUOpE <= ALUOp;
    ALUSrc2E <= ALUSrc2;
    RegDstE <= RegDst;
    WriteDataSrcE <= WriteDataSrc;
    
    --data
    regData1E <= regData1;
    regData2E <= regData2;
    extendDataE <= extendData;
    SPoutE <= SPout;
		RxE <= Rx;
    
    process(rst, clk, stall)
    begin
        if rst = '0' then -- �첽����
            --control signal
            MemRead <= '0';
            MemWrite <= '0';
            Mem2Reg <= '0';
            ALUOp <= (others => '0');
            ALUSrc2 <= '0';
            RegDst <= (others => '0');
            WriteDataSrc <= '0';
            
            regData1 <= (others => '0');
            regData2 <= (others => '0');
            extendData <= (others => '0');
            SPout <= (others => '0');
						Rx <= (others => '0');
        elsif rising_edge(clk) then
            if stall = '0' then
                --control signal
                MemRead <= MemReadD;
                MemWrite <= MemWriteD;
                Mem2Reg <= Mem2RegD;
                ALUOp <= ALUOpD;
                ALUSrc2 <= ALUSrc2D;
                RegDst <= RegDstD;
                WriteDataSrc <= WriteDataSrcD;
                
                --data
                regData1 <= regData1D;
                regData2 <= regData2D;
                extendData <= extendDataD;
                SPout <= SPoutD;
                Rx <= RxD;
            else    --doing nothing
                --control signal
                MemRead <= MemRead;
                MemWrite <= MemWrite;
                Mem2Reg <= Mem2Reg;
                ALUOp <= ALUOp;
                ALUSrc2 <= ALUSrc2;
                RegDst <= RegDst;
                WriteDataSrc <= WriteDataSrc;
                
                --data
                regData1 <= regData1;
                regData2 <= regData2;
                extendData <= extendData;
                SPout <= SPout;
								Rx <= Rx;
            end if;
        
        end if;
    end process;
    
end Behavioral;