org 0x7c00 	; endereço da bios
bits 16	 	; eax = 32bits, ax = 16 bit, al, ah = 8 bits

xor ax, ax
mov ds, ax

cli
	; modo de video
	mov al, 13h
	mov ah, 0
	int 0x10

	; interrupção de disco
	int 0x13	; inicia
	mov ah,	02h	; ler setores
	mov al,	32 	; qnt setores
	mov bx, 0x7E00  ; endereço
	mov cl, 2	; qual setor ler
	mov dh, 0	; cabess
	mov ch, 0	; cilindro
	int 0x13	; carrega
	
; copiar para o endereço de video
	mov di, 0
	mov si, 0x7E00 ; primeiro endereço apos a BIOS

	mov ax, 0xA000 ; endereço da placa de video
	mov es, ax

loop:
	; queremos mover os bytes do si para es -> mov [es:di] , [ds:si]
	; nao podemos fazer isso, usaremos al como um auxiliar

	mov al, [ds:si] ; valor do pixel que está em si (0x7e00)
	mov [es:di], al	; jogando em [es:di] o valor que estava no 0x7e00

	cmp di, 16000	; ja foram jogados 16k de bytes?????? ja???? entao saia do loop
	jz fim
	
	inc di	; incrementamos di ("proximo endereço")
	inc si	; incrementamos si (0x7e00++)

	jmp loop ; continue incrementado
fim:
	hlt

times 510 - ($-$$) db 0
dw 0xaa55

