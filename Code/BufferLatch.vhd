----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BufferLatch is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           signal_in : in STD_LOGIC_VECTOR(15 downto 0);
           signal_out : out STD_LOGIC(15 downto 0);
end BufferLatch;

architecture Behavioral of BufferLatch is
begin
    process(clk)
        if clk'event and clk = '1' then
            signal_out <= (not rst) and signal_in;
        end if;
    end process;
end Behavioral;

