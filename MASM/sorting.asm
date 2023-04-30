DATA SEGMENT
        MSG1 DB 'ENTER THE COUNT: $'
        STR DB 10,13,'ENTER THE NUMBER: $'
        STR1 DB 0DH,0AH,'BUBBLE SORTED:$'
        STR3 DB 0DH,0AH,'$'
        ARRAY DB 10 DUP(0)
DATA ENDS

CODE SEGMENT
ASSUMUE CS:CODE,DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        LEA DX,MSG1
        MOV AH,09H
        INT 21H
        MOV AH,01H
        INT 21H
        AND AL,0FH
        MOV CL,AL
        MOV CH,00H
        PUSH CX
        MOV AH,09H
        LEA DX,STR
        INT 21H
        LEA SI,ARRAY1
INPUTS: MOV AH,01H
        INT 21H
        CMP AL,' '
        JZ INPUTS
        MOV [SI],AL
        INC SI
        DEC CX
        JNZ INPUTS
        POP CX
        MOV BX,CX
        PUSH