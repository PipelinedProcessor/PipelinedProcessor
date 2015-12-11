TYPE_GAME:
    ADDSP 0xFF
    SW_SP R7 0x00

  GAME_INIT:
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
    ADDIU R3 0x02
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
    B TIME_RUN
    NOP
    
    MFPC R7
    ADDIU R7 0x3
    B TESTR
    NOP
    
    MFIH R0
    BEQZ R0 GAME_LOOP
    
    LI R3 0xBF
	SLL R3 R3 0x0
	ADDIU R3 0x2
	LW R3 R1 0x0    ;0xBF02
	NOP
	LI R3 0x7f 
    AND R1 R3 
    LI R0 0x7B
    CMP R3 R0
    BTEQZ QUIT_GAME
    NOP
    
    MOVE R0 R3
    MFPC R7
    ADDIU R7 0x3
    B EXIST_CHAR
    NOP
    MFIH R1
    BEQZ R1 GAME_LOOP
    NOP
    
    MFPC R7
    ADDIU R7 0x3
    B CHAR_DISAPPEAR
    NOP
    B GAME_LOOP
    NOP
  
  QUIT_GAME:
    LW_SP R7 0x0
    ADDSP 0x01
    JR R7
    NOP
    
    
TESTR:
	LI R3 0xBF 
	SLL R3 R3 0x0 
	ADDIU R3 0x3
	LW R3 R0 0x0 
	LI R3 0x2
	AND R0 R3
    LI R4 0x0
    MTIH R4
	BEQZ R0 QUITTESTR
	NOP
    LI R4 0x1
    MTIH R4
QUITTESTR:
    JR R7
    NOP


GET_RANDOM: ;R0 mod number
    ADDSP 0xFF
    SW_SP R1 0x0
    ADDSP 0xFF
    SW_SP R2 0x0

    LI R1 0xC2
    SLL R1 R1 0x0
    LW R1 R2 0x0
    ADDIU R2 0x61
    SW R1 R2 0x0
    MOVE R1 R2
    SLL R2 R2 0x4
    ADDU R1 R2 R2
    AND R2 R0
    MTIH R2
    
    LW_SP R2 0x0
    ADDSP 0x01
    LW_SP R1 0x0
    ADDSP 0x01
    JR R7
    NOP
    
CHAR_DISAPPEAR: ;R0 the disappear char
    ADDSP 0xFF
    SW_SP R1 0x0
    ADDSP 0xFF
    SW_SP R2 0x0
    ADDSP 0xFF
    SW_SP R3 0x0
    ADDSP 0xFF
    
    LI R1 0x20
    SLL R1 R1 0x0
    LI R3 0xC0
    SLL R3 R3 0x0
    ADDU R0 R3 R3
    LW R3 R2 0x0
    ADDU R2 R1 R1
    LI R2 0x0
    SW R1 R2 0x0 ; clear vga memory
    SW R3 R2 0x0 ; clear statu memory
    LI R3 0xC1
    SLL R3 R3 0x0
    ADDU R0 R3 R3
    SW R3 R2 0x0 ; clear life time memory
    
    LW_SP R3 0x0
    ADDSP 0x01
    LW_SP R2 0x0
    ADDSP 0x01
    LW_SP R1 0x0
    ADDSP 0x01
    JR R7
    NOP
    
CHAR_APPEAR: ;R0 appear char R1 x R2 y
    ADDSP 0xFF
    SW_SP R3 0x0
    ADDSP 0xFF
    SW_SP R4 0x0
    ADDSP 0xFF
    SW_SP R5 0x0
    ADDSP 0xFF
    
    ;compute statu
    LI R3 0x80
    SLL R3 R3 0x1
    ADDU R2 R3 R3
    SLL R3 R3 0x7
    ADDU R1 R3 R3 ; R3 is statu
    
    ;appear in vga
    LI R4 0x20
    ADDU R3 R4 R4
    LI R5 0x0
    ADDIU R5 0x80
    ADDU R0 R5 R5
    SW R4 R5 0x0
    
    ;save statu to memory
    LI R4 0xC0
    SLL R4 R4 0x0
    ADDU R0 R4 R4 ;R4 is the address of the char
    SW R4 R3 0x0
    
    ;save color to memory
    LI R4 0xC1
    SLL R4 R4 0x0
    ADDU R0 R4 R4
    LI R5 0xFF
    SLL R5 R5 0x1
    ADDIU R5 0x1
    SW R4 R5 0x0
    
    LW_SP R5 0x0
    ADDSP 0x01
    LW_SP R4 0x0
    ADDSP 0x01
    LW_SP R3 0x0
    ADDSP 0x01
    JR R7
    NOP

