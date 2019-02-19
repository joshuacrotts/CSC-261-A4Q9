; I have abided by the UNCG Academic Integrity Policy.
;
; Author:  Joshua Crotts
; Date:    February 25, 2019
;
; This program is a score counter for three different sports.
; Each sport has three different trials, which are averaged, and 
; multiplied by an arbitrary factor. 

INCLUDE io.h            ; header file for input/output

.586
.MODEL FLAT

.STACK 4096

.DATA

; NUMERIC & INPUT STRING DATA

inputBuffer			BYTE	40 DUP (?)


longJump			DWORD	?							; Long jump data, labels, avg, counter
longJumpAvg			DWORD	?
longJumpPrompt		BYTE	"Enter your long jump #"
counterLbl			BYTE	11 DUP (?), 0

highJump			DWORD	?							; High jump data, labels, avg, counter
highJumpAvg			DWORD	?
highJumpPrompt		BYTE	"Enter your high jump #"
counterLbl2			BYTE	11 DUP (?), 0		

shotPut				DWORD	?							; Shot put data, labels, avg, counter
shotPutAvg			DWORD	?
shotPutPrompt		BYTE	"Enter your shot-put #"
counterLbl3			BYTE	11 DUP (?), 0

weightedTotal		DWORD	?							; Grand total


;OUTPUT LABELS AND STRINGS

results				BYTE	"RESULTS: ", 0

longJumpAvgLbl		BYTE	"Long Jump Total: "
longJumpAvgStr		BYTE	11 DUP (?), 0dh, 0ah

highJumpAvgLbl		BYTE	"High Jump Total:"
highJumpAvgStr		BYTE	11 DUP (?), 0dh, 0ah

shotPutAvgLbl		BYTE	"Shot Put Total:"
shotPutAvgStr		BYTE	11 DUP (?), 0dh, 0ah

weightedTotalLbl	BYTE	"Grand total: "
weightedTotalStr	BYTE	11 DUP (?), 0

.CODE
_MainProc PROC

		mov		ecx, 1						; Moves initial counter (1) into ecx register

		; LONG JUMPS

		dtoa	counterLbl, ecx					; Converts current counter to ascii
		input	longJumpPrompt, inputBuffer, 40	; Input first long jump 
		atod	inputBuffer						; Converts the input to integer
		mov		longJump, eax					; Moves first long jump from reg to memory
		inc		ecx								; Increments counter in ecx register

		dtoa	counterLbl, ecx
		input	longJumpPrompt, inputBuffer, 40	; Input second long jump 
		atod	inputBuffer						; Converts the input to integer
		add		longJump, eax					; Moves second long jump from reg to memory
		inc		ecx

		dtoa	counterLbl, ecx
		input	longJumpPrompt, inputBuffer, 40	; Input third long jump 
		atod	inputBuffer						; Converts the input to integer
		add		longJump, eax					; Moves third long jump from reg to memory
		inc		ecx

		cdq										; Prepares eax and edx for 32-bit division
												; for quotient and remainder

		mov		eax, longJump					; Moves the average into eax register as dividend
		mov		ebx, 3							
		idiv	ebx								; Divides average by 3 trials

		mov		ebx, 7							
		imul	ebx								; Multiply long jump avg by 7

		mov		longJumpAvg, eax				; Grabs new factored average and stores it in memory
		mov		weightedTotal, eax				; Moves the factored average to the running total
		dtoa	longJumpAvgStr, eax				; Converts the factored average into its appropriate ascii representation
		mov		ecx, 1							; Resets counter

		; HIGH JUMPS

		dtoa	counterLbl2, ecx
		input	highJumpPrompt, inputBuffer, 40	 ; First high jump trial
		atod	inputBuffer
		add		highJump, eax
		inc		ecx

		dtoa	counterLbl2, ecx
		input	highJumpPrompt, inputBuffer, 40	 ; Second high jump trial
		atod	inputBuffer
		add		highJump, eax
		inc		ecx

		dtoa	counterLbl2, ecx
		input	highJumpPrompt, inputBuffer, 40  ; Third high jump trial
		atod	inputBuffer
		add		highJump, eax
		inc		ecx

		cdq
		mov		eax, highJump					; Moves the average into eax register as dividend
		mov		ebx, 3    						
		idiv	ebx								; Divides average by 3 trials

		mov		ebx, 4							
		imul	ebx								; Multiply high jump avg by 4

		mov		highJumpAvg, eax				; Grabs new factored average and stores it in memory
		add		weightedTotal, eax				; Adds on the shot put factored average to our running total
		dtoa	highJumpAvgStr, eax				; Converts high jump avg to ascii
		mov		ecx, 1

		; SHOT-PUT 

		dtoa	counterLbl3, ecx
		input	shotPutPrompt, inputBuffer, 40	; First shot-put trial
		atod	inputBuffer
		mov		shotPut, eax
		inc		ecx

		dtoa	counterLbl3, ecx
		input	shotPutPrompt, inputBuffer, 40	; Second shot-put trial
		atod	inputBuffer
		add		shotPut, eax
		inc		ecx

		dtoa	counterLbl3, ecx
		input	shotPutPrompt, inputBuffer, 40	; Third shot-put trial
		atod	inputBuffer
		add		shotPut, eax
		inc		ecx

		cdq
		mov		eax, shotPut					; Moves the average into eax register as dividend
		mov		ebx, 3    						
		idiv	ebx								; Divides average by 3 trials

		mov		ebx, 5							
		imul	ebx								; Multiply high jump avg by 5

		mov		shotPutAvg, eax					; Grabs new factored average and stores it in memory
		add		weightedTotal, eax				; Adds shot put avg to running total
		dtoa	shotPutAvgStr, eax

		mov		eax, weightedTotal				; Moves grand total to register to print
		dtoa	weightedTotalStr, eax			; Converts grand total that is in eax register to ascii

        output  results, longJumpAvgLbl         ; Outputs results label and starts printing strings
												; until last string with null-termination is reached.

        mov     eax, 0					; exit with return code 0
        ret

_MainProc ENDP
END										; end of source code

