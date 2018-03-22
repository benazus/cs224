.data
	endl: .asciiz "\n"
.text
	li $a0, -1267737486
	li $a1, -1416681536
	jal CompareFP
	
	# -1267737486 = 10110100011011111101110001110010(LS 32 bits): Exponent Case - Small
	# -1416681536 = 10101011100011110010011111000000(LS 32 bits): Exponent Case - Big
	
	# -78 =  11111111111111111111111110110010(LS 32 bits): Fraction Case - Big
	# -45 =  11111111111111111111111111010011(LS 32 bits): Fraction Case - Small
	
	# 695 =  00000000000000000000001010110111(Sign Extended 32 bits): Fraction Case - Big
	# 485 =  00000000000000000000000111100101(Sign Extended 32 bits): Fraction Case - Small
	
	# 957852378 = 11111001000101111010101011011010(Sign Extended 32 bits): Exponent Case - Big
	# 854542424 = 11110010111011110100100001011000(Sign Extended 32 bits): Exponent Case - Small
	
	move $t0, $v0
	move $t1, $v1
	
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall

	li $v0, 10
	syscall

CompareFP: # a0: 1st, a1: 2nd; v0: greater, v1: lesser
	move $t0, $a0
	move $t1, $a1
	
	CaseMSB:
		srl $t0, $t0, 31
		srl $t1, $t1, 31
		bgt $t0, $t1, fLTs
		blt $t0, $t1, fGTs
	move $t2, $t0 # MSB saved
	CaseExponent:
		move $t0, $a0
		move $t1, $a1
		sll $t0, $t0, 1
		sll $t1, $t1, 1
		srl $t0, $t0, 24
		srl $t1, $t1, 24
		beq $t2, 0, PosExp
		NegExp:
			bgt $t0, $t1, fLTs
			blt $t0, $t1, fGTs
		j CaseFraction
		PosExp:
			bgt $t0, $t1, fGTs
			blt $t0, $t1, fLTs
	CaseFraction:
		move $t0, $a0
		move $t1, $a1
		sll $t0, $t0, 9	
		sll $t1, $t1, 9
		srl $t0, $t0, 9
		srl $t1, $t1, 9
		beq $t2, 0, PosFrac
		NegFrac:
			bgt $t0, $t1, fLTs
			blt $t0, $t1, fGTs
		j equal
		PosFrac:
			bgt $t0, $t1, fGTs
			blt $t0, $t1, fLTs
		j equal
	fLTs:
	equal:
		move $v0, $a1
		move $v1, $a0
		j Exit
	fGTs:
		move $v0, $a0
		move $v1, $a1
	Exit:
		jr $ra
	# End of CompareFP