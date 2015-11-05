/*  
Functions 
	scaleRight 
	addSub 
	scaleLeft 
	divMod 
*/  
 
.text 
 
/*void scaleRight(int & R1, int & R3, int & R2) */ 
.globl scaleRight 
scaleRight: 
	PUSH {LR}                         /* PUSH LR onto the stack */ 
	doWhile_R1_LT_R2:                 /* Shift right until just under the remainder */ 
		MOV R3,R3,ASR #1;               /* Division counter */ 
		MOV R2,R2,ASR #1                /* Mod/Remainder subtraction */ 
	CMP R1,R2 
	BLT doWhile_R1_LT_R2 
	pop {LR}                          /* Pop LR from the stack */ 
    bx LR                           /* Leave scaleRight */ 
/* end scaleRight */ 

/* void addSub(int &R3,int &R2,int &R0,int &R1) */ 
.globl addSub 
addSub: 
	PUSH {LR}                       /* PUSH LR onto the stack */ 
	doWhile_R3_ge_1: 
		add R0,R0,R3 
		sub R1,R1,R2 
		BL scaleRight 
	CMP R3,#1 
	BGE doWhile_R3_ge_1 
    pop {LR}                      /* Pop LR from the stack */ 
    bx LR                         /* Leave addSub */ 
/* end addSub */ 

 
/* void scaleLeft(int & R1,int & R3,int & R2) */ 
.globl scaleLeft 
scaleLeft: 
	PUSH {LR}                       /* PUSH LR onto the stack */ 
	doWhile_R1_ge_R2:               /* Scale left till overshoot with remainder */ 
		MOV R3,R3,LSL #1              /* scale factor */ 
		MOV R2,R2,LSL #1              /* subtraction factor */ 
		CMP R1,R2 
	BGE doWhile_R1_ge_R2            /* End loop at overshoot */ 
	MOV R3,R3,ASR #1                /* Scale factor back */ 
	MOV R2,R2,ASR #1                /* Scale subtraction factor back */ 
	pop {LR}                        /* Pop LR from the stack */ 
    bx LR                         /* Leave addSub */ 
/* end scaleLeft */ 

 
/* void divMod(int & R2,int & R0,int & R1) */ 
.globl divMod 
divMod: 
	PUSH {LR}                       /* PUSH LR onto the stack */ 
                                  /* Determine the quotient and remainder */ 
	MOV R0,#0 
	MOV R3,#1 
	CMP R1,R2 
	BLT end 
		BL scaleLeft 
		BL addSub 
	end: 
	pop {LR}                        /* Pop LR from the stack */ 
    bx LR                         /* Leave addSub */ 
/* end divMod */ 
