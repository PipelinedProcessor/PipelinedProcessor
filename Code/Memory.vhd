----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------

-- Memory address allocation:
-- 0000~3FFF ram2: system instruction
-- 4000~7FFF ram2: user instruction
-- 8000~BEFF ram1: user memory
-- BF00~BF0F input/output devices communications
-- BF10~BFFF ram1: system memory
-- A000~AFFF block_memory: graphic memory for vga
-- D000~FFFF not used yet

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
    Port ( clk : in  STD_LOGIC;
			  clk50 : in STD_LOGIC;
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
        
           ComRdn, ComWrn : out STD_LOGIC;
           ComdataReady, ComTbre, ComTsre : in STD_LOGIC;
			  
			  vgahsync, vgavsync : out STD_LOGIC;
			  vgaR, vgaG, vgaB : out STD_LOGIC_VECTOR (2 downto 0);
			 
					 -- for keyboard
           keyboard_clk : in  STD_LOGIC;
           keyboard_data : in  STD_LOGIC;
           key1 : out  STD_LOGIC_VECTOR(6 downto 0);
           key2 : out  STD_LOGIC_VECTOR(6 downto 0); 
           -- end for
			  
			  flash_byte : out std_logic;
			  flash_vpen : out std_logic;
			  flash_rp : out std_logic;
			  flash_ce : out std_logic;
			  flash_oe : out std_logic;
			  flash_we : out std_logic;
			  flash_addr : out std_logic_vector(21 downto 0);
			  flash_data : inout std_logic_vector(15 downto 0);
        
           bubble : out  STD_LOGIC--;
           --l : out  STD_LOGIC_VECTOR(15 downto 0)
         );
end Memory;

architecture Behavioral of Memory is
	 component Flash is
		port(
			clk, rst : in std_logic;
			flash_byte : out std_logic;
			flash_vpen : out std_logic;
			flash_rp : out std_logic;
			flash_ce : out std_logic;
			flash_oe : out std_logic;
			flash_we : out std_logic;
			flash_addr : out std_logic_vector(21 downto 0);
			flash_data : inout std_logic_vector(15 downto 0);
			booting : out std_logic
			);
		end component;
    component Ram is
        Port ( clk, rst : in STD_LOGIC;
               readSignal, writeSignal : in STD_LOGIC;
               addr : in STD_LOGIC_VECTOR(15 downto 0);
          -- dataIn : in STD_LOGIC_VECTOR(15 downto 0);
               dataOut : out STD_LOGIC_VECTOR(15 downto 0);
               ramAddr : out  STD_LOGIC_VECTOR (17 downto 0);
               ramData : in  STD_LOGIC_VECTOR (15 downto 0);
               -- ramData : inout  STD_LOGIC_VECTOR (15 downto 0); -- out is assigned in Memory
               ramOE, ramWE : out  STD_LOGIC
             );
    end component;

    component COM is
         Port ( clk : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               BusData : in  STD_LOGIC_VECTOR (7 downto 0); 
                -- BusData : inout  STD_LOGIC_VECTOR (7 downto 0); -- out is assigned in Memory
               ComAddr : in  STD_LOGIC;
               ComreadSignal : in  STD_LOGIC;
               ComwriteSignal : in  STD_LOGIC;
               ComRdata : out  STD_LOGIC_VECTOR (7 downto 0);
               -- ComWdata : in  STD_LOGIC_VECTOR (7 downto 0);
               ComRdn : out  STD_LOGIC;
               ComWrn : out  STD_LOGIC;
               ComdataReady : in  STD_LOGIC;
               ComTbre : in  STD_LOGIC;
               ComTsre : in  STD_LOGIC
             );
    end component;
	 
	 component vga is
		Port (  clk : in  STD_LOGIC;
				  clk50 : in STD_LOGIC;
				  rst : in  STD_LOGIC;
				  addr : in STD_LOGIC_VECTOR (11 downto 0);
				  data : in STD_LOGIC_VECTOR (15 downto 0);
				  en : in  STD_LOGIC;
				  hsync : out  STD_LOGIC;
				  vsync : out  STD_LOGIC;
				  r : out  STD_LOGIC_VECTOR (2 downto 0):=(others => '0');
				  g : out  STD_LOGIC_VECTOR (2 downto 0):=(others => '0');
				  b : out  STD_LOGIC_VECTOR (2 downto 0):=(others => '0')
		);
	 end component;

    signal readSignal1, readSignal2, readSignalC, clk125, clk6125 : STD_LOGIC;
    signal writeSignal1, writeSignal2, writeSignalC, writeSignalV : STD_LOGIC; 
    signal addr1, addr2 : STD_LOGIC_VECTOR(15 downto 0);
    signal dataIn1, dataIn2, dataInV: STD_LOGIC_VECTOR(15 downto 0);
    signal dataOut1, dataOut2 : STD_LOGIC_VECTOR(15 downto 0); 
    signal dataInC, dataOutC : STD_LOGIC_VECTOR(7 downto 0);
	 signal addrV : STD_LOGIC_VECTOR(11 downto 0);
	 signal addrFlash : STD_LOGIC_VECTOR(21 downto 0);

	  -- for keyboard data
    signal keyboard_read_ready : STD_LOGIC;
    signal BF02 : STD_LOGIC_VECTOR(15 downto 0);
    signal BF03 : STD_LOGIC_VECTOR(15 downto 0);
	 signal booting : STD_LOGIC;

    component KeyBoardDriver is
        Port ( clk : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               keyboard_clk : in  STD_LOGIC;
               keyboard_data : in  STD_LOGIC;

               read_ready : in  STD_LOGIC;

               BF02 : out  STD_LOGIC_VECTOR(15 downto 0);
               BF03 : out  STD_LOGIC_VECTOR(15 downto 0);
               key1 : out  STD_LOGIC_VECTOR(6 downto 0);
               key2 : out  STD_LOGIC_VECTOR(6 downto 0)
             );
    end component;
    -- end for keyboard

