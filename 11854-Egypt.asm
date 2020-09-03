.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    A DW ?
    B DW ?  
    C DW ?       
    R DW "Right $"
    W DW "Wrong $"
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
        MOV A,AX        ;LENGTH OF A TRIANGLE
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV B,AX         ;LENGTH OF A TRIANGLE
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV C,AX         ;LENGTH OF A TRIANGLE
        CALL NEWLINE  
        MOV AX,C
        MOV BX,C
        MUL BX  ;AX=C*C
        MOV C,AX
        MOV AX,A
        MOV BX,A
        MUL BX  ;AX=A*A
        MOV A,AX
        MOV AX,B
        MOV BX,B
        MUL BX  ;AX=B*B
        MOV B,AX       
        ADD AX,A
        CMP AX,C
        JE RIGHT
        MOV AX,B
        ADD AX,C
        CMP AX,A
        JE RIGHT
        MOV AX,C
        ADD AX,A
        CMP AX,B
        JE RIGHT        
        WRONG:
            MOV AH,9
            LEA DX,W
            INT 21H
            CALL NEWLINE
            JMP LEVEL       
        RIGHT:
            MOV AH,9
            LEA DX,R
            INT 21H
            CALL NEWLINE
            JMP LEVEL                   
    EXIT:
        MOV AH,4CH
        INT 21H         
    MAIN ENDP  

NEWLINE PROC      ;NEWLINE
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        RET            
    NEWLINE ENDP

TAKING_INPUT PROC    ;MULTIPLE DIGIT INPUT
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
