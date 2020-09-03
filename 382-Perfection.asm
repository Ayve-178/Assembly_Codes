.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    N DW ? 
    SUM DW ?    
    S DW "PERFECTION OUTPUT $"
    D DW "DEFICIENT $" 
    P DW "PERFECT $"
    A DW "ABUNDANT $" 
    E DW "END OF OUTPUT $"
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
    MOV AH,9
    LEA DX,S
    INT 21H 
    CALL NEWLINE    
    LEVEL:  
        MOV SUM,0
        MOV CX,T
        DEC CX
        MOV T,CX
        CMP CX,0
        JE EXIT
        CALL TAKING_INPUT
        MOV N,AX        
        CALL NEWLINE
        MOV BX,0   
        PROC1: 
            INC BX
            CMP BX,N
            JE OUTPUT
            MOV DX,0 
            MOV AX,N   ;AX=N
            DIV BX     ;AX=N/BX 
            CMP DX,0   ;DX=N%BX
            JE ADDD
            JMP PROC1
        ADDD:
            ADD SUM,BX   ;SUM=SUM+BX
            JMP PROC1              
        OUTPUT: 
            MOV AX,N     ;AX=N
            CMP AX,SUM   ;IF(SUM==AX)
            JE PER  
            JL ABU 
            JG DEF            
        PER:
            MOV AH,9
            LEA DX,P
            INT 21H
            CALL NEWLINE 
            JMP LEVEL 
        DEF:
            MOV AH,9
            LEA DX,D
            INT 21H
            CALL NEWLINE 
            JMP LEVEL
        ABU:
            MOV AH,9
            LEA DX,A
            INT 21H
            CALL NEWLINE 
            JMP LEVEL                   
    EXIT: 
        MOV AH,9
        LEA DX,E  
        INT 21H
        CALL NEWLINE
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
END MAIN
