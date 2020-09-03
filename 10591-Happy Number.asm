.MODEL SMALL
.STACK 100H
.DATA
    N DW ?
    C DW ? 
    T DW ?
    H DB "HAPPY $"
    U DB "UNHAPPY $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    MOV C,0   
    CALL TAKING_INPUT  
    MOV N,AX          ;NUMBER
    CALL NEWLINE
    MOV AX,N          
    LEVEL:
        CMP AX,0
        JE PRO 
        MOV BX,10 
        MOV DX,0
        DIV BX   ;AX=AX/10
        MOV T,AX
        MOV AX,DX
        MOV BX,DX
        MUL DX  ;AX=DX*DX  
        MOV CX,C
        ADD CX,AX
        MOV C,CX
        MOV AX,T
        JMP LEVEL
        PRO:
            MOV CX,C
            CMP CX,1
            JE HH 
            CMP CX,10
            JL UU
            JMP XC
        HH:
            MOV AH,9
            LEA DX,H
            INT 21H     
            JMP EXIT
        UU:
            MOV AH,9
            LEA DX,U
            INT 21H
            JMP EXIT
        XC:
            MOV AX,CX
            MOV C,0
            JMP LEVEL    
    EXIT:
        MOV AH,4CH
        INT 21H         
    MAIN ENDP  

NEWLINE PROC 
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        RET            
    NEWLINE ENDP 

TAKING_INPUT PROC
        MOV CX,0
        INPUT:
        MOV AH,1
        INT 21H
        CMP AL,13
        JNE CALC
        MOV AX,CX 
        RET
        CALC:
        SUB AL,48
        MOV AH,0
        MOV BX,AX
        MOV DX,10
        MOV AX,CX
        MUL DX
        ADD AX,BX        
        MOV CX,AX
        JMP INPUT    
    TAKING_INPUT ENDP  

PRINTING_OUTPUT PROC
        MOV CX,0        
        PRINT:
        MOV DX,0
        MOV BX,10
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE PRINT        
        PRINTF:
        MOV AH,2
        POP DX
        ADD DL,48
        INT 21H
        LOOP PRINTF        
        RET        
    PRINTING_OUTPUT ENDP
END MAIN
