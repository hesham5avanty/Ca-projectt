.data 
parg: .space 400     #the length of paragraph is 40character
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
la $a0,parg  #the paragraph will save in a0
la $a1,5   
syscall 

li $v0,5
syscall 

move $t0,$v0   #copy the value from v0 to t0

li $v0,8   #the prohram will start
la $a0,parg  #the paragraph will save in a0
la $a1,400  
syscall

li $t1,1  #the value of t1 =1

 beq $t0,$t1,task1   #if t1==t0 will branch to task1
   addi $t1,$t1,1    #the value of t1 will increase 1 (t1=t1+1)
   beq $t0,$t1,task2   #if t1==t0 will branch to task2
   addi $t1,$t1,1      #the value of t1 will increase 1 (t1=t1+1)
   beq $t0,$t1,task3     #if t1==t0 will branch to task3
   addi $t1,$t1,1      #the value of t1 will increase 1 (t1=t1+1)
   beq $t0,$t1,task4      #if t1==t0 will branch to task4
   addi $t1,$t1,1       #the value of t1 will increase 1 (t1=t1+1)
   beq $t0,$t1,task5      #if t1==t0 will branch to task5
   
   
task1:  #will count the number of character in paragraph
li $t4,0    #register t4 will start from bit0 (counter)
count:     # count is loop to count number of character and save it to t4
lb $t0,parg($t4)   #load character from pragraph
beqz $t0,counted    # branch to counted when counter reach the end of aaray
addi $t4,$t4,1     #t4=t4+1 (t4 will increase 1)
j count     #jumb and return to function count

counted:    # the array already counted
li $t0,0     # return t0 to 0

foraa:
beq $t0,$t4,endtask1    #if t4==t0 will implement endtask1
li $t3,1                  #make t3=1
lb $s0,parg($t0)          #load t0 in s0
beqz $s0,skipa       #if s0 equal zero or null will branch to skipa
addi $t1,$t0,1      #t1=t0+1

forbb:
beq $t1,$t4,endofforbb     #if t4==t1 branch to endofforbb
lb $s1,parg($t1)           # load character from paraghraph and put in s1
bne  $s0,$s1,exit          #if s1 != s0 will exit
addi $t3,$t3,1             #t3=t3+1
sb $zero,parg($t1)        #make index in t1 null
addi $t1,$t1,1           #make t1=t1+1
j forbb                  #jumb and return to function forbb

exit:
add $t1,$t1,1     #t1=t1+1
j forbb           #jumb and return to function forbb

skipa:
addi $t0,$t0,1       #t0=t0+1
j foraa            #jumb and return to function foraa



endofforb:
sb $s0,char($zero)    #store byte index zero in s0
   
li $v0,4   
    la $a0,char   #load char in a0
    syscall 
    

    
li $v0,1
    move $a0,$t3       #copy the value of t3 in a0 (a0=t3)
    syscall 
    
li $v0,4
    la $a0,space   #load space in a0
    syscall      
    
j skipa       #jumb and return to function skipa

endtask1:
   li   $v0,10 
    syscall

task2:


li $t0,0     #initialize register t0 from 0
li $t1,0     #initialize register t1 from 0
li $t2,' '   #save value of space in t2
li $t3,0     #initialize register t3 from 0
li $t4,0     #initialize register t4 from 0
li $t7,0     #initialize register t7 from 0

splitword:       #take copy from each character to another array and it stopped when arrive to space
lb $s0,parg($t0)    #save the value from t0 in s0
beqz $s0,finally      # branch to finally when s0 is zero or null
beq $s0,$t2,Start     # if t2==t0  branch to start
sb $s0,target($t1)    # store s0 in array target in index t1
addi $t0,$t0,1        #t0=t0+1
addi $t1,$t1,1        #t1=t1+1
j splitword          #jump and return to function splitword

finally:
li $t7,1          # load value 1 in t7

Start:
addi $t0,$t0,1        #add 1 to t0 (t0=t0+1)
move $t6,$t0         #take copy of the value from t0 to t6

startcount:
li $t0,0       # load value is 0 in t0
li $t1,0       # load value is 0 in t1
li $t4,0       # load value is 0 in t4

fora:
lb $s0,parg($t0)      # load byte that it in t0 and put it s0
lb $s1,target($t1)    # load byte that it in t1 and put it s1
beqz $s0,printt       #branch to print when s0 is zero or null
beqz $s1,endtarget    #branch to endtarget when s1 is zero or null
bne $s0,$s1,skip      # if s1==s0 implement the function skip
addi $t0,$t0,1        # add 1 to t0 (t0=t0+1)
addi $t1,$t1,1        # add 1 to s1 (s1=s1+1)
j fora                # jump to function fora

