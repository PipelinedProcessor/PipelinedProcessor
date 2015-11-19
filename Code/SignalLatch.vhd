----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignalLatch is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           signal_in : in STD_LOGIC;
           signal_out : out STD_LOGIC);
end SignalLatch;

architecture Behavioral of SignalLatch is
    signal clockTag : STD_LOGIC := '0'; -- 不同模块之间是否能保证其该Tag同步？
begin
    process(clk)
        if clk'event and clk = '1' then
            if clockTag ＝'0' then
                signal_out <= (not rst) and signal_in;
            end if;
            clockTag <= not clockTag;
        end if;
    end process;
end Behavioral;

