;5.1  �Ա�дһ��������Գ���Ҫ��Լ��������Сд��ĸ�ô�д��ĸ��ʾ������
;��֪ASCII���a����������Ϊ97��A���������ֶ�Ӧ����Ϊ65,���Сд��ĸascii��=��д��ĸascii�� + 32
DATA SEGMENT
    MSG1 DB 'Enter an english word(a-z):','$'
    MSG2 DB 0DH,0AH,'the rewritting word is :','$'
DATA ENDS 

CODE SEGMENT
ASSUME CS:CODE,DS:DATA;,SS:STACK
START:  MOV AX,DATA ;�����ݶε������Ƶ�DS�Ĵ����У���Ϊ�޷�ֱ�����ݴ��ڴ��Ƶ�DS��ֻ�ܴӼĴ����Ƶ�DS��
    MOV DS,AX   ;������Ҫ�Ȱ������Ƶ�AX�Ĵ�����Ȼ�����Ƶ�Ds�Ĵ�����
    ;��Ϊ����Ҫ��DATA��������������Ϊ�˱������ݶ�DATA����ԭ�е�����
    ;DS�����ݶμĴ��� 
    ;Ҳ����˵��(���ָ���ǽ����ݶΣ�DATA�����׵�ַ����AX������һ�䡮MOV DS��AX������ͨ��AX�����ݶε��׵�ַ����DS
    ;֮��������������ΪDS������ֱ�ӱ���ֵ������Ҫ����AX��Ϊ����ת��������������кܶ���������Ҫ����ת�������ӡ�
    ;������ݶμĴ���DS�ھʹ洢�˸ó������ݶεĶλ�ֵ���Ա��������λ�ַ��)

    MOV DX,OFFSET MSG1
    MOV AH,9
    INT 21H

    MOV AH,1  ;���������ַ��Զ�����AL��
    INT 21H    ;int�ж�

    SUB AL,32  ; Сд���д
    MOV BL,AL   ;��ֵ��CX


    MOV DX,OFFSET MSG2
    MOV AH,9
    INT 21H

    MOV AH,2   ;��ʾ���  DL=����ַ�
    MOV DL,BL 
    INT 21H    ;int�ж�

    MOV AH,4CH  ;�����������,AL=������
    INT 21H

CODE ENDS
END START
