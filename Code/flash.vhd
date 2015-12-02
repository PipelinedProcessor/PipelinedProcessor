----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:15 12/02/2015 
-- Design Name: 
-- Module Name:    flash - Behavioral 
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Flash is
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
end Flash;


architecture Behavioral of flash is

Signal addr : std_logic_vector(15 downto 0) := (others=>'0');

begin

	process(clk,rst)
	begin
		if rst = '0' then
			booting <= '1';
			flash_byte <= '1';
			flash_vpen <= '1';
			flash_rp <= '1';
			flash_ce <= '1';
			flash_oe <= '1';
			flash_we <= '1';
			flash_data <= (others=>'Z');
			flash_addr <= (others=>'0');
			addr <= (others=>'0');
		elsif rising_edge(clk) then
			if addr < X"400" then
				booting <= '1';
				flash_ce <= '0';
				flash_oe <= '0';
				flash_addr <= "000000" & addr;
				flash_data <= (others=>'Z');
				addr <= addr + 1;
			else
				booting <= '0';
			end if;
		end if;
	end process;
end Behavioral;

