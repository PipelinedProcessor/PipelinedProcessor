ADDSP3 R0 0x0000
ADDSP3 R0 0x0000
NOP

;�����û�����Ĵ����ĵ�ַ 
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

DELINT:   ;�жϴ������
	NOP
	NOP
	NOP
	;�����û������ֳ�
	LI R6 0xBF
	SLL R6 R6 0x0000
	ADDIU R6 0x10					;R6=0xBF10
	SW R6 R0 0x0000
	SW R6 R1 0x0001
	SW R6 R2 0x0002
	

	

	
	;R1=�жϺ�
	LW_SP R1 0x0000
	ADDSP 0x0001
	LI R0 0x00FF
	AND R1 R0
	
	;R2=Ӧ�ó����pc
	LW_SP R2 0x0000
	ADDSP 0x0001
	
	;����r3
	ADDSP 0xFFFF
	SW_SP R3 0x0000


	
	;�����û����򷵻ص�ַ
	ADDSP 0xFFFF
	SW_SP R7 0x0000
	
	;��ʾ�նˣ������жϴ���
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
	;����жϺ�
	MFPC R7 
	ADDIU R7 0x0003  
	NOP
	B TESTW 	
	NOP
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00 
	SW R6 R1 0x0000
	NOP
	
	;��ʾ�նˣ��жϴ������
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
	
	;R6���淵�ص�ַ
	ADDIU3 R2 R6 0x0000
	
	;��r3=IH����λ���1��
	MFIH R3
	LI R0 0x0080
	SLL R0 R0 0x000
	OR R3 R0
	
	;�ָ��ֳ�
	LI R7 0xBF
	SLL R7 R7 0x0000
	ADDIU R7 0x10					;R7=0xBF10
	LW R7 R0 0x0000
	LW R7 R1 0x0001
	LW R7 R2 0x0002
	
	;r7=�û����򷵻ص�ַ
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
	;��ʼ��IH�Ĵ��������λΪ1ʱ�������жϣ�Ϊ0ʱ��������ʼ��Ϊ0��kernel�������ж�
	LI R0 0x07
	MTIH R0
	;��ʼ��ջ��ַ
	LI R0 0x00BF 
	SLL R0 R0 0x0000
	ADDIU R0 0x10					;R0=0xBF10 
	MTSP R0
	NOP
	
	;�û��Ĵ���ֵ��ʼ��
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
	

	

	

	
BEGIN:          ;�������
	;�����ַ������浽r1
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
	

	;����Ƿ�ΪR����		
	LI R0 0x0052
	CMP R0 R1
	BTEQZ SHOWREGS	
	NOP	
	;����Ƿ�ΪD����
	LI R0 0x0044
	CMP R0 R1
	BTEQZ SHOWMEM
	NOP	
	
	;����Ƿ�ΪA����
	LI R0 0x0041
	CMP R0 R1
	BTEQZ GOTOASM
	NOP	
	
	;����Ƿ�ΪU����
	LI R0 0x0055
	CMP R0 R1
	BTEQZ GOTOUASM
	NOP	
	;����Ƿ�ΪG����
	LI R0 0x0047
	CMP R0 R1
	BTEQZ GOTOCOMPILE
	NOP		
	
	B BEGIN
	NOP

;�����������
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
  
	
;����8251�Ƿ���д
TESTW:	
	NOP	 		
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	ADDIU R6 0x0001 
	LW R6 R0 0x0000 
	LI R6 0x0001 
	AND R0 R6 
	BEQZ R0 TESTW     ;BF01&1=0 ��ȴ�	
	NOP		
	JR R7
	NOP 
	

	
;����8251�Ƿ��ܶ�
TESTR:	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 
	ADDIU R6 0x0001 
	LW R6 R0 0x0000 
	LI R6 0x0002
	AND R0 R6 
	BEQZ R0 TESTR   ;BF01&2=0  ��ȴ�	
	NOP	
	JR R7
	NOP 		
	
	
SHOWREGS:    ;R�����ӡR0-R5
	LI R1 0x0006  ;R1�ݼ�  
	LI R2 0x0006   ;R2����
	
