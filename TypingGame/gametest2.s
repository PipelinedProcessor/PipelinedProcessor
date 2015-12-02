;R0 R1 R2 R3 R4 R5

;R4 ���ڱ���������Ϣ
; Reserved  y   x
;  15-13  12-8 7-0

;R5 ���ڱ����ַ���Ϣ
;   R     G    B  code
; 15-13 12-10 9-7 6-0

;0xC000~0xC07f
; exist reserved  y   x
;  15    14-13  12-8 7-0
;0xC080 �洢R3����ʱֵ

;0xD000~0xEFFF
;ӳ�䵽VGA

LI R4 0x0
LI R5 0X0

;��ʼ�� 0xA000~0xAFFF����
LI R0 0x0
LI R1 0xA0
LI R3 0xB0
SLL R1 R1 0x0
SLL R3 R3 0x0
LOOP1:
SW R1 R0 0x0  ;����
ADDIU R1 0x1
CMP R3 R1
BTEQZ BREAK1
NOP
B LOOP1
BREAK1:
NOP

;��ʼ�� 0xC000~0xC07f����
LI R0 0x0
LI R1 0xC0
SLL R1 R1 0x0
MOVE R3 R1
ADDIU R3 0x7f
LOOP1:
SW R1 R0 0x0  ;����
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


BEGIN:            ;�����ַ������浽R1
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

	;����ַ��Ƿ�Ϸ�
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

	;�����������ַ��Ƿ����
LEGAL2:
	LI R3 0xC0
	SLL R3 R3 0x0
	ADDU R1 R3 R1
	LW R1 R0 0x0 ;ȡ��0xC000+R1�����е����ݣ�����R0
	LI R3 0x80
	SLL R3 R3 0x0
	AND R3 R0
	BNEZ R3 EXIST
	NOP
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3 ;�����������ַ�����Ļ�ϲ����ڣ�����
	NOP
EXIST:
	; ɾ�����������ַ����ڴ�&VGA��
	LI R3 0x0
	SW R1 R3 0x0 ;���ն������ݵ��ڴ��ֽ���� keep value R0
	LI R3 0x20
	SLL R3 R3 0x0
	ADDIU R3 0xFF ;R3=0x20+0xFF=0x1FFF(��5+8λΪ1)
	AND R0 R3 ;ȡ����13λ
	LI R3 0xA0
	SLL R3 R3 0x0
	ADDU R3 R0 R1 ;R1�洢VGA�м�¼���������ַ��ĵ�ַ
	LI R3 0x0
	SW R1 R3 0x0 ;��VGA���ַ���ַ��Ӧ�������

	;	����һ���µ��ַ�
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
	LW R3 R2 0x0 ;ȡ��0xC000+R0�����е����ݣ�����R2
	LI R3 0x80
	SLL R3 R3 0x0
	AND R3 R2
	BEQZ R3 GOON1
	NOP
	ADDIU R0 0x1 ;���ַ��ѳ��ֹ�������+1����ַ�
	B JUDGE
	NOP						;�ַ���Ϣ�洢��R0	(ֵΪ��Ӧ��ASCII�룭61)
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
	ADDU R2 R1 R2 ;ƫ��������R2,R2�в�������λ
	LI R1 0x80
	SLL R1 R1 0x0
	ADDU R1 R2 R1	;д����λ��R1�к�����λ

	LI R3 0xC0
	SLL R3 R3 0x0
	ADDU R3 R0 R3
	ADDIU R3 0x61
	SW R3 R1 0x0;д���ڴ�

	MOVE R1 R5
	LI R3 0x0
	ADDIU R3 0x80
	AND R1 R3
    BNEZ R1 GOONN
    ADDIU R1 0x80
GOONN:
    NOP
	ADDU R1 R0 R0
    ADDIU R0 0x61 ;��ɫ���ַ���Ϣ����R0

	LI R3 0xA0
	SLL R3 R3 0x0
	ADDU R2 R3 R2 ;VGA���ַ�������ַ����R2

	SW R2 R0 0x0 ; VGA��Ϣд��
	LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
    ADDIU R3 0xFE
	JR R3 ; for tmp �޸�һ�κ��˳�����
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
	BEQZ R0 TESTR   ;BF03&2=0  ��ȴ�	
	NOP
    LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP