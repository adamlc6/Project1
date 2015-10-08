	.global _start 
 
_start: 
	MOV R1, #10		@ Sum of the numbers 
	MOV R2, #1		@ Increment 
	MOV, R3, #0		@ Tally 

 
_while:				@ Loop 
	CMP R2, R1		@ Condition parameter 
	BLE _sum		@ Check condition 
	B _exit		 

_sum: 
	ADD R3, R3, R2	@ sum up 
	ADD R2, R2, #1	@ Increment 
	BAL _while		@ Loop back 

_exit: 
 	MOV R0, R3		  
	MOV R7, #1 
	SWI 0 
