	.global _start
_start:

	MOV R2, #0x1AA 		@register 0=426
	MOV R1, #0x308C 	@register 1=1	2428 
	MOV R0, #4 			@copy register 0 into register 2

_while_R1_ge_1:
	CMP R1,#1
	BLT _output
	ADD R0,R0,#1
	SUB R1,R1,R2
	BAL _while_R1_ge_1

_output:
	MOV R7, #1
SWI 0