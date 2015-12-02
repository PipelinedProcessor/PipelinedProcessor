ADDSP3 R0 0x0000
ADDSP3 R0 0x0000
NOP

;保存用户程序寄存器的地址 
;0xBF10  0xBF11 BF12 0xBF13 BF14 0xBF15
; R0    R1   R2   R3   R4   R5  

;download typing game
LI R0 0x200
LI R1 0x340
LI R2 0x5000
LW R0 R3 0X0
SW R2 R3 0X0
ADDIU R0 0x1
ADDIU R2 0x1
CMP R0 R1
BTEQZ 0x3
NOP
B 0x7F8
NOP

B START
NOP

DELINT:   ;中断处理程序
	NOP
	NOP
	NOP
	;保存用户程序现场
	LI R6 0xBF
	SLL R6 R6 0x0000
	ADDIU R6 0x10					;R6=0xBF10
	SW R6 R0 0x0000
	SW R6 R1 0x0001
	SW R6 R2 0x0002
	

	

	
	;R1=中断号
	LW_SP R1 0x0000
	ADDSP 0x0001
	LI R0 0x00FF
	AND R1 R0
	
	;R2=应用程序的pc
	LW_SP R2 0x0000
	ADDSP 0x0001
	
	;保存r3
	ADDSP 0xFFFF
	SW_SP R3 0x0000


	
	;保存用户程序返回地址
	ADDSP 0xFFFF
	SW_SP R7 0x0000
	
	;提示终端，进入中断处理
	LI R3 0x000F
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00
	SW R6 R3 0x0000
	NOP
	;输出中断号
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00 
	SW R6 R1 0x0000
	NOP
	
	;提示终端，中断处理结束
	LI R3 0x000F
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00 
	SW R6 R3 0x0000
	NOP
	
	;R6保存返回地址
	ADDIU3 R2 R6 0x0000
	
	;用r3=IH（高位变成1）
	MFIH R3
	LI R0 0x0080
	SLL R0 R0 0x000
	OR R3 R0
	
	;恢复现场
	LI R7 0xBF
	SLL R7 R7 0x0000
	ADDIU R7 0x10					;R7=0xBF10
	LW R7 R0 0x0000
	LW R7 R1 0x0001
	LW R7 R2 0x0002
	
	;r7=用户程序返回地址
	LW_SP R7 0x0000
	
	ADDSP 0x0001
	ADDSP 0x0001
	NOP
	MTIH R3;
	JR R6
	LW_SP R3 0x00FF
	
	NOP	


;init  0x8251
START:
	;初始化IH寄存器，最高位为1时，允许中断，为0时不允许。初始化为0，kernel不允许中断
	LI R0 0x07
	MTIH R0
	;初始化栈地址
	LI R0 0x00BF 
	SLL R0 R0 0x0000
	ADDIU R0 0x10					;R0=0xBF10 
	MTSP R0
	NOP
	
	;用户寄存器值初始化
	LI R6 0x00BF 
	SLL R6 R6 0x0000
	ADDIU R6 0x10					;R6=0xBF10 
	LI R0 0x0000
	SW R6 R0 0x0000
	SW R6 R0 0x0001
	SW R6 R0 0x0002
	SW R6 R0 0x0003
	SW R6 R0 0x0004
	SW R6 R0 0x0005
		
	;WELCOME
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LI R0 0x004F
	SW R6 R0 0x0000
	NOP
	
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LI R0 0x004B
	SW R6 R0 0x0000
	NOP
	
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LI R0 0x000A
	SW R6 R0 0x0000
	NOP
	
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LI R0 0x000D
	SW R6 R0 0x0000
	NOP
	

	

	

	
