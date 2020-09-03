.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$')
    SUM DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    MOV SUM,0    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                  
        CMP AL,13
        JE OUTPUT                   
        MOV [SI],AL 
        INC SI
        CMP AL,97
        JE ONE
        CMP AL,98
        JE TWO
        CMP AL,99
        JE THREE 
        CMP AL,100
        JE ONE 
        CMP AL,101
        JE TWO 
        CMP AL,102
        JE THREE 
        CMP AL,103
        JE ONE 
        CMP AL,104
        JE TWO 
        CMP AL,105
        JE THREE 
        CMP AL,106
        JE ONE
        CMP AL,107
        JE TWO 
        CMP AL,108
        JE THREE 
        CMP AL,109
        JE ONE
        CMP AL,110
        JE TWO 
        CMP AL,111
        JE THREE 
        CMP AL,112
        JE ONE
        CMP AL,113
        JE TWO 
        CMP AL,114
        JE THREE
        CMP AL,115
        JE FOUR 
        CMP AL,116
        JE ONE
        CMP AL,117
        JE TWO 
        CMP AL,118
        JE THREE 
        CMP AL,119
        JE ONE 
        CMP AL,120
        JE TWO  
        CMP AL,121
        JE THREE  
        CMP AL,122
        JE FOUR
        CMP AL,32
        JE ONE
        JMP LEBEL
    ONE: 
        MOV BX,SUM
        ADD BX,1
        MOV SUM,BX
        JMP LEBEL
    TWO:        
        MOV BX,SUM
        ADD BX,2
        MOV SUM,BX
        JMP LEBEL
    THREE:      
        MOV BX,SUM
        ADD BX,3
        MOV SUM,BX
        JMP LEBEL
    FOUR:        
        MOV BX,SUM
        ADD BX,4
        MOV SUM,BX
        JMP LEBEL
    OUTPUT:
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        MOV AX,SUM
        CALL PRINTING_OUTPUT            
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP   

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
