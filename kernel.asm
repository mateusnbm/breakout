	org 0x7E00
	xor ax, ax
	mov ds, ax

	jmp begin

	color_aux: db 1
	game_active: dw 0
	game_lifes: dw 3
	game_score: dw 0
	plat_posx: dw 130
	plat_posy: dw 190
	ball_posx: dw 153
	ball_posy: dw 180
	ball_orienx: dw 0
	ball_orieny: dw 1
	display_bcd: times 35 dw 0
	welcome_message: db "breakout"
	gover_message: db "game over"
	lclear_message: db "congrats"
	display_text: times 350 dw 1
	blocks_count: dw 50
	blocks_active: dw 50
	blocks: dw 1,10,36,10, 1,40,36,10, 1,70,36,10, 1,100,36,10, 1,130,36,10, 1,160,36,10, 1,190,36,10, 1,220,36,10, 1,250,36,10, 1,280,36,10, 1,10,44,11, 1,40,44,11, 1,70,44,11, 1,100,44,11, 1,130,44,11, 1,160,44,11, 1,190,44,11, 1,220,44,11, 1,250,44,11, 1,280,44,11, 1,10,52,12, 1,40,52,12, 1,70,52,12, 1,100,52,12, 1,130,52,12, 1,160,52,12, 1,190,52,12, 1,220,52,12, 1,250,52,12, 1,280,52,12, 1,10,60,13, 1,40,60,13, 1,70,60,13, 1,100,60,13, 1,130,60,13, 1,160,60,13, 1,190,60,13, 1,220,60,13, 1,250,60,13, 1,280,60,13, 1,10,68,14, 1,40,68,14, 1,70,68,14, 1,100,68,14, 1,130,68,14, 1,160,68,14, 1,190,68,14, 1,220,68,14, 1,250,68,14, 1,280,68,14

	govideo:
		mov ah, 0
		mov al, 13h
		int 10h
		ret

	paste_buffer:
		push ds
		xor di, di
		xor si, si
		mov ax, 0xa000
		mov es, ax
		mov ax, screen_buffer
		shr ax, 4
		mov ds, ax
		mov cx, 16000
		cld
		rep movsd
		pop ds
		ret

	clear_buffer:
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		xor di, di
		xor eax, eax
		mov cx, 16000
		rep stosd
		ret

	clear_bcd:
		mov ax, 35
		mov si, display_bcd
		cb_loop:
		or ax, ax
		jz cb_end
		mov word [si], 0
		add si, 2
		dec ax
		jmp cb_loop
		cb_end:
		ret

	;di = string address
	;ax = number of chars
	;si = write address
	populate_text:
		fill_text:
		or ax, ax
		jz ft_end
		dec ax
		ft_char_a:
		cmp byte [di], "a"
		jne ft_char_b
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_b:
		cmp byte [di], "b"
		jne ft_char_c
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_c:
		cmp byte [di], "c"
		jne ft_char_d
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_d:
		cmp byte [di], "d"
		jne ft_char_e
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_e:
		cmp byte [di], "e"
		jne ft_char_f
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 1
		jmp ft_next
		ft_char_f:
		cmp byte [di], "f"
		jne ft_char_g
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 0
		jmp ft_next
		ft_char_g:
		cmp byte [di], "g"
		jne ft_char_h
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_h:
		cmp byte [di], "h"
		jne ft_char_i
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_i:
		cmp byte [di], "i"
		jne ft_char_j
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 0
		mov word [si+12], 0
		mov word [si+14], 1
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 0
		mov word [si+22], 0
		mov word [si+24], 1
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 0
		mov word [si+52], 0
		mov word [si+54], 1
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 1
		jmp ft_next
		ft_char_j:
		cmp byte [di], "j"
		jne ft_char_k
		mov word [si], 0
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 0
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 0
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_k:
		cmp byte [di], "k"
		jne ft_char_l
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 1
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 1
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 1
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_l:
		cmp byte [di], "l"
		jne ft_char_m
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 1
		jmp ft_next
		ft_char_m:
		cmp byte [di], "m"
		jne ft_char_n
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 1
		mov word [si+14], 0
		mov word [si+16], 1
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 1
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_n:
		cmp byte [di], "n"
		jne ft_char_o
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 1
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 1
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_o:
		cmp byte [di], "o"
		jne ft_char_p
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_p:
		cmp byte [di], "p"
		jne ft_char_q
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 0
		jmp ft_next
		ft_char_q:
		cmp byte [di], "q"
		jne ft_char_r
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 1
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 1
		jmp ft_next
		ft_char_r:
		cmp byte [di], "r"
		jne ft_char_s
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 0
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 1
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_s:
		cmp byte [di], "s"
		jne ft_char_t
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 1
		mov word [si+32], 1
		mov word [si+34], 1
		mov word [si+36], 1
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 0
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_t:
		cmp byte [di], "t"
		jne ft_char_u
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 0
		mov word [si+12], 0
		mov word [si+14], 1
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 0
		mov word [si+22], 0
		mov word [si+24], 1
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 0
		mov word [si+52], 0
		mov word [si+54], 1
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 0
		mov word [si+62], 0
		mov word [si+64], 1
		mov word [si+66], 0
		mov word [si+68], 0
		jmp ft_next
		ft_char_u:
		cmp byte [di], "u"
		jne ft_char_v
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 0
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 0
		jmp ft_next
		ft_char_v:
		cmp byte [di], "v"
		jne ft_char_x
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 1
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 1
		mov word [si+30], 1
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 1
		mov word [si+40], 1
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 1
		mov word [si+50], 0
		mov word [si+52], 1
		mov word [si+54], 0
		mov word [si+56], 1
		mov word [si+58], 0
		mov word [si+60], 0
		mov word [si+62], 0
		mov word [si+64], 1
		mov word [si+66], 0
		mov word [si+68], 0
		jmp ft_next
		ft_char_x:
		cmp byte [di], "x"
		jne ft_char_y
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 0
		mov word [si+22], 1
		mov word [si+24], 0
		mov word [si+26], 1
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 1
		mov word [si+44], 0
		mov word [si+46], 1
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 1
		mov word [si+60], 1
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 1
		jmp ft_next
		ft_char_y:
		cmp byte [di], "y"
		jne ft_char_z
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 0
		mov word [si+22], 1
		mov word [si+24], 0
		mov word [si+26], 1
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 0
		mov word [si+44], 1
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 0
		mov word [si+52], 0
		mov word [si+54], 1
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 0
		mov word [si+62], 0
		mov word [si+64], 1
		mov word [si+66], 0
		mov word [si+68], 0
		jmp ft_next
		ft_char_z:
		cmp byte [di], "z"
		jne ft_char_space
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 0
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 1
		mov word [si+20], 0
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 1
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 1
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 1
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 1
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 1
		mov word [si+62], 1
		mov word [si+64], 1
		mov word [si+66], 1
		mov word [si+68], 1
		jmp ft_next
		;
		;
		ft_char_space:
		cmp byte [di], 32
		jne ft_next
		mov word [si], 0
		mov word [si+2], 0
		mov word [si+4], 0
		mov word [si+6], 0
		mov word [si+8], 0
		mov word [si+10], 0
		mov word [si+12], 0
		mov word [si+14], 0
		mov word [si+16], 0
		mov word [si+18], 0
		mov word [si+20], 0
		mov word [si+22], 0
		mov word [si+24], 0
		mov word [si+26], 0
		mov word [si+28], 0
		mov word [si+30], 0
		mov word [si+32], 0
		mov word [si+34], 0
		mov word [si+36], 0
		mov word [si+38], 0
		mov word [si+40], 0
		mov word [si+42], 0
		mov word [si+44], 0
		mov word [si+46], 0
		mov word [si+48], 0
		mov word [si+50], 0
		mov word [si+52], 0
		mov word [si+54], 0
		mov word [si+56], 0
		mov word [si+58], 0
		mov word [si+60], 0
		mov word [si+62], 0
		mov word [si+64], 0
		mov word [si+66], 0
		mov word [si+68], 0
		ft_next:
		inc di
		add si, 70
		jmp fill_text
		ft_end:
		ret

	;si = bcd address
	;ax = number
	;cx = 0
	populate_bcd:
		cmp ax, 0
		jne pb_counter
		inc cx
		xor dx, dx
		push dx
		jmp fill_bcd
		pb_counter:
		cmp ax, 0
		je fill_bcd
		xor dx, dx
		mov bx, 10
		div bx
		push dx
		inc cx
		jmp pb_counter
		fill_bcd:
		cmp cx, 0
		je fill_end
		dec cx
		pop dx
		fb_num_0:
		cmp dx, 0
		jne fb_num_1
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 0
		jmp fb_next
		fb_num_1:
		cmp dx, 1
		jne fb_num_2
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 0
		mov word [si+8], 0
		mov word [si+10], 0
		mov word [si+12], 0
		jmp fb_next
		fb_num_2:
		cmp dx, 2
		jne fb_num_3
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 0
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 0
		mov word [si+12], 1
		jmp fb_next
		fb_num_3:
		cmp dx, 3
		jne fb_num_4
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 0
		mov word [si+12], 1
		jmp fb_next
		fb_num_4:
		cmp dx, 4
		jne fb_num_5
		mov word [si], 0
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 0
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 1
		jmp fb_next
		fb_num_5:
		cmp dx, 5
		jne fb_num_6
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 1
		jmp fb_next
		fb_num_6:
		cmp dx, 6
		jne fb_num_7
		mov word [si], 1
		mov word [si+2], 0
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 1
		jmp fb_next
		fb_num_7:
		cmp dx, 7
		jne fb_num_8
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 0
		mov word [si+8], 0
		mov word [si+10], 0
		mov word [si+12], 0
		jmp fb_next
		fb_num_8:
		cmp dx, 8
		jne fb_num_9
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 1
		mov word [si+10], 1
		mov word [si+12], 1
		jmp fb_next
		fb_num_9:
		mov word [si], 1
		mov word [si+2], 1
		mov word [si+4], 1
		mov word [si+6], 1
		mov word [si+8], 0
		mov word [si+10], 1
		mov word [si+12], 1
		fb_next:
		add si, 14
		jmp fill_bcd
		fill_end:
		ret

	;es = address to write
	;di = offset
	;ax = posx
	;bx = posy
	;cx = width
	;dx = height
	;si = color
	draw_rectangle:
		;push bx
		;add bx, dx
		;cmp bx, 320
		;pop bx
		;ja drec_end
		push ax
		mov ax, bx
		shl ax, 6
		shl bx, 8
		add bx, ax
		pop ax
		add ax, bx
		mov di, ax
		mov ax, si
		drec_y:
		cmp dx, 0
		je drec_end
		dec dx
		push cx
		cld
		rep stosb
		pop cx
		sub di, cx
		add di, 320
		jmp drec_y
		drec_end:
		ret

	;si = address
	;ax = posx
	;bx = posy
	;dx = qnt letters
	;di = color
	draw_text:
		dc_singles:
		or dx, dx
		jz dc_end
		dec dx
		push bx
		mov cx, 6
		push cx
		mov cx, 5
		dc_lines:
		or cx, cx
		jz dc_back_line
		dec cx
		cmp word [si], 0
		je dc_next_square
		pusha
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 2
		mov dx, 2
		mov si, di
		call draw_rectangle
		popa
		dc_next_square:
		add si, 2
		add ax, 3
		jmp dc_lines
		dc_back_line:
		pop cx
		or cx, cx
		jz dc_new_single
		dec cx
		push cx
		mov cx, 5
		sub ax, 15
		add bx, 3
		jmp dc_lines
		dc_new_single:
		pop bx
		add ax, 2
		jmp dc_singles
		dc_end:
		ret

	;si = address
	;ax = posx
	;bx = posy
	;dx = qnt numbers
	draw_bcd:
		db_singles:
		or dx, dx
		jz db_end
		dec dx
		db_seg_1:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_2
		pusha
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 5
		mov dx, 2
		mov si, 15
		call draw_rectangle
		popa
		db_seg_2:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_3
		pusha
		add ax, 3
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 2
		mov dx, 5
		mov si, 15
		call draw_rectangle
		popa
		db_seg_3:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_4
		pusha
		add ax, 3
		add bx, 5
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 2
		mov dx, 5
		mov si, 15
		call draw_rectangle
		popa
		db_seg_4:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_5
		pusha
		add bx, 8
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 5
		mov dx, 2
		mov si, 15
		call draw_rectangle
		popa
		db_seg_5:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_6
		pusha
		add bx, 5
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 2
		mov dx, 5
		mov si, 15
		call draw_rectangle
		popa
		db_seg_6:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_seg_7
		pusha
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 2
		mov dx, 5
		mov si, 15
		call draw_rectangle
		popa
		db_seg_7:
		mov cx, [si]
		add si, 2
		or cx, cx
		jz db_next
		pusha
		add bx, 4
		mov cx, screen_buffer
		shr cx, 4
		mov es, cx
		mov cx, 5
		mov dx, 2
		mov si, 15
		call draw_rectangle
		popa
		db_next:
		add ax, 7
		jmp db_singles
		db_end:
		ret

	;ax = qnt blocks
	;si = address
	blocks_reset:
		cmp ax, 0
		je br_end
		dec ax
		mov word [si], 1
		add si, 8
		jmp blocks_reset
		br_end:
		ret

	;ax = qnt blocks
	;di = address
	draw_tiles:
		dt_loop:
		cmp ax, 0
		je dt_end
		dec ax
		cmp word [di], 0
		je dt_next
		push ax
		push di
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, [di+2]
		mov bx, [di+4]
		mov cx, 30
		mov dx, 8
		mov si, [di+6]
		call draw_rectangle
		pop di
		pop ax
		dt_next:
		add di, 8
		jmp dt_loop
		dt_end:
		ret

	;ax = qnt blocks
	;si = blocks address
	blocks_hit:
		cmp ax, 0
		je bh_end
		dec ax
		cmp word [si], 0
		je bh_next
		push ax
		push si
		bh_bottom:
		mov ax, [si+4]
		add ax, 8
		cmp ax, [ball_posy]
		jne bh_top
		mov ax, [ball_posx]
		add ax, 6
		cmp ax, [si+2]
		jnae bh_top
		sub ax, 6
		mov bx, [si+2]
		add bx, 30
		cmp ax, bx
		jnbe bh_top
		mov word [si], 0
		mov word [ball_orieny], 0
		add word [game_score], 10
		jmp bh_hitten
		bh_top:
		mov ax, [ball_posy]
		add ax, 6
		cmp [si+4], ax
		jne bh_left
		mov ax, [ball_posx]
		add ax, 6
		cmp ax, [si+2]
		jnae bh_left
		sub ax, 6
		mov bx, [si+2]
		add bx, 30
		cmp ax, bx
		jnbe bh_left
		mov word [si], 0
		mov word [ball_orieny], 1
		add word [game_score], 10
		jmp bh_hitten
		bh_left:
		mov ax, [ball_posx]
		add ax, 6
		cmp ax, [si+2]
		jne bh_right
		mov ax, [si+4]
		mov bx, [ball_posy]
		add bx, 6
		cmp bx, ax
		jnae bh_right
		mov ax, [ball_posy]
		mov bx, [si+4]
		add bx, 8
		cmp ax, bx
		jnbe bh_right
		mov word [si], 0
		mov word [ball_orienx], 1
		add word [game_score], 10
		jmp bh_hitten
		bh_right:
		mov ax, [ball_posx]
		mov bx, [si+2]
		add bx, 30
		cmp ax, bx
		jne bh_pops
		mov ax, [si+4]
		mov bx, [ball_posy]
		add bx, 6
		cmp bx, ax
		jnae bh_pops
		mov ax, [ball_posy]
		mov bx, [si+4]
		add bx, 8
		cmp ax, bx
		jnbe bh_pops
		mov word [si], 0
		mov word [ball_orienx], 0
		add word [game_score], 10
		jmp bh_hitten
		bh_pops:
		pop si
		pop ax
		bh_next:
		add si, 8
		jmp blocks_hit
		bh_hitten:
		pop si
		pop ax
		dec word [blocks_active]
		bh_end:
		ret

	welcome:
		mov ah, 1
		int 16h
		jz wl_draw
		mov ah, 0
		int 16h
		cmp al, 13
		je wl_start
		wl_draw:
		mov di, welcome_message
		mov ax, 8
		mov si, display_text
		call populate_text
		inc byte [color_aux]
		mov si, display_text
		mov ax, 95
		mov bx, 90
		xor cx, cx
		mov dx, 8
		mov di, [color_aux]
		call draw_text
		call paste_buffer
		call clear_buffer
		jmp welcome
		wl_start:
		mov word [game_score], 0
		mov word [game_lifes], 3
		mov word [plat_posx], 130
		mov word [plat_posy], 190
		mov word [ball_posx], 153
		mov word [ball_posy], 180
		mov ax, [blocks_count]
		mov word [blocks_active], ax
		mov si, blocks
		call blocks_reset
		jmp gameloop

	gameover:
		mov ah, 1
		int 16h
		jz go_draw
		mov ah, 0
		int 16h
		cmp al, 13
		je wl_start
		go_draw:
		mov di, gover_message
		mov ax, 9
		mov si, display_text
		call populate_text
		mov si, display_text
		mov ax, 95
		mov bx, 90
		xor cx, cx
		mov dx, 9
		mov di, 4
		call draw_text
		call paste_buffer
		call clear_buffer
		jmp gameover

	nextlevel:
		mov ah, 1
		int 16h
		jz nl_draw
		mov ah, 0
		int 16h
		cmp al, 13
		je nl_prepare
		nl_draw:
		mov di, lclear_message
		mov ax, 8
		mov si, display_text
		call populate_text
		;
		mov si, display_text
		mov ax, 95
		mov bx, 90
		xor cx, cx
		mov dx, 8
		mov di, 1
		call draw_text
		call paste_buffer
		call clear_buffer
		jmp nextlevel
		nl_prepare:
		;
		jmp gameloop

	begin:
		call govideo
		call welcome

	gameloop:

		keyboard:
			mov ah, 1
			int 16h
			jz move_ball
			mov ah, 0
			int 16h
			plat_left:
			cmp al, 'a'
			jne plat_right
			mov ax, 10
			cmp [plat_posx], ax
			jl game_init
			sub word [plat_posx], 8
			jmp move_ball
			plat_right:
			cmp al, 'd'
			jne game_init
			mov ax, [plat_posx]
			add ax, 50
			cmp ax, 310
			ja game_init
			add word [plat_posx], 8
			jmp move_ball
			game_init:
			cmp al, 'w'
			jne move_ball
			inc word [game_active]
			jmp move_ball

		move_ball:
		cmp word [game_active], 0
		jna gl_draw
			hit_plat_top:
			mov ax, [ball_posy]
			add ax, 6
			cmp ax, [plat_posy]
			jne hit_plat_left
			mov ax, [ball_posx]
			add ax, 6
			cmp ax, [plat_posx]
			jl hit_plat_left
			inc word [game_score]
			mov ax, [plat_posx]
			add ax, 50
			cmp word [ball_posx], ax
			ja hit_plat_left
			mov word [ball_orieny], 1
			jmp hit_block
			hit_plat_left:
			mov ax, [ball_posy]
			mov bx, ax
			mov cx, [plat_posy]
			add bx, 6
			cmp bx, cx
			jl hit_block
			add cx, 5
			cmp ax, cx
			ja hit_block
			mov ax, [ball_posx]
			add ax, 6
			cmp ax, [plat_posx]
			jne hit_plat_right
			mov word [ball_orienx], 1
			jmp hit_block
			hit_plat_right:
			mov ax, [ball_posx]
			mov bx, [plat_posx]
			add bx, 50
			cmp ax, bx
			jne hit_block
			mov word [ball_orienx], 0
			jmp hit_block
			hit_block:
			mov ax, [blocks_count]
			mov si, blocks
			call blocks_hit
			cmp word [blocks_active], 0
			jne hit_bounds_left
				mov word [game_active], 0
				add word [game_score], 50
				mov word [ball_posx], 153
				mov word [ball_orienx], 0
				mov word [ball_orieny], 1
				mov word [plat_posx], 130
				sub word [plat_posy], 10
				mov ax, [plat_posy]
				sub ax, 10
				mov word [ball_posy], ax
				mov ax, [blocks_count]
				mov word [blocks_active], ax
				mov si, blocks
				call blocks_reset
				jmp nextlevel
			hit_bounds_left:
			cmp word [ball_posx], 10
			jne hit_bounds_right
			cmp word [ball_orienx], 0
			je hl_neg
			mov word [ball_orienx], 0
			jmp sums_ball
				hl_neg:
				mov word [ball_orienx], 1
				jmp sums_ball
			hit_bounds_right:
			cmp word [ball_posx], 305
			jne hit_bounds_top
			cmp word [ball_orienx], 0
			je hr_neg
			mov word [ball_orienx], 0
			jmp sums_ball
				hr_neg:
				mov word [ball_orienx], 1
				jmp sums_ball
			hit_bounds_top:
			cmp word [ball_posy], 14
			jne hit_bounds_bottom
			cmp word [ball_orieny], 0
			je ht_neg
			mov word [ball_orieny], 0
			jmp sums_ball
				ht_neg:
				mov word [ball_orieny], 1
				jmp sums_ball
			hit_bounds_bottom:
			cmp word [ball_posy], 195
			jne sums_ball
			mov word [game_active], 0
			mov word [ball_posx], 153
			mov ax, [plat_posy]
			sub ax, 10
			mov word [ball_posy], ax
			mov word [ball_orienx], 0
			mov word [ball_orieny], 1
			dec word [game_lifes]
			cmp word [game_lifes], 0
			je gameover

		sums_ball:
			orient_x:
			cmp word [ball_orienx], 0
			je positive_x
			dec word [ball_posx]
			jmp orient_y
			positive_x:
			inc word [ball_posx]
			orient_y:
			cmp word [ball_orieny], 0
			je positive_y
			dec word [ball_posy]
			jmp gl_draw
			positive_y:
			inc word [ball_posy]
			jmp gl_draw

		gl_draw:
		mov ax, [blocks_count]
		mov di, blocks
		call draw_tiles
		;
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, 0
		mov bx, 0
		mov cx, 320
		mov dx, 14
		mov si, 8
		call draw_rectangle
		;
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, 0
		mov bx, 14
		mov cx, 10
		mov dx, 186
		mov si, 8
		call draw_rectangle
		;
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, 310
		mov bx, 14
		mov cx, 10
		mov dx, 186
		mov si, 8
		call draw_rectangle
		;
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, [plat_posx]
		mov bx, [plat_posy]
		mov cx, 50
		mov dx, 5
		mov si, 7
		call draw_rectangle
		;
		mov ax, screen_buffer
		shr ax, 4
		mov es, ax
		mov ax, [ball_posx]
		mov bx, [ball_posy]
		mov cx, 6
		mov dx, 6
		mov si, 9
		call draw_rectangle
		;
		mov si, display_bcd
		mov ax, [game_score]
		xor cx, cx
		call populate_bcd
		mov si, display_bcd
		mov ax, 10
		mov bx, 2
		mov dx, 5
		call draw_bcd
		call clear_bcd
		;
		mov si, display_bcd
		mov ax, [game_lifes]
		xor cx, cx
		call populate_bcd
		mov si, display_bcd
		mov ax, 305
		mov bx, 2
		mov dx, 1
		call draw_bcd
		call clear_bcd
		;
		call paste_buffer
		call clear_buffer
		jmp gameloop

	terminate:
	times 8192-($-$$) db 0

	screen_buffer: times 64000 db 0
