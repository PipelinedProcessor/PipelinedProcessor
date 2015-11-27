------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Processor is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ram1addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram1data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1en : out  STD_LOGIC;

           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC;

           rdn : out STD_LOGIC;
           wrn : out STD_LOGIC;
			  ComdataReady, ComTbre, ComTsre : in STD_LOGIC;

           l : out  STD_LOGIC_VECTOR(15 downto 0)
         );
end Processor;

architecture Behavioral of Processor is
 -- ****** ******
   component InstructionFetch is
        Port ( clk, rst, stallF : in STD_LOGIC;
               NBranchD, TBranchD, BranchD, DirectJmpD : in STD_LOGIC;
               ToutD, RxEZD : in STD_LOGIC;
               PCBranchD : in STD_LOGIC_VECTOR(15 downto 0);
               PCPlus1F : out STD_LOGIC_VECTOR(15 downto 0);
               PCF : out STD_LOGIC_VECTOR(15 downto 0)
             );
    end component;
    -- cmd in (Command in)
    signal stallF : STD_LOGIC;
    signal BranchD, NBranchD, TBranchD, DirectJmpD : STD_LOGIC;
    -- data in
    signal ToutD : STD_LOGIC;
    signal RxEZD : STD_LOGIC;
    signal RxD : STD_LOGIC_VECTOR(15 downto 0);
    signal PCBranchD : STD_LOGIC_VECTOR(15 downto 0);
    -- data out
    signal InstrF : STD_LOGIC_VECTOR(15 downto 0);
    signal PCPlus1F : STD_LOGIC_VECTOR(15 downto 0);
      -- for Memory Unit
    signal PCF : STD_LOGIC_VECTOR(15 downto 0); 
 -- ****** ******
    component REG_IF_ID is
        Port ( rst, clk, stall: in std_logic;
               InstrF, PCPlus1F: in std_logic_vector(15 downto 0);
               InstrD, PCPlus1D: out std_logic_vector(15 downto 0)
             );
    end component;
    -- cmd in
    signal stallD : STD_LOGIC;
    -- data in (defined before)
    -- signal InstrF : STD_LOGIC_VECTOR(15 downto 0);
    -- signal PCPlus1F : STD_LOGIC_VECTOR(15 downto 0);
 -- ****** ******
    component ID is
        Port( rst, clk: in std_logic;     
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
    end component;
	 
    
	
	component ForwardUnit is
		port(
				--旁路传回的控制信号
				RegDstE: in std_logic_vector(3 downto 0);
				RegDstM: in std_logic_vector(3 downto 0);
		
				A1: in std_logic_vector(2 downto 0);
				A2: in std_logic_vector(2 downto 0);
		
				--给出的选择信号
				ForwardRA: out std_logic_vector(1 downto 0);
				ForwardT: out std_logic_vector(1 downto 0);
				ForwardSP: out std_logic_vector(1 downto 0);
				ForwardIH: out std_logic_vector(1 downto 0);
				ForwardRD1: out std_logic_vector(1 downto 0);
				ForwardRD2: out std_logic_vector(1 downto 0)
			);
	end component;
	 
	 
	 component HazardUnit is
			port(
					--control signal
					RegDstE: in std_logic_vector(3 downto 0);
					MemReadE: in std_logic;
					ALUSrc1: in std_logic_vector(1 downto 0);
					ALUSrc2: in std_logic;
					bubble: in std_logic;
		
					A1: in std_logic_vector(2 downto 0);
					A2: in std_logic_vector(2 downto 0);
					INST_15_11: in std_logic_vector(4 downto 0);
	
					stallF: out std_logic;
					stallD: out std_logic;
					FlushE: out std_logic
				);
		end component;
	 
	 
    -- cmd in
    signal ALUSrc1D: STD_LOGIC_VECTOR(1 downto 0);
    signal ImmLenD: STD_LOGIC_VECTOR(1 downto 0);
    signal ImmExtendD: STD_LOGIC;
		signal JumpDstD : STD_LOGIC_VECTOR(1 downto 0);
    -- data in
    signal InstrD, PCPlus1D : STD_LOGIC_VECTOR(15 downto 0);
    signal RegDstW : STD_LOGIC_VECTOR(3 downto 0);
    signal RegDstDataW : STD_LOGIC_VECTOR(15 downto 0);
    -- data out
      -- used before (in IF module)
    -- signal RxD : STD_LOGIC_VECTOR(15 downto 0);
    -- signal ToutD : STD_LOGIC;
		-- signal PCBranchD: out std_logic_vector(15 downto 0);
    signal Src1D : STD_LOGIC_VECTOR(15 downto 0);
    signal Src2D : STD_LOGIC_VECTOR(15 downto 0);
    signal ImmD : STD_LOGIC_VECTOR(15 downto 0);
	 
	 
	 --hy add
	 signal FlushE: STD_LOGIC;
	 signal ForwardRAD: std_logic_vector(1 downto 0);
	 signal ForwardTD: std_logic_vector(1 downto 0);
	 signal ForwardSPD: std_logic_vector(1 downto 0);
	 signal ForwardIHD: std_logic_vector(1 downto 0);
	 signal ForwardRD1D: std_logic_vector(1 downto 0);
	 signal ForwardRD2D: std_logic_vector(1 downto 0);
 -- ****** ******
    component controller is
        Port ( INST : in  STD_LOGIC_VECTOR (15 downto 0);
               Branch, NBranch, TBranch, DirectJmp, MemRead, MemWrite, MemtoReg : out STD_LOGIC;
               ALUSrc1 : out STD_LOGIC_VECTOR (1 downto 0);
               ALUSrc2 : out STD_LOGIC;
               ALUOp : out STD_LOGIC_VECTOR (3 downto 0);
               ImmExtend : out STD_LOGIC;
               ImmLen : out STD_LOGIC_VECTOR (1 downto 0);
               JumpDst : out STD_LOGIC_VECTOR (1 downto 0);
               RegDst : out STD_LOGIC_VECTOR (3 downto 0);
               WriteDataSrc : out STD_LOGIC
             );
    end component;
    -- data in (defined before)
    -- signal InstrD
    -- cmd out
        -- used in IF module (defined before)
    -- signal BranchD, NBranchD, TBranchD, DirectJmpD : STD_LOGIC;
        -- used in ID module (defined before)
    -- signal ALUSrc1D: STD_LOGIC_VECTOR(1 downto 0);
    -- signal ImmLenD: in STD_LOGIC_VECTOR(1 downto 0);
    -- signal ImmExtendD: in STD_LOGIC;
		-- signal JumpDstD : STD_LOGIC_VECTOR(1 downto 0);
        -- used in later module
    signal MemReadD : STD_LOGIC;
    signal MemWriteD : STD_LOGIC;
    signal Mem2RegD : STD_LOGIC;
    signal ALUOpD : STD_LOGIC_VECTOR(3 downto 0);
    signal ALUSrc2D : STD_LOGIC;
    signal RegDstD : STD_LOGIC_VECTOR(3 downto 0);
    signal WriteDataSrcD : STD_LOGIC;
 -- ****** ******
    component REG_ID_EXE is
        Port(
            rst, clk, stall, flush: in std_logic;

            MemReadD, MemWriteD, Mem2RegD: in std_logic;
            ALUOpD: in std_logic_vector(3 downto 0);
            ALUSrc2D: in std_logic;
            RegDstD: in std_logic_vector(3 downto 0);
            WriteDataSrcD : in STD_LOGIC;

            regData1D, regData2D, extendDataD, RxD: in std_logic_vector(15 downto 0); 
            
            MemReadE, MemWriteE, Mem2RegE: out std_logic;
            ALUOpE: out std_logic_vector(3 downto 0);
            ALUSrc2E: out std_logic;
            RegDstE: out std_logic_vector(3 downto 0);
            WriteDataSrcE : out STD_LOGIC;
            
            regData1E, regData2E, extendDataE, RxE: out std_logic_vector(15 downto 0)
        );
    end component;
    -- cmd in
    signal stallE : STD_LOGIC; -- TODO: would be future replaced by flushE 
        -- define before
    -- signal MemReadD : STD_LOGIC;
    -- signal MemWriteD : STD_LOGIC;
    -- signal Mem2RegD : STD_LOGIC;
    -- signal 
    -- signal ALUOpD : STD_LOGIC_VECTOR(3 downto 0);
    -- signal ALUSrc2D : STD_LOGIC;
    -- signal RegDstD : STD_LOGIC_VECTOR(3 downto 0);
    -- signal WriteDataSrcD : STD_LOGIC;
    -- cmd out 
    signal MemReadE : STD_LOGIC;
    signal MemWriteE : STD_LOGIC;
    signal Mem2RegE : STD_LOGIC;
    signal ALUOpE : STD_LOGIC_VECTOR(3 downto 0);
    signal ALUSrc2E : STD_LOGIC;
    signal RegDstE : STD_LOGIC_VECTOR(3 downto 0);
    signal WriteDataSrcE : STD_LOGIC;
    -- data in (defined before)
    -- signal Src1D : STD_LOGIC_VECTOR(15 downto 0);
    -- signal Src2D : STD_LOGIC_VECTOR(15 downto 0);
    -- signal ImmD : STD_LOGIC_VECTOR(15 downto 0);
    -- signal SPoutD : STD_LOGIC_VECTOR(15 downto 0);
    -- signal RxD : STD_LOGIC_VECTOR(15 downto 0);
    -- data out
    signal Src1E : STD_LOGIC_VECTOR(15 downto 0);
    signal Src2E : STD_LOGIC_VECTOR(15 downto 0);
    signal ImmE : STD_LOGIC_VECTOR(15 downto 0);
    signal RxE : STD_LOGIC_VECTOR(15 downto 0);
 -- ****** ******
    component EXE is
        Port ( Rx, imm, Src1, Ry: in std_logic_vector (15 downto 0);
               op: in std_logic_vector(3 downto 0);
               WriteDataSrc: in std_logic; -- control signal to select which reg to write back to memory
               ALUSrc2: in std_logic; -- control signal to select if ry or imm is the second source for ALU
               ALUResult: out std_logic_vector(15 downto 0);
               WriteData: out std_logic_vector(15 downto 0)
          --l : out STD_LOGIC_VECTOR(15 downto 0)
             );
    end component;

    -- cmd in (define before)
    -- signal ALUSrc2E : STD_LOGIC;
    -- signal ALUOpE : STD_LOGIC_VECTOR(3 downto 0);
    -- signal WriteDataSrcE : STD_LOGIC;
    -- data in (defined before)
    -- signal Src1E : STD_LOGIC_VECTOR(15 downto 0);
    -- signal Src2E : STD_LOGIC_VECTOR(15 downto 0);
    -- signal ImmE : STD_LOGIC_VECTOR(15 downto 0);
    -- signal SPoutE : STD_LOGIC_VECTOR(15 downto 0);
    -- signal RxE : STD_LOGIC_VECTOR(15 downto 0);
    -- data out
    signal ALUOutE : STD_LOGIC_VECTOR(15 downto 0);
    signal WriteDataE : STD_LOGIC_VECTOR(15 downto 0);
 -- ****** ******
    component REG_EXE_MEM is
        Port ( rst, clk, stall: in std_logic;
               MemReadE, MemWriteE, Mem2RegE: in std_logic;
               RegDstE: in std_logic_vector(3 downto 0);
        
               ALUOutE, WriteDataE: in std_logic_vector(15 downto 0);
        
               MemReadM, MemWriteM, Mem2RegM: out std_logic;
               RegDstM: out std_logic_vector(3 downto 0);
        
               ALUOutM, WriteDataM: out std_logic_vector(15 downto 0)
             );
    end component;
    -- cmd in
    signal stallM : STD_LOGIC;
        -- defined before
    -- signal MemReadE, MemWriteE, Mem2RegE : STD_LOGIC;
    -- signal RegDstE : STD_LOGIC_VECTOR(3 downto 0);
    -- cmd out
    signal MemReadM, MemWriteM, Mem2RegM : STD_LOGIC;
    signal RegDstM : STD_LOGIC_VECTOR(3 downto 0);
    -- data in (defined before)
    -- signal ALUOutE : STD_LOGIC_VECTOR(15 downto 0);
    -- signal WriteDataE : STD_LOGIC_VECTOR(15 downto 0); -- TODO: ryz not implemented yet
    -- data out
    signal ALUOutM, WriteDataM : STD_LOGIC_VECTOR(15 downto 0);
	 signal MemtoRegChooseM: STD_LOGIC_VECTOR(15 downto 0);
 -- ****** ******
    component Memory is
        Port ( clk, rst : in  STD_LOGIC;
               addrF : in  STD_LOGIC_VECTOR(15 downto 0);
               instrF : out  STD_LOGIC_VECTOR(15 downto 0);
               readSignalM, writeSignalM : in  STD_LOGIC; 
               addrM : in  STD_LOGIC_VECTOR(15 downto 0);
               dataInM : in  STD_LOGIC_VECTOR(15 downto 0);
               dataOutM : out  STD_LOGIC_VECTOR(15 downto 0);
               ram1Addr : out  STD_LOGIC_VECTOR (17 downto 0);
               ram1Data : inout  STD_LOGIC_VECTOR (15 downto 0);
               ram1OE, ram1WE, ram1EN : out  STD_LOGIC;     
               ram2Addr : out  STD_LOGIC_VECTOR (17 downto 0);
               ram2Data : inout  STD_LOGIC_VECTOR (15 downto 0);
               ram2OE, ram2WE, ram2EN : out  STD_LOGIC;
					
					ComRdn, ComWrn : out STD_LOGIC;
					ComdataReady, ComTbre, ComTsre : in STD_LOGIC;
					
               bubble : out  STD_LOGIC
            );
    end component;	
    -- cmd in (MEM part)
    -- signal readSignalM(MemReadM), writeSignalM(MemWriteM) : in  STD_LOGIC;
    -- cmd out
    signal bubble : STD_LOGIC;
    -- data in
      -- for IF part
      -- signal addrF(PCF) : STD_LOGIC_VECTOR(15 downto 0);
      -- for MEM part
      -- signal addrM(ALUOutM) : in  STD_LOGIC_VECTOR(15 downto 0);
      -- signal dataInM(WriteDataM) : in  STD_LOGIC_VECTOR(15 downto 0); 
	 -- data out
      -- for IF part 
      -- signal instrF(InstrF) : out  STD_LOGIC_VECTOR(15 downto 0);
      -- for MEM part (dataOutM)
      signal MemOutM : STD_LOGIC_VECTOR(15 downto 0); 
 -- ****** ******
    component REG_MEM_WB is
        Port ( rst, clk, stall: in std_logic;
					--control signal
					RegDstM: in std_logic_vector(3 downto 0);
					--data
					MemtoRegChooseM: in std_logic_vector(15 downto 0);
		
					--control signal
					RegDstW: out std_logic_vector(3 downto 0);
					--data
					MemtoRegChooseW: out std_logic_vector(15 downto 0)
             );
    end component;
	 
    -- cmd in
    signal stallW : STD_LOGIC;
        -- defined before
    -- signal Mem2RegM : STD_LOGIC;
    -- signal RegDstM : STD_LOGIC_VECTOR(3 downto 0);
    -- cmd out
    --signal Mem2RegW : STD_LOGIC;
        -- defined before in ID
    --signal RegDstW : STD_LOGIC_VECTOR(3 downto 0);
    -- data in (defined before)
    -- signal MemOutM, ALUOutM : STD_LOGIC_VECTOR(15 downto 0);
    -- data out
 -- ****** ******
    --component WriteBack is
    --    Port ( MemtoReg: in std_logic;
    --           MemOut, ALUOut : in std_logic_vector(15 downto 0);
    --           RegDstData: out std_logic_vector(15 downto 0) 
    --         );
    --end component;
    -- cmd in (defined before)
    -- signal Mem2RegW : STD_LOGIC;
    -- data in (defined before)
    -- signal MemOutW, ALUOutW : STD_LOGIC_VECTOR(15 downto 0);
    -- data out (defined before in ID)
    -- signal RegDstDataW : STD_LOGIC_VECTOR(15 downto 0);
 -- ****** ******
begin
	--l <= ComdataReady & ALUOutM(6 downto 0) & R1(7 downto 0);
    --l <= PCF(7 downto 0) & ALUOutM(15 downto 8);
	 l <= (ComTbre and ComTsre) & ALUOutE(14 downto 0);
	 --l <= (others => '0');
-- ****** IF ******
    --stallF <= '0';
    RxEZD <= '1' when RxD = X"0000"
             else '0';
    IFpart : InstructionFetch port map (
                            clk, rst, stallF,
                            NBranchD, TBranchD, BranchD, DirectJmpD,
                            ToutD, RxEZD, PCBranchD,
                            PCPlus1F, PCF
                        ); 
-- ****** IF2ID ******
    --stallD <= '0';
    IF2IDpart : REG_IF_ID port map (
                            rst, clk, stallD,
                            InstrF, PCPlus1F, InstrD, PCPlus1D
                        );
-- ****** ID ******
	
    IDpart : ID port map (  rst, clk,
                            ALUSrc1D, ImmLenD, ImmExtendD, JumpDstD,
									 ForwardRAD, ForwardTD, ForwardSPD, ForwardIHD, ForwardRD1D, ForwardRD2D,
									 ALUOutE, MemtoRegChooseM,
                            InstrD(10 downto 8), InstrD(7 downto 5),
                            RegDstW, RegDstDataW, PCPlus1D,
                            InstrD(3 downto 0), InstrD(4 downto 0), InstrD(4 downto 2),
                            InstrD(7 downto 0), InstrD(10 downto 0),
                            ToutD,
                            RxD, Src1D, Src2D, ImmD, PCBranchD
                        );
								
    Controlpart : controller port map (
                            InstrD, BranchD, NBranchD, TBranchD, DirectJmpD,
                            MemReadD, MemWriteD, Mem2RegD,
                            ALUSrc1D, ALUSrc2D, ALUOpD,
                            ImmExtendD, ImmLenD, JumpDstD, RegDstD, WriteDataSrcD
                        );
	
    ForwardUnitpart: ForwardUnit port map (
							RegDstE, RegDstM,
							InstrD(10 downto 8), InstrD(7 downto 5), 
							ForwardRAD, ForwardTD, ForwardSPD, ForwardIHD, ForwardRD1D, ForwardRD2D
						);

    HazardUnitpart: HazardUnit port map (
                            RegDstE, MemReadE, ALUSrc1D, ALUSrc2D, bubble,
									 InstrD(10 downto 8), InstrD(7 downto 5), InstrD(15 downto 11), 
									 stallF, stallD, FlushE
                        );
								
								
-- ****** ID2EXE ******
    stallE <= '0';
    ID2EXEpart : REG_ID_EXE port map (
                            rst, clk, stallE, FlushE, 
                            MemReadD, MemWriteD, Mem2RegD,
                            ALUOpD, ALUSrc2D, RegDstD, WriteDataSrcD,
                            Src1D, Src2D, ImmD, RxD,
                            MemReadE, MemWriteE, Mem2RegE,
                            ALUOpE, ALUSrc2E, RegDstE, WriteDataSrcE,
                            Src1E, Src2E, ImmE, RxE
                        );
-- ****** EXE ******
	--l <= ImmE(3 downto 0) & MemWriteM & WriteDataM(2 downto 0) & RegDstDataW(3 downto 0) & ALUOutM(3 downto 0);
    EXEpart : EXE port map ( RxE, ImmE, Src1E, Src2E,
                             ALUOpE, WriteDataSrcE, ALUSrc2E,
                             ALUOutE, WriteDataE
                           );
-- ****** EXE2MEM ******
	 --l <= ALUOutM;
    stallM <= '0';
    EXE2MEMpart : REG_EXE_MEM port map (
                            rst, clk, stallM,
                            MemReadE, MemWriteE, Mem2RegE, RegDstE,
                            ALUOutE, WriteDataE,
                            MemReadM, MemWriteM, Mem2RegM, RegDstM,
                            ALUOutM, WriteDataM
                        );
-- ****** Mem ******
    Mempart : Memory port map (
                            clk, rst, 
                            PCF, InstrF,
                            MemReadM, MemWriteM,
                            ALUOutM, WriteDataM, MemOutM,
                            ram1addr, ram1data, ram1oe, ram1we, ram1en,
                            ram2addr, ram2data, ram2oe, ram2we, ram2en,
									 
									 rdn,wrn,
									 ComdataReady, ComTbre, ComTsre,
									 
                            bubble
                        );
	with Mem2RegM select
		MemtoRegChooseM <= MemOutM when '1',
								 ALUOutM when '0',
								 (others => '0') when others;
	
-- ****** MEM2WB ******
	
    stallW <= '0';
    MEM2WBpart : REG_MEM_WB port map (
                            rst, clk, stallW,
                            RegDstM, MemtoRegChooseM, 
                            RegDstW, RegDstDataW
                        );
-- ****** WB *******
    --WBpart : WriteBack port map (Mem2RegW, MemOutW, ALUOutW, RegDstDataW);
-- ****** ******
end Behavioral;
