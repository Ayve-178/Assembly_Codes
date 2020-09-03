.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    A DW ?
    B DW ?
    C DW ?
    D DW ?
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
        MOV A,AX        ;CURRENT CHANNEL
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV B,AX        ;NEXT CHANNEL
        CALL NEWLINE 
        CMP AX, A
        JL XC        
        OUTPUT:
          MOV AX,B
          SUB AX,A   ;AX=B-A
          MOV C,AX   ;C=AX
          MOV AX,100
          SUB AX,B   ;AX=100-B
          ADD AX,A   ;AX=(100-B)+A
          MOV D,AX   ;D=AX
          CMP AX,C   ;IF(D<=C)
          JLE DD
          MOV AX,C
          CALL PRINTING_OUTPUT ;PRINTING D
          CALL NEWLINE
          JMP LEVEL          
        DD:
            CALL PRINTING_OUTPUT  ;PRINTING D
            CALL NEWLINE
            JMP LEVEL          
        XC:      
            MOV BX,A
            XCHG AX,BX   ;A=B & B=A
            JMP OUTPUT             
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
