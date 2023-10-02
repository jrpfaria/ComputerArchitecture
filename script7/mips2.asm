	.data
str:	.asciiz "ITED - orievA ed edadisrevinU"
str1:	.asciiz "Reversed String: "
	.eqv	print_string, 4
	.text
	.globl	main
main:	
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	la	$a0, str1
	li	$v0, print_string
	syscall				# print_string(str1);
	
	la	$a0, str
	jal	strrev
	
	move	$a0, $v0
	li	$v0, print_string
	syscall				# print_string(str);
	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4

	li	$v0, 0
	
	jr	$ra

# char *strrev(char *str)	
strrev:
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	
	move	$s0, $a0		# $s0 = str
	move	$s1, $a0		# $s1 = &p1
	move	$s2, $a0		# $s2 = &p2

	
while:
	lb	$a0, 0($s2)
	beq	$a0, '\0', endw
	addiu	$s2, $s2, 1
	j	while
endw:
	addiu	$s2, $s2, -1

while2:	
	bge	$s1, $s2, endw2
	
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange		# exchange(p1, p2)
	
	addiu	$s1, $s1, 1
	addiu	$s2, $s2, -1
	j	while2
	
endw2:
	move	$v0, $s0	# return str
	
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	addiu	$sp, $sp, 16
	
	jr	$ra
	
# exchange
exchange:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	
	sb	$t1, 0($a0)
	sb	$t0, 0($a1)
	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra