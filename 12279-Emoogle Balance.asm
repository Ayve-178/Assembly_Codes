.MODEL SMALL
.STACK 100H
.DATA
    N DW ?
    E DW ? 
    Z DW ?
    P DW ?    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV Z,0
    MOV P,0    
    CALL TAKING_INPUT  
    MOV N,AX        ;HOW MANY NUMBERS
    CALL NEWLINE      
    MOV CX,N
    INC CX
    MOV N,CX
    LEVEL: 
        MOV CX,N
        DEC CX
        MOV N,CX
        CMP CX,0
        JE OUTPUT
        CALL TAKING_INPUT
        MOV E,AX       ;ELEMENT
        CALL NEWLINE    
        MOV AX,E
        CMP AX,0
        JE ZZ
        JNE NZ
        ZZ:
            MOV BX,Z
            INC BX
            MOV Z,BX 
            JMP LEVEL
        NZ:
            MOV BX,P
            INC BX
            MOV P,BX
            JMP LEVEL
        OUTPUT:
            MOV AX,P
            SUB AX,Z  ;AX=P-Z
            CALL PRINTING_OUTPUT
            CALL NEWLINE    
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
