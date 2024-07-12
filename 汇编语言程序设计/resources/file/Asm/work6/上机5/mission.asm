.model small
.386

.data
array dw 55, 10, 25, 13, 90, 5, 15, 24, 68, 20
N equ ($-array)/2
order db N dup(10)
cost dw ?

.stack
dw 10 dup(?)

.code
main proc far
    mov ax, @data
    mov ds, ax      ;

    call input
    call calc
    call crlf       ; 输出回车
    call output

    mov ax, 4c00h
    int 21h
main endp
;------------------------------------------
;------------------------------------------ 显示回车换行
crlf proc near
    push dx         ; 保护现场
    mov dl, 0dh
    mov ah, 2
    int 21h
    mov dl, 0ah
    mov ah, 2
    int 21h
    pop dx
    ret
crlf endp
;------------------------------------------ 输入
input proc near
    push ax         ; 保护现场
    push cx
    push si

    mov ax, 0
    mov si, 0
    mov cx, N

readloop:
    ; 读取
    mov ah, 1
    int 21h
    ; 如果是回车，跳出
    cmp al, 0dh
    je endread
    ; 保存
    sub al, 30h     ; ascii 转 数字
    mov order[si], al
    inc si
    loop readloop

endread:
    pop si
    pop cx
    pop ax
    ret
input endp
;------------------------------------------ 输出（16进制转10进制，并输出）（除10取余法）
output proc near
    push ax
    push bx
    push cx
    push dx

    mov cx, 1
    mov bx, 10
    mov ax, cost
realin:
    div bx          ; 存余数
    push dx         ; 余数进栈
    cmp ax, 0       ; 是否已除净
    jle realout
    mov dx, 0
    inc cx
    jmp realin

realout:
    pop dx
    add dx, 30h
    mov ah, 2       ; 输出
    int 21h
    loop realout

    pop dx
    pop cx
    pop bx
    pop ax
    ret
output endp
;------------------------------------------ 计算
calc proc near
    push ax         ; 保存结果
    push bx         ; 临时存储 array 数组需要的元素
    push cx         ; 循环计数器
    push dx         ; 临时存储 order 数组需要的元素
    push si         ; order 下标

    mov ax, 0
    mov bx, 0
    mov cx, N
    mov dx, 0
    mov si, 0

calcloop:
    mov dl, order[si]
    ; 如果是 10（表示超出商品最大下标），跳出
    cmp dl, 10
    je endcalc

    push si         ; 保护 order 的下标
    mov si, dx
    add si, si      ; 操作16位数，两倍si

    ; 计算
    mov bx, array[si]
    add ax, bx

    pop si          ; 取出 order 的下标

    inc si
    loop calcloop

endcalc:
    ; 结束计算
    mov cost, ax
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
calc endp
end main
