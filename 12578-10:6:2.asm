.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    L DW ?
    AR DW ?
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
        MOV L,AX       ;LENGTH OF THE FLAG
        CALL NEWLINE    
        MOV AX,L
        MOV BX,2
        MUL BX   ;AX=2*L
        MOV DX,0
        MOV BX,10
        DIV BX   ;AX=(2*L)/10
        MOV BX,AX ;BX=AX
        MUL BX    ;AX=BX*BX
        MOV BX,3  ;CONSIDERING PI=3
        MUL BX    ;AX=THE AREA OF RED PORTION
        MOV AR,AX
        CALL PRINTING_OUTPUT
        CALL NEWLINE
        MOV AX,L
        MOV BX,6
        MUL BX    ;AX=6*L
        MOV BX,10
        DIV BX    ;AX=(6*L)/10
        MOV BX,L  ;BX=L
        MUL BX    ;AX=AX*L
        SUB AX,AR ;AX=AX-AR=THE AREA OF GREEN PORTION
        CALL PRINTING_OUTPUT
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
