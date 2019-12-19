;
; file: asm_main.asm
; Description: 
; Author: Raymond Laughrey
; Email: raymonl4963@student.vvc.edu
; Date: Sat Nov 23 17:59:42 PST 2019

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
; define array of 5 double word initialized.
%define ARRAY_SIZE 5
%define SCALAR 5
info1:  dd "Initial array values: ", 0
info2:  dd "Scaled array values:", 0
a1:     dd 1, 2, 3, 4, 5

; define array of words initialized to 0 using times.
arrEmpty:     times 10 dw 0

; uninitialized data is put in the .bss segment
;
segment .bss
; reserve an array.
a2:     resd    ARRAY_SIZE
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

        mov     eax,info2
        call    print_string
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

        mov     eax,a2
        mov     ecx,ARRAY_SIZE
        push    eax
        push    ecx
        call    print_array
        pop     ecx
        pop     eax

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
        call    print_nl
        lodsd
        loop    loopst1
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
        mov     edi,a2
; [0] = + 0, [1] = + 4, [2] = + 8, [3] = + 12, [4] = + 16. 

loopst:
        mov     edx,[esi]
        imul    edx,ebx  
        mov     eax,edx
        stosd                       ; stores eax in edi and increments it
        lodsd                       ; increments esi
        loop     loopst
; subprogram code ends here.
        pop     ebp
        ret
