.data
str: .asciiz "Enter first base and then exponent:  "

.text
main:
	#print the prompt
    	la $a0,str		
    	li $v0,4
    	syscall
    	
    	#get the base from user
    	li $v0,5
    	syscall
    	
    	move $a0,$v0
    	
    	#get the exponent from user
    	li $v0,5
    	syscall
    	
    	
    	move $a1,$v0    
    	
    	#go to the function
    	jal power

	#print the result
    	move $a0,$v0
    	li $v0,1
    	syscall
    	
   	li $v0,10
    	syscall

power: 
	#allocate memory
	addi $sp,$sp,-4
        sw $ra,0($sp)   
        
        #set v0 = 1
        addi $v0,$zero,1
        
        #consider the case when exponent is zero
        beq $a1, 0, zero
      
        bne $a1,1, recursion

        jr $ra
        
        
recursion:    
	#increment the exponent
        addi $a1,$a1,-1        
        #recursion
        jal power  
      
        mul $v0,$v0,$a0        
        lw $ra, 0($sp)
        addi $sp,$sp,4
        jr $ra
        
zero: 
   	addi $v0, $zero, 1
   	jr $ra


