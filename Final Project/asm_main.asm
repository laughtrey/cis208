;
; file: asm_main.asm
; Description: Final project for x86 Assembly 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date: Mon Dec 09 21:35:54 PST 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
; define array of 5 double word initialized.
%define ARRAY_SIZE 10
%define SCALAR 10
info1:  dd "Initial array values: ", 0
info2:  dd "Add 10 to initial array values:", 0
info3:  dd "Scaled array values by 10:", 0
info4:  dd "Third and first array added:", 0

a1:     dd 180, 32, 455, 499, 388, 480, 239, 346, 257, 84

; uninitialized data is put in the .bss segment
;
segment .bss
; reserve an array.
a2:     resd    ARRAY_SIZE
a3:		resd	ARRAY_SIZE
a4:		resd	ARRAY_SIZE
;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; assembly code begins here.
        mov     eax,info1
        call    print_string
        call    print_nl
    
        mov     eax,a1
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ecx
        call    print_array
        pop     ecx
        pop     eax
        call    print_nl
        call    print_nl
        
        mov     eax,a1
        mov     ebx,10          ;or SCALAR since it's the same value
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ebx
        push    ecx
        call    array_addition
        pop     ecx
        pop     ebx
        pop     eax

        mov     eax,info2
        call    print_string
        call    print_nl

        mov     eax,a2
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ecx
        call    print_array
        pop     ecx
        pop     eax
        call    print_nl
        call    print_nl

        mov     eax,a1
        mov     ebx,SCALAR
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ebx
        push    ecx
        call    array_scalar
        pop     ecx
        pop     ebx
        pop     eax

        mov     eax,info3
        call    print_string
        call    print_nl

        mov     eax,a3
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ecx
        call    print_array
        pop     ecx
        pop     eax
        call    print_nl
        call    print_nl

        mov     eax,a1
        mov     ebx,a3
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ebx
        push    ecx
        call    mul_arrays
        pop     ecx
        pop     ebx
        pop     eax

        mov     eax,info4
        call    print_string
        call    print_nl

        mov     eax,a4
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ecx
        call    print_array
        pop     ecx
        pop     eax
        call    print_nl


; assembly code ends here.
        popa
        mov     eax, 0            ; return back to C
        leave
        ret

print_array:
        push    ebp
        mov     ebp,esp
; subprogram code begins here.
        mov     ecx,[ebp + 8]       ; ecx = array size
        mov     esi,[ebp + 12]      ; esi = beginning address of array

loopst1:
        mov     eax,[esi]
        call    print_int
        mov     eax,"  "
        call    print_char
        lodsd
        loop    loopst1
; subprogram code ends here.
        pop     ebp
        ret

array_addition:
        push    ebp
        mov     ebp,esp
; subprogram code begins here.
        cld
        mov     ecx,[ebp + 8]
        mov     ebx,[ebp + 12]
        mov     esi,[ebp + 16]
        mov     edi,a2
        
loopa:
        mov     eax,[esi]
        add     eax,ebx
        stosd
        lodsd
        loop    loopa
; subprogram code ends here.
        pop     ebp
        ret

array_scalar:
        push    ebp
        mov     ebp,esp
; subprogram code begins here.
        cld
        mov     ecx,[ebp + 8]       ; ecx = array size
        mov     ebx,[ebp + 12]      ; ebx = scalar
        mov     esi,[ebp + 16]      ; esi = beginning address of array 
        mov     edi,a3
; [0] = + 0, [1] = + 4, [2] = + 8, [3] = + 12, [4] = + 16. 

loopb:
        mov     eax,[esi]
        imul    eax,ebx  
        stosd                       ; stores eax in edi and increments it
        lodsd                       ; increments esi
        loop     loopb
; subprogram code ends here.
        pop     ebp
        ret

mul_arrays:
        push    ebp
        mov     ebp,esp
; subprogram code begins here.
        cld
        mov ecx,[ebp + 8]       ; ecx = array size
        mov ebx,[ebp + 12]      ; ebx = third array to multiple by first
        mov esi,[ebp + 16]      ; esi = beginning address of a1
        mov edi,a4

loopc:
        mov     eax,[esi]
        add     eax,[ebx]
        stosd
        lodsd
        add     ebx,4
        loop    loopc

; subprogram code ends here.
        pop    ebp
        ret

