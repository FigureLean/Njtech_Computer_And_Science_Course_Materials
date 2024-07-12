data segment
    ;数据段代码：给成绩赋值及创建分类单元
    grade db 46,68,88,87,76,89,99,65,100,80     ;成绩赋值
    output db 'THE RESULT $'        ;输出语句
    enter db 13,10,'$'
    s5 db 0     ;<60
    s6 db 0     ;60~69
    s7 db 0     ;70~79
    s8 db 0     ;80~89
    s9 db 0     ;90~99
    s10 db 0    ;100
data ends

code segment
assume cs:code,ds:data
start:  
    ;代码段代码
     mov ax,data
     mov ds,ax
     mov bx,0
     mov cx,10

loop1:
     cmp cx,0
     jz next    ;cx=0相等则跳转至next
     mov dl,grade[bx]   ;下一个学生成绩进入dh
     inc bx     ;bx++
     dec cx     ;cx--
     ;讨论成绩分类
     cmp dl,100
     jz scr10     ;=100 -> scr10
     cmp dl,90
     jge scr9     ;≥90 > scr9
     cmp dl,80
     jge scr8     ;≥80 -> scr8
     cmp dl,70
     jge scr7     ;≥70 -> scr7
     cmp dl,60
     jge scr6     ;≥60 -> scr6
     cmp dl,0 
     jge scr5     ;≥50 -> scr5

scr5:
     inc s5       ;s5++（人数）
	 jmp loop1    ;跳回loop1
scr6:
     inc s6
	 jmp loop1
scr7:
     inc s7
	 jmp loop1
scr8:
     inc s8
	 jmp loop1
scr9:
     inc s9
	 jmp loop1
scr10:
     inc s10
	 jmp loop1

next:
     mov cx,6
	 mov bx,0
loop2:
     cmp cx,0
	 jz ending

     lea dx,output
     mov ah,09h
     int 21h

     mov dl,s5[bx]
     add dl,30h
     mov ah,02h
     int 21h

     mov dx,offset enter
     mov ah,09h
     int 21h

     dec cx
     inc bx
     jmp loop2
		
ending:
     mov ax,4c00h
     int 21h
code ends
end start
