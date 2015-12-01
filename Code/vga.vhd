----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:03:21 11/30/2015 
-- Design Name: 
-- Module Name:    vga - Behavioral 
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

entity vga is
    Port ( clk : in  STD_LOGIC;
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
end vga;
architecture Behavioral of vga is
component vga_controller is
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           hcounter : out  STD_LOGIC_VECTOR (9 downto 0);
           vcounter : out  STD_LOGIC_VECTOR (9 downto 0);
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC
			  );
	end component;

component charGen is
	port(
      clk: in std_logic;
		rst: in std_logic;
		wen : in std_logic;
		wdata : in std_logic_vector(15 downto 0);
      waddr : in std_logic_vector(11 downto 0);
      x : in std_logic_vector(9 downto 0); --col
      y : in std_logic_vector(9 downto 0);  --row
		r, g, b : out std_logic_vector(2 downto 0)
   );
	end component;

Signal hcnt,vcnt : STD_LOGIC_VECTOR (9 downto 0);

begin
	ucontroller : vga_controller port map (
		clk,rst,
		hcnt,vcnt,
		hsync,vsync
	);
	ucharGen : charGen port map (
		clk50, rst, en, 
		data, addr, 
		hcnt, vcnt,
		r, g, b
	);
end Behavioral;

