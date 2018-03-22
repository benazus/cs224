# IO
# Get a string as an octal number, convert it to base 10
.data 
	octal: .asciiz "17"
.text
start:
	la $a0, octal # input
	addi $a1, $0, 2 # input size
	jal convertToDec
	
	addi $t0, $v0, 0
	
	# Output
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	# Exit
	li $v0, 10
	syscall

#----------------------------------------------------------------------------------------
convertToDec:
# Arguments: a0: string base address, a1: string size
	addi $sp, $sp, -12
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	addi $s0, $a1, -1 # power count
	interpret: 
		lb $s1, ($a0) # save char value into 
		beq $s1, 48, prelabel0 # ascii 0
		beq $s1, 49, prelabel1 # ascii 1
		beq $s1, 50, prelabel2 # ascii 2
		beq $s1, 51, prelabel3 # ascii 3
		beq $s1, 52, prelabel4 # ascii 4
		beq $s1, 53, prelabel5 # ascii 5
		beq $s1, 54, prelabel6 # ascii 6
		beq $s1, 55, prelabel7 # ascii 7
		beq $s1, 56, prelabel8 # ascii 8
		beq $s1, 57, prelabel9 # ascii 9
		j finish
		
		prelabel0: 
			addi $s1, $0, 0
			j label
		prelabel1:
			addi $s1, $0, 1
			j label
		prelabel2:
			addi $s1, $0, 2
			j label
		prelabel3: 
			addi $s1, $0, 3
			j label
		prelabel4:
			addi $s1, $0, 4
			j label
		prelabel5: 
			addi $s1, $0, 5
			j label
		prelabel6:
			addi $s1, $0, 6
			j label
		prelabel7:
			addi $s1, $0, 7
			j label
		prelabel8:
			addi $s1, $0, 8
			j label
		prelabel9:
			addi $s1, $0, 9

		
		label: # Character in s1 and it's valid
			addi $sp, $sp, -8
			sw $a0, ($sp)
			sw $a1, 4($sp)
			
			addi $a0, $s0, 0 # power count
			addi $a1, $s1, 0 # char in a1
			
			addi $sp, $sp, -4
			sw $v0, ($sp)
			jal power
			
			lw $s2, ($sp) # v0
			addi $sp, $sp, 4
			add $v0, $v0, $s2 # sum
			
			lw $a0, ($sp)
			lw $a1, 4($sp)
			addi $sp, $sp, 8
			
			addi $a0, $a0, 1 # base address
			addi $a1, $a1, -1 # size
			addi $s0, $s0, -1 # power
			bne $a1, 0, interpret
		
	finish :
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		
		jr $ra
	# end of convertToDec
	
	
power: # a0 = x, a1 = num, v0 = result
	beq $a0, 0, zero
	loop: # calculate 8^x * num
		addi $t0, $0, 8
		mul $a1, $t0, $a1
		addi $a0, $a0, -1
		bne $a0, 0, loop
		
	addi $v0, $a1, 0 # load result into v0
	j end
	
	zero: 
		addi $v0, $a1, 0
	end: 
		jr $ra
	# End of power
