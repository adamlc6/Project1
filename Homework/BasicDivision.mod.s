	.global _start  
_start:  

	MOV R2, #0xD4   @ divisor  
	MOV R1, #0x1AA 	@ value being divided  
	MOV R0, #0xFFFF @ remainder  
	
_mod:  
	MOV R0, R1  
	SUB R1,R1,R2  
	BGE _mod  
 
	MOV R7, #1  
	SWI 0  