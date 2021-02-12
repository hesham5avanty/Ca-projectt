.data 
prag: .asciiz "hesham work in voda hesham voda work voda work in mai mai work "
space: .asciiz " "
target: .asciiz ""
.text
main:


li $t0,0
li $t1,0
li $t2,' '
li $t3,0
li $t4,0
li $t7,0
splitwordd:
lb $s0,prag($t0)
beqz $s0,finall
beq $s0,$t2,Start4
sb $s0,target($t1)
addi $t0,$t0,1
addi $t1,$t1,1
j splitwordd
finall:
li $t7,1

Start4:
addi $t0,$t0,1
move $t6,$t0

startcountz:
li $t0,0
li $t1,0
li $t4,0
cbu:
lb $s0,prag($t0) 
lb $s1,target($t1)
beqz $s0,printt4
beqz $s1,endtarget
bne $s0,$s1,skp
addi $t0,$t0,1
addi $t1,$t1,1
j cbu

skp:
li $t1,0
addi $t0,$t0,1
j cbu

endtarget:
addi $t4,$t4,1
j skp



printt4:

li $t1,0
addi $t1,$t1,1
beq $t4,$t1,goone
addi $t1,$t1,1
beq $t4,$t1,goone
addi $t1,$t1,1
beq $t4,$t1,goone

j clear

goone:
li $v0,4
la $a0,target
syscall

li $v0,1
    move $a0,$t4
    syscall
        
li $v0,4
la $a0,space
syscall


clear:
  li $t1,0
  for4:
  lb $s0,target($t1)
  beqz $s0,endnow
  sb $zero,target($t1)
  addi $t1,$t1,1
  j for4
  
  endnow:
  li $t1,0
  move $t0,$t6
  li $t4,0
  bne $t7,$t4,finallyprin
  j splitwordd  
        
              
 finallyprin:   
li $v0,4
la $a0,target
syscall

li $v0,1
    move $a0,$t4
    syscall
  ####################################
   li $t1,0
  newfor:
  lb $s0,target($t1)
  beqz $s0,newend
  sb $zero,target($t1)
  addi $t1,$t1,1
  j newfor       
  
 newend:
 li $t4,0
count:
lb $t0,prag($t4)
beqz $t0,oop
addi $t4,$t4,1
j count 

oop:
li $t0,0
fora:
beq $t0,$t4,endoffora
li $t3,1
lb $s0,prag($t0)
beqz $s0,skip

addi $t1,$t0,1
forb:
beq $t1,$t4,endofforb
lb $s1,prag($t1)
bne  $s0,$s1,exit
addi $t3,$t3,1
sb $zero,prag($t1)
addi $t1,$t1,1
j forb

exit:
add $t1,$t1,1
j forb

skip:
addi $t0,$t0,1

j fora



endofforb:
sb $s0,target($zero)
li $t1,0
addi $t1,$t1,1
beq $t3,$t1,gotwo
addi $t1,$t1,1
beq $t3,$t1,gotwo
addi $t1,$t1,1
beq $t3,$t1,gotwo   
li $t1,0
j skip   
   
gotwo:   
li $v0,4
    la $a0,target
    syscall 
    

    
li $v0,1
    move $a0,$t3
    syscall 
    
li $v0,4
    la $a0,space
    syscall      
    
j skip


endoffora:
   li   $v0,10
    syscall
                     
