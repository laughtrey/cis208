;
; file: asm_main.asm
; Description: Subprogram project
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date:

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
a: dd 87654321
b: dd 8
label1: dd "Checking to see if digit 87654321 contains 8", 0

; uninitialized data is put in the .bss segment
;
segment .bss
input1 resd 1

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0		; setup routine
        pusha
; assembly code begins here.
	mov	eax,label1
	call	print_string
	call	print_nl
	mov	eax,[a]
	mov	ebx,[b]
	push	eax
	push	ebx
	call	check_digit
	call	print_int	; 1 if contains digit, 0 if doesnt
	call	print_nl
	pop	eax
	pop	ebx

; assembly code ends here.
        popa
        mov     eax, 0		; return back to C
        leave
        ret

check_digit:
	push	ebp		; save original EBP value on stack
	mov	ebp,esp		; new EBP = ESP
; subprogram code begins here
	mov	eax,[ebp + 12]	; EAX is now pushed EAX
	mov	ebx,[ebp + 8]	; EBX is now pushed EBX
	mov	ecx,10		; ECX = 10 to divide off
	cdq			; initialize EDX for division
loop_start:
	cdq
	cmp	    eax,ebx		    ; compare eax and ebx
	je	    number_found	; jump to number_found label if equal
	div	    ecx		        ; otherwise, divide out the last number
	call	print_int
	call	print_nl
	cmp	    eax,0	    	; compare eax to see if it's still greater than 0, aka see if it still exists
	jg	    loop_start  	; if eax > 0, loop again
	jmp	    number_not_found; else jump to number_not_found
number_found:
	mov	eax,1
	jmp	end
number_not_found:
	mov	eax,0
end:
; subprogram code ends here
	pop	ebp
	ret


