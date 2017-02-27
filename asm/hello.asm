;hello.asm
; nasm -f elf64 hello.asm -l hello.list
; ld -o hello hello.o
; ./hello

;specify 64bit mode
bits 64

; specify elf executable text section
section .text

; specify start label
global _start

_start:
  xor   eax, eax
  mov   edx, eax
  inc   eax
  mov   edi, eax
  mov   dl, len
  mov   rsi, msg
  syscall
  xor   edi, edi
  mov   eax, edi
  mov   al, 60
  syscall

section .data
  msg   db  'hello, world', 0x0A
  len   equ $ - msg
