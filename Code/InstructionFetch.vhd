----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionFetch is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           -- cmd in
           stallF : in STD_LOGIC;
		       NBranchD : in STD_LOGIC;
		       TBranchD : in STD_LOGIC;
		       BranchD : in STD_LOGIC;
		       DirectJmpD : in STD_LOGIC;
		       -- data in
		       ToutD : in STD_LOGIC;
		       RxEZD : in STD_LOGIC; -- rx = '0' in ID part
		       PCBranchD : in STD_LOGIC_VECTOR(15 downto 0);
           -- data out
           InstrF : out STD_LOGIC_VECTOR(15 downto 0);
           PCPlus1F : out STD_LOGIC_VECTOR(15 downto 0);
          
           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC
          );

end InstructionFetch;

architecture Behavioral of InstructionFetch is
    component BufferLatch is
        Port ( clk, rst, stall : in STD_LOGIC;
               signal_in : in STD_LOGIC_VECTOR(15 downto 0);
               signal_out : out STD_LOGIC_VECTOR(15 downto 0));
    end component;

    signal PC : STD_LOGIC_VECTOR(15 downto 0);
    signal PCPlus1 : STD_LOGIC_VECTOR(15 downto 0);
    signal nextPC : STD_LOGIC_VECTOR(15 downto 0);
begin

    PCPlus1 <= (PC + "1") when rst = '1'
               else (others => '0');
    nextPC <= PCBranchD when DirectJmpD = '1'
	                       or (NBranchD = '1' and RxEZD = '0')
							     or (BranchD = '1' and RxEZD = '1')
								  or (TBranchD = '1' and ToutD = '1')
						  else PCPlus1;
    PCPlus1F <= PCPlus1; -- out

    L0: BufferLatch port map(clk, rst, stallF, nextPC, PC);

    ram2addr(17 downto 16) <= "00"; -- pin
    ram2addr(15 downto 0) <= PC; -- pin
		ram2data <= (others => 'Z');
    InstrF <= ram2data;

    ram2en <= not rst; -- pin
    ram2oe <= clk; -- pin
    ram2we <= '1'; -- pin
end Behavioral;