LOOP:
	LI R0  0x00BF
	SLL R0 R0 0x0000
	ADDIU R0 0x0010
	SUBU R2 R1 R3   ;R2=0,1,2,3
	ADDU R0 R3 R0   ;R0=BF10...
	LW R0 R3 0x0000    ;R3=�û������ R0,R1,R2	

	;���͵Ͱ�λ
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=BF00	
	SW R6 R3 0x0000	
	;���͸߰�λ
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
	

	
	

	
	
	
SHOWMEM:  ;�鿴�ڴ�	
;D��ȡ��ַ��λ��r5
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
	
	;��ȡ��ַ��λ��r1
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
	
	
	
	;R1�洢��ַ
	SLL R1 R1 0x0000
	OR R1 R5
	
	;��ȡ��ʾ������λ��R5
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
	;��ȡ��ʾ������λ��R2
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
	;R2�����ڴ����
	SLL R2 R2 0x0000
	OR R2 R5

	
		;ѭ������	
	
MEMLOOP:		
	
	LW R1 R3 0x0000    ;R3Ϊ�ڴ�����	

	;���͵Ͱ�λ
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	;���͸߰�λ

	SRA R3 R3 0x0000
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	
	ADDIU R1 0x0001   ;R1=��ַ�ӼӼ�
	ADDIU R2 0xFFFF
	NOP
	BNEZ R2 MEMLOOP
	NOP	

	B BEGIN
	NOP		


 ;���	
ASM:  
	;A�����ȡ��ַ��λ��r5
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
	;��ȡ��ַ��λ��r1
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
	
	;R1�洢��ַ
	SLL R1 R1 0x0000
	OR R1 R5
	
	
	
	
	;����ַ�Ƿ�Ϸ�
	LI R0 0x0000
	CMP R0 R1      
  BTEQZ GOTOBEGIN
	NOP	
	
 
	;��ȡ���ݵ�λ��R5
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
	

	;��ȡ���ݸ�λ��R2
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
	;R2��������
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
	
	
	
	
;����ࣺ����Ҫ�����ĵ�ַ����ֵ�����ն˴���	
UASM:
;��ȡ��ַ��λ��r5
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
	;��ȡ��ַ��λ��r1
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
	
	
	
	;R1�洢��ַ
	SLL R1 R1 0x0000
	OR R1 R5
	
	;��ȡ��ʾ������λ��R5
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
	;��ȡ��ʾ������λ��R2
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
	;R2�����ڴ����
	SLL R2 R2 0x0000
	OR R2 R5

	
		;ѭ������	
	
UASMLOOP:		
	
	LW R1 R3 0x0000    ;R3Ϊ�ڴ�����	

	;���͵Ͱ�λ
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	;���͸߰�λ

	SRA R3 R3 0x0000
	MFPC R7
	ADDIU R7 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R6 0x00BF 
	SLL R6 R6 0x0000 ;R6=0xBF00	
	SW R6 R3 0x0000	
	
	ADDIU R1 0x0001   ;R1=��ַ�ӼӼ�
	ADDIU R2 0xFFFF
	NOP
	BNEZ R2 UASMLOOP
	NOP	

	B BEGIN
	NOP			
	
;����ִ��
COMPILE:
	;��ȡ��ַ��λ��R5
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
	;��ȡ�ڴ��λ��R2
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
	;R2�����ڴ��ַ  ����r6
	SLL R2 R2 0x0000
	OR R2 R5
	ADDIU3 R2 R6 0x0000
	
	
	LI R7 0x00BF
	SLL R7 R7 0x0000
	ADDIU R7 0x0010
	
	LW R7 R5 0x0005
	ADDSP 0xFFFF
	SW_SP R5 0x0000
	
	
	;�жϱ�����R5��
	MFIH R5
	LI R1 0x0080
	SLL R1 R1 0x000
	OR R5 R1
	
	
	
	;�ָ��ֳ�
	LW R7 R0 0x0000
	LW R7 R1 0x0001
	LW R7 R2 0x0002
	LW R7 R3 0x0003
	LW R7 R4 0x0004
	
	
	
	MFPC R7
	ADDIU R7 0x0004
	MTIH R5    ;IH��λ��1	
	JR R6
	LW_SP R5 0x0000  ;R5�ָ��ֳ�
	
	;�û�����ִ����ϣ�����kernel�������ֳ�
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
	
	;IH��λ��0
	MFIH R0
	LI R1 0x007F
	SLL R1 R1 0x0000
	LI R2 0x00FF
	OR R1 R2	
	AND R0 R1
	MTIH R0
	
	;���ն˷��ͽ����û�������ʾ
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
	BEQZ R0 TESTR2   ;BF03&2=0  ��ȴ�	
	NOP
    LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP
