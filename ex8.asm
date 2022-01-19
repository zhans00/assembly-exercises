    .data
prompt:        .asciiz     "Enter x in degree: "
sum:    .asciiz     "cos(x): "
nl:         .asciiz     "\n"
minusOne: .float -1.0
rad : .float 0.0174533
one: .float 1.0
zero: .float 0.0

   .text
main:
    lwc1 $f7, minusOne

    # prompt user for x value
    li      $v0,4                   
    la      $a0,prompt                
    syscall
    #read x value
    li      $v0,6                   
    syscall
    
    #if x value == -1 then go to exit
    c.eq.s   $f7, $f0
    bc1t exit2

    
    #set $f12 as argument
    mov.s  $f12, $f0
    jal     cos

    la      $a0, sum             
    jal     printFloat

cos:
    move    $s0,$ra                 
    lwc1 $f3, rad
    mul.s $f12, $f12, $f3 #convert to radians

    mul.s   $f10,$f12,$f12            # x^2

    mov.s   $f12, $f10         
            
	#indicates whether to add or substract
    li      $t4,1                   

    lwc1 $f5, one              # pow = 1
                   
    lwc1 $f8, zero                
               
    lwc1 $f9, one                # fac = 1
                 
    lwc1 $f11, one               
                   
    # initial sum = 0
    lwc1 $f0, zero                
                
    li      $t2, 14               # number of iterations

loop:
     
    div.s   $f14,$f5,$f9           

    mov.s   $f12, $f14           
    bgtz    $t4, positive              
    sub.s   $f0,$f0,$f14           
    j       negative

positive:
    add.s   $f0,$f0,$f14
                
negative:
    mov.s   $f12, $f0          
   
    subi    $t2,$t2,1               
    blez    $t2, exit           

    mul.s   $f5,$f5,$f10          

    add.s   $f8,$f8,$f11            

    mov.s   $f12, $f8          
    mul.s   $f9,$f9,$f8          

    mov.s   $f12, $f9          
    add.s   $f8,$f8,$f11          

    mov.s   $f12,$f8           
    mul.s   $f9,$f9,$f8         
    mov.s   $f12, $f9         
    neg     $t4,$t4                 
    j       loop

exit:
    move    $ra,$s0                 
    jr      $ra

printFloat:
    li      $v0,4                   
    syscall

    li      $v0,2                   
    syscall

    li      $v0,4                   
    la      $a0,nl                  
    syscall

    j main
    jr      $ra
    
exit2:

li $v0, 10
syscall
