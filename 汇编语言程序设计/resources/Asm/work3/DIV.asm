DATA SEGMENT
	da dw 1D
        sum db 0
DATA ENDS
;----------------------------------
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX,DATA
	MOV DS,AX
	MOV CX,150      ;循环150次
	
LOP:    
        xor ax,ax
        mov ax,da
        mov bx,2d
        DIV bx
        
        cmp ah,0
        je B1;能被2整除跳转到B1

        jmp B4

B1:
xor ax,ax
mov ax,da
mov bx,3d
DIV bx
cmp ah,0
jne B2
jmp B4

B2:
INC sum
jmp B4
B4:
        INC da;              
        LOOP LOP

        MOV AH,02H
	MOV DL,sum
	INT 21H
        mov ax,4c00h
        int 21H


CODE ENDS
	END START
