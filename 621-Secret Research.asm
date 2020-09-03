.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$') 
    L DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE OUTPUT                   
        MOV [SI],AL 
        INC SI
        JMP LEBEL
    OUTPUT: 
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H 
        DEC SI
        CMP SI,1 ;IF(STRING SIZE==1)
        JE ONE
        CMP SI,2 ;IF(STRING SIZE==2)
        JE TWO
        CMP [SI],53 ;IF([LAST INDEX]==5)
        JE CN 
        CMP [SI],52 ;IF([LAST INDEX]==4)
        JE CEF
        CMP [0],49  ;IF([FIRST INDEX]==1)
        JE CENC
        ONE:
            CMP [0],49 ;IF([FIRST INDEX]==1)
            JE POS
            CMP [0],55 ;IF([FIRST INDEX]==7)
            JE POS
        TWO:
            CMP [0],55 ;IF([FIRST INDEX]==7)
            JE CT
        CT:
            CMP [1],56  ;IF([SECOND INDEX]==8)
            JE POS    
        POS:
            MOV AH,2
            MOV DL,43
            INT 21H
            JMP EXIT 
        NEGG:
            MOV AH,2
            MOV DL,45
            INT 21H
            JMP EXIT 
        EXF:
            MOV AH,2
            MOV DL,42
            INT 21H
            JMP EXIT 
        ENC:
            MOV AH,2
            MOV DL,63
            INT 21H
            JMP EXIT          
        CN:
            DEC SI
            CMP [SI],51
            JE NEGG
        CEF:
            CMP [0],57
            JE EXF 
        CENC:
            CMP [1],57
            JE CCENC
        CCENC:
            CMP [2],48
            JE ENC                       
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
