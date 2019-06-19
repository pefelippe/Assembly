; Escreva um programa que exiba uma imagem disponibilizada com seus pixels brutos.

org 0x7c00
bits 16

xor ax, ax
mov ds, ax

inicio:
	cli

	mov al, 13h
	mov ah, 0
	int 0x10

	int 0x13
	mov ah, 02h		; modo de leitura
	mov al, 32		; qnt setores	
	mov bx, 0x7e00		; endereço onde gravar
	mov cl, 2		; le a partir do setor 2
	mov ch, 0		; cilindro
	mov dh, 0		; cabeça
	int 0x13

	mov ax, 0xa00	; endereço da memoria de video
	mov es, ax

	mov di , 0	; contador de bytes
	mov si, 0x7e00	; endereço q esta salvo o arquivo
	
; imagem:
	mov ch, 50 
	mov ax, 320

copiar:
	mov al, [ds:si]	 	; vai salvar cada byte q leu no disco
	mov [es:di], al		; na memoria de video

	cmp di, 16000
	je fim
	
	inc di
	inc si
	jmp copiar

fim:
	hlt



times 510 - ($-$$) db 0
dw 0xaa55


