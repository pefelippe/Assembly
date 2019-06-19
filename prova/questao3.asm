org 0x7c00
bits 16

cli

mov ax, 0
mov ds, ax

inicio:
	mov ax, 0x7e00 ; endereço para salvar a string (primeiro endereço livre pos-512 da bios)
	call gets

	call reverte

	jmp inicio

	hlt 

reverte:
	push ax
	push di
	push cx

	mov cx, 0 	; contador do mal de caracteres
	mov di, ax	; passa o endereço da string para di
	mov ah, 0x0e	; para printar

.strlen:
	mov al, [ds:di] ; valor q ta no endereço da string para al
	or al, al	; acabou?	
	jz .print	; entao printe

	inc di		; endereço++
	inc cx		; caracteres++

	jmp .strlen

.print:
	dec di		; endereço--

	mov al, [ds:di] ; mova para al o endereço q esta em di
	int 0x10

	dec cx		; para cada letra pritada, caracteres--

	or cx, cx
	jz .retorno1

	jmp .print

.retorno1:
	pop cx
	pop di
	pop ax

	ret

gets:
	push ax
	push di
	mov di, ax

.loop:
	mov ah, 0x0
	int 0x16
	cmp al, 13
	je .retorno
	mov [ds:di], al
	inc di
	mov ah, 0x0e
	int 0x10
	jmp .loop

.retorno:
	mov ah, 0x0e
	mov al, 10
	int 0x10
	mov al, 13
	int 0x10
	pop di
	pop ax
	ret

times 510 - ($ - $$) db 0
dw 0xaa55

