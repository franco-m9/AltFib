# Franco Marcoccia - 7/7/2018
# altfib.s - alternating Fibonacci sequence which displays value causing overflow
# Register use:
#	$t3 for mathematics purpose of fibonacci
#	$t4 for initial value of fibonacci sequence
#	$t5 for counter , $t6 for max numbers a line being 5
#	$t0-$t2 for overflow checking	
	
	.text
main:	
	la	$a0, intro
	li	$v0, 4
	syscall

	li	$t3, 0			# set values needed for fibonacci
	li	$t4, 1
	li	$t5, 0			# counter starting at 0
	li	$t6, 5			# max numbers a line is 5 for counter

fib:	
	move	$a0, $t4		# prints initial number of line
	li	$v0, 1
	syscall

	la	$a0, space		# spacing between numbers
	li	$v0, 4
	syscall

	negu	$t0, $t4		# negates the value
	addu	$t1, $t3, $t0		# no overflow checking
	xor	$t2, $t3, $t0
	slt	$t2, $t2, $zero
	bne	$t2, $zero, No_overflow

	xor	$t2, $t1, $t3		# more overflow checking
	slt	$t2, $t2, $zero
	bne	$t2, $zero, Overflow

No_overflow:
	move	$t3, $t4		# moves values for next calculations
	move	$t4, $t1
	addi	$t5, $t5, 1		# adds one to counter
	beq	$t5, $t6, next		# if counter is 5 , branch
	j fib				# repeat for a new line

next:
	li	$t5, 0			# counter is set back to 0 for new line
	
	la	$a0, endl		# \n
	li	$v0, 4
	syscall

	j fib

Overflow:
	la	$a0, problem		
	li	$v0, 4
	syscall

	move	$a0, $t1		# moves the overflow value to be displayed
	li	$v0, 1
	syscall

	
	li	$v0, 10			# end program
	syscall

	.data
intro:	.asciiz "Here are the alternating Fibonacci numbers that I produced:\n\n"
space:	.asciiz " "
endl:	.asciiz "\n"
problem:.asciiz "\n\nValue causing overflow = "