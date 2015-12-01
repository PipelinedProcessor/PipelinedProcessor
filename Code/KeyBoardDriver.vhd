----------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity KeyBoardDriver is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           keyboard_clk : in  STD_LOGIC;
           keyboard_data : in  STD_LOGIC;

           read_ready : in  STD_LOGIC;

           BF02 : out  STD_LOGIC_VECTOR(15 downto 0);
           BF03 : out  STD_LOGIC_VECTOR(15 downto 0);
           key1 : out  STD_LOGIC_VECTOR(6 downto 0);
           key2 : out  STD_LOGIC_VECTOR(6 downto 0);
			  l : out  STD_LOGIC
         );
end KeyBoardDriver;

architecture Behavioral of KeyBoardDriver is
    signal scancode : STD_LOGIC_VECTOR(7 downto 0);
    signal data : STD_LOGIC_VECTOR(7 downto 0);
    signal break_code : STD_LOGIC; 
    signal data_ready: STD_LOGIC;
    
    component top is
        Port(
            datain, clkin : in  STD_LOGIC;
            fclk, rst_in: in  STD_LOGIC;
				scancode : out  STD_LOGIC_VECTOR(7 downto 0);
            seg0, seg1:out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

begin
    keyboard : top port map( keyboard_data, keyboard_clk, clk, rst, scancode, key1, key2 );

    BF02(15 downto 8) <= X"00";
		BF02(7 downto 0) <= X"61" when data = X"1C"      --a
												else X"62" when data = X"32" --b
												else X"63" when data = X"21" --c
												else X"64" when data = X"23" --d
												else X"65" when data = X"24" --e
												else X"66" when data = X"2B" --f
												else X"67" when data = X"34" --g
												else X"68" when data = X"33" --h
												else X"69" when data = X"43" --i
												else X"6A" when data = X"3B" --j
												else X"6B" when data = X"42" --k
												else X"6C" when data = X"4B" --l
												else X"6D" when data = X"3A" --m
												else X"6E" when data = X"31" --n
												else X"6F" when data = X"44" --o
												else X"70" when data = X"4D" --p
												else X"71" when data = X"15" --q
												else X"72" when data = X"2D" --r
												else X"73" when data = X"1B" --s
												else X"74" when data = X"2C" --t
												else X"75" when data = X"3C" --u
												else X"76" when data = X"2A" --v
												else X"77" when data = X"1D" --w
												else X"78" when data = X"22" --x
												else X"79" when data = X"35" --y
												else X"7A" when data = X"1A" --z
												else X"00";

   BF03 <= (1=>data_ready, others=>'0');

	 data_ready <= '0' when read_ready = '1' or rst = '0'
						else '1' when falling_edge(break_code) and rst = '1'
	 	            else data_ready;
	 l<= break_code;
	 
	 process(scancode, rst)
	 begin
	     if scancode = X"F0" and rst = '1' then
				break_code <= '1';
		  else
			   break_code <= '0';
		  end if;
	 end process;
	
	 --break_code <= '1' when scancode = X"F0"
	 --             else '0';
	
	 data <= (others => '0') when rst = '0'
	         else scancode when falling_edge(break_code) and rst = '1';
				
end Behavioral;
