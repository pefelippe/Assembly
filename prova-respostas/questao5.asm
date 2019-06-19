	org 0x7c00
	bits 16

MudarCor:
	;Limpa os registradores
	cli
	
	;Incializa a interrupção de vídeo
	mov ax, 0
	mov al, 0x13
	int 0x10

	;Guarda a posição da VRAM
	mov ax, 0xA000
	mov es, ax

.lerTeclado:
	;Lê o teclado
	mov ax, 0
	int 0x16
	
	;|
	;|
	;v

.mudarCor:	
	;Inicializa pra poder percorrer a tela
	mov bx, 0
	mov cx, 64000

.loop:
	mov di, bx
	mov [es:di], al	;memVideo[di] = al  ==  (memVideo + di) = al
	inc bx
	dec cx
	jz .lerTeclado	;Se pintou toda a tela
	jmp .loop

	
	times 510 - ($-$$) db 0
	dw 0xaa55
