.MODEL SMALL
.STACK 100H
.DATA 
    T DW ?
    A DW ?
    B DW ?
    SUM DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV SUM,0
    CALL TAKING_INPUT  
    MOV A,AX          ;LOWER LIMIT
    CALL NEWLINE  
    CALL TAKING_INPUT  
    MOV B,AX          ;UPPER LIMIT
    CALL NEWLINE      
    MOV CX,A
    DEC CX
    MOV T,CX
    LEVEL: 
        MOV CX,T
        INC CX
        MOV T,CX
        CMP CX,B
        JG OUTPUT 
        MOV AX,T
        MOV DX,0
        MOV BX,2
        DIV BX
        CMP DX,0
        JNE ISUM
        JMP LEVEL
    ISUM:
        MOV AX,SUM
        ADD AX,T
        MOV SUM,AX 
        JMP LEVEL   
    OUTPUT:
        MOV AX,SUM
        CALL PRINTING_OUTPUT    
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
