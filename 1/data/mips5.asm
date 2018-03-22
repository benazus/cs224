# Preliminary 2

.data
	prompt: .asciiz "Enter a string: "
	promptYes: .asciiz "\nYES"
	promptNo: .asciiz "\nNO"
.text	
	# Prompt instruction
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get input
	li $v0, 8
	li $a0, 5
	syscall
	
	# Store data in registers
	move $s1, $a0 # buffer
	move $s2, $a1 # length
	
	# Input taken, process data
	# Base case, data size is 0 or 1
	addi $t0, $0, 1
	bge $t0, $s2, yes # size 1
	
	sra $s3, $s2, 1 # mid index of stack
	sub $sp, $sp, $s3 # push stack
	addi $t0, $0, 0
	addi $t1, $s0, 0
	
loop:	sb $t1, ($sp)
	addi $sp, $sp, 1
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	bne $t0, $s3, loop
	
check:	
	lb $t0, ($t1)
	lb $t2, ($sp)
	addi $t1, $t1, 1
	addi $sp, $sp, 1
	bne $t0, $t2, no
	beq $t0, $t2, check
	j yes
	
no:	li $v0, 4
	la $a0, promptNo
	syscall	
	
yes: 	li $v0, 4
	la $a0, promptYes
	syscall	
	
exit: # Exit
	li $v0, 10
	syscall
