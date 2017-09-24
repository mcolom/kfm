; z80dasm 1.1.4
; command line: z80dasm -g0 -l roms/a-4e-c.bin

	org	00000h

l0000h:
	di	
l0001h:
	im 1
l0003h:
	ld sp,0f000h
l0006h:
	ld hl,0e000h
	ld de,0e001h
l000ch:
	ld bc,l0fffh
l000fh:
	ld (hl),000h
l0011h:
	ldir
l0013h:
	ld hl,0eb25h
l0016h:
	ld (0eb03h),hl
	in a,(004h)
l001bh:
	bit 7,a
l001dh:
	jp z,07666h
l0020h:
	call sub_058fh
l0023h:
	ld hl,l05cch
	ld de,0ea06h
l0029h:
	ld bc,l0078h
	ldir
	ld hl,(l063fh)
	ld a,l	
	ld l,h	
	ld h,a	
	jr l0082h
l0036h:
	rst 0	
	rst 0	
	ex af,af'	
l0039h:
	exx	
	ld hl,(0eb03h)
	ld de,0c020h
l0040h:
	ld bc,l00c0h
	ldir
	ld a,(0e902h)
	ld (0a000h),a
	ld a,(0e903h)
	ld (0b000h),a
	push iy
	push ix
l0055h:
	jp l008dh
	rst 0	
	rst 0	
l005ah:
	rst 0	
l005bh:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l0060h:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	retn
	ld h,e	
	xor l	
	sbc a,h	
	ld d,d	
	ld (hl),d	
	rst 8	
l006eh:
	add a,a	
	ld b,c	
	ld d,h	
	scf	
l0072h:
	and a	
	ld b,e	
	sub c	
	ld d,c	
	and a	
	ld b,e	
l0078h:
	sub c	
	ld d,c	
	sbc a,a	
	cp b	
	push hl	
l007dh:
	sub 085h
	ld d,(hl)	
l0080h:
	dec (hl)	
	inc hl	
l0082h:
	ld (0e980h),hl
	ld hl,0e917h
	inc (hl)	
	ei	
	jp 0487eh
l008dh:
	ld a,(0e000h)
	and a	
	jp m,l01f8h
	in a,(004h)
	bit 4,a
	jr nz,l00b7h
	ld hl,0e005h
	bit 7,(hl)
	jr nz,l00b7h
	bit 0,(hl)
	in a,(000h)
	jr nz,l00b0h
	and 002h
	jr nz,l00b7h
	set 0,(hl)
	jp l01f0h
l00b0h:
	and 001h
	jp nz,l01f0h
	res 0,(hl)
l00b7h:
	in a,(004h)
	bit 3,a
	jr nz,l00cdh
	ld hl,0e904h
l00c0h:
	bit 1,(hl)
	jr z,l00cdh
	ld hl,0e80eh
	dec (hl)	
	jp p,l01f0h
	ld (hl),008h
l00cdh:
	ld a,(0e000h)
	cp 006h
l00d2h:
	ld a,047h
	jr z,l00d8h
	ld a,r
l00d8h:
	ld hl,0e010h
	add a,(hl)	
l00dch:
	ld (hl),a	
	inc hl	
l00deh:
	add a,(hl)	
	ld (hl),a	
l00e0h:
	ld hl,0e014h
	inc (hl)	
	ld a,(hl)	
	and 003h
	ld d,000h
	ld e,a	
	ld a,(0e000h)
	ld hl,l007dh+1
	cp 006h
	jr z,l0107h
	ld hl,l006eh
	ld a,(0e080h)
	and 038h
	cp 020h
	jr c,l0102h
l0100h:
	ld a,018h
l0102h:
	rrca	
	ld c,a	
	ld b,000h
	add hl,bc	
l0107h:
	add hl,de	
	ld a,(hl)	
	ld hl,0e015h
l010ch:
	add a,(hl)	
	ld (hl),a	
	inc hl	
	add a,(hl)	
l0110h:
	ld (hl),a	
	inc hl	
	add a,(hl)	
	ld (hl),a	
	call sub_0d05h
	call sub_0d48h
l011ah:
	call 0482fh
	call sub_0de5h
l0120h:
	ld a,(0e001h)
	and a	
	jr nz,l012dh
	ld a,(0e913h)
	and a	
	jp nz,l0217h
l012dh:
	call sub_03f8h
	ld a,(0e000h)
	cp 00bh
	jp nc,l01ddh
	ld a,018h
	ld (0eb00h),a
	ld hl,0eb25h
l0140h:
	ld (0eb03h),hl
l0143h:
	ld (0eb01h),hl
	ld a,(0e000h)
	add a,a	
	ld e,a	
l014bh:
	ld d,000h
	ld hl,l0156h
	add hl,de	
	ld e,(hl)	
l0152h:
	inc hl	
	ld d,(hl)	
	ex de,hl	
	jp (hl)	
l0156h:
	call nz,0c401h
	ld bc,l01beh
	ld l,b	
	ld bc,l0168h
	or h	
	ld bc,l0168h
	cp c	
	ld bc,l01beh
l0168h:
	call 0413fh
	call 0402ch
	ld a,(0e080h)
	and 007h
	cp 004h
	jr z,l017fh
	call 040e5h
	call sub_1cb3h
	jr l0185h
l017fh:
	call sub_1cb3h
	call 040e5h
l0185h:
	call 047b6h
	ld a,(0e100h)
l018bh:
	and a	
	jr z,l019ch
	cp 00ah
	jr c,l0197h
	call sub_37deh
	jr l019fh
l0197h:
	call sub_3595h
	jr l019fh
l019ch:
	call sub_12ach
l019fh:
	call sub_2fc7h
	ld a,(0e33fh)
	and a	
	call nz,sub_2ec1h
	call sub_39c0h
	call 02d72h
	call sub_2f06h
	jr l01c4h
	call 04d24h
	jr l01c4h
	call 05436h
	jr l01c4h
l01beh:
	call 04000h
	call 040e5h
l01c4h:
	ld a,(0eb00h)
	and a	
	jr z,l01ddh
	ld b,a	
	ld iy,(0eb01h)
	xor a	
	ld de,l0006h+2
l01d3h:
	ld (iy+004h),a
	ld (iy+005h),a
	add iy,de
	djnz l01d3h
l01ddh:
	ld a,(0e000h)
l01e0h:
	cp 006h
	ld a,037h
	jr z,l01e8h
	ld a,r
l01e8h:
	ld hl,0e012h
	add a,(hl)	
	ld (hl),a	
	inc hl	
	add a,(hl)	
	ld (hl),a	
l01f0h:
	pop ix
	pop iy
	exx	
	ex af,af'	
	ei	
	ret	
l01f8h:
	push af	
	ld a,018h
	ld (0eb00h),a
	ld hl,0eb25h
	ld (0eb03h),hl
	ld (0eb01h),hl
	pop af	
	inc a	
	call nz,07aaeh
	call sub_03f8h
	call sub_0d05h
	call sub_0de5h
	jr l01c4h
l0217h:
	ld sp,0f000h
	ld a,001h
	ld (0e001h),a
	xor a	
l0220h:
	ld (0e000h),a
	ei	
	call 05178h
	ld a,0ffh
	ld (0e006h),a
	ld hl,0e080h
	ld de,0e081h
	ld bc,l001dh+2
	ld (hl),000h
	ldir
	in a,(003h)
	and 001h
	jr nz,l0247h
	ld a,008h
	ld (0e080h),a
	ld (0e090h),a
l0247h:
	call sub_056fh
	ld (0e084h),a
	ld (0e094h),a
sub_0250h:
	ld hl,0e005h
	res 7,(hl)
	xor a	
	ld (0e000h),a
	in a,(004h)
	and 002h
	ld hl,0e910h
	jr z,l026dh
	ld a,(0e002h)
	and 001h
	jr z,l026dh
	set 0,(hl)
	jr l026fh
l026dh:
	res 0,(hl)
l026fh:
	ld hl,0e085h
	bit 1,(hl)
	jr nz,l0285h
	set 1,(hl)
	call 0520dh
	ld a,0e1h
	call 0570fh
l0280h:
	ld a,070h
	call 0570fh
l0285h:
	call sub_1157h
	xor a	
	ld (0e007h),a
	ld (0e008h),a
	call sub_0449h
	ld a,004h
	ld (0e000h),a
	ld a,024h
	call sub_0dfeh
l029ch:
	in a,(004h)
	bit 4,a
l02a0h:
	jr z,l02aeh
	bit 5,a
	jr nz,l02aeh
	ld hl,0e904h
	bit 0,(hl)
	jp nz,l039ch
l02aeh:
	ld a,(0e000h)
	cp 00bh
	jp z,l033ah
	cp 00ch
	jp z,l02c0h
	call sub_0fb8h
	jr l029ch
l02c0h:
	ld a,000h
	call sub_0dfeh
	ld a,022h
	call sub_0dfeh
	ld a,0e1h
	call sub_0582h
	ld a,038h
	call sub_0582h
l02d4h:
	ld a,001h
	call sub_0582h
	ld hl,0e709h
	ld a,(hl)	
	and a	
	jp m,l02eah
	dec (hl)	
	call sub_2f97h
	call sub_055fh
	jr l02d4h
l02eah:
	ld de,l0000h
	push de	
l02eeh:
	ld a,003h
	call sub_0582h
	pop de	
	ld hl,(0e003h)
	ld a,l	
	or h	
	jr z,l031dh
	ld a,e	
	add a,001h
	daa	
	ld e,a	
l0300h:
	sbc hl,de
	add hl,de	
	jr nc,l0307h
	ld e,l	
	ld d,h	
l0307h:
	ld a,l	
	sub e	
	daa	
	ld l,a	
	ld a,h	
	sbc a,d	
	daa	
	ld h,a	
	ld (0e003h),hl
	push de	
	call sub_2f9ah
	ld a,016h
	call sub_0dfeh
	jr l02eeh
l031dh:
	ld a,038h
	call sub_0582h
	ld a,(0e080h)
	and 001h
	call nz,053c2h
	ld a,(0e080h)
	and 007h
	cp 004h
	call z,04fe9h
	call sub_0432h
	call sub_0250h
l033ah:
	ld a,02dh
	call 0570fh
	ld hl,(0e003h)
	ld a,l	
	or h	
	call z,056b5h
	ld hl,0e084h
	dec (hl)	
	jr z,l035dh
	ld a,(0e007h)
	and a	
	jr z,l0360h
	call sub_0dfeh
	ld a,0a9h
	call 0570fh
	jr l0360h
l035dh:
	call 054f4h
l0360h:
	ld hl,0e002h
	bit 1,(hl)
	jr z,l0382h
	ld a,(0e094h)
	and a	
	jr z,l0382h
	ld a,(hl)	
	xor 001h
	ld (hl),a	
l0371h:
	ld b,010h
	ld hl,0e080h
	ld de,0e090h
l0379h:
	ld c,(hl)	
	ld a,(de)	
	ex de,hl	
	ld (hl),c	
	ld (de),a	
	inc hl	
	inc de	
	djnz l0379h
l0382h:
	ld a,(0e084h)
	and a	
	jp nz,sub_0250h
	ld hl,0e910h
	res 0,(hl)
	xor a	
	ld (0e006h),a
	ld a,(0e913h)
	and a	
	jp nz,l0217h
	jp 0487eh
l039ch:
	ld hl,0e005h
	set 7,(hl)
	ld a,000h
	call sub_0dfeh
	xor a	
	ld (0e000h),a
	call sub_1157h
	ld hl,l0000h
	ld (0e902h),hl
	call 0570dh
	ld hl,0595bh
	call sub_111ch
l03bch:
	ld c,014h
	ld de,0d3a7h
	ld a,(0e080h)
	and 0f8h
	rrca	
	rrca	
	rrca	
	call sub_055bh
	ld de,0d427h
	call sub_0556h
l03d2h:
	ld a,(0e906h)
	and 0a0h
	jr nz,l03d2h
l03d9h:
	ld hl,0e904h
	bit 1,(hl)
	jp nz,sub_0250h
	ld hl,0e906h
	bit 7,(hl)
	jr nz,l03eeh
	bit 5,(hl)
	jr nz,l03f3h
	jr l03d9h
l03eeh:
	call sub_041bh
	jr l03bch
l03f3h:
	call sub_0432h
	jr l03bch
sub_03f8h:
	ld hl,0e880h
	dec (hl)	
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l0402h
	dec (hl)	
l0402h:
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l0408h
	dec (hl)	
l0408h:
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l040eh
	dec (hl)	
l040eh:
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l0414h
	dec (hl)	
l0414h:
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l041ah
	dec (hl)	
l041ah:
	ret	
sub_041bh:
	ld hl,0e080h
	dec (hl)	
	ld a,(hl)	
	and 007h
	cp 007h
	ret nz	
	ld a,(hl)	
	and 0f8h
	cp 0f8h
	jr nz,l042eh
	ld a,028h
l042eh:
	or 004h
	ld (hl),a	
	ret	
sub_0432h:
	ld hl,0e080h
	inc (hl)	
	ld a,(hl)	
	and 007h
	cp 005h
	ret nz	
	ld a,(hl)	
	and 0f8h
	add a,008h
	cp 030h
	jr nz,l0447h
	ld a,028h
l0447h:
	ld (hl),a	
	ret	
sub_0449h:
	ld (0e81ch),a
	ld a,001h
	ld (0e000h),a
	call sub_0644h
	ld a,(0e080h)
	and 001h
	ld hl,l0020h+1
	jr nz,l0461h
	ld hl,0bfe0h
l0461h:
	push hl	
	ld (0e817h),hl
	call sub_0e9bh
	xor a	
	ld (0e915h),a
	call 05756h
	ld a,(0e81ch)
	and a	
	call z,sub_04e5h
	ld a,002h
	ld (0e000h),a
	ld a,027h
	call 0570fh
	ld hl,l0006h+1
	ld (0e817h),hl
	ld hl,0e915h
	inc (hl)	
	ld hl,05aa1h
	call sub_04bfh
	ld a,00bh
	call 0570fh
	ld hl,0e915h
	inc (hl)	
	ld hl,05af0h
	call sub_04bfh
	ld a,(0e81ch)
	and a	
	ld hl,l053fh
	call z,sub_111ch
	ld a,054h
	call 0570fh
	pop hl	
	ld (0e817h),hl
	call 05756h
	ld hl,l0000h
	ld (0e014h),hl
	ld (0e016h),hl
	ret	
sub_04bfh:
	ld a,(0e080h)
	and 007h
	ret z	
	and 001h
	jp z,sub_111ch
	call 05756h
	ld a,(0e915h)
	cp 002h
	ret nz	
	ld hl,l04d9h
	jp sub_111ch
l04d9h:
	defb 0fdh,067h,0d6h	;illegal sequence
	cp 092h
	add a,c	
	ld a,a	
	defb 0fdh,0a7h,0d6h	;illegal sequence
	add a,e	
	rst 38h	
sub_04e5h:
	ld hl,l04fdh
	call sub_111ch
	ld a,(0e002h)
	and 001h
	inc a	
	call sub_1108h
	call sub_111ch
	call sub_0556h
	jp sub_111ch
l04fdh:
	defb 0fdh,067h,0d3h	;illegal sequence
	cp 0dbh
	jr nz,l0524h
	jr nz,l0526h
	jr nz,l0528h
	jr nz,l052ah
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	defb 0fdh,0a7h,0d3h	;illegal sequence
	jr nz,$+1
	dec l	
	ld d,b	
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	jr nz,$+1
	dec l	
	ld b,(hl)	
l0524h:
	ld c,h	
	ld c,a	
l0526h:
	ld c,a	
l0527h:
	ld d,d	
l0528h:
	jr nz,l0527h
l052ah:
	rst 20h	
	out (020h),a
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,l0559h
	jr nz,sub_055bh
	jr nz,$+34
	jr nz,$+1
l053fh:
	cp 0dbh
	defb 0fdh,02ch,0d4h	;illegal sequence
	jr nz,$+84
	ld b,l	
	ld b,c	
	ld b,h	
l0549h:
	ld e,c	
	jr nz,l0549h
	ld l,h	
	call nc,02020h
	jr nz,l0572h
	jr nz,l0574h
	jr nz,$+1
sub_0556h:
	ld a,(0e080h)
l0559h:
	and 007h
sub_055bh:
	inc a	
	jp sub_1108h
sub_055fh:
	ld a,(0e883h)
	and a	
	ret nz	
	ld a,003h
	ld (0e883h),a
	ld a,016h
	call sub_0dfeh
	ret	
sub_056fh:
	in a,(003h)
	cpl	
l0572h:
	and 00ch
l0574h:
	rrca	
	rrca	
	add a,002h
	cp 004h
	ret nc	
	inc a	
	cp 003h
	ret z	
	ld a,002h
	ret	
sub_0582h:
	ld (0e882h),a
l0585h:
	call sub_0fe3h
	ld a,(0e882h)
	and a	
	jr nz,l0585h
	ret	
sub_058fh:
	in a,(003h)
	cpl	
	rra	
	rra	
l0594h:
	rra	
	rra	
	ld b,a	
	ld hl,0e90ah
	in a,(004h)
	bit 2,a
	jr nz,l05b1h
	ld a,b	
	inc a	
	and 003h
	ld (hl),a	
	inc hl	
	ld a,b	
	rra	
	rra	
	and 003h
	cp 002h
	sbc a,0f5h
	ld (hl),a	
	ret	
l05b1h:
	ld a,b	
	inc a	
	and 00fh
	cp 007h
	jr c,l05c3h
	cp 009h
	jr c,l05c1h
	cp 00eh
	jr c,l05c3h
l05c1h:
	ld a,001h
l05c3h:
	bit 3,a
	jr z,l05c8h
	inc a	
l05c8h:
	ld (hl),a	
	inc hl	
	ld (hl),a	
	ret	
l05cch:
	nop	
	inc d	
	sub l	
	ld d,h	
	ld b,c	
	ld l,000h
	dec d	
	jr c,l0617h
	ld b,c	
	ld b,c	
	nop	
	dec d	
	ld (hl),d	
	ld c,(hl)	
	ld c,(hl)	
	ld c,c	
	nop	
	ld d,052h
	ld b,c	
	ld b,c	
	ld b,c	
	nop	
	jr l0608h
	ld c,c	
	ld c,e	
	ld c,a	
	nop	
	add hl,de	
	add a,l	
	ld b,c	
	ld c,c	
	ld l,000h
	jr nz,l05fah
	ld b,c	
	ld c,(hl)	
	ld c,a	
	nop	
	ld hl,04d01h
l05fah:
	ld l,04bh
	nop	
	dec h	
	ld d,c	
l05ffh:
	ld c,c	
l0600h:
	ld c,c	
	ld b,c	
	nop	
	dec h	
	ld (hl),b	
	ld c,b	
	ld b,c	
	ld d,h	
l0608h:
	nop	
	ld h,035h
	ld b,c	
	ld l,054h
	nop	
	jr z,$+19
	ld e,c	
	ld b,l	
	ld l,000h
	jr nc,l0638h
l0617h:
	ld d,e	
	ld b,c	
	ld c,c	
	nop	
	dec (hl)	
	ld d,b	
	ld c,c	
	ld c,b	
	ld c,l	
	nop	
	jr c,l0633h
	ld b,c	
	ld c,(hl)	
	ld c,c	
	nop	
	add hl,sp	
	jr l067eh
	ld d,e	
	ld c,c	
	nop	
	add hl,sp	
	ld (hl),l	
	ld b,d	
	ld b,c	
	ld c,b	
	nop	
l0633h:
	ld b,b	
	djnz $+86
	ld l,04bh
l0638h:
	nop	
	ld b,e	
	dec d	
	ld d,e	
	ld d,l	
	ld c,c	
	nop	
l063fh:
	ld c,b	
	ld d,d	
	ld c,(hl)	
	ld l,041h
sub_0644h:
	ld hl,l0080h
	ld (0e902h),hl
	ld hl,0eb25h
	ld de,0eb26h
	ld bc,000bfh
	ld (hl),000h
	ldir
	call sub_074dh
	call sub_06beh
	ld hl,0e380h
	ld de,0e381h
	ld bc,00131h
	ld (hl),000h
	ldir
	call sub_0866h
	ld hl,l0889h+1
	add hl,bc	
	ld a,(hl)	
	ld (0e100h),a
	and a	
	jr z,l0689h
	ld hl,l08b0h
	ld de,0e360h
l067eh:
	ld bc,l0016h+2
	call sub_06b2h
	ld a,001h
	ld (0e380h),a
l0689h:
	ld hl,0e520h
	ld de,0e521h
	ld bc,l0143h
	ld (hl),000h
	ldir
	call sub_0866h
	ld hl,l089eh
	add hl,bc	
	ld a,(hl)	
	and a	
	ret z	
	ld (0e100h),a
	ld hl,00920h
	ld de,0e500h
	ld bc,l0011h
	call sub_06b2h
	jp l3d53h
sub_06b2h:
	add a,a	
	push bc	
	ld c,a	
	add hl,bc	
	pop bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ldir
	ret	
sub_06beh:
	ld hl,0e700h
	ld de,0e701h
	ld bc,l0023h
	ld (hl),000h
	ldir
	ld a,(0e080h)
	and 007h
	add a,a	
	ld c,a	
	ld hl,l0880h
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld (0e003h),hl
	ld a,03fh
	ld (0e709h),a
	ld hl,05000h
	ld (0e710h),hl
	ld a,(0e080h)
	and 001h
	ld (0e101h),a
	jr z,l071dh
	ld hl,0e700h
	ld (hl),020h
	inc hl	
	ld (hl),040h
	ld hl,0ce40h
	ld (0e102h),hl
	ld hl,00900h
	ld (0e712h),hl
	ld hl,l1000h
	ld (0e707h),hl
	ld hl,0cd00h
	ld (0e106h),hl
	ld hl,l02c0h
	ld (0e104h),hl
	ld a,001h
	jp l0749h
l071dh:
	ld a,(0e080h)
	and 007h
	ld hl,010e0h
	cp 004h
	jr nz,l072ch
	ld hl,l1000h
l072ch:
	ld (0e102h),hl
	ld hl,0d560h
	ld (0e712h),hl
	ld hl,0d000h
	ld (0e707h),hl
	ld hl,0dc40h
	ld (0e106h),hl
	ld hl,011c0h
	ld (0e104h),hl
	ld a,0dfh
l0749h:
	ld (0e714h),a
	ret	
sub_074dh:
	ld hl,0e200h
	ld de,0e201h
	ld bc,l0152h
	ld (hl),000h
	ldir
	ld a,(0e080h)
	and 007h
	cp 004h
	jr nz,l0791h
	ld hl,l0600h
	ld (0e342h),hl
	ld hl,00780h
	ld (0e34eh),hl
	ld hl,05000h
	ld (0e344h),hl
	ld (0e350h),hl
	ld a,004h
	ld (0e346h),a
	ld a,007h
	ld (0e352h),a
	ld a,040h
	ld (0e34ch),a
	ld a,050h
	ld (0e340h),a
	ld a,005h
	ld (0e347h),a
l0791h:
	ld ix,0e2d8h
	ld (ix+00ah),03fh
	ld (ix+007h),007h
	ld hl,05000h
	ld (0e2dch),hl
	ld a,(0e080h)
	and 001h
	ld hl,l1500h
	ld de,03100h
	jr z,l07b6h
	ld hl,0cc00h
	ld de,0b000h
l07b6h:
	ld (0e2dah),hl
	ld (0e2d3h),de
	call sub_0866h
	push bc	
	sla c
	push bc	
	push bc	
	ld hl,l09b0h
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld de,0e19ch
	ld bc,l001dh
	ldir
	ld hl,l097fh+1
	pop bc	
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	or h	
	jr z,l07e6h
	ld bc,l0006h+2
	ldir
l07e6h:
	pop bc	
	ld hl,l0be0h
	add hl,bc	
	ld de,0e196h
	ldi
	ldi
	xor a	
	ld (de),a	
	pop bc	
	ld hl,l0b18h
	add hl,bc	
	ld a,(hl)	
	ld (0e1c1h),a
	ld hl,l0c08h
l0800h:
	add hl,bc	
	ld a,(hl)	
	ld (0e199h),a
	ld (0e19ah),a
	ld (0e19bh),a
	ld iy,l0000h
	ld hl,l0c2eh
	add hl,bc	
	add hl,bc	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	add iy,de
	ld ix,0e10ah
	ld de,l0c1ch
	ld b,023h
l0822h:
	call sub_0845h
	inc iy
	djnz l0822h
	ld hl,0e1ffh
	ld (0e108h),hl
	call sub_0866h
	ld d,b	
	ld e,c	
	ld hl,l0b2ch
	add hl,de	
	ex de,hl	
	add hl,hl	
	add hl,hl	
	add hl,hl	
	add hl,de	
	ld de,0e1f0h
	ld c,009h
	ldir
	ret	
sub_0845h:
	ld a,(iy+000h)
	push af	
	rrca	
	rrca	
	rrca	
	rrca	
	call sub_0851h
	pop af	
sub_0851h:
	and 00fh
	add a,a	
	ld h,000h
	ld l,a	
	add hl,de	
	ld a,(hl)	
	ld (ix+000h),a
	inc hl	
	ld a,(hl)	
	ld (ix+001h),a
	inc ix
	inc ix
	ret	
sub_0866h:
	ld a,(0e080h)
	ld l,a	
	and 007h
	ld h,a	
	ld a,l	
	and 038h
	cp 020h
	jr c,l0876h
	ld a,018h
l0876h:
	rrca	
	ld l,a	
	rrca	
	rrca	
	add a,l	
	add a,h	
	ld c,a	
	ld b,000h
	ret	
l0880h:
	nop	
	jr nz,l0883h
l0883h:
	jr nz,l0885h
l0885h:
	jr nz,l0887h
l0887h:
	jr nz,l0889h
l0889h:
	jr nz,l088bh
l088bh:
	ld bc,00200h
	nop	
	nop	
	inc bc	
	nop	
	ld (bc),a	
	nop	
	nop	
	inc b	
	nop	
	ld (bc),a	
	nop	
	nop	
	dec b	
	nop	
	ld (bc),a	
	nop	
l089eh:
	nop	
	nop	
	nop	
	ld a,(bc)	
	nop	
	nop	
	nop	
	nop	
	dec bc	
	nop	
	nop	
	nop	
	nop	
	inc c	
	nop	
	nop	
	nop	
	nop	
l08b0h:
	dec c	
	nop	
	cp h	
	ex af,af'	
	inc e	
	add hl,bc	
	call nc,0ec08h
	ex af,af'	
	inc b	
	add hl,bc	
	nop	
	nop	
	ld (hl),b	
	nop	
	dec c	
	ld d,h	
	xor b	
	ld b,e	
	ld e,d	
	ld (hl),b	
	ld h,(hl)	
	call z,l0000h
	ld (hl),000h
	ld d,0a9h
	or (hl)	
	ld bc,l014bh
	ld a,h	
	nop	
	nop	
	nop	
	ld (hl),b	
	nop	
	dec c	
	ld d,h	
	xor b	
	dec l	
	ld b,e	
	ld e,d	
	ld h,(hl)	
	call z,l0000h
	ld (hl),000h
	ld d,0a9h
	or (hl)	
	ld bc,l014bh
	ld a,h	
	nop	
	nop	
	nop	
	ld (hl),b	
	nop	
	dec c	
	ld d,h	
	xor b	
	inc e	
	jr c,l0939h
	ld h,(hl)	
	call z,l0000h
	ld (hl),000h
	ld d,0a9h
	or (hl)	
	ld bc,l014bh
	ld a,h	
	nop	
	nop	
	nop	
	ld (hl),b	
	nop	
	dec c	
	ld d,h	
	xor b	
	inc e	
	dec l	
	jr c,l0975h
	call z,l0000h
	ld (hl),000h
	ld d,0a9h
	or (hl)	
	ld bc,l014bh
	ld a,h	
	nop	
	nop	
	nop	
	nop	
	ld (hl),000h
	jr nc,l096ch
	nop	
	nop	
	nop	
	ld h,c	
	nop	
	and h	
	nop	
	ld (hl),000h
	ld d,000h
	ld d,d	
	nop	
	ld c,c	
	nop	
	dec l	
	nop	
	inc a	
	add hl,bc	
	ld c,l	
	add hl,bc	
	ld e,(hl)	
l0939h:
	add hl,bc	
	ld l,a	
	add hl,bc	
	jr nz,l093eh
l093eh:
	ld (l2800h),a
	nop	
	inc sp	
	nop	
	inc hl	
	nop	
	ld l,e	
	rlca	
	ld a,a	
	ccf	
	ccf	
	jr c,$+114
	ld (03b00h),a
	nop	
	ccf	
	nop	
	ld d,b	
	nop	
	jr c,l0957h
l0957h:
	ld l,e	
	rlca	
	or d	
	ccf	
	ld h,(hl)	
	jr c,l09ceh
	ld (03b00h),a
	nop	
	ccf	
	nop	
	ld d,b	
	nop	
	jr c,l0968h
l0968h:
	jr c,l096eh
	ld a,a	
	ld h,(hl)	
l096ch:
	ld h,(hl)	
	inc e	
l096eh:
	jr c,l09abh
	nop	
	ld b,h	
	nop	
	ld c,d	
	nop	
l0975h:
	ld e,a	
	nop	
	ld b,h	
	nop	
	jr c,l097fh
	or d	
	ld h,(hl)	
	ld a,a	
	inc e	
l097fh:
	jr c,l0981h
l0981h:
	nop	
	xor b	
	add hl,bc	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	xor b	
	add hl,bc	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	xor b	
	add hl,bc	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	xor b	
	add hl,bc	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	or e	
	rst 38h	
	rlca	
l09abh:
	nop	
	ld l,000h
	rst 10h	
	nop	
l09b0h:
	ret c	
	add hl,bc	
	pop hl	
	add hl,bc	
	rst 28h	
	add hl,bc	
	add iy,bc
	dec bc	
	ld a,(bc)	
	jr z,l09c6h
l09bch:
	ld sp,l3f0ah
	ld a,(bc)	
	ld c,l	
	ld a,(bc)	
	ld e,e	
	ld a,(bc)	
	ld a,b	
	ld a,(bc)	
l09c6h:
	add a,c	
	ld a,(bc)	
	adc a,a	
	ld a,(bc)	
	sbc a,l	
	ld a,(bc)	
	xor e	
	ld a,(bc)	
l09ceh:
	ret z	
	ld a,(bc)	
	pop de	
	ld a,(bc)	
	rst 18h	
	ld a,(bc)	
	defb 0edh;next byte illegal after ed
	ld a,(bc)	
	ei	
	ld a,(bc)	
	sbc a,c	
	push hl	
	ld h,(hl)	
	sbc a,c	
	ld d,h	
	xor b	
	ld hl,00b16h
	ld h,(hl)	
	ld a,a	
	call z,05403h
	xor b	
	dec l	
	ld e,d	
	ld (hl),b	
	ld d,h	
	xor b	
	inc e	
	dec l	
	jr c,l09bch
	push hl	
	xor b	
l09f2h:
	call m,0a854h
	dec l	
	ld e,d	
	ld (hl),b	
	nop	
	nop	
	nop	
	nop	
	ld d,054h
	xor b	
	sbc a,c	
l0a00h:
	or a	
	ld a,a	
	call m,0a970h
	xor c	
	ld d,h	
	ld d,h	
	jr c,l0a7ah
	xor c	
	ld h,(hl)	
	call z,0a854h
	ld d,h	
	xor b	
	dec bc	
	ld d,021h
	ld d,h	
	xor b	
	dec b	
	ex af,af'	
	dec bc	
	inc bc	
	add a,b	
	nop	
	sbc a,c	
	ld a,a	
	ld h,(hl)	
	ld a,a	
	call z,04c66h
	ld a,a	
	sbc a,c	
	ld a,a	
	ld a,a	
	ld c,h	
	ld a,a	
	cp a	
	inc sp	
	ld h,(hl)	
	ld d,h	
	xor b	
	rra	
	dec d	
	dec bc	
	ld c,h	
	ld h,(hl)	
	or d	
	inc bc	
	ld d,h	
	xor b	
	dec l	
	ld e,d	
	ld (hl),b	
	ld d,h	
	xor b	
	inc e	
	dec l	
	jr c,l09f2h
	push hl	
	xor b	
	call m,0a854h
	ld hl,05a38h
	nop	
	nop	
	nop	
	nop	
	djnz l0aa2h
	xor b	
	ld a,a	
	or d	
	ld a,a	
	call m,0a970h
	xor c	
	ld d,h	
	ld d,h	
	inc e	
	jr c,l0acbh
	ld h,(hl)	
	call z,0a854h
	ld d,h	
	xor b	
	dec bc	
	ld d,021h
	ld d,h	
	xor b	
	dec b	
	ex af,af'	
	dec bc	
	inc bc	
	add a,b	
	nop	
	sbc a,c	
	ld a,a	
	ld a,a	
	ld a,a	
	call z,0667fh
	ld a,a	
	sbc a,c	
	ld a,a	
	ld a,a	
	ld a,a	
	ld c,h	
	or d	
l0a7ah:
	inc sp	
	ld h,(hl)	
	ld d,h	
	xor b	
	inc e	
	inc de	
	dec bc	
	inc sp	
	ld a,a	
	call z,05403h
	xor b	
	dec l	
	ld e,d	
	ld (hl),b	
	ld d,h	
	xor b	
	djnz $+30
	dec l	
	sbc a,c	
	push hl	
	ld a,a	
	call m,0a854h
	ld d,02dh
	ld b,e	
	nop	
	nop	
	nop	
	nop	
	dec bc	
	ld d,h	
	xor b	
	ld h,(hl)	
	or d	
	ld a,a	
l0aa2h:
	call m,0a970h
	xor c	
	ld d,h	
	ld d,h	
	inc e	
	jr c,$+114
	ld h,(hl)	
	call z,0a854h
	ld d,h	
	xor b	
	dec bc	
	ld d,021h
	ld d,h	
	xor b	
	dec b	
	ex af,af'	
	dec bc	
	inc bc	
	add a,b	
	nop	
	call z,07fcch
	call z,07fcch
	ld c,h	
	ld a,a	
	call z,0cccch
	ld c,h	
	ld c,h	
	sbc a,c	
	inc sp	
l0acbh:
	ld h,(hl)	
	ld d,h	
	xor b	
	add hl,de	
	inc de	
	dec bc	
	add hl,de	
	ld a,a	
	push hl	
	inc bc	
	ld d,h	
	xor b	
	dec l	
	ld e,d	
	ld (hl),b	
	ld d,h	
	xor b	
	djnz l0afah
	dec l	
	ld a,a	
	call z,0fc54h
	ld d,h	
	xor b	
	ld d,02dh
	ld b,e	
	nop	
	nop	
	nop	
	nop	
	dec bc	
	ld d,h	
	xor b	
	ld d,h	
	xor b	
	ld a,a	
	call m,0a970h
	xor c	
	ld d,h	
	ld d,h	
	inc e	
	inc e	
l0afah:
	ld (hl),b	
	ld h,(hl)	
	call z,0a854h
	ld d,h	
	xor b	
	dec bc	
	ld d,021h
	ld d,h	
	xor b	
	dec b	
	ex af,af'	
	dec bc	
	inc bc	
	add a,b	
	nop	
	push hl	
	call z,0cc7fh
l0b10h:
	push hl	
	sbc a,c	
	ld a,a	
	ld a,a	
	push hl	
	call z,07fcch
l0b18h:
	nop	
	nop	
	ld h,033h
	ld c,h	
	nop	
	add hl,de	
	ld h,033h
	ld c,h	
	nop	
	add hl,de	
	inc sp	
	ld c,h	
	ld h,(hl)	
	nop	
	add hl,de	
	ld c,h	
	ld h,(hl)	
	ld a,a	
l0b2ch:
	inc b	
	ccf	
	ld e,d	
	or h	
	pop hl	
	ld a,(de)	
	ld bc,00049h
	inc b	
	ccf	
	ld e,d	
	or h	
	pop hl	
	ld a,(de)	
	ld bc,00049h
	inc b	
	ld d,l	
	ld e,d	
	or h	
	pop hl	
	ld a,(de)	
	ld bc,00049h
	inc b	
	ld d,l	
	ld e,d	
	or h	
	pop hl	
	ld a,(de)	
	ld bc,00049h
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	ld a,(de)	
	ld bc,00049h
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	pop hl	
	nop	
	ld d,d	
	nop	
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	pop hl	
	nop	
	ld d,d	
	nop	
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	pop hl	
	nop	
	ld d,d	
	nop	
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	pop hl	
	nop	
	ld d,d	
	nop	
	inc b	
	ld h,(hl)	
	ld e,d	
	or h	
	pop hl	
	pop hl	
	nop	
	ld d,d	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
	inc b	
	ld a,a	
	ld e,d	
	or h	
	pop hl	
	xor c	
	nop	
	ld e,e	
	nop	
l0be0h:
	inc bc	
	inc bc	
	inc b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc b	
	dec b	
	inc b	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	inc bc	
	dec b	
	dec b	
	dec b	
	dec b	
l0c08h:
	dec c	
	inc c	
	dec bc	
	ld a,(bc)	
	add hl,bc	
	dec bc	
	ld a,(bc)	
	add hl,bc	
	ex af,af'	
	ex af,af'	
	ld a,(bc)	
	add hl,bc	
	add hl,bc	
	ex af,af'	
	rlca	
	add hl,bc	
	ex af,af'	
	ex af,af'	
	rlca	
	rlca	
l0c1ch:
	add a,b	
	nop	
	nop	
	inc e	
	nop	
	jr c,l0c23h
l0c23h:
	ld (hl),b	
	nop	
	pop hl	
	inc b	
	inc e	
	inc b	
	jr c,l0c2fh
	ld (hl),b	
	inc b	
	pop hl	
l0c2eh:
	ld d,(hl)	
l0c2fh:
	inc c	
	ld a,c	
	inc c	
	sbc a,h	
	inc c	
	cp a	
	inc c	
	jp po,0560ch
	inc c	
	ld a,c	
	inc c	
	sbc a,h	
	inc c	
	cp a	
	inc c	
	jp po,0560ch
	inc c	
	ld a,c	
	inc c	
	sbc a,h	
	inc c	
	cp a	
	inc c	
	jp po,0560ch
	inc c	
	ld a,c	
	inc c	
	sbc a,h	
	inc c	
	cp a	
	inc c	
	jp po,l000ch
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	inc bc	
	nop	
	inc b	
	ld b,d	
	ld b,e	
	ld b,e	
	ld b,d	
	ld b,h	
	inc hl	
	inc (hl)	
	ld b,e	
	ld b,e	
	ld b,e	
	inc sp	
	inc (hl)	
	inc (hl)	
	ld b,e	
	ld b,e	
	inc sp	
	ld b,e	
	inc (hl)	
	ld b,e	
	jr nc,l0c79h
l0c79h:
	nop	
	ld h,c	
	inc bc	
	ld (03000h),hl
	ld (02740h),a
	inc hl	
	nop	
	inc hl	
	ld (de),a	
	ld (hl),e	
	ld (02703h),a
	jr nz,$+117
	ld (l0371h),a
	ld (bc),a	
	ld d,d	
	ld (02175h),a
	ld h,e	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	inc (hl)	
	ld b,l	
	inc de	
	rla	
	rla	
	ld (hl),e	
	ld hl,l2737h
	ld (l3763h),a
	inc (hl)	
	ld (02243h),a
	ld (02342h),a
	inc hl	
	jr nz,l0cbfh
l0cbfh:
	ld bc,00323h
	dec h	
	nop	
	ld (hl),b	
	ld d,031h
	ld b,031h
	nop	
	dec h	
	inc de	
	ld d,h	
	inc hl	
	nop	
	rlca	
	ld (de),a	
	ld h,e	
	ld h,c	
	ld h,c	
	daa	
	ld (de),a	
	ld d,(hl)	
	ld (hl),d	
	ld d,021h
	ld d,d	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	ld b,000h
	inc bc	
	ld sp,02321h
	rla	
	ld h,e	
	ld h,c	
	ld (07225h),a
	ld d,e	
	daa	
	ld (03115h),a
	ld b,021h
	ld (hl),e	
	ld d,013h
	ld d,b	
	nop	
sub_0d05h:
	ld a,(0e910h)
	and 001h
	in a,(001h)
	jr z,l0d10h
	in a,(002h)
l0d10h:
	ld hl,(0e906h)
	call sub_0d3bh
	ld (0e906h),hl
	ld hl,0e908h
	rla	
	rl (hl)
	rla	
	rla	
	rl (hl)
	rla	
	rla	
	rl (hl)
	in a,(000h)
	and 00fh
	ld b,a	
	in a,(002h)
	and 010h
	or b	
	ld hl,(0e904h)
	call sub_0d3bh
	ld (0e904h),hl
	ret	
sub_0d3bh:
	cpl	
	ld b,a	
	xor h	
	ld c,a	
	and l	
	ld l,a	
	ld a,c	
	cpl	
	and h	
	or l	
	ld l,a	
	ld h,b	
	ret	
sub_0d48h:
	rrca	
	rrca	
	rrca	
	ld b,a	
	ld a,(0e911h)
	rla	
	ld c,a	
	and 049h
	cp 049h
	jr nz,l0d61h
	ld hl,0e914h
	inc (hl)	
	ld a,(hl)	
	and 00fh
	call z,sub_0dd6h
l0d61h:
	ld hl,0e90ch
	ld de,0e90ah
	call sub_0db1h
	ld hl,0e90eh
	inc de	
	call sub_0db1h
	ld hl,0e911h
	ld (hl),c	
	dec hl	
	ld c,(hl)	
	dec hl	
	ld b,004h
	call sub_0da2h
	ld hl,0e90dh
	ld b,002h
	call sub_0da2h
	ld a,c	
	ld (0e910h),a
	out (001h),a
	in a,(004h)
	cpl	
	xor c	
	and 001h
	jr z,l0d94h
	inc a	
l0d94h:
	ld (0e916h),a
	ld a,(0e90ah)
	and a	
	ret nz	
	ld a,002h
	ld (0e913h),a
	ret	
sub_0da2h:
	dec (hl)	
	ret p	
	ld (hl),00ch
	dec hl	
	ld a,(hl)	
	and a	
	ret z	
	ld a,b	
	xor c	
	ld c,a	
	and b	
	ret nz	
	dec (hl)	
	ret	
sub_0db1h:
	rrc b
	rl c
	ld a,c	
	and 049h
	cp 001h
	ret nz	
	inc (hl)	
	ld a,(0e006h)
	and a	
	ld a,001h
	call z,sub_0dfeh
	ld a,(de)	
	cp 001h
	jr z,l0ddah
	cp 008h
	jr nc,l0dd8h
	ld hl,0e912h
	inc (hl)	
	cp (hl)	
	ret nz	
	ld (hl),000h
sub_0dd6h:
	ld a,009h
l0dd8h:
	sub 008h
l0ddah:
	ld hl,0e913h
	add a,(hl)	
	daa	
	jr nc,l0de3h
	ld a,099h
l0de3h:
	ld (hl),a	
	ret	
sub_0de5h:
	ld hl,0e917h
	ld a,(hl)	
	and a	
	ret z	
	dec (hl)	
	inc hl	
	ld a,(hl)	
	out (000h),a
	or 080h
	out (000h),a
	inc hl	
	ld de,0e918h
	ld bc,l000fh
	ldir
	ret	
sub_0dfeh:
	push hl	
	push de	
	ld d,a	
	bit 7,d
	jr z,l0e0dh
	ld a,(0e006h)
	and a	
	jr z,l0e1dh
	res 7,d
l0e0dh:
	ld hl,0e917h
	ld a,(hl)	
	cp 010h
	jr nc,l0e1dh
	inc (hl)	
	inc hl	
	ld e,a	
	ld a,d	
	ld d,000h
	add hl,de	
	ld (hl),a	
l0e1dh:
	pop de	
	pop hl	
	ret	
l0e20h:
	push hl	
	ld c,a	
	ld a,(0eb00h)
	ld b,a	
	ld iy,(0eb01h)
	bit 6,c
	ld hl,l0020h
	jr nz,l0e34h
	ld hl,0ffd0h
l0e34h:
	add hl,de	
	ld (0e805h),hl
	pop hl	
	dec b	
	inc b	
	ret z	
l0e3ch:
	ld a,(hl)	
	inc a	
	jr z,l0e92h
	ld a,(0e805h)
	bit 6,c
	jr nz,l0e52h
	add a,(hl)	
	ld (iy+006h),a
	ld a,(0e806h)
	adc a,000h
	jr l0e5bh
l0e52h:
	sub (hl)	
	ld (iy+006h),a
	ld a,(0e806h)
	sbc a,000h
l0e5bh:
	ld (iy+007h),a
	inc hl	
	ld a,(0e916h)
	ld e,a	
	ld a,(hl)	
	sub e	
	ld e,a	
	ld a,(0e807h)
	add a,e	
	ld (iy+002h),a
	ld a,(0e808h)
	adc a,000h
	ld (iy+003h),a
	inc hl	
	ld a,(hl)	
	and 01fh
	ld (iy+000h),a
	ld a,(hl)	
	rlca	
	rlca	
	and 003h
	or c	
	ld (iy+005h),a
	inc hl	
	ld a,(hl)	
	ld (iy+004h),a
	ld de,l0006h+2
	add iy,de
	inc hl	
	djnz l0e3ch
l0e92h:
	ld (0eb01h),iy
	ld a,b	
	ld (0eb00h),a
	ret	
sub_0e9bh:
	ld hl,059a7h
	call sub_111ch
	call sub_10a5h
	call sub_10abh
	call sub_10cfh
	call sub_10d9h
	call sub_10e6h
	ld a,(0e81ch)
	and a	
	call z,sub_0f1ah
	ld a,003h
	ld (0e881h),a
	ld a,(0e709h)
	ld (0e81ah),a
	ld a,(0e2e2h)
	ld (0e819h),a
	call sub_0f78h
	call sub_0f6bh
	ld de,0d0a0h
	ld bc,l0594h
	ld a,0a1h
l0ed6h:
	call sub_1110h
	inc a	
	inc de	
	djnz l0ed6h
	ld a,(0e080h)
	and 007h
	inc a	
	ld h,a	
	ld a,0a6h
	ld de,0d0e0h
	call sub_0f0ah
	inc a	
	ld de,0d120h
	call sub_0f0ah
	ld de,0d0e1h
	ld c,094h
	ld a,0a8h
	call sub_0f01h
	ld de,0d121h
	inc a	
sub_0f01h:
	ld b,004h
l0f03h:
	call sub_1110h
	inc de	
	djnz l0f03h
	ret	
sub_0f0ah:
	ld l,h	
	ld b,005h
	ld c,094h
l0f0fh:
	call sub_1110h
	inc de	
	dec l	
	jr nz,l0f17h
	inc c	
l0f17h:
	djnz l0f0fh
	ret	
sub_0f1ah:
	ld a,(0e080h)
	and 0f8h
	rrca	
	rrca	
	rrca	
	ld b,a	
	in a,(003h)
	and 001h
	jr nz,l0f2ah
	dec b	
l0f2ah:
	ld a,b	
	and a	
	ret z	
	cp 003h
	jr c,l0f33h
	ld a,003h
l0f33h:
	ld b,a	
	ld c,080h
	ld de,0d129h
l0f39h:
	call sub_0f3fh
	djnz l0f39h
	ret	
sub_0f3fh:
	ld a,0b8h
	call sub_0f4fh
	push de	
	ld hl,0003eh
	add hl,de	
	ex de,hl	
	call sub_0f4fh
	pop de	
	ret	
sub_0f4fh:
	call sub_1110h
	inc a	
	call sub_1110h
	inc a	
	ret	
sub_0f58h:
	ld de,0d129h
	xor a	
	ld c,a	
	call sub_0f63h
	ld de,0d169h
sub_0f63h:
	ld b,006h
l0f65h:
	call sub_1110h
	djnz l0f65h
	ret	
sub_0f6bh:
	ld de,0d116h
	ld hl,0e819h
	ld a,(0e2e2h)
	ld c,015h
	jr l0f83h
sub_0f78h:
	ld de,0d096h
	ld hl,0e81ah
	ld a,(0e709h)
	ld c,014h
l0f83h:
	sub (hl)	
	jp m,l0f8fh
	cp 003h
	jr c,l0f95h
	ld a,003h
	jr l0f95h
l0f8fh:
	cp 0fdh
	jr nc,l0f95h
	ld a,0fdh
l0f95h:
	add a,(hl)	
	ld (hl),a	
	ld b,008h
l0f99h:
	sub 008h
	ld l,a	
	jr c,l0fa3h
	jp m,l0fadh
	ld a,08ah
l0fa3h:
	add a,078h
	cp 077h
	jr nz,l0fb1h
	ld a,002h
	jr l0fb1h
l0fadh:
	ld l,0ffh
	ld a,003h
l0fb1h:
	call sub_1110h
	ld a,l	
	djnz l0f99h
	ret	
sub_0fb8h:
	ld a,(0e000h)
	cp 003h
	jr z,sub_0fe3h
	ld hl,(0e003h)
	ld de,0fccdh
	add hl,de	
	jr c,sub_0fe3h
	ld hl,0e008h
	ld a,(hl)	
	and a	
	jr nz,l0fd5h
	ld a,000h
	call sub_0dfeh
	inc (hl)	
l0fd5h:
	ld hl,0e885h
	ld a,(hl)	
	and a	
	jr nz,sub_0fe3h
	ld (hl),038h
	ld a,097h
	call sub_0dfeh
sub_0fe3h:
	ld hl,0e81bh
	ld a,(0e880h)
	cp (hl)	
	jr z,l103ah
	ld (hl),a	
	call sub_0f78h
	call sub_0f6bh
	ld hl,0d0e0h
	ld a,(0e080h)
	and 007h
	add a,a	
	ld e,a	
	ld d,000h
l0fffh:
	add hl,de	
l1000h:
	ld a,(0e880h)
	set 3,h
	ld a,(0e880h)
	and 018h
	ld a,095h
	jr z,l100fh
	dec a	
l100fh:
	ld (hl),a	
	ld de,l0040h
	add hl,de	
	ld (hl),a	
	ld a,(0e81ch)
	and a	
	jr nz,l105ah
	ld b,a	
	in a,(003h)
	and 001h
	ld a,(0e080h)
	jr nz,l1027h
	sub 008h
l1027h:
	cp 020h
	jr c,l103ah
	ld a,(0e880h)
	and 018h
	jr z,l1037h
	call sub_0f1ah
	jr l103ah
l1037h:
	call sub_0f58h
l103ah:
	ld a,(0e085h)
	and 001h
	jr nz,l105ah
	ld hl,(0e081h)
	ld de,05000h
	sbc hl,de
	jr c,l105ah
	ld hl,0e085h
	set 0,(hl)
	dec hl	
	inc (hl)	
	ld a,098h
	call sub_0dfeh
	call sub_10e6h
l105ah:
	ld a,(0e000h)
	cp 003h
	jr z,l1080h
	cp 00ch
	jr z,l1080h
	ld hl,0e881h
	ld a,(hl)	
	and a	
	jr nz,l1080h
	ld (hl),003h
	ld hl,(0e003h)
	ld a,l	
	sub 001h
	daa	
	ld l,a	
	ld a,h	
	sbc a,000h
	daa	
	ld h,a	
	jr c,l1080h
	ld (0e003h),hl
l1080h:
	call sub_10d9h
	ld a,(0e083h)
	ld c,a	
	ld de,(0e081h)
	ld a,(0e982h)
	ld hl,(0e980h)
	sub c	
	jr c,l109ah
	jr nz,sub_10a5h
	sbc hl,de
	jr nc,sub_10a5h
l109ah:
	ld a,c	
	ld (0e982h),a
	ld (0e980h),de
	call sub_10cfh
sub_10a5h:
	xor a	
	ld de,0e083h
	jr l10b0h
sub_10abh:
	ld a,001h
	ld de,0e093h
l10b0h:
	ld hl,0e002h
	xor (hl)	
	ex de,hl	
	and 001h
	ld de,0d029h
	jr nz,l10bfh
	ld de,0d014h
l10bfh:
	ld c,015h
l10c1h:
	ld a,(hl)	
	dec hl	
	call sub_1108h
	call sub_10fdh
	call sub_10fdh
	xor a	
	jr sub_1108h
sub_10cfh:
	ld hl,0e982h
	ld de,0d01fh
	ld c,000h
	jr l10c1h
sub_10d9h:
	ld c,014h
	ld hl,0e004h
	ld de,0d0eah
	call sub_10fdh
	jr sub_10fdh
sub_10e6h:
	ld a,(0e084h)
	ld de,0d162h
	ld l,a	
	ld b,007h
	ld c,003h
	ld a,0feh
l10f3h:
	dec l	
	jr nz,l10f7h
	xor a	
l10f7h:
	call sub_1110h
	djnz l10f3h
	ret	
sub_10fdh:
	ld a,(hl)	
	dec hl	
	push af	
l1100h:
	rrca	
	rrca	
	rrca	
	rrca	
	call sub_1108h
	pop af	
sub_1108h:
	and 00fh
	add a,090h
	daa	
	adc a,040h
	daa	
sub_1110h:
	ex de,hl	
	ld (hl),a	
	set 3,h
	ld (hl),c	
	res 3,h
	inc hl	
	ex de,hl	
	ret	
l111ah:
	ld c,(hl)	
l111bh:
	inc hl	
sub_111ch:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	jr z,l111ah
	inc a	
	jr z,l112dh
	sub 003h
	call sub_1110h
	jr sub_111ch
l112dh:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	jr l111bh
l1132h:
	ld c,(hl)	
l1133h:
	inc hl	
l1134h:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	jr z,l1132h
	inc a	
	jr z,l114eh
	sub 003h
	call sub_1110h
	cp 020h
	jr nz,l1134h
	ld a,00bh
	call 0570fh
	jr l1134h
l114eh:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	jr l1133h
	ld d,001h
	jr l1159h
sub_1157h:
	ld d,0dbh
l1159h:
	ld e,020h
	ld bc,l0800h
	ld hl,0d000h
	ld iy,0d800h
l1165h:
	ld (hl),e	
	ld (iy+000h),d
	inc hl	
	inc iy
	dec bc	
	ld a,b	
	or c	
	jr nz,l1165h
	ret	
sub_1172h:
	xor a	
	add hl,hl	
	rla	
	ld l,h	
	ld h,a	
	push de	
	ld de,l000fh+1
	add hl,de	
	pop de	
	ld (0e815h),hl
	add hl,de	
	ld (0e813h),hl
	ld a,(0e706h)
	add a,a	
	ld e,a	
	ld d,000h
	ld hl,0664dh
	add hl,de	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	ld iy,l0000h
	add iy,de
l1198h:
	ld hl,(0e717h)
	ld a,(iy+000h)
	cp 0ffh
	ret z	
	ld e,a	
	ld d,000h
	add hl,de	
	ld de,(0e813h)
	sbc hl,de
	jr nc,l1201h
	ld hl,(0e717h)
	ld e,(iy+001h)
	ld d,000h
	add hl,de	
	ld de,(0e815h)
	sbc hl,de
	jr c,l1201h
	ld hl,(0e712h)
	ld a,(0e701h)
	and 040h
	jr z,l11d2h
	ld e,(iy+004h)
	ld d,(iy+005h)
	sbc hl,de
	jr l11d9h
l11d2h:
	ld e,(iy+002h)
	ld d,(iy+003h)
	add hl,de	
l11d9h:
	and a	
	ld de,(0e80fh)
	sbc hl,de
	jr c,l1201h
	ld hl,(0e712h)
	and a	
	jr z,l11f2h
	ld e,(iy+002h)
	ld d,(iy+003h)
	sbc hl,de
	jr l11f9h
l11f2h:
	ld e,(iy+004h)
	ld d,(iy+005h)
	add hl,de	
l11f9h:
	and a	
	ld de,(0e811h)
	sbc hl,de
l1200h:
	ret c	
l1201h:
	ld de,l0006h
	add iy,de
	jr l1198h
sub_1208h:
	ld a,(0e000h)
	cp 006h
	ret z	
	in a,(004h)
	cpl	
	bit 6,a
	ret	
sub_1214h:
	cp (hl)	
	jr c,l121ch
	inc hl	
	cp (hl)	
	jr c,l121ch
	inc hl	
l121ch:
	inc hl	
	inc hl	
	ld a,(hl)	
	ret	
sub_1220h:
	ld (0e805h),hl
	ld a,(0e706h)
	ld hl,l126eh
	ld d,000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
	and a	
	ret z	
	ld iy,l1290h
	add a,a	
	add a,a	
	ld e,a	
	add iy,de
	ld hl,(0e710h)
	ld e,(iy+002h)
	ld d,(iy+003h)
	add hl,de	
	push hl	
	ld e,(iy+000h)
	ld d,(iy+001h)
	ld hl,(0e712h)
	ld a,(0e701h)
	and 040h
	jr z,l1257h
	add hl,de	
	jr l1259h
l1257h:
	sbc hl,de
l1259h:
	ld e,(ix+002h)
	ld d,(ix+003h)
	sbc hl,de
	ld de,(0e805h)
	jr c,l126bh
	sbc hl,de
	jr l126ch
l126bh:
	add hl,de	
l126ch:
	pop de	
	ret	
l126eh:
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	inc b	
	nop	
	ld bc,l0001h
	inc bc	
	nop	
	ld (bc),a	
	ld (bc),a	
	nop	
	nop	
	nop	
	nop	
	nop	
	ld bc,l0100h+1
	dec b	
	dec b	
	nop	
	ld b,000h
	nop	
	nop	
	nop	
	nop	
	nop	
l1290h:
	nop	
	nop	
	nop	
	nop	
	nop	
	ld (bc),a	
	add a,b	
	jr l1299h
l1299h:
	ld (bc),a	
	add a,b	
	inc de	
	add a,b	
	inc bc	
	nop	
	inc b	
	add a,b	
	inc bc	
	add a,b	
	jr $-94
	ld (bc),a	
	nop	
	jr l12c9h
	inc bc	
	add a,b	
	rrca	
sub_12ach:
	ld hl,0e700h
	bit 1,(hl)
	jr nz,l12c5h
	ld hl,0e200h
	call sub_12cbh
	call sub_12feh
	call sub_138fh
	call sub_13eeh
	call sub_143fh
l12c5h:
	call sub_153dh
	ret	
l12c9h:
	inc hl	
l12cah:
	inc hl	
sub_12cbh:
	ld a,(hl)	
	and a	
	ret z	
	dec (hl)	
	jp nz,l12c9h
	inc hl	
	ld c,(hl)	
	ld b,000h
	ex de,hl	
	ld hl,0e10ah
	add hl,bc	
	add hl,bc	
	res 7,(hl)
	ld hl,(0e108h)
	ldd
	ldd
	ld (0e108h),hl
	inc hl	
	ld (hl),000h
	ex de,hl	
	jp l12cah
l12efh:
	nop	
	nop	
	nop	
	ld bc,l0100h+1
	ld (bc),a	
	ld (bc),a	
	ld (bc),a	
	inc bc	
	inc bc	
	inc bc	
	inc b	
	inc b	
	inc b	
sub_12feh:
	ld a,(0e701h)
	and 080h
	ld c,0e4h
	jr z,l1309h
	ld c,01ch
l1309h:
	ld a,(0e713h)
	add a,c	
	cp 0e0h
	ret nc	
	ld (0e809h),a
	ld e,a	
	and 00fh
	dec a	
	ret m	
	ld hl,l12efh
	ld b,000h
	ld c,a	
	add hl,bc	
	ld c,(hl)	
	ld a,e	
	and 0f0h
	rrca	
	rrca	
	ld e,a	
	rrca	
	rrca	
	add a,e	
	add a,c	
	ld c,a	
	ld ix,0e10ah
	add ix,bc
	add ix,bc
	bit 7,(ix+000h)
	ret nz	
	ld hl,(0e108h)
	ld de,0e213h
	sbc hl,de
	ret z	
	ld b,a	
	ld a,(0e701h)
	and 080h
	ld hl,0e235h
	ld de,0e19ah
	jr z,l1353h
	ld hl,0e215h
	inc de	
l1353h:
	ld a,(hl)	
	and a	
	ret nz	
	inc hl	
	ld a,(hl)	
	cp 00ah
	ret nc	
	push hl	
	push de	
	inc (hl)	
	inc hl	
	ld e,a	
	add a,a	
	add a,e	
	ld d,000h
	ld e,a	
	add hl,de	
	ld (hl),d	
	inc hl	
	ld a,(0e809h)
	ld (hl),a	
	inc hl	
	ld a,(ix+000h)
	ld (hl),a	
	ld a,(ix+001h)
	ld hl,(0e108h)
	inc hl	
	ld (hl),a	
	inc hl	
	ld (hl),c	
	ld (0e108h),hl
	set 7,(ix+000h)
	pop hl	
	pop de	
	dec (hl)	
	ret nz	
	ld a,(0e199h)
	ld (hl),a	
	ex de,hl	
	dec hl	
	ld (hl),001h
	ret	
sub_138fh:
	ld hl,0e236h
	ld a,(hl)	
	and a	
	ret z	
	ld b,a	
	ld d,000h
	inc hl	
l1399h:
	ld a,(hl)	
	add a,036h
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	adc a,d	
	jp nc,l13a4h
	dec a	
l13a4h:
	ld (hl),a	
	inc hl	
	inc hl	
	djnz l1399h
	ld hl,(0e237h)
	ld a,h	
	cp 0beh
	jr nc,l13bch
	ld bc,l1200h
	add hl,bc	
	ld bc,(0e712h)
	sbc hl,bc
	ret c	
l13bch:
	ld hl,0e255h
	ld a,(hl)	
	cp 00ah
	ret nc	
	inc (hl)	
	ld e,a	
	ld hl,0e256h
	add hl,de	
	ld a,(0e239h)
	or 058h
	ld (hl),a	
	ex de,hl	
	ld hl,0e236h
	dec (hl)	
	jr z,l13e6h
	ld a,(hl)	
	ld de,0e237h
	ld hl,0e23ah
l13ddh:
	ld c,a	
	add a,a	
	add a,c	
	ld c,a	
	ld b,000h
	ldir
	ret	
l13e6h:
	dec hl	
	ld a,(hl)	
	and a	
	ret z	
	ex de,hl	
	set 0,(hl)
	ret	
sub_13eeh:
	ld hl,0e216h
	ld a,(hl)	
	and a	
	ret z	
	ld b,a	
	ld d,000h
	inc hl	
l13f8h:
	ld a,(hl)	
	sub 036h
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	sbc a,d	
	jp nc,l1403h
	inc a	
l1403h:
	ld (hl),a	
	inc hl	
	inc hl	
	djnz l13f8h
	ld hl,(0e217h)
	ld a,h	
	cp 022h
	jr c,l141ch
	ld bc,l1200h
	sbc hl,bc
	ld bc,(0e712h)
	sbc hl,bc
	ret nc	
l141ch:
	ld hl,0e255h
	ld a,(hl)	
	cp 00ah
	ret nc	
	inc (hl)	
	ld e,a	
	ld hl,0e256h
	add hl,de	
	ld a,(0e219h)
	or 030h
	ld (hl),a	
	ex de,hl	
	ld hl,0e216h
	dec (hl)	
	jr z,l13e6h
	ld a,(hl)	
	ld de,0e217h
	ld hl,0e21ah
	jr l13ddh
sub_143fh:
	ld a,(0e260h)
	ld b,a	
	xor 028h
	ret z	
	ld a,(0e2d8h)
	and 010h
	ld a,(0e196h)
	jr z,l1453h
	ld a,(0e197h)
l1453h:
	and a	
	jr z,l145ch
	ld c,a	
	ld a,(0e261h)
	cp c	
	ret nc	
l145ch:
	ld hl,0e255h
	ld a,(hl)	
	and a	
	ret z	
	ld c,a	
	inc hl	
	bit 6,(hl)
	jr nz,l1475h
	bit 5,b
	jr z,l14bfh
l146ch:
	dec c	
	ret z	
	inc hl	
	bit 6,(hl)
	jr z,l146ch
	jr l1479h
l1475h:
	bit 3,b
	jr nz,l14b8h
l1479h:
	call sub_1524h
	push af	
	ld hl,(0e712h)
	ld de,l1200h
	sbc hl,de
	ld de,0be00h
	sbc hl,de
	jr nc,l148eh
	add hl,de	
	ex de,hl	
l148eh:
	ld a,(0e2d8h)
	ld l,a	
	bit 4,l
	jr z,l14b1h
	ld a,(0e197h)
	and a	
	jr z,l14a7h
	bit 6,l
	jr z,l14b1h
	ld hl,(0e2dah)
	sbc hl,de
	jr c,l14b1h
l14a7h:
	ld hl,0e235h
l14aah:
	pop af	
	and 001h
	ret z	
	ld (hl),000h
	ret	
l14b1h:
	ld hl,0e260h
	set 3,(hl)
	jr l14f6h
l14b8h:
	dec c	
	ret z	
	inc hl	
	bit 6,(hl)
	jr nz,l14b8h
l14bfh:
	call sub_1524h
	push af	
	ld hl,(0e712h)
	ld de,l1200h
	add hl,de	
	ld de,l2200h
	sbc hl,de
	jr c,l14d3h
	add hl,de	
	ex de,hl	
l14d3h:
	ld a,(0e2d8h)
	ld l,a	
	bit 4,l
	jr z,l14f1h
	ld a,(0e197h)
	and a	
	jr z,l14ech
	bit 6,l
	jr nz,l14f1h
	ld hl,(0e2dah)
	sbc hl,de
	jr nc,l14f1h
l14ech:
	ld hl,0e215h
	jr l14aah
l14f1h:
	ld hl,0e260h
	set 5,(hl)
l14f6h:
	ld hl,0e261h
	inc (hl)	
	inc hl	
	ld bc,l000fh+1
l14feh:
	ld a,(hl)	
	and a	
l1500h:
	jr z,l1505h
	add hl,bc	
	jr l14feh
l1505h:
	pop af	
	ld (hl),a	
	xor a	
	inc hl	
	ld (hl),000h
	inc hl	
	ld (hl),e	
	inc hl	
	ld (hl),d	
	inc hl	
	ld (hl),000h
	inc hl	
	ld (hl),050h
	inc hl	
	ld (hl),a	
	inc hl	
	ld (hl),007h
	inc hl	
	ld (hl),a	
	inc hl	
	ld (hl),a	
	inc hl	
	ld (hl),002h
	inc hl	
	ld (hl),a	
	ret	
sub_1524h:
	ld a,(hl)	
	dec c	
	jr z,l152fh
	ld d,h	
	ld e,l	
	inc hl	
	ld b,000h
	ldir
l152fh:
	ld hl,0e255h
	dec (hl)	
	ret	
l1534h:
	pop bc	
	ld de,l000fh+1
	add ix,de
	djnz l1556h
	ret	
sub_153dh:
	ld a,(0e701h)
	and 003h
	jr nz,l1547h
	ld (0e2d2h),a
l1547h:
	ld hl,l0100h+1
	ld (0e71bh),hl
	ld (0e71dh),hl
	ld ix,0e262h
	ld b,005h
l1556h:
	push bc	
	ld hl,l1534h
	push hl	
	ld c,(ix+000h)
	bit 4,c
	ret z	
	bit 5,c
	call nz,sub_1c26h
	bit 3,c
	call nz,sub_1c3dh
	bit 0,c
	ld a,(ix+001h)
	jp nz,l186eh
	bit 2,c
	jp nz,l168ah
	ld hl,l162fh
	push hl	
	ld hl,0e700h
	bit 1,(hl)
	jp nz,l1be2h
	cp 001h
	jp z,l1baah
	jr c,l15d2h
	cp 009h
	jp z,l15ddh
	jr nc,l15a8h
l1592h:
	call sub_1befh
	ld de,0ef00h
	add hl,de	
	ret nc	
	call sub_1b7ah
	ld a,c	
	and 028h
	cpl	
	ld hl,0e260h
	and (hl)	
	ld (hl),a	
	pop hl	
	ret	
l15a8h:
	call sub_1be7h
	ld a,(ix+006h)
	cp 00ah
	jr nc,l15b6h
	ld (ix+006h),00dh
l15b6h:
	call sub_163eh
	ret c	
	ld de,0ff00h
	ld hl,(0e80ch)
	add hl,de	
	jp nc,l1b20h
	ret	
l15c5h:
	ld a,00ah
	add a,(ix+006h)
	ld (ix+006h),a
	ld (ix+001h),00ah
	ret	
l15d2h:
	call sub_1be7h
	ld de,0f800h
	add hl,de	
	jp nc,l15c5h
	ret	
l15ddh:
	call sub_1b54h
	call sub_1c61h
	cp (ix+00fh)
	jr z,l15f2h
	dec (ix+00bh)
	jr z,l1626h
	ld (ix+00fh),a
	jr l15fbh
l15f2h:
	dec (ix+00eh)
	jr nz,l15ffh
	ld (ix+00bh),006h
l15fbh:
	ld (ix+00eh),005h
l15ffh:
	dec (ix+007h)
	ret nz	
	ld a,(0e81ch)
	and a	
	ld a,002h
	jr nz,l1615h
	in a,(003h)
	and 002h
	ld a,004h
	jr nz,l1615h
	ld a,003h
l1615h:
	ld (ix+007h),a
	ld hl,0e709h
	ld a,(hl)	
	and a	
	ret m	
	dec (hl)	
	ret p	
	ld hl,0e71fh
	set 1,(hl)
	ret	
l1626h:
	ld hl,0e71ah
	dec (hl)	
	ld a,009h
	jp l1b90h
l162fh:
	ld hl,06a7bh
l1632h:
	ld a,(ix+001h)
	cp 005h
	jp nz,l1a7dh
	ld a,c	
	jp l1a80h
sub_163eh:
	ld de,l1680h
	call sub_1ad2h
	ret nc	
	push af	
	ld a,091h
	call sub_0dfeh
	pop af	
	jp m,l1653h
	ld a,080h
	jr l1677h
l1653h:
	ld hl,0e2d2h
	inc (hl)	
	call sub_1ac9h
	ld a,(hl)	
	jr nz,l166bh
	cp 002h
	ld a,080h
	jr c,l1677h
	ld a,082h
	jr z,l1677h
	ld a,085h
	jr l1677h
l166bh:
	cp 002h
	ld a,08ch
	jr c,l1677h
	ld a,080h
	jr z,l1677h
	ld a,082h
l1677h:
	ld hl,l00d2h
l167ah:
	ex de,hl	
	call sub_2f60h
	scf	
	ret	
l1680h:
	jp p,0f2f0h
	jp p,002f2h
	ld bc,0ffffh
	rst 38h	
l168ah:
	ld hl,l1822h
	push hl	
	ld hl,0e700h
	bit 1,(hl)
	jp nz,l1be2h
	cp 009h
	jp z,l15ddh
	jp nc,l170bh
	cp 001h
	jp z,l1baah
	jp nc,l1592h
	call sub_1be7h
	call sub_1828h
	ret c	
	ld hl,(0e80ch)
	ld de,0e100h
	add hl,de	
	jp c,sub_1b7ah
	bit 0,(ix+00bh)
	jr nz,l16e3h
	ld hl,(0e80ch)
	ld de,0fa00h
	add hl,de	
	jr c,l16e3h
	set 0,(ix+00bh)
	ld a,(0e702h)
	cp 003h
	jr z,l16d9h
	cp 006h
	jr z,l16d9h
	cp 007h
	jr nz,l16e3h
l16d9h:
	ld a,(0e013h)
	ld hl,0e1c1h
	cp (hl)	
	jp c,l17e5h
l16e3h:
	ld hl,(0e710h)
	ld de,0a180h
	add hl,de	
	ret c	
	ld hl,(0e80ah)
	ld de,l00c0h
	bit 6,c
	jr z,l16f8h
	add hl,de	
	jr l16fah
l16f8h:
	sbc hl,de
l16fah:
	jp c,l1b20h
	ret	
l16feh:
	ld (ix+001h),000h
	ld (ix+006h),000h
	ld (ix+007h),007h
	ret	
l170bh:
	ld e,(ix+00eh)
	ld d,(ix+00fh)
	ld a,(ix+006h)
	cp 00ah
	push af	
	call nz,sub_1c70h
	call l1be2h
	pop af	
	jr z,l173dh
	ld de,0ffd6h
	call sub_1cach
	add hl,de	
	call sub_1ca5h
	ex de,hl	
	call sub_1c9eh
	add hl,de	
	ld de,05000h
	sbc hl,de
	add hl,de	
	jr nc,l1738h
	ex de,hl	
l1738h:
	call sub_1c97h
	jr c,l16feh
l173dh:
	bit 1,(ix+00bh)
	jr nz,l175fh
	call sub_1c8ah
	ld de,0ff60h
	add hl,de	
	ld (0e80fh),hl
	ld de,l0140h
	add hl,de	
	ld (0e811h),hl
	call sub_1c9eh
	ld de,l0013h+1
	call sub_1172h
	jr c,l1787h
l175fh:
	dec (ix+007h)
	jr nz,l177ch
	ld a,(ix+00ah)
	inc a	
l1768h:
	ld (ix+00ah),a
	add a,a	
	ld e,a	
	ld d,000h
	ld hl,l17fch
	add hl,de	
	ld a,(hl)	
	ld (ix+007h),a
	inc hl	
	ld a,(hl)	
	ld (ix+006h),a
l177ch:
	ld a,(ix+006h)
	cp 00fh
	ret c	
	ld a,c	
	xor 0c0h
	ld c,a	
	ret	
l1787h:
	ld a,(0e702h)
	cp 003h
	jr z,l1796h
	cp 006h
	jr z,l1796h
	cp 007h
	jr nz,l17bah
l1796h:
	call sub_1c9eh
	ld de,l010ch
	ld a,091h
	call sub_0dfeh
	call sub_2ee2h
	ld a,007h
	push af	
	call sub_1cach
	ex de,hl	
	ld hl,l0000h
	sbc hl,de
	call sub_1ca5h
	set 1,(ix+00bh)
	pop af	
	jr l1768h
l17bah:
	ld (ix+006h),009h
	call sub_1c9eh
	ld de,l0a00h
	add hl,de	
	xor a	
	add hl,hl	
	rlca	
	ld l,h	
	ld h,a	
	ex de,hl	
	call sub_1c8ah
	call sub_1ac9h
	ld a,080h
	jr nz,l17d7h
	ld a,082h
l17d7h:
	call sub_2f60h
	ld a,091h
	call sub_0dfeh
	ld hl,01c5bh
	jp l1b96h
l17e5h:
	ld (ix+001h),00ah
	ld hl,003a0h
	call sub_1ca5h
	ld hl,00028h
	ld (ix+00eh),l
	ld (ix+00fh),h
	xor a	
	jp l1768h
l17fch:
	inc bc	
	ld a,(bc)	
	rlca	
	inc c	
	rlca	
	dec c	
	rlca	
	ld c,007h
	rrca	
	rlca	
	djnz $+1
	dec bc	
	inc bc	
	ld a,(bc)	
	rlca	
	dec c	
	rlca	
	ld c,007h
	rrca	
	rlca	
	djnz $+1
	dec bc	
	inc bc	
	ld a,(bc)	
	rlca	
	djnz l1822h
	rrca	
	rlca	
	ld c,007h
	dec c	
	rst 38h	
	dec bc	
l1822h:
	ld hl,06b2fh
	jp l1632h
sub_1828h:
	ld de,l1864h
	call sub_1ad2h
	ret nc	
	push af	
	ld a,(0e80bh)
	and 080h
	res 6,c
	jr z,l183bh
	set 6,c
l183bh:
	ld (ix+000h),c
	ld a,091h
	call sub_0dfeh
	pop af	
	jp m,l184bh
	ld a,081h
	jr l185eh
l184bh:
	ld hl,0e2d2h
	inc (hl)	
	ld a,(hl)	
	cp 002h
	ld a,080h
	jp c,l1677h
	ld a,081h
	jp z,l1677h
	ld a,084h
l185eh:
	ld hl,000beh
	jp l167ah
l1864h:
	rst 38h	
	ret p	
	rst 38h	
	rst 38h	
	rst 38h	
	rst 38h	
	ld bc,0ffffh
	rst 38h	
l186eh:
	ld hl,l1a72h
	push hl	
	ld hl,0e700h
	bit 1,(hl)
	jr nz,l18a3h
	ld l,(ix+008h)
	ld h,(ix+009h)
	dec hl	
	bit 7,h
	jr nz,l188ah
	ld (ix+008h),l
	ld (ix+009h),h
l188ah:
	add a,a	
	ld d,000h
	ld e,a	
	ld hl,l1897h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	jp (hl)	
l1897h:
	jr z,$+28
	xor d	
	dec de	
	ld l,h	
	add hl,de	
	jp nz,0ae19h
	jr l183bh
	add hl,de	
l18a3h:
	push af	
	call l1be2h
	pop af	
	cp 005h
	jp z,l19bdh
	ret	
	call l1be2h
	call sub_1a49h
	jr nc,l18d6h
l18b6h:
	dec (ix+00ah)
	push af	
	ld a,091h
	call sub_0dfeh
	pop af	
	jr z,l18c6h
	inc (ix+001h)
	ret	
l18c6h:
	call l1677h
	ld hl,0e215h
	bit 6,c
	jr z,l18d3h
	ld hl,0e235h
l18d3h:
	ld (hl),000h
	ret	
l18d6h:
	ld de,0ff00h
	ld hl,(0e80ch)
	add hl,de	
	jr c,l18eah
	ld a,005h
	ld hl,l005ah
	ld (ix+006h),002h
	jr l194fh
l18eah:
	ld a,(ix+008h)
	and a	
	jp z,l19fdh
	ld a,(ix+006h)
	cp 002h
	jr z,l195dh
	dec (ix+007h)
	ret nz	
	ld a,(ix+00eh)
l18ffh:
	and a	
	jp nz,l1942h
	ld hl,0e32bh
	ld a,(hl)	
	cp 003h
	inc (ix+007h)
	ret nc	
	add a,a	
	add a,(hl)	
	inc (hl)	
	inc hl	
	ld d,000h
	ld e,a	
	add hl,de	
	push hl	
	call sub_1c8ah
	ld de,l00c0h
	ld a,c	
	and 040h
	jr z,l1924h
	add hl,de	
	jr l1926h
l1924h:
	sbc hl,de
l1926h:
	ex de,hl	
	pop hl	
	ld b,a	
	ld a,(ix+006h)
	sub 009h
	or b	
	ld (hl),a	
	inc hl	
sub_1931h:
	ld (hl),e	
	inc hl	
	ld (hl),d	
	call sub_1dbfh
	dec (ix+00eh)
	ld (ix+007h),010h
	inc (ix+006h)
	ret	
l1942h:
	ld (ix+006h),002h
	dec (ix+00bh)
	ret nz	
	ld hl,(0e1f5h)
	ld a,003h
l194fh:
	ld (ix+008h),l
	ld (ix+009h),h
	ld (ix+001h),a
	ld (ix+007h),002h
	ret	
l195dh:
	ld hl,(0e80ch)
	ld de,0f5a0h
	add hl,de	
	ld hl,l005ah
	ld a,000h
	jr c,l194fh
	ret	
	call l1be2h
	ld a,002h
	cp (ix+006h)
	jr z,l1982h
	dec (ix+007h)
	ret nz	
	ld (ix+006h),a
	ld (ix+007h),003h
	ret	
l1982h:
	call sub_1a49h
	jp c,l18b6h
	dec (ix+007h)
	ret nz	
	ld (ix+008h),004h
	ld (ix+009h),000h
	ld (ix+001h),003h
	ret	
	call sub_1befh
	call sub_1a49h
	jp c,l18b6h
	ld a,(ix+008h)
	and a	
	jr nz,l19aeh
	ld a,(ix+009h)
	and a	
	jr z,l19f3h
l19aeh:
	ld de,0f600h
	ld hl,(0e80ch)
	add hl,de	
	jp c,l1a3ch
	call sub_1ab8h
	jr c,l1a3ch
l19bdh:
	ld a,c	
	xor 040h
	ld c,a	
	ret	
	call l1be2h
	call sub_1a49h
	jp c,l18b6h
	ld a,(ix+008h)
	and a	
	jr nz,l19d7h
	ld a,(ix+009h)
	and a	
	jr z,l19f3h
l19d7h:
	ld de,0f700h
	ld hl,(0e80ch)
	add hl,de	
	jr nc,l19eah
	ld de,0fe00h
	add hl,de	
	ret nc	
	ld (ix+001h),000h
	ret	
l19eah:
	call sub_1ab8h
	ret c	
	ld (ix+001h),005h
	ret	
l19f3h:
	ld (ix+001h),004h
	ld a,(0e1f0h)
	ld (ix+00bh),a
l19fdh:
	ld hl,0e1f1h
	ld a,(0e010h)
	cp (hl)	
	ld a,009h
	jr c,l1a0ah
	ld a,00bh
l1a0ah:
	ld (ix+006h),a
	inc hl	
	ld a,(0e011h)
	cp 055h
	jr c,l1a1bh
	inc hl	
	cp 0aah
	jr c,l1a1bh
	inc hl	
l1a1bh:
	ld a,(hl)	
	ld (ix+008h),a
	ld (ix+00eh),000h
	ld (ix+007h),00bh
	ret	
	call sub_1be7h
	ld de,0f600h
	add hl,de	
	ret c	
	ld a,(ix+008h)
	and a	
	jr nz,l1a3ch
	ld a,(ix+009h)
	and a	
	jr z,l19f3h
l1a3ch:
	ld (ix+001h),003h
	ld (ix+006h),002h
	ld (ix+007h),002h
	ret	
sub_1a49h:
	ld a,(0e701h)
	and 003h
	jr nz,l1a54h
	res 2,(ix+000h)
l1a54h:
	bit 2,(ix+000h)
	ret nz	
	ld de,l1680h
	call sub_1ad2h
	ret nc	
	set 2,(ix+000h)
	ld a,085h
	ret p	
	call sub_1ac9h
	ld a,083h
	jr nz,l1a70h
	ld a,087h
l1a70h:
	scf	
	ret	
l1a72h:
	ld hl,(0e80ch)
	ld de,0e400h
	add hl,de	
	ret c	
	ld hl,06be7h
l1a7dh:
	ld a,c	
l1a7eh:
	xor 040h
l1a80h:
	and 0c0h
	bit 4,(ix+000h)
	ret z	
	ex de,hl	
	call sub_1c9eh
	add hl,hl	
	ld l,h	
	ld h,000h
	rl h
	ld (0e807h),hl
	ld hl,(0e80ah)
	ld c,(ix+006h)
sub_1a9ah:
	push de	
	ld b,000h
	ld d,0ffh
	add hl,hl	
	jr c,l1aa3h
	ld d,b	
l1aa3h:
	add hl,hl	
	add hl,hl	
	ld e,h	
	ld hl,(0e715h)
	add hl,de	
	ld (0e803h),hl
	ex de,hl	
	pop hl	
	add hl,bc	
	add hl,bc	
	ld c,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,c	
	jp l0e20h
sub_1ab8h:
	call sub_1c91h
	ld hl,(0e106h)
	bit 6,c
	jr z,l1ac6h
	ld hl,(0e104h)
	ex de,hl	
l1ac6h:
	sbc hl,de
	ret	
sub_1ac9h:
	ld a,(0e702h)
	cp 008h
	ret z	
	cp 009h
	ret	
sub_1ad2h:
	push de	
	call sub_1ae7h
	pop hl	
	ret nc	
	call sub_1b18h
	ret nc	
	push af	
	and 00fh
	call sub_1b8eh
	call sub_1c91h
	pop af	
	ret	
sub_1ae7h:
	ld a,(0e80bh)
	ld b,a	
	ld a,(0e701h)
	rlca	
	xor b	
	and 080h
	ret z	
	ld a,(0e701h)
	and 003h
	ret z	
	and 002h
	ld de,l02c0h
	ld b,005h
	jr nz,l1b06h
	ld de,00400h
	ld b,a	
l1b06h:
	sbc hl,de
	ret nc	
	ld a,(0e702h)
	cp 006h
	ret c	
	inc b	
	sub 008h
	ret c	
	inc b	
	add a,b	
	ld b,a	
	scf	
	ret	
sub_1b18h:
	ld e,b	
	ld d,000h
	add hl,de	
	ld a,(hl)	
	cp 0ffh
	ret	
l1b20h:
	call sub_1208h
	jr nz,sub_1b7ah
	ld a,(0e81ch)
	and a	
	ld a,002h
	jr nz,l1b37h
	in a,(003h)
	and 002h
	ld a,004h
	jr nz,l1b37h
	ld a,003h
l1b37h:
	ld (ix+007h),a
	ld (ix+006h),009h
	ld (ix+001h),009h
	ld hl,0e71ah
	inc (hl)	
	call sub_1c61h
	ld (ix+00fh),a
	ld (ix+00bh),006h
	ld (ix+00eh),005h
sub_1b54h:
	bit 2,(ix+000h)
	ld hl,0e71bh
	jr z,l1b5fh
	inc hl	
	inc hl	
l1b5fh:
	bit 6,(ix+000h)
	ld de,0ff80h
	jr nz,l1b6ch
	inc hl	
	ld de,l0080h
l1b6ch:
	inc (hl)	
	ld b,(hl)	
	ld hl,(0e712h)
l1b71h:
	add hl,de	
	djnz l1b71h
	call sub_1c83h
	jp l1be2h
sub_1b7ah:
	bit 1,(ix+000h)
	jr nz,l1b89h
	ld (ix+000h),000h
	ld hl,0e261h
	dec (hl)	
	ret	
l1b89h:
	res 4,(ix+000h)
	ret	
sub_1b8eh:
	add a,004h
l1b90h:
	ld (ix+006h),a
	ld hl,l1c55h
l1b96h:
	ld (ix+001h),001h
	ld a,(hl)	
	inc hl	
	ld (ix+007h),a
	call sub_1ca5h
	xor a	
	ld (ix+00eh),a
	ld (ix+00fh),a
	ret	
l1baah:
	dec (ix+007h)
	jp nz,l1bc4h
	call sub_1cach
	ld a,(hl)	
	and a	
	jp m,sub_1b7ah
	inc hl	
	ld (ix+006h),a
	ld a,(hl)	
	inc hl	
	ld (ix+007h),a
	call sub_1ca5h
l1bc4h:
	ld e,(ix+00eh)
	ld d,(ix+00fh)
	ld hl,l0016h
	add hl,de	
	ld (ix+00eh),l
	ld (ix+00fh),h
	call sub_1c9eh
	sbc hl,de
	call sub_1c97h
	ld de,l0039h
	call sub_1c7ah
l1be2h:
	call sub_1c8ah
	jr l1c08h
sub_1be7h:
	ld de,l0036h
l1beah:
	call sub_1c70h
	jr l1bf5h
sub_1befh:
	ld de,l0036h
l1bf2h:
	call sub_1c7ah
l1bf5h:
	dec (ix+007h)
	jr nz,l1c08h
	ld (ix+007h),007h
	dec (ix+006h)
	jp p,l1c08h
	ld (ix+006h),003h
l1c08h:
	ld de,(0e712h)
	ld a,e	
	and 0e0h
	ld e,a	
	ld a,l	
	and 0e0h
	ld l,a	
	sbc hl,de
	ld (0e80ah),hl
	jr nc,l1c21h
	ld de,l0001h
	ex de,hl	
	sbc hl,de
l1c21h:
	ld (0e80ch),hl
	and a	
	ret	
sub_1c26h:
	ld hl,(0e712h)
	ld de,l1000h
	add hl,de	
	call sub_1c91h
	sbc hl,de
	ret c	
	res 5,(ix+000h)
	ld hl,0e260h
	res 5,(hl)
	ret	
sub_1c3dh:
	call sub_1c8ah
	ld de,l1000h
	add hl,de	
	ld de,(0e712h)
	sbc hl,de
	ret c	
	res 3,(ix+000h)
	ld hl,0e260h
	res 3,(hl)
	ret	
l1c55h:
	dec b	
	rlca	
	rlca	
	ex af,af'	
	ld de,l05ffh
	rlca	
	ld a,(bc)	
	ex af,af'	
	rla	
	rst 38h	
sub_1c61h:
	ld a,(0e000h)
	cp 006h
	ld a,(0e909h)
	ret z	
	ld a,(0e907h)
	and 00fh
	ret	
sub_1c70h:
	call sub_1c8ah
	bit 6,c
	jr z,l1c81h
l1c77h:
	add hl,de	
	jr sub_1c83h
sub_1c7ah:
	call sub_1c8ah
	bit 6,c
	jr z,l1c77h
l1c81h:
	sbc hl,de
sub_1c83h:
	ld (ix+002h),l
	ld (ix+003h),h
	ret	
sub_1c8ah:
	ld l,(ix+002h)
	ld h,(ix+003h)
	ret	
sub_1c91h:
	ex de,hl	
	call sub_1c8ah
	ex de,hl	
	ret	
sub_1c97h:
	ld (ix+004h),l
	ld (ix+005h),h
	ret	
sub_1c9eh:
	ld l,(ix+004h)
	ld h,(ix+005h)
	ret	
sub_1ca5h:
	ld (ix+00ch),l
	ld (ix+00dh),h
	ret	
sub_1cach:
	ld l,(ix+00ch)
	ld h,(ix+00dh)
	ret	
sub_1cb3h:
	call sub_1e4ah
	call sub_1dfdh
	ld ix,0e2fbh
	call sub_1cc4h
	ld ix,0e30bh
sub_1cc4h:
	ld a,(ix+000h)
	ld c,a	
	and 010h
	ret z	
	ld a,(0e700h)
	and 002h
	jp nz,l1da7h
	ld a,(ix+001h)
	cp 001h
	jp c,l1d4bh
	jr z,l1d03h
	call sub_1de9h
	ld a,(0e2d9h)
	cp 001h
	jr z,l1ceeh
	ld a,(0e2d8h)
	and 010h
	jr nz,l1d5bh
l1ceeh:
	ld de,(0e712h)
	sbc hl,de
	jp c,l1d5bh
	ld de,0ec00h
	add hl,de	
	jr nc,l1d5bh
	ld (ix+000h),000h
	jr l1d5bh
l1d03h:
	ld a,(ix+00bh)
	ld l,(ix+004h)
	ld h,(ix+005h)
	bit 0,a
	jr z,l1d1ch
	ld de,(0e1bfh)
	cp 003h
	jr z,l1d20h
	sbc hl,de
	jr l1d21h
l1d1ch:
	ld de,(0e1bdh)
l1d20h:
	add hl,de	
l1d21h:
	ld (ix+004h),l
	ld (ix+005h),h
	ld l,(ix+00ch)
	ld h,(ix+00dh)
	ld de,(0e1bbh)
	add hl,de	
	ld (ix+00ch),l
	ld (ix+00dh),h
	call sub_1defh
	ld e,(ix+00eh)
	ld d,(ix+00fh)
	sbc hl,de
	jr c,l1d5bh
	res 5,(ix+000h)
	jr l1d58h
l1d4bh:
	call sub_1de9h
	ld e,(ix+00eh)
	ld d,(ix+00fh)
	sbc hl,de
	jr nc,l1d5bh
l1d58h:
	inc (ix+001h)
l1d5bh:
	bit 5,(ix+000h)
	jr nz,l1d8fh
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld de,0ff40h
	add hl,de	
	ld (0e80fh),hl
	ld de,l017fh+1
	add hl,de	
	ld (0e811h),hl
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0006h+2
	push hl	
	call sub_1172h
	pop hl	
	jr nc,l1d8fh
	ld de,00118h
	call sub_2c9ah
	set 5,(ix+000h)
l1d8fh:
	dec (ix+007h)
	jr nz,l1da7h
	ld (ix+007h),002h
	ld a,(ix+006h)
	inc a	
	cp 006h
	jr c,l1da4h
	call sub_1dbfh
	xor a	
l1da4h:
	ld (ix+006h),a
l1da7h:
	call l1be2h
	ld de,0e800h
	add hl,de	
	ret c	
	ld a,(ix+006h)
	cp 003h
	ld a,040h
	jr c,l1db9h
	xor a	
l1db9h:
	ld hl,075a5h
	jp l1a7eh
sub_1dbfh:
	push hl	
	push de	
	ld hl,(0e003h)
	ld de,0fccdh
	add hl,de	
	ld a,095h
	jr c,l1dceh
	ld a,099h
l1dceh:
	call sub_0dfeh
	pop de	
	pop hl	
	ret	
sub_1dd4h:
	push hl	
	push de	
	ld hl,(0e003h)
	ld de,0fccdh
	add hl,de	
	ld a,092h
	jr c,l1de3h
	ld a,09ah
l1de3h:
	call sub_0dfeh
	pop de	
	pop hl	
	ret	
sub_1de9h:
	ld l,(ix+00ch)
	ld h,(ix+00dh)
sub_1defh:
	ld e,(ix+002h)
	ld d,(ix+003h)
	add hl,de	
	ld (ix+002h),l
	ld (ix+003h),h
	ret	
sub_1dfdh:
	ld ix,0e31bh
	ld c,(ix+000h)
	bit 4,c
	ret z	
	dec (ix+007h)
	jr nz,l1e20h
	ld (ix+007h),005h
	inc (ix+006h)
	ld a,(0e321h)
	cp 004h
	jr c,l1e20h
	jr nz,l1e45h
	set 7,(ix+000h)
l1e20h:
	ld de,l0072h
	call sub_1c7ah
	call l1be2h
	ld hl,(0e327h)
	ld de,l001bh
	add hl,de	
	ld (0e327h),hl
	ex de,hl	
	ld hl,(0e31fh)
	sbc hl,de
	ld (0e31fh),hl
	ld hl,073d2h
	ld a,(0e31bh)
	jp l1a7eh
l1e45h:
	ld (ix+000h),000h
	ret	
sub_1e4ah:
	ld a,(0e2d8h)
	ld c,a	
	and a	
	jr z,$+63
	and 010h
	ret z	
	ld hl,(0e2e0h)
	dec hl	
	bit 7,h
	jr nz,l1e5fh
	ld (0e2e0h),hl
l1e5fh:
	ld ix,0e2d8h
	ld a,(0e2e2h)
	ld hl,0e2fah
	and a	
	jp m,l1e77h
	cp 03fh
	jr z,l1e77h
	dec (hl)	
	jr nz,l1e79h
	inc (ix+00ah)
l1e77h:
	ld (hl),070h
l1e79h:
	ld a,(0e080h)
	and 007h
	ld hl,l1e84h
	jp l1f26h
l1e84h:
	add hl,de	
	rra	
	sbc a,b	
	ld (l213eh),hl
	ret p	
	inc h	
	jp p,l3a26h+2
	add a,b	
	ret po	
	and 007h
	ld hl,(0e2d3h)
	ld de,(0e712h)
	sbc hl,de
	bit 0,a
	jr z,l1ea1h
	ccf	
l1ea1h:
	ret c	
	cp 003h
	jr nz,l1each
	ld hl,0034fh
	ld (0e2f8h),hl
l1each:
	bit 0,a
	ld c,a	
	ld a,012h
	jr nz,l1eb5h
	ld a,052h
l1eb5h:
	ld (0e2d8h),a
	ld a,070h
	ld (0e2fah),a
	ld a,(0e261h)
	ld hl,0e197h
	sub (hl)	
	ret c	
	ret z	
	ld b,005h
	ld ix,0e262h
l1ecch:
	bit 0,(ix+000h)
	jr nz,l1f03h
	ld hl,(0e712h)
	ld e,(ix+002h)
	ld d,(ix+003h)
	bit 0,c
	jr z,l1eebh
	bit 6,(ix+000h)
	jr z,l1f03h
	sbc hl,de
l1ee7h:
	jr c,l1f03h
	jr l1ef5h
l1eebh:
	bit 6,(ix+000h)
	jr nz,l1f03h
	sbc hl,de
	jr nc,l1f03h
l1ef5h:
	ld l,a	
	ld a,(ix+001h)
	and a	
	ld a,l	
	jr nz,l1f03h
	ld (ix+001h),005h
	dec a	
	ret z	
l1f03h:
	ld de,l000fh+1
	add ix,de
	djnz l1ecch
	ret	
l1f0bh:
	jr nc,l1f2ch
	ld sp,hl	
	rra	
	ld de,04520h
	rra	
	ld e,c	
	rra	
	ld h,h	
	jr nz,l1f33h
	jr nz,l1ee7h
	ld l,a	
	inc l	
	ld hl,l2096h
	push hl	
	ld hl,l1f0bh
l1f23h:
	ld a,(ix+001h)
l1f26h:
	add a,a	
	ld d,000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
l1f2ch:
	inc hl	
	ld h,(hl)	
	ld l,a	
	jp (hl)	
	call sub_2d0dh
l1f33h:
	ld de,0fa00h
	add hl,de	
	jp nc,l1fcfh
	ld de,0c000h
	ld hl,(0e2dah)
	add hl,de	
	jp c,l1f50h
	ret	
	call l1be2h
	ld de,0fa00h
	add hl,de	
	jp nc,l1fcfh
	ret	
l1f50h:
	ld (ix+001h),003h
	ld (ix+006h),000h
	ret	
	call l1be2h
	call sub_20e3h
	jp c,l2036h
	dec (ix+007h)
	ret nz	
	dec (ix+00eh)
	jp m,l2085h
	jr z,l1fc2h
	inc (ix+006h)
	ld (ix+007h),005h
	ld a,(0e2e6h)
	cp 002h
	ret nz	
	call sub_1dd4h
	ld de,(0e80ch)
	ld hl,0fa60h
	add hl,de	
	ret c	
	ld hl,0fe00h
	add hl,de	
	ret nc	
	ld hl,(0e2dah)
	ld de,00200h
	add hl,de	
	ld (0e80fh),hl
	ld de,l02c0h
	add hl,de	
	ld (0e811h),hl
	ld a,(0e2deh)
	cp 00bh
	jr c,l1fb0h
	jr z,l1fabh
	ld hl,06900h
	jr l1fb3h
l1fabh:
	ld hl,06180h
	jr l1fb3h
l1fb0h:
	ld hl,05980h
l1fb3h:
	ld de,l0003h+2
	push hl	
	call sub_1172h
	pop hl	
	ret nc	
	ld de,l0110h
	jp l2c95h
l1fc2h:
	dec (ix+00bh)
	jr nz,l1fd2h
	inc (ix+006h)
	ld (ix+007h),005h
	ret	
l1fcfh:
	call sub_2ce8h
l1fd2h:
	ld a,(0e011h)
	ld hl,0e19eh
	ld b,004h
	cp (hl)	
	jr c,l1fe5h
	inc hl	
	ld b,009h
	cp (hl)	
	jr c,l1fe5h
	ld b,00eh
l1fe5h:
	ld (ix+006h),b
	ld (ix+00eh),004h
	ld a,(0e012h)
	ld hl,0e1a0h
	call sub_1214h
	ld (0e2dfh),a
	ret	
l1ff9h:
	call l1baah
	bit 4,(ix+000h)
	ret nz	
	pop hl	
	ld hl,0e2d8h
	res 4,(hl)
	ld hl,0e2e8h
	res 4,(hl)
	ret	
l200dh:
	ld (ix+001h),002h
l2011h:
	call l1be2h
	dec (ix+007h)
	jp z,l1fcfh
	ret	
	ld de,(0e104h)
	ld l,(ix+002h)
	ld h,(ix+003h)
	sbc hl,de
	jr c,l200dh
	ld de,l0055h
	call sub_1c7ah
	jr l2011h
l2031h:
	ld (ix+001h),006h
	ret	
l2036h:
	add a,013h
	ld (0e2deh),a
	cp 016h
	ld hl,l2126h
	jr c,l2045h
	ld hl,0212ch
l2045h:
	call l1b96h
	ld hl,l2d67h
	ld de,l00d8h
	call sub_2d19h
	ld a,008h
	jp c,l247ah
	ld a,(ix-002h)
	ld (ix-002h),01ch
	and a	
	jr nz,l2031h
	inc (ix+001h)
	ret	
	call sub_2d13h
	call sub_20e3h
	jp c,l2036h
l206dh:
	ld de,(0e104h)
l2071h:
	ld l,(ix+002h)
	ld h,(ix+003h)
	sbc hl,de
	jr c,l2080h
	ld a,(ix+008h)
	and a	
	ret nz	
l2080h:
	ld (ix+001h),000h
	ret	
l2085h:
	ld (ix+006h),000h
	ld (ix+007h),007h
	ld (ix+001h),005h
	ld (ix+008h),025h
	ret	
l2096h:
	call sub_2cb9h
	call sub_2c78h
	ld hl,06c8dh
l209fh:
	ld de,0fea0h
sub_20a2h:
	ld a,(0e701h)
	and 003h
	jr nz,l20adh
	res 5,(ix+000h)
l20adh:
	push hl	
	ld a,(ix+001h)
	cp 001h
	jr z,l20d2h
	ld hl,(0e80ch)
	add hl,de	
	ld hl,0e701h
	bit 6,(ix+000h)
	jr z,l20cch
	jr c,l20c8h
	set 4,(hl)
	jr l20d9h
l20c8h:
	res 4,(hl)
	jr l20d9h
l20cch:
	jr c,l20d7h
	set 5,(hl)
	jr l20d9h
l20d2h:
	ld hl,0e701h
	res 4,(hl)
l20d7h:
	res 5,(hl)
l20d9h:
	pop hl	
	call sub_2d01h
	ld a,(ix+000h)
	jp l1a7eh
sub_20e3h:
	call sub_2109h
	ret nc	
	ld hl,(0e80ch)
	ld de,0fe60h
	add hl,de	
	ret nc	
	ld a,(0e2deh)
	cp 004h
	jr c,l20fdh
	cp 009h
	ld hl,l2112h
	jr c,l2100h
l20fdh:
	ld hl,l211ch
l2100h:
	call sub_1b18h
	ret nc	
	set 5,(ix+000h)
	ret	
sub_2109h:
	ld a,(ix+000h)
	and 020h
	ret nz	
	jp sub_1ae7h
l2112h:
	inc b	
	inc bc	
	rst 38h	
	rst 38h	
	rst 38h	
	rst 38h	
	inc b	
	rst 38h	
	rst 38h	
	rst 38h	
l211ch:
	ld (bc),a	
	nop	
	ld (bc),a	
	ld (bc),a	
	ld (bc),a	
	ld (bc),a	
	ld bc,0ffffh
	rst 38h	
l2126h:
	ld b,018h
	ex af,af'	
	add hl,de	
	ld de,006ffh
	ld a,(de)	
	ex af,af'	
	dec de	
	ld de,048ffh
	ld hl,l1ff9h
	nop	
	ld (l215dh),hl
	ld h,a	
	ld hl,l2217h
l213eh:
	ld hl,l2239h
	push hl	
	ld hl,02132h
	jp l1f23h
	call sub_2d0dh
	ld de,0fb00h
	add hl,de	
	jp nc,l21dch
	ld de,0c000h
	ld hl,(0e2dah)
	add hl,de	
	jp c,l1f50h
	ret	
l215dh:
	call l1be2h
	ld de,0fb00h
	add hl,de	
	jr nc,l21dch
	ret	
	call l1be2h
	call sub_224bh
	jp c,l220ah
	dec (ix+007h)
	ret nz	
	dec (ix+00eh)
	jr z,l21d4h
	inc (ix+006h)
	ld (ix+007h),00bh
	ld a,(0e2e6h)
	cp 002h
	ret nz	
	call sub_1dd4h
	ld hl,(0e2dah)
	ld a,(0e2deh)
	cp 007h
	jr c,l21a9h
	ld de,l01e0h
	add hl,de	
	ld (0e80fh),hl
	ld de,l0220h
	add hl,de	
	ld (0e811h),hl
	ld hl,05e00h
	ld de,l0011h
	jr l21bdh
l21a9h:
	ld de,00240h
	add hl,de	
	ld (0e80fh),hl
	ld de,l01e0h
	add hl,de	
	ld (0e811h),hl
	ld hl,06a00h
	ld de,0000ah
l21bdh:
	call sub_1172h
	ret nc	
	ld a,(0e2deh)
	cp 007h
	ld hl,06c80h
	jr c,l21ceh
	ld hl,06080h
l21ceh:
	ld de,l0016h+2
	jp l2c95h
l21d4h:
	dec (ix+00bh)
	jr nz,l21dfh
	jp l2220h
l21dch:
	call sub_2ce8h
l21dfh:
	ld a,(0e011h)
	ld hl,0e19eh
	ld b,004h
	cp (hl)	
	jr c,l21ech
	ld b,007h
l21ech:
	ld (ix+006h),b
	ld a,(0e012h)
	ld hl,0e1a5h
	call sub_1214h
	ld (0e2dfh),a
	ld (ix+00eh),003h
	ret	
l2200h:
	call l1be2h
	dec (ix+007h)
	jp z,l1f50h
	ret	
l220ah:
	ld (ix+006h),000h
	ld (ix+007h),00bh
	ld (ix+001h),002h
	ret	
l2217h:
	call sub_2d13h
	call sub_224bh
	jp l206dh
l2220h:
	ld (ix+006h),000h
	ld (ix+007h),007h
	ld (ix+001h),005h
	ld a,(0e013h)
	ld hl,0e1a0h
	call sub_1214h
	ld (ix+008h),a
	ret	
l2239h:
	call sub_2cb9h
	call sub_2c78h
	ld hl,06e65h
	ld de,0fe20h
	call sub_20a2h
	jp l2e70h
sub_224bh:
	ld a,(0e2d8h)
	and 020h
	ret nz	
	ld hl,l00e0h
	call sub_1220h
	ret nc	
	set 5,(ix+000h)
	push de	
	ld hl,l0003h+2
	call sub_2e5ch
	ld hl,l2d6ah
	call sub_2d19h
	pop de	
	jr c,l2271h
	ld hl,09000h
	add hl,de	
	ret	
l2271h:
	pop af	
	ld de,000eeh
	ld a,009h
	call l247ah
	ld (ix+006h),000h
	ld hl,l2284h
	jp l1b96h
l2284h:
	ld b,00ah
	ex af,af'	
	dec bc	
	inc de	
	rst 38h	
l228ah:
	and l	
	ld (l1ff9h),hl
	add hl,bc	
	inc h	
	rst 0	
	ld (l22d2h),hl
	add a,b	
	inc h	
	ld (0cd24h),a
	ld l,a	
	inc l	
	ld hl,l249fh
	push hl	
	ld hl,l228ah
	jp l1f23h
	call sub_2d0dh
	ld de,0f600h
	add hl,de	
	jp nc,l23c6h
	ld de,05f00h
	ld hl,(0e2dah)
	add hl,de	
	jp nc,l1f50h
	ret	
l22bah:
	ld (ix+001h),000h
	ld (ix+006h),000h
	ld (ix+007h),002h
	ret	
	call l1be2h
	ld de,0f600h
	add hl,de	
	jp nc,l23c6h
	ret	
l22d2h:
	call l1be2h
	call sub_24b0h
	jp c,l2448h
	dec (ix+007h)
	ret nz	
	dec (ix+00eh)
	jr z,l2344h
	jp m,l23b4h
	inc (ix+006h)
	ld (ix+007h),00bh
	ld iy,0e2fbh
	bit 4,(iy+000h)
	jr z,l22fch
	ld iy,0e30bh
l22fch:
	ld a,(0e2e7h)
	cp 002h
	ld hl,06900h
	jr c,l2309h
	ld hl,05680h
l2309h:
	ld (iy+004h),l
	ld (iy+005h),h
	ld (iy+00bh),a
	ld hl,(0e2dah)
	ld de,0ff00h
	add hl,de	
	ld (iy+002h),l
	ld (iy+003h),h
	ld de,0ed00h
	add hl,de	
	ld (iy+00eh),l
	ld (iy+00fh),h
	ld hl,(0e1b9h)
	ld (iy+00ch),l
	ld (iy+00dh),h
	ld a,050h
	ld (iy+000h),a
	xor a	
	ld (iy+001h),a
	ld (iy+006h),a
	ld a,002h
	ld (iy+007h),a
	ret	
l2344h:
	inc (ix+00eh)
	inc (ix+007h)
	ld iy,0e2fbh
	bit 4,(iy+000h)
	jr z,l2368h
	bit 7,(iy+00dh)
	ret nz	
	bit 0,(ix-001h)
	jr z,l2371h
	bit 4,(iy+010h)
	jr nz,l2371h
	jp l23d3h
l2368h:
	ld iy,0e30bh
	bit 7,(iy+00dh)
	ret nz	
l2371h:
	ld a,(iy+00bh)
	and a	
	jr z,l237fh
	cp 003h
	jr z,l237fh
	ld a,00ah
	jr l2381h
l237fh:
	ld a,00ch
l2381h:
	ld (ix+006h),a
	ld hl,(0e2dah)
	ld de,0fec0h
	add hl,de	
	ld e,(iy+002h)
	ld d,(iy+003h)
	sbc hl,de
	ret nc	
	ld (iy+000h),000h
	dec (ix+006h)
	ld a,(0e30bh)
	and 010h
	ld a,00bh
	jr nz,l23b0h
	dec (ix+00eh)
	ld a,(0e011h)
	ld hl,0e1a5h
	call sub_1214h
l23b0h:
	ld (0e2dfh),a
	ret	
l23b4h:
	ld hl,(0e80ch)
	ld de,0f500h
	add hl,de	
	jp c,l22bah
	dec (ix+00bh)
	jr nz,l23cch
	jp l2220h
l23c6h:
	ld a,(0e19fh)
	ld (0e2e3h),a
l23cch:
	ld a,r
	and 001h
	ld (ix-001h),a
l23d3h:
	ld (ix+001h),004h
	ld a,(0e010h)
	ld hl,0e19ch
	ld b,000h
	cp (hl)	
	jr c,l23edh
	inc hl	
	inc b	
	cp (hl)	
	jr c,l23edh
	inc hl	
	inc b	
	cp (hl)	
	jr c,l23edh
	inc b	
l23edh:
	ld (ix+00fh),b
	ld a,b	
	ld b,009h
	cp 002h
	jr nc,l23f9h
	ld b,00bh
l23f9h:
	ld (ix+006h),b
	ld (ix+007h),00bh
	ld (ix+00eh),002h
	ret	
l2405h:
	ld (ix+001h),002h
l2409h:
	call l1be2h
	dec (ix+007h)
	ret nz	
	inc (ix+007h)
	ld a,(0e30bh)
	and 010h
	jr nz,l2427h
	ld a,(0e2fbh)
	and 010h
	jr z,l23c6h
	bit 0,(ix-001h)
	jr nz,l23d3h
l2427h:
	ld a,(0e2e4h)
	ld (0e2deh),a
	ld (ix+001h),004h
	ret	
	ld de,(0e106h)
	ld l,(ix+002h)
	ld h,(ix+003h)
	sbc hl,de
	jr nc,l2405h
	ld de,l0055h
	call sub_1c7ah
	jr l2409h
l2448h:
	ld b,(ix+006h)
	add a,004h
	ld (0e2deh),a
	ld hl,l2d6dh
	call sub_2d19h
	jr c,l246fh
	ld (ix+00ch),b
	ld (ix+007h),006h
	ld a,(ix-002h)
	ld (ix-002h),01ch
	and a	
	jp nz,l2031h
	ld (ix+001h),002h
	ret	
l246fh:
	ld hl,l24cch
	call l1b96h
	ld de,l00dch
	ld a,009h
l247ah:
	ld hl,(0e2dah)
	jp sub_2f60h
	call sub_2d13h
	call sub_24b0h
	jr c,l2448h
l2488h:
	ld de,(0e106h)
	ld l,(ix+002h)
	ld h,(ix+003h)
	sbc hl,de
	jp nc,l2080h
	ld a,(ix+008h)
	and a	
	jp z,l2080h
	ret	
l249fh:
	ld hl,0e700h
	set 6,(hl)
	call sub_2cb9h
	call sub_2c78h
	ld hl,06f4eh
	jp l209fh
sub_24b0h:
	call sub_2109h
	ret nc	
	ld hl,(0e80ch)
	ld de,0fe60h
	add hl,de	
	ret nc	
	ld hl,l24c2h
	jp l2100h
l24c2h:
	ld (bc),a	
	nop	
	ld (bc),a	
	ld (bc),a	
	ld (bc),a	
	ld (bc),a	
	ld bc,0ffffh
	rst 38h	
l24cch:
	ld b,007h
	ex af,af'	
	ex af,af'	
	ld de,l18ffh
	dec h	
	ld sp,hl	
	rra	
	jp l3525h
	dec h	
	ld b,b	
	dec h	
	dec de	
	daa	
	ld a,a	
	ld h,0d6h
	ld h,0e2h
	dec de	
	inc bc	
	jr z,$-68
	daa	
	scf	
	daa	
	add a,h	
	daa	
	ex (sp),hl	
	dec h	
	cpl	
	ld h,02ah
	ret m	
	jp po,0b47dh
	jr z,l24fbh
	dec hl	
	ld (0e2f8h),hl
l24fbh:
	ld hl,0e2d6h
	ld a,(hl)	
	and a	
	jr z,l2503h
	dec (hl)	
l2503h:
	call sub_250fh
	ld ix,0e2e8h
	bit 4,(ix+000h)
	ret z	
sub_250fh:
	ld hl,024d2h
	call l1f23h
	jp l2893h
	call sub_2d0dh
	ld de,0f800h
	add hl,de	
	jp nc,l2589h
	bit 6,(ix+000h)
	ret nz	
	ld de,05f00h
	ld l,(ix+002h)
	ld h,(ix+003h)
	add hl,de	
	jp nc,l1f50h
	ret	
	call l1be2h
	ld de,0f800h
	add hl,de	
	jp nc,l2589h
	ret	
	call l1be2h
	call sub_28bah
	jp c,l264bh
	ld a,(ix+00eh)
	and a	
	call m,sub_25afh
	dec (ix+007h)
	ret nz	
	and a	
	jr z,l256ch
	jp m,l258ch
	add a,(ix+006h)
	ld (ix+006h),a
	call sub_34ddh
l2563h:
	ld (ix+007h),00bh
	ld (ix+00eh),000h
	ret	
l256ch:
	dec (ix+00bh)
	jp z,l2220h
	call sub_25afh
l2575h:
	ld (ix+006h),000h
	dec (ix+00eh)
	ld a,(0e011h)
	ld hl,0e1a5h
	call sub_1214h
	ld (ix+007h),a
	ret	
l2589h:
	call sub_2ce8h
l258ch:
	call sub_2cd4h
	jp z,l27dfh
l2592h:
	ld a,(0e012h)
	ld hl,0e19eh
	ld b,001h
	cp (hl)	
	jr c,l25a3h
	inc b	
	inc hl	
	cp (hl)	
	jr c,l25a3h
	inc b	
l25a3h:
	ld (ix+00eh),b
	ld (ix+006h),004h
	ld (ix+007h),00bh
	ret	
sub_25afh:
	ld hl,(0e80ch)
	ld de,0f380h
	add hl,de	
	ret nc	
	pop af	
	ld (ix+006h),000h
	ld (ix+007h),007h
	jp l2080h
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld a,(0e2d7h)
	and a	
	jp z,l1f50h
	ld (ix+001h),00dh
	ld (ix+006h),01ah
	ld (ix+007h),008h
	ld hl,0e700h
	set 0,(hl)
	ret	
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),008h
	inc (ix+006h)
	ld a,(ix+006h)
	cp 022h
	ret nz	
	inc (ix+001h)
	ld (ix+006h),01eh
	ld l,(ix+002h)
	ld h,(ix+003h)
	bit 6,(ix+000h)
	jr z,l2618h
	ld de,0a100h
	sbc hl,de
	add hl,de	
	jr c,l2626h
	ld de,0fd80h
	add hl,de	
	jr l2626h
l2618h:
	ld de,l0280h
	add hl,de	
	ld de,(0e106h)
	sbc hl,de
	add hl,de	
	jr c,l2626h
	ex de,hl	
l2626h:
	ld (ix+002h),l
	ld (ix+003h),h
	jp l1be2h
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),008h
	inc (ix+006h)
	ld a,(ix+006h)
	cp 026h
	ret nz	
	ld hl,0e700h
	res 0,(hl)
	jp l1f50h
l264bh:
	and a	
	jr z,l2698h
	ld (ix+006h),008h
	ld hl,02d70h
	call sub_2d19h
	ld hl,l28d6h
	jr c,l266eh
	ld a,(hl)	
	ld (ix+007h),a
	ld (ix+001h),002h
	ld hl,0e2d6h
	ld a,(hl)	
	ld (hl),01ch
	inc hl	
	ld (hl),a	
	ret	
l266eh:
	call l1b96h
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld de,000d7h
	ld a,00ah
	jp sub_2f60h
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld a,(ix+006h)
	inc a	
	cp 013h
	jr c,l26ceh
	jr nz,l26edh
	ld (ix+007h),01ch
	ld a,026h
	jr l26d2h
l2698h:
	ld a,091h
	call sub_0dfeh
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld (0e31dh),hl
	ld a,(ix+000h)
	and 050h
	ld (0e31bh),a
	ld hl,06500h
	ld (0e31fh),hl
	ld hl,l005bh
	ld (0e327h),hl
	ld a,005h
	ld (0e322h),a
	xor a	
	ld (0e321h),a
	ld hl,0e700h
	set 0,(hl)
	ld (ix+001h),006h
	ld a,00bh
l26ceh:
	ld (ix+007h),008h
l26d2h:
	ld (ix+006h),a
	ret	
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld a,(ix+006h)
	inc a	
	cp 01ah
	jr c,l26ceh
	ld hl,0e700h
	res 0,(hl)
	jp l2589h
l26edh:
	inc (ix+001h)
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld de,l0280h
	bit 6,(ix+000h)
	jr nz,l270ch
	add hl,de	
	ex de,hl	
	ld hl,(0e106h)
	sbc hl,de
	add hl,de	
	jr c,l270eh
	ex de,hl	
	jr l270eh
l270ch:
	sbc hl,de
l270eh:
	ld (ix+002h),l
	ld (ix+003h),h
	call l1be2h
	ld a,00fh
	jr l26ceh
	call sub_2d13h
	call sub_28bah
	jp c,l264bh
	call sub_2cd4h
	jp z,l2080h
	bit 6,(ix+000h)
	jp z,l2488h
	ld de,0a100h
	jp l2071h
l2737h:
	dec (ix+007h)
	jr nz,l2752h
	inc (ix+007h)
	call sub_2887h
	jr nz,l27b0h
	ld (ix+007h),007h
	dec (ix+006h)
	jp p,l2752h
	ld (ix+006h),003h
l2752h:
	ld hl,(0e712h)
	ld e,(ix+00ch)
	ld d,(ix+00dh)
	sbc hl,de
	ex de,hl	
	bit 6,(ix+000h)
	jr nz,l2771h
	ld hl,(0e106h)
	sbc hl,de
	jr nc,l276fh
	ld de,(0e106h)
l276fh:
	jr l277bh
l2771h:
	ld hl,08580h
	sbc hl,de
	jr c,l277bh
	ld de,08580h
l277bh:
	ld (ix+002h),e
	ld (ix+003h),d
	jp l1be2h
	call l1be2h
	call sub_2887h
	jr z,l27a3h
	dec (ix+007h)
	ret nz	
	ld a,(ix+00eh)
	and a	
	jp z,l2575h
	jp m,l2592h
	add a,(ix+006h)
	ld (ix+006h),a
	jp l2563h
l27a3h:
	ld (ix+006h),000h
	ld (ix+007h),002h
	ld (ix+001h),00bh
	ret	
l27b0h:
	ld (ix+001h),00ch
	call l2592h
	jp l1be2h
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),008h
	inc (ix+006h)
	ld a,(ix+006h)
	cp 022h
	ret nz	
	ld hl,l018bh
	ld (0e2f8h),hl
	ld (ix+000h),000h
	ld hl,0e701h
	res 4,(hl)
	jr l283dh
l27dfh:
	ld hl,0e700h
	set 0,(hl)
	ld a,(0e2e8h)
	and 010h
	jr z,l284fh
	push ix
	ld ix,0e2d8h
	call sub_287eh
	ld (ix+017h),008h
	ld (ix+016h),01ah
	ld (ix+011h),00ah
l2800h:
	pop ix
	ret	
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),008h
	inc (ix+006h)
	ld a,(ix+006h)
	cp 026h
	ret nz	
	ld hl,l011ah
	ld (0e2f8h),hl
	call l27a3h
	call l283dh
	ld a,r
	and 001h
	ret z	
	ld (ix-00fh),00bh
	ld (ix+001h),000h
	ld hl,l0000h
	ld de,(0e2f4h)
	sbc hl,de
	ld (0e2e4h),hl
	ret	
l283dh:
	ld (ix-00ah),000h
	ld (ix-009h),002h
	ld (ix-00fh),000h
	ld hl,0e700h
	res 0,(hl)
	ret	
l284fh:
	ld de,(0e80ah)
	ld hl,0fd60h
	add hl,de	
	jr c,l285ch
	ld de,l02a0h
l285ch:
	ld hl,(0e712h)
	ld (0e2f4h),de
	sbc hl,de
	ld (0e2eah),hl
	ld hl,05000h
	ld (0e2ech),hl
	ld (ix+010h),050h
	ld (ix+017h),008h
	ld (ix+016h),01eh
	ld (ix+011h),009h
sub_287eh:
	ld (ix+001h),008h
	ld (ix+006h),01ah
	ret	
sub_2887h:
	ld a,(0e702h)
	cp 001h
	ret z	
	cp 009h
	ret z	
	cp 00ah
	ret	
l2893h:
	ld hl,(0e80ch)
	ld de,0e800h
	add hl,de	
	ld hl,0e197h
	ld de,0e198h
	jr nc,l28aah
	ld a,(0e2e8h)
	and 010h
	jr nz,l28aah
	ex de,hl	
l28aah:
	ld a,(hl)	
	and a	
	jr z,l28b1h
	ld (de),a	
	ld (hl),000h
l28b1h:
	ld hl,07047h
	ld de,0fe00h
	jp l20adh
sub_28bah:
	call sub_1ae7h
	ret nc	
	ld hl,(0e80ch)
	ld de,0fe60h
	add hl,de	
	ret nc	
	ld hl,l28cch
	jp sub_1b18h
l28cch:
	nop	
	rst 38h	
	nop	
	nop	
	nop	
	nop	
	ld bc,0ffffh
	rst 38h	
l28d6h:
	ld b,009h
	ex af,af'	
	ld a,(bc)	
	inc de	
	rst 38h	
l28dch:
	call m,0f928h
	rra	
	xor 02ah
	ld d,(hl)	
	add hl,hl	
	call z,08c29h
	ld hl,(l2914h)
	adc a,a	
	add hl,hl	
	ret z	
	ld hl,(l2b28h)
	ld (0212bh),a
	ld e,d	
	inc l	
	push hl	
	ld hl,l28dch
	jp l1f23h
	call sub_2d0dh
	ld de,0f760h
	add hl,de	
	jr nc,l292fh
	jr l2923h
l2907h:
	ld (ix+007h),007h
	ld (ix+001h),000h
	ld (ix+006h),000h
	ret	
l2914h:
	call sub_293ch
	call sub_1c70h
	call l1be2h
	ld de,0f760h
	add hl,de	
	jr c,l2907h
l2923h:
	ld de,0c000h
	ld hl,(0e2dah)
	add hl,de	
	jp c,l1f50h
	jr l2965h
l292fh:
	ld (ix+007h),009h
	ld (ix+006h),004h
l2937h:
	ld (ix+001h),006h
	ret	
sub_293ch:
	dec (ix+007h)
	jr nz,l2952h
	ld (ix+007h),009h
	ld a,(ix+006h)
	inc a	
	cp 005h
	jr z,l294fh
	ld a,004h
l294fh:
	ld (ix+006h),a
l2952h:
	ld de,l0011h+1
	ret	
	call l1be2h
	ld de,0f760h
	add hl,de	
	ld a,004h
	jr nc,l2962h
	xor a	
l2962h:
	ld (ix+006h),a
l2965h:
	call sub_2ba0h
	ld hl,(0e80ch)
	ld de,0fb80h
	add hl,de	
	ret c	
	ld a,(ix+008h)
	and a	
	jp nz,l2ae9h
l2977h:
	ld (ix+006h),004h
	ld hl,(0e80ch)
	ld de,0fd00h
	add hl,de	
	jr nc,l29a0h
	ld a,(0e1aah)
	ld (ix+007h),a
	ld (ix+001h),007h
	ret	
	ld de,(0e1abh)
	call sub_1c70h
	call l1be2h
	call sub_2ba0h
	dec (ix+007h)
	ret nz	
l29a0h:
	call sub_2ce8h
l29a3h:
	ld hl,(0e80ch)
	ld de,0fc80h
	add hl,de	
	jp c,l2a55h
	ld a,(0e011h)
	ld hl,0e19eh
	ld b,006h
	cp (hl)	
	jr c,l29c0h
	inc hl	
	ld b,00bh
	cp (hl)	
	jr c,l29c0h
	ld b,010h
l29c0h:
	ld (ix+006h),b
	ld (ix+007h),005h
	ld (ix+00eh),005h
	ret	
	call l1be2h
	call sub_2ba0h
	dec (ix+007h)
	ret nz	
	dec (ix+00eh)
	jr z,l2a3dh
	jp m,l29a3h
	ld a,(ix+00eh)
	cp 003h
	jr nz,l2a2ch
	ld a,(ix+006h)
	cp 00ch
	ld hl,l2a73h
	jr c,l29f7h
	ld hl,l2a7ah
	jr z,l29f7h
	ld hl,02a81h
l29f7h:
	ld a,(ix+002h)
	add a,(hl)	
	inc hl	
	ld e,a	
	ld a,(ix+003h)
	adc a,(hl)	
	inc hl	
	ld d,a	
	ld (0e80fh),de
	ld a,e	
	add a,(hl)	
	inc hl	
	ld e,a	
	ld a,d	
	adc a,(hl)	
	inc hl	
	ld d,a	
	ld (0e811h),de
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
	ld l,(hl)	
	ld h,000h
	ex de,hl	
	push hl	
	call sub_1172h
	pop hl	
	jr nc,l2a2ch
	ld de,00400h
	add hl,de	
	ld de,l0016h+2
	call l2c95h
l2a2ch:
	inc (ix+006h)
	ld e,(ix+00eh)
	ld d,000h
	ld hl,l2a87h
	add hl,de	
	ld a,(hl)	
	ld (ix+007h),a
	ret	
l2a3dh:
	dec (ix+00bh)
	jr z,l2a55h
	ld a,(0e012h)
	ld hl,0e1a5h
	call sub_1214h
	ld (ix+007h),a
	ret	
l2a4fh:
	ld hl,05000h
	ld (0e2dch),hl
l2a55h:
	ld (ix+006h),004h
	ld hl,(0e2dah)
	ld de,0fe00h
	add hl,de	
	ld de,(0e104h)
	sbc hl,de
	jr c,l2ad9h
	ld (ix+001h),008h
	ld a,(0e1aah)
	ld (ix+007h),a
	ret	
l2a73h:
	jr nz,l2a76h
	ld h,b	
l2a76h:
	ld bc,06780h
	rlca	
l2a7ah:
	ld b,b	
	ld bc,l0220h
	nop	
	ld h,(hl)	
	ld c,080h
	ld bc,00200h
	nop	
	ld d,b	
l2a87h:
	ld a,(bc)	
	ld bc,l0b10h
	djnz $-49
	inc a	
	add hl,hl	
	call sub_1c7ah
	call sub_2ab6h
	call sub_2ba0h
	ld a,(ix+008h)
	and a	
	jp z,l2977h
	ld hl,(0e80ch)
	ld de,0fb00h
	add hl,de	
	jp c,l2937h
	ld hl,(0e2dah)
	ld de,(0e104h)
	sbc hl,de
	jp c,l2977h
	ret	
sub_2ab6h:
	ld hl,(0e2dah)
	ld de,(0e104h)
	sbc hl,de
	jr nc,l2ac5h
	ld (0e2dah),de
l2ac5h:
	jp l1be2h
	ld de,(0e1abh)
	call sub_1c7ah
	call sub_2ab6h
	call sub_2ba0h
	dec (ix+007h)
	ret nz	
l2ad9h:
	ld a,(0e012h)
	ld hl,0e1a0h
	call sub_1214h
	ld (ix+008h),a
	ld (ix+007h),009h
l2ae9h:
	ld (ix+001h),005h
	ret	
	call l1be2h
	dec (ix+007h)
	jp z,l2a4fh
	ret	
l2af8h:
	pop hl	
	ld a,b	
	cp 002h
	ld a,01bh
	jr c,l2b04h
	jr z,l2b03h
	dec a	
l2b03h:
	dec a	
l2b04h:
	ld (ix+006h),a
	ld a,b	
	cp 003h
	jr z,l2b10h
	xor a	
	ld (0e2d6h),a
l2b10h:
	ld hl,l2c69h
	call l1b96h
	ld hl,l2d67h
	ld de,l00deh
	call sub_2d19h
	ld a,00bh
	jp c,l247ah
	inc (ix+001h)
	ret	
l2b28h:
	call l1be2h
	dec (ix+007h)
	jp z,l2a55h
	ret	
	call l1be2h
	ld hl,0e2d7h
	ld a,(hl)	
	and a	
	jr nz,l2b4eh
	ld a,(0e2deh)
	cp 01eh
	jr nz,l2b4eh
	ld (hl),001h
	ld hl,06000h
	ld de,l0016h+2
	call l2c95h
l2b4eh:
	ld hl,(0e2e4h)
	dec (ix+007h)
	jr nz,l2b6ah
	inc hl	
	inc hl	
	ld a,(hl)	
	cp 0ffh
	jp z,l2a4fh
	ld (ix+006h),a
	inc hl	
	ld a,(hl)	
	ld (ix+007h),a
	inc hl	
	ld (0e2e4h),hl
l2b6ah:
	ld a,(hl)	
	add a,(ix+004h)
	ld (ix+004h),a
	inc hl	
	ld a,(hl)	
	adc a,(ix+005h)
	ld (ix+005h),a
	ret	
l2b7ah:
	jr nz,$+3
	jr $+5
	xor d	
	nop	
	jr l2b84h
	nop	
	nop	
l2b84h:
	jr l2b89h
	ld d,(hl)	
	rst 38h	
	rla	
l2b89h:
	inc b	
	ret po	
	cp 0ffh
l2b8dh:
	jr nz,$+3
	ld e,003h
	xor d	
	nop	
	ld e,002h
	nop	
	nop	
	ld e,003h
	ld d,(hl)	
	rst 38h	
	rla	
	inc b	
	ret po	
	cp 0ffh
sub_2ba0h:
	call sub_1ae7h
	ret nc	
	ld hl,l2c36h
	call sub_1b18h
	ret nc	
	ld b,a	
	ld e,(ix+006h)
	ld d,000h
	ld hl,l2c40h
	add hl,de	
	ld a,(hl)	
	cp 0ffh
	ret z	
	ld hl,0e2d6h
	inc (hl)	
	cp 0feh
	jr z,l2bddh
	cp 008h
	jr c,l2bd0h
	ld e,a	
	ld a,b	
	cp 002h
	jr c,l2c2dh
	ld a,e	
	cp 009h
	jr z,l2bddh
l2bd0h:
	add a,b	
	ld e,a	
	ld hl,0e1adh
	add hl,de	
	ld a,(0e013h)
	cp (hl)	
	jp nc,l2af8h
l2bddh:
	pop hl	
	ld a,b	
	cp 002h
	jr z,l2c1bh
	jr c,l2c17h
	ld (ix+007h),005h
	ld (ix+001h),00ah
	ld (ix+006h),017h
	ld a,(0e080h)
	rrca	
	rrca	
	rrca	
	and 003h
	ld e,a	
	ld d,000h
	ld hl,l2c32h
	add hl,de	
	ld a,(0e2d6h)
	cp (hl)	
	ld hl,l2b7ah
	jr c,l2c13h
	ld hl,l2b8dh
	xor a	
	ld (0e2d7h),a
	ld (0e2d6h),a
l2c13h:
	ld (0e2e4h),hl
	ret	
l2c17h:
	ld a,015h
	jr l2c1dh
l2c1bh:
	ld a,016h
l2c1dh:
	ld (ix+006h),a
	ld (ix+001h),009h
	ld (ix+007h),00bh
	ld a,091h
	call sub_0dfeh
l2c2dh:
	xor a	
	ld (0e2d6h),a
	ret	
l2c32h:
	inc b	
	inc bc	
	ld (bc),a	
	ld (bc),a	
l2c36h:
	nop	
	inc bc	
	nop	
	nop	
	nop	
	ld bc,0ff02h
	rst 38h	
	rst 38h	
l2c40h:
	rst 38h	
	rst 38h	
	rst 38h	
	rst 38h	
	cp 0feh
	cp 000h
	nop	
	nop	
	cp 0feh
	inc b	
	inc b	
	inc b	
	cp 009h
	ex af,af'	
	ex af,af'	
	ex af,af'	
	add hl,bc	
	rst 38h	
	rst 38h	
	rst 38h	
	rst 38h	
	rst 38h	
	call sub_2cb9h
	call sub_2c7eh
	ld de,0fe00h
	ld hl,071fah
	jp l20adh
l2c69h:
	dec bc	
	inc e	
	ex af,af'	
	dec e	
	inc de	
	rst 38h	
	ld a,(ix-002h)
	and a	
	ret z	
	dec (ix-002h)
	ret	
sub_2c78h:
	ld a,(0e080h)
	and 0fch
	ret nz	
sub_2c7eh:
	ld hl,(0e80ch)
	ld de,0e800h
	add hl,de	
	ld hl,0e198h
	ld de,0e197h
	jr c,l2c8eh
	ex de,hl	
l2c8eh:
	ld a,(hl)	
	and a	
	ret z	
	ld (de),a	
	ld (hl),000h
	ret	
l2c95h:
	ld a,091h
	call sub_0dfeh
sub_2c9ah:
	ld a,(0e709h)
	sub e	
	jp p,l2cb6h
	call sub_1208h
	jr nz,l2cb6h
	ld a,(0e080h)
	and 007h
	cp 002h
	ld a,004h
	jr nz,l2cb3h
	ld a,005h
l2cb3h:
	ld (0e007h),a
l2cb6h:
	jp sub_2ee2h
sub_2cb9h:
	ld hl,(0e80ch)
	ld de,0f760h
	add hl,de	
	ld hl,0e700h
	res 4,(hl)
	ret c	
	ld a,(ix+001h)
	cp 001h
	ret z	
	ld a,(0e261h)
	and a	
	ret nz	
	set 4,(hl)
	ret	
sub_2cd4h:
	ld hl,(0e2f8h)
	ld a,l	
	or h	
	ret nz	
	ld a,(0e702h)
	cp 009h
	jr z,l2ce6h
	cp 00ah
	jr z,l2ce6h
	ld a,h	
l2ce6h:
	and a	
	ret	
sub_2ce8h:
	ld a,(0e010h)
	ld hl,0e19ch
	ld b,001h
	cp (hl)	
	jr c,l2cf9h
	inc hl	
	inc b	
	cp (hl)	
	jr c,l2cf9h
	inc b	
l2cf9h:
	ld (ix+00bh),b
	ld (ix+001h),004h
	ret	
sub_2d01h:
	push hl	
	ld hl,(0e80ch)
	ld de,0ee00h
	add hl,de	
	pop hl	
	ret nc	
	pop af	
	ret	
sub_2d0dh:
	ld de,l001bh
	jp l1beah
sub_2d13h:
	ld de,l001bh
	jp l1bf2h
sub_2d19h:
	ld a,083h
	call sub_0dfeh
	ld a,091h
	call sub_0dfeh
	push de	
	ld a,(0e706h)
	push hl	
	ld hl,l2d42h
	ld e,a	
	ld d,000h
	add hl,de	
	ld e,(hl)	
	pop hl	
	add hl,de	
	ld a,(0e2e2h)
	sub (hl)	
	ld (0e2e2h),a
	pop de	
	ret nc	
	ld a,087h
	call sub_0dfeh
	scf	
	ret	
l2d42h:
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	ld (bc),a	
	nop	
	ld bc,l0001h
	ld (bc),a	
	nop	
	ld bc,l0001h
	nop	
	nop	
	nop	
	nop	
	ld bc,l0001h
	inc bc	
	inc bc	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
	nop	
l2d67h:
	nop	
	djnz l2d76h
l2d6ah:
	jr nz,l2d78h
	ex af,af'	
l2d6dh:
	jr l2d7fh
	djnz l2d91h
	djnz $+35
	dec hl	
	ex (sp),hl	
	ld a,(hl)	
l2d76h:
	and a	
	ret z	
l2d78h:
	ld b,a	
	inc hl	
l2d7ah:
	push bc	
	ld c,(hl)	
	ld de,000b4h
l2d7fh:
	bit 1,c
	jr z,l2d86h
	ld de,l00d2h
l2d86h:
	bit 4,c
	jr z,l2d91h
	push hl	
	ld hl,l0016h+2
	add hl,de	
	ex de,hl	
	pop hl	
l2d91h:
	ld (0e807h),de
	inc hl	
	ld e,(hl)	
	push hl	
	inc hl	
	ld d,(hl)	
	ld a,(0e700h)
	ld hl,(0e1f7h)
	bit 6,c
	jr z,l2dbeh
	ex de,hl	
	bit 1,a
	jr nz,l2daah
	add hl,de	
l2daah:
	push hl	
	ld de,(0e712h)
	sbc hl,de
	ld (0e80ah),hl
	jr c,l2ddch
	ld de,0f000h
	add hl,de	
	jr c,l2e1ah
	jr l2dd9h
l2dbeh:
	ex de,hl	
	bit 1,a
	jr nz,l2dc5h
	sbc hl,de
l2dc5h:
	push hl	
	jr c,l2e1ah
	ld de,(0e712h)
	sbc hl,de
	ld (0e80ah),hl
	jr nc,l2ddch
	ld de,l1000h
	add hl,de	
	jr nc,l2e1ah
l2dd9h:
	ld hl,(0e80ah)
l2ddch:
	bit 1,a
	jr nz,l2df0h
	bit 4,c
	jr nz,l2df0h
	ld de,l0060h
	add hl,de	
	ld de,l00c0h
	sbc hl,de
	call c,sub_2e31h
l2df0h:
	ld hl,(0e80ah)
	ld d,0ffh
	add hl,hl	
	jr c,l2dfah
	ld d,000h
l2dfah:
	add hl,hl	
	add hl,hl	
	ld e,h	
	ld hl,(0e715h)
	add hl,de	
	ex de,hl	
	ld hl,075a0h
	ld a,c	
	xor 040h
	and 040h
	call l0e20h
	pop de	
	pop hl	
	ld (hl),e	
	inc hl	
	ld (hl),d	
l2e12h:
	inc hl	
	pop bc	
	dec b	
	jp nz,l2d7ah
	ret	
l2e19h:
	pop hl	
l2e1ah:
	ld hl,0e32bh
	ld a,(hl)	
	dec (hl)	
	add a,a	
	add a,(hl)	
	inc hl	
	ld d,000h
	ld e,a	
	add hl,de	
	pop de	
	pop de	
	inc de	
	ld bc,l0003h
	lddr
	ex de,hl	
	jr l2e12h
sub_2e31h:
	bit 1,c
	jr nz,l2e42h
	ld hl,(0e710h)
	ld de,0a600h
	add hl,de	
	ret c	
	ld hl,05a00h
	jr l2e54h
l2e42h:
	ld a,(0e702h)
	cp 006h
	ret z	
	cp 007h
	ret z	
	ld a,(0e706h)
	cp 005h
	ret z	
	ld hl,06900h
l2e54h:
	ld de,00118h
	call sub_2ee2h
	jr l2e19h
sub_2e5ch:
	ld (0e338h),hl
	ex de,hl	
	add hl,hl	
	ld l,h	
	ld h,000h
	jr nc,l2e67h
	inc h	
l2e67h:
	ld (0e336h),hl
	ld a,007h
	ld (0e335h),a
	ret	
l2e70h:
	ld hl,0e335h
	ld a,(hl)	
	and a	
	ret z	
	dec (hl)	
	ret z	
	ld hl,(0e336h)
	push bc	
	ld (0e807h),hl
	ld hl,(0e338h)
	ld de,(0e803h)
	add hl,de	
	ex de,hl	
	xor a	
	ld hl,07484h
	call l0e20h
	pop bc	
	ret	
	ld a,(0e720h)
	cp 003h
	ld a,001h
	jr z,l2e9bh
	xor a	
l2e9bh:
	ld (0e33fh),a
	ld a,(0e701h)
	bit 6,a
	ld hl,0fffeh
	jr z,l2eabh
	ld hl,l0001h+1
l2eabh:
	ld (0e33dh),hl
	ld hl,(0e722h)
	add hl,hl	
	ld l,h	
	ld h,000h
	jr nc,l2eb8h
	inc h	
l2eb8h:
	ld (0e33bh),hl
	ld a,00eh
	ld (0e33ah),a
	ret	
sub_2ec1h:
	ld hl,0e33ah
	ld a,(hl)	
	and a	
	ret z	
	dec (hl)	
	ret z	
	ld hl,(0e33bh)
	push bc	
	ld (0e807h),hl
	ld hl,(0e33dh)
	ld de,(0e715h)
	add hl,de	
	ex de,hl	
	xor a	
	ld hl,07489h
	call l0e20h
	pop bc	
	ret	
sub_2ee2h:
	ld a,(0e71fh)
	and 001h
	jr nz,l2efbh
	ld (0e722h),hl
	ld hl,0e71fh
	set 0,(hl)
	inc hl	
	ld (hl),d	
	inc hl	
	ld (hl),e	
	ld a,083h
	call sub_0dfeh
	ret	
l2efbh:
	ld a,(0e709h)
	sub e	
	jr nc,l2f02h
	xor a	
l2f02h:
	ld (0e709h),a
	ret	
sub_2f06h:
	ld hl,0e64ch
	ld b,004h
l2f0bh:
	ld a,(hl)	
	and a	
	ret z	
	dec (hl)	
	jr z,l2f46h
	push bc	
	inc hl	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	ld (0e807h),de
	inc hl	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
	ld c,(hl)	
	inc hl	
	push hl	
	ld hl,(0e712h)
	ld a,l	
	and 0e0h
	ld l,a	
	ex de,hl	
	sbc hl,de
	push hl	
	ld de,01c00h
	jr c,l2f36h
	sbc hl,de
	jr l2f37h
l2f36h:
	add hl,de	
l2f37h:
	pop hl	
	jr nc,l2f41h
	ld de,075f7h
	xor a	
	call sub_1a9ah
l2f41h:
	pop hl	
	pop bc	
	djnz l2f0bh
	ret	
l2f46h:
	dec b	
	jr z,l2f5dh
	push bc	
	push hl	
	ex de,hl	
	ld hl,l0006h
	add hl,de	
	ld a,b	
	add a,a	
	add a,b	
	add a,a	
	ld c,a	
	ld b,000h
	ldir
	xor a	
	ld (de),a	
	jr l2f41h
l2f5dh:
	ld (hl),000h
	ret	
sub_2f60h:
	push bc	
	push de	
	push hl	
	ld de,0e663h
	ld hl,0e65dh
	ld bc,l0011h+1
	lddr
	ld d,a	
	and 07fh
	ld e,a	
	ld (0e651h),a
	pop hl	
	ld (0e64fh),hl
	pop hl	
	ld (0e64dh),hl
	ld a,0a9h
	bit 7,d
	jr z,l2f85h
	ld a,00bh
l2f85h:
	ld (0e64ch),a
	ld d,000h
	ld hl,l2fadh
	add hl,de	
	add hl,de	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	call sub_2f9ah
	pop bc	
l2f96h:
	ret	
sub_2f97h:
	ld de,l000fh+1
sub_2f9ah:
	ld hl,0e081h
	ld a,(hl)	
	add a,e	
	daa	
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	adc a,d	
	daa	
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	adc a,000h
	daa	
	ld (hl),a	
	ret	
l2fadh:
	jr nz,l2fafh
l2fafh:
	jr nc,l2fb1h
l2fb1h:
	ld b,b	
	nop	
	ld d,b	
	nop	
	ld h,b	
	nop	
	add a,b	
	nop	
	sub b	
	nop	
	nop	
	ld bc,00200h
	nop	
	inc bc	
	nop	
	dec b	
	nop	
	djnz l2fd6h
	nop	
sub_2fc7h:
	ld a,(0e381h)
	and a	
	ret z	
	ld ix,0e382h
	ld b,010h
l2fd2h:
	push bc	
	ld c,(ix+000h)
l2fd6h:
	bit 4,c
	call nz,sub_2fe4h
	pop bc	
	ld de,l0013h
	add ix,de
	djnz l2fd2h
	ret	
sub_2fe4h:
	ld hl,l36e7h
	push hl	
	ld hl,l2ff7h
	ld e,(ix+001h)
	ld d,000h
	add hl,de	
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	jp (hl)	
l2ff7h:
	ld a,a	
	inc sp	
	call nc,sub_1931h
	jr nc,l2f96h
	inc sp	
	call nc,0c833h
	ld (l3049h),a
	xor 031h
	dec h	
	ld (l328bh),a
	ld d,h	
	ld sp,l315dh
	ld h,(hl)	
	ld sp,l3444h
	ld a,b	
	inc (hl)	
	add a,h	
	inc (hl)	
	scf	
	dec (hl)	
	call l1be2h
	ld hl,07000h
	call sub_371dh
	jp c,l30cdh
l3025h:
	call sub_3773h
	jp c,l331eh
	call sub_3746h
	ld a,091h
	jp c,l3327h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),003h
	ld a,(ix+006h)
	inc a	
	cp 004h
	jr nz,l3045h
	ld a,002h
l3045h:
	ld (ix+006h),a
	ret	
l3049h:
	call l1be2h
	dec (ix+008h)
	jp z,l3106h
	ld l,(ix+00eh)
	ld h,(ix+00fh)
	ld de,l0020h
	bit 2,(ix+000h)
	jr z,l306eh
	sbc hl,de
	jr nc,l307bh
	res 2,(ix+000h)
	ld hl,l0000h
	jr l307bh
l306eh:
	add hl,de	
	push hl	
	ld de,0ff80h
	add hl,de	
	pop hl	
	jr nc,l307bh
	set 2,(ix+000h)
l307bh:
	ld (ix+00eh),l
	ld (ix+00fh),h
	ld e,(ix+00ah)
	ld d,(ix+00bh)
	add hl,de	
	ld (ix+002h),l
	ld (ix+003h),h
	ld l,(ix+010h)
	ld h,(ix+011h)
	ld de,00049h
	bit 0,(ix+000h)
	jr z,l30aah
	sbc hl,de
	jr nc,l30b7h
	res 0,(ix+000h)
	ld hl,l0000h
	jr l30b7h
l30aah:
	add hl,de	
	push hl	
	ld de,0fe00h
	add hl,de	
	pop hl	
	jr nc,l30b7h
	set 0,(ix+000h)
l30b7h:
	ld (ix+010h),l
	ld (ix+011h),h
	ld e,(ix+00ch)
	ld d,(ix+00dh)
	add hl,de	
	ld (ix+004h),l
	ld (ix+005h),h
	jp l3025h
l30cdh:
	ld (ix+001h),006h
	ld a,(0e371h)
	ld (ix+008h),a
	ld de,l0040h
	ld l,(ix+002h)
	ld h,(ix+003h)
	sbc hl,de
	ld (ix+00ah),l
	ld (ix+00bh),h
	ld (ix+00eh),e
	ld (ix+00fh),d
	ld de,l0100h
	ld l,(ix+004h)
	ld h,(ix+005h)
	sbc hl,de
	ld (ix+00ch),l
	ld (ix+00dh),h
	ld (ix+010h),e
	ld (ix+011h),d
	ret	
l3106h:
	call sub_333ah
	ld a,086h
	call sub_0dfeh
	ld iy,0e382h
	ld b,010h
	ld c,00ah
	ld l,(ix+002h)
	ld h,(ix+003h)
l311ch:
	bit 4,(iy+000h)
	jr nz,l314ch
	set 4,(iy+000h)
	ld (iy+007h),007h
	ld (iy+006h),014h
	ld (iy+002h),l
	ld (iy+003h),h
	ld de,07400h
	ld (iy+004h),e
	ld (iy+005h),d
	ld (iy+001h),c
	ld a,(0e381h)
	inc a	
	ld (0e381h),a
	ld a,c	
	inc c	
	cp 00ch
	ret z	
l314ch:
	ld de,l0013h
	add iy,de
	djnz l311ch
	ret	
	ld de,(0e376h)
	call sub_1c70h
	jr l316dh
l315dh:
	call l1be2h
	ld de,(0e372h)
	jr l3174h
	ld de,(0e376h)
	call sub_1c7ah
l316dh:
	call l1be2h
	ld de,(0e374h)
l3174h:
	ld hl,05000h
	call sub_3732h
	jp c,l3713h
	ld hl,(0e80ch)
	ld de,l0300h
	sbc hl,de
	jr nc,l31aah
	ld e,(ix+002h)
	ld d,(ix+003h)
	ld hl,0ffe0h
	add hl,de	
	ld (0e80fh),hl
	ld hl,l0020h
	add hl,de	
	ld (0e811h),hl
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0001h
	call sub_1172h
	jp c,l31c0h
l31aah:
	dec (ix+007h)
	ret nz	
	ld (ix+007h),003h
	ld a,(ix+006h)
	inc a	
	cp 016h
	jr nz,l31bch
	ld a,014h
l31bch:
	ld (ix+006h),a
	ret	
l31c0h:
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0120h
	ld a,091h
	call sub_0dfeh
	call sub_2ee2h
	jp l3713h
	call l1be2h
	call sub_3773h
	jp c,l32edh
	call sub_3746h
	ld a,091h
	jp c,l3327h
	ld hl,05000h
	call sub_371dh
	jr c,l3213h
	ret	
	call l1be2h
	dec (ix+007h)
	ret nz	
	inc (ix+006h)
	ld a,(ix+006h)
	cp 010h
	jr nz,l3220h
	inc (ix+001h)
	ld a,(0e80bh)
	bit 7,a
	set 6,(ix+000h)
	jr nz,l3220h
	res 6,(ix+000h)
	jr l3220h
l3213h:
	ld a,086h
	call sub_0dfeh
l3218h:
	ld (ix+001h),007h
	ld (ix+006h),00dh
l3220h:
	ld (ix+007h),007h
	ret	
	call l1be2h
	ld hl,l0140h
	call sub_1220h
	ld a,(0e702h)
	jr nc,l323dh
	cp 004h
	jp z,l32a8h
	cp 005h
	jp z,l32a8h
l323dh:
	cp 006h
	jr z,l3275h
	cp 007h
	jr z,l3275h
	ld a,(0e706h)
	cp 005h
	jr z,l3275h
	bit 5,c
	jr nz,l3275h
	ld a,(ix+006h)
	cp 012h
	jr nz,l3275h
	ld hl,(0e80ah)
	ld de,l067eh+2
	bit 6,c
	jr nz,l3265h
	sbc hl,de
	jr l3266h
l3265h:
	add hl,de	
l3266h:
	jr nc,l3275h
	ld hl,06b00h
	ld de,l0120h
	call sub_36cah
	set 5,(ix+000h)
l3275h:
	dec (ix+007h)
	ret nz	
	ld a,(ix+006h)
	cp 013h
	jp z,l32a2h
	inc (ix+006h)
	ld a,(0e370h)
	ld (ix+007h),a
	ret	
l328bh:
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld a,(ix+006h)
	cp 018h
	jp z,l3713h
	inc (ix+006h)
	ld (ix+007h),007h
	ret	
l32a2h:
	ld (ix+006h),017h
	jr l32bfh
l32a8h:
	ld a,086h
	call sub_0dfeh
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld de,l00dch
	ld a,088h
	call sub_2f60h
	ld (ix+006h),016h
l32bfh:
	ld (ix+001h),009h
	ld (ix+007h),007h
	ret	
	call l1be2h
	dec (ix+007h)
	ret nz	
	ld a,(ix+006h)
	inc (ix+006h)
	ld (ix+007h),007h
	cp 00ch
	ret nz	
	ld a,(ix+00eh)
	and a	
	call m,sub_3cbah
	jp l3713h
l32e6h:
	ld a,093h
	call sub_0dfeh
	jr l32f2h
l32edh:
	ld a,086h
	call sub_0dfeh
l32f2h:
	ld a,(0e701h)
	and 001h
	jr nz,l3300h
	ld b,084h
	ld de,08081h
	jr l3305h
l3300h:
	ld b,082h
	ld de,08c80h
l3305h:
	ld a,r
	and 07fh
	cp 02ah
	jr c,l333ch
	ld b,e	
	cp 055h
	jr c,l333ch
	ld b,d	
	jr l333ch
l3315h:
	ld b,088h
	ld a,086h
	call sub_0dfeh
	jr l333ch
l331eh:
	ld b,087h
	ld a,086h
	call sub_0dfeh
	jr l333ch
l3327h:
	call sub_0dfeh
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0280h
	add hl,de	
	ld de,l0120h
	call sub_36cah
sub_333ah:
	ld b,000h
l333ch:
	ld (ix+00eh),b
	ld (ix+007h),007h
	ld (ix+001h),005h
	ld (ix+006h),00ah
	ret	
l334ch:
	ld a,086h
	call sub_0dfeh
	jr sub_333ah
sub_3353h:
	call sub_36f6h
	ld a,(ix+002h)
	ld (iy+002h),a
	ld a,(ix+003h)
	ld (iy+003h),a
	ld a,(ix+004h)
	ld (iy+004h),a
	ld a,(ix+005h)
	ld (iy+005h),a
	set 4,(iy+000h)
	ld (iy+007h),007h
	ld (iy+001h),005h
	ld (iy+006h),00ah
	ret	
	call l1be2h
	call sub_3773h
	jp c,l32e6h
	call sub_3746h
	ld a,093h
	jr c,l3327h
	ld hl,05000h
	call sub_371dh
	jr c,l33c2h
	ret	
	call l1be2h
	call sub_3773h
	jp c,l32f2h
	dec (ix+007h)
	ret nz	
	ld (ix+007h),005h
	inc (ix+006h)
	ld a,(ix+006h)
	cp 007h
	jr nz,l3432h
l33b3h:
	ld a,(0e80bh)
	bit 7,a
	set 6,(ix+000h)
	ret z	
	res 6,(ix+000h)
	ret	
l33c2h:
	ld (ix+001h),003h
	ld (ix+007h),005h
	ld (ix+006h),004h
	ld a,093h
	call sub_0dfeh
	ret	
	ld de,(0e36eh)
	call sub_1c7ah
	call l1be2h
	ld de,0e400h
	add hl,de	
	jp c,l3713h
	bit 5,c
	jr nz,l341ch
	ld a,(0e702h)
	cp 00ch
	jr z,l341ch
	ld hl,(0e80ah)
	ld de,l00e0h
	bit 6,c
	jr z,l33feh
	sbc hl,de
	jr l33ffh
l33feh:
	add hl,de	
l33ffh:
	jr nc,l341ch
	ld hl,(0e710h)
	ld de,0ad00h
	add hl,de	
	jr c,l341ch
	ld hl,05600h
	ld de,00320h
	ld a,094h
	call sub_0dfeh
	call sub_36cah
	set 5,(ix+000h)
l341ch:
	dec (ix+007h)
	ret nz	
	ld (ix+007h),009h
	ld a,(ix+006h)
	inc a	
	cp 00ah
	jr nz,l342eh
	ld a,008h
l342eh:
	ld (ix+006h),a
	ret	
l3432h:
	cp 008h
	ret nz	
l3435h:
	ld (ix+001h),004h
	ld (ix+006h),008h
	ld (ix+007h),009h
	jp l33b3h
l3444h:
	ld de,(0e372h)
	call sub_1c7ah
	call l1be2h
	call sub_37bfh
	jp c,l3315h
	call sub_3792h
	ld a,091h
	jp c,l3327h
	dec (ix+008h)
	jp z,l356bh
	dec (ix+007h)
	ret z	
	ld (ix+007h),00bh
	ld a,(ix+006h)
	inc a	
	cp 01bh
	jr c,l3474h
	ld a,019h
l3474h:
	ld (ix+006h),a
	ret	
	ld de,(0e374h)
	call sub_1c7ah
	ld hl,(0e36ah)
	jr l348eh
	ld de,(0e376h)
	call sub_1c7ah
	ld hl,(0e36ch)
l348eh:
	ld (0e800h),hl
	call l1be2h
	call sub_37bfh
	jp c,l3315h
	call sub_3792h
	ld a,091h
	jp c,l3327h
	ld de,(0e800h)
	ld hl,05000h
	call sub_3732h
	jr c,l34c4h
	dec (ix+007h)
	ret z	
	ld (ix+007h),00bh
	ld a,(ix+006h)
	inc a	
	cp 01dh
	jr c,l34c0h
	ld a,01bh
l34c0h:
	ld (ix+006h),a
	ret	
l34c4h:
	ld a,086h
	call sub_0dfeh
	ld a,r
	and 003h
	jp z,l3218h
	push af	
	call sub_3353h
	pop af	
	cp 001h
	jp z,l3435h
	jp l3713h
sub_34ddh:
	call sub_36f6h
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld de,00200h
	ld a,(ix+000h)
	and 040h
	jr z,l34f3h
	add hl,de	
	jr l34f5h
l34f3h:
	sbc hl,de
l34f5h:
	ld (iy+002h),l
	ld (iy+003h),h
	xor 050h
	ld (iy+000h),a
	ld a,(ix+00eh)
	add a,00ch
	ld (iy+001h),a
	add a,a	
	ld e,a	
	ld d,000h
	ld hl,03517h
	add hl,de	
	ld e,(hl)	
	ld (iy+004h),e
	inc hl	
	ld e,(hl)	
	ld (iy+005h),e
	ld (iy+007h),00bh
	cp 01ah
	jr nz,l352ch
	ld (iy+006h),019h
l3525h:
	ld a,(0e365h)
	ld (iy+008h),a
	ret	
l352ch:
	ld (iy+006h),01bh
	ret	
	nop	
	ld h,(hl)	
	nop	
	ld e,a	
	nop	
	ld e,d	
	ld de,(0e363h)
	call sub_1c7ah
	call l1be2h
	call sub_3773h
	jp c,l3315h
	call sub_3746h
	ld a,094h
	jp c,l3327h
	dec (ix+008h)
	jp z,l334ch
	dec (ix+007h)
	ret nz	
	ld (ix+007h),00bh
	ld a,(ix+006h)
	inc a	
	cp 01fh
	jr c,l3567h
	ld a,01dh
l3567h:
	ld (ix+006h),a
	ret	
l356bh:
	call sub_3353h
	ld a,086h
	call sub_0dfeh
	ld a,r
	and 001h
	jp z,l3713h
	ld a,040h
	xor (ix+000h)
	ld (ix+000h),a
	ld (ix+001h),010h
	ld (ix+006h),01dh
	ld (ix+007h),00bh
	ld a,(0e366h)
	ld (ix+008h),a
	ret	
sub_3595h:
	ld a,(0e360h)
	ld de,(0e712h)
	ld hl,(0e361h)
	sbc hl,de
	jr c,l35aeh
	ld hl,(0e363h)
	sbc hl,de
	jr c,l35b5h
	cp 001h
	jr l35afh
l35aeh:
	and a	
l35afh:
	ret nz	
	xor a	
	ld (0e100h),a
	ret	
l35b5h:
	ld hl,0e380h
	dec (hl)	
	ret nz	
	inc (hl)	
	inc hl	
	ld a,(hl)	
	cp 010h
	ret nc	
	ld a,(0e017h)
	ld hl,0e36ah
	ld e,000h
	cp (hl)	
	jr c,l35e8h
	inc hl	
	inc e	
	cp (hl)	
	jr c,l35e8h
	inc e	
	ld a,(0e016h)
	cp 07fh
	ld a,0f8h
	jr c,l35dch
	ld a,006h
l35dch:
	ld hl,0e701h
	bit 6,(hl)
	jr nz,l35e5h
	neg
l35e5h:
	ld d,a	
	jr l360bh
l35e8h:
	ld a,(0e016h)
	ld d,0f7h
	cp 02ah
	jr c,l360bh
	ld d,0fah
	cp 055h
	jr c,l360bh
	ld d,0fdh
	cp 07fh
	jr c,l360bh
	ld d,003h
	cp 0aah
	jr c,l360bh
	ld d,006h
	cp 0d4h
	jr c,l360bh
	ld d,009h
l360bh:
	ld a,(0e702h)
	cp 001h
	jr z,l3618h
	cp 009h
	ld a,003h
	jr nz,l361ah
l3618h:
	ld a,006h
l361ah:
	ld hl,0e701h
	bit 6,(hl)
	jr z,l3623h
	neg
l3623h:
	cp d	
	jr nz,l3628h
	ld d,000h
l3628h:
	ld a,(0e702h)
	cp 001h
	jr z,l3635h
	cp 009h
	ld a,003h
	jr nz,l3637h
l3635h:
	ld a,009h
l3637h:
	bit 6,(hl)
	jr nz,l363dh
	neg
l363dh:
	add a,d	
	ld d,a	
	ld a,(0e713h)
	add a,d	
	ld d,a	
	set 0,d
	ex de,hl	
	ld ix,0e36fh
	ld de,l0013h
	ld b,010h
l3650h:
	add ix,de
	bit 4,(ix+000h)
	jr z,l366ch
	ld a,(ix+001h)
	cp 003h
	jr c,l3667h
	cp 006h
	jr c,l366ch
	cp 009h
	jr nc,l366ch
l3667h:
	ld a,(ix+012h)
	cp h	
	ret z	
l366ch:
	djnz l3650h
	ex de,hl	
	ld a,(0e015h)
	ld hl,0e365h
	call sub_1214h
	ld hl,0e380h
	ld (hl),a	
	inc hl	
	inc (hl)	
	ld ix,0e36fh
	ld bc,l0013h
l3685h:
	add ix,bc
	bit 4,(ix+000h)
	jr nz,l3685h
	ld a,r
	and 040h
	or 010h
	ld (ix+000h),a
	ld (ix+001h),e
	ld (ix+006h),e
	ld (ix+012h),d
	ld (ix+003h),d
	ld (ix+002h),000h
	ld hl,09000h
	ld (ix+004h),l
	ld (ix+005h),h
	ld (ix+007h),003h
	ld hl,0000ah
	ld de,l007dh
	ld (ix+00ah),l
	ld (ix+00bh),h
	ld hl,(0e36ch)
	add hl,de	
	ld (ix+00ch),l
	ld (ix+00dh),h
	ret	
sub_36cah:
	ld a,(0e080h)
	and 007h
	cp 003h
	jr nz,l36e4h
	ld a,(0e709h)
	sub e	
	jp p,l36e4h
	call sub_1208h
	jr nz,l36e4h
	ld a,005h
	ld (0e007h),a
l36e4h:
	jp sub_2ee2h
l36e7h:
	ld hl,(0e80ch)
	ld de,0e400h
	add hl,de	
	ret c	
	ld hl,0748eh
	ld a,c	
	jp l1a7eh
sub_36f6h:
	ld a,(0e381h)
	cp 010h
	jr nc,l3711h
	inc a	
	ld (0e381h),a
	ld iy,0e36fh
	ld de,l0013h
l3708h:
	add iy,de
	bit 4,(iy+000h)
	jr nz,l3708h
	ret	
l3711h:
	pop af	
	ret	
l3713h:
	ld (ix+000h),000h
	ld hl,0e381h
	dec (hl)	
	pop af	
	ret	
sub_371dh:
	push hl	
	ld l,(ix+00ah)
	ld h,(ix+00bh)
	ld e,(ix+00ch)
	ld d,(ix+00dh)
	add hl,de	
	ld (ix+00ch),l
	ld (ix+00dh),h
	pop hl	
sub_3732h:
	push hl	
	and a	
	ld l,(ix+004h)
	ld h,(ix+005h)
	sbc hl,de
	ld (ix+004h),l
	ld (ix+005h),h
	pop de	
	sbc hl,de
	ret	