BEGIN:          ;检测命令
	;接收字符，保存到r1
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R1 0x0000
	LI R6 0x00ff 
  AND R1 R6 
	NOP	
	

	;检测是否为R命令		
	LI R0 0x0052
	CMP R0 R1
	BTEQZ SHOWREGS	
	NOP	
	;检测是否为D命令
	LI R0 0x0044
	CMP R0 R1
	BTEQZ SHOWMEM
	NOP	
	
	;检测是否为A命令
	LI R0 0x0041
	CMP R0 R1
	BTEQZ GOTOASM
	NOP	
	
	;检测是否为U命令
	LI R0 0x0055
	CMP R0 R1
	BTEQZ GOTOUASM
	NOP	
	;检测是否为G命令
	LI R0 0x0047
	CMP R0 R1
	BTEQZ GOTOCOMPILE
	NOP		
	
	B BEGIN
	NOP

;各处理块的入口
GOTOUASM:
	NOP
	B UASM
	NOP
GOTOASM:
	NOP
	B ASM
	NOP
	
GOTOCOMPILE:
	NOP
	B COMPILE
	NOP
  
	
;测试8251是否能写
TESTW:	
	NOP	 		
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	ADDIU R6 0x0001 
	LW R6 R0 0x0000 
	LI R6 0x0001 
	AND R0 R6 
	BEQZ R0 TESTW     ;BF01&1=0 则等待	
	NOP		
	JR R7
	NOP 
	

	
;测试8251是否能读
TESTR:	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	ADDIU R6 0x0001 
	LW R6 R0 0x0000 
	LI R6 0x0002
	AND R0 R6 
	BEQZ R0 TESTR   ;BF01&2=0  则等待	
	NOP	
	JR R7
	NOP 		
	
	
SHOWREGS:    ;R命令，打印R0-R5
	LI R1 0x0006  ;R1递减  
	LI R2 0x0006   ;R2不变
	
LOOP:
	LI R0  0x00BF
	SLL R0 R0 0x0000
	ADDIU R0 0x0010
	SUBU R2 R1 R3   ;R2=0,1,2,3
	ADDU R0 R3 R0   ;R0=BF10...
	LW R0 R3 0x0000    ;R3=用户程序的 R0,R1,R2	

	;发送低八位
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=BF00	
	SW R6 R3 0x0000	
	;发送高八位
	SRA R3 R3 0x0000
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	
	ADDIU R1 0xFFFF
	NOP
	BNEZ R1 LOOP
	NOP	
	B BEGIN
	NOP
	

	
	

	
	
	
SHOWMEM:  ;查看内存	
;D读取地址低位到r5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000	
	LI R6 0x00FF
	AND R5 R6
	NOP	
	
	;读取地址高位到r1
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R1 0x0000
	LI R6 0x00FF
	AND R1 R6
	NOP	
	
	
	
	;R1存储地址
	SLL R1 R1 0x0000
	OR R1 R5
	
	;读取显示次数低位到R5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	;读取显示次数高位到R2
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R2 0x0000
	LI R6 0x00FF
	AND R2 R6
	NOP	
	;R2保存内存个数
	SLL R2 R2 0x0000
	OR R2 R5

	
		;循环发出	
	
MEMLOOP:		
	
	LW R1 R3 0x0000    ;R3为内存数据	

	;发送低八位
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	;发送高八位

	SRA R3 R3 0x0000
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	
	ADDIU R1 0x0001   ;R1=地址加加加
	ADDIU R2 0xFFFF
	NOP
	BNEZ R2 MEMLOOP
	NOP	

	B BEGIN
	NOP		


 ;汇编	
ASM:  
	;A命令读取地址低位到r5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	;读取地址高位到r1
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R1 0x0000
	LI R6 0x00FF
	AND R1 R6
	NOP	
	
	;R1存储地址
	SLL R1 R1 0x0000
	OR R1 R5
	
	
	
	
	;检测地址是否合法
	LI R0 0x0000
	CMP R0 R1      
  BTEQZ GOTOBEGIN
	NOP	
	
 
	;读取数据低位到R5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	

	;读取数据高位到R2
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R2 0x0000
	LI R6 0x00FF
	AND R2 R6
	NOP	
	;R2保存数据
	SLL R2 R2 0x0000
	OR R2 R5
			
	SW R1 R2 0x0000	
	NOP
	
	B ASM
	NOP
	
GOTOBEGIN:
	NOP
	B BEGIN
	NOP
	
	
	
	
