org 0x7c00
jmp 0x0000:start


	start:
	xor ax, ax
	mov ds, ax

	jmp begin
	qnterrors: dw 0
	diskloads: db 'Preparing contents', 0xa, 0xd, 0
	diskerror: db 'Error:Unable to read disk', 0xa, 0xd, 0

	print_asm:
	mov al, [si]
	cmp al, 0
	je return
	inc si
   	mov ah, 0xe
   	int 0x10
	jmp print_asm
	return:
	ret

	begin:
	mov si, diskloads
	call print_asm
	loadstage:
	mov bx, 0x500	;address
	mov ah, 2	;intruction
	mov al, 1	;number of sectors to read
	mov ch, 0	;cylinder
	mov cl, 2	;starting sector
	mov dh, 0	;head number
	int 0x13	;interruption
	jc error	;error
	jmp 0x500
	error:
	cmp word [qnterrors], 3
	je terminate
	mov si, diskerror
	call print_asm
	inc word [qnterrors]
	jmp loadstage

	terminate:
	times 510-($-$$) db 0
	dw 0xAA55
