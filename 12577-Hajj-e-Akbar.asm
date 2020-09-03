.MODEL SMALL
.STACK 100H
.DATA 
    VAR1 DB 100 DUP('$')
    HAJJ DB "Hajj-e-Akbar $"
    UMRAH DB "Hajj-e-Asghar $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    MOV AX,0    
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
        CMP [0],72 
        JE H
        JNE U       
        H:
            MOV AH,9
            LEA DX,HAJJ
            INT 21H
            JMP EXIT
        U:
            MOV AH,9
            LEA DX,UMRAH
            INT 21H
            JMP EXIT    
        EXIT:
            MOV AH,4CH
            INT 21H                
    MAIN ENDP
END MAIN
