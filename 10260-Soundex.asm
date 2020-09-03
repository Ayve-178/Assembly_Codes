.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$') 
    C DW ?
    I DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    MOV CX,0   
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE OUTPUTT                   
        MOV [SI],AL 
        INC SI 
        JMP LEBEL
        MOV C,CX
        MOV CX,48        
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H 
        MOV I,0 
        OUTPUTT: 
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H
            MOV CX,SI
            INC CX
            MOV SI,0
            JMP OUTPUT       
        OUTPUT: 
            DEC CX
            CMP CX,0
            JE EXIT 
            CMP [SI],66  ;IF([SI]==B)
            JE ONE
            CMP [SI],70
            JE ONE
            CMP [SI],80
            JE ONE
            CMP [SI],86
            JE ONE
            CMP [SI],67
            JE TWO
            CMP [SI],71
            JE TWO
            CMP [SI],74
            JE TWO
            CMP [SI],75
            JE TWO
            CMP [SI],81
            JE TWO
            CMP [SI],83
            JE TWO
            CMP [SI],88
            JE TWO
            CMP [SI],90
            JE TWO
            CMP [SI],68
            JE THREE 
            CMP [SI],84
            JE THREE
            CMP [SI],76
            JE FOUR
            CMP [SI],77
            JE FIVE
            CMP [SI],78
            JE FIVE
            CMP [SI],82
            JE SIX 
            INC SI
            JMP OUTPUT
        ONE: 
            MOV AH,2
            MOV DL,49
            INT 21H   ;PRINTING 1
            INC SI
            JMP OUTPUT
        TWO:          
            MOV AH,2
            MOV DL,50
            INT 21H   ;PRINTING 2
            INC SI 
            JMP OUTPUT
        THREE:        
            MOV AH,2
            MOV DL,51
            INT 21H    ;PRINTING 3
            INC SI 
            JMP OUTPUT
        FOUR:         
            MOV AH,2
            MOV DL,52
            INT 21H     ;PRINTING 4
            INC SI
            JMP OUTPUT
        FIVE:         
            MOV AH,2
            MOV DL,53
            INT 21H      ;PRINTING 5
            INC SI
            JMP OUTPUT
        SIX:          
            MOV AH,2
            MOV DL,54
            INT 21H      ;PRINTING 6
            INC SI
            JMP OUTPUT
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