APPEAR_VGA: ;R0 char
    ADDSP 0xFF
    SW_SP R1 0x0
    ADDSP 0xFF
    SW_SP R2 0x0
    ADDSP 0xFF
    SW_SP R3 0x0
    ADDSP 0xFF
    SW_SP R4 0x0
    
    LI R1 0xC0
    SLL R1 R1 0x0
    ADDU R0 R1 R1 ;R1 is the address of the char
    LW R1 R2 0x0 ; R2 is the statu
    LI R1 0xC1
    SLL R1 R1 0x0
    ADDU R0 R1 R1
    LW R1 R3 0x0 ; R3 is the color
    SLL R3 R3 0x7
    ADDU R0 R3 R3 ; R3 to save
    LI R4 0x20
    SLL R4 R4 0x0
    ADDU R4 R2 R4
    SW R4 R3 0x0
    
    LW_SP R4 0x0
    ADDSP 0x01
    LW_SP R3 0x0
    ADDSP 0x01
    LW_SP R2 0x0
    ADDSP 0x01
    LW_SP R1 0x0
    ADDSP 0x01
    JR R7
    NOP
    
CHECK_POSITION: ;R0 x R1 y
    ADDSP 0xFF
    SW_SP R2 0x0
    ADDSP 0xFF
    SW_SP R3 0x0
    ADDSP 0xFF
    SW_SP R4 0x0
    ADDSP 0xFF
    SW_SP R5 0x0
    ADDSP 0xFF
    SLTUI R0 0x50
    BTEQZ CHECK_ILLEGAL
    NOP
    SLTUI R1 0x1E
    BTEQZ CHECK_ILLEGAL
    NOP
    LI R2 0x0
    LI R3 0xC0
    SLL R3 R3 0x0
    ADDIU R3 0x61
    
  LOOP_CHECK:
    ADDU R2 R3 R4
    LW R4 R5 0x0
    LI R4 0x80
    SLL R4 R4 0x0
    AND R4 R5
    BEQZ R4 CONTINUE_CHECK
    NOP
    LI R4 0x7F
    AND R4 R5
    CMP R4 R0
    BTEQZ ILLEGAL_CHECK
    NOP
    LI R4 0x1F
    SLL R4 R4 0x7
    AND R4 R5
    SRA R4 R4 0x7
    CMP R4 R1
    BTEQZ ILLEGAL_CHECK
    NOP
  CONTINUE_CHECK:
    ADDIU R2 0x1
    SLTUI R2 0x1A
    BTEQZ LEGAL_CHECK
    NOP
    B LOOP_CHECK
    NOP
  ILLEGAL_CHECK:
    LI R2 0x0
    MTIH R2
    B RET_CHECK
    NOP
  LEGAL_CHECK:  
    LI R2 0x1
    MTIH R2
  RET_CHECK:
    LW_SP R5 0x0
    ADDSP 0x01
    LW_SP R4 0x0
    ADDSP 0x01
    LW_SP R3 0x0
    ADDSP 0x01
    LW_SP R2 0x0
    ADDSP 0x01
    JR R7
    NOP

EXIST_CHAR: ;R0 char
    ADDSP 0xFF
    SW_SP R1 0x0
    ADDSP 0xFF
    SW_SP R2 0x0
    LI R1 0xC0
    SLL R1 R1 0x0
    ADDU R1 R0 R1
    LW R1 R2 0x0
    LI R1 0x80
    SLL R1 0x0
    AND R1 R2
    BEQZ R1 EXIST_NO
    NOP
    LI R1 0x1
    MTIH R1
    B RET_EXIST
    NOP
  EXIST_NO:
    LI R1 0x0
    MTIH R1
  RET_EXIST:
    LW_SP R2 0x0
    ADDSP 0x01
    LW_SP R1 0x0
    ADDSP 0x01
    JR R7
    NOP
    
