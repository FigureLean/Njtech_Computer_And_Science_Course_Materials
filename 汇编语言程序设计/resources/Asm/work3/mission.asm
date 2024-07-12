DATA	SEGMENT
BUF		DW 2345H	;随机存储一下数据
COUNT	DB ?		;用于统计BUF字单元数据中所含1的个数
DATA	ENDS
STACK	SEGMENT STACK
		DB 100 DUP(?);在堆栈段开辟一段大小为100DB的存储空间
STACK	ENDS
CODE	SEGMENT
		ASSUME CS:CODE,DS:DATA,SS:STACK
START:	MOV AX,DATA	;
		MOV DS,AX	;
		MOV AX,BUF	;将BUF中的数据存储到AX寄存器中，因为BUF里面只有一个数据且和AX的大小类型一致，所以直接将BUF的值赋值给AX，使用AX进行参与运算
		XOR CL,CL	;对CL进行初始化清零操作，用于存放统计1的个数
NEXT:	AND AX,AX	;先判断BUF里面的数据是否为0
		JZ  EXIT	;JZ判断上条指令中的AX结果为0跳转，否则执行下一条指令
		SHL AX,1	;执行到此条指令，表示BUF内容不为0.即将AX逻辑左移一位，最高位赋值给CF，最低位补0
		JNC NEXT	;判断上条指令中的AX左移之后，若没有进位（CF=0）则跳转到NEXT标签处，否则（CF=1）执行下一条指令 即一个二进制位数有1，执行下一条指令，若没有1.跳转到NEXT再次左移判断下一个二进制位是否是1
		INC CL		;执行到此条指令，即二进制位为1，CL计数自加
		JMP NEXT	;无条件跳转到NEXT处开始再次的左移操作判断下一位二进制位是否为1
EXIT:	MOV COUNT,CL;把最后统计到1的个数赋值给COUNT
		MOV AH,4CH	;调用4CH号功能，返回DOS操作系统
		INT 21H		;终止当前程序的运行，并返回DOS系统
CODE	ENDS
		END START
