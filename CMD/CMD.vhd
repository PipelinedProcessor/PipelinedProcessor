-------------------------------------------------------------------------------
-- Company: PipelinedProcessor
-- Engineer: Yang Xiaocheng
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CMD is
    Port ( rst : in  STD_LOGIC; -- hand_control�，把写入数据的指针置�
      	-- hand_control�，把计算机所有状态置�
           clk : in  STD_LOGIC; -- 用于串口输入指令和指令写入寄存器
         -- pins
           ram1data : inout  STD_LOGIC_VECTOR (7 downto 0);
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1en : out  STD_LOGIC;

           ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
           ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2en : out  STD_LOGIC;
           
           SW : in STD_LOGIC_VECTOR(15 downto 0);
           data_ready : in  STD_LOGIC;
           rdn : out  STD_LOGIC;
           tbre, tsre : in  STD_LOGIC;
           wrn : out  STD_LOGIC;
           
           l : out  STD_LOGIC_VECTOR(15 downto 0) --  显示正在被操作的指令
         );
end CMD;

architecture Behavioral of CMD is
    component cmd2ram2
        Port ( clk, rst, cmd_start : in  STD_LOGIC;
               cmd_ready : out  STD_LOGIC;
               data : in  STD_LOGIC_VECTOR(15 downto 0);
               ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
               ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
               ram2oe, ram2we, ram2en : out  STD_LOGIC
             );
    end component;
 
    component COMRW is
        Port ( RW, start, Clock, rst: in  STD_LOGIC;
               SW : in  STD_LOGIC_VECTOR (15 downto 0);
               output : out  STD_LOGIC_VECTOR (15 downto 0);
               Ram1Data : inout  STD_LOGIC_VECTOR (7 downto 0);
               Ram1OE, Ram1WE, Ram1EN : out  STD_LOGIC;
               data_ready : in  STD_LOGIC;
               rdn : out  STD_LOGIC;
               tbre, tsre : in  STD_LOGIC;
               wrn, done : out  STD_LOGIC
              );
    end component;
 -- signals for read from serial port
    signal serial_start : STD_LOGIC; -- 上升沿触�
    signal serial_ready : STD_LOGIC;
    signal serial_rw : STD_LOGIC; -- 0 for read, 1 for write
 -- signal for write cmds to SRAM2
    signal cmd_start : STD_LOGIC; -- 上升沿触�
    signal cmd_ready : STD_LOGIC;
 -- 正在被操作的指令
    signal cmds : STD_LOGIC_VECTOR(15 downto 0);
   
begin
    l <= serial_start & serial_ready & cmd_start & cmd_ready & cmds(11 downto 0);
    serial_rw <= '0';
    cmd : cmd2ram2 port map (clk, rst, cmd_start, cmd_ready,
                             cmds, ram2addr, ram2data, ram2oe, ram2we, ram2en);
									 
    serial : COMRW port map (serial_rw, serial_start, clk, rst, SW, cmds,
                             ram1data, ram1oe, ram1we, ram1en,
                             data_ready, rdn, tbre, tsre, wrn, serial_ready);

    -- serial : 从串口中读取控制信号
    -- cmd : 将从串口中读出的控制信号写入ram2
    -- clk : 手按时钟
    -- 当reset后，cmd_ready和serial_ready均置零，此时打开hand_conrtro开关，首先serial_start被置�，运行完后serial_ready=1，此时以下两行使serial_start = 0 && cmd_start=1，开始执行写入内存。写入后cmd_ready=1，以下两行使cmd_start = 0 && serial_start=1，又开始新一轮操作。流程由hand_control和clk控制，可随时结束
    -- 模块cmd2ram2和COMRW需保证在start=1的上升沿将ready置零
    serial_start <= rst and ( cmd_ready or not serial_ready );
    cmd_start <= rst and serial_ready;

end Behavioral;
