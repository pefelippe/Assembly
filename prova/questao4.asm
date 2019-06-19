org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli

	mov al, 0x13
	int 0x10

	mov ax, 0xA000 ; VRAM
	mov es, ax


	mov dl, 0	; cor inicial
	cmp dl, 255 ; funciona sera
	mov dl, 0

pintar:
	mov di, 0
	mov cx, 64000

	inc dl
loop:

	mov [es:di], byte dl

	inc di
	inc dl

	dec cx
	or cx, cx
	jz fim

	jmp loop
fim:
	
	jmp pintar


times 510 - ($-$$)  db 0
dw 0xaa55	
