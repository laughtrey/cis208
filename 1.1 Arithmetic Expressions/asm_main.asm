;
; file: asm_main.asm
; Description: Arithmetic operations project. A = (A-B) + A + (B - C + D) 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date: Thu Sep 19 17:56:13 PDT 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data

A: dd 40
B: dd 7
C: dd 13
D: dd 9

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
; next print out result message as series of steps

        mov     eax,[A] ; Puts A into eax register
		sub 	eax,[B] ; Subtracts B from the eax register
		mov		ebx,[B] ; Puts B into ebx register
		sub		ebx,[C] ; Subtracts C from the ebx register
		add		ebx,[D] ; Adds D to the ebx register
		add		eax,[A] ; Adds A into the eax register
		add		eax,ebx ; Adds the two registers, aka parenthesis.

        call    print_int
        call    print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


