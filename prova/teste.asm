org 0x7c00
bits 16

mov ax, 0x00
mov ds, ax

cli

mov si, msg
call print

mov si, ola
call print

hlt

print:
	push si
	mov ah, 0x0e	
.loop:
	lodsb
	or al, al
	jz .retorno
	int 0x10

	jmp .loop


.retorno:
	pop si
	ret



msg:
	db "Hello World", 13, 10, 0
ola:
	db "Ol",160,"Mundo", 13, 10, 0



times 510 - ($ - $$) db 0
dw 0xaa55
