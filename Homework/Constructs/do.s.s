	.global _start

_start:
		MOV R1, #10			@ Sum of numbers
		MOV R2, #10			@ Increment
		MOV R3, #0			@ Tally
		
_do:						@ Loop
		ADD R3, R3, R2		@ Sum
		ADD R2, R2, #1		@ Increment
		CMP R2, R1			@ Condition Parameter
		BLE _do				@ Check the loop condition
		B _exit				
		
_exit:
		MOV R0, R3		
		MOV R7, #1
		SWI 0