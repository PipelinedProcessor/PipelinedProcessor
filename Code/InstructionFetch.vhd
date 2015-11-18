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
           stallF : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR(15 downto 0);
           PCPlus4 : out STD_LOGIC_VECTOR(15 downto 0);
          
           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC;

           dyp0 : out  STD_LOGIC_VECTOR (6 downto 0));

end InstructionFetch;

architecture Behavioral of InstructionFetch is
    component BufferLatch is
        Port ( clk, rst : in STD_LOGIC;
               signal_in : in STD_LOGIC_VECTOR(15 downto 0);
               signal_out : out STD_LOGIC_VECTOR(15 downto 0));
    end component;

    signal PC : STD_LOGIC_VECTOR(15 downto 0);
    signal PCPlus4F : STD_LOGIC_VECTOR(15 downto 0);
    signal nextPC : STD_LOGIC_VECTOR(15 downto 0);

    signal clockTag : STD_LOGIC;

begin

    PCPlus4F <= PC + '1';
    nextPC <= PCPlus4F;
    PCPlus4 <= PCPlus4F; -- out

    L0: BufferLatch port map( clk(clk), rst(stallF), signal_in(nextPC), signal_out(PC) );

    ram2addr(17 downto 16) <= "00"; -- pin
    ram2addr(15 downto 0) <= PC; -- pin

    ram2en <= '0'; -- pin
    ram2oe <= '0'; -- pin
    ram2we <= '1'; -- pin

--    process(clk)
--        if clk'event then
--            if clk = '1' then
--                instr <= ram2data; -- out
--                PC <= nextPC;
--            else
--                ram2data <= (others => 'Z'); -- pin
--            end if;
--        end if;
--    end process;

    process(clk)
        if clk'event and clk = '1' then
            if clockTag = '1' then
                instr <= ram2data; --out
                PC <= nextPC;
            else
                ram2data <= (others => 'Z'); -- pin
            end if;
            clockTag <= not clockTag;
        end if;
    end process;

end Behavioral;
