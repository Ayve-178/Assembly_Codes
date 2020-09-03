.MODEL SMALL
.STACK 100H
.DATA  
    T DW ?
    NUM1 DW ?
    NUM2 DW ? 
    NUM3 DW ? 
    RESULT DW ?    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX     
    CALL TAKING_INPUT
    MOV T,AX 
    CALL NEWLINE
    MOV DX,T  
    ADD DX,1     
    LOOP_:  
        SUB DX,1
        CMP DX,0
        JE EXIT
        CALL TAKING_INPUT
        MOV NUM1,AX   
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV NUM2,AX  
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV NUM3,AX  
        CALL NEWLINE        
        MOV BX,NUM1    ;CHECKING NUM1
        CMP BX,NUM2
        JG CASE_A  
        CMP BX,NUM3
        JG CASE_A1
        MOV BX,NUM2   ;CHECKING NUM2
        CMP BX,NUM1
        JG CASE_B  
        CMP BX,NUM3
        JG CASE_B1         
        MOV BX,NUM3
        JMP CASE_R         ;IF NUM1 OR NUM2 IS NOT...THEN OFCOURSE NUM3 IS THE MIDDLE NUMBER         
        CASE_A:
            CMP BX,NUM3
            JL CASE_R      ;NUM1 IS THE MIDDLE NUMBER
        CASE_A1:
            CMP BX,NUM2
            JL CASE_R      ;NUM1 IS THE MIDDLE NUMBER                
        CASE_B:
            CMP BX,NUM3
            JL CASE_R      ;NUM2 IS THE MIDDLE NUMBER
        CASE_B1:
            CMP BX,NUM1
            JL CASE_R      ;NUM2 IS THE MIDDLE NUMBER        
        CASE_R: 
            MOV RESULT,BX
            JMP OUTPUT       
        
    OUTPUT:  
        MOV AX,RESULT
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
