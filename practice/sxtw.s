output:
	.string "The number is :%d\nAfter signed extension:%d\nAfter zero extension%d\n"


	.balign 4
	.global main

main:
	stp 	x29,x30,[sp,-16]!
	mov	x29,sp

	adrp	x0,output
	add	x0,x0,:lo12:output
	mov	w1,-128
	sxtb	w2,w1
	uxtb	w3,w1
	bl	printf

	ldp	x29,x30,[sp],16
	ret
