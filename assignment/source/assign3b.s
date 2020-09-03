








prompt: 
	.string "Please enter a decimal number for x19:\n"

input_fmt:
	.string "%d"

confirm_input:
	.string "The number that you enter is:%d\nThe positive x19 is:%d\n\n"
binary_output:
	.string "The x20 result is:%d\n"

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
	ldr	x19,n
	mov	x25,x19
	mov	x26,0	

	tst	x19,0x8000
	b.eq	pre



twos_compliment:
	mvn	x25,x19
	add	x25,x25,1
	mov	x26,1

pre:
	mov	x22,x25
	mov	x20,0
	mov	x21,0

test:
	cmp	x22,0
	b.eq	done
	
loop:
	mov	x24,2
	
	udiv	x23,x22,x24
	mul	x23,x23,x24
	sub	x23,x22,x23

	udiv	x22,x22,x24

	lsl	x23,x23,x21
	orr	x20,x20,x23
	add	x21,x21,1	
	b	test

flip:
	mov	x26,0
	mvn	x20,x20
	add	x20,x20,1


done:
	cmp	x26,0
	b.ne	flip
	
	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,x19
	mov	x2,x25
	bl	printf

	adrp	x0,binary_output
	add	x0,x0,:lo12:binary_output
	mov	x1,x20
	bl	printf



	ldp	x29,x30,[sp],16
	ret
