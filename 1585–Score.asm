.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$')
    T DW ?
    C DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV T,0
    MOV C,0    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE OUTPUT
        MOV [SI],AL 
        INC SI
        CMP AL,79
        JE ZZ 
        JMP XX
        JMP LEBEL        
        ZZ:
            MOV DX,T
            CMP DX,0 
            JE ZZZ 
            JNE ZZN
        ZZZ:
            MOV CX,1            
            MOV BX,C
            ADD BX,CX
            MOV C,BX 
            MOV T,1  
            JMP LEBEL
        ZZN:
            INC CX
            MOV BX,C
            ADD BX,CX
            MOV C,BX
            JMP LEBEL
        XX:
            MOV T,0
            JMP LEBEL
        OUTPUT:
            CALL NEWLINE
            MOV AX,C
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
