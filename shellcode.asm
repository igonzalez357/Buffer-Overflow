; Intel Syntax
section .text
global _start

_start:
    xor rax, rax                  ; Clear RAX
    mov al, 59                    ; Syscall number: execve (0x3B)

    xor rdi, rdi                  ; Clear RDI
    push rdi                      ; NULL terminator for "/bin/sh"
    mov rdi, 0x68732f6e69622f2f   ; "/bin/sh" in little-endian
    push rdi                      ; Push "/bin/sh" onto the stack
    mov rdi, rsp                  ; RDI points to "/bin/sh"

    xor rsi, rsi                  ; RSI = NULL (argv)
    xor rdx, rdx                  ; RDX = NULL (envp)

    syscall                       ; Invoke execve("/bin/sh", NULL, NULL)
