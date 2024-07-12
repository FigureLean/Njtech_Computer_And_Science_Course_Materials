DATA SEGMENT 
        ARRAY DB 46,68,88,87,76,89,99,65,100,80
        STRING db 'abc' ,'$'
        N EQU $-ARRAY
        MAX DB ?
        MIN DB ?
DATA ENDS

CODE SEGMENT 
        ASSUME DS:DATA,CS:CODE
        START:
        
        MOV ax,DATA
        MOV ds,ax
        
        MOV CX,N
        MOV di,-1;
        MOV BL,0

        
        NEXT:
        INC di
        MOV BH,ARRAY[di]
        CMP BH,BL
        JA s1
        LOOP NEXT
        MOV MAX,BL
        JMP EXIT


        s1:
        XOR BL,BL
        MOV BL,BH
        JMP NEXT

       EXIT:
       MOV dl,BL
       or dl,30h
        MOV AH ,2
        INT 21H
       MOV ax,4c00H
       INT 21H


CODE ENDS
END START