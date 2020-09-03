.MODEL SMALL
.STACK 100H
.DATA
    NUM1 DW ?
    NUM2 DW ?     
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    LOOP_:  
        CALL TAKING_INPUT
        MOV NUM1,AX 
        CMP AX,0   ;IF(AX==0)BREAK;
        JE EXIT  
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV NUM2,AX  
        CALL NEWLINE
        MOV AX,NUM2
        MUL NUM1     ;AX=NUM1*NUM2 
        SUB AX,1     ;AX=AX-1        
    OUTPUT:
        CALL PRINTING_OUTPUT   
        CALL NEWLINE
        JMP LOOP_     
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
