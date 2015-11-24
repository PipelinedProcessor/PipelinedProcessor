----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
      -- for IF
         -- data
           addrF : in  STD_LOGIC_VECTOR(15 downto 0);
           instrF : out  STD_LOGIC_VECTOR(15 downto 0);
      -- for MEM
         -- signals
           readSignalM : in  STD_LOGIC;
           writeSignalM : in  STD_LOGIC;
         -- data 
           addrM : in  STD_LOGIC_VECTOR(15 downto 0);
           dataInM : in  STD_LOGIC_VECTOR(15 downto 0);
           dataOutM : out  STD_LOGIC_VECTOR(15 downto 0);
      -- pins
           ram1Addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram1Data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram1OE : out  STD_LOGIC;
           ram1WE : out  STD_LOGIC;
           ram1EN : out  STD_LOGIC;
           
           ram2Addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2Data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2OE : out  STD_LOGIC;
           ram2WE : out  STD_LOGIC;
           ram2EN : out  STD_LOGIC;

           bubble : out  STD_LOGIC

         );
end Memory;

architecture Behavioral of Memory is
    component Ram is
        Port ( clk, rst : in STD_LOGIC;
               readSignal, writeSignal : in STD_LOGIC;
               addr, dataIn : in STD_LOGIC_VECTOR(15 downto 0);
               dataOut : out STD_LOGIC_VECTOR(15 downto 0);
               ramAddr : out  STD_LOGIC_VECTOR (17 downto 0);
               ramData : inout  STD_LOGIC_VECTOR (15 downto 0);
               ramOE, ramWE : out  STD_LOGIC
             );
    end component;

    signal readSignal1, readSignal2 : STD_LOGIC;
    signal writeSignal1, writeSignal2 : STD_LOGIC; 
    signal addr1, addr2 : STD_LOGIC_VECTOR(15 downto 0);
    signal dataIn1, dataIn2 : STD_LOGIC_VECTOR(15 downto 0);
    signal dataOut1, dataOut2 : STD_LOGIC_VECTOR(15 downto 0); 
begin
    ram1 : Ram port map (
              clk, rst, readSignal1, writeSignal1,
              addr1, dataIn1, dataOut1,
              ram1Addr, ram1Data, ram1OE, ram1WE
           ); -- 0x0~0x7FFFF mainly instructions
    ram2 : Ram port map (
              clk, rst, readSignal2, writeSignal2,
              addr2, dataIn2, dataOut2,
              ram2Addr, ram2Data, ram2OE, ram2WE
           ); -- data

    bubble <= '1' when addrM < X"8000"
              else '0';

    ram1EN <= not rst;
    ram2EN <= '1' when addrM < X"8000"
              else not rst;

    readSignal1 <= readSignalM when addrM < X"8000"
                   else '1';
    readSignal2 <= readSignalM;

    writeSignal1 <= writeSignalM when addrM < X"8000"
                    else '0';
    writeSignal2 <= writeSignalM;

    addr1 <= addrM when addrM < X"8000"
             else addrF;
    addr2 <= addrM;

    dataIn1 <= dataInM;
    dataIn2 <= dataInM;

    instrF <= dataOut1;
    dataOutM <= dataOut1 when addrM < X"8000"
                else dataOut2;
end Behavioral;
