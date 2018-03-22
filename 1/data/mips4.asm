# ?mplement the expression ((x-y)/z)mod 4
# Get inputs from keyboard
.data
	print: .asciiz "Enter 3 integers."
	getx: .asciiz "\nEnter integer x: "
	gety: .asciiz "\nEnter integer y: "
	getz: .asciiz "\nEnter integer z: "
	result: .asciiz "\nResult is: "
.text
	# Print instructions
	li $v0, 4
	la $a0, print
	syscall
	
	# Get x
	li $v0, 4
	la $a0, getx
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # x
	
	# Get y
	li $v0, 4
	la $a0, gety
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0 # y
	
	# Get z
	li $v0, 4
	la $a0, getz
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0 # y
	
	# Function
	sub $s3, $s0, $s1 # x-y
	div $s3, $s3, $s2 # (x-y)/z
	addi $t0, $0, 4 # t0 = 4
	div $s3, $t0 # ((x-y)/z)mod 4
	mfhi $s3 # get remainder
	
	# Print result
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	# Exit
	li $v0, 10
	syscall