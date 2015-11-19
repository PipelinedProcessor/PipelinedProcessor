----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
    Port ( clk : in STD_LOGIC;
         -- signals
					 MemReadM : in STD_LOGIC;
					 MemWriteM : in STD_LOGIC;
				 -- data 
		       inALUOutM : in STD_LOGIC_VECTOR(15 downto 0);
		       outALUOutM : out STD_LOGIC_VECTOR(15 downto 0);

					 WriteDataM : in STD_LOGIC_VECTOR(15 downto 0);
		       ReadDataM : out STD_LOGIC_VECTOR(15 downto 0);
 
					 inWriteRegM : in STD_LOGIC_VECTOR(15 downto 0);
					 outWriteRegM : out STD_LOGIC_VECTOR(15 downto 0);
				 -- pins
					 ram1addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram1data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1en : out  STD_LOGIC;

		       dyp0 : out  STD_LOGIC_VECTOR (6 downto 0));

end Memory;

architecture Behavioral of Memory is
	  signal clockTag : STD_LOGIC := '0';
		signal writeSignal : STD_LOGIC;
		signal readSignal : STD_LOGIC; -- 以上两者为第一个下降沿来临时的信号种类

begin

	outALUOutM <= inALUOutM;
	outWriteRegM <= inWriteRegM;

	ram1addr(17 downto 16) <= "00"; -- pin
	ram1en <= '0'; -- pin

	process(clk)
		if clk'event then
			if clockTag = '0' then
				
				if clk = '1' then -- 第一个上升沿
					ram1oe <= '1';
					ram1we <= '1';
				else -- 第一个下降沿
					readSignal <= MemReadM;
					writeSignal <= MemWriteM; -- 认为不会出现两者同时为1的情况
    
					ram1addr(15 downto 0) <= inALUOutM; -- pin
					if MemWriteM = '1' then
						ram1data(15 downto 0) <= WriteDataM; -- pin
					end if;

				end if;

			else
				
				if clk = '1' then -- 第二个上升沿
					ram1oe <= not MemReadM;
					ram1we <= not MemWriteM;
				else -- 第二个下降沿
					if ram1oe = '0' then
						ram1data <= (others => 'Z');
					elsif ram1we = '0' then -- 出现读写冲突bug时，优先读
						ram1we <= '1';
					end if;
				end if;

			end if;
		end if;
	end process;

end Behavioral;
