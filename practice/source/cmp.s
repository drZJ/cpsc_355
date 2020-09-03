output: .string "here\n"


	.balign 4
	.global main

main:
	stp	x29,x30,[sp,-16]!
	mov	x29,sp
	
	mov	x19,-4

	cmp	x19,xzr
	b.ge	done
	
or:
	adrp	x0,output
	add	x0,x0,:lo12:output
	bl	printf


done:
	mov 	w0,0
	ldp 	x29,x30,[sp],16
	ret

