#OPTION 2 IS IMPLEMENTED

.data
num1: .word	  12	#allocate memory for the string
output:	.space	120

.text
	
main:

	addi $v0, $zero, 5
	syscall

	add $a0, $zero, $v0  # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 4   # Prepare syscall 0
	syscall          
