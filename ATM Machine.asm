.model small
.stack 100
.data 
INTROMSG db 0dh,0ah,"*** WELCOME TO GREEN BANK ***$",10,13

INTRO DB '*** AUTOMATED TELLER MACHINE SYSTEM ***$',10,13

ThankYouMSG db 0dh,0ah, "Thank Yoy For Chossing GREEN BANK $",10,13
msg db 0dh,0ah, "Exit or deposit/withdrawal (e/d/w)?:  $"
answerFromUser db ?        
MSGUSERNAME DB 0dh,0ah, "      Username : $"         


errorInputMessage db 0dh,0ah, "Please enter y or n only!  $"
msgD db 0dh,0ah, "In deposit section$"  
msgW db 0dh,0ah, "In withdrawal section$"
calcD db 0dh,0ah, "Data calculate Section$"
msgReEnter db 0dh,0ah, "ReEnter deposit withdraw (y/n)?:  $"

msgSD db 0dh,0ah, "Enter amount of deposit :  $"
answerForDw db 6 dup('$')
msgSW db 0dh,0ah, "Enter amount of withdrawal :  $"

username db 'green123$'                   ;username = green123
etrname db 10 dup (?)                    ;to store your enter username
askname db 10,13, 'Enter Username : $'   
wrgname db 10,13, 'Wrong Username!$ '    
crtname db 10,13, 'Correct Username.$'	

password db '12345'                     ;password = 12345
etrpwd db 10 dup (?)                    ;to store your enter password
askpwd db 10,13, 'Enter Password : $'   
wrgpwd db 10,13, 'Wrong Password!$ '    
crtpwd db 10,13, 'Correct Password.$'	
loginf db 10,13, 'Login Failed ! Please Try Again!$'    
loginp db 10,13, '* SUCCESSFULLY LOGGED IN ***$'            

newline db 0dh,0ah, '$' 


DWE db 10,13, '==========MAIN MENU============ $'     
AMG db 10,13, '|     (A) FOR ACCOUNT DETAILS |$'     
DPT db 10,13, '|     (D) FOR DEPOSIT         |$'                         
WDW db 10,13, '|     (W) FOR WITHDRAWAL      |$'                      
EXT db 10,13, '|     (E) FOR EXIT            |$'                              
DWEA db 10,13, '|                             | $'
WRG_CHO DB 10,13, '! PLEASE CHOOSE A VAILD INPUT !$'   
UR_CHO DB 10,13, 'INPUT (A/D/W/E): $'

DPT_MSG DB 10,13, '**** DEPOSIT****$' 
WDW_MSG DB 10,13, '*** WITHDRAWAL ***$' 


QuestionD db 0dh , 0ah, "Please choose your Deposit Amount or (B) for back :  $"
QuestionW db 0dh , 0ah, "Please choose your Withdrawal Amount or (B) for back :  $"
        
Deposit6 db 0dh , 0ah, "=====================================$"
INFO db 0dh , 0ah,     "KEYS         DEPOSIT AMOUNT        $"
Deposit1 db 0dh , 0ah, "(1)              TK 100            $"
Deposit2 db 0dh , 0ah, "(2)              TK 200            $"
Deposit3 db 0dh , 0ah, "(3)              TK 400            $" 
Deposit4 db 0dh , 0ah, "(4)              TK 1000           $" 
Deposit5 db 0dh , 0ah, "=====================================$"  

Withdrawal6 db 0dh , 0ah, "==================================$"
INFOW db 0dh , 0ah,       "KEYS       WITHDRAWAL AMOUNT    $"
Withdrawal1 db 0dh , 0ah, "(1)              TK 100         $" 
Withdrawal2 db 0dh , 0ah, "(2)              TK 200         $" 
Withdrawal3 db 0dh , 0ah, "(3)              TK 400         $" 
Withdrawal4 db 0dh , 0ah, "(4)              TK 1000        $"
Withdrawal5 db 0dh , 0ah, "==================================$"  
  
descThatAll db 0dh , 0ah, "Is that all? (Y)/(N):  $"   
errorYOrNOnly db 0dh , 0ah, "INVALID INPUT.(Y) for yes and ?? for no ONLY!! $"  
withdrawalComfirmationMSG  db 0dh , 0ah, "Are you sure you want to withdraw TK $" 
questionMark db "? : ","$"                                                        

descTotalSum db 0dh,0ah,         "=== Summary of Accounts ===$"
descCurrentAmount db 0dh,0ah,    "      Current Amount in Account :  TK $"    
endTotalSum  db 0dh,0ah,         "=== End of Summary of Accounts ===$"

descDAmount db 0dh,0ah, "Deposited amount  :  $"
descWAmount db 0dh,0ah, "Withdrawal amount :  $" 
 
