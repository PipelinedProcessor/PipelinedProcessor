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
	B TESTR
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


TESTR:
	NOP
	ADDIU R4 0x7    ;R4+=D
	ADDIU R5 0x3    ;R5+=B
	LI R3 0xBF 
	SLL R3 R3 0x0 
	ADDIU R3 0x3
	LW R3 R0 0x0 
	LI R3 0x2
	AND R0 R3
	BEQZ R0 TESTR   ;BF03&2=0  则等待	
	NOP
    LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP