.model small
.data
score db 80,60,49,86,100,79,85,86,99,59;�ɼ�����
rank db 10 dup(?);��������
.code
start:
mov ax, @data ;���ݶ�����AX
mov ds, ax      ;AX��������
mov si, 0     ;��ַ�Ĵ�����0
mov cx, 10    ;���ݶ�
lp1:
mov al, 1
mov di, 0     ;di��ַ
push cx       ;cx��ջ
mov cx, 10
lp2:
mov ah, score[di]
cmp ah, score[si]
jbe next      ;С�ڵ�������ת
inc al        ;�ۼӼ���          
next:
inc di
loop lp2
pop cx          ;CX��ջ
mov rank[si], al ;������������������
inc si
loop lp1

mov ax, 4c00h
int 21h
end start
