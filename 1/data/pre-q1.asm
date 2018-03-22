.data
	array:	.space  100  # Create an array of size 20
	prompt: .asciiz " Enter an integer: "
	space: .asciiz " "
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
	mul $s2, $s1, 4
	add $s2, $s2, $s0 
	
	addi $t1, $s0, 0 # temporarily store s0 inside t1
	jal getdata
	
	addi $t1, $s0, 0 # temporarily store s0 inside t1 to be editted
	jal display
	
	addi $t1, $s0, 0 # temporarily store s0 inside t1 to be editted
	jal reverse
	
	# Prompt message
	li $v0, 4
	la $a0, prompt
	syscall
	
	addi $t1, $s0, 0 # temporarily store s0 inside t1 to be editted
	jal display
	
	# Exit
	li $v0, 10
	syscall
	
getdata: 
	# loop to get input of amount in s1
	# Get input
	li $v0, 5
	syscall
	
	sw $v0, 0($t1) # move data to loc t1+0
	addi $t1, $t1, 4 # update base address
	bne $t1, $s2, getdata
	jr $ra
	# end of getdata
	
display: 
	# Function that displays array elements on the console
	lw $t2, 0($t1) # load into t1
	
	# Prompt message
	li $v0, 4
	la $a0, space
	syscall
	
	# Print data
	li $v0, 1
	la $a0, 0($t2)
	syscall
	
	addi $t1, $t1, 4 # increment base address by 4
	bne $t1, $s2, display
	jr $ra
	# end of display
	
reverse:
	# Function that reverses the order of the array
	addi $t0, $s1, -1 # t0 = input count-1;
	sll $t0, $t0, 2 # t0 = t0 * 4;
	add $t0, $t1, $t0 # t0 = (input count-1)*4 + base address, address of the last element
	
jump:	# $t1 = base address, $t0 = last address
	lw $t2, 0($t1) # store an element into t2
	lw $t3, 0($t0) # store its pair into t3
	
	sw $t3, 0($t1) # store pair into the element's place
	sw $t2, 0($t0) # store the element into its pair's place
	
	addi $t1, $t1, 4 # increment base by 4
	addi $t0, $t0, -4 # decrement base by 4
	
	slt $t2, $t0, $t1 # t2 = 1 if t0=last address < t1=base address, else t2 = 0
	beq $t2, $0, jump
	jr $ra
	# end of reverse
