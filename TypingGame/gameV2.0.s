TYPE_GAME:
    SW_SP R7 0x0

    LI R4 0x0
    LI R5 0X0

    ;≥ı ºªØ 0xA000~0xAFFFπÈ¡„
    LI R0 0x0
    LI R1 0xA0
    LI R3 0xB0
    SLL R1 R1 0x0
    SLL R3 R3 0x0
    LOOP1:
    SW R1 R0 0x0  ;÷√¡„
    ADDIU R1 0x1
    CMP R3 R1
    BTEQZ BREAK1
    NOP
    B LOOP1
    BREAK1:
    NOP

    ;≥ı ºªØ 0xC000~0xC07fπÈ¡„
    LI R0 0x0
    LI R1 0xC0
    SLL R1 R1 0x0
    MOVE R3 R1
    ADDIU R3 0x7f
    ADDIU R3 0x7f
    LOOP1:
    SW R1 R0 0x0  ;÷√¡„
    ADDIU R1 0x1
    CMP R3 R1
    BTEQZ BREAK2
    NOP
    B LOOP1
    BREAK2:
    NOP

GAME_LOOP:
    MFPC R7
    ADDIU R7 0x3
    B TESTR
    NOP
    
    LI R3 0x7f
    AND R1 R3
    SLTUI R1 0x61
    BTEQZ LEGAL1
    NOP
    B GAME_LOOP
    
TESTR:
	LI R3 0xBF 
	SLL R3 R3 0x0 
	ADDIU R3 0x3
	LW R3 R0 0x0 
	LI R3 0x2
	AND R0 R3
	BEQZ R0 TESTR   ;BF03&2=0  ‘Úµ»¥˝	
	NOP
    LI R3 0xC0
	SLL R3 R3 0x0
	LW R3 R3 0x0
	JR R3
	NOP
QUITTESTR:
    JR R7
