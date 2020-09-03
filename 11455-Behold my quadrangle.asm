.MODEL SMALL
.STACK 100H
.DATA
    A DW ?
    B DW ?
    C DW ?
    D DW ?
    Q DB "quadrangle $"
    R DB "rectangle $"
    S DB "square $"
    BA DB "banana $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    CALL TAKING_INPUT  
    MOV A,AX       
    CALL NEWLINE 
    CALL TAKING_INPUT  
    MOV B,AX       
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV C,AX       
    CALL NEWLINE
    CALL TAKING_INPUT  
    MOV D,AX       
    CALL NEWLINE     
    MOV AX,A
    CMP AX,B
    JE CBC 
    CBC:
        MOV AX,B
        CMP AX,C
        JE CCD
        JNE REC
    CCD:
        MOV AX,C
        CMP AX,D
        JE SSS 
    REC:
        MOV AX,A
        CMP AX,C
        JE CBD
        JNE QUAR
    CBD:
        MOV AX,B
        CMP AX,D
        JE RRR
        JNE QUAR
    QUAR:
        MOV AX,A
        ADD AX,B
        ADD AX,C
        CMP AX,D  ;IF(A+B+C>=D) 
        JL BBB
        MOV AX,B
        ADD AX,C
        ADD AX,D
        CMP AX,A  ;IF(D+B+C>=A) 
        JL BBB
        MOV AX,A
        ADD AX,B
        ADD AX,D
        CMP AX,C  ;IF(A+B+D>=C) 
        JL BBB  
        MOV AX,A
        ADD AX,C
        ADD AX,D
        CMP AX,B  ;IF(A+C+D>=B) 
        JL BBB
        JMP QQQ               
    SSS:
        MOV AH,9
        LEA DX,S
        INT 21H
        JMP EXIT 
    QQQ:
        MOV AH,9
        LEA DX,Q
        INT 21H
        JMP EXIT
    RRR:
        MOV AH,9
        LEA DX,R
        INT 21H
        JMP EXIT
    BBB:
        MOV AH,9
        LEA DX,BA
        INT 21H
        JMP EXIT            
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
