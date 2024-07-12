.model small
.data
str db 2 dup(10)  ; ��������
fib dw 0,1,23 dup(-1)  ; ����쳲�������
.stack
dw 128 dup(?)
.code
start:

    mov ax, @data
    mov ds, ax

    mov si, 0  ; �±�
    mov cx, 2

    s1:
        mov ah, 01h ; ����
        int 21h
        cmp al, 13  ; �ж��Ƿ�س�
        je break1
        sub al, 48  ; ASCII(0) = 48
        mov str[si], al
        inc si
        loop s1

    break1:
        cmp cx, 0  ; ��������� 2 ��������
        jne exit
        mov dl, 10
        mov ah, 02h
        int 21h
    exit:
        cmp cx, 0
        je next
        ; 1 λ��
        mov cl, str[0]
        mov ch, 0
        jmp short break2
    next:  ; 2 λ��
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
    mov bx, 0  ; ջ�ĸ߶�
    mov cx, 5  ; 0 - 65535 ���λ��Ϊ 5

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
    push ax  ; ���� ax����Ϊ�˷���Ҫ�õ� ax
    mov al, cl
    mov ah, 0
    mov dl, 2
    mul dl
    mov si, ax  ; 2 * cx ��Ӧ쳲��������������
    cmp fib[si], -1  ; ����Ƿ��Ѿ������
    je calculate
    mov bx, fib[si]  ; ֱ��ʹ�ü���õ�ֵ
    jmp short return
    calculate:

        dec cx
        call function
        mov ax, bx
        dec cx
        call function
        add ax, bx
        mov bx, ax

        add cx, 2  ; �ָ� cx
        mov al, cl
        mov ah, 0
        mul dl
        mov si, ax  ; ������õ���ֵ����쳲�����������
        mov fib[si], bx

    return:
        pop ax
        ret

end start
