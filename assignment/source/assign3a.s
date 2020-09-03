//This is Binary to Decimal part










prompt:
	.string "Please enter a integer x19:\n"
confirm_input:
	.string "x19 is :%d\npos_N is:%d\n"

input_fmt:
	.string	"%d"
decimal_output:
	.string "The x23 is:%d\n"

	.data
n:	.word 0
	.text
	.balign 4
	.global main

main:
	stp x29,x30,[sp,-16]!
	mov x29,sp


//prompt for input and scanf input store into x19
	adrp	x0,prompt
	add	x0,x0,:lo12:prompt
	bl	printf

	
	ldr	x0,=input_fmt
	ldr	x1,=n
	bl	scanf
	
	ldr	x19,n
	mov	x20,x19
	//verify x19

	mov	x26,0
	mov	x25,1
	//cmp is alias to subs xd,xn,xm
	
	
	//lsl	x21,x25,63	
	tst	x19,0x8000
	b.eq	pass

	
twos_compliment:
	mov	x26,1
	mvn	x20,x19
	add	x20,x20,1	
pass:
	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,x19
	mov	x2,x20
	bl 	printf
	
	mov	x24,0
test:	
	cmp	x24,64
	b.ge	done


	//x22 is equal to 2^x24
	lsl 	x22,x25,x24


	//increment x24 by 1 		
	add	x24,x24,1



add_to_decimal:

	tst 	x20,x22
	b.eq	test

	add	x23,x23,x22

	b	test


flip:
	mvn	x23,x23
	add	x23,x23,1
	mov	x26,0
	
done:
	cmp x26,0
	b.ne	flip

	adrp	x0,decimal_output
	add	x0,x0,:lo12:decimal_output
	mov	x1,x23
	bl	printf


	mov 	w0,0
	ldp	x29,x30,[sp],16
	ret