;反汇编：将需要反汇编的地址处的值发给终端处理	
UASM:
;读取地址低位到r5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	;读取地址高位到r1
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R1 0x0000
	LI R6 0x00FF
	AND R1 R6
	NOP	
	
	
	
	;R1存储地址
	SLL R1 R1 0x0000
	OR R1 R5
	
	;读取显示次数低位到R5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	;读取显示次数高位到R2
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R2 0x0000
	LI R6 0x00FF
	AND R2 R6
	NOP	
	;R2保存内存个数
	SLL R2 R2 0x0000
	OR R2 R5

	
		;循环发出	
	
UASMLOOP:		
	
	LW R1 R3 0x0000    ;R3为内存数据	

	;发送低八位
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	;发送高八位

	SRA R3 R3 0x0000
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	
	ADDIU R1 0x0001   ;R1=地址加加加
	ADDIU R2 0xFFFF
	NOP
	BNEZ R2 UASMLOOP
	NOP	

	B BEGIN
	NOP			
	
;连续执行
COMPILE:
	;读取地址低位到R5
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R5 0x0000
	LI R6 0x00FF
	AND R5 R6
	NOP	
	;读取内存高位到R2
	MFPC R7
	ADDIU R7 0x0003	
	NOP	
	B TESTR	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	LW R6 R2 0x0000
	LI R6 0x00FF
	AND R2 R6
	NOP	
	;R2保存内存地址  传给r6
	SLL R2 R2 0x0000
	OR R2 R5
	ADDIU3 R2 R6 0x0000
	
	
	LI R7 0x00BF
	SLL R7 R7 0x0000
	ADDIU R7 0x0010
	
	LW R7 R5 0x0005
	ADDSP 0xFFFF
	SW_SP R5 0x0000
	
	
	;中断保存在R5中
	MFIH R5
	LI R1 0x0080
	SLL R1 R1 0x000
	OR R5 R1
	
	
	
	;恢复现场
	LW R7 R0 0x0000
	LW R7 R1 0x0001
	LW R7 R2 0x0002
	LW R7 R3 0x0003
	LW R7 R4 0x0004
	
	
	
	MFPC R7
	ADDIU R7 0x0004
	MTIH R5    ;IH高位赋1	
	JR R6
	LW_SP R5 0x0000  ;R5恢复现场
	
	;用户程序执行完毕，返回kernel，保存现场
	NOP
	NOP
	ADDSP 0x0001
	LI R7 0x00BF
	SLL R7 R7 0x0000
	ADDIU R7 0x0010
	
	SW R7 R0 0x0000
	SW R7 R1 0x0001
	SW R7 R2 0x0002
	SW R7 R3 0x0003
	SW R7 R4 0x0004
	SW R7 R5 0x0005
	
	;IH高位赋0
	MFIH R0
	LI R1 0x007F
	SLL R1 R1 0x0000
	LI R2 0x00FF
	OR R1 R2	
	AND R0 R1
	MTIH R0
	
	;给终端发送结束用户程序提示
	LI R1 0x0007
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R1 0x0000		
	B BEGIN
	NOP	

NOP
NOP
NOP

;R0 R1 R2 R3 R4 R5

;R4 用于保存坐标信息
; Reserved  y   x
;  15-13  12-8 7-0

;R5 用于保存字符信息
;   R     G    B  code
; 15-13 12-10 9-7 6-0

;0xC000~0xC07f
; exist reserved  y   x
;  15    14-13  12-8 7-0
;0xC080 存储R3的临时值

;0xD000~0xEFFF
;映射到VGA

LI R4 0x0
LI R5 0X0

;初始化 0xA000~0xAFFF归零
LI R0 0x0
LI R1 0xA0
LI R3 0xB0
SLL R1 R1 0x0
SLL R3 R3 0x0
LOOP1:
SW R1 R0 0x0  ;置零
ADDIU R1 0x1
CMP R3 R1
BTEQZ BREAK1
NOP
B LOOP1
BREAK1:
NOP

