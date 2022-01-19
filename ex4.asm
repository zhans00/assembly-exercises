.data

string: .asciiz "Hello World"
length: .word 11

.text

la $a0, string
lw $a1, length
jal sort

	
li $v0, 4                    #printing the output			
syscall

li $v0, 10
syscall
  
sort:
	 subi $sp,$sp, 20      # make room on stack for 5 registers
         sw $ra, 16($sp)        
         sw $s3,12($sp)         
         sw $s2, 8($sp)         
         sw $s1, 4($sp)         
         sw $s0, 0($sp)         
         add $s2,$zero, $a0           # save $a0 into $s2
         move $s3, $a1           # save $a1 into $s3
         move $s0, $zero         # i = 0
for1: slt  $t0, $s0, $s3      # $t0 = 0 if $s0 ? $s3 
         beq  $t0, $zero, exit1  
         subi $s1, $s0, 1    
            
for2: slti $t0, $s1, 0        # $t0 = 1 if $s1 < 0 
         bne  $t0, $zero, exit2  
         add  $t1, $s1, $zero        
         add  $t2, $s2, $t1      
         lb   $t3, 0($t2)   
         lb   $t4, 1($t2)        
         slt  $t0, $t4, $t3      # $t0 = 0 if $t4 ? $t3
         beq  $t0, $zero, exit2  
         move $a0, $s2           # 1st param of swap is v 
         move $a1, $s1           # 2nd param of swap is j
         jal  swap               # calling swap
         subi $s1, $s1, 1       
         j    for2           
exit2:   addi $s0, $s0, 1 
	       
         j    for1         

exit1:   
	lw $s0, 0($sp)  # restore registers from stack
         lw $s1, 4($sp)         
         lw $s2, 8($sp)         
         lw $s3,12($sp)         
         lw $ra,16($sp)         
         addi $sp,$sp, 20        
         jr $ra
                  
swap: 
	add $t1,$a1, $zero	
	add $t6, $a0, $t1
	lb $t0, 0($t6)
	lb $t2, 1($t6)
	sb $t2, 0($t6)
	sb $t0, 1($t6)
	jr $ra

  





