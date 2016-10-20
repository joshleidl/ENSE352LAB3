; Put your name and a title for the program here

;;; Directives
            PRESERVE8
            THUMB  
			
			
;;; Equates

INITIAL_MSP	EQU		0x20001000	; Initial Main Stack Pointer Value	Allocating 
								; 1000 bytes to the stack as it grows down.
			     
								    
; Vector Table Mapped to Address 0 at Reset
; Linker requires __Vectors to be exported

      AREA    RESET, DATA, READONLY
      EXPORT  __Vectors

__Vectors	DCD		INITIAL_MSP			; stack pointer value when stack is empty
        	DCD		Reset_Handler		; reset vector
	 		
			ALIGN

;The program
; Linker requires Reset_Handler

      AREA    MYCODE, CODE, READONLY



			ENTRY
			EXPORT	Reset_Handler

			ALIGN
	


			
			
			
Reset_Handler	PROC
  

		LDR R0, = 0x3
	
		BL factorial ;Argument held in R0. Answer returned in R1.
		
		LDR R10, = 0x1
		ALIGN
			
		LDR R1, = string1
		BL countVowels ;String held in R1, answer returned in R2
		
		LDR R1, = string2
		BL countVowels


		ENDP
			
factorial  PROC
		
		CMP R0, #0x0
		BEQ zeroCase
		
		PUSH {R3}
		LDR R3,= 0x1 ;Designate R3 as the counter register
		LDR R1,= 0x1 ;Clear the return register
		
facLoop
		MULS R1, R3, R1
		
		CMP R3, R0
		BEQ regularCase
		
		ADD R3, R3, #1
		
		B facLoop
		
regularCase
		POP {R3};Return R3 to its original state
		
		BX LR

zeroCase
		; In the case that R0 is 0 return 1
		; no need to pop R3 in this case as it was never pushed
		LDR R1, =0x1
		BX LR

overflowCase
		;

		ENDP
			
countVowels PROC
	
		PUSH {R0, R3} 
		
		LDR R2, =-1
		

increment

		ADD R2, R2, #1
		
countLoop

		LDRB R3, [R1] ;R3 now holds character at pos R2
		ADD R1, R1, #1
		
		CMP R3, #0
		BEQ doneCounting
		
		CMP R3, #0x41 ;A
		BEQ increment
		CMP R3, #0x45 ;E
		BEQ increment
		CMP R3, #0x49 ;I
		BEQ increment
		CMP R3, #0x4F ;O
		BEQ increment
		CMP R3, #0x55 ;U
		BEQ increment
		CMP R3, #0x61 ;a
		BEQ increment
		CMP R3, #0x65 ;e
		BEQ increment
		CMP R3, #0x69 ;i
		BEQ increment
		CMP R3, #0x6F ;o
		BEQ increment
		CMP R3, #0x75 ;u
		BEQ increment
		
		B countLoop
		
doneCounting
		POP {R0, R3}

		BX LR
		
		ENDP



		ALIGN
			
string1
			DCB		"ENSE 352 is fun and I am learning ARM assembly!",0
			
string2
			DCB		"Yes I really love it!",0






	ALIGN

	END


