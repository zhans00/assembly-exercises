.data

Fib: .word 0 1 1 2 3 5 8


.text

la $s0, Fib
la $s1, Fib
la $s2, Fib
la $s3, Fib
la $s4, Fib
la $s5, Fib
la $s6, Fib


lw $t0, 0($s0)
lw $t1, 0($s1)
lw $t2, 0($s2)
lw $t3, 0($s3)
lw $t4, 0($s4)
lw $t5, 0($s5)
lw $t6, 0($s6)

sw $t0, 0($s0)
sw $t1, 0($s1)
sw $t2, 0($s2)
sw $t3, 0($s3)
sw $t4, 0($s4)
sw $t5, 0($s5)
sw $t6, 0($s6)
