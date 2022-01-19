.data
first: .asciiz "Enter the first integer:"
second: .asciiz "Enter the second integer:"
tryAgain: .asciiz "Try again!\n"

.text
main:
  
     li $v0, 4 
     la $a0, first  
     syscall

     li $v0, 5 
     syscall
     move $t1, $v0  #$t1= first integer
    
     li $v0, 4
     la $a0, second
     syscall

     li $v0,5        
     syscall
     move $t2,$v0 #$t2=second integer

     addu $a0, $t1, $t2 	#computing the sum
     li $v0, 1
     syscall

     li $v0, 10
     syscall
   
.ktext 0x80000180
mfc0 $k0, $14		
addi $k0, $k0, 4
li $v0, 4
la $a0, tryAgain
syscall
la $k0, main		
mtc0 $k0, $14		
eret 

