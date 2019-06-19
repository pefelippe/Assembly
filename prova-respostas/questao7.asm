org 0x7C00
	bits 16

	cli	;Limpa os registradores da bios
EPrimoOuNao:
	
	mov bx, 0	;Inicio o número que será lido
	
.leitura:
	;Ler teclado
	mov ax, 0
	int 0x16
	
	cmp al, 13
	je .verifica	;Se a tecla for enter
	
	;Mostro a tecla apertada
	mov ah, 0x0E
	int 0x10
	
	cmp al, 8
	je .backspace	;Se a tecla for backspace
	
	;Transformo pra número e acrescento no já lido
	sub al, 48
	imul bx, 10
	mov ah, 0
	add bx, ax
	
	jmp .leitura
	
	
.backspace:	
	mov al, ' '
	int 0x10	;Limpo a posição anterior
	mov al, 8
	int 0x10	;Volto para a posição anterior
	
	
	mov ax, bx
	mov bx, 10
	mov dx, 0
	;Divido por 10 para retirar o último número adicionado
	idiv bx
	mov bx, ax
	jmp .leitura
	


.verifica:
	;Verificação se o número digitado é ou não primo
	mov ax, bx
	push ax
	
	;O número 1 não é primo
	cmp ax, 1
	je .nPrimo
	
.divide:
	;Testo se o número digitado é divisível por algum anterior
	mov dx, 0
	dec bx
	cmp bx, 1
	je .ePrimo	;Se testarmos todos e não for divisível por nenhum, então é primo
	
	idiv bx
	or dx, dx
	jz .nPrimo	;Se for divisível para algum, ele não é primo
	
	pop ax
	push ax
	jmp .divide
	
.nPrimo:
	mov ah, 0x0E
	mov bx, nP	;Pego o texto de não ser primo
	jmp .loop
	
.ePrimo:
	mov ah, 0x0E
	mov bx, eP	;pego o texto de ser primo
	jmp .loop
	
	
.loop:	
	;Escrevo cada letra da frase
	mov al, [bx]
	int 0x10
	
	cmp al, 13	;Paro na exclamação '!'
	je .fim
	
	inc bx
	jmp .loop

.fim:
	jmp EPrimoOuNao	
	
nP:	db " N", 134, "o ", 130, " primo!", 10, 13	;Frase de não ser primo
eP:	db ' ',  144, " primo!", 10, 13		;Frase de ser primo
	
	times 510 - ($-$$) db 0

	dw 0xAA55
