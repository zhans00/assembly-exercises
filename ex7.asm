.data
	DISPLAY: .space 16384 # 64x64x4
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	COLORS:	.word 0xff0000, 0x0000ff00, 0x000000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFC0CB, 0xFFFFFF, 0x00FF00, 0xFFFFFF
.text

main:
	la $s1, COLORS 
	li $s2, 15 #initial radius
loopCircles:
	li $a0, 32 # center x
	li $a1, 32 #center y
	move $a2, $s2 #radius
	lw $a3, ($s1) #color
	jal circleRainbow
	
	addi $s1, $s1, 4
	addi $s2, $s2, -1
	bne $s2, 5, loopCircles
	
	li $v0, 10
	syscall

circleRainbow:
	#allocate memory
	addi $sp, $sp, -8
	sw $s0, 4($sp)
	sw $ra, 	($sp)
	
	addi $t4, $a2, 1
	addi $s0, $a2, -1
	move $a2, $a3 
	
draw:
	addi $t4, $t4, -1
	add $t6, $zero, $s0  #smallest radius
	beq $t4, $t6, exit
	
	#center of circles x = t5, y = t8
	move $t5, $a0 
	move $t8, $a1 
	li $t2, 0 #x
	move $t3, $t4 #y
	
	# d = 3 - 2 * r by Bresenham’s algorithm
	li $t6, 3 
	#change colors for each circle
	addi $t6, $t6, -30
loop:
	blt $t3, $t2, draw
	add $a0, $t2, $t5
	add $a1, $t3, $t8
	jal drawPixel

	sub $a0, $t5, $t2
	add $a1, $t3, $t8
	jal drawPixel
	
	add $a0, $t2, $t5
	sub $a1, $t8, $t3
	jal drawPixel
	
	sub $a0, $t5, $t2
	sub $a1, $t8, $t3
	jal drawPixel
	
	add $a0, $t5, $t3
	add $a1, $t8, $t2
	jal drawPixel
	
	sub $a0, $t5, $t3
	add $a1, $t8, $t2
	jal drawPixel
	
	add $a0, $t5, $t3
	sub $a1, $t8, $t2
	jal drawPixel
	
	sub $a0, $t5, $t3
	sub $a1, $t8, $t2
	jal drawPixel
	
	addi $t2, $t2, 1 #x++
	
	bgt $t6, $zero, if
	
	#d = d + 4 * x + 6 
	addi $t6, $t6, 6
	move $t0, $t2
	sll $t0, $t0, 2
	add $t6, $t6, $t0
	
	j loop
	
	if:
		addi $t3, $t3, -1 #y--
		
		#d = d + 4 * (x - y) + 10; 
		addi $t6, $t6, 10
		move $t7, $t2 
		sub $t7, $t7, $t3
		sll $t7, $t7, 2
		add $t6, $t6, $t7
		
		j loop

drawPixel: 
	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1 	
	add $t0,$t0, $a0 	
	sll $t0, $t0, 2 	
	la $t1, DISPLAY 	
	add $t1, $t1, $t0	
	sw $a2, ($t1) 		
	jr $ra 			
	
exit :
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
jr $ra
	
	

	
	
	
	
