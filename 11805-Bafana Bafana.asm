.MODEL SMALL
.STACK 100H
.DATA
    N DW ?
    K DW ?
    P DW ?
    S DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT  
    MOV N,AX          
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV K,AX          
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV P,AX          
    CALL NEWLINE      
    MOV AX,K
    ADD AX,P
    MOV S,AX  ;S=K+P
    LEVEL: 
        MOV CX,S        
        MOV S,CX
        CMP CX,N
        JLE OUTPUT
        MOV AX,S
        SUB AX,N
        MOV S,AX
        JMP LEVEL 
    OUTPUT:
        MOV AX,S
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
