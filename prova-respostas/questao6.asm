
	org 0x7c00
	bits 16
	
	cli
	
fibonacci:
	;Carrego a quantidade de números, e os primeiros valores da soma de gibonacci
	mov cx, 21
	mov ax, 0
	mov bx, 1
	
	
.proximo:
	or cx, cx
	jz .fim	;Se cheguei ao final
	
	dec cx

.dividir:
	;Guardo a quantidade e os valores atuais de fibonacci
	push cx
	push ax
	push bx
	
	;Inicio a divisão
	mov bx, 10
	mov cx, 0
	
.loop:	
	mov dx, 0
	
	;Divido o ax por 10 e pego o resto no dx
	idiv bx
	
	;Guardo o número já com o 0x0E no dh
	mov dh, 0x0E
	add dl, 48
	push dx
	inc cx
	
	or ax, ax
	jz .printar	;Se eu cheguei no fim da divisão
	
	jmp .loop



.printar:
	or cx, cx
	jz .reiniciar	;Se eu já printei todos os números
	
	dec cx
	
	;Pego o número guardado pra printar (Já está com 0x0E na pilha)
	pop ax
	int 0x10
	jmp .printar



.reiniciar:
	;Printo um espaço pra separar os números
	mov al, ' '
	int 0x10
	
	;Resgato os valores do cálculo
	pop bx
	pop ax
	pop cx
	
	;Faço o cálculo de Fibonacci
	mov dx, ax
	add ax, bx
	mov bx, dx
	
	jmp .proximo
	
	
	
.fim:
	hlt
	
	times 510 - ($-$$) db 0
	dw 0xaa55
