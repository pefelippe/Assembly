
org 0x7c00
bits 16

xor ax, ax
mov ds, ax
cli

	mov ax, msg
	call print

	mov ax, 0x7e00
	call get

	mov ax, msg
	call print

	mov ax, 0x7e01
	call get

	mov ax, resp
	call print

	mov al, [0x7e00] ; salva o valor do endereço  
	mov cl, [0x7e01] ; soma o valor do endereço 2

	add al, cl
	mov [0x7e10], al

	mov ax, 0x7e10
	call print

	hlt


print:
	push ax
	push si
	mov si, ax
	mov ah, 0x0e

	.loop:
		lodsb
		or al, al
		jz .retorno
		int 0x10
		jmp .loop

	.retorno:
		pop ax
		pop si
		ret
get:
	push ax
	push di
	mov di, ax

	.loop:
		mov ah, 0
		int 0x16

		cmp al, 13
		jz .retorno

		mov [ds:di], al
		inc di

		mov ah, 0x0e
		int 0x10

		jmp .loop

	.retorno:
		mov ah, 0x0e
		int 0x10
		mov al, 10
		int 0x10
		mov [es:di], byte 0
		pop ax
		pop di
		ret

msg: db "Digite um numero: ", 0
resp: db "Soma: ", 0

times 510 - ($-$$) db 0
dw 0xaa55