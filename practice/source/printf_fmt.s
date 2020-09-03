fmt: .string "char: %c\nint: %d\n"

	.balign 4
	.global main

main: 	stp x29, x30, [sp, -16]!
	mov x29, sp

	mov w19, 65
	mov w20, 42

	adrp x0, fmt
	add  x0, x0, :lo12:fmt
	mov w1, w19
	mov w2, w20
	bl printf
	
	mov w0, 0
	ldp x29, x30, [sp], 16
	ret