skip:
li $t1,0       # make t1=0
addi $t0,$t0,1    # add 1 to t0 (t0=t0+1)
j fora              # jump to function fora

endtarget:
addi $t4,$t4,1         # add 1 tp t4 (t4=t4+1)
j skip                # jump to function skip




printt:
li $v0,4
la $a0,target     #save the word in a0
syscall

li $v0,1
    move $a0,$t4    #copy the value from t4 to a0
    syscall
        
li $v0,4
la $a0,space      # laod space in register a0
syscall


  li $t1,0     #load the value 0 in t1
  for:
  lb $s0,target($t1)     #laod byte from t1 to s0
  beqz $s0,endnow        #branch to endnow when s0 equal zero or null
  sb $zero,target($t1)   #store value zero in t1
  addi $t1,$t1,1      # add 1 to t1 (t1=t1+1)
  j for               # jump to function for
  
  endnow:
  li $t1,0                     #make t1=0
  move $t0,$t6                 #copy the value from t6 to t0
  li $t4,0                     #make t4=0
  bne $t7,$t4,finallyprint     #if t4 != t7 implement finallyprint
  j splitword                  #jump to function splitword
        
              
 finallyprint:   
 li $v0,10  
 

task3:

li $t0,0   #load 0 in t0
countn:
lb $s0,replace($t0)    #load byte from t0 to s0
beqz $s0,endcound   #branch to endcound when s0 is zero or null
addi $t0,$t0,1    #add 1 to t0(t0=t0+1)
j countn          #jump to function countn

endcound:
li $t1,1       #load 1 to register t1
bne $t0,$t1,start       #if t1==t0 will branch to start
onechar:
li $t0,0    #load 0 to t0
lb $s0,find($t0)        #load the word from t0 to s0
lb $s2,replace($t0)     #load the word that i want to replace it from s2 to t0
onecharloop:
lb $s1,parg($t0)    #load the value from t0 to s1
beqz $s1,print     #branch to print when s1 equal zero or null
bne $s1,$s0,skip3   #if s0 !=s1 branch to skip3
sb $s2,target($t0)  #store the value in s2 in t0
addi $t0,$t0,1   #add 1 to t0 (t0=t0+1)
j onecharloop      #jump to function onecharloop

skip3:
sb $s1,target($t0)   #store s1 in t0
addi $t0,$t0,1       #add 1 to t0 (t0=t0+1)
j onecharloop        #jump to function onecharloop


start:
li $t2,' '   #load space to t2
li $t0,0    #load zero to t0
li $t1,0      #load zero to t1
lfind:
lb $s0,parg($t0)    #load the value in t0 to s0
lb $s1,find($t1)    #load the value in t1 to s1
beqz $s1,countz     #branch to countz when s1 is zero or null
bne $s0,$s1,nextword    #if s1 !=s0 branch to nextword
addi $t0,$t0,1         #add 1 to t0 (t0=t0+1)
addi $t1,$t1,1        #add 1 to t1 (t1=t1+1)
j lfind               #jump to function lfind

nextword:
li $t1,0           #load 0 to t1
move $t4,$t0       #copy the value in t0 to t4
loopnextword:
lb $s0,parg($t0)        #load the value of t0 in s0
beqz $s0,print         #branch to print when s0 equal zero or null  
addi $t0,$t0,1         #add 1 to t0 (t0=t0+1)
beq $s0,$t2,lfind      #if t2==s0 branch to lfind
j loopnextword         #jump to function loopnextword

countz:
li $t3,0     #load 0 in t3
countloop:
lb $s0,find($t3)     #load the byte in t3 to s0
beqz $s0,found       #branch to found when s0 equal zero or null
addi $t3,$t3,1       #add 1 to t3 (t3=t3+1)
j countloop            #jump to function countloop


found:
li $t1,0        #load 0 to t1
move $t4,$t0     #copy the value from t0 to t4
sub $t0,$t0,$t3     #subtract t3 and t0 and put the result in t0
foundloop:
beq $t1,$t0,step2     #if t0==t1 branch to step2
lb $s0,parg($t1)     #load the byte in t1 to s0
sb $s0,target($t1)   #store s0 to t1
addi $t1,$t1,1   #add 1 to t1 (t1=t1+1)
j foundloop       #jump to function foundloop

step2:
li $t0,0    #load 0 to t0
step2loop:
lb $s0,replace($t0)    #load the byte in t0 to s0
beqz $s0,step3         #branch to step3 when s0 equal zero or null
sb $s0,target($t1)    #store s0 in t1
addi $t0,$t0,1   #add 1 to t0 (t0=t0+1)
addi $t1,$t1,1   #add 1 to t1 (t1=t1+1)
j step2loop      #jump to function foundloop

step3:

