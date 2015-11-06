.data 

/* Array holding the elements to be guessed */ 
.balign 4 
a: .skip 12 

/* Array holding the numbers entered by the user */ 
.balign 4 
usrAray: .skip 12 

/* Prompt */ 
prompt: .asciz "Enter three numbers between 0-7\n" 

/* Result of guess */ 
result: .asciz "You got %d in the correct spot and %d incorrect\n" 

/* scan format */ 
.balign 4 
format: .asciz "%d %d %d" 
 
/* To check values in array */ 
numRead: .asciz "%d\n" 

/* Read in a number */ 
.balign 4 
num1: .word 0 

.balign 4 
num2: .word 0 

.balign 4 
num3: .word 0 
 
.text 

/* Generate a random number */ 
random: 
    push {lr}                       /* Push lr onto the top of the stack */ 
    bl rand                         /* Call rand */ 
 
    MOV R1, R0, asr #1              /* In case random return is negative */ 
    MOV R2,#8                       /* Move 8 to R2 */ 
                                    /* We want rand()%8 */ 
    bl divMod                       /* Call divMod function to get remainder */ 

    pop {lr}                        /* Pop the top of the stack and put it in lr */ 
    bx lr                           /* Leave main */ 
/* Exit random number generator */ 

/* fill the array */ 
.global fill 
fill: 
    push {R4,lr} 
    /* Save the array */ 
    MOV R4, #0                       /* R4 holds the index */ 
    fillLoop: 
        CMP R4, #3                   /* have we reached 3 yet */ 
        BEQ exit_fill 
        bl random 
        LDR R2, address_of_a         /* R0 <- master */ 
        str R1, [R2, R4, lsl #2]     /* (*R1  ← R2) + #4 */ 
        add R4, R4, #1 
        bal fillLoop 
    
    /* Exit the function */     
    exit_fill: 
      pop {R4, lr} 
      bx lr 

 
68 /* Get player guess */ 
69 read: 
    push {lr} 
    LDR R0, address_of_prompt 
    bl printf 

 
    LDR R0, address_of_format 
    LDR R1, address_of_num1 
    LDR R2, address_of_num2 
    LDR R3, address_of_num3 
    bl scanf 

    pop {lr} 
    bx lr 
/* end read */ 

/* Guess the number */ 
.global game 
game: 
     push {R4,lr} 
     MOV R4, #3                     /* max possible right/wrong */ 
     guess: 
        MOV R0, #0                  /* holds number correct */ 
        MOV R1, #0                  /* holds number incorrect */ 
        bl read                     /* get user guess */ 

        /* compare first value with guess */ 
        LDR R2, address_of_num1   
        LDR R2, [R2] 
        LDR R3, address_of_a 
        LDR R3, [R3, +#0] 
        CMP R2, R3                  /* does player guess match value in array */ 
        BEQ guess2                  /* numbers matched don't add to incorrect */ 
        add R1, R1, #1              /* guess incorrect, add to incorrect count*/ 
 
 
        guess2: 
            LDR R2, address_of_num2 
            LDR R2, [R2] 
            LDR R3, address_of_a 
            LDR R3, [R3, +#4] 
            CMP R2, R3 
            BEQ guess3 
            add R1, R1, #1 
 
        guess3: 
            LDR R2, address_of_num3 
            LDR R2, [R2] 
            LDR R3, address_of_a 
            LDR R3, [R3, +#8] 
            CMP R2, R3 
            BEQ done 
            add R1, R1, #1 
 
        done:                      /* Player has entered all numbers */ 
            sub R0, R4, R1         /* R0 now holds number of correct guesses */  
                                   /* Right/wrong in R0/R1, put in R1, R2 for printing */ 
            MOV R2, R1 
            MOV R1, R0 

            LDR R0, address_of_result 
            bl printf        
            CMP R1, R3 
            BEQ guess 
 
/* exit guess function */ 
exit_print: 
    pop {R4, lr} 
    bx lr 

 
address_of_a: .word a 
address_of_usrAray: .word usrAray 
address_of_numRead: .word numRead 
address_of_prompt: .word prompt 
address_of_format: .word format 
address_of_num1: .word num1 
address_of_num2: .word num2 
address_of_num3: .word num3 
address_of_result: .word result 

 
/* External functions */ 
.global printf 
.global scanf 
.global time 
.global srand 
.global rand 
