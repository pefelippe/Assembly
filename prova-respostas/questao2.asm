;Escreva um programa que decodifique uma mensagem criptografada em um arquivo texto

org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli

inicio:
	
	int 0x13

	mov ah, 0x02
	mov al, 1	; possui somente um setor
	mov bx, 0x7e00	; proximo endereço
	mov cl, 2	; 1?
	mov ch, 0	; cilindro
	mov dh, 0  	; cabeça

	int 0x13

	mov si, matricula

.descripitar:
	mov al, [bx]		;Pego a letra criptografada atual
	or al, al	
	jz .fim			;Se a frase acabou
	
	mov dl, [si]		;Pego o número da matrícula atual
	cmp dl, 10	
	je .retorno		;Se a matrícula acabou
	
.calcula:
	sub al, dl		;Decripto diminuindo pelo valor do número atual da matrícula
	mov ah, 0x0E
	int 0x10		;Escrevo a letra descriptografada
	inc si			;Vou para próximo número da matrícula
	inc bx			;Vou para a próxima letra da frase
	jmp .descripitar
	
.retorno:
	mov si, matricula	;Reinicio a posição do número atual da matrícula
	mov dl, [si]		;Pego o verdadeiro número atual da matrícula
	jmp .calcula		;Volto pra decriptar

.fim:
	hlt

matricula: db 4, 1, 8, 8, 0 , 6, 10

times 510 - ($-$$) db 0
dw 0xaa55
