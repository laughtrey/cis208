;
; file: asm_main.asm
; Description: Write an assembly program that will call each of the following functions that are defined in asm_io.asm 
; Author: Raymond Laughrey 
; Email: raymonl4963@student.vvc.edu
; Date: Thu Sep 19 20:23:34 PDT 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
num1:		dd 777
char1: 		dd "A"
string1: 	dd "spaghetti", 0
prompt1: 	dd "Please enter a number: ", 0 
success1: 	dd "Well done, your number is: ", 0
prompt2:	dd "Please enter a character: ", 0
success2:	dd "Sucess, your character is: ", 0
 

; uninitialized data is put in the .bss segment
;
segment .bss
input1 resd 1
input2 resd 1

;
; code is put in the .text segment
;
segment .text
       global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; next print out result message as series of steps

	mov	eax,[num1]
	call	print_int
	call	print_nl

	mov	eax,[char1]
	call	print_char
	call	print_nl

	mov 	eax,string1
	call	print_string
	call	print_nl
		
	mov	eax,prompt1
	call	print_string
	call	read_int
	mov	[input1],eax

	mov	eax,success1
	call	print_string
	mov	eax,[input1]
	call	print_int
	call	print_nl

	mov	eax,prompt2
	call	print_string
	call	read_char
	call	read_char
	mov	[input2],eax

	mov	eax,success2
	call	print_string
	mov	eax,[input2]
	call	print_char
	call	print_nl

	popa
	mov     eax, 0            ; return back to C
	leave
	ret
