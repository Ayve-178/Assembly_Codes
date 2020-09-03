.MODEL SMALL
.STACK 100H
.DATA
    E DW ?
    F DW ?
    C DW ?
    EB DW ?
    FB DW ?
    SUM DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    MOV SUM,0  
    CALL TAKING_INPUT  
    MOV E,AX          ;POSSESES
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV F,AX          ;FOUND
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV C,AX          ;NEED TO BUY A NEW
    CALL NEWLINE      
    MOV AX,E
    ADD AX,F      ;AX=E+F
    MOV EB,AX     ;EB=E+F
    LEVEL:
        MOV BX,EB
        CMP BX,C
        JL OUTPUT
        MOV AX,EB
        MOV BX,C
        MOV DX,0
        DIV BX     ;AX=EB/C
        MOV FB,AX
        MOV CX,SUM
        ADD CX,FB ;SUM=SUM+CX
        MOV SUM,CX
        ADD DX,FB  ;DX=DX+FB
        MOV EB,DX  ;EB=DX 
        JMP LEVEL
    OUTPUT:     
        MOV AX,SUM
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
