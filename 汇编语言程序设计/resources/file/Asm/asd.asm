;αָ��---->���ݶζ���
data segment
  num1 dw 0011h
  num2 dw 0022h
data ends

;αָ��---->����ζ���
code segment
assume cs:code,ds:data
 start: mov ax,num1;
      mov bx,num2;
      xor ax,bx
      xor bx,ax
      xor ax,bx
      mov ax,4c00h
   int 21h
code ends
end start 