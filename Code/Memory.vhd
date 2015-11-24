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
           rst : in STD_LOGIC;
         -- signals
           MemReadM : in STD_LOGIC;
           MemWriteM : in STD_LOGIC;
         -- data 
           ALUOutM : in STD_LOGIC_VECTOR(15 downto 0);

           WriteDataM : in STD_LOGIC_VECTOR(15 downto 0);
           ReadDataM : out STD_LOGIC_VECTOR(15 downto 0);
         -- pins
           ram1addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram1data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1en : out  STD_LOGIC

               -- dyp0 : out  STD_LOGIC_VECTOR (6 downto 0)
         );
 
end Memory;

architecture Behavioral of Memory is
begin
    ram1addr(17 downto 16) <= "00"; -- pin
    ram1en <= not rst; -- pin
    ram1we <= not MemWriteM and rst;
    ram1oe <= not MemReadM and rst;
    ram1addr(15 downto 0) <= ALUOutM;
	  ram1data <= WriteDataM when MemWriteM = '1'
				    else (others => 'Z');
    ReadDataM <= ram1data;
    -- dyp0 <= ram1data(6 downto 0);
end Behavioral;
