    .data
Promt:
	.asciiz    "Enter the number of disks (>0 & <32): "
Warning:
	.asciiz    "Input must (> 0 & <32)"
Result:
	.asciiz    "The number of steps : "
	.globl main
	
    .text     
main:
	li $v0, 4					#Print Promt
	la $a0, Promt
    syscall
	
	li $v0, 5					#Read Input
	syscall
	
	slti $t0, $v0, 1			#Check input number
	bne $t0, $0, Warn
	slti $t0, $v0, 32
	beq $t0, $0, Warn
	
	add $a0, $v0, $0
	jal hanoi
	add $a1, $v0, $0
	
	li $v0, 4					#Print Result text
	la $a0, Result
    syscall
	
	add $a0, $a1, $0
	li $v0, 1					#print result
	syscall
	
	jal Exit
	
hanoi:
	addi $sp, $sp, -8			#save $ra, $a0
	sw $ra, 4($sp)
	sw $a0, 0($sp)	
	slti $t0, $a0, 2
	beq $t0, $0, L1
	
	addi $v0, $0, 1
	addi $sp, $sp, 8
	jr $ra
	
L1:
	addi $v0, $0, 0
L2:
	addi $t0, $a0, 0
	addi $t1, $zero, 1
	bne $a0, $t1, else
	addi $v0, $v0, 1
	addi $a0, $t0, 0
	jr $ra
else:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	addi $a0, $a0, -1
	jal L2
	
	lw $a0, 0($sp)
	addi $v0, $v0, 1
	
	addi $a0, $a0, -1
	jal L2
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
Warn:
	li $v0, 4					#Print Warning text
	la $a0, Warning
    syscall
	jal Exit
Exit:
	li $v0, 10					#Exit
    syscall