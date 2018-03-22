# Preliminary 3
.text
	# Get c
	li $v0, 5
	syscall
	
	move $s0, $v0 # c
	
	# Get d
	li $v0, 5
	syscall
	
	move $s1, $v0 # d

	sub $s0, $s0, $s1 # x-y -> x
	
	andi $t0, $s0, 1
	
	# print result
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	# Exit
	li $v0, 10
	syscall