;初始化 0xC000~0xC07f归零
LI R0 0x0
LI R1 0xC0
SLL R1 R1 0x0
MOVE R3 R1
ADDIU R3 0x7f
LOOP1:
SW R1 R0 0x0  ;置零
ADDIU R1 0x1
CMP R3 R1
BTEQZ BREAK2
NOP
B LOOP1
BREAK2:
NOP

;character A in (10, 0A)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x61

LI R0 0x80    ;exist = 1
ADDIU R0 0xA ;y = 0A
SLL R0 R0 0x0
ADDIU R0 0x10 ;x = 10, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x61 ; for character 'a'
SW R0 R2 0x0

;character B in (20, 0A)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x62

LI R0 0x80    ;exist = 1
ADDIU R0 0xA ;y = 0A
SLL R0 R0 0x0
ADDIU R0 0x20 ;x = 20, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x62 ; for character 'b'
SW R0 R2 0x0

;character C in (30, 0A)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x63

LI R0 0x80    ;exist = 1
ADDIU R0 0xA ;y = 0A
SLL R0 R0 0x0
ADDIU R0 0x30 ;x = 30, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x63 ; for character 'c'
SW R0 R2 0x0

;character D in (40, 0A)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x64

LI R0 0x80    ;exist = 1
ADDIU R0 0xA ;y = 0A
SLL R0 R0 0x0
ADDIU R0 0x40 ;x = 40, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x64 ; for character 'd'
SW R0 R2 0x0

;character E in (10, 04)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x65

LI R0 0x80    ;exist = 1
ADDIU R0 0x04 ;y = 04
SLL R0 R0 0x0
ADDIU R0 0x10 ;x = 10, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x65 ; for character 'e'
SW R0 R2 0x0

;character F in (20, 04)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x66

LI R0 0x80    ;exist = 1
ADDIU R0 0x04 ;y = 04
SLL R0 R0 0x0
ADDIU R0 0x20 ;x = 20, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x66 ; for character 'f'
SW R0 R2 0x0

;character G in (30, 04)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x67

LI R0 0x80    ;exist = 1
ADDIU R0 0x04 ;y = 04
SLL R0 R0 0x0
ADDIU R0 0x30 ;x = 30, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x67 ; for character 'g'
SW R0 R2 0x0

;character H in (40, 04)
LI R1 0xC0
SLL R1 R1 0x0 ;R1 for addr starting from 0xC000
ADDIU R1 0x68

LI R0 0x80    ;exist = 1
ADDIU R0 0x04 ;y = 04
SLL R0 R0 0x0
ADDIU R0 0x40 ;x = 40, R0 for addr - 0xA000

SW R1 R0 0x0  ; keep value R1 for addr, R1

LI R2 0x20 ; 0x80 + 0x20 = 0xA0
SLL R2 R2 0x0
ADDU R2 R0 R0 ; R0 for addr of VGA

LI R2 0x0
ADDIU R2 0x80 ; color = (7,7,7)
ADDIU R2 0x68 ; for character 'h'
SW R0 R2 0x0


BEGIN:            ;接收字符，保存到R1
	MFPC R0
	ADDIU R0 0x7
	LI R3 0xC0
	SLL R3 R3 0x0
	SW R3 R0 0x0
	NOP
	B TESTR2
	NOP
	LI R3 0xBF
	SLL R3 R3 0x0
	ADDIU R3 0x2
	LW R3 R1 0x0    ;0xBF02
	NOP

	LI R3 0x7f 
    AND R1 R3 
	NOP	
	; keep value R1, R4, R5

	;检查字符是否合法
	SLTUI R1 0x61
	BTEQZ LEGAL1
	NOP
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP
LEGAL1:
	SLTUI R1 0x7B
	BTEQZ NOT_LEGAL 
	NOP
	B LEGAL2
	NOP
NOT_LEGAL:
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP
	; keep value R1, R4, R5

	;检查键盘所按字符是否存在
