.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    A DW ?
    B DW ?
    C DW ? 
    INV DB "Invalid $"
    EQQ DB "Equilateral $"
    ISO DB "Isosceles $"
    SCA DB "Scalene $"
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
        MOV A,AX       ;LENGTH
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV B,AX       ;LENGTH
        CALL NEWLINE 
        CALL TAKING_INPUT
        MOV C,AX       ;LENGTH
        CALL NEWLINE
        MOV AX,A
        ADD AX,B  ;AX=A+B
        CMP AX,C  ;IF(B+A>=C)
        JLE INVALID
        MOV AX,B
        ADD AX,C  ;AX=B+C
        CMP AX,A  ;IF(B+C>=A)
        JLE INVALID
        MOV AX,A
        ADD AX,C  ;AX=A+C
        CMP AX,B  ;IF(A+C>=B)
        JLE INVALID
        MOV AX,A
        CMP AX,B
        JE CB
        JNE CC        
        CC:
            MOV BX,B  
            CMP BX,C  ;IF(B==C)
            JE EQUIL
            JNE SCAL        
        CB:
            MOV AX,B
            CMP AX,C  ;IF(B==C)
            JE EQUIL
            JNE ISOS
        EQUIL:
            MOV AH,9
            LEA DX,EQQ
            INT 21H
            CALL NEWLINE
            JMP LEVEL
        ISOS:
            MOV AH,9
            LEA DX,ISO
            INT 21H
            CALL NEWLINE
            JMP LEVEL
        SCAL:
            MOV AH,9
            LEA DX,SCA
            INT 21H
            CALL NEWLINE        
            JMP LEVEL
        INVALID:
            MOV AH,9
            LEA DX,INV
            INT 21H
            CALL NEWLINE
            JMP LEVEL            
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
