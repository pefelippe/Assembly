; programa para decodificar. basicamente, vai remover os digitos adicionados e printar.

org 0x7C00
bits 16

xor ax, ax
mov ds, ax

cli

int 0x13
	mov ah, 2h 	; modo de leitura
	mov al, 1	; qnt de setores
	mov bx, 0x7e00	; endereço
	mov cl, 2	; setor 2
	mov ch, 0	; cilindro
	mov dh, 0	; cabess	
int 0x13


	mov ah, 0x0e

inicio:
	mov si, mat

.decodificar:
	mov al, [si] ; matricula
	cmp al, 10
	je inicio

	mov dl, [bx] ; caracteres da mensagem
	or dl, dl
	jz fim
	
	sub dl, al ; retira o digito adicionado
	mov al, dl

	int 0x10

	inc si
	inc bx

	jmp .decodificar
	
fim: 
	hlt


mat: db 4, 1, 8, 8 , 0 , 6, 10

times 510 - ($-$$) db 0
dw 0xaa55
