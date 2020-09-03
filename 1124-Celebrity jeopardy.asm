.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$')
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE EXIT                   
        MOV [SI],AL 
        INC SI
        JMP LEBEL    
    EXIT:  
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        MOV DX,OFFSET VAR1
        MOV AH,9
        INT 21H 
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
