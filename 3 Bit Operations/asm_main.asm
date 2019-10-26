;
; file: asm_main.asm
; Description: Bitwise operation project, print out powers of 2 up to 2^31 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date: Sat Oct 26 00:04:49 PDT 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data


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
	mov	ecx,30
	mov	eax,2
	call	print_int
	call	print_nl
loop_start:
	shl	eax,1
	call	print_int
	call	print_nl
	loop	loop_start

        popa
        mov     eax, 0            ; return back to C
        leave
        ret
