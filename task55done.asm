.data 
mass:.asciiz "the word's position is in :"
mass2:.asciiz "and it repated for "
parg:.asciiz "mai go gere mai now mai "
target: .asciiz "m"
space: .asciiz " "
.text

main:


li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,' '
li $t5,0
li $t6,0
li $t7,1
li $v0,4
 la $a0,mass
 syscall 
 
 countostr: #count the number of the specific word that will Search for it 
 lb $s0,target($t6) #load byte from Search word
 beqz $s0,fora5 #ask if it the last one of search word
 addi $t6,$t6,1 #increase the counter
 j countostr
 
fora5:#check the  index of space word  from the parg
lb $s0,parg($t0) 
lb $s1,target($t1)
beqz $s0,endname #end the prgram if all word in parg is check
beqz $s1,endtargetchoice #ask if space word is a char or a word
bne $s0,$s1,skip5 #skip if they no equl
addi $t0,$t0,1 #increase the counter
addi $t1,$t1,1 #increase the counter
j fora5

endtargetchoice:
beq $t6,$t7,endtargetforchar  # go to endtargetforchar if it is a char
j endtarget5 #else go to endtarget

skip5:
li $t1,0
addi $t0,$t0,1
j fora5

endtarget5:
addi $t2,$t2,1
move  $t3,$t0
loop5:
lb $s0,parg($t3)
beq $s0,$t4,countspace
beq $t3,$zero,endloop4
sub  $t3,$t3,1
j loop5
endloop4: #print the postion of word 
li $v0,1
    move $a0,$t5
    syscall
    li $t5,0
    li $v0,4
    la $a0,space
    syscall   
j skip5
countspace:
addi $t5,$t5,1
sub  $t3,$t3,1
j loop5


endtargetforchar:#print index of char
li $v0,1
move $a0,$t0
syscall
 li $v0,4
    la $a0,space
    syscall   
addi $t2,$t2,1
j skip5

endname: #print the word how many time repated
li $v0,4
 la $a0,mass2
 syscall 
 li $v0,4
    la $a0,space
    syscall   
li $v0,1
    move $a0,$t2
    syscall
li $v0,10
syscall 