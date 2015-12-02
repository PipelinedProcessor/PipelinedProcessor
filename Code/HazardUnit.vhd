----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:49:49 11/23/2015 
-- Design Name: 
-- Module Name:    HazardUnit - Behavioral 
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

--HazardUnit位置：ID段

--RegDstE: EXE阶段的RegDst控制信号，即上条指令的RegDst控制信号
--MemReadE: EXE阶段的MemReadE控制信号，即上条指令的MemReadE控制信号
--ALUSrc1： 当前指令产生的控制信号ALUSrc1
--ALUSrc2: 当前指令产生的控制信号ALUSrc2
--bubble： 当bubble置'1'时，插入气泡

--A1：读取的通用寄存器编号(rs)
--A2：读取的通用寄存器编号(rt)

--stallF: PC阶段寄存器保持不变
--stallD: reg_IF_ID阶段寄存器保持不变
--FlushE: reg_ID_EXE阶段寄存器清零

entity HazardUnit is
	port(
		rst: in std_logic;
		clk: in std_logic;--主时钟
		Interrupt: in std_logic;--中断信号，当Interrupt为0时，代表产生中断
		
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
		FlushE: out std_logic;
		UseInterruptINST: out std_logic; -- 1--执行InterruptINST  0--执行指令内存
		InterruptINST: out std_logic_vector(15 downto 0)
	);
end HazardUnit;

architecture Behavioral of HazardUnit is
	signal needLWBubble: BOOLEAN;
	type state is (peaceful, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12);
	signal current_state, next_state: state := peaceful;
begin
	
	needLWBubble <= MemReadE = '1' 	--上条是 读内存到寄存器 指令（LW, LW_SP）
				 and (						--且 本条读的寄存器 与 上条写的寄存器 相同
							--（本条为SW_SP（要将RD1写入内存） 或 本条RD1读通用寄存器） && 上条写通用寄存器 && 通用寄存器相同
							( (INST_15_11 = "11010" or ALUSrc1 = "00") and RegDstE(3) = '1' and A1 = RegDstE(2 downto 0) ) 
							--本条RD1读SP寄存器 && 上条写SP寄存器
						or	( ALUSrc1 = "01" and RegDstE = "0001" ) 
						
						--（本条为SW（要将RD2写入内存） 或 本条RD2读通用寄存器） && 上条写通用寄存器 && 通用寄存器相同
						or ( (INST_15_11 = "11011" or ALUSrc2 = '0') and RegDstE(3) = '1' and A2 = RegDstE(2 downto 0) ) 
					  ); 
	
	--输出stallF, stallD, FlushE
	process(bubble, needLWBubble, current_state)
	begin
		if (bubble = '1' or needLWBubble) then
			stallF <= '1';
			stallD <= '1';
			FlushE <= '1';
			UseInterruptINST <= '0'; 
			
		elsif 	current_state = I0 or current_state = I1 or current_state = I2 or current_state = I3
				or current_state = I4 or current_state = I5 or current_state = I6 or current_state = I7 
				or current_state = I8 or current_state = I9 or current_state = I10 or current_state = I11  then 
			stallF <= '1';
			stallD <= '0';
			FlushE <= '0';
			UseInterruptINST <= '1';
			
		elsif current_state = I12 then
			stallF <= '0';
			stallD <= '0';
			FlushE <= '0';
			UseInterruptINST <= '1';
			
		else
			stallF <= '0';
			stallD <= '0';
			FlushE <= '0';
			UseInterruptINST <= '0'; 
		
		end if;
	
	end process;
	
	process (rst, Interrupt, clk)
	begin
		if rst = '0' then 
			current_state <= peaceful;
		elsif Interrupt = '0' then
			current_state <= I0;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	--输出InterruptINST
	process(current_state, bubble, needLWBubble, Interrupt)
	begin
		case current_state is
		
			when peaceful => 	
				next_state <= peaceful; 
				InterruptINST <= (others => '0');
									
			when I0 => 	
				if (bubble = '1' or needLWBubble) then
					next_state <= I0;
				else
					next_state <= I1; 
				end if;
				InterruptINST <= X"0800";
							
			when I1 => 	
				next_state <= I2;
				InterruptINST <= X"0800";
							
			when I2 => 	
				next_state <= I3; 
				InterruptINST <= X"D6FD";
							
			when I3 => 	
				next_state <= I4;
				InterruptINST <= X"6E00";
			
			when I4 => 	
				next_state <= I5;
				InterruptINST <= X"D6FE";
			
			when I5 => 	
				next_state <= I6;
				InterruptINST <= X"EE40";
				
			when I6 => 	
				next_state <= I7;
				InterruptINST <= X"4EFF";
				
			when I7 => 	
				next_state <= I8;
				InterruptINST <= X"D6FF";
				
			when I8 => 	
				next_state <= I9;
				InterruptINST <= X"96FD";
				
			when I9 => 	
				next_state <= I10;
				InterruptINST <= X"63FE";
				
			when I10 => 	
				next_state <= I11;
				InterruptINST <= X"6E11";
				
			when I11 => 	
				next_state <= I12;
				InterruptINST <= X"EE00";
				
			when I12 => 	
				next_state <= peaceful;
				InterruptINST <= X"0800";
				
		end case;
	end process;
	
end Behavioral;

