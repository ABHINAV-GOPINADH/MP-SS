DATA SEGMENT
    MSG1 DB 10,13,'ENTER STRING:$'
    STR1 DB 40,0,40 DUP(0)
    LEN DW 0000H
    STR2 DB 40 DUP(0)
    MSG2 DB 10,13,'REVERSE STRING IS :$'
    MES1 DB 10,13,'WORD IS PALINDROME$'
    MES2 DB 10,13,'WORD IS NOT PALINDROME$'
DATA ENDS

DISPLAY MACRO MSG
    MOV AH,9
    LEA DX,MSG
    INT 21H
ENDM

CODE SEGMENT
ASSUME CS:CODE,DS:DATA,ES:DATA
START : MOV AX,DATA
        MOV DS,AX
        MOV ES,AX
        DISPLAY MSG1
        LEA DX,STR1
        MOV AH,OAH
        INT 21H
        MOV AL,[STR1+1]
        MOV BX,OFFSET LEN
        MOV BYTE PTR[BX],AL
        MOV BX,LEN
        LEA SI,STR1+2
        LEA DI,STR2+[BX]-1
        MOV CX,LEN
        DISPLAY MSG2
UP:     CLD
        LODSB
        STD
        STOSB
        DEC CX
        JNZ UP
        LEA DI,STR2+[BX]
        MOV BYTE PTR[DI],'$'
        DISPLAY STR2
        LEA SI,STR1+2
        LEA DI,STR2
        CLD
        MOV CX,LEN
        REPE CMPSB
        CMP CX,0000H
        JNZ NOTPALIN
        LEA DX,MES1
        MOV AH,09H
        INT 21H
        JMP EXIT
NOTPALIN:LEA DX,MES2
        MOV AH,09H
        INT 21H
EXIT:   MOV AH,4CH
        INT 21H
        CODE ENDS
        END START
        