step3loop:
lb $s0,parg($t4)     #load the byte in t4 to t0
beqz $s0,for        #btranch to for when s0 equal zero or null
sb $s0,target($t1)  #store s0 in t1
addi $t1,$t1,1   #add 1 to t1 (t1=t1+1)
addi $t4,$t4,1  #add 1 to t4 (t4=t4+1)
j step3loop     #jump to function step3loop

forz:
li $t0,0   #load 0 t0 t0
do:
lb $s0,target($t0)      #load t0 in s0
beqz $s0,start      #branch to start when s0 equal zero or null

sb $s0,parg($t0)    #store s0 in t0
addi $t0,$t0,1   #add 1 to t0 (t0=t0+1)
j do             #jump to function do


print:
li $v0,4   
la $a0,target  #load the word in target to a0
syscall 

li $v0,10
syscall 

task4:

li $t0,0     #initialize register t0 from 0
li $t1,0     #initialize register t1 from 0
li $t2,' '   #save value of space in t2
li $t3,0      #initialize register t3 from 0
li $t4,0     #initialize register t4 from 0
li $t7,0     #initialize register t7 from 0

splitwordd:
lb $s0,parg($t0)   #load t0 in s0
beqz $s0,finall    #branch to finall when s0 is zero or null
beq $s0,$t2,Start4    #if t2==s0 branch to start4
sb $s0,target($t1)    #store s0 in t1
addi $t0,$t0,1     #add 1 to t0
addi $t1,$t1,1   #add 1 to t1
j splitwordd      #jump to function do

finall:
li $t7,1

Start4:
addi $t0,$t0,1     #add 1 to t0
move $t6,$t0    #copy the value in t0 to t6

startcountz:
li $t0,0   #load 0 to t0
li $t1,0   #load 0 to t1
li $t4,0   #load 0 to t4
cbu:
lb $s0,parg($t0)   #load t0 in s0
lb $s1,target($t1)   #load t1 in s1
beqz $s0,printt4    #branch to print4 to s0
beqz $s1,endtarget    #barnch to endtarget when s1 is zero or null
bne $s0,$s1,skp     #if s1 !=s0 branch to skp
addi $t0,$t0,1     #add 1 to t0
addi $t1,$t1,1    #add 1 to t1
j cbu           #jump to function cbu


skp:
li $t1,0   #load 0 to t1
addi $t0,$t0,1   #add 1 to t0
j cbu         #jump to function cbu

endtarget4:
addi $t4,$t4,1  #add 1 to t4
j skp           #jump to function skp




printt4:

li $t1,0    #load 0 to t1
addi $t1,$t1,1     #add 1 to t1
beq $t4,$t1,goone   #if t1==t4 branch to goone
addi $t1,$t1,1    #add 1 to t1
beq $t4,$t1,goone    #if t1==t4 branch to goone
addi $t1,$t1,1       #add 1 to t1
beq $t4,$t1,goone    #if t1==t4 branch to goone

j clear             #jump to function skp

goone:
li $v0,4
la $a0,target   #load the value from target to a0
syscall

li $v0,1
    move $a0,$t4   #copy the value from t4 to a0
    syscall
        
li $v0,4
la $a0,space  #load space to a0
syscall


clear:
  li $t1,0    #load 0 to t1
  for4:
  lb $s0,target($t1)    #load byte from t1 to s0
  beqz $s0,endnow4      #branch to endnow4 when s0 equal zero or null
  sb $zero,target($t1)   #store zero in t1
  addi $t1,$t1,1   #add 1 to t1
  j for4      #jump to function for4
  
  endnow4:
  li $t1,0       #load 0 to t1
  move $t0,$t6   #copy the value from t6 to t0
  li $t4,0    #load 0 to t4
  bne $t7,$t4,finallyprin     #if t4 !=t7 branch to finallyprin
  j splitwordd       #jump to function splitwordd
        
              
 finallyprin:   
li $v0,4   
la $a0,target    #load target in a0
syscall

li $v0,1
    move $a0,$t4     #copy the value in t4 to a0
    syscall
  ####################################
   li $t1,0   #load 0 to t1branch to oop when t0 equal zero
  newfor:
  lb $s0,target($t1)    #load t1 to s0
  beqz $s0,newend    #branch to newend when s0 equal zero or null
  sb $zero,target($t1)    #store zero in t1
  addi $t1,$t1,1   #add 1 to t1
  j newfor         #jump to function newfor     
  
 newend:
 li $t4,0  #load 0 to t4
count4:
lb $t0,parg($t4)   #load byte t4 in t0
beqz $t0,oop      # or null
addi $t4,$t4,1   #add 1 to t4
j count4    #jump to function count4

