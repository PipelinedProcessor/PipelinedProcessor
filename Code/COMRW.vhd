----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:58:26 11/05/2015 
-- Design Name: 
-- Module Name:    chuankou - Behavioral 
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

entity COMRW is
    Port ( RW : in STD_LOGIC;
			  start : in STD_LOGIC;
			  Clock : in STD_LOGIC;
           SW : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           Ram1Data : inout  STD_LOGIC_VECTOR (7 downto 0);
           Ram1OE : out  STD_LOGIC;
           Ram1WE : out  STD_LOGIC;
           Ram1EN : out  STD_LOGIC;
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre : in  STD_LOGIC;
           tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
			  done : out  STD_LOGIC
			  );
end COMRW;

architecture Behavioral of COMRW is
type states is (s0,s1,s2,s3,s4,s5,s6,s7,s8,ss0);
signal current_state:states:=s0;
signal times:STD_LOGIC;
signal toReset,lastReset:STD_LOGIC;
begin

	
	process(start)
	begin
		if (rising_edge(start)) then
			toReset <= not toReset;
		end if;
	end process;
	
	process(Clock,current_state,Ram1Data,SW,data_ready,tbre,tsre)
	begin
		if (rising_edge(Clock)) then
			if toReset /= lastReset then
				lastReset <= toReset;
				times <= '0';
				done <= '0';
				if RW = '0' then
					current_state <= s0;
				else
					current_state <= s3;
				end if;
			else
				case current_state is
					when s0 =>
						Ram1EN <= '1';
						Ram1OE <= '1';
						Ram1WE <= '1';
						current_state <= ss0;
					when ss0 =>
						Ram1Data <= "ZZZZZZZZ";
						rdn <= '1';
						current_state <= s1;
					when s1 =>
						if data_ready = '1' then
							rdn <= '0';
							current_state <= s2;
						else
							current_state <= ss0;
						end if;
					when s2 =>
						if times = '0' then
							output(7 downto 0) <= Ram1Data;
							times <= '1';
							current_state <= ss0;
						else
							output(15 downto 8) <= Ram1Data;
							current_state <= s8;
							rdn <= '1';
						end if;
					when s3 =>
						Ram1Data <= "00000000";
						wrn <= '1';
						Ram1EN <= '1';
						Ram1OE <= '1';
						Ram1WE <= '1';
						current_state <= s4;				
					when s4 =>
						if times = '0' then
							Ram1Data <= SW(7 downto 0);
						else
							Ram1Data <= SW(15 downto 8);
						end if;
						wrn <= '0';
						current_state <= s5;
					when s5 =>
						wrn <= '1';
						current_state <= s6;
					when s6 =>
						if tbre = '1' then
							current_state <= s7;
						else current_state <= s6;
						end if;
					when s7 =>
						if tsre = '1' then
							if times = '1' then
								current_state <= s8;
							else
								times <= '1';
								current_state <= s3;
							end if;
						else current_state <= s7;
						end if;
					when others =>
						Ram1EN <= '0';
						Ram1OE <= '0';
						Ram1WE <= '0';
						done <= '1';
						current_state <= s8;
				end case;
			end if;
		end if;
	end process;
			
end Behavioral;

