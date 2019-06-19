
org 0x7c00
bits 16

xor ax, ax
mov ds, ax

Cor:
	cli

	mov al, 0x13
	int 0x10

	mov ax, 0xA000
	mov ds, ax

.pegarTecla:
	mov ah, 0
	int 0x16

.mudarCor:
	mov bx, 0
	mov cx, 64000
.loop:
	mov di, bx

	mov [ds:di], al

	inc bx

	dec cx
	je .pegarTecla

	jmp .loop

times 510 - ($-$$) db 0
dw 0xaa55