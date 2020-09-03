.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    X DW ?
    Y DW ?
    R DW ?
    S DW ?
    H DW ?
    W DW ?
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
        MOV X,AX       ;X EXIS
        CALL NEWLINE    
        CALL TAKING_INPUT
        MOV Y,AX        ;Y EXIS
        CALL NEWLINE
        CALL TAKING_INPUT
        MOV R,AX        ;RADIUS
        CALL NEWLINE
        MOV AX,X
        MOV BX,X
        MUL BX     ;AX=X*X
        MOV X,AX   ;X=X*X 
        MOV AX,Y
        MOV BX,Y
        MUL BX     ;AX=Y*Y
        MOV Y,AX   ;Y=Y*Y 
        ADD AX,X   ;AX=(X*X)+(Y*Y)
        CALL SQRT  ;AX=SQRT((X*X)+(Y*Y))
        MOV S,AX   ;S=AX
        SUB AX,R   ;AX=AX-R
        CALL PRINTING_OUTPUT
        CALL NEWLINE 
        MOV AX,S
        ADD AX,R   ;AX=AX+R
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

SQRT PROC 
    MOV W,AX   
    MOV BX,2
    MOV DX,0
    DIV BX   ;AX=AX/2
    MOV CX,AX
    MOV BX,1
    CALCS:
        MOV AX,BX
        MUL BX     ;AX=BX*BX
        CMP AX,W
        JE FOUND 
        JG FF
        INC BX   
        JMP CALCS
    FOUND:
        MOV AX,BX
        RET 
    FF:
       MOV AX,BX
       RET 
    SQRT ENDP
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
