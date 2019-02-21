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
buffer			BYTE	11	DUP(?)

longJumps		DWORD	3	DUP(?)		;Long Jumps array
longJumpSum		DWORD	0			;Long Jump var to hold summation of all jumps, same for other 2

highJumps		DWORD	3	DUP(?)
highJumpSum		DWORD	0

shotPuts		DWORD	3	DUP(?)
shotPutSum		DWORD	0

ljPrompt		BYTE	"Enter your long jump:"
ljCount			BYTE	11	DUP(?), 0
hjPrompt		BYTE	"Enter your high jump:"
hjCount			BYTE	11	DUP(?), 0
spPrompt		BYTE	"Enter your shot put:"
spCount			BYTE	11	DUP(?)

longJumpAvg		DWORD	?
highJumpAvg		DWORD	?
shotPutAvg		DWORD	?

sum			DWORD	?

results			BYTE	"Results: ", 0
longJumpLbl		BYTE	"Long Jump: "
longJumpAvgStr		BYTE	11	DUP(?), 0dh, 0ah

highJumpAvgLbl		BYTE	"High Jump Total:"
highJumpAvgStr		BYTE	11 DUP (?), 0dh, 0ah

shotPutAvgLbl		BYTE	"Shot Put Total:"
shotPutAvgStr		BYTE	11 DUP (?), 0dh, 0ah

weightedTotalLbl	BYTE	"Grand total: "
weightedTotalStr	BYTE	11 DUP (?), 0

; EAX register used for general arithmetic
; EBX register used for incrementing counter (up from 0)
; ECX register used for looping (counting downward from 0)
; EDX register used for multiplication/division factors
; 
; Arrays aren't really used in this program to the extent they
; should; they're only for storing the results. The average is calculated 
; as the values are inserted (sum is incremented by a counter).

.CODE
_MainProc PROC
				;Long Jumps
				lea		esi, longJumps			; Loads in long jumps array to esi
				mov		ecx, 3				; sets counter to 3
				mov		ebx, 1				; Display counter, opposite of ecx

LJLoop:				dtoa		ljCount, ebx
				input		ljPrompt, buffer, 40		; read ASCII characters
				atod		buffer				; Converts buffer numbers to digits
				add		DWORD PTR[esi], eax		; Takes converted chars from eax and stores them in esi dereferenced array
				add		esi, 4				; offsets the pointer to the array
				inc		ebx				; Increments display counter variable (incrementing up)
				add		longJumpSum, eax		; Adds eax to the current long jump sum 
				loop	LJLoop
			

				; High Jumps
				lea		esi, highJumps			; Loads in high jumps array to esi
				mov		ecx, 3				; Resets counter 
				mov		ebx, 1

HJLoop:				dtoa		hjCount, ebx			; Resets display counter
				input		hjPrompt, buffer, 40	
				atod		buffer		
				add		DWORD PTR[esi], eax
				add		esi, 4
				inc		ebx
				add		highJumpSum, eax		; Adds eax to the current high jump sum
				loop	HJLoop


				; Shot Puts
				lea		esi, shotPuts			; Loads in shot puts array to esi
				mov		ecx, 3
				mov		ebx, 1

SPLoop:				dtoa		spCount, ebx
				input		spPrompt, buffer, 40
				atod		buffer
				add		DWORD PTR[esi], eax
				add		esi, 4
				inc		ebx
				add		shotPutSum, eax			; Adds eax to the current shot put sum
				loop	SPLoop
				

				;Long Jump Average
				cdq
				mov		eax, longJumpSum
				mov		ebx, 3
				idiv		ebx				; Divides sum by 3 to calc avg
				mov		ebx, 
				imul		ebx				; Multiplies quotient by factor of 7
				dtoa		longJumpAvgStr, eax		; Long Jump avg to ascii
				add		sum, eax			; Moves longJumpSum to eax for total summation


				;High Jump Average
				cdq
				mov		eax, highJumpSum
				mov		ebx, 3
				idiv		ebx				; Divides sum by 3 to calc avg
				mov		ebx, 4
				imul		ebx				; Multiplies quotient by factor of 7
				dtoa		highJumpAvgStr, eax		; Converts high jump avg to ascii
				add		sum, eax			; Moves highJumpSum to eax for total summation


				;Shot put Average
				cdq
				mov		eax, shotPutSum
				mov		ebx, 3
				idiv		ebx				; Divides sum by 3 to calc avg
				mov		ebx, 5
				imul		ebx				; Multiplies quotient by factor of 7
				dtoa		shotPutAvgStr, eax		; Converts shot put avg to ascii	
				add		sum, eax			; Moves shotPutSum to eax for total summation


				; Moves sum to label
				mov		eax, sum
				dtoa		weightedTotalStr, eax 

				output 		results, longJumpLbl		; Outputs results

				
        mov     eax, 0								; exit with return code 0
        ret
_MainProc ENDP
END										; end of source code
