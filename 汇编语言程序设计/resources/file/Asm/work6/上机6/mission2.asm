.model small
.data
str db 2 dup(10)  ; 保存输入
fib dw 0,1,23 dup(-1)  ; 保存斐波那契数
.stack
dw 128 dup(?)
.code
start:

    mov ax, @data
    mov ds, ax

    mov si, 0  ; 下标
    mov cx, 2

    s1:
        mov ah, 01h ; 输入
        int 21h
        cmp al, 13  ; 判断是否回车
        je break1
        sub al, 48  ; ASCII(0) = 48
        mov str[si], al
        inc si
        loop s1

    break1:
        cmp cx, 0  ; 如果输入了 2 个数则换行
        jne exit
        mov dl, 10
        mov ah, 02h
        int 21h
    exit:
        cmp cx, 0
        je next
        ; 1 位数
        mov cl, str[0]
        mov ch, 0
        jmp short break2
    next:  ; 2 位数
        mov al, str[0]
        mov ah, 10
        mul ah
        mov bl, str[1]
        mov bh, 0
        add ax, bx
        mov cx, ax
    break2:

        call function

    mov ax, bx
    mov bx, 0  ; 栈的高度
    mov cx, 5  ; 0 - 65535 最大位数为 5

    s2:
        mov dl, 10
        div dl
        mov dh, 0
        mov dl, ah
        push dx
        inc bx
        mov ah, 0
        cmp ax, 0
        je break3
        loop s2

    break3:
        mov cx, bx

    s3:
    pop dx
    add dl, 48
    mov ah, 02h
    int 21h
    loop s3

    mov ax, 4c00h
    int 21h

function:
    push ax  ; 保存 ax，因为乘法需要用到 ax
    mov al, cl
    mov ah, 0
    mov dl, 2
    mul dl
    mov si, ax  ; 2 * cx 对应斐波那契数组的坐标
    cmp fib[si], -1  ; 检查是否已经计算过
    je calculate
    mov bx, fib[si]  ; 直接使用计算好的值
    jmp short return
    calculate:

        dec cx
        call function
        mov ax, bx
        dec cx
        call function
        add ax, bx
        mov bx, ax

        add cx, 2  ; 恢复 cx
        mov al, cl
        mov ah, 0
        mul dl
        mov si, ax  ; 将计算好的数值放入斐波那契数组中
        mov fib[si], bx

    return:
        pop ax
        ret

end start
