DATA	SEGMENT
BUF		DW 2345H	;����洢һ������
COUNT	DB ?		;����ͳ��BUF�ֵ�Ԫ����������1�ĸ���
DATA	ENDS
STACK	SEGMENT STACK
		DB 100 DUP(?);�ڶ�ջ�ο���һ�δ�СΪ100DB�Ĵ洢�ռ�
STACK	ENDS
CODE	SEGMENT
		ASSUME CS:CODE,DS:DATA,SS:STACK
START:	MOV AX,DATA	;
		MOV DS,AX	;
		MOV AX,BUF	;��BUF�е����ݴ洢��AX�Ĵ����У���ΪBUF����ֻ��һ�������Һ�AX�Ĵ�С����һ�£�����ֱ�ӽ�BUF��ֵ��ֵ��AX��ʹ��AX���в�������
		XOR CL,CL	;��CL���г�ʼ��������������ڴ��ͳ��1�ĸ���
NEXT:	AND AX,AX	;���ж�BUF����������Ƿ�Ϊ0
		JZ  EXIT	;JZ�ж�����ָ���е�AX���Ϊ0��ת������ִ����һ��ָ��
		SHL AX,1	;ִ�е�����ָ���ʾBUF���ݲ�Ϊ0.����AX�߼�����һλ�����λ��ֵ��CF�����λ��0
		JNC NEXT	;�ж�����ָ���е�AX����֮����û�н�λ��CF=0������ת��NEXT��ǩ��������CF=1��ִ����һ��ָ�� ��һ��������λ����1��ִ����һ��ָ���û��1.��ת��NEXT�ٴ������ж���һ��������λ�Ƿ���1
		INC CL		;ִ�е�����ָ���������λΪ1��CL�����Լ�
		JMP NEXT	;��������ת��NEXT����ʼ�ٴε����Ʋ����ж���һλ������λ�Ƿ�Ϊ1
EXIT:	MOV COUNT,CL;�����ͳ�Ƶ�1�ĸ�����ֵ��COUNT
		MOV AH,4CH	;����4CH�Ź��ܣ�����DOS����ϵͳ
		INT 21H		;��ֹ��ǰ��������У�������DOSϵͳ
CODE	ENDS
		END START
