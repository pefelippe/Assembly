; imprimir seu dobro

org 0x7c00
bits 16

xor ax, ax
mov ds, ax

cli

	mov ax, 0x7e00
	call geti
	mov ax, [0x7e00]

	mov [0x7e10], ax
	
	mov ax, 0x7e01
	call geti
	mov ax, [0x7e01]	

	add [0x7e10], ax

	mov ax, 0x7e10
	call printi


; pega o inteiro:
geti:   
	push ax
	mov di, ax
	mov ax, 0
	push ax
loop1:	
	mov ah, 0x00  
	int 0x16
	mov ah, 0x0e
	int 0x10      ; exibe digito digitado
	cmp al, 13
	je  term1
	sub al, 48    ;transforma caractere no valor
	mov dl, al
	pop ax
	imul ax, 10
	add ax, dx
	push ax
	jmp loop1
term1:  
	mov al, 10    ;faz a quebra de linha 
	int 0x10
        pop ax
	mov [ds:di], ax
	pop ax
	ret

; printar o inteiro
printi:
	push ax
	mov si, ax
	mov ax, [ds:si]
	mov bx, 10
	mov cx, 0
loop2:	
	mov dx, 0     ;loop para extrair cada dÃ­gito, colocando na pilha
	idiv bx
	add dx, 48    ;calcula o caractere
	push dx
	inc cx
	or ax, ax
	jnz loop2
loop3:	
	pop ax        ;loop para desempilhar dÃ­gitos, escrevendo-os na ordem correta
	mov ah, 0x0e
	int 0x10
	dec cx
	or cx, cx
	jnz loop3
	pop ax
	ret

fim:
	hlt

times 510 - ($-$$) db 0
dw 0xaa55	
