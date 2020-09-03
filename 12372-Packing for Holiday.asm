.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    L DW ?
    W DW ?
    H DW ?     
    GOOD DB "Good $"
    BADD DB "Bad $"    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT  
    MOV T,AX   
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
        MOV L,AX 
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV W,AX 
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV H,AX
        CALL NEWLINE
        MOV BX,L
        CMP BX,20
        JLE CHECK_W
        JMP BAD
        CHECK_W:
            MOV BX,W
            CMP BX,20
            JLE CHECK_H
            JMP BAD
        CHECK_H:
            MOV BX,H
            CMP BX,20
            JLE OUTPUT
            JMP BAD            
        OUTPUT:  
            LEA DX,GOOD
            MOV AH,9 
            INT 21H
            CALL NEWLINE
            JMP LEVEL
        BAD:
            LEA DX,BADD
            MOV AH,9 
            INT 21H    
            CALL NEWLINE
            LOOP LEVEL           
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
