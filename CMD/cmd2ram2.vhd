----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- clk 手按时钟
-- cmd_start 输入，为1时将数据写入ram2
-- cmd_ready 输出，表示已写入数据

entity cmd2ram2 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
         -- signals
           cmd_start : in  STD_LOGIC;
           cmd_ready : out  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR(15 downto 0);
         -- pins
           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC);
end cmd2ram2;

architecture Behavioral of cmd2ram2 is
    type local_states is (l0, l1, l2, l3);
    signal local_state : local_states := l0;
    signal pointer : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
    ram2oe <= '1';
    ram2addr(17 downto 0) <= "00" & pointer; -- pin

    process(clk, cmd_start, rst)
    begin
        if clk'event and clk = '1' and cmd_start = '1' and rst = '1' then
            case local_state is
                when l0 => -- write establishment time
                    cmd_ready <= '0';
                    ram2en <= '0';
                    ram2we <= '1';
                    ram2data <= data;
                    local_state <= l1;
                    cmd_ready <= '0';
                when l1 =>
                    ram2we <= '0';
                    local_state <= l2;
                    cmd_ready <= '0';
                when l2 => -- write keep time
                    ram2we <= '1';
                    local_state <= l3;
                    cmd_ready <= '0';
                when l3 =>
                    cmd_ready <= '1';
                    pointer <= pointer + '1';
                    ram2en <= '1';
                    local_state <= l0;
                    cmd_ready <= '1';
            end case;
        end if;

        if rst = '0' then
            pointer <= (others => '0');
            local_state <= l0;
            ram2en <= '1';
            ram2we <= '1';
				cmd_ready <= '0';
        end if;

        if cmd_start = '0' then
            local_state <= l0;
            ram2en <= '1';
            ram2we <= '1';
        end if;

    end process;

end Behavioral;
