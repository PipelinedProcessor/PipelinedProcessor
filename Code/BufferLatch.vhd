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
           stall : in STD_LOGIC;
           signal_in : in STD_LOGIC_VECTOR(15 downto 0);
           signal_out : out STD_LOGIC_VECTOR(15 downto 0));
end BufferLatch;

architecture Behavioral of BufferLatch is
    signal data : STD_LOGIC_VECTOR(15 downto 0); -- 不同模块之间是否能保证其该Tag同步�
begin
    signal_out <= data when rst = '1'
                  else (others => '0');

    process(clk, rst)
    begin
	     if rst = '0' then
            data <= (others => '0');
        elsif clk'event and clk = '1' and stall = '0' then
            data <= signal_in;
        end if;
    end process;
end Behavioral;
