# readArray
# that asks the user the size of an integer array 
# and get the values from the user in a loop. 
# Returns the beginning address of the array in $a0, 
# and array size in terms of number of integers in $a1.
.data
	out: .asciiz "\nEnter an integer: "
	out2: .asciiz "\Enter int item: "
	out3: .asciiz "\nBase address is: "
	out4: .asciiz "\nArray size is: "
	out5: .asciiz "\nEnter 1 for BubbleSort"
	out6: .asciiz "\nEnter 2 for minMax"
	out7: .asciiz "\nEnter 3 for getMedian"
	out8: .asciiz "\nEnter 4 for printArray"
	out9: .asciiz "\nEnter 5 for exit"
	endl: .asciiz "\n"
	space: .asciiz " "
.text	
	# Instructions
	li $v0, 4
	la $a0, out
	syscall
	
	# Get loop size
	li $v0, 5
	syscall
	
	move $s0, $v0 # save size
	
	# Dynamic Memory
	li $v0, 9
	sll $a0, $s0, 2 # array size
	syscall 
	
	move $s1, $v0 # save base address
	
	move $a0, $s1 # base
	move $a1, $s0 # size
	jal readArray
	
	# printArray
	move $a0, $s1 # base
	move $a1, $s0 # size
	jal printArray
	
	addi $s2, $0, 1
	addi $s3, $0, 2
	addi $s4, $0, 3
	addi $s5, $0, 4
	addi $s6, $0, 5
	
	mainLoop: 
		# Instructions
		li $v0, 4
		la $a0, out5
		syscall
		
		# Instructions
		li $v0, 4
		la $a0, out6
		syscall
		
		# Instructions
		li $v0, 4
		la $a0, out7
		syscall
		
		# Instructions
		li $v0, 4
		la $a0, out8
		syscall
		
		# Instructions
		li $v0, 4
		la $a0, out9
		syscall
		
		li $v0, 4
		la $a0, endl
		syscall
		
		# Get input
		li $v0, 5
		syscall
		
		move $a0, $s1 # base
		move $a1, $s0 # size
		
		beq $v0, $s2, label1
		beq $v0, $s3, label2
		beq $v0, $s4, label3
		beq $v0, $s5, label4
		beq $v0, $s6, label5
		j mainLoop
		
		label1:
			jal BubbleSort
			j mainLoop
		label2:
			jal minMax
			j mainLoop
		label3:
			jal getMedian
			j mainLoop
		label4:
			jal printArray
			j mainLoop
	# End of main loop
	
	label5: # Exit
	li $v0, 10
	syscall
	
# ***********************************************************************************************************************************************************************
readArray: # a0: base, $a1: size
	sll $t0, $a1, 2
	add $t1, $a0, $t0 # max base address
	
	loop: 	
		# Get input
		li $v0, 5
		syscall
		
		# Save
		sw $v0, ($a0) # save input to address
		addi $a0, $a0, 4 # base address + 4
		bne $a0, $t1, loop # t1: max address, t0: base address
		# end of loop
		
	jr $ra
	# End of readArray
	
# //////////////////////////////////////////////////////////////////////////////////
BubbleSort: # BubbleSort function for an integer array
# a0: base, $a1: size
	addi $t6, $0, 1
	bge $t6, $a1, end
	# Final address
	sll $t0, $a1, 2
	add $t0, $a0, $t0
	addi $t0, $t0, -4
	
	addi $t4, $0, 0
	addi $t5, $a1, -1
	
	move $t1, $a0 # base address copy
	bsStart:
		sortPass:
			lw $t2, ($t1) # base item
			lw $t3, 4($t1) # next item
			bge $t2, $t3, swap
			j increment
			
			swap: 
				sw $t3, ($t1)
				sw $t2, 4($t1)
				# End of swap
				
			increment: 
				addi $t1, $t1, 4 # base + 4
			
			bne $t1, $t0, sortPass # base address copy + 4
		# End of sortPass
		
		move $t1, $a0 # base address copy
		addi $t0, $t0, -4 # final - 4
		addi $t4, $t4, 1
		bne $t4, $t5, sortPass
	
	end: 
		jr $ra
	# End of BubbleSort

# //////////////////////////////////////////////////////////////////////////////////
printArray: # a0: base, $a1: size
	sll $t0, $a1, 2
	add $t0, $a0, $t0 # max address
	
	addi $sp, $sp, -4
	sw $a0, ($sp)
	
	printLoop:
	
		li $v0, 4
		la $a0, space
		syscall
		
		lw $a0, ($sp)
		lw $t1, ($a0)
		li $v0, 1
		la $a0, ($t1)
		syscall
		
		lw $a0, ($sp)
		addi $a0, $a0, 4
		sw $a0, ($sp)
		bne $a0, $t0, printLoop
		
	addi $sp, $sp, 4
	jr $ra
	# End of printArray

# //////////////////////////////////////////////////////////////////////////////////
minMax: # a0: base, a1: size
	sll $t1, $a1, 2
	add $t1, $a0, $t1 # max address
	
	lw $v0, ($a0) # max
	lw $v1, ($a0) # min
	
	mmLoop: 
		lw $t0, ($a0)
		bge $t0, $v0, greater
		sub: ble $t0, $v1, less
		j inc
		greater: 
			addi $v0, $t0, 0
			j sub
		less:	
			addi $v1, $t0, 0
		
	inc: addi $a0, $a0, 4
	bne $a0, $t1, mmLoop
	
	move $t0, $v0
	move $t1, $v1
	
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall
	
	li $v0, 1
	la $a0, ($t1)
	syscall
	
	jr $ra
	# End of minMax

# //////////////////////////////////////////////////////////////////////////////////
getMedian: # a0: base, a1: size
	
	sra $t0, $a1, 1
	sll $t0, $t0, 2
	add $a0, $a0, $t0 
	lw $t0, ($a0)
	
	li $v0, 4
	la $a0, endl
	syscall
	
		
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	jr $ra
	# End of getMedian

# //////////////////////////////////////////////////////////////////////////////////
