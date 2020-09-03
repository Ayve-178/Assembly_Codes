.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    A DW ?
    B DW ?  
    C DW ?       
    STAR DW "* $"
    FIRST DW "A $"
    SECOND DW "B $"
    THIRD DW "C $"
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
        MOV A,AX        ;ALICE'S VALUE
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV B,AX         ;BETO'S VALUE
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV C,AX         ;CLARA'S VALUE
        CALL NEWLINE  
        MOV AX,A
        CMP AX,B         ;IF(A==B)
        JE ONE
        JNE TWO        
        ONE:
            MOV AX,C
            CMP AX,B     ;IF(B==C)
            JE S
            JNE CC       
        TWO:
            MOV AX,C
            CMP AX,B    ;IF(B==C)
            JE AA
            JNE THREE                    
        THREE:
            CMP AX,A     ;IF(C==A)
            JE BB            
        S:             ;NO WINNER
            MOV AH,9
            LEA DX,STAR
            INT 21H
            CALL NEWLINE
            JMP LEVEL               
        AA:           ;ALICE WINNER
            MOV AH,9
            LEA DX,FIRST
            INT 21H
            CALL NEWLINE
            JMP LEVEL            
        BB:          ;BETO WINNER
            MOV AH,9
            LEA DX,SECOND
            INT 21H
            CALL NEWLINE
            JMP LEVEL            
        CC:           ;CLARA WINNER
            MOV AH,9
            LEA DX,THIRD
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
