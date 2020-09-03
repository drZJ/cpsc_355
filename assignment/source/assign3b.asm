define(N,x19)
define(binary,x20)
define(i,x21)
define(quotient,x22)
define(remainder,x23)
define(temp,x24)
define(pos_N,x25)
define(flag,x26)

prompt: 
	.string "Please enter a decimal number for N:\n"

input_fmt:
	.string "%d"

confirm_input:
	.string "The number that you enter is:%d\nThe positive N is:%d\n\n"
binary_output:
	.string "The binary result is:%d\n"

	.data
n:	.word 0
	
	.text
	.balign 4
	.global main

main:
	stp	x29,x30,[sp,-16]!
	mov	x29,sp


	adrp	x0,prompt
	add	x0,x0,:lo12:prompt
	bl	printf


	ldr	x0,=input_fmt
	ldr	x1,=n
	bl	scanf

	//initialization
	ldr	N,n
	mov	pos_N,N
	mov	flag,0	

	tst	N,0x8000
	b.eq	pre



twos_compliment:
	mvn	pos_N,N
	add	pos_N,pos_N,1
	mov	flag,1

pre:
	mov	quotient,pos_N
	mov	binary,0
	mov	i,0

test:
	cmp	quotient,0
	b.eq	done
	
loop:
	mov	temp,2
	
	udiv	remainder,quotient,temp
	mul	remainder,remainder,temp
	sub	remainder,quotient,remainder

	udiv	quotient,quotient,temp

	lsl	remainder,remainder,i
	orr	binary,binary,remainder
	add	i,i,1	
	b	test

flip:
	mov	flag,0
	mvn	binary,binary
	add	binary,binary,1


done:
	cmp	flag,0
	b.ne	flip
	
	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,N
	mov	x2,pos_N
	bl	printf

	adrp	x0,binary_output
	add	x0,x0,:lo12:binary_output
	mov	x1,binary
	bl	printf



	ldp	x29,x30,[sp],16
	ret
