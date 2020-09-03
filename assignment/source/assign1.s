









prompt: .string "Please enter a number for N:\n"

input_fmt:
	.string "%d"
confirm_input:
	.string "The number you entered is: %d\n"
random_output:
	.string "The random output is:%d\n"
max_output:
	.string "The x22 is:%d\n"
min_output:
	.string "The x21 is:%d\n"
sum_output:
	.string "The x23 is: %d\n"


	
	.data
n:	.word	0
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

	ldr	x19,n

	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,x19
	bl 	printf


init:
	mov	x0,xzr
	bl	time
	bl	srand
	mov	x20,xzr
	mov	x21,99
	mov	x22,xzr
	mov	x23,xzr
test:	
	cmp	x20,x19
	b.ge 	done

loop:
	mov	x0,xzr
	bl	rand


	//get a random number in [0,99]	
	mov	x24,x0
	mov	x25,100
	sdiv	x24,x24,x25
	mul	x24,x24,x25
	sub	x24,x0,x24

	//add to x23
	add	x23,x23,x24


	
	adrp	x0,random_output
	add	x0,x0,:lo12:random_output
	mov	x1,x24
	bl	printf

	add	x20,x20,1

min_test:
	cmp 	x24,x21
	b.lt	min_found	

max_test:
	cmp	x24,x22
	b.gt	max_found
	b	test

min_found:
	mov	x21,x24
	b	max_test

max_found:
	mov	x22,x24
	b	test

done:
	adrp	x0,min_output
	add	x0,x0,:lo12:min_output
	mov	x1,x21
	bl	printf

	adrp	x0,max_output
	add	x0,x0,:lo12:max_output
	mov	x1,x22
	bl	printf

	adrp	x0,sum_output
	add	x0,x0,:lo12:sum_output
	mov	x1,x23
	bl	printf



	mov	w0,0


	ldp	x29,x30,[sp],16
	ret	
