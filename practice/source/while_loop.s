fmt: .string "Loop:%d\n"
break_output:
	.string "It's outside of loop\n"

	.balign 4
	.global main

main:
	stp	x29,x30,[sp,-16]!
	mov 	x29,sp

	mov	x19,0
	
test:	cmp	x19,10
	b.ge	break // ge is greater or equal here

loop:	adrp	x0,fmt
	add	x0,x0,:lo12:fmt
	mov	x1,x19
	bl	printf

	add	x19,x19,1
	b	test

break:
	adrp	x0,break_output
	add	x0,x0,:lo12:break_output
	bl	printf

	ldp	x29,x30,[sp],16
	ret