begin
    ram1 : Ram port map (
              clk, rst, readSignal1, writeSignal1,
              addr1, dataOut1,
              ram1Addr, ram1Data, ram1OE, ram1WE
           );
    ram1data <= "ZZZZZZZZ" & dataInC when writeSignalC = '1'
                else dataIn1 when writeSignal1 = '1'
                else (others => 'Z'); -- writeSignalC is prior to writeSignal1
    

    ram2 : Ram port map (
              clk, rst, readSignal2, writeSignal2,
              addr2, dataOut2,
              ram2Addr, ram2Data, ram2OE, ram2WE
           );
    ram2Data <= dataIn2 when writeSignal2 = '1'
                else (others => 'Z');
   
    com1 : Com port map (
              clk, rst, ram1Data(7 downto 0), addrM(0), 
              readSignalC, writeSignalC, dataOutC, -- dataInC,
              ComRdn, ComWrn, ComdataReady, ComTbre, ComTsre
           );
	 
	 uvga : vga port map (
				  clk, clk50, rst,
				  addrV, dataInV, writeSignalV,
				  vgahsync, vgavsync,
				  vgaR, vgaG, vgaB
	 );
	 
	 uflash : flash port map (
				  clk6125, rst,
				  flash_byte, flash_vpen,
				  flash_rp, flash_ce, flash_oe, flash_we,
				  addrFlash, flash_data,
				  booting
	 );
	 
	 flash_addr <= addrFlash;
	 
	 process(clk)
	 begin
		if rising_edge(clk) then
			clk125 <= not clk125;
		end if;
	 end process;
	 
	 process(clk125)
	 begin
		if rising_edge(clk125) then
			clk6125 <= not clk6125;
		end if;
	end process;
	 
    bubble <= '1' when (addrM(15) = '0' 
                   and (writeSignalM = '1' or readSignalM = '1'))
						 or booting = '1'
              else '0';

    ram1EN <= '1' when rst = '0' or addrM(15 downto 4) = "101111110000"
              else '0';    
    ram2EN <= not rst;
    
    readSignal1 <= '0' when writeSignalM = '1' 
                         or addrM(15 downto 4) = "101111110000"
								 or booting = '1'
                   else '1';  
    readSignal2 <= '0' when (addrM(15) = '0' 
                        and writeSignalM = '1')
								or booting = '1'
                   else '1'; 
    readSignalC <= '1' when readSignalM = '1'
                        and addrM(15 downto 1) = "101111110000000"
                   else '0';

    writeSignal1 <= '0' when addrM(15) = '0'
                          or writeSignalM = '0'
                          or addrM(15 downto 4) = "101111110000"
								  or booting = '1'
                    else '1'; 
    writeSignal2 <= '1' when (addrM(15) = '0'
                         and writeSignalM = '1')
								 or booting = '1'
                    else '0';  
    writeSignalC <= '1' when writeSignalM = '1'
                         and addrM(15 downto 1) = "101111110000000"
                    else '0';
    writeSignalV <= '1' when writeSignalM = '1'
								 and addrM(15 downto 12) = "1010" -- A000~AFFF
						  else '0';
	 
		-- for keyboard data
    --l <= keyboard_read_ready & BF03(2 downto 0) & BF02(11 downto 0);
    keyboard_read_ready <= '1' when readSignalM = '1' and addrM = X"BF02"
									else '0';
    keyboard_driver : KeyBoardDriver port map (
              clk, rst, keyboard_clk, keyboard_data,
              keyboard_read_ready, BF02, BF03, key2, key1
            );
    -- end for keyboard

    addr2 <= addrM when addrM(15) = '0'
                    and (readSignalM = '1' or writeSignalM = '1')
				 else addrFlash(15 downto 0) when booting = '1'
             else addrF;
    addr1 <= addrM;
	 addrV <= addrM(11 downto 0);
	 
    dataIn1 <= dataInM;
    dataIn2 <= flash_data when booting = '1' 
			 else dataInM;
    dataInC <= dataInM(7 downto 0);
	 dataInV <= dataInM;
    instrF <= dataOut2;
    dataOutM <= dataOut2 when addrM(15) = '0' and readSignalM = '1'
                else "00000000" & dataOutC when addrM(15 downto 1) = "101111110000000" and readSignalM = '1'
								-- for keyboard data
                else BF02 when readSignalM = '1' and addrM = X"BF02"
                else BF03 when readSignalM = '1' and addrM = X"BF03"
                -- end for keyboard
					 else dataOut1;
end Behavioral;