LEGAL2:
	LI R3 0xC0
	SLL R3 R3 0x0
	ADDU R1 R3 R1
	LW R1 R0 0x0 ;取出0xC000+R1格子中的内容，存于R0
	LI R3 0x80
	SLL R3 R3 0x0
	AND R3 R0
	BNEZ R3 EXIST
	NOP
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3 ;若键盘所按字符在屏幕上不存在，返回
	NOP
EXIST:
	; 删除键盘所按字符（内存&VGA）
	LI R3 0x0
	SW R1 R3 0x0 ;将刚读出内容的内存字节清空 keep value R0
	LI R3 0x20
	SLL R3 R3 0x0
	ADDIU R3 0xFF ;R3=0x20+0xFF=0x1FFF(后5+8位为1)
	AND R0 R3 ;取出后13位
	LI R3 0xA0
	SLL R3 R3 0x0
	ADDU R3 R0 R1 ;R1存储VGA中记录键盘所按字符的地址
	LI R3 0x0
	SW R1 R3 0x0 ;将VGA中字符地址对应像素清空

	;	生成一个新的字符
	MOVE R0 R5
	LI R3 0x1F
	AND R0 R3
JUDGE:
	SLTUI R0 0x1A ;0x0~0x19 available
	BTEQZ NOTAVA1 ;PC:=PC+4
	NOP
	B AVA1
	NOP
NOTAVA1:
	ADDIU R0 0xE6 ;-26
    B JUDGE
    NOP
AVA1:
	LI R3 0xC0
	SLL R3 R3 0x0
	ADDIU R3 0x61
	ADDU R0 R3 R3
	LW R3 R2 0x0 ;取出0xC000+R0格子中的内容，存于R2
	LI R3 0x80
	SLL R3 R3 0x0
	AND R3 R2
	BEQZ R3 GOON1
	NOP
	ADDIU R0 0x1 ;该字符已出现过，考虑+1后的字符
	B JUDGE
	NOP						;字符信息存储于R0	(值为对应的ASCII码－61)
GOON1:
	MOVE R2 R4
	SRA R2 R2 0x0
	LI R3 0x1F
	AND R2 R3
XC1:
	SLTUI R2 0x0E ;0x0~0x0D available
	BTEQZ NOTAVA2
	NOP
	B AVA2
	NOP
NOTAVA2:
	ADDIU R2 0xF2 ;-14
    B XC1
    NOP
AVA2:
	MOVE R1 R4
	LI R3 0xFF
	AND R1 R3
XC2:
	SLTUI R1 0x50 ;0x0~0x4F available
	BTEQZ NOTAVA3 ;PC:=PC+4
	NOP
	B AVA3
	NOP
NOTAVA3:
	ADDIU R1 0xB0 ;-50
    B XC2
    NOP
AVA3:
	SLL R2 R2 0x0
	ADDU R2 R1 R2 ;偏移量存于R2,R2中不含存在位
	LI R1 0x80
	SLL R1 R1 0x0
	ADDU R1 R2 R1	;写存在位，R1中含存在位

	LI R3 0xC0
	SLL R3 R3 0x0
	ADDU R3 R0 R3
	ADDIU R3 0x61
	SW R3 R1 0x0;写入内存

	MOVE R1 R5
	LI R3 0x0
	ADDIU R3 0x80
	AND R1 R3
    BNEZ R1 GOONN
    ADDIU R1 0x80
GOONN:
    NOP
	ADDU R1 R0 R0
    ADDIU R0 0x61 ;颜色和字符信息存于R0

	LI R3 0xA0
	SLL R3 R3 0x0
	ADDU R2 R3 R2 ;VGA新字符产生地址存于R2

	SW R2 R0 0x0 ; VGA信息写入
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
    ADDIU R3 0xFE
	JR R3 ; for tmp 修改一次后退出程序
	NOP


TESTR2:
	NOP
	ADDIU R4 0x7    ;R4+=D
	ADDIU R5 0x3    ;R5+=B
	LI R3 0xBF 
	SLL R3 R3 0x0 
	ADDIU R3 0x3
	LW R3 R0 0x0 
	LI R3 0x2
	AND R0 R3
	BEQZ R0 TESTR2   ;BF03&2=0  则等待	
	NOP
    LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP
