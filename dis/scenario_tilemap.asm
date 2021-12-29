; Tilemap of the scenario, used by DRAW_SCENARIO_COL.

l59dbh:
    ; starts with 0x58, 0x59, 0x60, 0x61.
	ld e,b
	ld e,c	
	ld h,b	
	ld h,c	
	ld l,b	
	ld l,c	
l59e1h:
	ld h,a	
	ld l,(hl)	
	ld e,(hl)	
	ld e,(hl)	
	ld e,(hl)	
	ld e,(hl)	
	ld e,a	
	ld h,(hl)	
l59e9h:
	pop af	
	ex af,af'	
	ld b,001h
	ld b,001h
	ld b,001h
	ld b,001h
	inc d	
	ld b,c	
	dec d	
	ld b,c	
	xor 008h
	rst 28h	
	ex af,af'	
	ld b,001h
	ld b,001h
	jr $+67
	add hl,de	
	ld b,c	
	ld b,001h
	ld b,001h
	xor 008h
	rst 28h	
	ex af,af'	
	ld b,001h
	ld b,001h
	inc d	
	ld b,c	
	dec d	
	ld b,c	
	ld b,001h
	ld b,001h
	xor 008h
	rst 28h	
	ex af,af'	
	jr l5a5eh
	add hl,de	
	ld b,c	
	ld b,001h
	ld b,001h
	ld b,001h
	ld b,001h
	ret p	
	ex af,af'	
	ld (03c23h),hl
	dec a	
	ld e,d	
	ld e,e	
	ld (hl),b	
l5a30h:
	ld (hl),c	
l5a31h:
	ld (bc),a	
	out (07ch),a
	ld a,(hl)	
	inc bc	
	OutP1Flipscreen
l5a38h:
	ld a,a	
	inc e	
	call nc,07e7ch
	dec e	
l5a3eh:
	call nc,0x7f01
	jp m,0x7cd5
	ld a,(hl)	
	ei	
	push de	
	ld bc,0107fh
	out (07ch),a
	ld a,(hl)	
	ld de,l01d3h
	ld a,a	
l5a51h:
	ld (bc),a	
	out (07ch),a
	ld a,(hl)	
	inc bc	
	OutP1Flipscreen
	ld a,a	
	inc e	
	call nc,07e7ch
	dec e	
l5a5eh:
	call nc,0x7f01
	ld a,(0x7cd4)
	ld a,(hl)	
	dec sp	
	call nc,0x7f01
	djnz l5a3eh
	ld a,h	
	ld a,(hl)	
	ld de,l01d3h
	ld a,a	
	rra	
	jr nz,$+65
	ld b,b	
	ld e,a	
	ld h,b	
	ld a,a	
	add a,b	
	sbc a,a	
	and b	
	cp a	
l5a7ch:
	ret nz	
	cp a	
	ret nz	
	sbc a,a	
	and b	
	ld a,a	
	add a,b	
	ld e,a	
	ld h,b	
	ccf	
	ld b,b	
	rra	
l5a88h:
	jr nz,l5a8eh
	ld b,005h
	ld a,l	
	ld a,(hl)	
l5a8eh:
	sub (hl)	
	sub l	
	sub a	
	cp h	
	cp (hl)	
	cp l	
	cp a	
	ret nz	
	jp nz,0c3c1h
	call nz,0c5c6h
	rst 0	
	ret z	
	jp z,0cbc9h
l5aa1h:
	defb 0fdh,0fbh,0d4h	;illegal sequence
	cp 041h
	ld (03afdh),hl
	push de	
	add a,b	
	cp 091h
	rra	
	sub h	
	defb 0fdh,079h,0d5h	;illegal sequence
	ld h,0feh
	ld de,0
	nop	
	defb 0fdh,0b8h,0d5h	;illegal sequence
	cp 091h
	daa	
	jr z,$+43
	cp 011h
	nop	
	nop	
	defb 0fdh,0f8h,0d5h	;illegal sequence
	cp 091h
	jr nc,l5af5h
	cp 011h
	inc bc	
	cp 091h
	jr nz,l5af3h
	defb 0fdh,038h,0d6h	;illegal sequence
	ld sp,2d2ch
	cp 011h
	inc bc	
	cp 091h
	inc hl	
	defb 0fdh,079h,0d6h	;illegal sequence
	ld l,02fh
	ld (11feh),hl
	inc bc	
	defb 0fdh,0bah,0d6h	;illegal sequence
	cp 091h
	dec hl	
	inc h	
	dec h	
	rst 38h	
l5af0h:
	defb 0fdh,0fch,0d4h	;illegal sequence
l5af3h:
	cp 041h
l5af5h:
	ld (3bfdh),hl
	push de	
	add a,b	
	add a,b	
	defb 0fdh,079h,0d5h	;illegal sequence
	add a,b	
	defb 0fdh,0b8h,0d5h	;illegal sequence
	add a,b	
	add a,b	
	add a,b	
	defb 0fdh,0f8h,0d5h	;illegal sequence
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	defb 0fdh,038h,0d6h	;illegal sequence
	add a,(hl)	
	add a,(hl)	
	add a,(hl)	
	add a,(hl)	
	add a,(hl)	
	ld (iy-02ah),a
	cp 091h
	ld (hl),037h
	ld (03232h),a
	inc sp	
	or (iy-02ah)
	jr c,l5b5eh
	inc (hl)	
	inc (hl)	
	inc (hl)	
	inc (hl)	
	dec (hl)	
	rst 38h	
	cp 001h
	ld b,0feh
	add iy,sp
	ld e,e	
	add a,b	
	add a,b	
	add a,(hl)	
	rst 38h	
	cp 001h
	ld b,0feh
	ld bc,0fdfeh
	ld d,d	
	ld e,e	
	cp 041h
	ld (08080h),hl
	rst 38h	
	cp 009h
	cp 0fdh
	ld d,e	
	ld e,e	
	cp 0fch
	ld d,e	
	ld e,e	
	cp 001h
	ld b,0f9h
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	rst 38h	
	cp 001h
	inc bc	
l5b5eh:
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	inc bc	
	rst 38h	
l5b6ah:
	xor d	
	ld e,e	
	or e	
	ld e,e	
	call nz,0ce5bh
	ld e,e	
	call nz,0d55bh
	ld e,e	
	ret pe	
	ld e,e	
	ei	
	ld e,e	
	djnz $+94
	dec h	
	ld e,h	
	ld a,(04f5ch)
	ld e,h	
	ld h,d	
	ld e,h	
	adc a,05bh
	call nz,0ce5bh
	ld e,e	
	call nz,0ce5bh
	ld e,e	
	call nz,0d55bh
	ld e,e	
	ret pe	
	ld e,e	
	ei	
	ld e,e	
	djnz l5bf4h
	dec h	
	ld e,h	
	ld a,(04f5ch)
	ld e,h	
	ld h,d	
	ld e,h	
	adc a,05bh
	call nz,0ce5bh
	ld e,e	
	ld (hl),l	
	ld e,h	
	add a,e	
	ld e,h	
	cp 0fdh
	ld e,e	
	ld e,e	
	jp p,0f6f4h
	inc b	
	rst 38h	
	cp 0fdh
	add hl,sp	
	ld e,e	
	cp 001h
	rst 30h	
	di	
	push af	
	cp 041h
	add a,h	
	ld a,h	
	rst 38h	
	cp 001h
	ld b,0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	ld a,h	
	add a,h	
	rst 38h	
	cp 001h
	ld b,0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	add a,h	
	ld a,h	
	rst 38h	
	cp 041h
	ld d,080h
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	ld e,080h
	add a,b	
	add a,b	
	add a,b	
l5be4h:
	inc d	
	add a,h	
	ld a,h	
	rst 38h	
	cp 041h
	rla	
	adc a,b	
	inc e	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	rra	
	adc a,b	
l5bf4h:
	adc a,b	
	adc a,b	
	adc a,b	
	dec d	
	ld a,h	
	add a,h	
	rst 38h	
	cp 001h
	ld sp,hl	
	cp 041h
l5c00h:
	add a,b	
	adc a,c	
	nop	
	ld (bc),a	
	inc b	
	ld b,010h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	add a,h	
	ld a,h	
	rst 38h	
	cp 001h
	ld sp,hl	
	cp 041h
	add a,b	
	adc a,c	
	ld bc,00503h
	rlca	
	ld de,08022h
	add a,b	
	add a,b	
	add a,b	
	add a,(hl)	
	ld a,h	
	add a,h	
	rst 38h	
	cp 001h
	ld sp,hl	
	cp 041h
	add a,b	
	adc a,c	
	ex af,af'	
	ld a,(bc)	
	inc c	
	ld c,012h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	add a,h	
	ld a,h	
	rst 38h	
	cp 001h
	ld sp,hl	
	cp 041h
	add a,b	
	adc a,c	
	add hl,bc	
	dec bc	
	dec c	
	rrca	
	inc de	
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	ld a,h	
	add a,h	
	rst 38h	
	cp 041h
	ld a,(de)	
	inc hl	
	dec e	
	inc hl	
	inc hl	
	inc hl	
	inc hl	
	inc hl	
	jr nz,$+37
	inc hl	
	inc hl	
	inc hl	
	jr l5be4h
	ld a,h	
	rst 38h	
	cp 041h
	dec de	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	ld hl,08080h
	add a,b	
	add a,b	
	add hl,de	
	ld a,h	
	add a,h	
	rst 38h	
	cp 0fdh
	add hl,sp	
	ld e,e	
	cp 001h
	ret m	
	jp m,0fefch
	ld b,c	
	ld a,h	
	add a,h	
	rst 38h	
	cp 0fdh
	ld e,e	
	ld e,e	
	ei	
	defb 0fdh,0feh,041h	;illegal sequence
	ld a,e	
	ld a,h	
	rst 38h	
l5c8eh:
	xor b	
	ld e,h	
	jp nz,0dd5ch
	ld e,h	
	di	
	ld e,h	
	ex af,af'	
	ld e,l	
	jr nz,l5cf7h
	inc sp	
	ld e,l	
	inc a	
	ld e,l	
	ld a,(bc)	
	ld e,(hl)	
	bit 3,e
	pop bc	
	ld e,e	
	bit 3,e
	pop bc	
	ld e,e	
	cp 003h
	rst 28h	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	cp 092h
	ld a,(03e3ch)
	adc a,(hl)	
	cp 009h
	cp 0fdh
	ld d,h	
	ld e,e	
	call z,01feh
	defb 0edh;next byte illegal after ed
	rst 38h	
	cp 009h
	cp 0fdh
	ld d,l	
	ld e,e	
	cp 092h
	dec sp	
	dec a	
	ld b,(hl)	
	ld b,h	
	ld b,(hl)	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	cp 092h
	ld c,c	
	cp 093h
	ld c,e	
	ld c,l	
	rst 38h	
	cp 041h
	dec d	
	rla	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	cp 093h
	ccf	
	ld b,b	
	ld b,d	
	ld b,a	
	ld b,l	
	ld c,b	
	ld c,d	
	ld c,h	
	ld c,(hl)	
	ld e,h	
	ld e,(hl)	
	rst 38h	
	cp 001h
	ld b,0f9h
l5cf7h:
	cp 0fdh
	ld d,l	
	ld e,e	
	cp 093h
	ld b,c	
	ld b,e	
	ld d,d	
	ld d,h	
	ld d,(hl)	
	ld e,b	
	ld e,d	
	add a,(hl)	
	ld e,l	
	ld e,a	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 0fdh
	ld d,h	
	ld e,e	
	cp 093h
	ld d,c	
	ld d,e	
	ld d,l	
	ld d,a	
	ld e,c	
	ld e,e	
	cp 001h
	ld b,0feh
	sub e	
	ld h,e	
	ld e,a	
	rst 38h	
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 093h
	ld c,a	
	ld d,b	
	cp 013h
	nop	
	nop	
	nop	
	ld b,0feh
	sub e	
	ld h,e	
	ld e,a	
	rst 38h	
	cp 0fdh
	dec hl	
	ld e,e	
	cp 093h
	ld h,e	
	ld e,a	
	rst 38h	
	cp 008h
	xor 0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	cp 093h
	ld h,b	
	ld h,d	
	rst 38h	
l5d48h:
	ld h,d	
	ld e,l	
	ld a,l	
	ld e,l	
	sbc a,b	
	ld e,l	
	or d	
	ld e,l	
	jp z,0d65dh
	ld e,l	
	jp po,0f75dh
	ld e,l	
	ld a,(bc)	
	ld e,(hl)	
	bit 3,e
	pop bc	
	ld e,e	
	bit 3,e
	pop bc	
	ld e,e	
	cp 003h
	rst 28h	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	cp 092h
	add a,a	
	adc a,d	
	adc a,h	
	adc a,(hl)	
	cp 009h
	cp 0fdh
	ld d,l	
	ld e,e	
	nop	
	call z,01feh
	defb 0edh;next byte illegal after ed
	rst 38h	
	cp 009h
	cp 0fdh
	ld d,l	
	ld e,e	
	cp 092h
	adc a,b	
	adc a,e	
	adc a,l	
	adc a,a	
	sub d	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	call 01feh
	defb 0edh;next byte illegal after ed
	cp 092h
	ld (hl),h	
	rst 38h	
	cp 041h
	dec d	
	rla	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	cp 093h
	adc a,c	
	sub b	
	sub e	
	ld h,l	
	cp 041h
	adc a,b	
	adc a,b	
	adc a,b	
	dec d	
	cp 093h
	ld (hl),e	
	ld (hl),l	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 0fdh
	ld d,h	
	ld e,e	
	cp 093h
	sub c	
	ld h,h	
	cp 041h
	add a,b	
	add a,b	
	add a,b	
	add a,b	
	cp 093h
	ld l,(hl)	
	ld (hl),b	
	ld (hl),d	
	rst 38h	
	cp 0fdh
	ld (hl),05bh
	add a,b	
	cp 093h
	ld l,l	
	ld l,a	
	ld (hl),c	
	ld e,a	
	rst 38h	
	cp 0fdh
	ld (hl),05bh
	cp 093h
	ld l,b	
	ld l,d	
	ld l,h	
	ld h,e	
	ld e,a	
	rst 38h	
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 041h
	ld (0fe80h),hl
	sub e	
	ld h,(hl)	
	ld l,c	
	ld l,e	
	cp 013h
	ld (bc),a	
	cp 093h
	ld h,e	
	ld e,a	
	rst 38h	
	cp 008h
	xor 0feh
	add iy,sp
	ld e,e	
	cp 093h
l5e00h:
	ld h,a	
	cp 041h
	add a,b	
	add a,(hl)	
	cp 093h
	ld h,b	
	ld h,d	
	rst 38h	
	cp 008h
	rst 28h	
	cp 0fdh
	ld l,05bh
	cp 093h
	ld h,c	
	cp 041h
	add a,h	
	rst 38h	
l5e18h:
	ld (04c5eh),a
	ld e,(hl)	
	ld (hl),h	
	ld e,(hl)	
	ld a,l	
	ld e,(hl)	
	ld a,l	
	ld e,(hl)	
	ld a,l	
	ld e,(hl)	
	add a,(hl)	
	ld e,(hl)	
	adc a,a	
	ld e,(hl)	
	sbc a,e	
	ld e,(hl)	
	bit 3,e
	pop bc	
	ld e,e	
	bit 3,e
	pop bc	
	ld e,e	
	cp 003h
	rst 28h	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	cp 092h
	halt	
	inc a	
	ld a,c	
	cp 009h
	cp 0fdh
	ld d,h	
	ld e,e	
	nop	
	call z,01feh
	defb 0edh;next byte illegal after ed
	rst 38h	
	cp 009h
	cp 0fdh
	ld d,l	
	ld e,e	
	cp 092h
	ld (hl),a	
	ld a,b	
	cp 009h
	cp 0fdh
	ld d,e	
	ld e,e	
	call 092feh
	ld a,d	
	ld a,h	
	rst 38h	
	cp 041h
	dec d	
	rla	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	rra	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	dec d	
	rst 38h	
	cp 0fdh
	ld h,d	
	ld e,(hl)	
	cp 092h
	ld a,e	
	inc (hl)	
	rst 38h	
	cp 0fdh
	dec hl	
	ld e,e	
	cp 091h
	ld (0ff34h),a
	cp 0fdh
	dec hl	
	ld e,e	
	cp 091h
	add a,b	
	add a,d	
	rst 38h	
	cp 008h
	xor 0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	cp 091h
	add a,c	
	add a,e	
	rst 38h	
	cp 008h
	rst 28h	
	cp 0fdh
	ld l,05bh
	cp 091h
	ld a,a	
	cp 041h
	add a,h	
	rst 38h	
l5ea9h:
	rst 8	
	ld e,(hl)	
	jp po,0f45eh
	ld e,(hl)	
	inc c	
	ld e,a	
	ld hl,395fh
	ld e,a	
	ld d,e	
	ld e,a	
	ld l,l	
	ld e,a	
	adc a,e	
	ld e,a	
	and a	
	ld e,a	
	jp 0df5fh
	ld e,a	
	defb 0fdh,05fh,018h	;illegal sequence
	ld h,b	
	dec hl	
	ld h,b	
	ld b,a	
	ld h,b	
	ld h,l	
	ld h,b	
	add a,e	
	ld h,b	
	sbc a,e	
	ld h,b	
	cp 003h
	rst 28h	
	cp 009h
	nop	
	nop	
	nop	
	call nz,0c8c6h
	ret z	
	ret z	
	ret	
	rlc b
	nop	
	nop	
	rst 38h	
	cp 009h
	nop	
	nop	
	nop	
	nop	
	push bc	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	jp z,0
	nop	
	nop	
	call 0feffh
	add hl,bc	
	jp 041feh
	rla	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
l5f00h:
	adc a,b	
	rra	
	adc a,b	
	adc a,b	
	adc a,b	
	adc a,b	
	dec d	
	cp 007h
	add a,b	
	add a,d	
	rst 38h	
	cp 006h
	and a	
	xor b	
	cp 0fdh
	ld d,e	
	ld e,e	
	cp 041h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	cp 007h
	add a,c	
	add a,e	
	rst 38h	
	cp 045h
	adc a,d	
	cp 006h
	inc b	
	xor c	
	xor d	
	xor e	
	xor e	
	xor e	
	xor e	
	xor e	
	cp l	
	xor e	
	xor e	
	xor e	
	xor e	
	ret nz	
	cp 00ah
	sub 0d4h
	rst 38h	
	cp 006h
	and c	
	and d	
	cp 005h
	adc a,h	
	cp 006h
	xor h	
	xor l	
	xor (hl)	
	xor (hl)	
	xor (hl)	
	xor (hl)	
	cp (hl)	
	xor (hl)	
	xor (hl)	
	xor (hl)	
	xor (hl)	
	pop bc	
	cp 04ah
	ld a,l	
	ld a,(hl)	
	rst 38h	
	cp 006h
	sbc a,(hl)	
	and e	
	and (hl)	
	cp 005h
	adc a,a	
	cp 006h
	inc b	
	xor a	
	or b	
	or c	
	or c	
	cp a	
	or c	
	or c	
	or c	
	or c	
	jp nz,04afeh
	ld a,a	
	add a,e	
	rst 38h	
	cp 008h
	call pe,006feh
	and h	
	sub h	
	sub (hl)	
	sbc a,c	
	cp 005h
	adc a,h	
	cp 006h
	or d	
	or e	
	nop	
	cp 041h
	ld (08080h),hl
l5f83h:
	add a,b	
	cp 004h
	add a,h	
	add a,(hl)	
	adc a,b	
	adc a,d	
	rst 38h	
	cp 008h
	rst 28h	
	cp 006h
	and l	
	sub l	
	sub a	
	sbc a,d	
	sub e	
	cp 005h
	adc a,(hl)	
	cp 006h
	inc b	
	or h	
	or l	
	nop	
	nop	
	nop	
	cp 004h
	add a,l	
	add a,a	
	adc a,c	
	adc a,e	
	rst 38h	
	cp 001h
	ld b,0f9h
	nop	
	cp 006h
	sbc a,b	
	sbc a,e	
	sub h	
	sub (hl)	
	sbc a,c	
	cp 005h
	adc a,h	
	cp 006h
	or (hl)	
	or a	
	xor e	
	xor e	
	xor e	
	ret nz	
	cp 00ah
	call nc,0ffd6h
	cp 001h
	ld b,0f9h
	nop	
	nop	
	cp 006h
	sbc a,h	
	sub l	
	sub a	
	sbc a,d	
	sub e	
	cp 005h
	adc a,(hl)	
	cp 006h
	inc b	
	cp b	
	cp c	
	xor (hl)	
	pop bc	
	cp 00ah
	push de	
	rst 10h	
	rst 38h	
	cp 001h
	ld b,0f9h
	nop	
	nop	
	nop	
	nop	
	cp 006h
	sbc a,b	
	sbc a,e	
	sub h	
	sbc a,l	
	and b	
	cp 005h
	adc a,h	
	cp 006h
	cp d	
	cp e	
	jp nz,00afeh
	ret c	
	cp 041h
	ld a,h	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 0fdh
	ld d,l	
	ld e,e	
	cp 006h
	sbc a,h	
	sub l	
	sbc a,(hl)	
	sbc a,d	
	sub e	
	cp 005h
	adc a,(hl)	
	cp 006h
	inc b	
	cp h	
	cp 00ah
	out (003h),a
	rst 38h	
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 006h
	sbc a,a	
	sbc a,e	
	sub h	
	sub (hl)	
	sbc a,c	
	cp 005h
	adc a,h	
	cp 00ah
	pop de	
	jp nc,0feffh
	ld bc,0f906h
	cp 00bh
	exx	
	call c,0dcdch
	call c,0fedeh
	ld b,c	
	add a,b	
	ld (006feh),hl
	sbc a,h	
	sub l	
	sub a	
	sbc a,d	
	sub b	
	cp 005h
	adc a,l	
	rlca	
	rst 38h	
	cp 008h
	xor 0feh
	ld bc,0fef9h
	dec bc	
	jp c,0db07h
	defb 0ddh,0dfh,0e9h	;illegal sequence
	cp 041h
	add a,b	
	ld (08080h),hl
	cp 006h
	sbc a,b	
	sbc a,e	
	sub c	
	cp 00ah
	rst 8	
	ret nc	
	rst 38h	
	cp 008h
	rst 28h	
	cp 001h
	ld sp,hl	
	cp 00bh
	jp c,ENEMY_MOVE_COUNTER
	call po,0e9e6h
	cp 041h
	add a,b	
	ld (08080h),hl
	add a,b	
	cp 006h
	sbc a,h	
	sub d	
	cp 00ah
l6080h:
	adc a,003h
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 00bh
	jp c,0e3e1h
	push hl	
	rst 20h	
	jp (hl)	
	cp 041h
	add a,b	
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	add a,h	
	ld a,h	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 00bh
	ex de,hl	
	ret pe	
	ret pe	
	ret pe	
	ret pe	
	jp pe,041feh
	add a,b	
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	ld a,h	
	add a,h	
	rst 38h	
l60b3h:
	dec d	
	ld h,c	
	add hl,bc	
	ld h,c	
	ld (bc),a	
	ld h,c	
	or 060h
	push hl	
	ld h,b	
	exx	
	ld h,b	
	scf	
	ld h,e	
	add a,l	
	ld h,e	
	sub b	
	ld h,e	
	jr nc,l612ah
	scf	
	ld h,e	
	jr nc,l612eh
	scf	
	ld h,e	
	jr nc,l6132h
	scf	
	ld h,e	
	add a,l	
	ld h,e	
	sub b	
	ld h,e	
	jr nc,l613ah
	scf	
	ld h,e	
	cp 0fdh
	ld (hl),05bh
	add a,b	
	add a,b	
	cp 096h
	or h	
	or (hl)	
	or l	
	rst 38h	
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 041h
	ld (0fe80h),hl
	sub (hl)	
	or a	
	xor e	
	xor l	
	xor a	
	or c	
	or e	
l60f5h:
	rst 38h	
	cp 0fdh
	ld (hl),05bh
	cp 096h
	xor d	
	xor h	
	xor (hl)	
	or b	
	or d	
	rst 38h	
	cp 0fdh
	ld h,d	
	ld e,(hl)	
	add a,h	
	add a,h	
	rst 38h	
	cp 0fdh
	ld b,l	
	ld e,e	
	cp 092h
	ld c,c	
	cp 001h
	defb 0edh;next byte illegal after ed
	inc b	
	rst 38h	
	cp 003h
	rst 28h	
	cp 0fdh
	ld b,l	
	ld e,e	
	call z,01feh
	defb 0edh;next byte illegal after ed
	rst 38h	
	dec a	
	ld h,c	
	ld e,c	
	ld h,c	
	ld a,e	
	ld h,c	
	sbc a,e	
	ld h,c	
	cp e	
l612ah:
	ld h,c	
	push de	
	ld h,c	
	ex de,hl	
l612eh:
	ld h,c	
	inc bc	
	ld h,d	
	dec de	
l6132h:
	ld h,d	
	scf	
	ld h,d	
	ld d,e	
	ld h,d	
	ld l,c	
	ld h,d	
	ld a,l	
l613ah:
	ld h,d	
	sub c	
	ld h,d	
	cp 008h
	xor 0feh
	ld bc,0fef9h
	dec bc	
	exx	
	call c,0dcdch
	call c,04deh
	cp 041h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	cp 04ah
	ld c,(hl)	
	add a,c	
	rst 38h	
	cp 008h
	rst 28h	
	cp 001h
	ld sp,hl	
	cp 00bh
	jp c,4bfeh
	add a,a	
	adc a,l	
	sub b	
	cp 00bh
	rlca	
	jp (hl)	
	inc b	
	cp 041h
	ld (08080h),hl
	add a,b	
	add a,b	
	cp 046h
l6175h:
	ld c,e	
l6176h:
	cp 04ch
	sbc a,e	
	xor c	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 00bh
	jp c,4bfeh
	add a,a	
	adc a,(hl)	
	sub c	
	cp 00bh
	rlca	
	jp (hl)	
	inc b	
	cp 041h
	ld (08080h),hl
	cp 046h
	ld c,h	
	cp 04ch
	add a,e	
	sbc a,a	
	and a	
	add a,a	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 00bh
	jp c,4bfeh
	adc a,h	
	adc a,a	
	sub d	
	cp 00bh
	rlca	
	jp (hl)	
	inc b	
	cp 041h
	ld (0fe80h),hl
	ld b,(hl)	
	ld c,e	
	cp 04ch
	sbc a,e	
	sbc a,h	
	ld c,c	
	xor b	
	add a,a	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 00bh
	ex de,hl	
	ret pe	
	ret pe	
	ret pe	
	ret pe	
	jp pe,0fe04h
	ld b,(hl)	
	ld c,l	
l61cbh:
	cp 04ch
	add a,e	
	sbc a,a	
	and b	
	and c	
	add a,l	
	add a,a	
	add a,a	
	rst 38h	
	cp 001h
	ld b,0f9h
	cp 0fdh
	ld d,h	
	ld e,e	
	cp 046h
	ld c,e	
	cp 04ch
	sbc a,e	
	and l	
	and (hl)	
	sbc a,d	
	sbc a,d	
l61e7h:
	ld b,d	
	ld b,e	
	ld b,h	
	rst 38h	
	cp 001h
	ld b,0f9h
	nop	
	nop	
	nop	
	nop	
	cp 046h
	ld c,h	
	cp 04ch
	add a,e	
	sbc a,a	
	and e	
	and h	
	ld a,03eh
	ld a,045h
	ld c,b	
	add a,a	
	rst 38h	
	cp 001h
	ld b,0f9h
	nop	
	nop	
	nop	
	cp 046h
	ld c,e	
	cp 04ch
	sbc a,e	
	sbc a,h	
	and d	
	ld b,b	
	dec a	
	dec a	
	dec a	
	dec a	
	ld b,(hl)	
	ld b,a	
	add a,a	
	rst 38h	
	cp 008h
	xor 0feh
	ld bc,000f9h
	cp 046h
	ld c,h	
	cp 04ch
	add a,e	
	sbc a,a	
	and b	
	and c	
	add a,b	
	cp 041h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	add a,h	
	add a,h	
	rst 38h	
	cp 008h
	rst 28h	
	cp 001h
	ld sp,hl	
	cp 046h
	ld c,e	
	cp 04ch
	sbc a,e	
	sbc a,h	
	sbc a,l	
	sbc a,(hl)	
	add a,b	
	add a,b	
	cp 041h
	ld (08080h),hl
	add a,b	
	add a,b	
	add a,(hl)	
	add a,h	
	add a,h	
	rst 38h	
	cp 046h
	ld c,d	
	cp 04ch
	add a,e	
	sbc a,b	
	sbc a,c	
	sbc a,d	
	sbc a,d	
	sbc a,d	
	sbc a,d	
	sbc a,d	
	ld b,c	
	sbc a,d	
	sbc a,d	
	sbc a,d	
	sbc a,d	
	ld b,d	
	ld b,e	
	ld b,h	
	rst 38h	
	cp 04ch
	sbc a,e	
	sub l	
	sub (hl)	
	sub a	
	ld a,03eh
	ld a,03eh
	ld a,03fh
	ld a,03eh
	ld a,03eh
	ld b,l	
	ld c,b	
	add a,a	
	rst 38h	
	cp 04ch
	sub e	
	sub h	
	dec a	
	dec a	
	dec a	
	dec a	
	dec a	
	dec a	
	dec a	
	ld b,b	
	dec a	
	dec a	
	dec a	
	dec a	
	ld b,(hl)	
	ld b,a	
	add a,a	
	rst 38h	
	cp 04ch
	inc a	
	cp 0fdh
	ld l,05bh
	add a,h	
	add a,h	
	rst 38h	
	jr nc,$+101
	scf	
	ld h,e	
	jr nc,l6304h
	xor a	
	ld h,d	
	cp b	
	ld h,d	
	call nz,0d062h
	ld h,d	
	push hl	
	ld h,d	
	or 062h
	add hl,bc	
	ld h,e	
	cp 0fdh
	dec hl	
	ld e,e	
	ld a,h	
	cp 091h
	inc e	
	rst 38h	
	cp 008h
	xor 0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	cp 091h
	jr $+32
	rst 38h	
	cp 008h
	rst 28h	
	cp 0fdh
	ld l,05bh
	cp 091h
	inc d	
	ld d,0ffh
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 041h
	ld (0fe80h),hl
	sub c	
	ld a,(de)	
	cp 041h
	add a,b	
	add a,b	
	add a,(hl)	
	cp 091h
	inc d	
	ld d,0ffh
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 041h
	ld (091feh),hl
	add hl,de	
	dec de	
	dec e	
	djnz $+20
	inc d	
	ld d,0ffh
	cp 0fdh
l62f8h:
	ld c,a	
	ld e,e	
	cp 091h
	ex af,af'	
	ld a,(bc)	
	inc c	
	cp 011h
	inc bc	
	cp 091h
l6304h:
	ld de,1513h
	rla	
	rst 38h	
	cp 0fdh
	ld c,a	
	ld e,e	
	cp 091h
	add hl,bc	
	dec bc	
	dec c	
	rrca	
	cp 011h
	inc bc	
	inc bc	
	cp 091h
	rlca	
	ld c,0ffh
	jr nc,l6381h
	scf	
	ld h,e	
	jr nc,l6385h
	ld a,063h
	ld b,a	
	ld h,e	
	ld d,e	
	ld h,e	
	ld e,a	
	ld h,e	
	ld e,a	
	ld h,e	
	ld e,a	
	ld h,e	
	ld l,b	
	ld h,e	
	cp 0fdh
	dec hl	
	ld e,e	
	add a,h	
	ld a,h	
	rst 38h	
	cp 0fdh
	dec hl	
	ld e,e	
	ld a,h	
	add a,h	
	rst 38h	
	cp 0fdh
	dec hl	
	ld e,e	
	ld a,h	
	cp 091h
	jr c,$+1
	cp 008h
	xor 0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	cp 091h
	ld (hl),039h
	rst 38h	
	cp 008h
	rst 28h	
	cp 0fdh
	ld l,05bh
	cp 091h
	scf	
	inc (hl)	
	rst 38h	
	cp 0fdh
	dec hl	
	ld e,e	
	cp 091h
	ld (0ff34h),a
	cp 0fdh
	dec hl	
	ld e,e	
	cp 091h
	inc sp	
	dec (hl)	
	rst 38h	
	jr nc,l63d6h
	scf	
	ld h,e	
	jr nc,l63dah
	scf	
	ld h,e	
	add a,l	
	ld h,e	
	sub b	
	ld h,e	
	jr nc,l63e2h
	scf	
	ld h,e	
l6381h:
	jr nc,l63e6h
	scf	
	ld h,e	
l6385h:
	cp 008h
	xor 0feh
	defb 0fdh,02eh,05bh	;illegal sequence
	cp 0fch
	inc (hl)	
	ld h,e	
	cp 008h
	rst 28h	
	cp 0fdh
	ld l,05bh
	cp 0fch
	dec sp	
	ld h,e	
	and a	
	ld h,e	
	or b	
	ld h,e	
	cp c	
	ld h,e	
	jp nz,0cf63h
	ld h,e	
	jp (hl)	
	ld h,e	
l63a7h:
	cp 05ch
	ld l,c	
	ld l,e	
	ld l,l	
	cp 05eh
	adc a,e	
	rst 38h	
	cp 05ch
	ld (hl),b	
	ld (hl),d	
	cp 05eh
	ld a,b	
	add a,h	
	rst 38h	
	cp 05ch
	ld (hl),c	
	ld (hl),e	
	cp 05eh
	ld a,c	
	add a,h	
	rst 38h	
	cp 05ch
	ld (hl),h	
	halt	
	cp 05dh
	ld c,a	
	add a,a	
	add a,a	
	cp 0fch
	ret c	
	ld h,e	
	cp 05ch
	ld (hl),l	
	ld (hl),a	
	cp 05dh
	ld d,b	
l63d6h:
	cp 05fh
	add a,a	
	add a,a	
l63dah:
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	add a,a	
l63e2h:
	add a,a	
	add a,a	
	add a,a	
	add a,a	
l63e6h:
	add a,a	
	add a,a	
	rst 38h	
	cp 05ch
	ld l,a	
	ld a,d	
	cp 05dh
	ld d,c	
	cp 05fh
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	add a,a	
	scf	
	jr c,$+59
	add hl,sp	
	ld a,(0873bh)
	add a,a	
	add a,a	
	add a,a	
	rst 38h	
l6402h:
	ld b,d	
	ld h,h	
	ld c,(hl)	
	ld h,h	
	ld e,l	
	ld h,h	
	cp h	
	ld h,h	
	ret nz	
	ld h,h	
	ld h,h	
	ld h,h	
	ld l,b	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ld (hl),h	
	ld h,h	
	ld l,h	
	ld h,h	
	ld (hl),b	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret z	
	ld h,h	
	call z,0d064h
	ld h,h	
	call nc,0fe64h
	ld c,l	
	jp m,0fefch
	ld (hl),b	
	xor a	
	or c	
	or e	
	or l	
	or a	
	rst 38h	
	cp 04dh
	defb 0fdh,0feh,08dh	;illegal sequence
	add a,l	
	cp 08eh
	add a,h	
	cp 050h
	or d	
	or h	
	or (hl)	
	rst 38h	
	cp 08eh
	nop	
	ld bc,0302h
	rst 38h	
	call p,0d8f6h
	rst 38h	
	push af	
	rst 30h	
	add a,b	
	rst 38h	
	ret p	
	jp p,0ffd8h
	pop af	
	di	
	add a,b	
	rst 38h	
	ret m	
	push de	
	rst 10h	
	rst 38h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	cp b	
	ld h,h	
	cp h	
	ld h,h	
	ret nz	
	ld h,h	
	call nz,0d864h
	ld h,h	
	ret pe	
	ld h,h	
	ret z	
	ld h,h	
	call z,0d064h
	ld h,h	
	call nc,0d864h
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	call pe,0f264h
	ld h,h	
	ld sp,hl	
	ld h,h	
	ld (bc),a	
	ld h,l	
	add a,0c2h
	add a,b	
	rst 38h	
	rst 0	
	jp nz,0ff80h
	adc a,0d5h
	rst 10h	
	rst 38h	
	rst 8	
	sub 0d8h
	rst 38h	
	ret z	
	jp z,0ff80h
	ret	
	set 1,l
	rst 38h	
	ret nc	
	jp nc,0ffd4h
	pop de	
	out (080h),a
	rst 38h	
	xor d	
	jp nz,0ff80h
	cp b	
	jp nz,0ffc4h
	pop bc	
	jp 0ffc5h
	xor d	
	ret nz	
	call z,0b8ffh
	jp nz,0ff80h
	cp d	
	cp h	
	cp 050h
	cp (hl)	
	rst 38h	
	cp 050h
	cp c	
	cp e	
	cp l	
	cp a	
	rst 38h	
	cp 050h
	xor h	
	xor (hl)	
	or b	
	or d	
	or h	
l6500h:
	or (hl)	
	rst 38h	
	cp 050h
	xor e	
	xor l	
	xor a	
	or c	
	or e	
	or l	
	or a	
	rst 38h	
l650ch:
	ld c,h	
	ld h,l	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ld d,b	
	ld h,l	
	ret po	
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	call c,0e064h
	ld h,h	
	call po,0e864h
	ld h,h	
	ret c	
	ld h,h	
	ret pe	
	ld h,h	
	ret z	
	ld h,h	
	call z,0d064h
	ld h,h	
	call nc,0e364h
	push hl	
	add a,b	
	rst 38h	
	call po,0c4e6h
	rst 38h	
l6554h:
	ld b,(hl)	
	ld e,(hl)	
	ld e,b	
	ld h,l	
	cp 001h
	defb 0edh;next byte illegal after ed
	cp 041h
	ld a,h	
	rst 38h	
	ld h,a	
	ld h,l	
	ld l,l	
	ld h,l	
	halt	
	ld h,l	
	add a,c	
	ld h,l	
	cp 042h
	inc h	
	ld h,030h
	rst 38h	
	cp 05dh
	add a,a	
	cp 042h
	ld hl,(2e2ch)
	rst 38h	
	cp 05fh
	add a,a	
l6579h:
	add a,a	
	dec (hl)	
	cp 042h
	dec hl	
	dec l	
	cpl	
	rst 38h	
	cp 05fh
	add a,a	
	add a,a	
	ld (hl),0feh
	ld b,d	
	ld sp,03332h
	inc (hl)	
	rst 38h	
l658dh:
	dec b	
	ld bc,0b07h
	cp 006h
	dec b	
	ld (bc),a	
	add hl,bc	
	dec bc	
	defb 0fdh,008h,005h	;illegal sequence
	ld bc,0b0ch
	cp 00bh
	dec b	
	ld (bc),a	
	ld c,00bh
	defb 0fdh,00dh,0b7h	;illegal sequence
	ld h,l	
	or a	
	ld h,l	
l65a9h:
	push de	
	ld h,l	
	ret po	
	ld h,l	
l65adh:
	ex de,hl	
	ld h,l	
	pop af	
	ld h,l	
	nop	
	nop	
	rst 30h	
	ld h,l	
	ei	
	ld h,l	
l65b7h:
	ld (bc),a	
	nop	
	nop	
	ld (bc),a	
	nop	
	inc bc	
	dec b	
	add hl,de	
	ld bc,0b305h
	nop	
	dec b	
	nop	
	nop	
	dec b	
	ld c,l	
	rst 38h	
	dec b	
	rst 20h	
	cp 002h
	nop	
	defb 0fdh,002h,000h	;illegal sequence
	nop	
	rst 38h	
	nop	
	nop	
	inc b	
	djnz l65deh
	ld (de),a	
	djnz $-107
	ld b,014h
	inc b	
l65deh:
	djnz l65e0h
l65e0h:
	inc b	
	ld de,1206h
	djnz l6579h
	ld b,014h
	inc b	
	djnz l65ebh
l65ebh:
	dec b	
	ld d,l	
	ld bc,0088h
	nop	
	dec b	
	ld d,(hl)	
	ld bc,0088h
	nop	
	dec b	
	cp b	
	nop	
	nop	
	dec b	
	cp c	
	nop	
	nop	
l65ffh:
	sbc a,e	
	ld h,(hl)	
	cp a	
	ld h,(hl)	
	exx	
	ld h,(hl)	
	ld h,(iy+01dh)
	ld h,a	
	ld b,l	
	ld h,a	
	sub e	
	ld l,b	
	cp l	
	ld l,b	
	ld b,a	
	ld l,b	
	ld l,e	
	ld l,b	
	rra	
	ld l,b	
	ld (hl),a	
	ld l,c	
	and c	
	ld l,c	
	dec hl	
	ld l,c	
	ld c,a	
	ld l,c	
	inc bc	
	ld l,c	
	sbc a,a	
	ld h,a	
	ret	
	ld l,c	
	cp c	
	ld h,a	
	exx	
	ld h,a	
	rst 38h	
	ld h,a	
	ld l,e	
	ld l,b	
	ld l,e	
	ld l,b	
	ld l,e	
	ld l,b	
	push hl	
	ld l,b	
	push hl	
	ld l,b	
	nop	
	nop	
	nop	
	nop	
	ld h,e	
	ld h,a	
	ld (hl),h	
	ld h,a	
	add a,c	
	ld h,a	
	sub d	
	ld h,a	
	di	
	ld l,c	
	rlca	
	ld l,d	
	daa	
	ld l,d	
	inc a	
	ld l,d	
	ld d,c	
	ld l,d	
	ld h,(hl)	
	ld l,d	
	ld h,(hl)	
	ld (hl),h	
l664dh:
	xor h	
	ld h,(hl)	
	call z,0ea66h
	ld h,(hl)	
	ld a,(bc)	
	ld h,a	
	ld (05667h),a
	ld h,a	
	and h	
	ld l,b	
l665bh:
	jp nc,05868h
	ld l,b	
	add a,b	
	ld l,b	
	inc (hl)	
	ld l,b	
	adc a,b	
	ld l,c	
	or (hl)	
	ld l,c	
	inc a	
	ld l,c	
	ld h,h	
	ld l,c	
	jr l66d6h
	xor h	
	ld h,a	
	jp c,0c669h
	ld h,a	
	and 067h
	inc c	
	ld l,b	
	add a,b	
	ld l,b	
	add a,b	
	ld l,b	
	add a,b	
	ld l,b	
	or 068h
	or 068h
	nop	
	nop	
	nop	
	nop	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
	nop	
	ld l,d	
	inc d	
	ld l,d	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
	cp (hl)	
	ld h,(hl)	
l6699h:
	cp (hl)	
	ld h,(hl)	
l669bh:
	daa	
	djnz l66a0h
	add a,b	
	dec l	
l66a0h:
	djnz l66a4h
	add a,d	
	inc hl	
l66a4h:
	inc l	
	nop	
	add a,h	
	jr z,l66d9h
	ld bc,0ff02h
	dec a	
	ld c,d	
	and b	
	rst 38h	
	jr nz,$+1
	rrca	
	ccf	
	ld b,b	
	nop	
	ld b,b	
	rst 38h	
	rrca	
	jr c,l665bh
	nop	
	nop	
	nop	
	rst 38h	
	add hl,hl	
	djnz $+4
	add a,(hl)	
	jr z,l66f5h
	ld bc,2803h
	ld b,b	
	nop	
	inc b	
	rst 38h	
	ld b,d	
	ld c,e	
	ret nz	
	rst 38h	
	ld b,b	
	rst 38h	
	rrca	
	ld b,d	
	ld h,b	
	nop	
l66d6h:
	ld h,b	
	rst 38h	
	rst 38h	
l66d9h:
	ld h,010h
	ld (bc),a	
	adc a,(hl)	
	dec l	
	djnz $+4
	sub b	
	ld (002ch),hl
	sub d	
	jr z,l6716h
	ld bc,0ff0bh
	jr nc,l6735h
	ret nz	
	rst 38h	
	ld b,b	
	rst 38h	
	rrca	
	ld a,0a0h
	nop	
	ret nz	
l66f5h:
	rst 38h	
	rrca	
	jr z,l66f9h
l66f9h:
	nop	
	nop	
	rst 38h	
	rst 38h	
	daa	
	ccf	
	nop	
	inc b	
	jr z,l6713h
	ld (bc),a	
	sub h	
	jr z,l6737h
	ld bc,0ff0dh
	ld b,b	
	ld c,e	
	ret nz	
	rst 38h	
	jr nz,$+1
	rrca	
	ld b,c	
	ld b,b	
l6713h:
	nop	
	ld h,b	
	rst 38h	
l6716h:
	rrca	
	inc e	
	and b	
	nop	
	nop	
	nop	
	rst 38h	
	ld hl,(0003bh)
	ld hl,(1020h+2)
	ld (bc),a	
	adc a,b	
	ld hl,(00210h)
	adc a,d	
	ld (0130h),hl
	dec b	
	add hl,hl	
	dec l	
	ld bc,0ff06h
	rrca	
	ld b,l	
	ld b,b	
l6735h:
	nop	
	ret po	
l6737h:
	rst 38h	
	rrca	
	ld a,(l00e0h)
	and b	
	rst 38h	
	rrca	
	ld h,000h
	nop	
	ld b,b	
	rst 38h	
	rst 38h	
	dec h	
	djnz $+4
	adc a,h	
	ld l,010h
	ld (bc),a	
	ex af,af'	
	jr z,l676fh
	ld bc,2709h
	dec l	
	nop	
	ld a,(bc)	
	rst 38h	
	rrca	
	dec (hl)	
	and b	
	rst 38h	
	jr nz,$+1
	rrca	
	inc l	
	add a,b	
	nop	
	and b	
	rst 38h	
	rst 38h	
	rra	
	dec e	
	ld (bc),a	
	sbc a,d	
	inc h	
	ld (de),a	
	ld (bc),a	
	sbc a,h	
	dec h	
	ld (l16feh+3),a
l676fh:
	dec h	
	ld b,d	
	nop	
	ld d,0ffh
	ld hl,(00210h)
	sbc a,(hl)	
	ld hl,(0130h)
	add hl,de	
	jr z,$+66
	nop	
	inc e	
l6780h:
	rst 38h	
	jr nz,$+31
	ld (bc),a	
	and b	
	dec h	
	ld (de),a	
	ld (bc),a	
	and d	
	dec h	
	ld (01b01h),a
	inc h	
	ld b,d	
	nop	
	ld a,(de)	
	rst 38h	
	ld hl,(00210h)
	and h	
	ld hl,(0130h)
	dec e	
	jr z,l67dch
	nop	
	inc e	
	rst 38h	
	ld hl,(0003ch)
	ld hl,l1027h+1
	ld (bc),a	
	and (hl)	
	jr z,l67d7h
	ld bc,0ff1fh
	rrca	
	ld b,(hl)	
	nop	
	nop	
	add a,b	
	rst 38h	
	rrca	
	scf	
	and b	
	nop	
	nop	
	nop	
	rst 38h	
	add hl,hl	
	ld c,c	
	nop	
	ld hl,l1027h+1
	ld (bc),a	
	xor b	
	jr z,l67eeh
	ld bc,0ffaah
	ld b,(hl)	
	ld d,b	
	ret po	
	rst 38h	
	ld h,b	
	rst 38h	
	add hl,sp	
	ld b,(hl)	
	ld h,b	
	nop	
	and b	
	rst 38h	
	inc d	
	add hl,sp	
	ld h,b	
	nop	
	ret nz	
l67d7h:
	rst 38h	
	rst 38h	
	jr z,l67f2h
	ld (bc),a	
l67dch:
	xor h	
	add hl,hl	
	ld sp,l2200h+1
	jr z,$+67
	nop	
	ld hl,036ffh
	ld c,d	
	ret nz	
	rst 38h	
	ld b,b	
	rst 38h	
	dec hl	
	ccf	
l67eeh:
	ret nz	
	nop	
	ret po	
	rst 38h	
l67f2h:
	ld e,02ch
	jr nz,l67f6h
l67f6h:
	ld b,b	
	rst 38h	
	ld a,(de)	
	ld e,040h
	nop	
	nop	
	nop	
	rst 38h	
	jr z,l684ah
	nop	
	ld hl,l1027h+1
	ld (bc),a	
	xor b	
	add hl,hl	
	dec hl	
	ld bc,0ffaeh
	ld c,b	
	ld d,e	
	ret nz	
	rst 38h	
	ld b,b	
	rst 38h	
	cpl	
	ld c,b	
	ld h,b	
	nop	
	and b	
	rst 38h	
	inc d	
	cpl	
	ld b,b	
	nop	
	ret nz	
	rst 38h	
	rst 38h	
	dec h	
	djnz $+4
	or b	
	ld hl,(00210h)
	or d	
	inc e	
	jr c,l682bh
	inc h	
l682bh:
	ld hl,(0130h)
	dec h	
	inc l	
	ld b,b	
	nop	
	ld h,0ffh
	rrca	
	ld c,e	
	ld b,b	
	ld bc,0ffc0h
	rrca	
	add hl,hl	
	add a,b	
	ld bc,0ff00h
	rrca	
	cpl	
	add a,b	
	ld bc,0ffa0h
	rst 38h	
	dec h	
	djnz $+4
l684ah:
	or b	
	ld hl,(00210h)
	or d	
	add hl,hl	
	jr nc,$+3
	jr z,l687dh
	ld b,b	
	nop	
	daa	
	rst 38h	
	rrca	
	ld c,e	
	ld b,b	
	nop	
	ret nz	
	rst 38h	
	rrca	
	ld hl,(0x80)
	nop	
	rst 38h	
	ld (0a040h),a
	nop	
	jr nz,l686ah
l686ah:
	rst 38h	
	dec h	
	djnz $+4
	or b	
	ld hl,(00210h)
	or d	
	inc e	
	jr c,l6877h
	add hl,hl	
l6877h:
	jr z,l68a9h
	ld bc,2828h+3
	ld b,b	
l687dh:
	nop	
	ld hl,(0fffh)
	ld c,d	
	ld b,b	
	nop	
	and b	
	rst 38h	
	rrca	
	add hl,hl	
	add a,b	
	nop	
	nop	
	rst 38h	
	add hl,hl	
	ccf	
	add a,b	
	nop	
	ret nz	
	rst 38h	
	rst 38h	
	dec e	
	inc h	
	ld (bc),a	
	or h	
	dec l	
	djnz l689ch
	cp b	
	dec l	
l689ch:
	jr nc,l689fh
	or (hl)	
l689fh:
	dec l	
	ld b,b	
	nop	
	inc l	
	rst 38h	
	daa	
	ld c,e	
	add a,b	
	nop	
	nop	
l68a9h:
	nop	
	rrca	
	daa	
	ret nz	
	nop	
	ld b,b	
	nop	
	jr nc,$+65
	ret po	
	nop	
	and b	
	nop	
	cpl	
	scf	
	nop	
	nop	
	ld b,b	
	rst 38h	
	rst 38h	
	ld c,038h
	ld (bc),a	
	dec l	
	ld e,030h
	ld (bc),a	
	ld (l1027h+1),a
	ld (bc),a	
	call nz,302eh
	ld bc,02e34h
	ld b,b	
	nop	
	inc sp	
	rst 38h	
	scf	
	ld c,d	
	and b	
	nop	
	jr nz,l68d8h
l68d8h:
	dec (hl)	
	ccf	
	jr nz,$+3
	jr nz,$+1
	inc de	
	jr c,$+66
	nop	
	and b	
	rst 38h	
	rst 38h	
	daa	
	ld b,(hl)	
	nop	
	daa	
	jr z,l68fbh
	ld (bc),a	
	add a,028h
	jr z,$+3
	jp z,03718h
	ld (bc),a	
	ret z	
	rst 38h	
	inc de	
	ld d,c	
	nop	
	nop	
	add a,b	
l68fbh:
	rst 38h	
	ld sp,08047h
	nop	
l6900h:
	nop	
	nop	
	rst 38h	
	dec h	
	djnz l6908h
	sub (hl)	
	dec (hl)	
l6908h:
	djnz $+4
	sbc a,b	
l690bh:
	ld e,028h
	ld bc,2e11h
	inc hl	
	ld bc,sub_2d0dh+2
	inc sp	
	nop	
	ld c,0ffh
	rrca	
	ld a,(0x60)
	ret po	
	rst 38h	
	rrca	
	ld sp,0x00c0
	nop	
	nop	
	rrca	
	ld (l0040h),hl
	jr nz,$+1
	rst 38h	
	dec h	
	djnz l6930h
	sub (hl)	
	dec (hl)	
l6930h:
	djnz $+4
	sbc a,b	
	ld hl,(0123h)
	inc de	
	ld hl,(0033h)
	ld (de),a	
	rst 38h	
	rrca	
	ld a,(0x60)
	ret po	
	rst 38h	
	rrca	
	ld (0x00c0),a
	jr nz,l6948h
l6948h:
	rrca	
	ld (l0020h),hl
	jr nz,$+1
	rst 38h	
	dec h	
	djnz l6954h
	sub (hl)	
	dec (hl)	
l6954h:
	djnz l6958h
	sbc a,b	
	rra	
l6958h:
	jr z,$+3
	djnz $+42
	inc hl	
	ld bc,02815h
	inc sp	
	nop	
	inc d	
	rst 38h	
	rrca	
	ld a,(l0040h)
	ret nz	
	rst 38h	
	rrca	
	jr nc,$-62
	nop	
	ret po	
	rst 38h	
	rrca	
	ld (0ffe0h),hl
	nop	
	rst 38h	
	rst 38h	
	jr nz,l6989h
	ld (bc),a	
	call z,02028h
	nop	
	adc a,030h
	djnz $+4
	scf	
	jr nc,l69a5h
	ld bc,0ff36h
	dec e	
l6989h:
	jr c,l690bh
	nop	
	nop	
	nop	
	rrca	
l698fh:
	inc l	
	ld b,b	
	ld bc,000a0h
	rra	
	dec hl	
	nop	
	nop	
	ld b,b	
	rst 38h	
	rrca	
	rra	
	ld b,b	
	rst 38h	
	ret nz	
	cp 0ffh
	rrca	
	djnz l69a6h
	dec sp	
l69a5h:
	rra	
l69a6h:
	djnz $+4
	call nc,01a26h
	nop	
	ret c	
	jr nc,l69bfh
	ld (bc),a	
	sub 02dh
	inc hl	
	ld bc,0ff3ch
	ld a,(de)	
	jr c,$+34
	nop	
	and b	
	rst 38h	
	add hl,de	
	dec l	
	nop	
l69bfh:
	ld bc,0fee0h
	rrca	
	rra	
	ret nz	
	ld bc,l00e0h
	rst 38h	
	jr l6a04h
	nop	
	ld hl,1b12h
	ld (bc),a	
	ld l,022h
	djnz $+4
	jp nz,02b1bh
	ld bc,0ff31h
	add hl,sp	
	ld b,d	
	ret nz	
	defb 0fdh,040h,0fdh	;illegal sequence
	ld hl,(0a039h)
	cp 0c0h
	defb 0fdh,01fh,02fh	;illegal sequence
	ld b,b	
	rst 38h	
	ld b,b	
	cp 00fh
	jr nz,l698fh
	rst 38h	
	nop	
	rst 38h	
	rst 38h	
	add hl,hl	
	ld b,b	
	nop	
	ld a,029h
	jr nc,l69fbh
	ccf	
l69fbh:
	add hl,hl	
	djnz l6a00h
	ld b,d	
	rst 38h	
l6a00h:
	rrca	
	ld c,e	
	jr nz,l6a04h
l6a04h:
	and b	
	rst 38h	
	rst 38h	
	dec h	
	ccf	
l6a09h:
	nop	
	rlca	
	dec hl	
	cpl	
	ld bc,2c35h
	djnz l6a14h
	ld b,h	
	rst 38h	
l6a14h:
	ld b,b	
	ld c,b	
	and b	
	rst 38h	
	jr nz,$+1
	inc (hl)	
	ccf	
	ld h,b	
	nop	
	ret nz	
	rst 38h	
	rrca	
	ld a,(0x00c0)
	jr nz,l6a26h
l6a26h:
	rst 38h	
	ld hl,(l0040h)
	dec a	
	jr nz,l6a5dh
	ld b,c	
	dec hl	
	jr nc,l6a61h
	ld b,c	
	ld a,020h
	djnz $+4
	ld b,(hl)	
	jr nc,l6a49h
	ld (bc),a	
	ld c,b	
	rst 38h	
	ld h,033h
	ld b,c	
	ccf	
	ld (hl),031h
	add a,b	
	jp pe,l141ch
	ld (bc),a	
	ld c,d	
	inc l	
l6a49h:
	inc de	
	ld (bc),a	
	ld c,h	
	inc a	
	add hl,de	
	nop	
	ld c,(hl)	
	rst 38h	
	ld l,040h
	add a,b	
	ex de,hl	
	ld e,030h
	add a,c	
	call pe,302eh
	add a,c	
	defb 0edh;next byte illegal after ed
l6a5dh:
	ld e,010h
	ld (bc),a	
	ld d,b	
l6a61h:
	ld l,010h
	ld (bc),a	
	ld d,d	
	rst 38h	
	daa	
	ld (hl),081h
	xor 037h
	inc l	
	add a,b	
	rst 28h	
	rla	
	djnz l6a73h
	ld d,h	
	daa	
l6a73h:
	ld d,001h
	ld d,(hl)	
	scf	
	djnz l6a7ah
	ld e,b	
l6a7ah:
	rst 38h	
l6a7bh:
	sub a	
	ld l,d	
	and h	
	ld l,d	
	or c	
	ld l,d	
	and h	
	ld l,d	
	ret c	
	ld l,d	
	bit 5,d
	cp (hl)	
	ld l,d	
	push hl	
	ld l,d	
	jp p,0ff6ah
	ld l,d	
	ld (196bh),hl
	ld l,e	
	inc c	
	ld l,e	
	add hl,de	
	ld l,e	
	dec l	
	ld b,b	
	ld b,l	
	nop	
l6a9bh:
	daa	
	djnz $+70
	add a,b	
	dec l	
	djnz l6ae6h
	ld b,b	
	rst 38h	
	dec l	
	ld b,b	
	ld b,l	
	nop	
	add hl,hl	
	jr nc,l6aefh
	ld bc,1029h
	ld b,h	
	ld b,d	
	rst 38h	
	dec l	
	ld b,b	
	ld b,l	
	nop	
	jr z,l6ac7h
	ld b,h	
	add a,h	
	ld sp,04410h
	ld b,h	
	rst 38h	
	daa	
	inc a	
	ld b,l	
	ld (bc),a	
	ld hl,l4420h
	ld b,(hl)	
	inc l	
l6ac7h:
	djnz l6b0dh
	ld c,b	
	rst 38h	
	inc h	
	jr z,l6b12h
	ld c,d	
	jr z,l6afch
	ld b,l	
	ld c,h	
	jr z,l6ae5h
	ld b,h	
	ld c,(hl)	
	rst 38h	
	inc l	
	inc c	
	ld b,l	
	sbc a,b	
	dec h	
	jr nz,l6b23h
	ld d,(hl)	
	dec h	
	djnz $+70
	inc b	
	rst 38h	
l6ae5h:
	add hl,de	
l6ae6h:
	dec c	
	ld b,l	
	adc a,b	
l6ae9h:
	rra	
	ld a,(de)	
	ld b,h	
	ld d,b	
	cpl	
	dec c	
l6aefh:
	ld b,h	
	adc a,h	
	rst 38h	
	inc e	
	dec c	
	ld b,l	
	sub b	
l6af6h:
	inc l	
	rla	
	ld b,h	
	ld d,d	
	dec (hl)	
	dec c	
l6afch:
	ld b,h	
	ld d,h	
	rst 38h	
l6affh:
	jr z,l6b40h
	ld b,l	
	nop	
l6b03h:
	ld h,010h
	ld b,h	
	sub h	
	ld (hl),030h
	ld b,h	
	inc bc	
	rst 38h	
	add hl,hl	
l6b0dh:
	ld b,b	
	add a,l	
	nop	
	ld h,010h
l6b12h:
	ld b,h	
	or 036h
	djnz l6a9bh
	jp c,02affh
	ld b,b	
	add a,l	
	nop	
	ld hl,(04410h)
	call m,02affh
l6b23h:
	ld b,b	
	add a,l	
	nop	
	ld h,010h
	ld b,h	
	jp m,01036h
	call nz,0fff2h
l6b2fh:
	ld d,c	
	ld l,e	
	ld e,(hl)	
	ld l,e	
	ld l,e	
	ld l,e	
	ld e,(hl)	
	ld l,e	
	add a,l	
	ld l,e	
	ld a,b	
	ld l,e	
	nop	
	nop	
l6b3dh:
	sub d	
	ld l,e	
	sbc a,e	
l6b40h:
	ld l,e	
	and h	
	ld l,e	
	or c	
	ld l,e	
	or c	
	ld l,e	
	cp d	
	ld l,e	
	jp 0cc6bh
	ld l,e	
	push de	
	ld l,e	
	sbc a,06bh
	jr z,l6b83h
	sub c	
	djnz l6b7eh
	jr nz,l6ae9h
	ld de,l1027h+1
	sub d	
	add a,d	
	rst 38h	
	jr z,l6b90h
	sub c	
	djnz l6b8bh
	jr nz,l6af6h
	ld (de),a	
	jr z,l6b78h
	sub d	
	add a,h	
	rst 38h	
	daa	
	jr nc,l6affh
	djnz $+42
	jr nz,l6b03h
l6b72h:
	inc de	
	jr z,l6b85h
	sub d	
	add a,(hl)	
	rst 38h	
l6b78h:
	jr z,l6b9ah
	sub c	
	adc a,b	
	jr z,l6b8eh
l6b7eh:
	sub d	
	adc a,d	
	dec hl	
	ld l,047h
l6b83h:
	inc c	
	rst 38h	
l6b85h:
	jr z,l6ba7h
	sub c	
	sub d	
	jr z,l6b9bh
l6b8bh:
	sub d	
	sub h	
	inc l	
l6b8eh:
	inc c	
	ld b,a	
l6b90h:
	inc c	
	rst 38h	
	ld (09118h),hl
	sub (hl)	
	dec l	
	djnz $-108
	sbc a,b	
l6b9ah:
	rst 38h	
l6b9bh:
	ld e,012h
	sub c	
	adc a,h	
	ld l,012h
	sub d	
	adc a,(hl)	
	rst 38h	
	daa	
	dec l	
	sub c	
l6ba7h:
	djnz $+43
	djnz l6b3dh
	sub b	
	inc l	
	jr nz,l6b40h
	inc d	
	rst 38h	
	ld hl,(0d118h)
	call p,1029h+1
	jp nc,0fff6h
	inc l	
	ld e,0d1h
	ret m	
	ld hl,(0d20ah)
	jp m,029ffh
	dec c	
	pop de	
	call m,1226h
	sub d	
	ei	
	rst 38h	
	daa	
	dec c	
	pop de	
	cp 020h
	ld d,092h
	call m,027ffh
	dec c	
	pop de	
	call m,l1822h+2
	sub d	
	ei	
	rst 38h	
	jr z,l6beah
	pop de	
	cp 021h
	ld de,0fc92h
	rst 38h	
l6be7h:
	ld bc,00e6ch
l6beah:
	ld l,h	
	rla	
	ld l,h	
	ld c,06ch
	dec l	
	ld l,h	
	ld a,(0246ch)
	ld l,h	
	ld b,a	
	ld l,h	
	ld d,h	
	ld l,h	
	ld (hl),a	
	ld l,h	
	add a,h	
	ld l,h	
	ld h,c	
	ld l,h	
	ld l,d	
	ld l,h	
	dec h	
	jr nc,$+8
	cp (hl)	
	dec h	
	djnz l6c0eh
l6c08h:
	ret nz	
	ld hl,(l4610h)
	ld e,b	
	rst 38h	
l6c0eh:
	dec h	
	jr nc,l6c17h
	cp d	
	dec h	
	djnz l6c1bh
	cp h	
	rst 38h	
l6c17h:
	dec h	
	jr nc,$+8
	ret nc	
l6c1bh:
	dec h	
	djnz l6c24h
	jp nc,102bh
	ld b,(hl)	
	ld e,d	
	rst 38h	
l6c24h:
	daa	
	djnz l6c6dh
	and b	
	dec l	
	ld a,047h
	dec b	
	rst 38h	
	jr nz,l6c58h
	ld b,(hl)	
	ld b,026h
	inc c	
	ld b,(hl)	
	xor h	
	jr nc,$+14
	ld b,a	
	rlca	
	rst 38h	
	jr nz,l6c4ch
	ld b,(hl)	
	ret nc	
	ld hl,(0472dh)
	inc c	
	jr nc,l6c54h
	ld b,(hl)	
	call nc,17ffh
	dec h	
	ld b,(hl)	
	ld e,h	
	daa	
l6c4ch:
	ld c,046h
	or b	
	scf	
	djnz l6c98h
	ld e,(hl)	
	rst 38h	
l6c54h:
	rla	
	ld a,(bc)	
	ld b,(hl)	
	or h	
l6c58h:
	daa	
	ld a,(bc)	
	ld b,(hl)	
	cp b	
	scf	
	ld a,(bc)	
	ld b,(hl)	
	ld h,b	
	rst 38h	
	daa	
	djnz l6caah
	cp h	
	daa	
	ld c,b	
	ld b,a	
	ex af,af'	
	rst 38h	
l6c6ah:
	ld h,010h
	ld b,(hl)	
l6c6dh:
	ret nz	
	ld (hl),037h
	ld b,(hl)	
	add hl,bc	
	ld (hl),010h
	ld b,(hl)	
	ld a,(bc)	
	rst 38h	
	rla	
	jr nc,$+72
	dec bc	
	rla	
	djnz l6cc4h
	ld h,d	
	daa	
l6c80h:
	djnz l6cc8h
	call nz,01fffh
	djnz l6ccdh
	ret z	
	cpl	
	djnz l6cd1h
	call z,0c5ffh
	ld l,h	
	sub 06ch
	rst 20h	
	ld l,h	
	sub 06ch
	ld h,06dh
	ld d,b	
l6c98h:
	ld l,l	
	sub e	
	ld l,l	
	ld d,b	
	ld l,l	
	ld h,06dh
	dec c	
	ld l,l	
	dec sp	
	ld l,l	
	ld a,(hl)	
	ld l,l	
	dec sp	
	ld l,l	
	dec c	
	ld l,l	
	ret m	
l6caah:
	ld l,h	
	dec sp	
	ld l,l	
	ld h,l	
	ld l,l	
	dec sp	
	ld l,l	
	ret m	
	ld l,h	
	jp c,0c56dh
	ld l,l	
	xor h	
	ld l,l	
	inc c	
	ld l,(hl)	
	di	
	ld l,l	
	dec h	
	ld l,(hl)	
	ld (hl),06eh
	ld b,e	
	ld l,(hl)	
	ld e,b	
l6cc4h:
	ld l,(hl)	
	jr nz,$+18
	ld c,b	
l6cc8h:
	ld h,h	
	jr nc,l6cdbh
	ld c,c	
	ld h,(hl)	
l6ccdh:
	inc h	
	jr nc,l6d19h
	ld l,b	
l6cd1h:
	inc (hl)	
	jr nc,l6d1dh
	dec c	
	rst 38h	
	ld h,010h
	ld c,b	
	ld c,026h
l6cdbh:
	jr nz,l6d26h
	ld l,d	
	ld h,040h
	ld c,c	
	rrca	
	ld (hl),028h
	ld c,c	
	djnz $+1
	jr nz,$+18
	ld c,c	
	ld l,h	
	daa	
	jr nc,$+75
	ld l,(hl)	
	jr nc,$+18
	ld c,b	
	ld (hl),b	
	jr c,$+43
	ld c,c	
	djnz $+1
	ld hl,l4810h
	ld (hl),d	
	ld sp,l4810h
	ld (hl),h	
	jr l6d2fh
	ld c,c	
	halt	
	jr z,l6d26h
	ld c,c	
	ret c	
	jr $+78
	ld c,b	
	ld de,025ffh
	ld b,b	
	ld c,c	
	rrca	
	ex af,af'	
	jr nc,l6d5dh
	ld a,b	
	jr $+56
	ld c,c	
	ld (de),a	
l6d19h:
	ld hl,l4810h
	ld (hl),d	
l6d1dh:
	jr nc,l6d2fh
	ld c,b	
	ld (hl),h	
	jr z,$+45
	ld c,c	
	ld a,d	
	rst 38h	
l6d26h:
	jr nz,$+18
	ld c,b	
	dec h	
	jr nc,l6d3ch
	ld c,c	
	ld h,014h
l6d2fh:
	jr z,l6d3ah
	call m,201ah
	ld c,c	
	daa	
	ld hl,(l4920h)
	ld a,h	
l6d3ah:
	rst 38h	
	add hl,hl	
l6d3ch:
	inc a	
	ld c,c	
	rrca	
	dec e	
	djnz $+74
	ld a,(hl)	
	dec l	
	djnz $+10
	jp c,0401dh
	ld c,c	
	inc de	
	dec h	
	ld hl,(0dc09h)
	rst 38h	
	dec hl	
	dec hl	
	ld c,c	
	rrca	
	inc e	
	djnz l6d9fh
	inc d	
	inc l	
	djnz $+75
	dec d	
	inc e	
l6d5dh:
	inc l	
	ld c,c	
	ld d,028h
	jr nz,l6d6ch
	sbc a,0ffh
	daa	
	ld b,b	
	ld c,c	
	rrca	
	inc hl	
	djnz l6d74h
l6d6ch:
	ret po	
	inc sp	
	djnz l6d79h
	jp po,l3025h
	add hl,bc	
l6d74h:
	call po,3835h
	ld c,c	
	rla	
l6d79h:
	ld b,l	
	jr c,l6dc5h
	jr $+1
	inc e	
	ex af,af'	
	ex af,af'	
	and 01ch
	jr z,$+75
	add hl,de	
	inc l	
	djnz $+75
	call c,0303ch
	ld c,c	
	ld a,(de)	
	ld c,e	
	jr nc,l6ddah
	dec de	
	rst 38h	
	ld hl,(0492bh)
	rrca	
	rra	
	djnz l6de2h
	inc e	
	cpl	
	djnz $+11
	ret pe	
l6d9fh:
	ld h,020h
	ld c,c	
	dec e	
	ld a,020h
	ld c,c	
	ld e,04eh
	jr nz,l6df3h
	rra	
	rst 38h	
	jr l6de6h
	add hl,bc	
	jp pe,3018h
	ld c,b	
	jr nz,l6ddah
	djnz l6dbfh
	call pe,2828h
	add hl,bc	
	xor 028h
	ld c,b	
	ld c,c	
l6dbfh:
	ld hl,l3c2ah+1
	ld b,a	
	inc c	
	rst 38h	
l6dc5h:
	rrca	
	ld c,b	
	add hl,bc	
	ret p	
	rla	
	jr c,l6e15h
	ld (l1027h),hl
	ex af,af'	
	jp p,2e27h
	add hl,bc	
	call p,02b2dh
	ld b,a	
	rlca	
	rst 38h	
l6ddah:
	ld (de),a	
	ccf	
	add hl,bc	
	or 016h
	jr c,$+75
	inc hl	
l6de2h:
	ld h,030h
	add hl,bc	
	ret m	
l6de6h:
	jr z,l6e10h
	ld c,c	
	inc h	
	dec h	
	djnz l6df5h
	jp m,0e2ch
	ld b,a	
	inc c	
	rst 38h	
l6df3h:
	jr nz,l6e05h
l6df5h:
	ld c,b	
	dec h	
	jr nc,l6e09h
	ld c,c	
	ld h,014h
	jr z,$+11
	call m,201ah
	ld c,c	
	daa	
	jr z,l6e25h
l6e05h:
	add hl,bc	
	cp 02dh
	dec hl	
l6e09h:
	ld b,a	
	inc c	
	rst 38h	
	jr nz,$+18
	ld c,b	
	dec h	
l6e10h:
	jr nc,l6e22h
	ld c,c	
l6e13h:
	ld h,014h
l6e15h:
	jr z,l6e20h
	call m,201ah
	ld c,c	
	daa	
	ld hl,(00920h)
	ld h,b	
l6e20h:
	inc sp	
	dec c	
l6e22h:
	ld b,a	
	inc c	
	rst 38h	
l6e25h:
	ld h,010h
	add hl,bc	
	ld h,d	
l6e29h:
	jr nc,$+26
	add hl,bc	
	ld h,h	
	jr nz,l6e5fh
	ex af,af'	
	ld h,(hl)	
	inc l	
	jr c,l6e3dh
	ld l,b	
	rst 38h	
	rla	
	jr z,$+11
	ld l,d	
	rra	
	jr $+75
l6e3dh:
	ret po	
	cpl	
	djnz $+75
	call po,l20fdh+2
	ld de,l6c08h
	rra	
	ld sp,2849h
	ld (04941h),hl
	add hl,hl	
	cpl	
	dec d	
	add hl,bc	
l6e52h:
	ld l,(hl)	
	cpl	
	dec (hl)	
	ld c,c	
l6e56h:
	ld hl,(17ffh)
	ld (l6a09h),hl
	rra	
	ld (de),a	
	ld c,c	
l6e5fh:
	ret po	
	cpl	
	ld a,(bc)	
l6e62h:
	ld c,c	
	call po,0x7dff
	ld l,(hl)	
	sub d	
	ld l,(hl)	
	and e	
	ld l,(hl)	
	sub d	
	ld l,(hl)	
	cp b	
	ld l,(hl)	
l6e6fh:
	call 07d6eh
	ld l,(hl)	
l6e73h:
	jp pe,0ff6eh
	ld l,(hl)	
l6e77h:
	ld a,l	
	ld l,(hl)	
	jr l6eeah
	ld sp,0286fh
	ld c,b	
l6e7fh:
	adc a,(hl)	
	jr nz,l6eabh
	jr nc,l6e13h
l6e84h:
	ld (0382bh),hl
	adc a,(hl)	
l6e88h:
	ld bc,1020h+1
	adc a,a	
l6e8ch:
	inc h	
	ld sp,08f10h
	ld h,0ffh
	jr z,l6edch
l6e94h:
	adc a,(hl)	
	jr z,l6ebfh
	jr nc,l6e29h
	ld hl,(l1027h+1)
	adc a,a	
l6e9dh:
	inc l	
	jr $+18
	adc a,a	
l6ea1h:
	ld (bc),a	
	rst 38h	
	jr z,l6eedh
	adc a,(hl)	
	ld l,028h
	jr c,$-112
	inc bc	
l6eabh:
	dec hl	
	jr nc,l6e3dh
	inc b	
	ld hl,08f10h
	jr nc,$+51
	djnz $-111
	ld (02cffh),a
	ld b,b	
	adc a,(hl)	
	inc (hl)	
	ld h,030h
	adc a,(hl)	
l6ebfh:
	ld (hl),028h
	jr nc,l6e52h
	dec b	
	dec e	
	djnz l6e56h
	jr c,l6ef6h
	djnz $-111
	ld a,(2bffh)
	ld d,b	
	adc a,(hl)	
	ld b,023h
	jr nc,l6e62h
	inc a	
	ld (08e40h),a
	rlca	
	ccf	
	ld b,b	
	adc a,(hl)	
l6edch:
	ex af,af'	
	add hl,hl	
	jr nc,l6e6fh
	ld a,(bc)	
	dec de	
	djnz l6e73h
	ld a,02bh
	djnz l6e77h
	ld b,b	
	rst 38h	
l6eeah:
	add hl,hl	
	ld b,b	
	adc a,(hl)	
l6eedh:
	ld b,d	
	inc h	
	jr nc,l6e7fh
	ld b,h	
	daa	
	jr nc,l6e84h
	add hl,bc	
l6ef6h:
	inc e	
	djnz l6e88h
	ld b,(hl)	
	inc l	
	djnz l6e8ch
	ld c,b	
	rst 38h	
	add hl,hl	
	ld b,b	
	adc a,(hl)	
	ld c,d	
	inc hl	
	jr nc,l6e94h
	ld c,h	
	ld hl,08f10h
	ld c,(hl)	
	add hl,hl	
	jr nz,l6e9dh
	ld d,b	
	add hl,sp	
	jr nc,l6ea1h
	dec bc	
	ld c,c	
	ld sp,0c8fh
	rst 38h	
	dec hl	
	ld b,l	
	adc a,(hl)	
l6f1bh:
	ld d,d	
	inc hl	
	inc sp	
	sub b	
l6f1fh:
	ld d,h	
	inc l	
	ld l,090h
	ld d,(hl)	
l6f24h:
	dec h	
	dec l	
	adc a,a	
	dec c	
	inc l	
	ld c,08fh
	ld e,b	
	inc a	
	dec d	
	adc a,a	
	ld e,d	
	rst 38h	
	dec hl	
	inc a	
	adc a,(hl)	
	ld e,h	
	add hl,hl	
	dec e	
	adc a,a	
	ld e,(hl)	
	dec de	
	inc e	
	ld c,(hl)	
	and (hl)	
	add hl,sp	
	inc c	
	ld c,a	
	xor d	
	ld b,a	
	inc e	
	adc a,a	
	add a,b	
l6f45h:
	dec hl	
l6f46h:
	ld c,h	
	adc a,a	
	rrca	
	add hl,hl	
	dec l	
	adc a,(hl)	
	ld c,0ffh
l6f4eh:
	ld l,b	
	ld l,a	
	ld a,l	
	ld l,a	
l6f52h:
	sub d	
	ld l,a	
	ld a,l	
	ld l,a	
	ei	
	ld l,a	
	inc c	
	ld (hl),b	
	xor 06fh
	dec e	
	ld (hl),b	
	ld (0c070h),a
	ld l,a	
	exx	
	ld l,a	
	sub d	
	ld l,a	
	xor e	
l6f67h:
	ld l,a	
	dec e	
	ld c,b	
	add a,e	
l6f6bh:
	ret pe	
	jr z,l6faeh
	add a,a	
	dec d	
	ld hl,05310h
l6f73h:
	sbc a,h	
	ld sp,09320h
l6f77h:
	sbc a,d	
	ld sp,09410h
	sbc a,h	
l6f7ch:
	rst 38h	
	dec e	
	ld c,b	
	add a,e	
l6f80h:
	ret pe	
	jr z,l6fc3h
	add a,a	
	dec d	
	rra	
	jr nc,l6f1bh
	sbc a,(hl)	
	cpl	
	jr nz,l6f1fh
	and b	
	daa	
	djnz l6f24h
	and d	
	rst 38h	
	dec e	
	ld c,b	
	add a,e	
	ret pe	
	jr z,l6fd8h
	add a,a	
	dec d	
	ld hl,09330h
	and h	
	ld sp,09320h
	and (hl)	
	ld h,010h
	sub h	
	xor b	
	ld (hl),010h
	sub h	
	ld d,0ffh
	add hl,hl	
	ccf	
	add a,a	
l6faeh:
	dec d	
	inc h	
	jr nc,l6f45h
	jr $+53
	ld sp,01793h
	inc h	
	djnz l6f4eh
	xor d	
	inc (hl)	
	djnz l6f52h
	xor h	
	rst 38h	
	inc de	
	jr z,l6f46h
l6fc3h:
	jp (hl)	
l6fc4h:
	ld hl,(08737h)
	dec d	
	jr nz,$+43
	sub e	
	add hl,de	
	jr nc,$+27
	sub e	
	xor (hl)	
	dec h	
	djnz l6f67h
	or b	
	dec (hl)	
	djnz l6f6bh
	ld a,(de)	
l6fd8h:
	rst 38h	
l6fd9h:
	ld hl,(08737h)
	dec d	
	inc h	
	jr z,l6f73h
	dec de	
	inc (hl)	
	jr l6f77h
	or d	
	inc hl	
	djnz l6f7ch
	or h	
	inc sp	
	djnz l6f80h
	or (hl)	
	rst 38h	
	jr z,l701bh
	sub e	
	cp b	
	jr z,$+42
	sub e	
	inc e	
	jr z,$+18
	sub h	
	cp d	
	rst 38h	
	jr z,$+64
	add a,a	
	dec e	
	inc h	
l7000h:
	ld e,093h
	cp h	
	jr z,$+18
	sub h	
	cp (hl)	
	ld sp,0930bh
	ld e,0ffh
	dec hl	
	dec sp	
	add a,a	
	rra	
	ld hl,09328h
	ret nz	
	ld sp,0932bh
	jp nz,01024h
	sub h	
l701bh:
	call nz,26ffh
	dec (hl)	
	add a,a	
	ret po	
	jr nz,l703ch
	sub e	
	add a,030h
	add hl,hl	
	sub e	
	pop hl	
	dec hl	
	inc de	
	sub h	
	ret z	
	dec sp	
	djnz l6fc4h
	jp z,l18ffh
	ld hl,(0e287h)
	jr nz,l704ch
	sub e	
	call z,0312ch
l703ch:
	sub e	
	adc a,02ch
	inc de	
	sub h	
	ret nc	
	inc a	
	djnz l6fd9h
	jp nc,0bbffh
	ld (hl),b	
	xor d	
	ld (hl),b	
	sub l	
l704ch:
	ld (hl),b	
	xor d	
	ld (hl),b	
	ret nc	
	ld (hl),b	
	jp (hl)	
	ld (hl),b	
	ld (bc),a	
	ld (hl),c	
	dec de	
	ld (hl),c	
	cp e	
	ld (hl),c	
	ret nc	
	ld (hl),c	
	push hl	
	ld (hl),c	
	adc a,e	
	ld (hl),c	
	ld (hl),b	
	ld (hl),c	
	ld a,c	
	ld (hl),c	
	add a,d	
	ld (hl),c	
	dec c	
	ld (hl),l	
	ld (de),a	
	ld (hl),l	
	dec de	
	ld (hl),l	
	dec l	
	ld (hl),l	
	add a,d	
	ld (hl),c	
	ld a,c	
	ld (hl),c	
	ld (hl),b	
	ld (hl),c	
	adc a,e	
	ld (hl),c	
	sub h	
	ld (hl),c	
l7077h:
	and c	
	ld (hl),c	
	xor (hl)	
	ld (hl),c	
	inc (hl)	
	ld (hl),c	
	ld c,c	
	ld (hl),c	
	ld d,(hl)	
	ld (hl),c	
	ld h,e	
	ld (hl),c	
	dec c	
	ld (hl),l	
	ld (de),a	
	ld (hl),l	
	dec de	
l7088h:
	ld (hl),l	
	dec l	
	ld (hl),l	
	ld h,e	
l708ch:
	ld (hl),c	
	ld d,(hl)	
	ld (hl),c	
l708fh:
	ld c,c	
	ld (hl),c	
	inc (hl)	
	ld (hl),c	
	cp (hl)	
l7094h:
	ld h,(hl)	
	ld h,038h
	sub 000h
	ld e,020h
	rst 10h	
	jr nz,$+48
	jr nz,l7077h
	ld (101eh),hl
	sub 002h
	ld l,010h
	sub 003h
l70a9h:
	rst 38h	
	ld h,038h
	sub 000h
l70aeh:
	dec e	
	jr nz,l7088h
l70b1h:
	inc h	
	dec l	
	jr nz,l708ch
l70b5h:
	ld h,021h
	djnz l708fh
l70b9h:
	ld bc,26ffh
	jr c,l7094h
	nop	
	ld e,020h
	rst 10h	
	jr nz,l70f2h
	jr nz,$-39
	ld (101eh),hl
	sub 028h
l70cbh:
	ld l,010h
	sub 02ah
	rst 38h	
	inc l	
	jr c,l70a9h
	nop	
	inc h	
	jr nz,l70aeh
	inc l	
	dec hl	
	jr nc,l70b1h
	ld l,034h
	jr nz,l70b5h
	dec b	
l70e0h:
	inc e	
	djnz l70b9h
	ld a,(bc)	
l70e4h:
	inc l	
	djnz $-40
l70e7h:
	rlca	
	rst 38h	
	ld l,038h
l70ebh:
	sub 000h
	inc hl	
	jr nz,$-39
	jr nc,$+49
l70f2h:
	jr nz,l70cbh
	ld (303fh),a
	sub 009h
l70f9h:
	inc e	
	djnz $-40
	ld a,(bc)	
l70fdh:
	inc l	
	djnz $-40
l7100h:
	rlca	
	rst 38h	
	ld l,038h
l7104h:
	sub 000h
	inc hl	
	jr nz,l70e0h
	jr nc,$+49
	jr nz,l70e4h
	inc (hl)	
	ccf	
	jr z,l70e7h
	add hl,bc	
	inc e	
	djnz l70ebh
	ld a,(bc)	
	inc l	
	djnz $-40
	rlca	
	rst 38h	
	ld l,038h
	sub 000h
	inc hl	
	jr nz,l70f9h
	jr nc,$+49
	jr nz,l70fdh
	ld (hl),03fh
	jr nz,l7100h
	inc c	
	inc e	
l712ch:
	djnz l7104h
	ld a,(bc)	
	inc l	
	djnz $-40
	rlca	
	rst 38h	
	jr z,l716eh
	sub 000h
	ld (0d720h),hl
	jr c,l716bh
	ld (14d6h),a
	ld l,022h
	rst 10h	
	dec d	
	ld h,010h
l7146h:
	sub 013h
	rst 38h	
	ld e,028h
	ret c	
	ld a,(0282eh)
l714fh:
	ret c	
	inc a	
	inc h	
	djnz l712ch
	ld a,0ffh
	ld e,028h
	ret c	
	ld b,b	
	ld l,028h
	ret c	
	ld b,d	
	inc h	
	djnz $-38
l7161h:
	ld b,h	
	rst 38h	
	ld e,028h
	ret c	
	ld b,(hl)	
	ld l,028h
	ret c	
	ld c,b	
l716bh:
	inc h	
	djnz l7146h
l716eh:
	ld c,d	
	rst 38h	
	ld (0d830h),hl
	ld d,022h
	djnz l714fh
	ld c,h	
	rst 38h	
	ld (0d830h),hl
	rla	
	ld (0d810h),hl
	ld c,(hl)	
	rst 38h	
	ld (0d830h),hl
	jr l71a9h
	djnz l7161h
	ld d,b	
	rst 38h	
	ld (0d720h),hl
	ld d,d	
	ld (0d610h),hl
	add hl,de	
	rst 38h	
l7194h:
	dec h	
	ld sp,1ad6h
	ld (0d720h),hl
	ld d,d	
	ld (0d610h),hl
	add hl,de	
l71a0h:
	rst 38h	
	daa	
	inc (hl)	
	sub 000h
	ld (0d720h),hl
	ld d,d	
l71a9h:
	ld (0d610h),hl
	add hl,de	
	rst 38h	
l71aeh:
	jr z,$+58
	sub 000h
	ld (0d720h),hl
l71b5h:
	ld d,d	
	ld (0d610h),hl
l71b9h:
	add hl,de	
	rst 38h	
	daa	
	jr c,l7194h
	dec de	
	inc hl	
	jr nz,$-39
	ld d,h	
	inc sp	
	jr nz,$-39
	inc e	
	add hl,hl	
	djnz l71a0h
	dec e	
	ld hl,(0d827h)
	ld e,0ffh
	inc hl	
	jr nc,l71a9h
	rra	
	inc e	
	jr l71aeh
	ld d,(hl)	
	add hl,hl	
	dec d	
	rst 10h	
	ld e,b	
	add hl,sp	
	djnz l71b5h
	ld e,d	
	add hl,sp	
	jr z,l71b9h
	ld h,b	
	rst 38h	
	ld e,027h
	sub 061h
	jr nz,l7201h
	rst 10h	
	ld e,h	
	jr nc,l7202h
	rst 10h	
	ld e,(hl)	
	ld a,010h
	sub 080h
	ld l,030h
	sub 062h
	rst 38h	
l71fah:
	jr c,l726eh
	ld c,l	
	ld (hl),d	
	ld e,d	
	ld (hl),d	
	ld c,l	
l7201h:
	ld (hl),d	
l7202h:
	ld l,e	
	ld (hl),d	
	add a,b	
	ld (hl),d	
	ld l,e	
	ld (hl),d	
	jp 0d872h
	ld (hl),d	
	jp l6b72h
	ld (hl),d	
	ld l,e	
	ld (hl),d	
	sub l	
	ld (hl),d	
	xor d	
	ld (hl),d	
	sub l	
	ld (hl),d	
l7218h:
	ld l,e	
	ld (hl),d	
	sbc hl,sp
	cp 072h
	inc de	
	ld (hl),e	
	cp 072h
	sbc hl,sp
	ld b,(hl)	
l7225h:
	ld (hl),e	
	ld d,a	
	ld (hl),e	
	inc l	
	ld (hl),e	
	add hl,sp	
	ld (hl),e	
	adc a,d	
	ld (hl),e	
	ld l,b	
	ld (hl),e	
	ld (hl),l	
	ld (hl),e	
	sbc a,e	
	ld (hl),e	
	xor h	
	ld (hl),e	
	cp l	
	ld (hl),e	
	ld h,047h
	exx	
	ld l,b	
	inc h	
	jr nc,l7218h
l723fh:
	add a,d	
	inc l	
	daa	
	exx	
l7243h:
	ld l,c	
	jr nz,$+18
	jp c,3084h
	djnz l7225h
	add a,(hl)	
	rst 38h	
	ld h,048h
l724fh:
	exx	
	inc b	
	ld h,028h
	exx	
	adc a,b	
	ld h,010h
	jp c,0ff8ah
	ld h,047h
	exx	
	inc b	
	ld h,027h
l7260h:
	exx	
	adc a,h	
	dec e	
	djnz l723fh
l7265h:
	adc a,(hl)	
	dec l	
	djnz l7243h
l7269h:
	sub b	
	rst 38h	
l726bh:
	dec h	
	ld b,l	
	exx	
l726eh:
	ld b,024h
	ld h,0d9h
	sub d	
	inc (hl)	
	jr nc,l724fh
	sub h	
	ld hl,0da10h
	sub (hl)	
	ld sp,0da10h
l727eh:
	sbc a,b	
	rst 38h	
	dec h	
	ld b,a	
	exx	
	ld b,024h
	jr z,l7260h
	sbc a,d	
	inc h	
	djnz l7265h
	sbc a,(hl)	
	inc (hl)	
	djnz l7269h
	dec bc	
	inc (hl)	
	ld a,(09cd9h)
	rst 38h	
	inc hl	
	ld b,a	
	exx	
	inc b	
	ld (0d927h),hl
	and b	
	ld (0d936h),a
	ld h,a	
	inc e	
	djnz l727eh
	and d	
	inc l	
	ld e,0dah
	and h	
	rst 38h	
	dec e	
	ld c,b	
l72ach:
	exx	
	ld b,01ch
	jr z,$-37
	and (hl)	
	inc l	
	jr z,$-37
	xor b	
	ld a,(0da3ch)
	ld l,d	
	ld c,d	
	inc a	
	jp c,01f6bh
	djnz $-36
	xor d	
	rst 38h	
	dec h	
	ld b,(hl)	
	exx	
	inc b	
	inc h	
	ld h,0d9h
	xor h	
	inc (hl)	
	jr c,$-37
	ld l,h	
	dec h	
	djnz l72ach
l72d2h:
	xor (hl)	
	dec (hl)	
	djnz $-36
l72d6h:
	ld l,l	
	rst 38h	
	jr z,$+73
	exx	
	inc b	
	ld h,027h
	exx	
	or b	
	ld (hl),038h
	exx	
	ld l,(hl)	
	ld hl,0da10h
l72e7h:
	or d	
	ld sp,0da10h
l72ebh:
	or h	
	rst 38h	
	inc e	
	jr nz,$-37
	or (hl)	
	inc l	
	jr nz,$-37
	cp b	
	inc e	
	djnz l72d2h
	ld l,a	
	inc l	
	djnz l72d6h
l72fch:
	ld (hl),b	
	rst 38h	
	ld hl,(0d930h)
	ld (hl),c	
	jr nz,l7320h
l7304h:
	exx	
	cp d	
	jr nc,l7322h
	exx	
	cp h	
	rra	
	djnz l72e7h
	ld (hl),d	
	inc sp	
	djnz l72ebh
	ld (hl),e	
	rst 38h	
	dec h	
	inc l	
	exx	
	ld (hl),h	
	rra	
	djnz $-37
	cp (hl)	
	cpl	
	djnz $-37
	ret nz	
	dec e	
l7320h:
	djnz l72fch
l7322h:
	ld (hl),l	
	dec a	
	djnz $-36
	halt	
	ld c,l	
	djnz l7304h
	ld l,l	
	rst 38h	
	add hl,hl	
	ld d,b	
	exx	
l732fh:
	ld l,b	
	dec h	
	jr nc,$-37
	jp nz,1025h
	jp c,0ffc4h
	jr z,$+70
	exx	
l733ch:
	ld (hl),a	
	ld (0d924h),hl
l7340h:
	add a,024h
	inc d	
	jp c,0ffc8h
	ld h,030h
	exx	
	jp z,332dh
	exx	
	call z,101eh+1
	jp c,02fceh
	djnz l732fh
	ret nc	
	rst 38h	
	ld h,031h
	exx	
l735ah:
	jp nc,2825h
	exx	
l735eh:
	ld a,b	
	dec e	
	djnz l733ch
	ld a,c	
	daa	
	djnz l7340h
l7366h:
	call nc,029ffh
	jr nc,$-37
	sub 019h
	daa	
	exx	
	ret c	
	ld h,010h
	jp c,0ffdah
	inc hl	
	inc sp	
	exx	
	call c,2323h
	exx	
	ld a,d	
	daa	
	djnz l735ah
	sbc a,037h
	djnz l735eh
l7384h:
	ld a,h	
	inc sp	
	ld a,0dah
	ld a,e	
	rst 38h	
	dec hl	
	jr nc,l7366h
	ret po	
	jr nz,$+42
	exx	
	jp po,1025h
	jp c,031e4h
	inc c	
	jp c,0ff7dh
	jr z,$+43
	exx	
	and 023h
	inc hl	
	exx	
	ret pe	
	ld l,010h
	jp c,3eeah
	djnz l7384h
	ld a,(hl)	
	rst 38h	
	dec e	
	dec de	
	exx	
	call pe,1018h
	exx	
	ld a,a	
	jr z,$+18
	exx	
	xor 038h
	ld de,0f0dah
	rst 38h	
	inc h	
	ld a,(l6699h)
l73c1h:
	ld (09928h),hl
	ld l,b	
	ld h,00fh
	sbc a,d	
	ld l,d	
	ld (09a2fh),a
	ld l,(hl)	
	ld b,d	
	cpl	
	sbc a,d	
	ld (hl),b	
	rst 38h	
l73d2h:
	call c,0e173h
	ld (hl),e	
	and 073h
	ex de,hl	
	ld (hl),e	
	call c,02873h
	djnz $-40
	ld h,e	
	rst 38h	
	jr z,l73f3h
	sub 064h
	rst 38h	
	jr z,l73f8h
	sub 065h
	rst 38h	
	jr z,l73fdh
	sub 066h
	rst 38h	
l73f0h:
	nop	
	ld (hl),h	
	dec c	
l73f3h:
	ld (hl),h	
	ld a,(de)	
	ld (hl),h	
	dec c	
	ld (hl),h	
l73f8h:
	daa	
	ld (hl),h	
l73fah:
	jr c,$+118
	ld c,l	
l73fdh:
	ld (hl),h	
	ld a,a	
l73ffh:
	ld (hl),h	
l7400h:
	jr z,l743dh
	dec de	
	add hl,sp	
	daa	
	dec hl	
	inc e	
	ld a,(l1027h+1)
	sbc a,h	
	ld h,b	
	rst 38h	
l740dh:
	jr z,l744bh
	dec de	
	add hl,sp	
	jr z,l743fh
	sbc a,h	
	jp m,l1027h+1
	sbc a,h	
	ld h,d	
	rst 38h	
	jr z,l7458h
	sbc a,e	
	add iy,iy
	inc l	
	sbc a,h	
	cp 027h
	djnz l73c1h
	ld h,h	
	rst 38h	
	rra	
	ld (2f1bh),a
	ld e,01ah
	inc e	
	ld e,(hl)	
	dec h	
	ld c,09ch
	call c,0261eh
	dec e	
	jr nz,$+1
	inc hl	
	ld (381bh),a
	rra	
l743dh:
	ld a,(de)	
	sbc a,h	
l743fh:
	sbc a,025h
	ld c,01ch
	ld e,d	
	inc hl	
	ld l,09dh
	ld sp,hl	
	inc e	
	inc hl	
	dec e	
l744bh:
	ld e,0ffh
	inc hl	
	ld (381bh),a
	rra	
	ld a,(de)	
	sbc a,h	
	sbc a,025h
	ld c,01ch
l7458h:
	ld e,d	
	rla	
	jr nz,l7479h
	inc c	
	daa	
	jr nz,l747dh
	jr l748bh
	dec hl	
	sbc a,l	
	rst 38h	
	rst 38h	
	inc hl	
	jr c,l7484h
	inc hl	
	dec h	
	jr nc,l7489h
	jr nc,l748dh
	djnz l740dh
	ld (hl),h	
	dec h	
	ld b,b	
	add a,b	
	halt	
	dec h	
	jr nc,l73fah
l7479h:
	ld a,b	
	dec hl	
	djnz l73ffh
l747dh:
	ld a,d	
	rst 38h	
	jr z,l7485h
	sbc a,l	
	ld l,h	
	rst 38h	
l7484h:
	dec hl	
l7485h:
	ld a,(bc)	
	ld b,a	
	inc c	
	rst 38h	
l7489h:
	dec hl	
	ld a,(bc)	
l748bh:
	ld c,e	
	inc c	
l748dh:
	rst 38h	
l748eh:
	call z,0d174h
	ld (hl),h	
	sub 074h
	in a,(074h)
	call z,0e074h
	ld (hl),h	
	jp (hl)	
	ld (hl),h	
	jp p,0ff74h
	ld (hl),h	
	inc b	
	ld (hl),l	
	ld h,c	
	ld (hl),l	
	ld l,d	
	ld (hl),l	
	ld (hl),e	
	ld (hl),l	
	dec c	
	ld (hl),l	
	ld (de),a	
	ld (hl),l	
	dec de	
	ld (hl),l	
	jr nz,$+119
	ld b,e	
	ld (hl),l	
	ld c,h	
	ld (hl),l	
	ld b,e	
	ld (hl),l	
	ld a,b	
	ld (hl),l	
	ld a,l	
	ld (hl),l	
	ld (02075h),a
	ld (hl),l	
	dec l	
	ld (hl),l	
	add a,d	
	ld (hl),l	
	add a,a	
	ld (hl),l	
	adc a,h	
	ld (hl),l	
	sub c	
	ld (hl),l	
	sub (hl)	
	ld (hl),l	
	sbc a,e	
	ld (hl),l	
	jr z,l74deh
	ld a,(bc)	
	ld (hl),b	
	rst 38h	
	jr z,l74e3h
	ld c,l	
	dec (hl)	
	rst 38h	
	jr z,l74e8h
	ld c,e	
	ld a,(28ffh)
	djnz $+77
l74deh:
	inc a	
	rst 38h	
	jr nz,l74f2h
	ld c,d	
l74e3h:
	inc l	
	jr nc,$+18
	ld c,d	
	dec l	
l74e8h:
	rst 38h	
	jr nz,l74fbh
	ld c,d	
	ld l,030h
	djnz l753ah
	cpl	
	rst 38h	
l74f2h:
	jr z,$+18
	ld c,e	
	ld (1020h),a
	ld c,d	
	jr nc,l752bh
l74fbh:
	djnz l7547h
	ld sp,28ffh
	djnz $+77
	ld (21ffh),a
	djnz l7552h
	inc sp	
	ld sp,04b10h
	inc (hl)	
	rst 38h	
	jr z,$+18
	inc c	
	ld (hl),d	
	rst 38h	
	jr z,l7524h
	inc c	
	ld (hl),h	
	jr z,$+50
	ld c,h	
	ld (hl),0ffh
	jr z,l752dh
	ld c,h	
	call pe,26ffh
	rla	
	ld c,h	
	ret p	
l7524h:
	ld (hl),02fh
	inc c	
	halt	
	jr z,l7539h
	ld c,h	
l752bh:
	ret pe	
	rst 38h	
l752dh:
	jr z,l753eh
	ld c,h	
	ret pe	
	rst 38h	
	ld h,017h
	ld c,h	
	ret p	
	ld (hl),02fh
	inc c	
l7539h:
	halt	
l753ah:
	ld hl,0c35h
	ld a,b	
l753eh:
	ld sp,0c35h
l7541h:
	ld a,d	
	rst 38h	
	ld h,017h
	ld c,h	
	ret p	
l7547h:
	ld (hl),02fh
	inc c	
	halt	
	rst 38h	
	ld h,017h
	ld c,h	
	ret p	
	ld (hl),02fh
l7552h:
	inc c	
	halt	
	jr c,$+65
	ld c,h	
	scf	
	ld c,b	
	ccf	
	ld c,h	
	jr c,l75b5h
	ccf	
	ld c,h	
	add hl,sp	
	rst 38h	
	jr nz,$+10
	inc c	
	ld a,b	
	jr nc,$+10
	inc c	
	ld a,d	
	rst 38h	
	jr nz,$+10
	inc c	
	ld a,h	
	jr nc,l7578h
	inc c	
l7571h:
	ld a,(hl)	
	rst 38h	
	jr z,l757dh
	inc c	
l7576h:
	ld b,b	
	rst 38h	
l7578h:
	dec hl	
	dec c	
	ld c,e	
	dec sp	
	rst 38h	
l757dh:
	dec hl	
	dec c	
	ld c,e	
	dec a	
	rst 38h	
	inc l	
	ld c,0d8h
	dec c	
	rst 38h	
	inc l	
	ld c,0d8h
	ld c,0ffh
	inc l	
	dec c	
	ret c	
	rrca	
	rst 38h	
	inc l	
	dec c	
	ret c	
	djnz $+1
	jr z,l75a8h
	ret c	
	ld de,28ffh
	djnz l7576h
	ld (de),a	
	rst 38h	
l75a0h:
	inc h	
	add hl,bc	
	ld bc,0ff01h
l75a5h:
	or c	
	ld (hl),l	
	or (hl)	
l75a8h:
	ld (hl),l	
	cp e	
l75aah:
	ld (hl),l	
	or (hl)	
	ld (hl),l	
	or c	
	ld (hl),l	
l75afh:
	cp e	
	ld (hl),l	
	jr z,l75c3h
	add a,e	
	ex (sp),hl	
l75b5h:
	rst 38h	
	jr z,l75c8h
	add a,e	
l75b9h:
	call po,28ffh
	djnz l7541h
	push hl	
	rst 38h	
l75c0h:
	call nc,0d975h
l75c3h:
	ld (hl),l	
	sbc a,075h
	ex (sp),hl	
	ld (hl),l	
l75c8h:
	ret pe	
	ld (hl),l	
	defb 0edh;next byte illegal after ed
	ld (hl),l	
l75cch:
	jp p,l6175h
	ld (hl),l	
	ld l,d	
	ld (hl),l	
	ld (hl),e	
	ld (hl),l	
	jr z,l75e6h
	sub l	
	call nc,28ffh
	djnz l7571h
	and 0ffh
l75deh:
	jr z,l75f0h
	sub l	
	sub 0ffh
	jr z,l75f5h
	sub l	
l75e6h:
	ret c	
	rst 38h	
	jr z,l75edh
	sub l	
l75ebh:
	sub 0ffh
l75edh:
	jr z,l75f2h
	sub l	
l75f0h:
	ret c	
	rst 38h	
l75f2h:
	jr z,l7604h
	sub l	
l75f5h:
	rst 20h	
	rst 38h	
l75f7h:
	ld de,01676h
	halt	
	dec de	
	halt	
	jr nz,$+120
	dec h	
	halt	
	ld hl,(2f76h)
l7604h:
	halt	
	inc (hl)	
	halt	
	dec a	
	halt	
	ld b,(hl)	
	halt	
	ld c,a	
	halt	
	ld e,b	
	halt	
	ld h,c	
	halt	
	jr z,l7623h
	adc a,h	
	ret p	
	rst 38h	
	jr z,l7628h
	adc a,h	
	pop af	
	rst 38h	
	daa	
	djnz l75aah
	jp p,28ffh
	djnz l75afh
l7623h:
	di	
	rst 38h	
	jr z,l7637h
	adc a,h	
l7628h:
	call p,28ffh
	djnz l75b9h
	push af	
	rst 38h	
	jr z,l7641h
	adc a,h	
	or 0ffh
	inc h	
	djnz l75c3h
l7637h:
	ret m	
	ld hl,(08c10h)
	rst 30h	
	rst 38h	
	dec h	
	djnz l75cch
	ret p	
l7641h:
	ld hl,(08c10h)
	rst 30h	
	rst 38h	
	dec h	
	djnz $-114
	pop af	
	ld hl,(08c10h)
	rst 30h	
	rst 38h	
	dec h	
	djnz l75deh
	di	
	ld hl,(08c10h)
	rst 30h	
	rst 38h	
	ld hl,08c10h
	ret m	
	inc l	
	djnz l75ebh
	rst 30h	
	rst 38h	
	jr z,l7673h
	adc a,h	
	ret m	
	rst 38h	
    ; End of data here?
