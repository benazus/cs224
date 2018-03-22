.data
	endl:	.asciiz "\n"  
.text		
	.globl __start
 
__start: # execution starts here

	li $a0,27 # to calculate fib(7)
	jal fib	# call fib
	
	# print result
	move $a0, $v0
	li $v0, 1
	syscall
	
	# New Line
	la $a0, endl
	li $v0, 4
	syscall

	# Exit
	li $v0,10
	syscall

#------------------------------------------------
fib:	move $v0, $a0 # fib(int x), x = $a0
	blt $a0, 2, done # if x = 0 or 1, fib(x) is known.

	addi $t0, $0, 0 # x-2 is initially 0
	addi $v0, $0, 1 # x-1 is initially 1

loop:	
	add $t1, $t0, $v0 # get next value
	move $t0, $v0 # update second last
	move $v0, $t1 # update last element
	sub $a0, $a0, 1 # decrement count
	bgt $a0, 1, loop # exit loop when count=0
	
done:	
	jr $ra
