----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:57 11/30/2015 
-- Design Name: 
-- Module Name:    charGen - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity charGen is
   port(
      clk: in std_logic;
		rst: in std_logic;
		wen : in std_logic;
		wdata : in std_logic_vector(15 downto 0);
      waddr : in std_logic_vector(11 downto 0);
		x, y : in std_logic_vector(9 downto 0);
		r, g, b : out std_logic_vector(2 downto 0)
		--output: out std_logic_vector(15 downto 0)
   );
end charGen;

architecture Behavioral of charGen is
component font_rom
	port(
		clk: in std_logic;
		addr: in std_logic_vector(10 downto 0);
		data: out std_logic_vector(7 downto 0)
	);
end component;

component vgamemory
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;

	Constant H_PIXELS:  STD_LOGIC_VECTOR(9 downto 0):="1010000000";--640
	Constant V_PIXELS:   STD_LOGIC_VECTOR(9 downto 0):="0111100000";--480
	
	Signal font_rom_addr:STD_LOGIC_VECTOR(10 downto 0);
	Signal bit_reg1,bit_reg2:STD_LOGIC_VECTOR(2 DOWNTO 0);
	Signal fontout:std_logic_vector(7 downto 0);
	Signal dout:std_logic_vector(15 downto 0);
	Signal wea:std_logic_vector(0 downto 0);
	Signal raddr:std_logic_vector(11 downto 0);
	Signal nrst: STD_LOGIC;
	Signal pixel: STD_LOGIC;
	Signal color: STD_LOGIC_VECTOR(8 downto 0);
begin
	nrst <= not rst;
	wea(0) <= wen;
	font_rom_addr <= dout(6 downto 0) & y(3 downto 0);
	font_unit:font_rom
	port map(
		clk, font_rom_addr, fontout
	);
	
	--raddrtest <= "000000001010";
	raddr <= y(8 downto 4) & x(9 downto 3);
	char_mem_unit:vgamemory
	port map(
		clk, wea, waddr, wdata,
		clk, nrst, raddr, dout
	);
	--output <= dout;
	
	process (clk) -- delay 2 periods, 1 for char_mem access, 1 for font_mem access
	begin
		if(rising_edge(clk)) then
			bit_reg1 <= x(2 downto 0);
			bit_reg2 <= bit_reg1;
			color <= dout(15 downto 7);
		end if;
	end process;
	
	pixel <= fontout(conv_integer(not bit_reg2)) when x < H_PIXELS and y < V_PIXELS and x > 1 and y > 1
		else   '0';
	--r <= (others => pixel);
	r(2) <= pixel and color(8);
	r(1) <= pixel and color(7);
	r(0) <= pixel and color(6);
	g(2) <= pixel and color(5);
	g(1) <= pixel and color(4);
	g(0) <= pixel and color(3);
	b(2) <= pixel and color(2);
	b(1) <= pixel and color(1);
	b(0) <= pixel and color(0);
	--g <= (others => pixel);
	--b <= (others => pixel);
	
end Behavioral;