deposited100 db 0dh,0ah, "Successfully deposited TK 100  $"
deposited200 db 0dh,0ah, "Successfully deposited TK 200  $" 
deposited400 db 0dh,0ah, "Successfully deposited TK 400  $"  
deposited1000 db 0dh,0ah, "Successfully deposited TK 1000  $"  

withdrawal100 db 0dh,0ah, "Successfully withdrawed TK 100  $"
withdrawal200 db 0dh,0ah, "Successfully withdrawed TK 200  $" 
withdrawal400 db 0dh,0ah, "Successfully withdrawed TK 400  $"  
withdrawal1000 db 0dh,0ah, "Successfully withdrawed TK 1000  $"

withdrawAmount dw 0
enteredDWAmount dw 0  
accountCurrent dw 0
inputForThatAll db ?        
currentlyDOrW dw ?    ;0 for deposit section, 1 for withdrawal section

ErrorMsg db 0dh , 0ah,"Invalid input. Please Choose Again! $"
withdrawErrorMSG db 0dh , 0ah,"Not enough deposits in account $"
zeroMSG db "0$"
xyz dw 0
pressYorN  db 0dh , 0ah,"Press (Y) for yes ?? for no. $" 
.CODE
   
macro printString str    ;USING MACRO FOR USING LESS CODE
    lea dx, str
    mov ah, 09h 
    int 21h 
endm

jmp start  

proc accountStatus 
    
    
    printString descTotalSum             
    printString newline                 
    printString MSGUSERNAME
    printString username 
    printString newline  
    printString descCurrentAmount       
    
    mov ax, accountCurrent
    call check0              ;Here compare with 0 for starting
    mov ax, accountCurrent
    call printNumber         ;print the ammount in ax
    printString newline
    printString endTotalSum
    printString newline
    jmp CHOICE
    ret
     
endp accountStatus
 
 
proc comfirmWithdrawal           
     
     mov ax,withdrawAmount
     mov xyz,ax 
     printString NEWLINE
     printString pressYorN
goHereStart:  
     
     printString withdrawalComfirmationMSG    
     
     mov ax, xyz 
     mov withdrawAmount,ax
     mov ax, withdrawAmount
     call printNumber      
     mov withdrawAmount,0 
                                              
     printString questionMark                 
             
     MOV AH,1                                 
     INT 21H                                  
     CMP AL,'n'                 
     JE  CHOICE                 
     CMP AL,'N'                 
     JE  CHOICE                 
     CMP AL,'Y'                               
     JE  goHere      
     CMP AL,'y'                 
     JE  goHere
     
     printString errorYOrNOnly                
     
     jmp goHereStart 
 
goHere:       
     ret
      
endp comfirmWithdrawal 
 
check0 proc  
    
    cmp ax,0
    jne endCheck0
    lea dx, zeroMSG
    mov ah, 09h
    int 21h 
    
    endCheck0:
    ret  
    
check0 endp


printNumber proc    ;compare with 0 and assci to decibel                  
    
    mov cx, 0
    mov dx, 0 

    label1: 
        cmp ax, 0 
        je print1 
        mov bx, 10 
        div bx 
        push dx 
        inc cx 
        xor dx, dx 
        jmp label1 

    print1:
        cmp cx, 0 
        je exitprint 
        pop dx 
        add dx, 48 
        mov ah, 02h 
        int 21h 
        dec cx 
        jmp print1 

    exitprint:
        ret   
        
printNumber endp
 
 
withdrawCODE proc 
    
WITHDRAWALSECTION: 
     MOV withdrawAmount,0
     
     printString Withdrawal6
     
     printString INFOW                   
              
     printString Withdrawal1                            
     printString Withdrawal2                  
     printString Withdrawal3             
     printString Withdrawal4              
     printString Withdrawal5
        
     printString QuestionW               
     
     
     MOV AH,1                   
     INT 21H 
     
     CMP AL,49                   ;IF AL=1
     JE JumpW1
     
     CMP AL,50                   ;IF AL=2 
     JE JumpW2 
      
     CMP AL,51                   ;IF AL=3 
     JE JumpW3      
     
     CMP AL,52                   ;IF AL=4 
     JE JumpW4 
     
     CMP AL, 'B'                 ;IF B GO BACK TO CHOICE
     JE CHOICE 
     
     CMP AL, 'b'
     JE CHOICE
     
     JMP ERROR  
     
 
 ERROR:                             
    
    printString ErrorMsg           
     
    JMP WITHDRAWALSECTION
    
 JumpW1:                      ; (1) WITHDRAW 100
    add withdrawAmount,100
    cmp accountCurrent,100
    jl withdrawNotEnough         ;JMP IF CURRENT AMOUNT LESS THAN 100    
    call comfirmWithdrawal
    sub accountCurrent, 100
         
    printString withdrawal100    ;"Successfully withdrawal 100  $"
    
    jmp sumOfW
        
 JumpW2:                      ;JMP HERE IF CHOOSE (2) WITHDRAW 200
    add withdrawAmount,200  
    cmp accountCurrent,200
    jl withdrawNotEnough         ;JMP IF CURRENT AMOUNT LESS THAN 200
    call comfirmWithdrawal  
    sub accountCurrent, 200 
    
    printString withdrawal200    ;"Successfully withdrawal 200  $"
        
    jmp sumOfW

 JumpW3:                      ;JMP HERE IF CHOOSE (3) WITHDRAW 400
     add withdrawAmount,400      
     cmp accountCurrent,400
     jl withdrawNotEnough        ;JMP IF CURRENT AMOUNT LESS THAN 400
     call comfirmWithdrawal  
     sub accountCurrent, 400
      
     printString withdrawal400   ;"Successfully withdrawal 400  $"
     
     jmp sumOfW 
     
 JumpW4:                      ;JMP HERE IF CHOOSE (4) WITHDRAW 1000
    add withdrawAmount,1000 
    cmp accountCurrent,1000
    jl withdrawNotEnough         ;JMP IF CURRENT AMOUNT LESS THAN 1000
    call comfirmWithdrawal  
    sub accountCurrent, 1000
      
    printString withdrawal1000   ;"Successfully withdrawal 1000  $"
      
    jmp sumOfW
         
withdrawNotEnough:               
printString withdrawErrorMSG     
jmp WITHDRAWALSECTION            
            
     
sumOfW:          ; taka withdraw ar por koto asa oita dakhar jonno                    
    
    call accountStatus
   
    ret
withdrawCODE endp   


depositCODE proc              
    
     DEPOSITSECTION:
     
     printString Deposit6
     printString INFO                 
                
     printString Deposit1                
     printString Deposit2                  
     printString Deposit3             
     printString Deposit4              
     printString Deposit5
        
     printString QuestionD              
   
     
     MOV AH,1                    ;TAKE AN INPUT & SAVED TO AL
     INT 21H 
     
     CMP AL,49                   ;IF AL=1
     JE JumpD1
     
     CMP AL,50                   ;IF AL=2 
     JE JumpD2 
      
     CMP AL,51                   ;IF AL=3 
     JE JumpD3      
     
     CMP AL,52                  ;IF AL=4 
     JE JumpD4
     
     CMP AL, 'B'                 ;IF B GO BACK TO CHOICE
     JE CHOICE 
     
     CMP AL, 'b'
     JE CHOICE 
     
     JMP ERRORD  
     
 
 ERRORD:                        
    
    printString ErrorMsg               
    
    JMP DEPOSITSECTION           
    
 JumpD1:
    add accountCurrent, 100 
    printString deposited100     ;"Successfully deposited 100  $"
    JMP ThatAllDW
        
 JumpD2:        
    add accountCurrent, 200 
    printString deposited200     ;"Successfully deposited 200  $"
    JMP ThatAllDW

 JumpD3:
    add accountCurrent, 400  
    printString deposited400     ;"Successfully deposited 400  $"
    JMP ThatAllDW   
    
 JumpD4:
    add accountCurrent, 1000  
    printString deposited1000    ;"Successfully deposited 1000  $"
    JMP ThatAllDW
            
ThatAllDW:                       ;CONFIRMATION
     LEA DX,descThatAll          
     MOV AH,9       
     INT 21H  
             
     MOV AH,1                    
     INT 21H                     
     CMP AL,'y'                    
     JE  sumOfDW                   
     CMP AL,'Y'                     
     JE  sumOfDW                             
     CMP AL,'n'                  
     JE  DEPOSITSECTION                    
     CMP AL,'N'                    
     JE  DEPOSITSECTION 
         
     printString errorYOrNOnly   
             
     JMP THATALLDW  
     
sumOfDW:                            ;Taka joma dilam akon ki add hoilo ki na oitar jonno
    call accountStatus
       
    ret
depositCODE endp
                                     
MAIN PROC
start:    
     mov ax, @data
     mov ds, ax       
;INTRO   
    printString INTROMSG    
    printString NEWLINE
    printString INTRO        
    printString NEWLINE
    
     
;USERNAME START HERE

UsernameStart:
    lea si, username             ;load offset of username on si
    lea di, etrname              ;load offset of enterusername on di
     
    printString askname            
    mov cx, 8                    ;total number of chars of ur password
    
CheckName:
    mov ah, 07                   
    int 21h
    
    mov [di], al                 ;ait onsho ta youtube ar help
    inc di 
    mov ah, 2                    
    mov dl, al
    int 21h
    loop CheckName              
    lea si, username             ;load offset of password on si
    lea di, etrname              ;load offset of enterpassword on di   
    mov cx, 7                    ;cx = 5 , number of password    
    mov bx, 0                    
    
