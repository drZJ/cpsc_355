allocate=-(20*20*4+20*12+20*12)&-16

deallocate=-allocate

row_trio=20*20*4

col_trio=20*20*4+20*12


N	.req	w19
sum	.req	w20
max	.req	w21
min	.req	w22
i	.req	w23
j	.req	w24
temp	.req	w25
offset	.req	w26
temp_2	.req	w27

prompt:
	.string "Please enter a number N, such that is positive and not exceed 20: \n"

input_fmt:
	.string "%d"

input_valid:
	.string "The input is :%d. Valid!\n"


input_invalid:
	.string "The input is :%d. Invalid!\n"

number_output:
	.string "%d _ "

new_line:
	.string "\n"

str_output:
	.string "Positive numbers are generated and stored onto addresses\n"

read_row_first_output:
	.string "Done reading row first.\n"


	.data
n:	.word 0
	

	.text
	.balign 4
	.global main

main:
	stp	x29,x30,[sp,-16]!
	

	//allocate the memory for use
	add	sp,sp,allocate	
	mov	x29,sp
prompt_N:
	//prompt for an input N
	adrp	x0,prompt
	add	x0,x0,:lo12:prompt
	bl	printf
	

	ldr	x0,=input_fmt	
	ldr	x1,=n
	bl	scanf
	
	ldr	N,n
	
check_validity:
	cmp	N,1
	b.lt	invalid
	cmp	N,20
	b.gt	invalid
	
	b	valid

invalid:
	adrp	x0,input_invalid
	add	x0,x0,:lo12:input_invalid	
	mov	w1,N
	bl	printf

	b	prompt_N

valid:
	adrp	x0,input_valid
	add	x0,x0,:lo12:input_valid
	mov	w1,N
	bl	printf


//	to get rand and store onto addresses
	
prepare_str:
	mov	i,0
	mov	j,0
	mov	w0,0
	bl	time
	bl	srand
	mov	temp,0
	mov	offset,0

for_i_str:
	cmp	i,N
	b.ge	str_done	
	
for_j_str:
	cmp	j,N
	b.ge	i_plus_one_str

	mul	offset,i,N
	add	offset,offset,j
	lsl 	offset,offset,2


	bl	rand
	
	mov	temp,99
	
	udiv	temp_2,w0,temp
	mul	temp_2,temp_2,temp
	sub	temp,w0,temp_2
	add	temp,temp,1
	
	str	temp,[x29,offset,SXTW]	

	adrp	x0,input_valid
	add	x0,x0,:lo12:input_valid
	ldr	w1,[x29,offset,SXTW]
	bl	printf
	
	add	j,j,1
	b	for_j_str

i_plus_one_str:
	
	add	i,i,1
	mov	j,0
	b	for_i_str

str_done:
	adrp	x0,str_output
	add	x0,x0,:lo12:str_output
	bl	printf

//read, row_first
read_row_first:
	mov	i,0
	mov	j,0
	mov	temp,0
	mov	offset,0

row_reset:
	mov	sum,0
	mov	min,0
	mov	max,0

for_i_read_row_first:
	cmp	i,N
	b.ge	done_read_row_first
		

for_j_read_row_first:
	cmp	j,N
	b.ge	i_plus_read_row_first

	mul	offset,i,N
	add	offset,offset,j
	lsl	offset,offset,2
	
	ldr	temp,[x29,offset,SXTW]

	adrp	x0,number_output
	add	x0,x0,:lo12:number_output
	mov	w1,temp
	bl	printf
	
	add	j,j,1
	b	for_j_read_row_first

i_plus_read_row_first:
	add	i,i,1
	mov	j,0
	adrp	x0,new_line
	add	x0,x0,:lo12:new_line
	bl	printf

	b	row_reset	


done_read_row_first:
	
	adrp	x0,read_row_first_output
	add	x0,x0,:lo12:read_row_first_output
	bl	printf



done:
	mov	w0,0
	add	sp,sp,deallocate
	ldp	x29,x30,[sp],16
	ret
