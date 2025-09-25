section .data ; Initialized data (variables)
    num1 dq 15                  ; First number (64-bit)
    num2 dq 27                  ; Second number (64-bit)
    result dq 0                 ; Store result here
    msg db "The sum is: "       ; Message prefix
    msg_len equ $ - msg
    newline db 0xA              ; String with newline character
    ; Buffer for number (max 20 digits for 64-bit number)
    buffer times 21 db 0        ; Increase the buffer size

section .text ; Code
    global _start ; Make label accessible from outside

_start: ; _start: Code label (ends with colon)
    ; Add the two numbers
    mov rax, [num1]             ; Load first number into RAX
    add rax, [num2]             ; Add second number to RAX

    ; Display the message
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, msg                ; message
    mov rdx, msg_len            ; message length
    syscall

    ; Convert number to string and display (SIMPLIFIED)
    mov rax, [num1]
    add rax, [num2]             ; RAX = 15 + 27 = 42
    mov rdi, buffer             ; Point to buffer
    call int_to_string          ; Convert integer to string

    ; Display the number
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, buffer             ; number string
    mov rdx, 20                 ; max length
    syscall

    ; Display newline
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, newline            ; newline
    mov rdx, 1                  ; length
    syscall

    ; Exit program
    mov rax, 60
    mov rdi, 0
    syscall

; Function: Convert integer to string
; Input: 
    ; RAX = number
    ; RDI = buffer pointer
    ; RCX = buffer size

; SIMPLIFIED int_to_string function
int_to_string: ; Code label
    mov rbx, 10             ; Base 10 divisor
    mov rcx, 20             ; Max digits counter
    lea rsi, [buffer + 19]  ; Start from end of buffer
    mov byte [rsi], 0       ; Null terminator

.convert_loop:
    dec rsi                 ; Move backwards
    xor rdx, rdx            ; Clear RDX for division
    div rbx                 ; RAX = quotient, RDX = remainder
    add dl, '0'             ; Convert to ASCII
    mov [rsi], dl           ; Store digit
    test rax, rax           ; Check if quotient is zero
    jz .done
    loop .convert_loop      ; Continue if counter > 0

.done:
    ; Calculate string length
    mov rdi, buffer
    mov rcx, 20

; Move string to beginning of buffer
.find_start:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    test al, al
    jz .exit
    loop .find_start

.exit:
    ret
