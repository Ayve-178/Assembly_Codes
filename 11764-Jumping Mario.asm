.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    N DW ?
    K DW ?
    X DW ?
    U DW ?
    D DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    MOV X,0   
    CALL TAKING_INPUT  
    MOV T,AX          ;HOW MANY NUMBERS
    CALL NEWLINE      
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
        JNE SE
        FF:
            MOV X,1
            MOV K,AX   ;COMPARE WITH THE PREVIOUS INPUT
            JMP LEVEL 
        SE:    
            CMP AX,K
            JL UP
            JG DOWN 
            JE LEVEL
        UP:  
            MOV DX,U
            INC DX     ;U++
            MOV U,DX
            MOV K,AX
            JMP LEVEL    
        DOWN:
            MOV DX,D
            INC DX     ;D++
            MOV D,DX
            MOV K,AX
            JMP LEVEL
        OUTPUT:
            MOV AX,D
            CALL PRINTING_OUTPUT
            CALL NEWLINE
            MOV AX,U 
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
