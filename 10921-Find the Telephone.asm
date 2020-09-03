.MODEL SMALL
.STACK 100H
.DATA
    VAR1 DB 100 DUP('$')
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX    
    MOV SI,OFFSET VAR1    
    LEBEL:
        MOV AH,1
        INT 21H                   
        CMP AL,13
        JE OUTPUTT                   
        MOV [SI],AL 
        INC SI
        JMP LEBEL 
    OUTPUTT:
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        MOV CX,SI
        INC CX
        MOV SI,0    
    OUTPUT:
        DEC CX
        CMP CX,0
        JE EXIT    
        CMP [SI],45 ;IF([SI]==-)
        JE HIF
        CMP [SI],49 ;IF([SI]==1)
        JE ONE
        CMP [SI],65 ;IF([SI]==A)
        JE TWO
        CMP [SI],66
        JE TWO
        CMP [SI],67
        JE TWO
        CMP [SI],68
        JE THREE
        CMP [SI],69
        JE THREE
        CMP [SI],70
        JE THREE
        CMP [SI],71
        JE FOUR 
        CMP [SI],72
        JE FOUR
        CMP [SI],73
        JE FOUR
        CMP [SI],74
        JE FIVE 
        CMP [SI],75
        JE FIVE 
        CMP [SI],76
        JE FIVE 
        CMP [SI],77
        JE SIX
        CMP [SI],78
        JE SIX
        CMP [SI],79
        JE SIX
        CMP [SI],80
        JE SEVEN
        CMP [SI],81
        JE SEVEN
        CMP [SI],82
        JE SEVEN
        CMP [SI],83
        JE SEVEN
        CMP [SI],84
        JE EIGHT
        CMP [SI],85
        JE EIGHT
        CMP [SI],86
        JE EIGHT
        CMP [SI],87
        JE NINE
        CMP [SI],88
        JE NINE
        CMP [SI],89
        JE NINE
        CMP [SI],90  ;IF([SI]==Z)
        JE NINE  
    HIF: 
        MOV AH,2
        MOV DL,45
        INT 21H
        INC SI
        JMP OUTPUT
    ONE:          
        MOV AH,2
        MOV DL,49
        INT 21H
        INC SI
        JMP OUTPUT
    TWO:          
        MOV AH,2
        MOV DL,50
        INT 21H
        INC SI
        JMP OUTPUT
    THREE:        
        MOV AH,2
        MOV DL,51
        INT 21H
        INC SI
        JMP OUTPUT
    FOUR:         
        MOV AH,2
        MOV DL,52
        INT 21H
        INC SI
        JMP OUTPUT
    FIVE:         
        MOV AH,2
        MOV DL,53
        INT 21H
        INC SI
        JMP OUTPUT
    SIX:          
        MOV AH,2
        MOV DL,54
        INT 21H
        INC SI
        JMP OUTPUT
    SEVEN:        
        MOV AH,2
        MOV DL,55
        INT 21H
        INC SI
        JMP OUTPUT
    EIGHT:
        MOV AH,2
        MOV DL,56
        INT 21H
        INC SI
        JMP OUTPUT
    NINE:         
        MOV AH,2
        MOV DL,57
        INT 21H
        INC SI
        JMP OUTPUT
    EXIT:  
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
