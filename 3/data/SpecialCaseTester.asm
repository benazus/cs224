	li $a0, 999999999999999999
	jal SpecialCase
	
	move $t0, $v0
	
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	li $v0, 10
	syscall

SpecialCase: # a0: input, v0: return in binary
	move $t0, $a0
	label0:
		sll $t0, $t0, 1
		srl $t0, $t0, 1
		beq $t0, 0, special
	move $t0, $a0
	labelDenormalized:
		sll $t0, $t0, 9
		srl $t0, $t0, 9
		bne $t0, 0, denormalizedPart2
		j labelInfinity
		denormalizedPart2:
			move $t0, $a0
			sll $t0, $t0, 1
			srl $t0, $t0, 24
			beq $t0, 0, special
	labelInfinity:
		move $t0, $a0
		sll $t0, $t0, 1
		srl $t0, $t0, 24
		beq $t0, 255, infinityPart2
		j labelNaN
		infinityPart2:
			move $t0, $a0
			sll $t0, $t0, 9
			srl $t0, $t0, 9
			beq $t0, $t0, special
	labelNaN:
		move $t0, $a0
		sll $t0, $t0, 1
		srl $t0, $t0, 24
		beq $t0, 255, NaNPart2
		j normalized
		NaNPart2:
			move $t0, $a0
			sll $t0, $t0, 9
			srl $t0, $t0, 9
			bne $t0, 0, special
	j normalized
	special:
		addi $v0, $0, 1
		j exit
	normalized:
		addi $v0, $0, 0
	exit: 
		jr $ra
	# End of SpecialCase
