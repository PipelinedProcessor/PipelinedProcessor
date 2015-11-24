----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ram is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
         -- signals
           readSignal : in STD_LOGIC;
           writeSignal : in STD_LOGIC;
         -- data 
           addr : in STD_LOGIC_VECTOR(15 downto 0);
           dataIn : in STD_LOGIC_VECTOR(15 downto 0);
           dataOut : out STD_LOGIC_VECTOR(15 downto 0);
         -- pins
           ramAddr : out  STD_LOGIC_VECTOR (17 downto 0);
           ramData : inout  STD_LOGIC_VECTOR (15 downto 0);
           ramOE : out  STD_LOGIC;
           ramWE : out  STD_LOGIC
         );
end Ram;

architecture Behavioral of Ram is
begin
    ramAddr <= "00" & addr;
    ramData <= dataIn when writeSignal = '1'
               else (others => 'Z');
    ramWE <= not writeSignal or clk;
    ramOE <= not readSignal or clk;
    dataOut <= ramData when rst = '1'
               else (others => '0');
end Behavioral;