CompareName:
    mov bl,[si]                  ;load [si] on bl store kora user name
    mov bh,[di]                  ;load [di] on bh jeta ami dilam
    
    inc si
    inc di
    
    cmp bl, bh                   ;compare bh and bl to soman ki na
    jne WrongName               
    loop CompareName             
    
    printString crtname          
   
    printString newline
       
    jmp PasswordStart            ;go to password
    
WrongName:
    printString wrgname          ;user name vul korle ai ta asbe
    
    printString newline
    
    jmp UsernameStart  

;PASSWORD START HERE

PasswordStart:
    lea si, password             ;load offset of password on si
    lea di, etrpwd               ;load offset of enterpassword on di
     
    mov ah, 9h                   
    lea dx, askpwd
    int 21h
    
    mov cx, 5                    ;total number of chars of ur password
    
CheckPwd:
    mov ah, 07                   
    int 21h
    
    mov [di], al                 
    inc di
    
    mov ah, 2                    ;display * on ur screen to hide password
    mov dl, '*'
    int 21h
    
    loop CheckPwd                ;loop until cx=0 
    
    lea si, password             ;load offset of password on si
    lea di, etrpwd               ;load offset of enterpassword on di
    
    mov cx, 5                    ;cx = 5 , number of password
    
    mov bx, 0                    ;initialize for operation
    
ComparePwd:
    mov bl,[si]                  ;load [si] on bl
    mov bh,[di]                  ;load [di] on bh
    
    inc si
    inc di
    
    cmp bl, bh                   ;compare bh and bl to check their equality
    jne WrongPwd                 ;jump to zz if they are not equal
    loop ComparePwd              ;loop until cx=0 
    printString crtpwd           ;'Correct Password!$'
    printString loginp           ;'***SUCCESSFULLY LOGIN***$'  
    
    mov ah, 9                    ;newline
    printString newline
    printString newline

    jmp CHOICE                   ;SUCCEED THEN GO TO CHOICE
    
WrongPwd: 
    printString wrgpwd               ;'Wrong Username!$ '
    printString NEWLINE

    printString loginf               ;'Login Failed! Please Try Again!$'
    printString newline
  
    jmp UsernameStart                ;JMP TO INPUT USERNAME AGAIN

CHOICE:                               
    printString NEWLINE 
    printString DWE             ;'===PLEASE CHOOSE ONE OF IT=== $'
    printString DWEA
    printString AMG             ;'(A) FOR ACCOUNT DETAILS $'
    printString DWEA 
    printString DPT             ;'(D) FOR DEPOSIT $'
    printString DWEA
    printString WDW             ;'(W) FOR WITHDRAWAL $'
    printString DWEA
    printString EXT 
    printString DWEA 
    printString DWE             ;'(E) FOR EXIT $'
    printString NEWLINE
    printString UR_CHO          ;'INPUT (A/D/W/E): $'
                          

MOV AH, 1H                      ;INPUT FOR 2 BYTE
INT 21H    

CMP AL, 'a'                     ;IF D THEN JMP TO DEPOSIT
je callAccount

CMP AL, 'A'                     ;IF D THEN JMP TO DEPOSIT
je callAccount

jmp continueHERETHEN:

callAccount:   

   CALL accountStatus

continueHERETHEN:

CMP AL, 'd'                    ;IF D THEN JMP TO DEPOSIT
JE continueToD
CMP AL, 'D'                    ;IF D THEN JMP TO DEPOSIT
JE continueToD

CMP AL, 'w'                    ;IF W THEN JMP TO WITHDRWAL
JE continueToW
CMP AL, 'W'                    ;IF W THEN JMP TO WITHDRWAL
JE continueToW

CMP AL, 'e'                    ;IF E THEN JMP TO EXIT   
JE exit                        ;JMP TO EXIT

CMP AL, 'E'                    ;IF E THEN JMP TO EXIT   
JE exit                        ;JMP TO EXIT
JMP ERROR_CHOICE               ;JMP TO ERROR_CHOICE

ERROR_CHOICE:                  ;IF INPUT NOT IN CHOICES JMP HERE
mov ah, 9                      ;NEWLINE
lea dx, NEWLINE
int 21h

mov ah, 9                      ;DISPLAY E FOR EXIT
lea dx, WRG_CHO
int 21h 
                               ;JMP BACK TO CHOICE AGAIN
JMP CHOICE
      
continueToD:  
       call depositCODE
       jmp CHOICE  
                      
continueToW:  
       call withdrawCODE 
       jmp CHOICE

       
exit:        
        printString ThankYouMSG
       mov ah, 4ch       ;end the program
       int 21h
       
MAIN ENDP
END MAIN