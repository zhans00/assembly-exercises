.data 
	Arr: .word 21 20 51 83 20 20
	x: .word 20
	y: .word 5
	length: .word 6
	space: .asciiz " "
	newLine: .asciiz "\n"
	
.text 
	# sets $t0 to zero
	addi $t0, $zero,0
	addi $t1, $zero, 0
	
	# set the first element of Arr to $t1
	la $t1, Arr

	lw $s0, length

	lw $t4, x
	lw $t5, y
	
	loop:
	bge $t0, $s0, ReplacingElements
	lw $t6, 0($t1)
	#increments the counter of the loop
	addi $t0, $t0, 1
	addi    $t1, $t1, 4
	li      $v0, 1      
  	move    $a0, $t6
    	syscall
    
  	# prints space
    	li $v0, 4
    	la $a0, space
    	syscall
    	j loop
		
	
	jal ReplacingElements
	li $v0, 1
	syscall
	
	li $v0,10 # exit 
	syscall
	

	ReplacingElements :
	 li $v0, 4
        la $a0, newLine
        syscall
        
	addi $t1, $zero, 0
	la $t1, Arr
    	addi $t0, $zero, 0
    	lw $s0, length
	
	while:
		# loop that runs until $t0 < = $s0(length)
		bge $t0, $s0, exit
		lw     $t3, 0($t1)
		# checks if the given element of Arr equal to x
    		beq $t3, $t4, numbersEqual
    		
    	

    		# syscall to print value
    		li      $v0, 1      
    		move    $a0, $t3
    		syscall
    		#uincrements the counter of while
    		addi $t0, $t0, 1
		# increments the index of Arr
    		addi    $t1, $t1, 4
    		
    		# prints space
   	 	li $v0, 4
    		la $a0, space
    		syscall
    		j while
    
	numbersEqual:
    		sw $t5, 0($t1)
    		li $v0, 1
    		move $a0, $t5
    		syscall
    		addi $t0, $t0, 1
		# increments the index of Arr
    		addi    $t1, $t1, 4
    		li $v0, 4
    		la $a0, space
   		syscall
       
    		# jump to the loop "while"	
    		j while
		jr $ra
 	 	
 exit:
	li $v0,10 # exit 
	syscall 