sub_3746h:
	ld hl,(0e80ch)
	ld de,l0300h
	sbc hl,de
	ret nc	
	ld e,(ix+002h)
	ld d,(ix+003h)
	ld hl,0ff80h
	add hl,de	
	ld (0e80fh),hl
	ld hl,l0080h
	add hl,de	
	ld (0e811h),hl
l3763h:
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0080h
	add hl,de	
	ld de,l0006h+2
	jp sub_1172h
sub_3773h:
	ld hl,l0140h
	call sub_1220h
	ret nc	
	and a	
	ld l,(ix+004h)
	ld h,(ix+005h)
	sbc hl,de
	ret nc	
	ld hl,0f800h
	add hl,de	
	ld e,(ix+004h)
	ld d,(ix+005h)
	and a	
	sbc hl,de
	ret	
sub_3792h:
	ld hl,(0e80ch)
	ld de,l0300h
	sbc hl,de
	ret nc	
	ld e,(ix+002h)
	ld d,(ix+003h)
	ld hl,0ffc0h
	add hl,de	
	ld (0e80fh),hl
	ld hl,l0040h
	add hl,de	
	ld (0e811h),hl
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,l0080h
	add hl,de	
	ld de,l0003h+1
	jp sub_1172h
sub_37bfh:
	ld hl,l00e0h
	call sub_1220h
	ret nc	
	and a	
	ld l,(ix+004h)
	ld h,(ix+005h)
	sbc hl,de
	ret nc	
	ld hl,0fb80h
	add hl,de	
	ld e,(ix+004h)
	ld d,(ix+005h)
	and a	
	sbc hl,de
	ret	
sub_37deh:
	ld hl,(0e712h)
	ld de,08000h
	add hl,de	
	jr c,l37f1h
	call sub_37f6h
	call sub_38ffh
	call sub_3960h
	ret	
l37f1h:
	xor a	
	ld (0e100h),a
	ret	
sub_37f6h:
	ld b,004h
	ld hl,0e572h
l37fbh:
	ld a,(hl)	
	and a	
	jr z,l3804h
	dec (hl)	
l3800h:
	inc hl	
	djnz l37fbh
	ret	
l3804h:
	push bc	
	push hl	
	ld a,(0e080h)
	cp 010h
	ld hl,l38dbh
	jr c,l3813h
	ld hl,l38ebh
l3813h:
	ld d,000h
	ld e,b	
	rlc e
	rlc e
	add hl,de	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	push hl	
	ld bc,(0e712h)
	ld hl,sub_0f3fh+1
	add hl,bc	
	sbc hl,de
	jp c,l38d9h
	ld hl,0f0c0h
	add hl,bc	
	sbc hl,de
	jp nc,l38d9h
	ld hl,0e576h
	ld a,(0e50bh)
	cp (hl)	
	jp c,l38d9h
	inc (hl)	
	ld iy,0e562h
	ld bc,l0013h+2
l3847h:
	add iy,bc
	bit 4,(iy+000h)
	jr nz,l3847h
	ld (iy+002h),e
	ld (iy+003h),d
	ld hl,(0e712h)
	ld a,010h
	sbc hl,de
	jr c,l3860h
	ld a,050h
l3860h:
	ld (iy+000h),a
	call sub_3dc5h
	push de	
	ld a,(0e012h)
	ld hl,0e50dh
	cp (hl)	
	jr nc,l387fh
	set 1,(iy+014h)
	and 002h
	ld a,038h
	jr z,l387ch
	ld a,0a9h
l387ch:
	ld (iy+013h),a
l387fh:
	ld a,(0e013h)
	ld hl,0e50eh
	cp (hl)	
	jr nc,l3896h
	set 0,(iy+014h)
	and 002h
	inc hl	
	jr z,l3892h
	inc hl	
l3892h:
	ld a,(hl)	
	ld (iy+012h),a
l3896h:
	pop de	
	pop hl	
	inc hl	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld (iy+004h),l
	ld (iy+005h),h
	sbc hl,de
	ld (iy+00ch),l
	ld (iy+00dh),h
	push af	
	ld a,(iy+001h)
	add a,004h
	ld (iy+001h),a
	cp 004h
	jr z,l38c1h
	pop af	
	ld a,r
	bit 0,a
	jr z,l38c4h
	jr l38c8h
l38c1h:
	pop af	
	jr c,l38c8h
l38c4h:
	set 3,(iy+000h)
l38c8h:
	ld (iy+006h),006h
	ld (iy+007h),010h
	ld a,(0e50ah)
	pop hl	
	ld (hl),a	
	pop bc	
	jp l3800h
l38d9h:
	pop hl	
	pop hl	
l38dbh:
	pop bc	
	jp l3800h
	nop	
	ld (hl),c	
	nop	
	add a,b	
	nop	
	ld e,e	
	nop	
	ld d,h	
	nop	
	dec a	
	nop	
	ld (hl),b	
l38ebh:
	nop	
	inc hl	
	nop	
	add a,b	
	nop	
	ld (hl),c	
	nop	
	add a,b	
	nop	
	ld e,e	
	nop	
	ld (hl),b	
	nop	
	dec a	
	nop	
	ld (hl),b	
	nop	
	inc hl	
	nop	
	add a,b	
sub_38ffh:
	ld a,(0e520h)
	and a	
	ret z	
	ld b,a	
	ld ix,0e521h
l3909h:
	ld l,(ix+000h)
	ld h,(ix+001h)
l390fh:
	ld de,l0029h
	sbc hl,de
	ex de,hl	
	ld hl,l0800h
	sbc hl,de
	jr c,l3921h
	call sub_3d0eh
	jr l3945h
l3921h:
	ld (ix+000h),e
	ld (ix+001h),d
	ld hl,(0e712h)
	sbc hl,de
	jr c,l3938h
	ld de,0f000h
	add hl,de	
	jr c,l3959h
	ld c,0ffh
	jr l3940h
l3938h:
	ld de,l1000h
	add hl,de	
	jr nc,l3959h
	ld c,000h
l3940h:
	push bc	
	call sub_3d55h
	pop bc	
l3945h:
	ld hl,0e520h
	dec (hl)	
	ret z	
	dec b	
	ret z	
	ld a,(hl)	
	inc hl	
	rlca	
	ld d,000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	jr l390fh
l3959h:
	inc ix
	inc ix
	djnz l3909h
	ret	
sub_3960h:
	ld a,(0e549h)
	and a	
	ret z	
	ld b,a	
	ld ix,0e54ah
l396ah:
	ld l,(ix+000h)
	ld h,(ix+001h)
l3970h:
	ld de,l0029h
	add hl,de	
	ex de,hl	
	ld hl,08000h
	sbc hl,de
	jr nc,l3981h
	call sub_3d09h
	jr l39a5h
l3981h:
	ld (ix+000h),e
	ld (ix+001h),d
	ld hl,(0e712h)
	sbc hl,de
	jr c,l3998h
	ld de,0f000h
	add hl,de	
	jr c,l39b9h
	ld c,0ffh
	jr l39a0h
l3998h:
	ld de,l1000h
	add hl,de	
	jr nc,l39b9h
	ld c,000h
l39a0h:
	push bc	
	call sub_3d59h
	pop bc	
l39a5h:
	ld hl,0e549h
	dec (hl)	
	ret z	
	dec b	
	ret z	
	ld a,(hl)	
	inc hl	
	rlca	
	ld d,000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	jr l3970h
l39b9h:
	inc ix
	inc ix
	djnz l396ah
	ret	
sub_39c0h:
	ld a,(0e576h)
	and a	
	ret z	
	ld ix,0e577h
	ld a,(0e50bh)
	ld b,a	
l39cdh:
	push bc	
	ld c,(ix+000h)
	bit 4,c
	call nz,sub_39dfh
	pop bc	
	ld de,l0013h+2
	add ix,de
	djnz l39cdh
	ret	
sub_39dfh:
	ld a,(ix+001h)
	cp 004h
	jr c,l39f1h
	cp 007h
	jp c,l3c3bh
	jp z,l3be9h
	jp l3b1fh
l39f1h:
	dec (ix+007h)
	jr nz,l3a03h
	ld (ix+007h),005h
	dec (ix+006h)
	jr z,l3a03h
	ld (ix+006h),001h
l3a03h:
	bit 1,(ix+014h)
	jr z,l3a26h
	dec (ix+013h)
	jr nz,l3a26h
	bit 2,(ix+014h)
	jr nz,l3a1eh
	set 2,(ix+014h)
	ld (ix+013h),0a9h
	jr l3a26h
l3a1eh:
	res 2,(ix+014h)
	res 1,(ix+014h)
l3a26h:
	bit 0,(ix+014h)
	jr z,l3a32h
	dec (ix+012h)
	jp z,l3b92h
l3a32h:
	ld l,(ix+002h)
	ld h,(ix+003h)
	ld e,(ix+010h)
	ld d,(ix+011h)
	bit 2,(ix+014h)
	jr z,l3a47h
	ld de,l0000h
l3a47h:
	bit 6,c
	jr nz,l3a5eh
	sbc hl,de
	ex de,hl	
	ld hl,0f400h
	add hl,de	
	jr c,l3a70h
	set 6,(ix+000h)
	ld hl,l3eabh
	jp l3baah
l3a5eh:
	add hl,de	
	ex de,hl	
	ld hl,08400h
	add hl,de	
	jr nc,l3a70h
	res 6,(ix+000h)
	ld hl,l3e7fh
	jp l3baah
l3a70h:
	ld (ix+002h),e
	ld (ix+003h),d
	push de	
	ld hl,(0e712h)
	sbc hl,de
	ld de,l1100h
	jr c,l3a89h
	sbc hl,de
	pop de	
	jr c,l3a94h
	jp l3cfbh
l3a89h:
	add hl,de	
	pop de	
	jr c,l3a94h
	ld hl,0df00h
	add hl,de	
	jp c,l3cfbh
l3a94h:
	cp 003h
	jr z,l3af4h
	call sub_3d22h
	dec a	
	jp m,l3ae4h
	push de	
	ld l,(ix+00ch)
	ld h,(ix+00dh)
	jr z,l3aaeh
	ld de,(0e504h)
	jr l3ab2h
l3aaeh:
	ld de,(0e506h)
l3ab2h:
	bit 3,c
	jr z,l3ac3h
	sbc hl,de
	ex de,hl	
	bit 7,d
	jr z,l3adbh
	res 3,(ix+000h)
	jr l3adbh
l3ac3h:
	add hl,de	
	ex de,hl	
	bit 7,d
	jr nz,l3adbh
	and a	
	jr z,l3ad1h
	ld hl,0ec00h
	jr l3ad4h
l3ad1h:
	ld hl,0f000h
l3ad4h:
	add hl,de	
	jr nc,l3adbh
	set 3,(ix+000h)
l3adbh:
	ld (ix+00ch),e
	ld (ix+00dh),d
	pop hl	
	add hl,de	
	ex de,hl	
l3ae4h:
	ld l,(ix+008h)
	ld h,(ix+009h)
	add hl,de	
	ld (ix+004h),l
	ld (ix+005h),h
	jp l3c7ah
l3af4h:
	call sub_3d22h
	push de	
	ld de,(0e504h)
	ld l,(ix+00ch)
	ld h,(ix+00dh)
	bit 3,c
	jr z,l3b0ah
	sbc hl,de
	jr l3b0bh
l3b0ah:
	add hl,de	
l3b0bh:
	jr nc,l3b14h
	ld (ix+001h),000h
	ld hl,l0000h
l3b14h:
	ld (ix+00ch),l
	ld (ix+00dh),h
	pop de	
	add hl,de	
	ex de,hl	
	jr l3ae4h
l3b1fh:
	ld l,(ix+00eh)
	ld h,(ix+00fh)
	dec (ix+007h)
	jr nz,l3b33h
	ld de,l0003h+2
	add hl,de	
	call sub_3bd5h
	jr z,l3b57h
l3b33h:
	ld a,(hl)	
	add a,(ix+002h)
	ld (ix+002h),a
	inc hl	
	ld a,(hl)	
	adc a,(ix+003h)
	ld (ix+003h),a
	inc hl	
	ld a,(hl)	
	add a,(ix+004h)
	ld (ix+004h),a
	inc hl	
	ld a,(hl)	
	adc a,(ix+005h)
	ld (ix+005h),a
	inc hl	
	ld c,(hl)	
	jp l3c7ah
l3b57h:
	ld (ix+00ah),000h
	ld (ix+006h),000h
	ld (ix+007h),005h
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld e,(ix+008h)
	ld d,(ix+009h)
	sbc hl,de
	ld (ix+00ch),l
	ld (ix+00dh),h
	ld a,(ix+001h)
	sub 008h
	jr nz,l3b8ch
	ld a,003h
	res 3,(ix+000h)
	bit 7,h
	jr nz,l3b8ch
	set 3,(ix+000h)
l3b8ch:
	ld (ix+001h),a
	jp l3c7ah
l3b92h:
	res 0,(ix+014h)
	bit 6,(ix+000h)
	ld hl,l3e7fh
	res 6,(ix+000h)
	jr nz,l3baah
	set 6,(ix+000h)
	ld hl,l3eabh
l3baah:
	push hl	
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,09800h
	add hl,de	
	pop hl	
	jr nc,l3bbch
	ld de,l0016h
	add hl,de	
l3bbch:
	call sub_3bd5h
	ld de,l0003h+1
	add hl,de	
	ld c,(hl)	
	ld a,(ix+001h)
	add a,008h
	cp 00bh
	jr nz,l3bcfh
	ld a,008h
l3bcfh:
	ld (ix+001h),a
	jp l3c7ah
sub_3bd5h:
	ld a,(hl)	
	cp 0ffh
	ret z	
	ld (ix+007h),a
	inc hl	
	ld a,(hl)	
	ld (ix+006h),a
	inc hl	
	ld (ix+00eh),l
	ld (ix+00fh),h
	ret	
l3be9h:
	dec (ix+007h)
	jp nz,l3ca9h
	ld a,(ix+006h)
	cp 009h
	jr z,l3c00h
	ld (ix+007h),005h
	inc (ix+006h)
	jp l3ca9h
l3c00h:
	ld a,(ix+00eh)
	and a	
	jp z,l3cf2h
	call sub_3cbah
	jp l3cf2h
l3c0dh:
	ld a,086h
	call sub_0dfeh
	ld a,(0e701h)
	and 001h
	ld a,083h
	jr nz,l3c2ah
	inc a	
	jr l3c2ah
l3c1eh:
	ld de,00115h
	call sub_2ee2h
	ld a,094h
	call sub_0dfeh
	xor a	
l3c2ah:
	ld (ix+00eh),a
	ld (ix+007h),005h
	ld (ix+006h),007h
	ld (ix+001h),007h
	jr l3ca9h
l3c3bh:
	dec (ix+007h)
	jr z,l3c66h
	ld a,(0eb00h)
	push af	
	ld a,001h
	ld (0eb00h),a
	ld hl,(0eb01h)
	push hl	
	ld hl,(0eb03h)
	ld de,0fff8h
	add hl,de	
	ld (0eb01h),hl
	ld (0eb03h),hl
	call l3ca9h
	pop hl	
	ld (0eb01h),hl
	pop af	
	ld (0eb00h),a
	ret	
l3c66h:
	ld (ix+006h),000h
	ld (ix+007h),005h
	ld a,(ix+001h)
	sub 004h
	jr nz,l3c77h
	ld a,003h
l3c77h:
	ld (ix+001h),a
l3c7ah:
	call sub_3ccfh
	jp c,l3c0dh
	ld e,(ix+002h)
	ld d,(ix+003h)
	ld hl,0ffc0h
	add hl,de	
	ld (0e80fh),hl
	ld hl,l0080h
	add hl,de	
	ld (0e811h),hl
	ld l,(ix+004h)
	ld h,(ix+005h)
	ld de,00200h
	add hl,de	
	ld de,l0006h
	push hl	
	call sub_1172h
	pop hl	
	jp c,l3c1eh
l3ca9h:
	call l1be2h
	ld de,0e400h
	add hl,de	
	ret c	
	ld hl,075c0h
	ld a,c	
	xor 040h
	jp l1a80h
sub_3cbah:
	ld l,(ix+004h)
	ld h,(ix+005h)
	add hl,hl	
	ld d,000h
	rl d
	ld e,h	
	ld l,(ix+002h)
	ld h,(ix+003h)
	jp sub_2f60h
sub_3ccfh:
	ld hl,l0140h
	call sub_1220h
	ret nc	
	ld hl,l017fh+1
	add hl,de	
	ex de,hl	
	ld l,(ix+004h)
	ld h,(ix+005h)
	sbc hl,de
	ret nc	
	ld hl,0f380h
	add hl,de	
	ld e,(ix+004h)
	ld d,(ix+005h)
	and a	
	sbc hl,de
	ret	
l3cf2h:
	ld hl,0e576h
	dec (hl)	
	ld (ix+000h),000h
	ret	
l3cfbh:
	ld hl,0e576h
	dec (hl)	
	bit 6,(ix+000h)
	ld (ix+000h),000h
	jr nz,sub_3d0eh
sub_3d09h:
	ld hl,0e520h
	jr l3d11h
sub_3d0eh:
	ld hl,0e549h
l3d11h:
	ld a,(hl)	
	cp 014h
	ret z	
	inc (hl)	
	inc hl	
	push bc	
	rlca	
	ld b,000h
	ld c,a	
	add hl,bc	
	ld (hl),e	
	inc hl	
	ld (hl),d	
	pop bc	
	ret	
sub_3d22h:
	ld l,(ix+00ah)
	ld h,(ix+00bh)
	ld de,(0e508h)
	bit 2,(ix+000h)
	jr z,l3d40h
	sbc hl,de
	ex de,hl	
	jr nc,l3d4ch
	res 2,(ix+000h)
	ld de,l0000h
	jr l3d4ch
l3d40h:
	add hl,de	
	ex de,hl	
	ld hl,0fc00h
	add hl,de	
	jr nc,l3d4ch
	set 2,(ix+000h)
l3d4ch:
	ld (ix+00ah),e
	ld (ix+00bh),d
	ret	
l3d53h:
	ld c,000h
sub_3d55h:
	ld b,010h
	jr l3d5bh
sub_3d59h:
	ld b,050h
l3d5bh:
	ld hl,0e576h
	ld a,(0e50bh)
	cp (hl)	
	ret c	
	inc (hl)	
	ld iy,0e562h
	ld de,l0013h+2
l3d6bh:
	add iy,de
	bit 4,(iy+000h)
	jr nz,l3d6bh
	ld a,r
	and 00ch
	or b	
	ld (iy+000h),a
	ld hl,(0e712h)
	ld de,l1080h
	bit 0,c
	jr z,l3d89h
	sbc hl,de
	jr l3d93h
l3d89h:
	add hl,de	
	ld de,l2080h
	sbc hl,de
	add hl,de	
	jr nc,l3d93h
	ex de,hl	
l3d93h:
	ld (iy+002h),l
	ld (iy+003h),h
	ld (iy+007h),005h
	ld (iy+006h),000h
	call sub_3dc5h
	ld a,(iy+001h)
	cp 001h
	ret c	
	ld hl,l3e5fh
	jr z,l3db2h
	ld hl,03e6fh
l3db2h:
	ld a,(0e010h)
	and 00eh
	ld d,000h
	ld e,a	
	add hl,de	
	ld a,(hl)	
	ld (iy+00ch),a
	inc hl	
	ld a,(hl)	
	ld (iy+00dh),a
	ret	
sub_3dc5h:
	ld hl,0e649h
	ld a,(hl)	
	and a	
	jr nz,l3ddbh
	ld (hl),003h
	ld a,r
	and 01ch
	ld hl,l3e1fh
	ld d,000h
	ld e,a	
	add hl,de	
	jr l3ddfh
l3ddbh:
	dec (hl)	
	ld hl,(0e64ah)
l3ddfh:
	ld a,(hl)	
	inc hl	
	ld (0e64ah),hl
	ld (iy+001h),a
	ld (iy+014h),000h
	ld hl,l3e3fh
	and a	
	jr z,l3df4h
	ld hl,l3e4fh
l3df4h:
	ld a,r
	and 00eh
	ld d,000h
	ld e,a	
	add hl,de	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	ld (iy+008h),e
	ld (iy+009h),d
	ld (iy+00bh),002h
	ld a,(0e011h)
	ld hl,0e50ch
	cp (hl)	
	ld hl,(0e500h)
	jr c,l3e18h
	ld hl,(0e502h)
l3e18h:
	ld (iy+010h),l
	ld (iy+011h),h
	ret	
l3e1fh:
	ld (bc),a	
	nop	
	ld bc,l0100h
	ld (bc),a	
	nop	
	nop	
	nop	
	nop	
	ld (bc),a	
	ld bc,l0100h
	nop	
	ld (bc),a	
	ld (bc),a	
	nop	
	nop	
	ld bc,00200h
	ld bc,l0000h
	ld bc,l0001h+1
	ld bc,l0000h
	ld (bc),a	
l3e3fh:
	nop	
	ld d,b	
	add a,b	
	ld d,h	
	nop	
	ld e,c	
	add a,b	
	ld e,l	
	nop	
	ld h,d	
	add a,b	
	ld h,(hl)	
	nop	
	ld l,e	
	add a,b	
	ld l,a	
l3e4fh:
	nop	
	ld c,(hl)	
	add a,b	
	ld d,c	
	nop	
	ld d,l	
	add a,b	
	ld e,b	
	nop	
	ld e,h	
	add a,b	
	ld e,a	
	nop	
	ld h,e	
	add a,b	
	ld h,(hl)	
l3e5fh:
	nop	
	nop	
	add a,b	
	ld (bc),a	
	nop	
	dec b	
	nop	
	rlca	
	add a,b	
	add hl,bc	
	add a,b	
	dec bc	
	nop	
	ld c,000h
	djnz l3e70h
l3e70h:
	nop	
	nop	
	inc bc	
	nop	
	ld b,080h
	ex af,af'	
	add a,b	
	dec bc	
	nop	
	ld c,000h
	inc c	
	nop	
	inc d	
l3e7fh:
	ld (de),a	
	ld (bc),a	
	ld hl,(04700h)
	nop	
	ld b,b	
	ld (de),a	
	inc bc	
	nop	
	nop	
	adc a,(hl)	
	nop	
	ld b,b	
	ld (de),a	
	ld (bc),a	
	sub 0ffh
	ld b,a	
	nop	
	nop	
	rst 38h	
	ld (de),a	
	inc b	
	ld hl,(0b900h)
	rst 38h	
	ret nz	
	ld (de),a	
	dec b	
	nop	
	nop	
	ld (hl),d	
	rst 38h	
	ret nz	
	ld (de),a	
	inc b	
	sub 0ffh
	cp c	
	rst 38h	
	add a,b	
	rst 38h	
l3eabh:
	ld (de),a	
	ld (bc),a	
	sub 0ffh
	ld b,a	
	nop	
	nop	
	ld (de),a	
	inc bc	
	nop	
	nop	
	adc a,(hl)	
	nop	
	nop	
	ld (de),a	
	ld (bc),a	
	ld hl,(04700h)
	nop	
	ld b,b	
	rst 38h	
	ld (de),a	
	inc b	
	sub 0ffh
	cp c	
	rst 38h	
	add a,b	
	ld (de),a	
	dec b	
	nop	
	nop	
	ld (hl),d	
	rst 38h	
	add a,b	
	ld (de),a	
	inc b	
	ld hl,(0b900h)
	rst 38h	
	ret nz	
	rst 38h	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l3f0ah:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
