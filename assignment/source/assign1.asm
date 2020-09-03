define(condition,x19)
define(temp,x24)
define(temp_2,x25)
define(i,x20)
define(min,x21)
define(max,x22)
define(sum,x23)



prompt: .string "Please enter a number for N:\n"

input_fmt:
	.string "%d"
confirm_input:
	.string "The number you entered is: %d\n"
random_output:
	.string "The random output is:%d\n"
max_output:
	.string "The max is:%d\n"
min_output:
	.string "The min is:%d\n"
sum_output:
	.string "The sum is: %d\n"


	
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

	ldr	condition,n

	adrp	x0,confirm_input
	add	x0,x0,:lo12:confirm_input
	mov	x1,condition
	bl 	printf


init:
	mov	x0,xzr
	bl	time
	bl	srand
	mov	i,xzr
	mov	min,99
	mov	max,xzr
	mov	sum,xzr
test:	
	cmp	i,condition
	b.ge 	done

loop:
	mov	x0,xzr
	bl	rand


	//get a random number in [0,99]	
	mov	temp,x0
	mov	temp_2,100
	sdiv	temp,temp,temp_2
	mul	temp,temp,temp_2
	sub	temp,x0,temp

	//add to sum
	add	sum,sum,temp


	
	adrp	x0,random_output
	add	x0,x0,:lo12:random_output
	mov	x1,temp
	bl	printf

	add	i,i,1

min_test:
	cmp 	temp,min
	b.lt	min_found	

max_test:
	cmp	temp,max
	b.gt	max_found
	b	test

min_found:
	mov	min,temp
	b	max_test

max_found:
	mov	max,temp
	b	test

done:
	adrp	x0,min_output
	add	x0,x0,:lo12:min_output
	mov	x1,min
	bl	printf

	adrp	x0,max_output
	add	x0,x0,:lo12:max_output
	mov	x1,max
	bl	printf

	adrp	x0,sum_output
	add	x0,x0,:lo12:sum_output
	mov	x1,sum
	bl	printf



	mov	w0,0


	ldp	x29,x30,[sp],16
	ret	
