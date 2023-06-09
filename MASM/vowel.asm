DATA SEGMENT
        MSG1 DB 'ENTER THE STRING:$'
        INPUT DB 40,0,40 DUP(0)
        MSG2 DB 0AH,0DH,'THE NO: OF VOWELS IS:$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:  MOV AX,DATA
        MOV DS,AX
        LEA DX,MSG1
        MOV AH,09H
        INT 21H
        LEA DX,INPUT
        MOV AH,0AH
        INT 21H
        MOV CH,00H
        MOV CL,[INPUT+1]
        LEA SI,[INPUT+2]
        MOV BL,0000H
BACK:   MOV AL,[SI]
        CMP AL,0DH
        JZ FINAL
        CMP AL,'A'
        JZ COUNT
        CMP AL,'E'
        JZ COUNT
        CMP AL,'I'
        JZ COUNT
        CMP AL,'O'
        JZ COUNT
        CMP AL,'U'
        JZ COUNT
        CMP AL,'a'
        JZ COUNT
        CMP AL,'e'
        JZ COUNT
        CMP AL,'i'
        JZ COUNT
        CMP AL,'o'
        JZ COUNT
        CMP AL,'U'
        JZ COUNT
        INC SI
        DEC CX
        JMP BACK
COUNT:  INC BL
        MOV AL,BL
        DAA
        MOV BL,AL
        INC SI
        DEC CX
        JMP BACK
FINAL:  MOV BH,BL
        LEA DX,MSG2
        MOV AH,09H
        INT 21H
        AND BL,0F0H
        MOV CL,04H
        SHR BL,CL
        OR BL,30H
        MOV AH,02H
        INT 21H
        AND BH,0FH
        OR BH,30H
        MOV DL,BH
        INT 21H
        MOV AH,4CH
        INT 21H

        CODE ENDS
        END START