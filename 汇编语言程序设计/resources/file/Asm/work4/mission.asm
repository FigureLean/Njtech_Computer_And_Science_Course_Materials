.model small
.data
score db 80,60,49,86,100,79,85,86,99,59;成绩数组
rank db 10 dup(?);排名数组
.code
start:
mov ax, @data ;数据段送入AX
mov ds, ax      ;AX送入代码段
mov si, 0     ;变址寄存器置0
mov cx, 10    ;数据段
lp1:
mov al, 1
mov di, 0     ;di地址
push cx       ;cx入栈
mov cx, 10
lp2:
mov ah, score[di]
cmp ah, score[si]
jbe next      ;小于等于则跳转
inc al        ;累加计数          
next:
inc di
loop lp2
pop cx          ;CX出栈
mov rank[si], al ;将数据送入排名数组
inc si
loop lp1

mov ax, 4c00h
int 21h
end start
