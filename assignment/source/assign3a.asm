//This is Binary to Decimal part

define(N,x19)
define(pos_N,x20)
define(temp,x21)
define(temp_2,x22)
define(decimal,x23)
define(i,x24)
define(one,x25)
define(flag,x26)

prompt:
	.string "Please enter a integer N:\n"
confirm_input:
	.string "N is :%d\npos_N is:%d\n"

input_fmt:
	.string	"%d"
decimal_output:
	.string "The decimal is:%d\n"

	.data
n:	.word 0
	.text
	.balign 4
	.global main

main:
	stp x29,x30,[sp,-16]!
	mov x29,sp


//prompt for input and scanf input store into N
	adrp	x0,prompt
	add	x0,x0,:lo12:prompt
	bl	printf

	
	ldr	x0,=input_fmt
	ldr	x1,=n
	bl	scanf
	
	ldr	N,n
	mov	pos_N,N
	//verify N

	mov	flag,0
	mov	one,1
	//cmp is alias to subs xd,xn,xm
	
	
	//lsl	temp,one,63	
	tst	N,0x8000
	b.eq	pass

	
twos_compliment:
	mov	flag,1
	mvn	pos_N,N
	add	pos_N,pos_N,1	
pass:
	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,N
	mov	x2,pos_N
	bl 	printf
	
	mov	i,0
test:	
	cmp	i,64
	b.ge	done


	//temp_2 is equal to 2^i
	lsl 	temp_2,one,i


	//increment i by 1 		
	add	i,i,1



add_to_decimal:

	tst 	pos_N,temp_2
	b.eq	test

	add	decimal,decimal,temp_2

	b	test


flip:
	mvn	decimal,decimal
	add	decimal,decimal,1
	mov	flag,0
	
done:
	cmp flag,0
	b.ne	flip

	adrp	x0,decimal_output
	add	x0,x0,:lo12:decimal_output
	mov	x1,decimal
	bl	printf


	mov 	w0,0
	ldp	x29,x30,[sp],16
	ret
