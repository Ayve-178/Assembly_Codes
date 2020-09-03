.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    X DW ?
    Y DW ? 
    Z DW ?
    Q DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT  
    MOV T,AX          ;TEST CASE
    CALL NEWLINE      
    MOV CX,T
    INC CX
    MOV T,CX    
    LEVEL: 
        MOV CX,T
        DEC CX
        MOV T,CX
        CMP CX,0
        JE EXIT
        CALL TAKING_INPUT
        MOV X,AX        
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV Y,AX        
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV Z,AX        
        CALL NEWLINE
        MOV AX,X
        ADD AX,Y   ;AX=X+Y
        MOV BX,3  
        MOV DX,0
        DIV BX     ;AX=(X+Y)/3
        MOV Q,AX
        MOV AX,X
        SUB AX,Q   ;AX=X-Q
        MOV BX,Z
        MUL BX    ;AX=AX*Z
        MOV BX,Q
        DIV BX     ;AX=AX/Q
        CALL PRINTING_OUTPUT
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
