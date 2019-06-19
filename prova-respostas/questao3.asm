	org 0x7c00
	bits 16

	cli
	
	;Inicializa a quantidade de letras
	mov cx, 0
	
EscreverAoContrario:
	
	;Interrupção para a letura do teclado
	mov ax, 0
	int 0x16
	
	;Interrupção para printar na tela o que foi lido
	mov ah, 0x0E
	int 0x10
	
	cmp al, 8
	je .apagar	;Se a tecla apertada foi backspace
	
	;Guarda o valor lido na pilha
	push ax
	inc cx
	
	cmp al, 13
	je .inverte	;Se a tecla apertada foi enter
	jmp EscreverAoContrario


.apagar:
	;Descarto a última letra
	pop ax
	
	;Escrevo um espaço em branco no lugar e volto
	mov al, ' '
	int 0x10
	mov al, 8
	int 0x10
	
	;Decremento uma letra
	dec cx
	jmp EscreverAoContrario



.inverte:
	;Primeiro faz a quebra de linha
	mov al, 10
	;Printa a quebra de linha (ah já está com o valor 0x0E)
	int 0x10
	
.loop:
	;Vai resgatando as letras guardadas
	pop ax
	
	;Printa a letra guardada (ah já está com 0x0E)
	int 0x10
	
	dec cx
	jz .fim	;Se chegou ao fim das letras
	
	jmp .loop
	
.fim:
	hlt

	times 510 - ($-$$) db 0
	dw 0xaa55
