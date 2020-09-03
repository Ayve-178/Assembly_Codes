.MODEL SMALL
.STACK 100H
.DATA
    T DW ?
    N DW ? 
    X DW ?    
    L DB "This is leap year. $"
    H DB "This is huluculu festival year. $"
    B DB "This is bulukulu festival year. $"
    O DB "This is an ordinary year. $"
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
        MOV X,0
        MOV CX,T
        DEC CX
        MOV T,CX
        CMP CX,0
        JE EXIT
        CALL TAKING_INPUT
        MOV N,AX        
        CALL NEWLINE 
        MOV DX,0
        MOV AX,N
        MOV BX,400
        DIV BX   ;AX=N/400
        CMP DX,0
        JE LEAP
        MOV AX,N
        MOV DX,0
        MOV BX,4
        DIV BX    ;AX=BX/4
        CMP DX,0
        JE LL 
        JNE HH
        LL:
            MOV AX,N
            MOV BX,100
            DIV BX  ;AX=N/100
            CMP DX,0
            JNE LEAP
        LEAP:
            MOV AH,9
            LEA DX,L
            INT 21H 
            CALL NEWLINE 
            MOV X,1
        HH:     
            MOV DX,0
            MOV AX,N
            MOV BX,15
            DIV BX  ;AX=N/15
            CMP DX,0
            JE HUL
            JNE BB
        HUL:
            MOV AH,9
            LEA DX,H
            INT 21H 
            CALL NEWLINE  
            MOV X,1
        BB: 
            MOV DX,0
            MOV AX,N
            MOV BX,55
            DIV BX
            CMP DX,0
            JE BUL
            MOV BX,X
            CMP BX,1
            JE LEVEL
            JNE OO 
        BUL:
            MOV AH,9
            LEA DX,B
            INT 21H 
            CALL NEWLINE
            JMP LEVEL
        OO:
            MOV AX,N
            MOV BX,400 
            MOV DX,0
            DIV BX
            CMP DX,0
            JNE OTH
            MOV AX,N
            MOV BX,4 
            MOV DX,0
            DIV BX
            CMP DX,0
            JE LEVEL
            MOV AX,N
            MOV BX,100 
            MOV DX,0
            DIV BX
            CMP DX,0
            JE OTH
            JMP LEVEL
        OTH:     
            MOV AH,9
            LEA DX,O
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
END MAIN