TIME_RUN:
    ADDSP 0xFF
    SW_SP R7 0x0
    ADDSP 0xFF
    SW_SP R0 0x0
    ADDSP 0xFF
    SW_SP R1 0x0
    ADDSP 0xFF
    SW_SP R2 0x0
    ADDSP 0xFF
    SW_SP R3 0x0
    ADDSP 0xFF
    SW_SP R4 0x0
    ADDSP 0xFF
    SW_SP R5 0x0
    
    LI R5 0x00
    
  LOOP_TIME_RUN:
    LI R0 0xC0
    SLL R0 R0 0x0
    ADDIU R0 0x61
    ADDU R0 R5 R0
    LW R0 R1 0x0
    LI R4 0x80
    SLL R4 R4 0x0
    AND R4 R1
    BEQZ R4 RAMDOM_APPEAR
    NOP
  
  DEC_COLOR:
    LI R0 0xFF
    SLL R0 R0 0x5
    MFPC R7
    ADDIU R7 0x3
    B GET_RANDOM
    NOP
    MFIH R0
    BNEZ CONTINUE_TIME_RUN
    NOP
    
    LI R4 0xC1
    SLL R4 R4 0x0
    ADDIU R4 0x61
    ADDU R4 R5 R4
    LW R4 R3 0x0
    LI R0 0x7
    MFPC R7
    ADDIU R7 0x3
    B GET_RANDOM
    NOP
    MFIH R0
    SLTUI R0 0x6
    BTEQZ DEC_B
    NOP
    SLTUI R0 0x3
    BTEQZ DEC_G
    NOP
    
      DEC_R:
        LI R0 0x07
        SLL R0 R0 0x6
        AND R0 R3
        BEQZ R0 DEC_G
        NOP
        LI R0 0x01
        SLL R0 R0 0x6
        SUBU R3 R0 R3
        B BREAK_RGB
        NOP
      DEC_G:
        LI R0 0x07
        SLL R0 R0 0x3
        AND R0 R3
        BEQZ R0 DEC_B
        NOP
        LI R0 0x01
        SLL R0 R0 0x3
        SUBU R3 R0 R3
        B BREAK_RGB
        NOP
      DEC_B:
        LI R0 0x07
        AND R0 R3
        BEQZ R0 DEC_R
        NOP
        LI R0 0x01
        SUBU R3 R0 R3
    
  BREAK_RGB:
    BEQZ R3 DELETE_CHAR
    NOP
    SW R4 R3 0x0
    MOVE R0 R5
    ADDIU R0 0x61
    MFPC R7
    ADDIU R7 0x3
    B APPEAR_VGA
    NOP
    B CONTINUE_TIME_RUN
    NOP
    
  DELETE_CHAR:
    MOVE R0 R5
    ADDIU R0 0x61
    MFPC R7
    ADDIU R7 0x3
    B CHAR_DISAPPEAR
    NOP
    B CONTINUE_TIME_RUN
    NOP
  
  RAMDOM_APPEAR:
    LI R0 0xFF
    SLL R0 R0 0x4
    ADDIU R0 0x3
    MFPC R7
    ADDIU R7 0x3
    B GET_RANDOM
    NOP
    MFIH R0
    BNEZ CONTINUE_TIME_RUN
    NOP
      LOOP_POSITION:
        LI R0 0x7F
        MFPC R7
        ADDIU R7 0x03
        B GET_RANDOM
        NOP
        MFIH R1
        LI R0 0x1F
        MFPC R7
        ADDIU R7 0x3
        B GET_RANDOM
        NOP
        MFIH R2
        MOVE R0 R1
        MOVE R1 R2
        MFPC R7
        ADDIU R7 0x3
        B CHECK_POSITION
        NOP
        MFIH R2
        BEQZ R2 LOOP_POSITION
        NOP
    MOVE R2 R1
    MOVE R1 R0
    MOVE R0 R5
    ADDIU R0 0x61
    MFPC R7
    ADDIU R7 0x3
    B CHAR_APPEAR
    NOP
      
  CONTINUE_TIME_RUN:
    ADDIU R5 0x1
    SLTUI R5 0x1A
    BTEQZ RET_TIME_RUN
    NOP
    B LOOP_TIME_RUN
    NOP
  
  RET_TIME_RUN:
    LW_SP R5 0x0
    ADDSP 0x01
    LW_SP R4 0x0
    ADDSP 0x01
    LW_SP R3 0x0
    ADDSP 0x01
    LW_SP R2 0x0
    ADDSP 0x01
    LW_SP R1 0x0
    ADDSP 0x01
    LW_SP R0 0x0
    ADDSP 0x01
    LW_SP R7 0x0
    ADDSP 0x01
    JR R7
    NOP
    
    