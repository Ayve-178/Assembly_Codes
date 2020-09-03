.MODEL SMALL
.STACK 100H
.DATA
    N DW ?
    A DW ?
    B DW ? 
    GREAT DB "> $"
    LESS DB "< $"
    EQUAL DB "= $"    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT
    MOV N,AX    
    CALL NEWLINE    
    MOV CX,N 
    INC CX 
    MOV N,CX    
    LEVEL: 
        MOV CX,N 
        DEC CX  
        MOV N,CX
        CMP CX,0
        JE EXIT
        CALL TAKING_INPUT
        MOV A,AX
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV B,AX
        CALL NEWLINE 
        MOV AX,A  
        CMP AX,B
        JG G  
        CMP AX,B
        JL L    
        CMP AX,B
        JE E        
        G:
            MOV AH,9
            LEA DX,GREAT
            INT 21H     
            CALL NEWLINE
            JMP LEVEL 
        L:
            MOV AH,9
            LEA DX,LESS
            INT 21H 
            CALL NEWLINE
            JMP LEVEL            
        E:
            MOV AH,9
            LEA DX,EQUAL
            INT 21H 
            CALL NEWLINE
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
