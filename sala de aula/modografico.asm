org 0x7c00
bits 16
xor ax, ax
mov ds, ax
cli
;modo de video:
	mov ah, 0 
	mov al, 0x13
	int 0x10
; salvar o endereço no es:	
	mov ax, 0xA000
	mov es, ax
;contadores:
	mov cx, 64000
	mov bx, 0
loop:
	mov di, bx ; salva o byte atual no di
	mov [es:di], byte 40 ; salva o byte 40 nos endereços
	inc bx

	dec cx
	jnz loop

	hlt

times 510 - ($-$$) db 0
dw 0xaa55
