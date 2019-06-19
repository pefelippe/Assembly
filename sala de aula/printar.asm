org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli
	mov si, msg
	call printar

printar:
	push si
	mov ah, 0x0e
.loop:
	lodsb
	or al, al
	jz fim
	int 0x10
	jmp .loop
fim:
	hlt

msg: db "oooi"
times 510 - ($-$$) db 0
dw 0xaa55



