;
; file: asm_main.asm
; Description: 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date:

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
num1: dd 500
num2: dd 777
num3: dd 777

string1: dd "This is the IF statement", 0
string2: dd "This is the ELSE statement", 0
string3: dd "This is after the control structures", 0

; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	mov	eax,[num1]	; putting values into registers for comparison
	mov	ebx,[num2]
	mov	ecx,[num3]
	cmp	ebx,ecx
	je	thenblock	; JE = Jump if equal to, which they are.
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next

thenblock:
	mov	eax,string1
	call	print_string
	call	print_nl
next:
	mov	eax,[num1]
	cmp	eax,ebx
	jne	thenblock2	; JNE
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next2

thenblock2:
	mov	eax,string1
	call	print_string
	call	print_nl

next2:
	mov	eax,[num1]
	cmp	eax,ebx
	jl	thenblock3	; JL
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next3

thenblock3:
	mov	eax,string1
	call	print_string
	call	print_nl

next3:
	mov	eax,[num1]
	cmp	eax,ebx
	jle	thenblock4	; JLE
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next4

thenblock4:
	mov	eax,string1
	call	print_string
	call	print_nl

next4:
	mov	eax,[num1]
	cmp	eax,ebx
	jg	thenblock5	; JG
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next5

thenblock5:
	mov	eax,string1
	call	print_string
	call	print_nl

next5:
	mov	eax,[num1]
	cmp	eax,ebx
	jge	thenblock6	; JGE
	mov	eax,string2
	call	print_string
	call	print_nl
	jmp	next6

thenblock6:
	mov	eax,string1
	call	print_string
	call	print_nl

next6:
				; This is the end of the jump statements
	mov	eax,string3
	call	print_string
	call	print_nl

	mov	eax, 0
	mov	ecx, 10

loop_start:
	add	eax, 1 
	call	print_int
	call	print_nl
	loop	loop_start


        popa
        mov     eax, 0            ; return back to C
        leave
        ret
