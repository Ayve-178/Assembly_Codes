.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$')
    E DB "ENGLISH $"
    S DB "SPANISH $"
    G DB "GERMAN $"
    F DB "FRENCH $"
    I DB "ITALIAN $"
    R DB "RUSSIAN $"
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
            MOV AH,2    ;NEWLINE
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H             
            CMP [0],72
            JE HHH
            CMP [0],66
            JE FFF 
            CMP [0],67
            JE III
            CMP [0],90
            JE RRR
            HHH:
                CMP [1],69
                JE EEE
                CMP [1],79
                JE SSS
                CMP [1],65
                JE GGG
            EEE:
                MOV AH,9
                LEA DX,E
                INT 21H
                JMP EXIT             
            SSS:
                MOV AH,9
                LEA DX,S
                INT 21H
                JMP EXIT 
            GGG:
                MOV AH,9
                LEA DX,G
                INT 21H 
                JMP EXIT 
            FFF: 
                MOV AH,9
                LEA DX,F
                INT 21H 
                JMP EXIT
            III:        
                MOV AH,9
                LEA DX,I
                INT 21H 
                JMP EXIT
            RRR:        
                MOV AH,9
                LEA DX,R
                INT 21H 
                JMP EXIT      
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