oop:
li $t0,0   #load 0 to t0
fora4:
beq $t0,$t4,endoffora   #if t4==t0 branch to endoffora
li $t3,1   #load 1 to t3
lb $s0,parg($t0)   #load t0 to s0
beqz $s0,skip4    #branch to skip4 when s0 equal zero or null

addi $t1,$t0,1   #add 1 to t0 and the result is t1 (t1=t0+1)
forb:
beq $t1,$t4,endofforb4   #if t4==t1 branch to endofforb4
lb $s1,parg($t1)   #load t1 to s1
bne  $s0,$s1,exit4   #if s1 !=s0 branch to exit4
addi $t3,$t3,1     #add 1 to t3
sb $zero,parg($t1)   #store zero in t1
addi $t1,$t1,1     #add 1 to t1
j forb        #jump to function forb

exit4:
add $t1,$t1,1    #add 1 to t1
j forb      #jump to function forb

skip4:
addi $t0,$t0,1   #add 1 to t0

j fora4   #jump to function fora4



endofforb4:
sb $s0,target($zero)   #store the value zero in s0
li $t1,0     #load 0 to t1
addi $t1,$t1,1    #add 1 to t1
beq $t3,$t1,gotwo    #if t1==t3 branch to gotwo
addi $t1,$t1,1   #add 1 to t1
beq $t3,$t1,gotwo    #if t1==t3 branch to gotwo
addi $t1,$t1,1     #add 1 to t1
beq $t3,$t1,gotwo    #if t1==t3 branch to gotwo
li $t1,0            #load 0 to t1
j skip4              #jump to function fora4
   
gotwo:   
li $v0,4
    la $a0,target   #load target in a0
    syscall 
    

    
li $v0,1
    move $a0,$t3   #copy the value from t3 to a0
    syscall 
    
li $v0,4
    la $a0,space  #load space to a0
    syscall      
    
j skip4      #jump to function skip4


endoffora:
   li   $v0,10    
    syscall
                     
task5:

li $t0,0      #load 0 to t0
li $t1,0      #load 0 to t1
li $t2,0      #load 0 to t2
li $t3,0      #load 0 to t3
li $t4,' '    #load space to t4
li $t5,0      #load 0 to t5
li $t6,0      #load 0 to t6
li $t7,1      #load 1 to t7
li $v0,4       
 la $a0,mass    
 syscall 
 
 countostr:    #count the number of the specific word that will Search for it 
 lb $s0,target($t6)            #load byte from Search word
 beqz $s0,fora5       #ask if it the last one of search word
 addi $t6,$t6,1       #increase the counter
 j countostr          #jump to function countostr
 
fora5:             #check the  index of space word  from the parg
lb $s0,parg($t0)   #load t0 to s0
lb $s1,target($t1)   #load t1 to s1
beqz $s0,endname       #end the prgram if all word in parg is check
beqz $s1,endtargetchoice       #ask if space word is a char or a word
bne $s0,$s1,skip5              #skip if they no equl
addi $t0,$t0,1                 #increase the counter
addi $t1,$t1,1                 #increase the counter
j fora5                        #jump to function fora5

endtargetchoice:
beq $t6,$t7,endtargetforchar       # go to endtargetforchar if it is a char
j endtarget5                       #else go to endtarget

skip5:
li $t1,0       #load 0 to t1
addi $t0,$t0,1    #add 1 to t0
j fora5           #jump to function fora5

endtarget5:
addi $t2,$t2,1     #add 1 to t2
move  $t3,$t0     #copy the value from t0 to t3
loop5:
lb $s0,parg($t3)         #load t3 to s0
beq $s0,$t4,countspace   #if t4==s0 branch to countspace
beq $t3,$zero,endloop4   #if t3=zero branch to endloop4
sub  $t3,$t3,1          #subtract 1 from t3 (t3=t3-1)
j loop5                  #jump to function loop5
endloop4: #print the postion of word    
li $v0,1
    move $a0,$t5   #copy the value in t5 to a0
    syscall
    li $t5,0    #load 0 to t5
    li $v0,4     
    la $a0,space    #load space to a0
    syscall   
j skip5              #jump to function skip5

countspace:
addi $t5,$t5,1    #add 1 to t5
sub  $t3,$t3,1    #add 1 to t3
j loop5           #jump to function loop5


endtargetforchar:   #print index of char
li $v0,1
move $a0,$t0    #copy the value in t0 to a0
syscall
 li $v0,4
    la $a0,space    #load space to a0
    syscall   
addi $t2,$t2,1     #add 1 to t2
j skip5            #jump to function skip5


endname: #print the word how many time repated
li $v0,4
 la $a0,mass2
 syscall 
 li $v0,4
    la $a0,space      #load space to a0
    syscall   
li $v0,1
    move $a0,$t2     #copy the value from t2 to a0
    syscall
li $v0,10
syscall
