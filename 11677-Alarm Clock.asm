.MODEL SMALL
.STACK 100H
.DATA
    H1 DW ?
    M1 DW ?
    H2 DW ? 
    M2 DW ?
    H DW ?
    M DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT  
    MOV H1,AX          
    CALL NEWLINE  
    CALL TAKING_INPUT  
    MOV M1,AX          
    CALL NEWLINE  
    CALL TAKING_INPUT  
    MOV H2,AX          
    CALL NEWLINE  
    CALL TAKING_INPUT  
    MOV M2,AX          
    CALL NEWLINE      
    MOV AX,H2
    SUB AX,H1  ;AX=H2-H1
    MOV H,AX   ;H=H2-H1
    MOV AX,M2
    SUB AX,M1  ;AX=M2-M1
    MOV M,AX   ;M=M2-M1  
    CMP AX,0
    JL MIN 
    MOV AX,H 
    CMP AX,0
    JL HOUR
    JMP CALCC
    MIN:
        MOV AX,M
        ADD AX,60 ;M=M+60
        MOV M,AX   
        MOV AX,H
        DEC AX     ;H-- 
        MOV H,AX
        CMP AX,0
        JL HOUR
        JMP CALCC
    HOUR:
        MOV AX,H
        ADD AX,24   ;H=H+24  
    CALCC:  
        MOV AX,H
        MOV BX,60
        MUL BX      ;AX=H*60 
        ADD AX,M    ;AX=AX+M
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
