section .data
    hello db 'Hello, World!', 0xA ; String with newline (0xA)
    hello_len equ $ - hello ; Calculate string length

section .text
    global _start

_start:
    ; Write hello world to stdout
    mov rax, 1          ; sys_write system call number
    mov rdi, 1          ; File descriptor: 1 (stdout)
    mov rsi, hello      ; Pointer to message
    mov rdx, hello_len  ; Message length
    syscall             ; Invoke system call

    ; Exit program (0)
    mov rax, 60         ; sys_exit system call number
    mov rdi, 0          ; exit status: 0
    syscall             ; invoke system call
