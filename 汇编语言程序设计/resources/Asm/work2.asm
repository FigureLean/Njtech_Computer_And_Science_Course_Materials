;5.1  试编写一个汇编语言程序，要求对键盘输入的小写字母用大写字母显示出来。
;已知ASCII码的a的整型数字为97；A的整型数字对应数字为65,因此小写字母ascii码=大写字母ascii码 + 32
DATA SEGMENT
    MSG1 DB 'Enter an english word(a-z):','$'
    MSG2 DB 0DH,0AH,'the rewritting word is :','$'
DATA ENDS 

CODE SEGMENT
ASSUME CS:CODE,DS:DATA;,SS:STACK
START:  MOV AX,DATA ;将数据段的数据移到DS寄存器中，因为无法直接数据从内存移到DS，只能从寄存器移到DS，
    MOV DS,AX   ;所以需要先把数据移到AX寄存器，然后再移到Ds寄存器。
    ;因为下面要用DATA，所以这样做是为了保存数据段DATA上面原有的数据
    ;DS是数据段寄存器 
    ;也可以说：(这句指令是将数据段（DATA）的首地址赋给AX，而下一句‘MOV DS，AX’则是通过AX将数据段的首地址赋给DS
    ;之所以这样做是因为DS不可以直接被赋值，而需要借助AX作为‘中转’。汇编语言里有很多像这样需要’中转‘的例子。
    ;最后数据段寄存器DS内就存储了该程序数据段的段基值，以便后续计算段基址。)

    MOV DX,OFFSET MSG1
    MOV AH,9
    INT 21H

    MOV AH,1  ;键盘输入字符自动存入AL中
    INT 21H    ;int中断

    SUB AL,32  ; 小写变大写
    MOV BL,AL   ;赋值给CX


    MOV DX,OFFSET MSG2
    MOV AH,9
    INT 21H

    MOV AH,2   ;显示输出  DL=输出字符
    MOV DL,BL 
    INT 21H    ;int中断

    MOV AH,4CH  ;带返回码结束,AL=返回码
    INT 21H

CODE ENDS
END START
