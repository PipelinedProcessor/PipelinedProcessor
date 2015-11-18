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
begin
    process(clk)
        if clk'event and clk = '1' then
            signal_out <= (not rst) and signal_in;
        end if;
    end process;
end Behavioral;

