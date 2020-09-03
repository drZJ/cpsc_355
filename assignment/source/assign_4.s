allocate=-(20*20*4+20*12+20*12)&-16

deallocate=-allocate


base1=20*20*4
base2=20*20*4+20*3*4


N	.req	w19
sum	.req	w20
max	.req	w21
min	.req	w22
i	.req	w23
j	.req	w24
temp	.req	w25
offset	.req	w26
temp_2	.req	w27
base 	.req	x28

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
	.string "Done reading row first......\n"

read_col_first_output:
	.string "Done reading col first......\n"

rowt_out:
	.string	"At row %d, sum=%d, min=%d, max=%d\n" 

rt_done:
	.string "Done printing row trio......\n"


colt_out:
	.string	"At col %d, sum=%d, min=%d, max=%d\n" 	

ct_done:
	.string "Done printing col trio......\n"




	.data
n:	.word 0
	

	.text
	.balign 4
	.global main

main:
	stp	x29,x30,[sp,-16]!
	
	mov	x29,sp
	//allocate the memory for use
	add	sp,sp,allocate
	mov	base,sp	
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
	
	str	temp,[base,offset,SXTW]	


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
	mov	min,100
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
	
	ldr	temp,[base,offset,SXTW]

    add sum,sum,temp

	adrp	x0,number_output
	add	x0,x0,:lo12:number_output
	mov	w1,temp
	bl	printf
	
	add	j,j,1

    cmp temp,max
    b.gt    row_max
	b		check_row_min

row_max:
    mov max,temp

check_row_min:
    cmp temp,min
    b.lt    row_min
    b for_j_read_row_first
row_min:
    mov min,temp
    b for_j_read_row_first




i_plus_read_row_first:

    mov offset,base1
    mov temp,4
    mov temp_2,3
    mul temp,temp,temp_2
    mul temp,temp,i
    add offset,offset,temp
    
    str sum,[base,offset,SXTW]

    add offset,offset,4

    str min,[base,offset,SXTW]

    add offset,offset,4

    str max,[base,offset,SXTW]


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

//now read row trio

row_trio:
	mov 	i,0
read_rt:
	cmp	 	i,N
	b.ge 	read_row_trio_done

	mov offset,base1
    mov temp,4
    mov temp_2,3
    mul temp,temp,temp_2
    mul temp,temp,i
    add offset,offset,temp
    
    ldr sum,[base,offset,SXTW]

    add offset,offset,4

    ldr min,[base,offset,SXTW]

    add offset,offset,4

    ldr max,[base,offset,SXTW]

	adrp	x0,rowt_out
	add 	x0,x0,:lo12:rowt_out
	mov 	w1,i
	mov 	w2,sum
	mov  	w3,min
	mov 	w4,max
	bl 		printf

	add 	i,i,1
	b 		read_rt

read_row_trio_done:
	adrp   x0,rt_done
	add 	x0,x0,:lo12:rt_done
	bl 		printf


//now read col first

prepare_col_first:
	mov 	i,0
	mov 	j,0

col_reset:
	mov	sum,0
	mov	min,100
	mov	max,0

forJ:
	cmp	j,N
	b.ge	read_col_first_done
		

forI:
	cmp	i,N
	b.ge	j_plus_one

	mul	offset,i,N
	add	offset,offset,j
	lsl	offset,offset,2
	
	ldr	temp,[base,offset,SXTW]

    add sum,sum,temp

	adrp	x0,number_output
	add	x0,x0,:lo12:number_output
	mov	w1,temp
	bl	printf
	
	add	i,i,1

    cmp temp,max
    b.gt    col_max
	b		check_col_min

col_max:
    mov max,temp

check_col_min:
    cmp temp,min
    b.lt    col_min
    b forI
col_min:
    mov min,temp
    b forI


j_plus_one:

    mov offset,base2
    mov temp,4
    mov temp_2,3
    mul temp,temp,temp_2
    mul temp,temp,j
    add offset,offset,temp
    
    str sum,[base,offset,SXTW]

    add offset,offset,4

    str min,[base,offset,SXTW]

    add offset,offset,4

    str max,[base,offset,SXTW]



	add	j,j,1
	mov	i,0
	adrp	x0,new_line
	add	x0,x0,:lo12:new_line
	bl	printf

	b	col_reset	

read_col_first_done:
	adrp 	x0,read_col_first_output
	add 	x0,x0,:lo12:read_col_first_output
	bl  	printf





//now read col trio

col_trio:
	mov 	j,0
read_ct:
	cmp	 	j,N
	b.ge 	read_col_trio_done

	mov offset,base2
    mov temp,4
    mov temp_2,3
    mul temp,temp,temp_2
    mul temp,temp,j
    add offset,offset,temp
    
    ldr sum,[base,offset,SXTW]

    add offset,offset,4

    ldr min,[base,offset,SXTW]

    add offset,offset,4

    ldr max,[base,offset,SXTW]

	adrp	x0,colt_out
	add 	x0,x0,:lo12:colt_out
	mov 	w1,j
	mov 	w2,sum
	mov  	w3,min
	mov 	w4,max
	bl 		printf

	add 	j,j,1
	b 		read_ct

read_col_trio_done:
	adrp   x0,ct_done
	add 	x0,x0,:lo12:ct_done
	bl 		printf




done:

	mov	w0,0
	add	sp,sp,deallocate
	ldp	x29,x30,[sp],16
	ret