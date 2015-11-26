----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:48 11/25/2015 
-- Design Name: 
-- Module Name:    COM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COM is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           BusData : in  STD_LOGIC_VECTOR (7 downto 0);
           -- BusData : inout  STD_LOGIC_VECTOR (7 downto 0);
           ComAddr : in  STD_LOGIC;
           ComreadSignal : in  STD_LOGIC;
           ComwriteSignal : in  STD_LOGIC;
           ComRdata : out  STD_LOGIC_VECTOR (7 downto 0);
           -- ComWdata : in  STD_LOGIC_VECTOR (7 downto 0);
           ComRdn : out  STD_LOGIC;
           ComWrn : out  STD_LOGIC;
           ComdataReady : in  STD_LOGIC;
           ComTbre : in  STD_LOGIC;
           ComTsre : in  STD_LOGIC);
end COM;

architecture Behavioral of COM is

begin
    ComRdn <= not ComreadSignal or clk;
    ComWrn <= not ComwriteSignal or clk;
    ComRData <= (others => '0') when ComreadSignal = '0' or rst = '0'
                else  "000000" & ComdataReady & (ComTbre and ComTsre) when ComAddr = '1'
                else  BusData;

end Behavioral;

