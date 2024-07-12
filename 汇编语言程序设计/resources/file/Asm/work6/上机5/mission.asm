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
    call crlf       ; ����س�
    call output

    mov ax, 4c00h
    int 21h
main endp
;------------------------------------------
;------------------------------------------ ��ʾ�س�����
crlf proc near
    push dx         ; �����ֳ�
    mov dl, 0dh
    mov ah, 2
    int 21h
    mov dl, 0ah
    mov ah, 2
    int 21h
    pop dx
    ret
crlf endp
;------------------------------------------ ����
input proc near
    push ax         ; �����ֳ�
    push cx
    push si

    mov ax, 0
    mov si, 0
    mov cx, N

readloop:
    ; ��ȡ
    mov ah, 1
    int 21h
    ; ����ǻس�������
    cmp al, 0dh
    je endread
    ; ����
    sub al, 30h     ; ascii ת ����
    mov order[si], al
    inc si
    loop readloop

endread:
    pop si
    pop cx
    pop ax
    ret
input endp
;------------------------------------------ �����16����ת10���ƣ������������10ȡ�෨��
output proc near
    push ax
    push bx
    push cx
    push dx

    mov cx, 1
    mov bx, 10
    mov ax, cost
realin:
    div bx          ; ������
    push dx         ; ������ջ
    cmp ax, 0       ; �Ƿ��ѳ���
    jle realout
    mov dx, 0
    inc cx
    jmp realin

realout:
    pop dx
    add dx, 30h
    mov ah, 2       ; ���
    int 21h
    loop realout

    pop dx
    pop cx
    pop bx
    pop ax
    ret
output endp
;------------------------------------------ ����
calc proc near
    push ax         ; ������
    push bx         ; ��ʱ�洢 array ������Ҫ��Ԫ��
    push cx         ; ѭ��������
    push dx         ; ��ʱ�洢 order ������Ҫ��Ԫ��
    push si         ; order �±�

    mov ax, 0
    mov bx, 0
    mov cx, N
    mov dx, 0
    mov si, 0

calcloop:
    mov dl, order[si]
    ; ����� 10����ʾ������Ʒ����±꣩������
    cmp dl, 10
    je endcalc

    push si         ; ���� order ���±�
    mov si, dx
    add si, si      ; ����16λ��������si

    ; ����
    mov bx, array[si]
    add ax, bx

    pop si          ; ȡ�� order ���±�

    inc si
    loop calcloop

endcalc:
    ; ��������
    mov cost, ax
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
calc endp
end main
