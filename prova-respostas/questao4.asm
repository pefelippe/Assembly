org 0x7c00
	bits 16

cores:
	cli ;Limpa os registradores

	;Inicializa a interrupção de gráfico
	mov ax, 0
	mov al, 0x13
	int 0x10
	
	;Posição da VRAM
	mov ax, 0xA000
	mov es, ax
	
	;Guarda a cor inicial
	mov dl, 0
	push dx

;Inicialização de loop
.loop:
	mov ax, 0
	mov cx, 64000

;Pintar a tela
.percorrer:
	mov di, ax
	mov [es:di], dl ;memVideo[di] = dl  ==  *(memVideo + di) = dl
	inc ax
	dec cx
	jz .proxloop	;Se percorer toda tela 

	inc dl
	jmp .percorrer

;Inicializa o proximo loop
.proxloop:
	pop dx
	inc dl
	push dx
	jmp .loop


	times 510 - ($-$$) db 0
	dw 0xaa55
