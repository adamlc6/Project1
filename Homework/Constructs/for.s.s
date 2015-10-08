	.global _start 
 
_start: 

	MOV R1, #10		@ sum of the numbers
	MOV R2, #1		@ increment
	MOV R3, #0		@ sum tally 
 
_for:				@ loop 
	CMP  R2, R1		@ condition parameter 
	BLE _sum		@ check loop condition 
	B _exit			@ exit loop 

_sum: 
	ADD R3, R3, R2	@ total 
	ADD r2, r2, #1	@ increment 
	BAL _for		@ loop back 
 
_exit: 
	MOV R0, R3		 
	MOV R7, #1 
	SWI 0 
