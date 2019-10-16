;
; file: asm_main.asm
; Description: Control Structures, sum of all even numbers between 2 and 100 should be 2550, 
; prompt for 2 values and sum of all odds between them, sum of all squares between 1 and 100. 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date: Thu Oct 10 20:13:27 PDT 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
num1: dd 2
num2: dd 100
askforfirstvalue: dd "Please enter your first value: ", 0
askforsecondvalue: dd "Please enter your second value: ", 0
allyouroddvalues: dd "All the odd values between your two numbers, summed up: ", 0

; uninitialized data is put in the .bss segment
;
segment .bss
a: resd 1
b: resd 1
n: resd 1 	; reserved for sum of odd values

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0		; setup routine
        pusha
	
	mov	eax,0		; Moving 0 into eax, going to add to this register.
	mov	ebx,2		; Starting at 2, going to add 2 to this number each time.
	mov	ecx,50

loop_start:
	add	eax,ebx
	add	ebx,2
	loop	loop_start

loop_end:
	call	print_int
	call	print_nl

prompt:
	mov	eax,askforfirstvalue
	call	print_string
	call	print_nl
	call	read_int
	mov	[a],eax
	
	mov	eax,askforsecondvalue
	call	print_string
	call	print_nl
	call	read_int
	mov	[b],eax

	mov	eax,[a]		; We're now going to start the process to add all odd numbers from a to b
	test	eax,1		; Sets the ZF flag to 1 if the number in eax is even. 0001 = odd, 0010 = even
	jnz	oddnumber	; Jumps to the next part of the program if it's odd
	add	eax,1		; Otherwise let's add 1 to it and continue as normal. 
	mov	[a],eax
	mov	eax,[a]

oddnumber:
				; lets find n first since d will always equal 2 and a is the first term..
				; n = ((last - first) / difference) + 1
	mov	eax,[a]
	mov	ebx,[b]
	sub	ebx,eax
	mov	eax,ebx
	cdq			; initialize edx
	mov	ecx,2		; difference in every odd number = 2
	div	ecx
	add	eax,1		; eax is now n
	mov	[n],eax		; n is now n
				; (n/2) * (2 * a + d * (n - 1)) = arithmetic sum
	sub	eax,1		; subtracting 1 from n
	mul	ecx		; and multiplying it by d (2, still in ecx)
	mov	ebx,eax		; store that in ebx for now so I can mul a and 2 then add it
	mov	eax,[a]		;
	mul	ecx		; 2 * a is now in eax, I'll add ebx to it and have the big part of the equation
	add	eax,ebx		; going to now mul by n and then divide by ecx (2)
	mov	ebx,[n]
	mul	ebx
	div	ecx
	mov	ebx,eax
	mov	eax,allyouroddvalues
	call	print_string
	
	mov	eax,ebx
	call	print_int
	call	print_nl

sum_of_squares:
	xor	ecx,ecx
	xor	eax,eax
	xor	ebx,ebx
	mov	ecx,1

loop_squares_start:
	mov	eax,ecx
	mul	eax
	add	ebx,eax
	inc	ecx
	cmp	ecx,100
	jle	loop_squares_start

loop_squares_end:
	mov	eax,ebx
	call	print_int
	call	print_nl
	
        popa
        mov     eax, 0		; return back to C
        leave
        ret
