org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli

primo:

	mov bx, 0

	.ler:
		mov ax, 0
		int 0x16 ; ler do teclado
		
		cmp al, 13
		jz. verifica

		mov ah, 0x0e ; modo texto
		int 0x10

		; transformar em decimal (decorar ae):
		sub al, 48
		imul bx, 10
		mov ah, 0
		add bx, ax

	
.ePrimo:
	mov ah, 0x0E
	mov bx, msg1	;pego o texto de ser primo
	jmp .loop
.nPrimo:
	mov ah, 0x0E
	mov bx, msg2	;Pego o texto de não ser primo
	jmp .loop
	

	jmp primo

msg1: db " eh primo!", 13, 10
msg2: db " nao eh primo!", 13, 10


times 510 - ($-$$) db 0
dw 0xaa55
