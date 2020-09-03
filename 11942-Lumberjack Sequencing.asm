.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    N DW ?
    K DW ?
    X DW ?
    XXX DW ?
    UP DW ?
    LO DW ? 
    O DB "Ordered $"
    U DB "Unordered $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV T,10 
    MOV UP,0
    MOV LO,0
    MOV X,0
    MOV XXX,0         
    MOV CX,T
    INC CX
    MOV T,CX
    LEVEL: 
        MOV CX,T
        DEC CX
        MOV T,CX
        CMP CX,0
        JE OUTPUT
        CALL TAKING_INPUT
        MOV N,AX       ;NUMBER
        CALL NEWLINE    
        MOV AX,N
        MOV BX,X
        CMP BX,0
        JE FF
        JNE OK        
        FF:
            MOV X,1
            MOV K,AX    ;FIRST NUMBER
            JMP LEVEL
        OK:
            CMP AX,K
            JL UPPER   ;IF(K>N)
            JG LOWER   ;IF(K<N)
        UPPER:
            MOV UP,1
            MOV CX,LO
            CMP CX,0   ;IF(LO!=0) THEN Unordered
            JNE UN
            JMP LEVEL
        LOWER:
            MOV LO,1
            MOV CX,UP
            CMP CX,0   ;IF(UP!=0) THEN Unordered
            JNE UN
            JMP LEVEL            
        UN:
            MOV XXX,1 
            JMP LEVEL
        OUTPUT:
            MOV CX,XXX  ;IF(XXX==0) THEN Ordered
            CMP CX,0
            JE OOO
            JNE UUU
        OOO:
            MOV AH,9
            LEA DX,O
            INT 21H
            JMP EXIT 
        UUU:
            MOV AH,9
            LEA DX,U
            INT 21H
            JMP EXIT                
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
END MAIN
