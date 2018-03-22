.data
	array:	.space  100  # Create an array of size 100
	prompt: .asciiz "\nEnter an integer: "
	instruction: .asciiz "\nEnter 0 to find Sum of items greater than an pivot, sumgreater"
	instruction2: .asciiz "\nEnter 1 to find sum of even and odd numbers, evenodd"
	instruction3: .asciiz "\nEnter 2 to find no of the items divisible by a pivot, modcount"
	instruction4: .asciiz "\nEnter -1 to exit"
	endl: .asciiz "\n"
	space: .asciiz " "
	pivot: .asciiz "\nEnter a pivot integer: "
.text
	la $s0, array # load base address to s0
	
	# Get input count from user
	# Prompt message
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get input count
	li $v0, 5
	syscall
	
	addi $s1, $v0, 0 # store the input count in s1
	
	# calculate last location of the array
	sll $s2, $s1, 2
	add $s2, $s2, $s0 
	
	# s0 = base address, s1 = data count, s2 = last address
	# get data
	addi $a0, $s0, 0 # store base address of the array in a0
	addi $a1, $s2, 0 # store last index of array in a1
	jal getdata
	
	# Program Loop
	addi $s3, $0, -1 # s3 = -1, Exit Command
			# $0 = 0, Sum of items greater than an pivot, sumgreater
	addi $s4, $0, 1 # s4 = 1, Sum of even and odd numbers, evenodd
	addi $s5, $0, 2 # s5 = 2, No of the items divisible by a pivot, modcount
	
	addi $t0, $0, 0
	
programloop:
	# Print instructions
	li $v0, 4
	la $a0, endl
	syscall	
	
	addi $a0, $s0, 0
	jal display
	
	# Print instructions
	li $v0, 4
	la $a0, instruction
	syscall
	
	la $a0, instruction2
	syscall
	
	la $a0, instruction3
	syscall
	
	la $a0, instruction4
	syscall
	
	la $a0, prompt
	syscall
	
	# Get input
	li $v0, 5
	syscall
	
	beq $v0, $s3, exit
	beq $v0, 0, op0
	beq $v0, $s4, op1
	beq $v0, $s5, op2
	j programloop
	
op0: 
	# Sum of items greater than an pivot, sumgreater
	# Print instructions
	li $v0, 4
	la $a0, pivot
	syscall
	
	# Get input
	li $v0, 5
	syscall
	
	# a0: base address, a1: last address, a2: pivot, v0: sum
	addi $a0, $s0, 0 # base address of the array
	addi $a1, $s2, 0 # last address of the array
	addi $a2, $v0, 0 # pivot
	jal sumgreater
	
	addi $t0, $v0, 0
	# print sum
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	j programloop
	# end of op0
	
op1:	
	# Find sum of even and odd numbers, evenodd
	# a0: base address, a1: last address, v0: even, v1: odd
	addi $a0, $s0, 0 # base address of the array
	addi $a1, $s2, 0 # last address of the array
	jal evenodd
	
	addi $t0, $v0, 0
	
	# print even
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	# print endl
	li $v0, 4
	la $a0, endl
	syscall
	
	# print odd
	li $v0, 1
	la $a0, ($v1)
	syscall
	
	j programloop
	# end of op1

op2:	
	# Find no of the items divisible by a pivot, modcount
	# a0: base address, a1: last address, a2: pivot
	# Print instructions
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get input
	li $v0, 5
	syscall
	
	# a0: base address, a1: last address, a2: pivot, v0: sum
	addi $a0, $s0, 0 # base address of the array
	addi $a1, $s2, 0 # last address of the array
	addi $a2, $v0, 0 # pivot
	jal modcount
	
	addi $t0, $v0, 0
	# Display
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	
	j programloop
	# end of op2
	
	# end of programloop
	
exit:	# Exit
	li $v0, 10
	syscall
	
#---------------------------------------------------------------------------------
getdata: 
	# loop to get input of amount in s1 	
	# Get input
	li $v0, 5
	syscall
	
	sw $v0, 0($a0) # move data to loc t1+0
	addi $a0, $a0, 4 # update base address
	bne $a0, $a1, getdata
	jr $ra
	# end of getdata
	
display: 
	# Function that displays array elements on the console
	lw $t0, 0($a0) # load from a0 into t0
	addi $t1, $a0, 0 # save a0
	
	# Prompt message
	li $v0, 4
	la $a0, space
	syscall
	
	# Print data
	li $v0, 1
	la $a0, 0($t0)
	syscall
	
	addi $a0, $t1, 4 # increment base address by 4
	bne $a0, $a1, display
	jr $ra
	# end of display

sumgreater: # WORKS CORRECTLY
	# a0: base address, a1: last address, a2: pivot, v0: sum
	addi $v0, $0, 0 # v0 = 0
	
	loop: 	lw $t0, ($a0)
	ble $t0, $a2, increment
	
	# item > pivot
	add $v0, $v0, $t0 # sum = sum + item
	
	increment: addi $a0, $a0, 4 # base address = base address + 4
	bne $a0, $a1, loop
	jr $ra
	# end of sumgreater

evenodd: 
	# a0: base address, a1: last address, v0: even, v1: odd
	addi $v0, $0, 0 # sum-even = 0
	addi $v1, $0, 0 # sum-odd = 0
	
	loop2: addi $t0, $0, 2
	lw $t1, ($a0)
	div $t1, $t0
	mfhi $t0 # t0 = remainder
	beq $t0, 0, even
	beq $t0, 1, odd
	
	even: add $v0, $v0, $t1
	j end
	
	odd: add $v1, $v1, $t1
	j end
	
	end: addi $a0, $a0, 4 # base = base + 4
	bne $a0, $a1, loop2	
	jr $ra
	# end of evenodd

modcount: 
	# a0: base address, a1: last address, a2: pivot
	addi $v0, $0, 0 # sum = 0
	
	loop3: lw $t0, ($a0)
	div $t0, $a2
	mfhi $t0
	bne $t0, 0, increment2
	addi $v0, $v0, 1 # sum++
	
	increment2: addi $a0, $a0, 4 # base = base + 4
	bne $a0, $a1, loop3
	jr $ra
	# end of modcount
	
