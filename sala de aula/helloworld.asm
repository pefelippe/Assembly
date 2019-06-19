org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli
	mov si, msg
	mov ah, 0x0e
print:
	lodsb
	or al, al
	jz fim
	int 0x10
	jmp print

fim:
	hlt

msg:
	db "hello world"

times 510 - ($-$$) db 0
dw 0xaa55
