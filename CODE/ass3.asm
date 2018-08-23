#This program implements the following C code
#if (i<j)
#	f=g+h;
#else
#	f=g-h;
#end
.data 
i: .word 0x80000001 
j: .word 0x10000002 
g: .word 0x00000005 
h: .word 0x00100004 
f: .word 0x00000005 
k: .word 0x80000005 
l: .word 0x00000007 
m: .word 0x00000002 
# num in rising order : 0x80000005 0x80000001 0x00000002 0x00000005 0x00000005 0x00000007 0x00100004 0x10000002
.text
# Before running this code make sure that
# Settings -> Memory Configuration -> Compact, Data at Address 0
	
		
	addi $a1,$zero, 7 # num of elements
	addi $a2,$zero, 0 # adress
	addi $a3,$zero, 7 # num of iter
		
	
	#strate forword bubble sort
LOOP11:	lw $t1, ($a2) #first element
LOOP12:	lw $t2,4($a2)	# second element
	slt $s0,$t1,$t2 #a modyfied slt for our assiment
	nop #a problame in the design wich was descovered too late ane will be attanted later	
	beq $s0, $zero,A # a>=B
	beq $zero,$zero,B#B>A
	
A:   	sw $t2,0($a2) #put it in the back !!
	subi $a1,$a1,1 #are we out of elements
	beq $a1,$zero,SET1 # yes
	addi $a2,$a2, 4 # address +4
	beq $zero,$zero, LOOP12	# moving on to next element
	

B:	sw $t1,0($a2) # stay where you are!
	subi $a1,$a1,1 #are we out of elements
	beq $a1,$zero,SET2 # yes
	addi $a2,$a2,4 # address +4
	beq $zero,$zero, LOOP11 # start over from next element
SET1:	sw $t1,4($a2) # put it in its place
SET2:	subi $a3, $a3, 1 # are we there yet??
	beq $zero,$a3,END # yes
	addi $a1,$zero,7 # restore num of elements
	addi $a2,$zero, 0 #reset address
	beq $zero,$zero, LOOP11 #on we go
	
	
END: 	lw $t1,0	# in the end, load so we can go over the sorted elements
	lw $t2,4
	lw $t3,8
	lw $t4,12
	lw $t5,16
	lw $t6,20
	lw $t7,24
	lw $s0,28
	
	
	

	
	
	
	
	

	
