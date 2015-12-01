----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:06:26 11/30/2015 
-- Design Name: 
-- Module Name:    vga_controller - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_controller is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           hcounter : out  STD_LOGIC_VECTOR (9 downto 0);
           vcounter : out  STD_LOGIC_VECTOR (9 downto 0);
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC);
end vga_controller;

architecture Behavioral of vga_controller is
	Constant H_PIXELS:  STD_LOGIC_VECTOR(9 downto 0):="1010000000";--640
	Constant H_SYNCDOWN:   STD_LOGIC_VECTOR(9 downto 0):="1010010000";--656
	Constant H_SYNCUP:STD_LOGIC_VECTOR(9 downto 0):="1011110000";--752
	Constant H_MAX:  STD_LOGIC_VECTOR(9 downto 0):="1100100000";--800
	
	Constant V_PIXELS:   STD_LOGIC_VECTOR(9 downto 0):="0111100000";--480
	Constant V_SYNCDOWN:   STD_LOGIC_VECTOR(9 downto 0):="0111101010";--490
	Constant V_SYNCUP:STD_LOGIC_VECTOR(9 downto 0):="0111101100";--492
	Constant V_MAX:  STD_LOGIC_VECTOR(9 downto 0):="1000001101";--525
	
	Signal hcnt,vcnt : STD_LOGIC_VECTOR(9 downto 0);
begin
	hcounter <= hcnt;
	vcounter <= vcnt;
	
	-- counter controller
	process(clk,rst)
	begin
		if rst = '0' then
			hcnt <= (others => '0');
			vcnt <= (others => '0');
		elsif rising_edge(clk) then
			if hcnt < H_MAX then
				hcnt <= hcnt + 1;
			else
				hcnt <= (others => '0');
				if vcnt < V_MAX then
					vcnt <= vcnt + 1;
				else
					vcnt <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	
	-- sync controller
	vsync <= '1' when rst = '0' 
						 or vcnt <  V_SYNCDOWN
						 or vcnt >= V_SYNCUP
		else   '0';
	
	hsync <= '1' when rst = '0'
						 or hcnt <  H_SYNCDOWN
						 or hcnt >= H_SYNCUP
		else	 '0';
	
end Behavioral;

