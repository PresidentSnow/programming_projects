section .text
    global _start

; Simple code for test the "add_two_integers.asm" file.
_start:
    ; Simple addition test
    mov rax, 15
    mov rbx, 27
    add rax, rbx    ; Result should be 42 in RAX
    
    ; Just exit (no printing)
    mov rax, 60
    mov rdi, 0
    syscall