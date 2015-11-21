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

           stallF : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR(15 downto 0);
           PCPlus1 : out STD_LOGIC_VECTOR(15 downto 0);
          
           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC;

           dyp0 : out  STD_LOGIC_VECTOR (6 downto 0));

end InstructionFetch;

architecture Behavioral of InstructionFetch is
    component BufferLatch is
        Port ( clk, rst, stall : in STD_LOGIC;
               signal_in : in STD_LOGIC_VECTOR(15 downto 0);
               signal_out : out STD_LOGIC_VECTOR(15 downto 0));
    end component;

    signal PC : STD_LOGIC_VECTOR(15 downto 0);
    signal PCPlus1F : STD_LOGIC_VECTOR(15 downto 0);
    signal nextPC : STD_LOGIC_VECTOR(15 downto 0);
begin

    PCPlus1F <= (PC + "1") when rst = '1'
                else (others => '0');
    nextPC <= PCPlus1F;
    PCPlus1 <= PCPlus1F; -- out

    L0: BufferLatch port map(clk, rst, stallF, nextPC, PC);

    ram2addr(17 downto 16) <= "00"; -- pin
    ram2addr(15 downto 0) <= PC; -- pin
		ram2data <= (others => 'Z');
    instr <= ram2data;
    dyp0 <= ram2data(6 downto 0);

    ram2en <= not rst; -- pin
    ram2oe <= clk; -- pin
    ram2we <= '1'; -- pin
end Behavioral;
