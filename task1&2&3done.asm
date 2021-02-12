.data 
parg: .space 400
char: .asciiz ""
space: .asciiz " "
mass:.asciiz "the word's position is in :"
mass2:.asciiz "and it repated for "
target: .asciiz ""
find:     .asciiz  "w"
replace:  .asciiz  "g"
.text 
main:

li $v0,4
la $a0,parg
la $a1,5
syscall 

li $v0,5
syscall 

move $t0,$v0

li $v0,8
la $a0,parg
la $a1,400
syscall

li $t1,1

 beq $t0,$t1,task1
   addi $t1,$t1,1
   beq $t0,$t1,task2
   addi $t1,$t1,1
   beq $t0,$t1,task3
   addi $t1,$t1,1
   beq $t0,$t1,task4
   addi $t1,$t1,1
   beq $t0,$t1,task5
task1:
li $t4,0
count:
lb $t0,parg($t4)
beqz $t0,counted
addi $t4,$t4,1
j count 

counted:
li $t0,0
foraa:
beq $t0,$t4,endtask1
li $t3,1
lb $s0,parg($t0)
beqz $s0,skipa

addi $t1,$t0,1
forbb:
beq $t1,$t4,endofforb
lb $s1,parg($t1)
bne  $s0,$s1,exit
addi $t3,$t3,1
sb $zero,parg($t1)
addi $t1,$t1,1
j forbb

exit:
add $t1,$t1,1
j forbb

skipa:
addi $t0,$t0,1
j foraa



endofforb:
sb $s0,char($zero)
   
li $v0,4
    la $a0,char
    syscall 
    

    
li $v0,1
    move $a0,$t3
    syscall 
    
li $v0,4
    la $a0,space
    syscall      
    
j skipa


endtask1:
   li   $v0,10
    syscall

task2:


li $t0,0
li $t1,0
li $t2,' '
li $t3,0
li $t4,0
li $t7,0

splitword:
lb $s0,parg($t0)
beqz $s0,finally
beq $s0,$t2,Start
sb $s0,target($t1)
addi $t0,$t0,1
addi $t1,$t1,1
j splitword
finally:
li $t7,1

Start:
addi $t0,$t0,1
move $t6,$t0

startcount:
li $t0,0
li $t1,0
li $t4,0
fora:
lb $s0,parg($t0) 
lb $s1,target($t1)
beqz $s0,printt
beqz $s1,endtarget
bne $s0,$s1,skip
addi $t0,$t0,1
addi $t1,$t1,1
j fora

skip:
li $t1,0
addi $t0,$t0,1
j fora

endtarget:
addi $t4,$t4,1
j skip




printt:
li $v0,4
la $a0,target
syscall

li $v0,1
    move $a0,$t4
    syscall
        
li $v0,4
la $a0,space
syscall


  li $t1,0
  for:
  lb $s0,target($t1)
  beqz $s0,endnow
  sb $zero,target($t1)
  addi $t1,$t1,1
  j for
  
  endnow:
  li $t1,0
  move $t0,$t6
  li $t4,0
  bne $t7,$t4,finallyprint
  j splitword  
        
              
 finallyprint:   
 li $v0,10

task3:



li $t0,0
countn:
lb $s0,replace($t0)
beqz $s0,endcound
addi $t0,$t0,1
j countn

endcound:
li $t1,1
bne $t0,$t1,start
onechar:
li $t0,0
lb $s0,find($t0)
lb $s2,replace($t0)
onecharloop:
lb $s1,parg($t0)
beqz $s1,print
bne $s1,$s0,skip3
sb $s2,target($t0)
addi $t0,$t0,1
j onecharloop
skip3:
sb $s1,target($t0)
addi $t0,$t0,1
j onecharloop


start:
li $t2,' '
li $t0,0
li $t1,0
lfind:
lb $s0,parg($t0)
lb $s1,find($t1)
beqz $s1,countz
bne $s0,$s1,nextword
addi $t0,$t0,1
addi $t1,$t1,1
j lfind

nextword:
li $t1,0
move $t4,$t0
loopnextword:
lb $s0,parg($t0)
beqz $s0,print
addi $t0,$t0,1
beq $s0,$t2,lfind
j loopnextword

countz:
li $t3,0
countloop:
lb $s0,find($t3)
beqz $s0,found
addi $t3,$t3,1
j countloop

found:
li $t1,0
move $t4,$t0
sub $t0,$t0,$t3
foundloop:
beq $t1,$t0,step2
lb $s0,parg($t1)
sb $s0,target($t1)
addi $t1,$t1,1
j foundloop

step2:
li $t0,0
step2loop:
lb $s0,replace($t0)
beqz $s0,step3
sb $s0,target($t1)
addi $t0,$t0,1
addi $t1,$t1,1
j step2loop

step3:

step3loop:
lb $s0,parg($t4)
beqz $s0,for
sb $s0,target($t1)
addi $t1,$t1,1
addi $t4,$t4,1
j step3loop

forz:
li $t0,0
do:
lb $s0,target($t0)
beqz $s0,start

sb $s0,parg($t0)
addi $t0,$t0,1
j do

print:
li $v0,4
la $a0,target
syscall 

li $v0,10
syscall 

task4:


li $t0,0
li $t1,0
li $t2,' '
li $t3,0
li $t4,0
li $t7,0
splitwordd:
lb $s0,parg($t0)
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
lb $s0,parg($t0) 
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

endtarget4:
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
  beqz $s0,endnow4
  sb $zero,target($t1)
  addi $t1,$t1,1
  j for4
  
  endnow4:
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
count4:
lb $t0,parg($t4)
beqz $t0,oop
addi $t4,$t4,1
j count4 

oop:
li $t0,0
fora4:
beq $t0,$t4,endoffora
li $t3,1
lb $s0,parg($t0)
beqz $s0,skip4

addi $t1,$t0,1
forb:
beq $t1,$t4,endofforb4
lb $s1,parg($t1)
bne  $s0,$s1,exit4
addi $t3,$t3,1
sb $zero,parg($t1)
addi $t1,$t1,1
j forb

exit4:
add $t1,$t1,1
j forb

skip4:
addi $t0,$t0,1

j fora4



endofforb4:
sb $s0,target($zero)
li $t1,0
addi $t1,$t1,1
beq $t3,$t1,gotwo
addi $t1,$t1,1
beq $t3,$t1,gotwo
addi $t1,$t1,1
beq $t3,$t1,gotwo   
li $t1,0
j skip4   
   
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
    
j skip4


endoffora:
   li   $v0,10
    syscall
                     
task5:

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