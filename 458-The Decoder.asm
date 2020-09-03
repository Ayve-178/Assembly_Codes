.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$') 
    C DB "*CDC is the trademark of the Control Data Corporation. $"
    I DB "*IBM is a trademark of the International Business Machine Corporation. $"
    D DB "*DEC is the trademark of the Digital Equipment Corporation."
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE OUTPUT                   
        MOV [SI],AL 
        INC SI
        JMP LEBEL 
    OUTPUT:       
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        CMP [1],80
        JE III 
        CMP [1],74
        JE CCC 
        CMP [1],75
        JE DDD
    DDD:
        MOV AH,9
        LEA DX,D
        INT 21H
        JMP EXIT
    CCC:
        MOV AH,9
        LEA DX,C
        INT 21H
        JMP EXIT
    III:
        MOV AH,9
        LEA DX,I
        INT 21H
        JMP EXIT                                      
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
