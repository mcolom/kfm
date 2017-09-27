; z80dasm 1.1.4
; command line: z80dasm -g0x4000 -l roms/a-4d-c.bin

	org	04000h

l4000h:
	ld hl,(0e712h)
	ld de,(0e707h)
	ld a,(0e080h)
	and 001h
	jr z,l400fh
	ex de,hl	
l400fh:
	sbc hl,de
	ld a,001h
	jr nc,l4017h
	ld a,000h
l4017h:
	ld (0e702h),a
	jr c,l402ch
	ld hl,0e703h
	ld a,(hl)	
	dec (hl)	
	and a	
	jr nz,l402ch
	call sub_433fh
	ld a,090h
	call 00dfeh
l402ch:
	ld hl,(0e712h)
	ld a,(0e71ah)
	and a	
	jp nz,l40adh
	ld a,(0e000h)
	cp 003h
	jr z,l40adh
	ld a,(0e702h)
	cp 00bh
	jr z,l40adh
	jr nc,l4080h
	cp 009h
	jr nc,l4055h
	cp 001h
	jr nz,l40adh
	ld a,(0e706h)
	cp 004h
	jr z,l40adh
l4055h:
	ld a,(0e700h)
	bit 5,a
	ld a,(0e701h)
	ld de,00029h
	jr z,l4089h
	and 020h
	jr nz,l40adh
	add hl,de	
	ld de,0db00h
	sbc hl,de
	add hl,de	
	jr c,l4070h
	ex de,hl	
l4070h:
	push hl	
	ld a,h	
	sub 00fh
	ld hl,0e714h
	cp (hl)	
	jr nz,l40a9h
	inc (hl)	
	ld a,(hl)	
	add a,01fh
	jr l40a6h
l4080h:
	ld a,(0e700h)
	and 020h
	jr nz,l4098h
	jr l4070h
l4089h:
	and 010h
	jr nz,l40adh
	sbc hl,de
	ld de,00400h
	sbc hl,de
	add hl,de	
	jr nc,l4098h
	ex de,hl	
l4098h:
	push hl	
	ld a,010h
	add a,h	
	ld hl,0e714h
	cp (hl)	
	jr nz,l40a9h
	dec (hl)	
	ld a,(hl)	
	add a,0e0h
l40a6h:
	call sub_5765h
l40a9h:
	pop hl	
	ld (0e712h),hl
l40adh:
	xor a	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	ld l,h	
	ld h,a	
	ld de,00080h
	sbc hl,de
	jr c,l40ceh
	add hl,de	
	ld de,00680h
	sbc hl,de
	jr nc,l40ceh
	add hl,de	
	ld (0e900h),hl
	ld hl,00100h
	jr l40d6h
l40ceh:
	ld (0e900h),de
	ld de,00100h
	add hl,de	
l40d6h:
	ld (0e715h),hl
	xor a	
	ld hl,(0e710h)
	add hl,hl	
	rla	
	ld l,h	
	ld h,a	
	ld (0e717h),hl
	ret	
sub_40e5h:
	ld hl,(0e717h)
	ld (0e807h),hl
	ld a,(0e706h)
	add a,a	
	ld hl,l65ffh
	ld b,000h
	ld c,a	
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld a,(0e701h)
	and 040h
	ld de,(0e715h)
	call 00e20h
	ld a,(0e000h)
	cp 005h
	ret z	
	cp 007h
	ret z	
	cp 003h
	ld hl,(0e900h)
	jr nz,l4134h
	ex de,hl	
	ld hl,(0e902h)
	ld a,(0e101h)
	ld bc,00002h
	and a	
	jr nz,l412bh
	sbc hl,bc
	sbc hl,de
	jr nc,l4130h
	jr l4133h
l412bh:
	add hl,bc	
	sbc hl,de
	jr nc,l4133h
l4130h:
	add hl,de	
	jr l4134h
l4133h:
	ex de,hl	
l4134h:
	ld (0e902h),hl
	ld a,(0e33fh)
	and a	
	call z,02ec1h
	ret	
	call 01208h
	jr nz,l4150h
	ld hl,(0e003h)
	ld a,h	
	or l	
	jr nz,l4150h
	ld hl,0e71fh
	set 1,(hl)
l4150h:
	call sub_4174h
	ld hl,0e700h
	bit 4,(hl)
	jr z,l4168h
	bit 5,(hl)
	jr z,l4163h
	bit 6,(hl)
	jr nz,l4170h
	ret	
l4163h:
	bit 6,(hl)
	jr z,l416ch
	ret	
l4168h:
	bit 5,(hl)
	jr nz,l4170h
l416ch:
	inc hl	
	res 6,(hl)
	ret	
l4170h:
	inc hl	
	set 6,(hl)
	ret	
sub_4174h:
	ld hl,0e719h
	dec (hl)	
	jp nz,l419ah
	ld a,(0e080h)
	and 018h
	cp 008h
	ld d,000h
	jr c,l4192h
	ld d,0a9h
	jr z,l4192h
	cp 010h
	ld d,070h
	jr z,l4192h
	ld d,038h
l4192h:
	ld (hl),d	
	ld hl,0e701h
	ld a,(hl)	
	xor 080h
	ld (hl),a	
l419ah:
	ld a,(0e000h)
	cp 003h
	jp z,l46a0h
	call sub_4704h
	ld hl,0e702h
	ld a,(hl)	
	cp 00dh
	jp z,l45f6h
	cp 004h
	jp c,l4289h
	cp 00bh
	jp z,l44deh
	jp nc,l4502h
	cp 008h
	jp nc,l4406h
	ld a,(0e71fh)
	and 001h
	jp nz,l4551h
	ld a,(0e909h)
	ld d,a	
	ld a,(hl)	
	cp 006h
	jr nc,l41d6h
	bit 2,d
	jp nz,l4387h
l41d6h:
	bit 3,d
	jp nz,l43b5h
	ld hl,0e700h
	bit 1,d
	jr z,l41e4h
	res 5,(hl)
l41e4h:
	bit 0,d
	jr z,l41eah
	set 5,(hl)
l41eah:
	ld hl,0e703h
	dec (hl)	
	jr nz,l4229h
	ld a,(0e704h)
	inc a	
	jr z,l4240h
	dec a	
	jr nz,l4212h
	inc a	
	ld (0e704h),a
	ld hl,(0e70ah)
	ld a,(hl)	
	ld (0e703h),a
	inc hl	
	ld a,(0e701h)
	and (hl)	
	ld (0e701h),a
	inc hl	
	ld a,(hl)	
	ld (0e706h),a
	ret	
l4212h:
	ld hl,0e702h
	ld a,(hl)	
	cp 006h
	ld bc,00400h
	jr c,l4220h
	ld bc,00503h
l4220h:
	ld (hl),c	
	ld a,b	
	ld (0e706h),a
	inc hl	
	ld (hl),005h
	ret	
l4229h:
	ld a,(0e704h)
	dec a	
	ret nz	
	ld hl,(0e70ah)
	inc hl	
	bit 1,(hl)
	jr z,l423bh
	bit 5,d
	jr nz,l4244h
	ret	
l423bh:
	bit 4,d
	jr nz,l4244h
	ret	
l4240h:
	xor a	
	ld (0e705h),a
l4244h:
	xor a	
	ld (0e704h),a
	ld d,a	
	ld a,(0e702h)
	sub 004h
	add a,a	
	ld e,a	
	add a,a	
	add a,e	
	ld e,a	
	ld hl,l658dh
	add hl,de	
	ld a,(hl)	
	ld (0e703h),a
	inc hl	
	ld a,(0e701h)
	or (hl)	
	ld (0e701h),a
	inc hl	
	bit 1,a
	ld a,(hl)	
	inc hl	
	ld (0e70ah),hl
	ld hl,0e705h
	jr z,l4275h
	bit 0,(hl)
	jr z,l4275h
	inc a	
l4275h:
	ld (0e706h),a
	inc (hl)	
sub_4279h:
	ld a,(0e884h)
	and a	
	ret nz	
	ld a,00bh
	ld (0e884h),a
	ld a,082h
	call 00dfeh
	ret	
l4289h:
	ld a,(0e71fh)
	bit 1,a
	jp nz,l4636h
	bit 0,a
	jp nz,l455ah
	ld a,(0e703h)
	dec a	
	jp m,l42a0h
	ld (0e703h),a
l42a0h:
	ld a,(0e909h)
	bit 5,a
	jp nz,l4365h
	bit 4,a
	jp nz,l4352h
	bit 3,a
	jp nz,l43bdh
	bit 2,a
	jp nz,l4387h
	bit 1,a
	jr nz,l4307h
	bit 0,a
	jr nz,l42dfh
l42bfh:
	ld hl,0e702h
	ld a,(hl)	
	cp 002h
	ld (hl),000h
	jp nc,l4347h
	cp 000h
	ld a,(0e705h)
	jr z,l42d3h
	ld a,005h
l42d3h:
	dec a	
	ld (0e705h),a
	ret nz	
	ld hl,(0e712h)
	ld (0e707h),hl
	ret	
l42dfh:
	ld hl,(0e712h)
	ld de,0db00h
	sbc hl,de
	jr z,l42bfh
	ld hl,0e701h
	bit 5,(hl)
	dec hl	
	jr nz,l42f9h
	bit 5,(hl)
	jr nz,l4331h
	set 5,(hl)
	jr l431fh
l42f9h:
	set 5,(hl)
	jr l42ffh
l42fdh:
	res 5,(hl)
l42ffh:
	ld hl,(0e712h)
	ld (0e707h),hl
	jr l42bfh
l4307h:
	ld hl,(0e712h)
	ld de,00400h
	sbc hl,de
	jr z,l42bfh
	ld hl,0e701h
	bit 4,(hl)
	dec hl	
	jr nz,l42fdh
	bit 5,(hl)
	jr z,l4331h
	res 5,(hl)
l431fh:
	ld a,(0e702h)
	cp 004h
	jr nz,l432bh
	ld a,005h
	ld (0e703h),a
l432bh:
	ld hl,(0e712h)
	ld (0e707h),hl
l4331h:
	ld hl,0e702h
	ld a,001h
	cp (hl)	
	ld (hl),a	
	jr c,l4347h
	ld a,(0e703h)
	and a	
	ret nz	
sub_433fh:
	ld a,(0e706h)
	inc a	
	cp 004h
	jr c,l4349h
l4347h:
	ld a,000h
l4349h:
	ld (0e706h),a
	ld a,005h
	ld (0e703h),a
	ret	
l4352h:
	ld a,(hl)	
	cp 003h
	ld a,005h
	jr nz,l435bh
	ld a,007h
l435bh:
	ld (hl),a	
	ld hl,(0e712h)
	ld (0e707h),hl
	jp l4240h
l4365h:
	ld a,001h
	ld (0e703h),a
	ld a,(hl)	
	cp 003h
	ld c,004h
	ld a,006h
	jr nz,l4377h
	ld c,006h
	ld a,00bh
l4377h:
	ld (hl),c	
	ld (0e706h),a
	ld a,0ffh
	ld (0e704h),a
	ld hl,(0e712h)
	ld (0e707h),hl
	ret	
l4387h:
	ld a,(hl)	
	cp 002h
	jr z,l43a5h
	cp 003h
	ret z	
	ld (hl),002h
	ld hl,(0e712h)
	ld (0e707h),hl
	ld a,002h
	ld (0e703h),a
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
	ret	
l43a5h:
	ld a,(0e703h)
	and a	
	ret nz	
	ld a,003h
	ld (0e702h),a
	ld a,005h
	ld (0e706h),a
	ret	
l43b5h:
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
l43bdh:
	ld hl,(0e712h)
	ld de,(0e707h)
	ld a,(0e700h)
	and 020h
	jr nz,l43cch
	ex de,hl	
l43cch:
	sbc hl,de
	ld a,008h
	ld de,00400h
	sbc hl,de
	jr c,l43d8h
	inc a	
l43d8h:
	ld (0e702h),a
	sub 008h
	add a,a	
	ld b,000h
	ld c,a	
	ld de,0e703h
	ld hl,065a5h
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ldi
	inc bc	
	ld (0e70ch),hl
	ld hl,l65a9h
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ldi
	ld (0e70eh),hl
	xor a	
	ld (de),a	
	ld a,(hl)	
	ld (0e706h),a
	ret	
l4406h:
	ld hl,0e71fh
	bit 0,(hl)
	jp nz,l464bh
	ld a,(0e71ah)
	and a	
	jp nz,l4656h
	ld hl,(0e70ch)
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	push hl	
	ld hl,(0e710h)
	add hl,de	
l4420h:
	ld (0e710h),hl
	pop hl	
	ld a,(0e703h)
	dec a	
	jr nz,l4430h
	inc hl	
	ld a,(hl)	
	inc hl	
	ld (0e70ch),hl
l4430h:
	ld (0e703h),a
	ld hl,(0e70eh)
	ld a,(0e704h)
	dec a	
	jr nz,l4445h
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l446eh
	inc hl	
	ld (0e70eh),hl
l4445h:
	ld (0e704h),a
	ld c,(hl)	
	ld a,(0e705h)
	and a	
	jr z,l44a7h
	ld hl,(0e70ah)
	ld a,(0e705h)
	dec a	
	jr nz,l4486h
	bit 7,(hl)
	jr z,l4460h
	bit 7,c
	jr nz,l4489h
l4460h:
	inc hl	
	ld a,(hl)	
	ld (0e705h),a
	inc hl	
	and a	
	jr z,l448ah
	ld (0e70ah),hl
	jr l4489h
l446eh:
	ld hl,00500h
	ld (0e702h),hl
	ld a,004h
	ld (0e706h),a
	ld hl,l5000h
	ld (0e710h),hl
	ld hl,(0e712h)
	ld (0e707h),hl
	ret	
l4486h:
	ld (0e705h),a
l4489h:
	ld c,(hl)	
l448ah:
	ld a,(0e701h)
	set 1,a
	bit 6,c
	jr nz,l449dh
	res 1,a
	set 0,a
	bit 5,c
	jr nz,l449dh
	res 0,a
l449dh:
	ld (0e701h),a
l44a0h:
	ld a,c	
	and 01fh
	ld (0e706h),a
	ret	
l44a7h:
	bit 7,c
	jr z,l44a0h
	ld a,(0e909h)
	and 030h
	jr z,l44a0h
	ld b,0f8h
	bit 4,a
	jr nz,l44c1h
	ld b,0fbh
	ld a,081h
	call 00dfeh
	jr l44c4h
l44c1h:
	call sub_4279h
l44c4h:
	ld a,(0e702h)
	add a,b	
	add a,a	
	ld d,000h
	ld e,a	
	ld hl,l65adh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld a,(hl)	
	ld (0e705h),a
	inc hl	
	ld (0e70ah),hl
	jr l4489h
l44deh:
	ld a,(0e71fh)
	and 001h
	jr nz,l455ah
	ld hl,0e703h
	dec (hl)	
	ret nz	
	ld hl,0e702h
	ld a,(0e706h)
	cp 005h
	ld (hl),003h
	ret z	
	ld (hl),000h
	ld a,000h
	ld (0e706h),a
	ld a,005h
	ld (0e703h),a
	ret	
l4502h:
	ld hl,0e703h
	dec (hl)	
	jr nz,l4521h
	ld hl,(0e70ah)
	ld a,(hl)	
	cp 0ffh
	jr z,l454bh
	ld (0e706h),a
	inc hl	
	ld a,(hl)	
	inc hl	
	ld (0e703h),a
	ld (0e70ah),hl
	ld hl,0e700h
	set 1,(hl)
l4521h:
	ld de,(0e70eh)
	ld hl,(0e707h)
	add hl,de	
	ld (0e70eh),hl
	ld hl,(0e710h)
	sbc hl,de
	ld (0e710h),hl
	ld hl,(0e712h)
	ld de,(0e70ch)
	ld a,(0e700h)
	and 020h
	jr z,l4546h
	sbc hl,de
	jr l4547h
l4546h:
	add hl,de	
l4547h:
	ld (0e712h),hl
	ret	
l454bh:
	ld a,00bh
	ld (0e000h),a
	ret	
l4551h:
	ld a,(hl)	
	cp 006h
	ld a,005h
	jr nc,l4564h
	jr l4561h
l455ah:
	ld a,(0e706h)
	cp 005h
	jr z,l4567h
l4561h:
	call sub_468eh
l4564h:
	ld (0e706h),a
l4567h:
	call 02e91h
	ld hl,(0e712h)
	ld (0e707h),hl
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
	ld hl,0e71fh
	res 0,(hl)
	ld a,008h
	ld (0e703h),a
	ld hl,0e721h
	ld a,(0e709h)
	and a	
	scf	
	jp m,l4591h
	sub (hl)	
	ld (0e709h),a
l4591h:
	ld hl,0e702h
	ld (hl),00bh
	ret nc	
	call 01208h
	ret nz	
	inc (hl)	
	ld a,(0e720h)
l459fh:
	and a	
	push af	
	ld a,000h
	call 00dfeh
	ld a,087h
	call 00dfeh
	pop af	
	ld hl,l45ech
	ld de,0000ch
	ld bc,00012h
	jr nz,l45dah
	ld hl,(0e712h)
	ld de,(0e2dah)
	sbc hl,de
	ld hl,0e701h
	jr c,l45cch
	res 6,(hl)
	dec hl	
	res 5,(hl)
	jr l45d1h
l45cch:
	set 6,(hl)
	dec hl	
	set 5,(hl)
l45d1h:
	ld hl,l45f1h
	ld de,00039h
	ld bc,0001bh
l45dah:
	ld (0e70ah),hl
	ld (0e70ch),de
	ld (0e707h),bc
	ld hl,00000h
	ld (0e70eh),hl
	ret	
l45ech:
	ld (0230ah),hl
	jr $+1
l45f1h:
	inc h	
	ex af,af'	
	dec h	
	ld d,0ffh
l45f6h:
	ld hl,0e71fh
	bit 0,(hl)
	jr z,l4609h
	call 02e91h
	call sub_4675h
	call sub_468eh
	ld (0e706h),a
l4609h:
	ld de,(0e70eh)
	ld hl,00012h
l4610h:
	add hl,de	
	ld (0e70eh),hl
	ld hl,(0e710h)
	sbc hl,de
	ex de,hl	
	ld hl,0b000h
	add hl,de	
	jr nc,l4625h
	ld (0e710h),de
	ret	
l4625h:
	ld hl,l5000h
	ld hl,0e71fh
	bit 1,(hl)
	jr z,l4643h
	res 1,(hl)
	call 01208h
	jr nz,l4643h
l4636h:
	ld a,00ch
	ld (0e702h),a
	ld a,005h
	ld (0e703h),a
	jp l459fh
l4643h:
	ld hl,0e702h
	ld (hl),000h
	jp l4347h
l464bh:
	call 02e91h
	call sub_4675h
	call sub_468eh
	jr l4658h
l4656h:
	ld a,010h
l4658h:
	ld (0e706h),a
	ld a,00dh
	ld (0e702h),a
	ld hl,00080h
	ld (0e70eh),hl
	ld hl,(0e712h)
	ld (0e707h),hl
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
	ret	
sub_4675h:
	ld hl,0e721h
	ld a,(0e709h)
	and a	
	jp m,l4684h
	sub (hl)	
	ld c,000h
	jr nc,l4686h
l4684h:
	ld c,002h
l4686h:
	ld (0e709h),a
	ld hl,0e71fh
	ld (hl),c	
	ret	
sub_468eh:
	ld hl,(0e710h)
	ld de,01800h
	add hl,de	
	ld de,(0e722h)
	sbc hl,de
	ld a,020h
	ret c	
	inc a	
	ret	
l46a0h:
	call sub_5903h
	cp 004h
	jr z,l46f4h
	ld hl,0e703h
	dec (hl)	
	ret nz	
	ld (hl),008h
	ld hl,0e705h
	dec (hl)	
	jr nz,l46d8h
	ld (hl),002h
	dec hl	
	dec (hl)	
	jr z,l46eeh
	ld hl,(0e712h)
	ld de,00100h
	ld a,(0e101h)
	and a	
	jr z,l46c9h
	add hl,de	
	jr l46cbh
l46c9h:
	sbc hl,de
l46cbh:
	ld (0e712h),hl
	ld hl,(0e710h)
	ld de,00600h
	add hl,de	
	ld (0e710h),hl
l46d8h:
	ld a,(0e706h)
	inc a	
	cp 020h
	jr nz,l46e2h
	ld a,01ch
l46e2h:
	ld (0e706h),a
	and 001h
	ret nz	
	ld a,090h
	call 00dfeh
	ret	
l46eeh:
	ld a,00ch
	ld (0e000h),a
	ret	
l46f4h:
	ld a,(0e706h)
	cp 026h
	ret nz	
	ld a,00ch
	ld (0e000h),a
	xor a	
	ld (0e340h),a
	ret	
sub_4704h:
	ld hl,(0e102h)
	ld de,(0e712h)
	call sub_5903h
	cp 004h
	jr z,l4784h
	ld a,(0e101h)
	cp 001h
	ld iy,l5000h
	jr c,l4723h
	ret nz	
	ld iy,l5200h
	ex de,hl	
l4723h:
	and a	
	sbc hl,de
	ret c	
	push hl	
	ld hl,(0e710h)
	ld de,l5000h
	sbc hl,de
	jr c,l4782h
	add hl,hl	
	ld a,h	
	pop hl	
	ld b,00ch
l4737h:
	sub 00ch
	jr c,l4749h
	ld de,00100h
	sbc hl,de
	ret c	
	ld de,00600h
	add iy,de
	dec b	
	jr l4737h
l4749h:
	ld (0e710h),iy
	ld a,000h
	call 00dfeh
	ld a,003h
	ld (0e000h),a
	ex de,hl	
	ld hl,(0e712h)
	ld a,(0e101h)
	and a	
	jr z,l4766h
	sbc hl,de
	ld de,00100h
l4766h:
	add hl,de	
	ld (0e712h),hl
	ld hl,0e700h
	set 1,(hl)
	ld a,01ch
	ld (0e706h),a
	ld a,008h
	ld (0e703h),a
	ld a,001h
	ld (0e705h),a
	ld a,b	
	ld (0e704h),a
l4782h:
	pop af	
	ret	
l4784h:
	sbc hl,de
	ret c	
	ld a,(0e702h)
	cp 002h
	ret nc	
	ld hl,0e341h
	inc (hl)	
	ld a,005h
	ld (0e346h),a
	ld a,005h
	ld (0e347h),a
	ld a,003h
	ld hl,0e701h
	res 6,(hl)
	dec hl	
	res 5,(hl)
	set 1,(hl)
	ld (0e000h),a
	ld a,000h
	call 00dfeh
	pop af	
	ld a,003h
	ld (0e706h),a
	ret	
l47b6h:
	ld ix,0e34ch
	bit 4,(ix+000h)
	call nz,sub_4821h
	ld ix,0e340h
	ld c,(ix+000h)
	bit 4,c
	ret z	
	ld a,(ix+001h)
	cp 001h
	jr c,l480bh
	jr z,l47e7h
sub_47d4h:
	ld de,0001bh
	call 01beah
	ld de,0ff20h
	add hl,de	
	jr c,sub_4821h
	ld a,026h
	ld (0e706h),a
	jr sub_4821h
l47e7h:
	dec (ix+007h)
	jr nz,sub_4821h
	ld (ix+007h),00bh
	inc (ix+006h)
	ld a,(ix+006h)
	cp 007h
	jr c,sub_4821h
	ld (ix+007h),007h
	inc (ix+001h)
	ld (ix+006h),001h
	set 4,(ix+00ch)
	jr sub_4821h
l480bh:
	dec (ix+007h)
	jr nz,sub_4821h
l4810h:
	ld (ix+007h),008h
	ld a,(ix+006h)
	inc a	
	cp 005h
	jr z,l481eh
	ld a,004h
l481eh:
	ld (ix+006h),a
sub_4821h:
	call 01be2h
	ld de,0ee00h
	add hl,de	
	ret c	
	ld hl,l73f0h
	jp 01a7dh
	ld a,(0e000h)
	cp 006h
	jr nz,l484dh
	ld hl,0e022h
	dec (hl)	
	ret nz	
	ex de,hl	
	ld hl,(0e023h)
	ld a,(hl)	
	cp 0ffh
	jr z,l4878h
	inc hl	
	ld (de),a	
	ld a,(hl)	
	inc hl	
	ld (0e023h),hl
	jr l4874h
l484dh:
	ld a,(0e906h)
	and 004h
	ld hl,0e700h
	bit 0,(hl)
	jr nz,l4874h
	ld a,(0e906h)
	and 007h
	ld c,a	
	ld a,(0e71ah)
	and a	
	ld a,c	
	jr nz,l4874h
	ld a,(0e908h)
	cpl	
	ld b,a	
	cpl	
	rlca	
	rlca	
	rlca	
	and b	
	and 038h
	ld b,a	
	or c	
l4874h:
	ld (0e909h),a
	ret	
l4878h:
	ld a,00bh
	ld (0e000h),a
	ret	
l487eh:
	di	
	ld sp,0f000h
	xor a	
	ld (0e001h),a
	ld (0e020h),a
	ld (0e021h),a
	ld (0e080h),a
	ei	
	call sub_5700h
	call 0064ah
	ld hl,l4b6dh
	call 0111ch
	ld hl,l4f01h
	ld (0e70eh),hl
	ld a,09ch
	ld (0e705h),a
	ld hl,030a0h
	ld (0e712h),hl
	ld hl,l5c00h
	ld (0e710h),hl
	ld (0e344h),hl
	ld hl,034a0h
	ld (0e342h),hl
	ld a,010h
	ld (0e340h),a
	ld a,005h
	ld (0e347h),a
	ld ix,0e262h
	ld bc,00750h
	ld hl,00f00h
	ld b,007h
l48d2h:
	ld (ix+004h),000h
	ld (ix+005h),05ch
	ld (ix+007h),007h
	ld (ix+00eh),038h
	ld (ix+00fh),b
	ld (ix+000h),c
	ld (ix+002h),l
	ld (ix+003h),h
	ld a,b	
	cp 007h
	jr z,l48fbh
	cp 004h
	jr c,l48fbh
	ld (ix+006h),00ah
l48fbh:
	cp 005h
	jr nc,l4904h
	ld hl,03100h
	ld c,010h
l4904h:
	ld de,00010h
	add ix,de
	djnz l48d2h
	ld a,005h
	ld (0e000h),a
	ld de,0d152h
	ld c,00bh
	ld hl,l4b86h
	call 01134h
l491bh:
	ld a,(0e020h)
	cp 008h
l4920h:
	jr nz,l491bh
	call 0111ch
l4925h:
	ld a,(0e020h)
	cp 00bh
	jr nz,l4925h
	call sub_49aeh
	ld hl,l4c0eh
	call 01134h
	ld a,0e1h
	call sub_570fh
	call sub_49aeh
	ld hl,l4c71h
	call 0111ch
l4943h:
	call sub_49c0h
	ld a,(0e000h)
	cp 00bh
	jr nz,l4943h
	xor a	
	ld hl,00000h
	ld (0e081h),a
	ld (0e082h),hl
	inc a	
	ld (0e084h),a
	ld (0e022h),a
	ld hl,0e025h
	ld a,(hl)	
	ld (hl),009h
	ld de,l4a55h
	and a	
	jr z,l496fh
	ld de,l4b0ah
	ld (hl),000h
l496fh:
	ld (0e080h),a
	ld (0e023h),de
	call 01157h
	ld a,001h
	call 00449h
	di	
	ld a,006h
	ld (0e000h),a
	ld hl,00000h
	ld (0e081h),hl
	ld (0e082h),hl
	ld (0e010h),hl
	ld (0e012h),hl
	ei	
l4994h:
	call 00fb8h
	ld a,(0e000h)
	cp 00bh
	jr nz,l4994h
	ld a,038h
	call sub_570fh
	call sub_5620h
	ld a,0e1h
	call sub_570fh
	jp l487eh
sub_49aeh:
	ld de,0d150h
	ld b,004h
l49b3h:
	push de	
	call sub_572ah
	pop hl	
	ld de,00080h
	add hl,de	
	ex de,hl	
	djnz l49b3h
	ret	
sub_49c0h:
	ld de,0d316h
	ld bc,0190bh
	ld a,(0e880h)
	and 030h
	jp z,l571fh
	ld hl,(0e90ah)
	ld a,l	
	xor h	
	jr nz,l49e9h
	inc de	
	call sub_49f7h
	bit 3,l
	ret nz	
	ld de,0d397h
	ld a,l	
	add a,a	
	daa	
	call sub_4a10h
	ld a,002h
	jr l4a0ah
l49e9h:
	ld a,041h
	call sub_49f4h
	ld l,h	
	ld de,0d396h
	ld a,042h
sub_49f4h:
	call sub_4a2ch
sub_49f7h:
	bit 3,l
	ld a,001h
	jr nz,l49feh
	ld a,l	
l49feh:
	call sub_4a10h
	bit 3,l
	ld a,001h
	jr z,l4a0ah
	ld a,l	
	and 007h
l4a0ah:
	push hl	
	ld hl,l4a39h
	jr l4a14h
sub_4a10h:
	push hl	
	ld hl,l4a34h
l4a14h:
	push af	
	push bc	
	ld c,b	
	call sub_56f7h
	pop bc	
	inc de	
	call 0111ch
	pop af	
	push de	
	cp 001h
	ld a,053h
	call nz,01110h
	pop de	
	inc de	
	pop hl	
	ret	
sub_4a2ch:
	call 01110h
	ld a,02dh
	jp 01110h
l4a34h:
	ld b,e	
	ld c,a	
	ld c,c	
	ld c,(hl)	
	rst 38h	
l4a39h:
	ld d,b	
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	rst 38h	
	jr nz,l4a62h
	jr nz,l4a64h
	jr nz,l4a66h
	jr nz,l4a68h
	jr nz,l4a6ah
	jr nz,$+34
	jr nz,l4a6eh
	jr nz,l4a70h
	jr nz,$+34
	jr nz,l4a74h
	rst 38h	
l4a55h:
	ld b,d	
	ld (bc),a	
	ld bc,02820h
	ld (bc),a	
	ld (bc),a	
	djnz l4a76h
	ld (bc),a	
	inc bc	
	djnz $+26
l4a62h:
	ld (bc),a	
	ld (bc),a	
l4a64h:
	djnz l4a8ah
l4a66h:
	ld (bc),a	
	ld (bc),a	
l4a68h:
	jr nz,$+58
l4a6ah:
	ld (bc),a	
	djnz l4a71h
	ld (bc),a	
l4a6eh:
	jr nz,l4a8eh
l4a70h:
	ld (bc),a	
l4a71h:
	djnz l4a7bh
	ld (bc),a	
l4a74h:
	jr nz,$+46
l4a76h:
	ld bc,02004h
	jr z,$+4
l4a7bh:
	ex af,af'	
	ld bc,01002h
	jr z,$+3
	djnz l4a8bh
	jr l4aa5h
	ex af,af'	
	ld bc,00240h
	ex af,af'	
l4a8ah:
	ex af,af'	
l4a8bh:
	ex af,af'	
	jr nz,l4ad6h
l4a8eh:
	ld (bc),a	
	inc bc	
	ld bc,00203h
	inc bc	
	ld bc,00603h
	inc bc	
	dec b	
	inc bc	
	ld b,003h
	ld bc,00203h
	inc bc	
	ld bc,00103h
	inc bc	
	ld (bc),a	
l4aa5h:
	inc bc	
	ld bc,00603h
	inc bc	
	dec b	
	inc bc	
	ld b,003h
	ld bc,00203h
	inc bc	
	ld bc,00203h
	inc bc	
	ld bc,00603h
	inc bc	
	dec b	
	inc bc	
	ld b,003h
	ld bc,00218h
	ld (bc),a	
	ex af,af'	
	ld c,b	
	ld (bc),a	
	ld (bc),a	
	djnz l4ae0h
	nop	
	ld (bc),a	
	djnz $+26
	nop	
	ld a,(bc)	
	ld bc,0040ah
	ld (bc),a	
	djnz $+26
	inc b	
	ld (bc),a	
l4ad6h:
	jr nz,l4af0h
	inc b	
	ld (bc),a	
	djnz $+18
	inc b	
	jr z,l4ae0h
	inc bc	
l4ae0h:
	jr nz,$+34
	ld bc,02003h
	jr l4ae8h
	inc bc	
l4ae8h:
	jr nz,l4af2h
	nop	
	jr z,l4aefh
	ex af,af'	
	inc b	
l4aefh:
	inc bc	
l4af0h:
	jr nz,$+18
l4af2h:
	djnz l4b28h
	ld (bc),a	
	inc b	
	ex af,af'	
	djnz l4b19h
	jr z,$+4
	dec b	
	ld bc,00205h
	dec b	
	ld bc,00605h
	dec b	
	dec b	
	dec b	
	ld b,080h
	nop	
	rst 38h	
l4b0ah:
	inc e	
	ld bc,00004h
	ld bc,04410h
	ld bc,00010h
	jr z,l4b17h
	ld (bc),a	
l4b17h:
	jr nz,$+18
l4b19h:
	ld (bc),a	
	jr nz,l4b1dh
	ld (bc),a	
l4b1dh:
	ex af,af'	
	ld d,b	
	ld bc,00802h
	ld (hl),001h
	ld a,(bc)	
	ld (bc),a	
	jr nc,l4b28h
l4b28h:
	djnz l4b3ah
	jr nz,l4b2ch
l4b2ch:
	dec de	
	ld (bc),a	
	ld (bc),a	
	ex af,af'	
	djnz l4b42h
	ld c,b	
	ld (bc),a	
	ld (bc),a	
	ex af,af'	
	djnz $+34
	jr z,l4b3eh
l4b3ah:
	ld (bc),a	
	jr nz,$+34
	inc b	
l4b3eh:
	ld l,b	
	ld bc,0000ah
l4b42h:
	inc b	
	jr nz,$+18
	ld (bc),a	
	djnz l4b48h
l4b48h:
	jr z,$+3
	ld bc,06002h
	inc b	
	jr c,l4b51h
	ld (bc),a	
l4b51h:
	ex af,af'	
	djnz l4b64h
	jr nc,l4b56h
l4b56h:
	ld d,b	
	ld bc,00220h
	ld (bc),a	
	ex af,af'	
	djnz l4b7eh
	jr nz,l4b60h
l4b60h:
	jr l4b64h
	djnz l4b6ch
l4b64h:
	djnz l4b86h
	djnz l4b68h
l4b68h:
	ld b,b	
	ld bc,004a0h
l4b6ch:
	rst 38h	
l4b6dh:
	cp 01dh
	defb 0fdh,0d8h,0d6h	;illegal sequence
	ld b,b	
	jr nz,$+51
	add hl,sp	
	jr c,l4bach
l4b78h:
	jr nz,l4b78h
	jp c,l5249h
	ld b,l	
l4b7eh:
	ld c,l	
	jr nz,l4bc4h
	ld c,a	
	ld d,d	
	ld d,b	
	ld l,0ffh
l4b86h:
	ld b,c	
	jr nz,l4bd4h
	ld d,l	
	ld c,(hl)	
	ld b,a	
	dec l	
	ld b,(hl)	
	ld d,l	
	jr nz,l4bdeh
	ld b,c	
	ld d,e	
	ld d,h	
	ld b,l	
	ld d,d	
	inc l	
	cp 01ah
	ld d,h	
	ld c,b	
	ld c,a	
	ld c,l	
	ld b,c	
	ld d,e	
	cp 00bh
	jr nz,l4be4h
	ld c,(hl)	
l4ba4h:
	ld b,h	
	jr nz,l4ba4h
	jp nc,0fed1h
	ld a,(de)	
	ld d,e	
l4bach:
	ld c,c	
	ld c,h	
	ld d,(hl)	
	ld c,c	
	ld b,c	
	cp 00bh
	jr nz,$+89
	ld b,l	
	ld d,d	
	ld b,l	
	jr nz,l4c0dh
	ld d,l	
	ld b,h	
	ld b,h	
	ld b,l	
	ld c,(hl)	
	ld c,h	
	ld e,c	
	jr nz,$+67
	ld d,h	
l4bc4h:
	ld d,h	
	ld b,c	
	ld b,e	
	ld c,e	
	ld b,l	
l4bc9h:
	ld b,h	
	jr nz,l4bc9h
	ld d,d	
	jp nc,l5942h
	jr nz,l4c25h
	ld b,l	
	ld d,(hl)	
l4bd4h:
	ld b,l	
	ld d,d	
	ld b,c	
	ld c,h	
	jr nz,l4c2fh
	ld c,(hl)	
	ld c,e	
	ld c,(hl)	
	ld c,a	
l4bdeh:
	ld d,a	
	ld c,(hl)	
	jr nz,l4c29h
	ld d,l	
	ld e,c	
l4be4h:
	ld d,e	
	ld l,0ffh
	defb 0fdh,0d0h,0d2h	;illegal sequence
l4beah:
	jr z,l4beah
	ld a,(de)	
	ld d,e	
	ld c,c	
	ld c,h	
	ld d,(hl)	
	ld c,c	
	ld b,c	
	cp 00bh
	jr nz,l4c4eh
	ld b,c	
	ld d,e	
	jr nz,$+77
	ld c,c	
	ld b,h	
	ld c,(hl)	
l4bfeh:
	ld b,c	
	ld d,b	
	ld d,b	
	ld b,l	
	ld b,h	
	jr nz,l4c47h
	ld e,c	
	jr nz,l4c5ch
	ld c,b	
	ld b,l	
	ld c,l	
	ld l,029h
l4c0dh:
	rst 38h	
l4c0eh:
	defb 0fdh,053h,0d1h	;illegal sequence
	ld c,h	
	ld b,c	
	ld d,h	
	ld b,l	
	ld d,d	
l4c16h:
	jr nz,l4c16h
	ld a,(de)	
	ld d,h	
	ld c,b	
	ld c,a	
	ld c,l	
	ld b,c	
	ld d,e	
	cp 00bh
	jr nz,$+72
	ld c,a	
	ld d,l	
l4c25h:
	ld c,(hl)	
	ld b,h	
	jr nz,l4c6ah
l4c29h:
	jr nz,l4c77h
	ld b,l	
	ld d,h	
	ld d,h	
	ld b,l	
l4c2fh:
	ld d,d	
	jr nz,l4c2fh
	out (0d1h),a
	ld b,(hl)	
	ld d,d	
	ld c,a	
	ld c,l	
l4c38h:
	jr nz,l4c38h
	ld a,(de)	
	ld e,b	
	cp 00bh
	ld l,020h
	defb 0fdh,053h,0d2h	;illegal sequence
	ld c,b	
	ld b,l	
	jr nz,$+75
l4c47h:
	ld d,e	
	jr nz,l4c8bh
	ld c,(hl)	
	jr nz,l4c96h
	ld c,(hl)	
l4c4eh:
	ld c,b	
	ld b,c	
	ld b,d	
	ld c,c	
	ld d,h	
	ld b,c	
	ld c,(hl)	
	ld d,h	
	jr nz,l4ca7h
	ld b,(hl)	
	jr nz,l4cafh
	ld c,b	
l4c5ch:
	ld b,l	
	jr nz,l4c5ch
	out (0d2h),a
	ld b,h	
	ld b,l	
	ld d,(hl)	
	ld c,c	
	ld c,h	
	daa	
	ld d,e	
	jr nz,l4cbeh
l4c6ah:
	ld b,l	
	ld c,l	
	ld d,b	
	ld c,h	
	ld b,l	
	ld l,0ffh
l4c71h:
	cp 0dah
	defb 0fdh,0dah,0d0h	;illegal sequence
	add a,b	
l4c77h:
	add a,c	
	add a,d	
	add a,e	
	add a,h	
	add a,l	
	add a,(hl)	
	add a,a	
	adc a,b	
	adc a,c	
	adc a,d	
	defb 0fdh,01ah,0d1h	;illegal sequence
	adc a,e	
	adc a,h	
	adc a,l	
	adc a,(hl)	
	adc a,a	
	sub b	
	sub c	
l4c8bh:
	sub d	
	sub e	
	sub h	
	sub l	
	defb 0fdh,057h,0d1h	;illegal sequence
	sub (hl)	
	sub a	
	sbc a,b	
	sbc a,c	
l4c96h:
	sbc a,d	
	sbc a,e	
	sbc a,h	
	sbc a,l	
	sbc a,(hl)	
	sbc a,a	
	and b	
	and c	
	and d	
	and e	
	and h	
	and l	
	and h	
	and (hl)	
	sub (iy-02fh)
l4ca7h:
	and a	
	xor b	
	xor c	
	xor d	
	xor e	
	xor h	
	xor l	
	xor (hl)	
l4cafh:
	xor a	
	or b	
	or c	
	or d	
	or e	
	or h	
	or l	
	or (hl)	
	or a	
	or e	
	cp b	
	cp c	
	defb 0fdh,0d6h,0d1h	;illegal sequence
l4cbeh:
	cp d	
	cp e	
	cp h	
	cp l	
	cp (hl)	
	cp a	
	ret nz	
	pop bc	
	jp nz,0c4c3h
	push bc	
	add a,0c7h
	ret z	
	ret	
	jp z,0cccbh
	call 015fdh
	jp nc,0cfceh
	ret nc	
	pop de	
	jp nc,0d4d3h
	push de	
	sub 0d7h
	ret c	
	exx	
	ld b,0dah
	in a,(0dch)
	defb 0ddh,0deh,0dfh	;illegal sequence
	ret po	
	pop hl	
	defb 0fdh,055h,0d2h	;illegal sequence
	jp po,0e4e3h
	push hl	
	and 0e7h
	ret pe	
	jp (hl)	
	jp pe,0ecebh
	defb 0edh;next byte illegal after ed
	ld b,0eeh
	rst 28h	
	ret p	
	pop af	
	ld b,0f2h
	di	
	call p,0fdf5h
	sub l	
	jp nc,0f7f6h
	ret m	
	ld sp,hl	
	jp m,070fbh
	ld (hl),c	
	ld (hl),d	
	ld (hl),e	
	ld (hl),h	
	ld (hl),l	
	ld b,076h
	ld (hl),a	
	ld a,b	
	ld a,c	
	ld a,d	
	ld a,e	
	ld a,h	
	ld a,l	
	ld a,(hl)	
	rst 38h	
l4d1dh:
	ld a,00bh
	ld (0e000h),a
	jr l4d54h
	ld hl,0e703h
	ld a,(hl)	
	and a	
	jr z,l4d2ch
	dec (hl)	
l4d2ch:
	ld hl,0e705h
	dec (hl)	
	jr nz,l4d7fh
	ld de,(0e70eh)
	ld a,(de)	
	and a	
	jp m,l4d1dh
	bit 6,a
	jr z,l4d43h
	ld hl,0e020h
	inc (hl)	
l4d43h:
	bit 5,a
	jr z,l4d54h
	push af	
	ld hl,l65b7h
	ld a,(hl)	
	inc hl	
	ld (0e70ch),hl
	ld (0e703h),a
	pop af	
l4d54h:
	ld l,a	
	bit 4,l
	jr z,l4d5eh
	ld a,002h
	ld (0e703h),a
l4d5eh:
	bit 3,l
	jr z,l4d6ah
	ld a,(0e701h)
	xor 040h
	ld (0e701h),a
l4d6ah:
	ld a,l	
	and 003h
	ld (0e021h),a
	inc de	
	ld a,(de)	
	ld (0e705h),a
	inc de	
	ld a,(de)	
	ld (0e706h),a
	inc de	
	ld (0e70eh),de
l4d7fh:
	ld a,(0e021h)
	ld hl,l4dbch
	call 01f26h
	ld a,(0e020h)
	ld ix,0e340h
	ld c,(ix+000h)
	cp 00ah
	jr z,l4da0h
	jr nc,l4da9h
	and a	
	jr nz,l4da6h
	call sub_47d4h
	jr l4da9h
l4da0h:
	ld de,00036h
	call 01c7ah
l4da6h:
	call sub_4821h
l4da9h:
	ld a,(0e020h)
	ld ix,0e262h
	ld c,(ix+000h)
	ld hl,04dc2h
	call 01f26h
	jp 02d72h
l4dbch:
	jp m,0124dh
	ld c,(hl)	
	jp c,0244dh
	ld c,(hl)	
	dec h	
	ld c,(hl)	
	ld a,(0714eh)
	ld c,(hl)	
	xor a	
	ld c,(hl)	
	xor b	
	ld c,(hl)	
	and c	
	ld c,(hl)	
	sbc a,d	
	ld c,(hl)	
	sub e	
	ld c,(hl)	
	adc a,h	
	ld c,(hl)	
	ld a,a	
	ld c,(hl)	
	inc h	
	ld c,(hl)	
	ld hl,(0e70ch)
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	push hl	
	ld hl,(0e710h)
	add hl,de	
	ld (0e710h),hl
	pop hl	
	ld a,(0e703h)
	and a	
	jr nz,l4e12h
	inc hl	
	ld a,(hl)	
	inc hl	
	ld (0e70ch),hl
	ld (0e703h),a
	jr l4e12h
	call l431fh
	ld hl,(0e712h)
	ld de,0ffe5h
	ld a,(0e701h)
	and 040h
	jr nz,l4e0dh
	add hl,de	
	jr l4e0fh
l4e0dh:
	sbc hl,de
l4e0fh:
	ld (0e712h),hl
l4e12h:
	ld hl,(0e712h)
	xor a	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	ld l,h	
	ld h,a	
	call l40d6h
	call sub_40e5h
	ret	
	call 01be7h
	ld hl,(0e264h)
	ld de,0e700h
	add hl,de	
	jr nc,l4e6bh
	ld hl,0e020h
	inc (hl)	
	ld hl,l4ee5h
	jr l4e43h
	ld hl,0e269h
	dec (hl)	
	jr nz,l4e68h
	ld hl,(0e26eh)
l4e43h:
	ld a,(hl)	
	cp 0ffh
	jr z,l4e76h
	ld (0e268h),a
	inc hl	
	ld a,(hl)	
	ld (0e269h),a
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l4e64h
	push hl	
	ld hl,0e32bh
	ld (hl),001h
	inc hl	
	ld (hl),a	
	inc hl	
	ld (hl),040h
	inc hl	
	ld (hl),01ah
	pop hl	
l4e64h:
	inc hl	
	ld (0e26eh),hl
l4e68h:
	call 01be2h
l4e6bh:
	bit 4,c
	jp nz,01a72h
	ret	
	call sub_4edfh
	jr l4e6bh
l4e76h:
	ld hl,0e020h
	inc (hl)	
	call 017dfh
	jr l4e68h
	ld hl,0e2a2h
	ld de,00010h
	ld b,003h
l4e87h:
	set 6,(hl)
	add hl,de	
	djnz l4e87h
	ld ix,0e2c2h
	call sub_4ed7h
	ld ix,0e2b2h
	call sub_4ed7h
	ld ix,0e2a2h
	call sub_4ed7h
	ld ix,0e282h
	call sub_4eb3h
	ld ix,0e292h
	call sub_4eb3h
	ld ix,0e272h
sub_4eb3h:
	ld c,(ix+000h)
	ld hl,l4ed1h
	push hl	
	ld a,(ix+001h)
	cp 001h
	jr z,sub_4edfh
	call 015a8h
	dec (ix+00eh)
	ret nz	
	ld a,(ix+00fh)
	ld (ix+006h),a
	jp 017dfh
l4ed1h:
	bit 4,c
	ret z	
	jp 0162fh
sub_4ed7h:
	ld c,(ix+000h)
	call 01be7h
	jr l4ed1h
sub_4edfh:
	bit 4,c
	jp nz,01baah
	ret	
l4ee5h:
	dec bc	
	dec bc	
	nop	
	inc c	
	jr c,l4f3dh
	nop	
	dec bc	
	nop	
	add hl,bc	
	dec bc	
	nop	
	ld a,(bc)	
	jr c,$+82
	nop	
	dec hl	
	nop	
	ld b,00ah
	nop	
	nop	
	jr l4efdh
l4efdh:
	ld b,001h
	nop	
	rst 38h	
l4f01h:
	ld b,c	
	ld d,000h
	ld bc,00432h
	ld bc,0051ch
	ld bc,0042dh
	ld (01004h),hl
	ld (bc),a	
	ld b,012h
	ld (bc),a	
	djnz l4f29h
	ld (bc),a	
	ld b,014h
	ld (bc),a	
	inc b	
	djnz $+18
	ld hl,00100h
l4f20h:
	dec bc	
	inc b	
	ld (01004h),hl
	ld (bc),a	
	ld b,012h
	ld (bc),a	
l4f29h:
	djnz l4f43h
	ld (bc),a	
	ld b,014h
l4f2eh:
	ld (bc),a	
	inc b	
	djnz l4f33h
	ex af,af'	
l4f33h:
	ld b,001h
	ex af,af'	
	rlca	
	ld bc,00608h
	ld bc,00413h
l4f3dh:
	ld b,c	
	ld hl,04104h
	ld c,004h
l4f43h:
	ld bc,00808h
	ld bc,00908h
	ld bc,00802h
	ld b,c	
	dec b	
	ex af,af'	
	ld b,c	
	ex af,af'	
	dec b	
	ld b,c	
	ex af,af'	
	dec bc	
	ld b,c	
	ex af,af'	
	inc c	
	ld bc,00b08h
	ld bc,00508h
	ld bc,00d08h
	ld bc,00e08h
	ld bc,00d09h
	ld b,c	
	ex af,af'	
	dec b	
	ld bc,0041ch
	add hl,bc	
	djnz l4f70h
l4f70h:
	djnz $+41
	nop	
	ld b,c	
	pop hl	
	inc bc	
	ld bc,003a9h
	ld bc,00416h
	ld bc,00608h
	ld bc,00708h
	ld bc,00608h
	ld bc,00408h
	ld bc,00808h
	ld bc,00908h
	ld bc,00808h
	add hl,bc	
	ex af,af'	
	inc b	
	ld bc,00608h
	ld bc,00708h
	ld bc,00608h
	ld bc,00408h
	ld bc,00508h
	ld bc,00b08h
	ld bc,00c08h
	ld bc,00b08h
	ld bc,00508h
	ld bc,00408h
	ld bc,00808h
	ld bc,00908h
	ld bc,00808h
	add hl,bc	
	ex af,af'	
	dec b	
	ld bc,00b08h
	ld bc,00c08h
	ld bc,00b08h
	ld bc,00508h
	ld (01004h),hl
	ld (bc),a	
	ld b,012h
	ld (bc),a	
	djnz l4febh
	ld (bc),a	
	ld b,014h
	ld (bc),a	
	inc b	
	djnz $+11
	ex af,af'	
	inc b	
	ld bc,00608h
	ld bc,00708h
	ld bc,00608h
	ld bc,004a9h
	rst 38h	
	ld a,023h
l4febh:
	call 00dfeh
	xor a	
	ld (0e702h),a
	ld (0e020h),a
	ld (0e883h),a
	ld a,008h
	ld (0e000h),a
	call sub_5095h
l5000h:
	ld c,0d9h
	ld hl,l5132h
	call 0111ch
	ld hl,l5147h
	call 0111ch
	ld hl,l5157h
	call 0111ch
	ld hl,l5162h
	call 0111ch
	ld hl,l516dh
	call 0111ch
	ld hl,l50a7h
	call sub_5079h
	ld a,0f8h
	call sub_5038h
	call sub_5091h
	ld hl,l50ffh
	ld c,0d9h
	call sub_5079h
	ld a,0f8h
sub_5038h:
	push hl	
	push bc	
	push de	
	ld (0e882h),a
	ld c,0d9h
l5040h:
	ld hl,0e883h
	ld a,(hl)	
	and a	
	jr nz,l5061h
	ld (hl),00bh
	ld hl,0e020h
	dec (hl)	
	dec (hl)	
	jp p,l5053h
	ld (hl),008h
l5053h:
	ld e,(hl)	
	ld d,000h
	ld hl,l506bh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call 0111ch
l5061h:
	ld a,(0e882h)
	and a	
	jr nz,l5040h
	pop de	
	pop bc	
	pop hl	
	ret	
l506bh:
	ld e,l	
	ld d,c	
	ld l,b	
	ld d,c	
	ld c,l	
	ld d,c	
	dec l	
	ld d,c	
	dec a	
	ld d,c	
l5075h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
sub_5079h:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	inc a	
	jr z,l5075h
	sub 003h
	call 01110h
	cp 020h
	jr nz,sub_5079h
	ld a,00bh
	call sub_5038h
	jr sub_5079h
sub_5091h:
	ld b,008h
	jr l5097h
sub_5095h:
	ld b,019h
l5097h:
	ld c,00bh
	ld de,0d19fh
l509ch:
	call sub_571ah
	ld hl,0001fh
	add hl,de	
	ex de,hl	
	djnz l509ch
	ret	
l50a7h:
	defb 0fdh,063h,0d2h	;illegal sequence
	ld b,c	
	jr nz,$+77
	ld d,l	
	ld c,(hl)	
	ld b,a	
	dec l	
	ld b,(hl)	
	ld d,l	
	jr nz,l5102h
	ld b,c	
	ld d,e	
	ld d,h	
	ld b,l	
	ld d,d	
	inc l	
	ld d,h	
	ld c,b	
	ld c,a	
	ld c,l	
	ld b,c	
	ld d,e	
	jr nz,l5104h
	ld c,(hl)	
l50c4h:
	ld b,h	
	jr nz,l50c4h
	ex (sp),hl	
	jp nc,04953h
	ld c,h	
	ld d,(hl)	
	ld c,c	
	ld b,c	
	jr nz,l5116h
	ld c,(hl)	
	ld c,d	
	ld c,a	
	ld e,c	
	ld b,l	
	ld b,h	
	jr nz,l5121h
	ld b,c	
	ld d,b	
	ld d,b	
	ld c,c	
	ld c,(hl)	
	ld b,l	
	ld d,e	
l50e0h:
	ld d,e	
	jr nz,l50e0h
	ld h,e	
	out (041h),a
	ld b,a	
	ld b,c	
	ld c,c	
	ld c,(hl)	
	jr nz,l5132h
	ld c,a	
l50edh:
	ld d,d	
	jr nz,l5131h
	jr nz,$+78
	ld c,c	
	ld d,h	
	ld d,h	
	ld c,h	
	ld b,l	
	jr nz,l5150h
	ld c,b	
	ld c,c	
	ld c,h	
	ld b,l	
	ld l,0ffh
l50ffh:
	and (iy-02eh)
l5102h:
	ld b,d	
	ld d,l	
l5104h:
	ld d,h	
	jr nz,l515bh
	ld c,b	
	ld b,l	
	ld c,c	
	ld d,d	
	jr nz,l5155h
	ld b,c	
	ld d,b	
	ld d,b	
	ld e,c	
	jr nz,l5157h
	ld b,c	
	ld e,c	
l5115h:
	ld d,e	
l5116h:
	jr nz,l5115h
	jr z,l50edh
	ld b,h	
	ld c,c	
	ld b,h	
	jr nz,l516dh
	ld c,a	
	ld d,h	
l5121h:
	jr nz,$+78
	ld b,c	
	ld d,e	
	ld d,h	
	jr nz,$+78
	ld c,a	
	ld c,(hl)	
	ld b,a	
	ld l,0ffh
	defb 0fdh,02eh,0d4h	;illegal sequence
	nop	
l5131h:
	nop	
l5132h:
	defb 0fdh,0ach,0d4h	;illegal sequence
	ld h,b	
	ld h,c	
	defb 0fdh,0ech,0d4h	;illegal sequence
	ld h,d	
	ld h,e	
	rst 38h	
	defb 0fdh,0ach,0d4h	;illegal sequence
	nop	
	nop	
	defb 0fdh,0ech,0d4h	;illegal sequence
	nop	
	nop	
l5147h:
	defb 0fdh,06dh,0d4h	;illegal sequence
	ld h,h	
	ld h,l	
	rst 38h	
	defb 0fdh,0b0h,0d4h	;illegal sequence
l5150h:
	nop	
	nop	
	defb 0fdh,0f0h,0d4h	;illegal sequence
l5155h:
	nop	
	nop	
l5157h:
	defb 0fdh,02eh,0d4h	;illegal sequence
	ld h,(hl)	
l515bh:
	ld h,a	
	rst 38h	
	defb 0fdh,06dh,0d4h	;illegal sequence
	nop	
	nop	
l5162h:
	defb 0fdh,06fh,0d4h	;illegal sequence
	ld l,b	
	ld l,c	
	rst 38h	
	defb 0fdh,06fh,0d4h	;illegal sequence
	nop	
	nop	
l516dh:
	defb 0fdh,0b0h,0d4h	;illegal sequence
	ld l,d	
	ld l,e	
	defb 0fdh,0f0h,0d4h	;illegal sequence
	ld l,h	
	ld l,l	
	rst 38h	
	ld hl,0e005h
	set 7,(hl)
	call 01157h
	call sub_5703h
l5183h:
	ld de,0d25ah
	ld c,014h
	ld a,(0e880h)
	and 018h
	jr z,l5197h
	ld hl,l51d8h
	call 0111ch
	jr l519ah
l5197h:
	call sub_5725h
l519ah:
	ld de,0d319h
	ld a,(0e913h)
	push af	
	cp 001h
	ld hl,l51e5h
	jr z,l51abh
	ld hl,l51f3h
l51abh:
	call 0111ch
	ld hl,l5202h
	call 0111ch
	pop af	
	call 010ffh
	ld a,(0e904h)
	and 003h
	jr z,l5183h
	and 002h
	ld (0e002h),a
	ld b,001h
	jr z,l51c9h
	inc b	
l51c9h:
	ld hl,0e913h
	ld a,(hl)	
	sub b	
	jr c,l5183h
	daa	
	ld (hl),a	
	ld hl,0e005h
	res 7,(hl)
	ret	
l51d8h:
	ld d,b	
	ld d,l	
	ld d,e	
	ld c,b	
	jr nz,l51feh
	ld b,d	
	ld d,l	
	ld d,h	
	ld d,h	
	ld c,a	
	ld c,(hl)	
	rst 38h	
l51e5h:
	ld c,a	
	ld c,(hl)	
	ld c,h	
	ld e,c	
	jr nz,$+51
	jr nz,l523dh
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	rst 38h	
l51f3h:
	ld sp,l4f20h
	ld d,d	
	jr nz,$+52
	jr nz,$+82
	ld c,h	
	ld b,c	
	ld e,c	
l51feh:
	ld b,l	
	ld d,d	
l5200h:
	ld d,e	
	rst 38h	
l5202h:
	pop iy
	push de	
	ld b,e	
	ld d,d	
	ld b,l	
	ld b,h	
	ld c,c	
	ld d,h	
	jr nz,$+1
	call 01157h
	call sub_5703h
	ld a,020h
	call 00dfeh
	ld c,01bh
	ld de,0d153h
	ld b,017h
l521fh:
	call sub_5725h
	ld hl,00026h
	add hl,de	
	ex de,hl	
	djnz l521fh
	ld hl,l5232h
	call sub_5739h
	jp 0111ch
l5232h:
	defb 0fdh,055h,0d1h	;illegal sequence
	call z,sub_60fdh
	pop de	
	call z,sub_67fdh
	pop de	
l523dh:
	call z,092fdh
	out (0e3h),a
	defb 0fdh,0d1h,0d3h	;illegal sequence
	exx	
	ret c	
	nop	
	ret nc	
l5249h:
	pop de	
	call 010fdh
	call nc,0dbe0h
	jp c,0d200h
	out (0cfh),a
	defb 0fdh,050h,0d4h	;illegal sequence
	jp po,0dc07h
	defb 0ddh,0d4h,0d5h	;illegal sequence
	defb 0fdh,090h,0d4h	;illegal sequence
	call po,0de07h
l5264h:
	rst 18h	
	sub 0d7h
	defb 0fdh,0d0h,0d4h	;illegal sequence
	and 007h
	rlca	
	rlca	
	push hl	
	defb 0fdh,010h,0d5h	;illegal sequence
	pop hl	
	rlca	
	ret pe	
	jp (hl)	
	rst 20h	
	defb 0fdh,050h,0d5h	;illegal sequence
	rlca	
	rlca	
	jp pe,0fdebh
	sub b	
	push de	
	rlca	
	rlca	
	call pe,0fdedh
	ret nc	
	push de	
	rlca	
	rst 28h	
	xor 0fdh
	djnz l5264h
	rlca	
	pop af	
	defb 0fdh,050h,0d6h	;illegal sequence
	ret p	
	di	
	defb 0fdh,090h,0d6h	;illegal sequence
	jp p,0d0fdh
	sub 0f4h
	defb 0fdh,0d6h,0d6h	;illegal sequence
	adc a,0fdh
	call po,0ced6h
	cp 0fdh
	xor l	
	out (0e3h),a
	jp (iy)
	out (0cdh),a
	pop de	
	ret nc	
	nop	
	ret c	
	exx	
	add iy,iy
	call nc,0d3cfh
	jp nc,0da00h
	in a,(0e0h)
	defb 0fdh,06ah,0d4h	;illegal sequence
	push de	
	call nc,0dcddh
	rlca	
	jp po,0aafdh
	call nc,0d6d7h
	rst 18h	
	sbc a,007h
	call po,0ebfdh
	call nc,007e5h
	rlca	
	rlca	
	and 0fdh
	dec hl	
	push de	
	rst 20h	
	jp (hl)	
	ret pe	
	rlca	
	pop hl	
	defb 0fdh,06ch,0d5h	;illegal sequence
	ex de,hl	
	jp pe,00707h
	defb 0fdh,0ach,0d5h	;illegal sequence
	defb 0edh;next byte illegal after ed
	call pe,00707h
	defb 0fdh,0edh,0d5h	;illegal sequence
	xor 0efh
	rlca	
	defb 0fdh,02eh,0d6h	;illegal sequence
	pop af	
	rlca	
	ld l,(iy-02ah)
	di	
	ret p	
	defb 0fdh,0afh,0d6h	;illegal sequence
	jp p,0effdh
	sub 0f4h
	rst 38h	
	cp 01bh
	defb 0fdh,017h,0d2h	;illegal sequence
	ld e,c	
	ld c,a	
	ld d,l	
	ld d,d	
	jr nz,l535dh
	ld c,a	
	ld d,(hl)	
	ld b,l	
l5314h:
	jr nz,l5314h
	rra	
	ld d,e	
	ld c,c	
	ld c,h	
	ld d,(hl)	
	ld c,c	
	ld b,c	
	cp 01bh
	defb 0fdh,097h,0d2h	;illegal sequence
	ld c,c	
	ld d,e	
	jr nz,l536fh
	ld c,(hl)	
	jr nz,l536ch
	ld d,l	
	ld d,e	
	ld d,h	
	ld c,a	
	ld b,h	
	ld e,c	
	jr nz,l537fh
	ld c,a	
	ld d,a	
	ld l,0fdh
	ld d,0d3h
	ld c,c	
	ld b,(hl)	
	jr nz,l5394h
	ld c,a	
	ld d,l	
	jr nz,l5396h
	ld b,c	
	ld c,(hl)	
	ld d,h	
	jr nz,l5398h
	ld c,a	
	jr nz,$+85
	ld b,c	
	ld d,(hl)	
	ld b,l	
	defb 0fdh,097h,0d3h	;illegal sequence
	ld e,c	
	ld c,a	
	ld d,l	
	ld d,d	
	jr nz,l5397h
	ld b,l	
	ld b,c	
	ld d,d	
l5356h:
	jr nz,l5356h
	rra	
	ld d,e	
	ld c,c	
	ld c,h	
	ld d,(hl)	
l535dh:
	ld c,c	
	ld b,c	
	daa	
	ld d,e	
	add iy,de
	call nc,01ffeh
	ld c,h	
	ld c,c	
	ld b,(hl)	
	ld b,l	
	cp 01bh
l536ch:
	inc l	
	jr nz,l53b2h
l536fh:
	ld c,a	
	ld c,l	
	ld b,l	
	jr nz,$+86
	ld c,a	
	defb 0fdh,097h,0d4h	;illegal sequence
	ld d,h	
	ld c,b	
	ld b,l	
	jr nz,$+70
	ld b,l	
	ld d,(hl)	
l537fh:
	ld c,c	
	ld c,h	
	daa	
	ld d,e	
	jr nz,l53d9h
	ld b,l	
	ld c,l	
	ld d,b	
	ld c,h	
	ld b,l	
	defb 0fdh,017h,0d5h	;illegal sequence
	ld b,c	
	ld d,h	
	jr nz,$+81
	ld c,(hl)	
	ld b,e	
	ld b,l	
l5394h:
	ld l,0fdh
l5396h:
	sub (hl)	
l5397h:
	push de	
l5398h:
	dec (hl)	
	jr nz,$+85
	ld c,a	
	ld c,(hl)	
	ld d,e	
	jr nz,l53efh
	ld b,(hl)	
	jr nz,l53f7h
	ld c,b	
	ld b,l	
	jr nz,l53ebh
	ld b,l	
	ld d,(hl)	
	ld c,c	
	ld c,h	
	defb 0fdh,017h,0d6h	;illegal sequence
	ld d,a	
	ld c,c	
	ld c,h	
	ld c,h	
l53b2h:
	jr nz,$+71
	ld c,(hl)	
	ld d,h	
	ld b,l	
	ld d,d	
	ld d,h	
	ld b,c	
	ld c,c	
	ld c,(hl)	
	jr nz,$+91
	ld c,a	
	ld d,l	
	ld l,0ffh
	call sub_5700h
	ld a,005h
	call 00dfeh
	ld a,(0e080h)
	push af	
	ld a,004h
	ld (0e080h),a
	call 0064ah
	ld hl,05400h
l53d9h:
	ld (0e710h),hl
	ld (0e344h),hl
	ld hl,02700h
	ld (0e712h),hl
	ld hl,01a00h
	ld (0e342h),hl
l53ebh:
	pop af	
	ld (0e080h),a
l53efh:
	ld hl,l5447h
	call 0111ch
	ld a,007h
l53f7h:
	ld (0e000h),a
	ld a,070h
	call sub_5416h
	ld hl,l54abh
	call 0111ch
	ld a,005h
	call 00dfeh
	ld a,070h
	call sub_5416h
	ld a,005h
	call 00dfeh
	ld a,0c0h
sub_5416h:
	ld (0e882h),a
l5419h:
	ld a,(0e880h)
	ld de,0d295h
	ld c,0d9h
	ld hl,l5485h
	and 018h
	jr nz,l542bh
	ld hl,05498h
l542bh:
	call 0111ch
	ld hl,0e882h
	ld a,(hl)	
	and a	
	jr nz,l5419h
	ret	
	ld hl,0e703h
	ld a,(hl)	
	and a	
	jr z,l543eh
	dec (hl)	
l543eh:
	call l431fh
	call l4e12h
	jp l47b6h
l5447h:
	cp 096h
	defb 0fdh,018h,0d5h	;illegal sequence
	or a	
	defb 0fdh,057h,0d5h	;illegal sequence
	xor d	
	xor e	
	defb 0fdh,097h,0d5h	;illegal sequence
	xor h	
	xor l	
	defb 0fdh,0d7h,0d5h	;illegal sequence
	or 0f5h
	call m,017fdh
	sub 0f8h
	ld sp,hl	
	rst 30h	
	defb 0fdh,057h,0d6h	;illegal sequence
	jp m,0fefbh
	sub 018h
	ld d,(iy-02fh)
	cp 0d7h
	ld c,h	
	ld b,l	
	ld d,h	
	daa	
	ld d,e	
	jr nz,l54cbh
	ld d,d	
	ld e,c	
	jr nz,$+80
	ld b,l	
	ld e,b	
	ld d,h	
	jr nz,l54c6h
	ld c,h	
	ld c,a	
	ld c,a	
	ld d,d	
	rst 38h	
l5485h:
	ld c,b	
	ld b,l	
	ld c,h	
	ld d,b	
	jr nz,l54d8h
	ld b,l	
	inc l	
	defb 0fdh,015h,0d3h	;illegal sequence
	ld d,h	
	ld c,b	
	ld c,a	
	ld c,l	
	ld b,c	
	ld d,e	
	ld hl,020ffh
	jr nz,$+34
	jr nz,$+34
	jr nz,l54bfh
	jr nz,$-1
	dec d	
	out (020h),a
	jr nz,l54c6h
	jr nz,l54c8h
	jr nz,$+34
	rst 38h	
l54abh:
	cp 0dah
	defb 0fdh,0a3h,0d2h	;illegal sequence
	ld c,c	
	daa	
	ld c,l	
	jr nz,$+69
	ld c,a	
	ld c,l	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	inc iy
	out (052h),a
	ld c,c	
l54bfh:
	ld b,a	
	ld c,b	
	ld d,h	
	jr nz,l5505h
	ld d,a	
	ld b,c	
l54c6h:
	ld e,c	
	inc l	
l54c8h:
	defb 0fdh,0a5h,0d3h	;illegal sequence
l54cbh:
	ld d,e	
	ld c,c	
	ld c,h	
	ld d,(hl)	
	ld c,c	
	ld b,c	
	ld hl,020ffh
	jr nz,l54f6h
	jr nz,$+34
l54d8h:
	jr nz,$+34
	jr nz,l54fch
	jr nz,l54feh
	jr nz,$+73
	ld b,c	
	ld c,l	
	ld b,l	
	jr nz,l5534h
	ld d,(hl)	
	ld b,l	
	ld d,d	
	jr nz,l550ah
	jr nz,l550ch
	jr nz,$+34
	jr nz,l5510h
	jr nz,$+34
	jr nz,$+34
	ld a,021h
l54f6h:
	call 00dfeh
	ld de,0d340h
l54fch:
	ld c,0dbh
l54feh:
	ld ix,054d3h
	call sub_56c3h
l5505h:
	ld a,0e1h
	call sub_570fh
l550ah:
	ld a,038h
l550ch:
	call sub_570fh
	xor a	
l5510h:
	ld (0e700h),a
	ld (0e71ah),a
	ld de,0e083h
	ld hl,0ea00h
	ld b,003h
l551eh:
	ld a,(de)	
	ld (hl),a	
	inc hl	
	dec de	
	djnz l551eh
	ld b,003h
l5526h:
	ld (hl),020h
	inc hl	
	djnz l5526h
	ld c,014h
	ld de,0ea00h
l5530h:
	ld b,003h
l5532h:
	ld a,(de)	
	cp (hl)	
l5534h:
	jr c,l5552h
	jr nz,l553eh
	inc de	
	inc hl	
	djnz l5532h
	jr l5552h
l553eh:
	ld a,b	
	add a,003h
	ld b,a	
l5542h:
	ld a,(hl)	
	push af	
	ld a,(de)	
	ld (hl),a	
	pop af	
	ld (de),a	
	inc hl	
	inc de	
	djnz l5542h
	dec c	
	jr nz,l5530h
	inc de	
	inc de	
	inc de	
l5552h:
	ld a,c	
	cp 014h
	ret z	
	inc b	
	dec b	
	jr z,l555dh
l555ah:
	inc de	
	djnz l555ah
l555dh:
	push de	
	push af	
	ld a,024h
	call 00dfeh
	call sub_5620h
	ld hl,l568ah
	call 0111ch
	pop af	
	ld de,0da11h
	cp 00ah
	jr c,l557ah
	sub 00ah
	ld de,0da21h
l557ah:
	ld l,000h
	srl a
	rr l
	ld h,a	
	add hl,de	
	pop de	
	ld b,00dh
l5585h:
	ld (hl),000h
	inc hl	
	djnz l5585h
	ld bc,0f7fdh
	add hl,bc	
	ld b,003h
	ld a,041h
	ld (hl),a	
	ld (de),a	
	ld a,020h
l5596h:
	ld (0e026h),a
	push de	
	ld de,0d160h
	ld c,000h
	call 010ffh
	pop de	
	ld a,038h
	ld (0e881h),a
l55a8h:
	call sub_570dh
	ld a,(0e904h)
	and 003h
	jr nz,l561bh
	ld a,(0e906h)
	and 003h
	jr z,l55deh
	ld a,(0e883h)
	and a	
	jr nz,l55e2h
	ld a,00bh
	ld (0e883h),a
	ld a,(0e906h)
	bit 0,a
	ld a,(hl)	
	jr nz,l55d5h
	dec a	
	cp 041h
	jr nc,l55f5h
	ld a,05ch
	jr l55f5h
l55d5h:
	inc a	
	cp 05dh
	jr c,l55f5h
	ld a,041h
	jr l55f5h
l55deh:
	xor a	
	ld (0e883h),a
l55e2h:
	ld a,(0e909h)
	and 030h
	jr z,l55f7h
	ld a,(hl)	
	cp 05ch
	jr z,l561bh
	inc de	
	inc hl	
	dec b	
	jr z,l560dh
	ld a,041h
l55f5h:
	ld (hl),a	
	ld (de),a	
l55f7h:
	ld a,(0e881h)
	and a	
	jr nz,l55a8h
	ld a,(0e026h)
	sub 001h
	daa	
	jr nz,l5596h
	ld de,0d160h
	ld c,000h
	call 010ffh
l560dh:
	call sub_562ch
	ld a,01ch
	call sub_570fh
	ld a,000h
	call 00dfeh
	ret	
l561bh:
	ld a,020h
	ld (de),a	
	jr l560dh
sub_5620h:
	call 01157h
	call sub_5703h
	ld hl,l5675h
	call 0111ch
sub_562ch:
	ld hl,0ea06h
	ld de,0d6a1h
	ld a,020h
l5634h:
	push af	
	ld c,0d8h
	call sub_56f7h
	ld c,015h
	inc de	
	ld a,(hl)	
	inc hl	
	and a	
	push de	
	call nz,01108h
	pop de	
	inc de	
	ld b,002h
l5648h:
	ld a,(hl)	
	inc hl	
	call 010ffh
	djnz l5648h
	ld a,030h
	call 01110h
	ld c,000h
	inc de	
	ld b,003h
l5659h:
	ld a,(hl)	
	inc hl	
	call 01110h
	djnz l5659h
	pop af	
	sub 001h
	daa	
	ret z	
	push hl	
	ld hl,0ff73h
	add hl,de	
	ex de,hl	
	pop hl	
	cp 010h
	jr nz,l5634h
	ld de,0d691h
	jr l5634h
l5675h:
	cp 0dbh
	defb 0fdh,0d8h,0d0h	;illegal sequence
	ld b,d	
	ld b,l	
	ld d,e	
	ld d,h	
	jr nz,$+52
	jr nc,l56a2h
	ld d,b	
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	ld d,e	
	rst 38h	
l568ah:
	defb 0fdh,05ah,0d1h	;illegal sequence
	cp 014h
	ld d,h	
	ld c,c	
	ld c,l	
	ld b,l	
	rst 38h	
l5694h:
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,$+34
	jr nz,l56beh
	jr nz,l56c0h
	ld d,h	
	ld c,c	
l56a2h:
	ld c,l	
	ld b,l	
	jr nz,$+81
	ld d,(hl)	
	ld b,l	
	ld d,d	
	jr nz,l56cbh
	jr nz,l56cdh
	jr nz,l56cfh
	jr nz,$+34
	jr nz,$+34
	jr nz,l56d5h
	ld c,0d8h
	ld ix,l5694h
	call sub_56c3h
l56beh:
	ld a,070h
l56c0h:
	jp sub_570fh
sub_56c3h:
	ld hl,(0e902h)
	ld de,00004h
	add hl,de	
	add hl,hl	
l56cbh:
	add hl,hl	
	add hl,hl	
l56cdh:
	add hl,hl	
	add hl,hl	
l56cfh:
	ld a,h	
	add a,01ah
	ld de,0d340h
l56d5h:
	ld l,a	
	ld h,003h
l56d8h:
	push hl	
	ld b,00bh
l56dbh:
	push de	
	ld a,l	
	inc l	
	and 03fh
	or e	
	ld e,a	
	ld a,(ix+000h)
	inc ix
	call 01110h
	pop de	
	djnz l56dbh
	ld hl,00040h
	add hl,de	
	ex de,hl	
	pop hl	
	dec h	
	jr nz,l56d8h
	ret	
sub_56f7h:
	cp 010h
	jp nc,010ffh
	inc de	
	jp 01108h
sub_5700h:
	call 01153h
sub_5703h:
	xor a	
	ld (0e000h),a
	ld hl,00000h
	ld (0e902h),hl
sub_570dh:
	ld a,001h
sub_570fh:
	push hl	
	ld hl,0e882h
	ld (hl),a	
l5714h:
	ld a,(hl)	
	and a	
	jr nz,l5714h
	pop hl	
	ret	
sub_571ah:
	push bc	
	ld b,021h
	jr l572dh
l571fh:
	call sub_5725h
	ld de,0d396h
sub_5725h:
	push bc	
	ld b,01ah
	jr l572dh
sub_572ah:
	push bc	
	ld b,020h
l572dh:
	xor a	
l572eh:
	call 01110h
	djnz l572eh
	pop bc	
	ret	
l5735h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
sub_5739h:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	jr nz,l5744h
	set 5,c
	jr sub_5739h
l5744h:
	inc a	
	jr z,l5735h
	sub 003h
	res 7,c
	cp 008h
	jr c,l5751h
	set 7,c
l5751h:
	call 01110h
	jr sub_5739h
	ld hl,(0e817h)
	ld a,h	
l575ah:
	push hl	
	call sub_5765h
	pop hl	
	inc h	
	ld a,h	
	cp l	
	jr nz,l575ah
	ret	
sub_5765h:
	cp 0e0h
	ret nc	
	ld (0e802h),a
	add a,020h
	and 03fh
	ld hl,0d180h
	or l	
	ld l,a	
	ld a,(0e802h)
	call sub_5800h
	ld a,(0e080h)
	and 001h
	jr nz,l5786h
	call sub_585fh
	jr l5789h
l5786h:
	call sub_5835h
l5789h:
	call sub_5903h
	jr nz,l5793h
	call sub_58d3h
	jr l5796h
l5793h:
	call sub_58f1h
l5796h:
	call sub_57d4h
	call sub_5903h
	cp 003h
	ret nz	
	ld a,(0e802h)
	ld bc,00008h
	ld hl,l5a30h
	cpdr
	ret nz	
	rlc c
	rlc c
	ld a,(0e080h)
	cp 010h
	ld hl,l5a31h
	jr c,l57bch
	ld hl,l5a51h
l57bch:
	add hl,bc	
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
	ex de,hl	
	ld c,011h
l57c4h:
	ld a,(de)	
	inc de	
	ld (hl),a	
	set 3,h
	ld (hl),c	
	ld a,(de)	
	ld de,0f840h
	add hl,de	
	ld (hl),a	
	set 3,h
	ld (hl),c	
	ret	
sub_57d4h:
	ld a,(0e080h)
	and 001h
	ld hl,l5a7ch
	jr nz,l57e1h
	ld hl,l5a88h
l57e1h:
	ld a,(0e802h)
	ld bc,0000ch
	cpdr
	ret nz	
	ld hl,l5a88h+1
	add hl,bc	
	add hl,bc	
	ld a,(0e802h)
	ex de,hl	
	add a,020h
	and 03fh
	ld hl,0d380h
	or l	
	ld l,a	
	ld c,08bh
	jr l57c4h
sub_5800h:
	ld de,l61e7h
	cp 0dah
	jp nc,l5918h
	sub 0d5h
	jr c,l5818h
	push hl	
	ld hl,l59dbh
	ld e,a	
	ld d,000h
	add hl,de	
	ld a,(hl)	
	pop hl	
	jr l581ch
l5818h:
	and 001h
	add a,052h
l581ch:
	ld c,05ch
	call sub_5909h
	ld a,(0e802h)
	and 007h
	push hl	
	ld hl,l59e1h
	ld c,a	
	add hl,bc	
	ld a,(hl)	
	pop hl	
	ld (hl),a	
	set 3,h
	ld (hl),05eh
	add hl,de	
	ret	
sub_5835h:
	ld a,(0e802h)
	cp 0ddh
	ret nc	
	cp 00dh
	jr c,l5849h
	cp 0cfh
	jr c,l586dh
	ld de,l5f83h
	jp l58c5h
l5849h:
	ld b,a	
	ld a,(0e915h)
	cp 001h
	ld a,b	
	ld de,l5d48h
	jr z,l58c5h
	ld de,l5e18h
	jr nc,l58c5h
	ld de,l5c8eh
	jr l58c5h
sub_585fh:
	ld a,(0e802h)
	cp 0ddh
	ret nc	
	cp 013h
	jr c,l589fh
	cp 0d3h
	jr nc,l5886h
l586dh:
	and 01fh
	push af	
	push hl	
	add a,a	
	ld c,a	
	ld hl,l59e9h
	add hl,bc	
	ld a,(hl)	
	inc hl	
	ld c,(hl)	
	pop hl	
	ld (hl),a	
	set 3,h
	ld (hl),c	
	add hl,de	
	pop af	
	ld de,l5b6ah
	jr l58c5h
l5886h:
	ld b,a	
	ld de,l61cbh
	call sub_5903h
	jr z,l589ch
	ld a,(0e915h)
	cp 001h
	ld de,l6176h
	jr nc,l589ch
	ld de,l60f5h
l589ch:
	ld a,b	
	jr l58c5h
l589fh:
	ld e,a	
	call sub_5903h
	cp 004h
	ld a,e	
	ld de,l60b3h
	jr z,l58c5h
	ld de,l5ea9h
	call l5918h
	call sub_5903h
	ld a,(0e802h)
	jr nz,l58beh
	cp 003h
	jr nc,l58c8h
	ret	
l58beh:
	cp 002h
	jr nc,l58c8h
	ld de,l6554h
l58c5h:
	call l5918h
l58c8h:
	ld (hl),005h
	set 3,h
	ld (hl),001h
	ld de,0f840h
	add hl,de	
	ret	
sub_58d3h:
	ld c,04fh
	ld a,(0e802h)
	cp 0c0h
	jr nc,l58ech
	cp 020h
	jr c,l58e7h
	and 01fh
	ld de,l650ch
	jr l5918h
l58e7h:
	ld de,l6402h
	jr l5918h
l58ech:
	ld de,l62f8h
	jr l5918h
sub_58f1h:
	ld a,(0e802h)
	ld de,l63a7h
	cp 0dch
	jr nc,l5918h
	and 001h
	add a,024h
	ld c,042h
	jr sub_5909h
sub_5903h:
	ld a,(0e080h)
	and 007h
	ret	
sub_5909h:
	ld b,003h
	ld de,0f840h
l590eh:
	ld (hl),a	
	set 3,h
	ld (hl),c	
	add hl,de	
	add a,002h
	djnz l590eh
	ret	
l5918h:
	ex de,hl	
	push bc	
	ld b,000h
	ld c,a	
	add hl,bc	
	add hl,bc	
	pop bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ex de,hl	
	ld b,001h
l5927h:
	ld a,(de)	
	inc de	
	inc a	
	jr z,l593fh
	inc a	
	jr z,l5946h
	add a,0feh
	ld (hl),a	
	set 3,h
	ld (hl),c	
	ld a,040h
	add a,l	
	ld l,a	
	ld a,0f8h
	adc a,h	
	ld h,a	
	jr l5927h
l593fh:
	dec b	
	ret z	
	pop de	
l5942h:
	inc de	
	inc de	
	jr l5927h
l5946h:
	ld a,(de)	
	inc de	
	cp 0fch
	jr c,l5958h
	jr z,l5950h
	push de	
	inc b	
l5950h:
	ex de,hl	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ex de,hl	
	jr l5927h
l5958h:
	ld c,a	
	jr l5927h
	cp 015h
	defb 0fdh,0d8h,0d2h	;illegal sequence
	ld d,e	
	ld b,l	
	ld c,h	
	ld b,l	
	ld b,e	
	ld d,h	
	jr nz,l59afh
	ld b,c	
	ld c,l	
	ld b,l	
	jr nz,$+72
	ld c,h	
	ld c,a	
	ld c,a	
	ld d,d	
	defb 0fdh,09ah,0d3h	;illegal sequence
	ld c,b	
	ld c,a	
	ld d,l	
	ld d,e	
	ld b,l	
	jr nz,l59c9h
	ld d,l	
	ld c,l	
	ld b,d	
	ld b,l	
	ld d,d	
	dec l	
	defb 0fdh,01ah,0d4h	;illegal sequence
	ld b,(hl)	
	ld c,h	
	ld c,a	
	ld c,a	
	ld d,d	
	jr nz,l59d9h
	ld d,l	
	ld c,l	
	ld b,d	
	ld b,l	
	ld d,d	
	dec l	
	defb 0fdh,098h,0d4h	;illegal sequence
	ld d,b	
	ld d,l	
	ld c,(hl)	
	ld b,e	
	ld c,b	
	dec l	
	ld d,l	
	ld d,b	
	jr nz,l59e9h
	ld c,c	
	ld b,e	
	ld c,e	
	dec l	
	ld b,h	
	ld c,a	
	ld d,a	
	ld c,(hl)	
	rst 38h	
	cp 015h
	defb 0fdh,011h,0d0h	;illegal sequence
	ld sp,02d50h
l59afh:
	defb 0fdh,026h,0d0h	;illegal sequence
	ld (02d50h),a
	cp 000h
	defb 0fdh,01bh,0d0h	;illegal sequence
	ld d,h	
	ld c,a	
	ld d,b	
	dec l	
	cp 014h
	defb 0fdh,0aah,0d0h	;illegal sequence
	ld d,h	
	ld c,c	
	ld c,l	
	ld b,l	
	cp 094h
l59c9h:
	defb 0fdh,091h,0d0h	;illegal sequence
	sbc a,b	
	sbc a,c	
	sbc a,d	
	sbc a,e	
	sbc a,h	
	cp 095h
	defb 0fdh,011h,0d1h	;illegal sequence
	sbc a,l	
	sbc a,(hl)	
	sbc a,a	
l59d9h:
	and b	
	rst 38h	
l59dbh:
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
	out (001h),a
	ld a,a	
	inc e	
	call nc,07e7ch
	dec e	
l5a3eh:
	call nc,sub_7f01h
	jp m,l7cd4h+1
	ld a,(hl)	
	ei	
	push de	
	ld bc,0107fh
	out (07ch),a
	ld a,(hl)	
	ld de,001d3h
	ld a,a	
l5a51h:
	ld (bc),a	
	out (07ch),a
	ld a,(hl)	
	inc bc	
	out (001h),a
	ld a,a	
	inc e	
	call nc,07e7ch
	dec e	
l5a5eh:
	call nc,sub_7f01h
	ld a,(l7cd4h)
	ld a,(hl)	
	dec sp	
	call nc,sub_7f01h
	djnz l5a3eh
	ld a,h	
	ld a,(hl)	
	ld de,001d3h
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
	ld de,00000h
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
	ld sp,02d2ch
	cp 011h
	inc bc	
	cp 091h
	inc hl	
	defb 0fdh,079h,0d6h	;illegal sequence
	ld l,02fh
	ld (011feh),hl
	inc bc	
	defb 0fdh,0bah,0d6h	;illegal sequence
	cp 091h
	dec hl	
	inc h	
	dec h	
	rst 38h	
	defb 0fdh,0fch,0d4h	;illegal sequence
l5af3h:
	cp 041h
l5af5h:
	ld (03bfdh),hl
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
	call z,001feh
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
	call z,001feh
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
	call 001feh
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
	call z,001feh
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
	ld hl,0395fh
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
	jp z,00000h
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
	jp c,0e2e0h
	call po,0e9e6h
	cp 041h
	add a,b	
	ld (08080h),hl
	add a,b	
	cp 006h
	sbc a,h	
	sub d	
	cp 00ah
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
sub_60fdh:
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
	call z,001feh
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
	call c,004deh
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
	jp c,l4bfeh
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
	jp c,l4bfeh
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
	jp c,l4bfeh
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
	ld de,01513h
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
	ld bc,00302h
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
	ld hl,(02e2ch)
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
	ld bc,00b07h
	cp 006h
	dec b	
	ld (bc),a	
	add hl,bc	
	dec bc	
	defb 0fdh,008h,005h	;illegal sequence
	ld bc,00b0ch
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
	ld de,01206h
	djnz l6579h
	ld b,014h
	inc b	
	djnz l65ebh
l65ebh:
	dec b	
	ld d,l	
	ld bc,00088h
	nop	
	dec b	
	ld d,(hl)	
	ld bc,00088h
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
	ld bc,02803h
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
	ld (0002ch),hl
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
	ld hl,(01022h)
	ld (bc),a	
	adc a,b	
	ld hl,(00210h)
	adc a,d	
	ld (00130h),hl
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
	ld a,(000e0h)
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
	ld bc,02709h
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
	ld (01701h),a
l676fh:
	dec h	
	ld b,d	
	nop	
	ld d,0ffh
	ld hl,(00210h)
	sbc a,(hl)	
	ld hl,(00130h)
	add hl,de	
	jr z,$+66
	nop	
	inc e	
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
	ld hl,(00130h)
	dec e	
	jr z,l67dch
	nop	
	inc e	
	rst 38h	
	ld hl,(0003ch)
	ld hl,01028h
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
	ld hl,01028h
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
	ld sp,02201h
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
sub_67fdh:
	nop	
	rst 38h	
	jr z,l684ah
	nop	
	ld hl,01028h
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
	ld hl,(00130h)
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
	ld hl,(00080h)
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
	ld bc,0282bh
	ld b,b	
l687dh:
	nop	
	ld hl,(00fffh)
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
	ld (01028h),a
	ld (bc),a	
	call nz,0302eh
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
	ld bc,02e11h
	inc hl	
	ld bc,02d0fh
	inc sp	
	nop	
	ld c,0ffh
	rrca	
	ld a,(00060h)
	ret po	
	rst 38h	
	rrca	
	ld sp,000c0h
	nop	
	nop	
	rrca	
	ld (00040h),hl
	jr nz,$+1
	rst 38h	
	dec h	
	djnz l6930h
	sub (hl)	
	dec (hl)	
l6930h:
	djnz $+4
	sbc a,b	
	ld hl,(00123h)
	inc de	
	ld hl,(00033h)
	ld (de),a	
	rst 38h	
	rrca	
	ld a,(00060h)
	ret po	
	rst 38h	
	rrca	
	ld (000c0h),a
	jr nz,l6948h
l6948h:
	rrca	
	ld (00020h),hl
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
	ld a,(00040h)
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
	ld bc,000e0h
	rst 38h	
	jr l6a04h
	nop	
	ld hl,01b12h
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
	ld bc,02c35h
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
	ld a,(000c0h)
	jr nz,l6a26h
l6a26h:
	rst 38h	
	ld hl,(00040h)
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
	jp pe,0141ch
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
	call pe,0302eh
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
	ld (0196bh),hl
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
	ld bc,01029h
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
	ld de,01028h
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
	call p,0102ah
	jp nc,0fff6h
	inc l	
	ld e,0d1h
	ret m	
	ld hl,(0d20ah)
	jp m,029ffh
	dec c	
	pop de	
	call m,01226h
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
	call m,01824h
	sub d	
	ei	
	rst 38h	
	jr z,l6beah
	pop de	
	cp 021h
	ld de,0fc92h
	rst 38h	
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
	jp nc,0102bh
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
	call nc,017ffh
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
	call m,0201ah
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
	jp po,03025h
	add hl,bc	
l6d74h:
	call po,03835h
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
	jp pe,03018h
	ld c,b	
	jr nz,l6ddah
	djnz l6dbfh
	call pe,02828h
	add hl,bc	
	xor 028h
	ld c,b	
	ld c,c	
l6dbfh:
	ld hl,03c2bh
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
	ld (01027h),hl
	ex af,af'	
	jp p,02e27h
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
	jp m,00e2ch
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
	call m,0201ah
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
	call m,0201ah
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
	call po,020ffh
	ld de,l6c08h
	rra	
	ld sp,02849h
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
	ld hl,(017ffh)
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
	call po,sub_7dffh
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
	ld bc,01021h
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
	ld hl,(01028h)
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
	ld a,(02bffh)
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
	ld sp,00c8fh
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
	call nz,026ffh
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
	jp z,018ffh
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
	ld (0101eh),hl
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
	ld bc,026ffh
	jr c,l7094h
	nop	
	ld e,020h
	rst 10h	
	jr nz,l70f2h
	jr nz,$-39
	ld (0101eh),hl
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
	ld (0303fh),a
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
	ld (014d6h),a
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
	ld sp,01ad6h
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
	jp c,03084h
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
	jp nz,01025h
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
	jp z,0332dh
	exx	
	call z,0101fh
	jp c,02fceh
	djnz l732fh
	ret nc	
	rst 38h	
	ld h,031h
	exx	
l735ah:
	jp nc,02825h
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
	call c,02323h
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
	jp po,01025h
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
	jp c,03eeah
	djnz l7384h
	ld a,(hl)	
	rst 38h	
	dec e	
	dec de	
	exx	
	call pe,01018h
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
	jr z,l743dh
	dec de	
	add hl,sp	
	daa	
	dec hl	
	inc e	
	ld a,(01028h)
	sbc a,h	
	ld h,b	
	rst 38h	
l740dh:
	jr z,l744bh
	dec de	
	add hl,sp	
	jr z,l743fh
	sbc a,h	
	jp m,01028h
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
	ld (02f1bh),a
	ld e,01ah
	inc e	
	ld e,(hl)	
	dec h	
	ld c,09ch
	call c,0261eh
	dec e	
	jr nz,$+1
	inc hl	
	ld (0381bh),a
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
	ld (0381bh),a
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
	ld a,(028ffh)
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
	ld (01020h),a
	ld c,d	
	jr nc,l752bh
l74fbh:
	djnz l7547h
	ld sp,028ffh
	djnz $+77
	ld (021ffh),a
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
	call pe,026ffh
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
	ld hl,00c35h
	ld a,b	
l753eh:
	ld sp,00c35h
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
	ld de,028ffh
	djnz l7576h
	ld (de),a	
	rst 38h	
	inc h	
	add hl,bc	
	ld bc,0ff01h
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
	call po,028ffh
	djnz l7541h
	push hl	
	rst 38h	
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
	call nc,028ffh
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
	ld de,01676h
	halt	
	dec de	
	halt	
	jr nz,$+120
	dec h	
	halt	
	ld hl,(02f76h)
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
	jp p,028ffh
	djnz l75afh
l7623h:
	di	
	rst 38h	
	jr z,l7637h
	adc a,h	
l7628h:
	call p,028ffh
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
	ld a,0ffh
	ld (0e000h),a
	ei	
	call sub_570dh
	call 01157h
	di	
l7673h:
	ld ix,00000h
	ld b,000h
	ld a,000h
l767bh:
	ld e,a	
	ld d,00dh
	ld c,010h
	ld hl,0e000h
l7683h:
	ld (hl),a	
	inc hl	
	inc a	
	dec d	
	jr nz,l768ch
	ld d,00dh
	inc a	
l768ch:
	djnz l7683h
	dec c	
	jr nz,l7683h
	ld a,e	
	ld hl,0e000h
	ld d,00dh
	ld c,010h
l7699h:
	cp (hl)	
	jp nz,l77f6h
l769dh:
	inc hl	
	inc a	
	dec d	
	jr nz,l76a5h
	ld d,00dh
	inc a	
l76a5h:
	djnz l7699h
	dec c	
	jr nz,l7699h
	ld a,e	
	inc a	
	cp 014h
	jr nz,l767bh
	ld a,000h
l76b2h:
	ld e,a	
	ld d,00dh
	ld c,010h
	ld hl,0d000h
l76bah:
	ld (hl),a	
	inc hl	
	inc a	
	dec d	
	jr nz,l76c3h
	ld d,00dh
	inc a	
l76c3h:
	djnz l76bah
	dec c	
	jr nz,l76bah
	ld a,e	
	ld hl,0d000h
	ld d,00dh
	ld c,010h
l76d0h:
	cp (hl)	
	jp nz,l77bdh
l76d4h:
	inc hl	
	inc a	
	dec d	
	jr nz,l76dch
	ld d,00dh
	inc a	
l76dch:
	djnz l76d0h
	dec c	
	jr nz,l76d0h
	ld a,e	
	inc a	
	cp 014h
	jr nz,l76b2h
l76e7h:
	call 01157h
	ld hl,0e000h
	ld de,0e001h
	ld bc,00fffh
	ld (hl),000h
	ldir
	ld hl,0eb25h
	ld (0eb03h),hl
	ld a,0ffh
	ld (0e000h),a
	ld de,00000h
	call sub_7c10h
	ld bc,(0006ah)
	xor a	
	sbc hl,bc
	jr z,l7712h
	inc a	
l7712h:
	call sub_7c10h
	ld bc,(0006ch)
	sbc hl,bc
	jr z,l771fh
	set 1,a
l771fh:
	push af	
	ld b,a	
	ld c,014h
	ld de,0d1d5h
	ld a,031h
	call sub_7bf7h
	ld de,0d255h
	ld a,032h
	call sub_7bf7h
	push ix
	pop hl	
	ld a,l	
	or h	
	ld de,0d155h
	ld hl,l7889h
	jr nz,l7743h
	ld hl,l7891h
l7743h:
	call 0111ch
	ei	
	ld a,070h
	call sub_570fh
	ld a,b	
	and a	
	call nz,sub_7be8h
l7751h:
	call 01157h
	ld hl,l7cf7h
	call 0111ch
	xor a	
	ld (0e882h),a
	ld a,(0e81dh)
l7761h:
	ld (0e81dh),a
	ld c,000h
	call sub_7bd7h
l7769h:
	ld a,(0e906h)
	and 003h
	ld hl,0e882h
	jr z,l7798h
	ld b,a	
	ld a,(hl)	
	and a	
	jr nz,l779ah
	ld (hl),010h
	ld c,014h
	ld a,(0e81dh)
	push af	
	call sub_7bd7h
	pop af	
	bit 1,b
	jr nz,l7790h
	dec a	
	jp p,l7761h
	ld a,005h
	jr l7761h
l7790h:
	inc a	
	cp 006h
	jr c,l7761h
	xor a	
	jr l7761h
l7798h:
	ld (hl),000h
l779ah:
	ld a,(0e904h)
	bit 0,a
	jr z,l7769h
	call 01157h
	ld hl,l7751h
	push hl	
	ld a,(0e81dh)
	ld hl,l77b1h
	jp 01f26h
l77b1h:
	sbc a,c	
	ld a,b	
	ld a,079h
	cp d	
	ld a,c	
	adc a,e	
	ld a,d	
	djnz $+125
	ld a,b	
	ld a,e	
l77bdh:
	ex af,af'	
	exx	
	ld de,0e000h
	ld hl,0d155h
	ld bc,00020h
	ldir
	ld de,0e020h
	ld hl,0d955h
	ld bc,00020h
	ldir
	ld ix,l77dbh
	jr l77fch
l77dbh:
	exx	
	ld hl,0e000h
	ld de,0d155h
	ld bc,00020h
	ldir
	ld hl,0e020h
	ld de,0d955h
	ld bc,00020h
	ldir
	exx	
	jp l76d4h
l77f6h:
	ld ix,l769dh
	ex af,af'	
	exx	
l77fch:
	ld hl,0d155h
	ld de,l7889h
	ld b,007h
l7804h:
	ld a,(de)	
	inc de	
	ld iy,l780ch
	jr l787fh
l780ch:
	djnz l7804h
	ld a,03ah
	ld iy,l7816h
	jr l787fh
l7816h:
	exx	
	ld a,h	
	exx	
	ld iy,l781fh
	jr l7861h
l781fh:
	exx	
	ld a,l	
	exx	
	ld iy,l7828h
	jr l7861h
l7828h:
	ld a,03ah
	ld iy,l7830h
	jr l787fh
l7830h:
	ex af,af'	
	ld e,a	
	ex af,af'	
	ld a,e	
	ld iy,l783ah
	jr l7861h
l783ah:
	inc hl	
	exx	
	ld a,(hl)	
	exx	
	ld iy,l7844h
	jr l7861h
l7844h:
	in a,(000h)
	bit 0,a
	jp z,l76e7h
	bit 1,a
	jr nz,l7844h
	ld bc,01000h
l7852h:
	dec bc	
	ld a,c	
	or b	
	jr nz,l7852h
l7857h:
	in a,(000h)
	bit 1,a
	jr z,l7857h
	exx	
	ex af,af'	
	jp (ix)
l7861h:
	ld e,a	
	rrca	
	rrca	
	rrca	
	rrca	
	and 00fh
	add a,090h
	daa	
	adc a,040h
	daa	
	ld (hl),a	
	set 3,h
	ld (hl),014h
	res 3,h
	inc hl	
	ld a,e	
	and 00fh
	add a,090h
	daa	
	adc a,040h
	daa	
l787fh:
	ld (hl),a	
	set 3,h
	ld (hl),014h
	res 3,h
	inc hl	
	jp (iy)
l7889h:
	ld d,d	
	ld b,c	
	ld c,l	
	jr nz,$+34
	ld c,(hl)	
	ld b,a	
	rst 38h	
l7891h:
	ld d,d	
	ld b,c	
	ld c,l	
	jr nz,$+34
	ld c,a	
	ld c,e	
	rst 38h	
	ld hl,l7c30h
	call 0111ch
	call sub_7bc1h
	call 0111ch
l78a5h:
	ld de,0d199h
	in a,(003h)
	call sub_7bb2h
	ld de,0d1d9h
	in a,(004h)
	call sub_7bb2h
	in a,(004h)
	bit 1,a
	ld hl,l7c96h
	jr nz,l78c1h
	ld hl,l7c9eh
l78c1h:
	ld de,0d35dh
	call 0111ch
	in a,(003h)
	and 001h
	ld hl,l7ca6h
	jr nz,l78d3h
	ld hl,l7cb0h
l78d3h:
	ld de,0d39eh
	call 0111ch
	in a,(003h)
	and 002h
	ld hl,l7cbah
	jr nz,l78e5h
	ld hl,l7cbfh
l78e5h:
	ld de,0d3deh
	call 0111ch
	call 0056fh
	ld de,0d41fh
	call 01108h
	call 0058fh
	ld b,c	
	ld de,0d29ah
	ld hl,(0e90ah)
	ld a,l	
	and a	
	jr z,l792ah
	cp h	
	push af	
	ld a,020h
	jr z,l790ah
	ld a,041h
l790ah:
	call 01110h
	call sub_49f7h
	pop af	
	ld de,0d2d0h
	jr z,l7933h
	push hl	
	ld hl,l7c8ch
	call 0111ch
	inc de	
	ld a,042h
	call 01110h
	pop hl	
	ld l,h	
	call sub_49f7h
	jr l7936h
l792ah:
	ld hl,l7cc4h
	call 0111ch
	ld de,0d2d0h
l7933h:
	call sub_571ah
l7936h:
	in a,(000h)
	bit 1,a
	jp nz,l78a5h
	ret	
	ld bc,00314h
	ld de,0d455h
l7944h:
	push bc	
	ld hl,l7cd8h
	call 0111ch
	push hl	
	inc de	
	ld a,b	
	call 01108h
	call sub_7bc1h
	ld hl,0002ch
	add hl,de	
	ex de,hl	
	pop hl	
	call 0111ch
	ld hl,0feb6h
	add hl,de	
	ex de,hl	
	pop bc	
	djnz l7944h
	ld hl,l7cech
	call 0111ch
	ld hl,09999h
	ld (0e003h),hl
l7971h:
	ld a,038h
	ld (0e882h),a
	ld hl,0e003h
	ld a,(hl)	
	add a,001h
	daa	
	ld (hl),a	
	inc hl	
	ld a,(hl)	
	adc a,000h
	daa	
	ld (hl),a	
	ld de,0d562h
	call 010fdh
	call 010fdh
l798dh:
	in a,(000h)
	ld de,0d2a2h
	call sub_7bb2h
	in a,(001h)
	ld de,0d3a2h
	call sub_7bb2h
	in a,(002h)
	ld de,0d4a2h
	call sub_7bb2h
	ld a,(0e882h)
	and a	
	jr z,l7971h
	ld a,(0e904h)
	bit 1,a
	jr z,l798dh
	ld a,(0e906h)
	bit 1,a
	jr z,l798dh
	ret	
	xor a	
	ld (0e882h),a
l79beh:
	push af	
	ld hl,l7a61h
	ld e,a	
	ld d,000h
	add hl,de	
	add hl,de	
l79c7h:
	ld a,(0e904h)
	bit 0,a
	jr nz,l79c7h
	ld a,(hl)	
	ld (0e883h),a
	ld (0e81fh),a
	inc hl	
	ld a,000h
	call 00dfeh
	ld a,(hl)	
	call 00dfeh
	ld hl,l7d56h
	call 0111ch
	pop af	
l79e6h:
	ld (0e81eh),a
	ld c,000h
	call sub_7bceh
l79eeh:
	ld a,(0e906h)
	and 003h
	ld hl,0e882h
	jr z,l7a26h
	ld b,a	
	ld a,(hl)	
	and a	
	jr nz,l79eeh
	ld a,000h
	call 00dfeh
	xor a	
	ld (0e81fh),a
	ld (hl),010h
	ld c,014h
	ld a,(0e81eh)
	push af	
	call sub_7bceh
	pop af	
	bit 1,b
	jr nz,l7a1eh
	dec a	
	jp p,l79e6h
	ld a,014h
	jr l79e6h
l7a1eh:
	inc a	
	cp 015h
	jr c,l79e6h
	xor a	
	jr l79e6h
l7a26h:
	ld (hl),000h
	ld a,(0e81fh)
	and a	
	jr z,l7a40h
	ld b,a	
	ld a,(0e883h)
	and a	
	jr z,l7a46h
	ld a,(0e904h)
	and 003h
	jr z,l79eeh
	bit 1,a
	jr nz,l7a5bh
l7a40h:
	ld a,(0e81eh)
l7a43h:
	jp l79beh
l7a46h:
	ld a,b	
	cp 0bah
	ld (0e883h),a
	ld a,001h
	ld (0e81fh),a
	jr nc,l79eeh
	ld a,(0e81eh)
	inc a	
	cp 015h
l7a59h:
	jr c,l7a43h
l7a5bh:
	ld a,000h
	call 00dfeh
	ret	
l7a61h:
	dec l	
	ld bc,0022dh
	dec l	
	inc bc	
	or h	
	dec b	
	sbc a,(hl)	
	inc b	
	dec l	
	ld b,02dh
	rlca	
	dec l	
	djnz $+47
	ld de,0122dh
	dec l	
	inc de	
	dec l	
	inc d	
	dec l	
	dec d	
	dec l	
	ld d,0bah
	jr nz,$+1
	inc h	
	cp d	
	ld (023ffh),hl
	cp d	
	ld hl,0172dh
	dec l	
	jr l7a59h
	ld d,e	
	ld de,00021h
	ret po	
	ld (hl),0feh
l7a93h:
	ld a,(0e906h)
	and 003h
	jr z,l7aa4h
	bit 1,a
	jr z,l7aa2h
	ld (hl),0fdh
	jr l7aa4h
l7aa2h:
	ld (hl),0feh
l7aa4h:
	ld a,(0e904h)
	bit 1,a
	jr z,l7a93h
	ld (hl),0ffh
	ret	
	ld c,000h
	inc a	
	jr nz,l7ae5h
	ld hl,00110h
	ld de,000e0h
	ld a,000h
	call sub_7adch
	ld hl,00110h
	ld de,00120h
	ld a,040h
	call sub_7adch
	ld hl,000d0h
	ld de,000e0h
	ld a,080h
	call sub_7adch
	ld hl,000d0h
	ld de,00120h
	ld a,0c0h
sub_7adch:
	ld (0e807h),hl
	ld hl,l75deh
	jp 00e20h
l7ae5h:
	ld hl,000c0h
	ld (0e807h),hl
	ld de,000d0h
	ld hl,l669bh
	call sub_7b0ch
	ld de,000f0h
	ld hl,l6c6ah
	call sub_7b0ch
	ld de,00110h
	ld hl,06e7dh
	call sub_7b0ch
	ld de,00130h
	ld hl,l726bh
sub_7b0ch:
	xor a	
	jp 00e20h
	ld de,0d1d0h
	ld c,014h
	ld a,041h
	ld b,01ah
	call sub_7bc7h
	ld de,0d210h
	ld a,030h
	ld b,00ah
	call sub_7bc7h
	call sub_7be8h
	ld a,004h
	ld de,00004h
	call 0115bh
	call sub_7be8h
	ld e,001h
	call 0115bh
	call sub_7be8h
	ld e,002h
	call 0115bh
	call sub_7be8h
	ld bc,00200h
	ld e,006h
	call 0115eh
	ld bc,00400h
	ld e,000h
	call 01165h
	ld bc,00200h
	ld e,007h
	call 01165h
	ld hl,0d410h
	ld c,008h
l7b61h:
	ld a,000h
l7b63h:
	ld b,004h
l7b65h:
	ld (hl),a	
	inc hl	
	djnz l7b65h
	inc a	
	and 007h
	jr nz,l7b63h
	ld de,00020h
	add hl,de	
	dec c	
	jr nz,l7b61h
	jp sub_7be8h
	ld c,000h
	ld de,0d010h
	ld a,00bh
	ld l,020h
l7b81h:
	push hl	
	ld b,010h
l7b84h:
	call 01110h
	dec a	
	call 01110h
	inc a	
	djnz l7b84h
	ld hl,00020h
	add hl,de	
	ex de,hl	
	cp 00bh
	ld a,00bh
	jr nz,l7b9bh
	ld a,009h
l7b9bh:
	pop hl	
	dec l	
	jr nz,l7b81h
	ld hl,0d3dfh
	ld (hl),00ch
	inc hl	
	ld (hl),00dh
	ld hl,0d41fh
	ld (hl),00eh
	inc hl	
	ld (hl),00fh
	jp sub_7be8h
sub_7bb2h:
	cpl	
	ld l,a	
	ld b,008h
l7bb6h:
	xor a	
	rrc l
	rl a
	call 01108h
	djnz l7bb6h
	ret	
sub_7bc1h:
	inc de	
	inc de	
	ld a,031h
	ld b,008h
sub_7bc7h:
	call 01110h
	inc a	
	djnz sub_7bc7h
	ret	
sub_7bceh:
	cp 006h
	jr c,l7bd3h
	inc a	
l7bd3h:
	and a	
	jr z,sub_7bd7h
	inc a	
sub_7bd7h:
	ld l,a	
	ld h,000h
	add hl,hl	
	add hl,hl	
	add hl,hl	
	add hl,hl	
	add hl,hl	
	add hl,hl	
	ld de,0d950h
	add hl,de	
	ld (hl),c	
	inc hl	
	ld (hl),c	
	ret	
sub_7be8h:
	ld a,(0e904h)
	bit 1,a
	jr z,sub_7be8h
l7befh:
	ld a,(0e904h)
	bit 1,a
	jr nz,l7befh
	ret	
sub_7bf7h:
	push af	
	ld hl,l7c2ch
	call 0111ch
	pop af	
	call 01110h
	inc de	
	ld hl,l7c29h
	rrc b
	jr c,l7c0dh
	ld hl,l7c26h
l7c0dh:
	jp 0111ch
sub_7c10h:
	push af	
	ld bc,l4000h
	ld hl,00000h
l7c17h:
	ld a,(de)	
	add a,l	
	ld l,a	
	ld a,000h
	adc a,h	
	ld h,a	
	inc de	
	dec bc	
	ld a,c	
	or b	
	jr nz,l7c17h
	pop af	
	ret	
l7c26h:
	ld c,a	
	ld c,e	
	rst 38h	
l7c29h:
	ld c,(hl)	
	ld b,a	
	rst 38h	
l7c2ch:
	ld d,d	
	ld c,a	
	ld c,l	
	rst 38h	
l7c30h:
	cp 014h
	defb 0fdh,050h,0d1h	;illegal sequence
	ld b,h	
	ld c,c	
	ld d,b	
	jr nz,l7c8dh
	ld d,a	
	jr nz,$+1
	defb 0fdh,094h,0d1h	;illegal sequence
	ld b,h	
	ld d,e	
	ld d,a	
	ld sp,0d4fdh
	pop de	
	ld b,h	
	ld d,e	
	ld d,a	
	ld (0a3fdh),a
	pop de	
	ld sp,l4f2eh
	ld c,(hl)	
	ex (sp),iy
	pop de	
	jr nc,l7c85h
	ld c,a	
	ld b,(hl)	
	ld b,(hl)	
	defb 0fdh,050h,0d3h	;illegal sequence
	ld b,d	
	ld c,a	
	ld b,h	
	ld e,c	
	jr nz,l7cb7h
	ld e,c	
	ld d,b	
	ld b,l	
	defb 0fdh,090h,0d3h	;illegal sequence
	ld b,h	
	ld c,c	
	ld b,(hl)	
	ld b,(hl)	
	ld c,c	
	ld b,e	
	ld d,l	
	ld c,h	
	ld d,h	
	ld e,c	
	defb 0fdh,0d0h,0d3h	;illegal sequence
	ld b,h	
	ld b,l	
	ld b,e	
	ld d,d	
	ld b,l	
	ld b,c	
	ld d,e	
	ld b,l	
	defb 0fdh,010h,0d4h	;illegal sequence
	ld b,(hl)	
	ld c,c	
	ld b,a	
	ld c,b	
l7c85h:
	ld d,h	
	ld b,l	
	ld d,d	
	ld d,e	
	defb 0fdh,090h,0d2h	;illegal sequence
l7c8ch:
	ld b,e	
l7c8dh:
	ld c,a	
	ld c,c	
	ld c,(hl)	
	jr nz,l7cdfh
	ld c,a	
	ld b,h	
	ld b,l	
	rst 38h	
l7c96h:
	ld d,h	
	ld b,c	
	ld b,d	
	ld c,h	
	ld b,l	
	jr nz,l7cbdh
	rst 38h	
l7c9eh:
	ld d,l	
	ld d,b	
	ld d,d	
	ld c,c	
	ld b,a	
	ld c,b	
	ld d,h	
	rst 38h	
l7ca6h:
	ld b,l	
	ld b,c	
	ld d,e	
	ld e,c	
	jr nz,l7ccch
	jr nz,$+34
	jr nz,$+1
l7cb0h:
	ld b,h	
	ld c,c	
	ld b,(hl)	
	ld b,(hl)	
	ld c,c	
	ld b,e	
	ld d,l	
l7cb7h:
	ld c,h	
	ld d,h	
	rst 38h	
l7cbah:
	ld d,e	
	ld c,h	
	ld c,a	
l7cbdh:
	ld d,a	
	rst 38h	
l7cbfh:
	ld b,(hl)	
	ld b,c	
	ld d,e	
	ld d,h	
	rst 38h	
l7cc4h:
	jr nz,l7ce6h
	jr nz,l7ce8h
	jr nz,l7d10h
	ld d,d	
	ld b,l	
l7ccch:
	ld b,l	
	jr nz,l7cefh
	jr nz,l7d21h
	ld c,h	
	ld b,c	
	ld e,c	
l7cd4h:
	jr nz,l7cf6h
	jr nz,$+1
l7cd8h:
	ld c,c	
	ld c,(hl)	
	ld d,h	
	ld b,l	
	ld d,d	
	ld b,(hl)	
	ld b,c	
l7cdfh:
	ld b,e	
	ld b,l	
	rst 38h	
	ld d,d	
	ld b,l	
	ld b,c	
	ld b,h	
l7ce6h:
	jr nz,l7d2ch
l7ce8h:
	ld b,c	
	ld d,h	
	ld b,c	
	rst 38h	
l7cech:
	defb 0fdh,057h,0d5h	;illegal sequence
l7cefh:
	ld d,h	
	ld c,c	
	ld c,l	
	ld c,l	
	ld c,c	
	ld c,(hl)	
	ld b,a	
l7cf6h:
	rst 38h	
l7cf7h:
	cp 014h
	defb 0fdh,050h,0d1h	;illegal sequence
	jr nc,l7d2fh
	jr nz,l7d44h
	ld c,c	
	ld d,b	
	jr nz,$+85
	ld d,a	
	ld c,c	
	ld d,h	
	ld b,e	
	ld c,b	
	defb 0fdh,090h,0d1h	;illegal sequence
	jr nc,$+52
	jr nz,$+75
l7d10h:
	cpl	
	ld c,a	
	jr nz,$+82
	ld c,a	
	ld d,d	
	ld d,h	
	defb 0fdh,0d0h,0d1h	;illegal sequence
	jr nc,l7d4fh
	jr nz,l7d71h
	ld c,a	
	ld d,l	
	ld c,(hl)	
l7d21h:
	ld b,h	
	defb 0fdh,010h,0d2h	;illegal sequence
	jr nc,l7d5bh
	jr nz,l7d6ch
	ld c,b	
	ld b,c	
	ld d,d	
l7d2ch:
	ld b,c	
	ld b,e	
	ld d,h	
l7d2fh:
	ld b,l	
	ld d,d	
	defb 0fdh,050h,0d2h	;illegal sequence
	jr nc,$+55
	jr nz,l7d7bh
	ld c,a	
	ld c,h	
	ld c,a	
	ld d,d	
	defb 0fdh,090h,0d2h	;illegal sequence
	jr nc,l7d77h
	jr nz,l7d86h
	ld d,d	
l7d44h:
	ld c,a	
	ld d,e	
	ld d,e	
	jr nz,$+74
	ld b,c	
	ld d,h	
	ld b,e	
	ld c,b	
	jr nz,l7d9fh
l7d4fh:
	ld b,c	
	ld d,h	
	ld d,h	
	ld b,l	
	ld d,d	
	ld c,(hl)	
	rst 38h	
l7d56h:
	cp 014h
	defb 0fdh,015h,0d1h	;illegal sequence
l7d5bh:
	ld d,e	
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld b,h	
	defb 0fdh,050h,0d1h	;illegal sequence
	jr nc,l7d96h
	jr nz,l7dc0h
	ld b,l	
	ld c,h	
	ld c,h	
	jr nz,$+81
l7d6ch:
	ld b,(hl)	
	jr nz,$+82
	ld c,h	
	ld b,c	
l7d71h:
	ld e,c	
	ld b,l	
	ld d,d	
	jr z,l7dc0h
	ld d,l	
l7d77h:
	ld c,l	
	ld d,b	
	dec l	
	ld c,e	
l7d7bh:
	ld c,c	
	ld b,e	
	ld c,e	
	ld d,e	
	add hl,hl	
	defb 0fdh,093h,0d1h	;illegal sequence
	ld b,e	
	ld d,d	
	ld b,l	
l7d86h:
	ld b,h	
	ld c,c	
	ld d,h	
	jr nz,l7dcch
	ld b,h	
	ld b,h	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,l7de5h
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld b,h	
l7d96h:
	defb 0fdh,0d0h,0d1h	;illegal sequence
	jr nc,l7dcdh
	jr nz,l7df6h
	ld b,l	
	ld c,h	
l7d9fh:
	ld c,h	
	jr nz,l7df1h
	ld b,(hl)	
	jr nz,l7df5h
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	jr z,$+82
	ld d,l	
	ld c,(hl)	
	ld b,e	
	ld c,b	
	ld b,l	
	ld d,e	
	inc l	
	ld c,e	
	ld c,c	
	ld b,e	
	ld c,e	
	ld d,e	
	add hl,hl	
	defb 0fdh,010h,0d2h	;illegal sequence
	jr nc,l7df1h
	jr nz,$+73
l7dc0h:
	ld d,d	
	ld c,a	
	ld b,c	
	ld c,(hl)	
	jr nz,l7e15h
	ld b,(hl)	
	jr nz,$+82
	ld c,h	
	ld b,c	
	ld e,c	
l7dcch:
	ld b,l	
l7dcdh:
	ld d,d	
	jr nz,$+81
	ld d,d	
	jr nz,l7e18h
	ld c,(hl)	
	ld b,l	
	ld c,l	
	ld e,c	
	defb 0fdh,050h,0d2h	;illegal sequence
	jr nc,$+54
	jr nz,l7e2ah
	ld b,c	
	ld d,l	
	ld b,a	
	ld c,b	
	ld c,c	
	ld c,(hl)	
	ld b,a	
l7de5h:
	jr nz,l7e3dh
	ld c,a	
	ld c,c	
	ld b,e	
	ld b,l	
	jr nz,l7e3ch
	ld b,(hl)	
	jr nz,l7e35h
	ld c,(hl)	
l7df1h:
	ld b,l	
	ld c,l	
	ld c,c	
	ld b,l	
l7df5h:
	ld d,e	
l7df6h:
	dec l	
	ld sp,090fdh
	jp nc,03530h
	jr nz,l7e4bh
sub_7dffh:
	ld b,c	
	ld d,l	
	ld b,a	
	ld c,b	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,l7e5eh
	ld c,a	
	ld c,c	
	ld b,e	
	ld b,l	
	jr nz,$+81
	ld b,(hl)	
	jr nz,$+71
	ld c,(hl)	
	ld b,l	
	ld c,l	
	ld c,c	
l7e15h:
	ld b,l	
	ld d,e	
	dec l	
l7e18h:
	ld (0d0fdh),a
	jp nc,03630h
	jr nz,l7e62h
	ld d,l	
	ld d,d	
	ld d,e	
	ld d,h	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,l7e78h
	ld b,(hl)	
l7e2ah:
	jr nz,$+82
	ld b,c	
	ld d,b	
	ld b,l	
	ld d,d	
	jr nz,l7e74h
	ld b,c	
	ld c,h	
	ld c,h	
l7e35h:
	defb 0fdh,013h,0d3h	;illegal sequence
	ld b,d	
	ld d,l	
	ld d,d	
	ld d,e	
l7e3ch:
	ld d,h	
l7e3dh:
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,$+81
	ld b,(hl)	
	jr nz,l7e89h
	ld d,d	
	ld b,c	
	ld b,a	
	ld c,a	
	ld c,(hl)	
	daa	
l7e4bh:
	ld d,e	
	jr nz,l7e93h
	ld b,a	
	ld b,a	
	defb 0fdh,050h,0d3h	;illegal sequence
	jr nc,l7e8ch
	jr nz,l7eaah
	ld c,b	
	ld d,d	
	ld c,c	
	ld b,l	
	ld c,e	
	jr nz,l7eadh
l7e5eh:
	ld b,(hl)	
	jr nz,l7eb1h
	ld c,h	
l7e62h:
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	defb 0fdh,090h,0d3h	;illegal sequence
	jr nc,$+58
	jr nz,$+82
	ld c,h	
	ld b,c	
	ld e,c	
	ld b,l	
	ld d,d	
	jr nz,l7ec6h
l7e74h:
	ld d,l	
	ld c,(hl)	
	ld c,(hl)	
	ld c,c	
l7e78h:
	ld c,(hl)	
	ld b,a	
	defb 0fdh,0d0h,0d3h	;illegal sequence
	jr nc,l7eb8h
	jr nz,$+74
	ld c,c	
	ld d,h	
	ld d,h	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,l7edch
l7e89h:
	ld c,a	
	ld d,l	
	ld c,(hl)	
l7e8ch:
	ld b,h	
	defb 0fdh,010h,0d4h	;illegal sequence
	ld sp,02030h
l7e93h:
	ld d,e	
	ld d,a	
	ld c,c	
	ld d,e	
	ld c,b	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,$+85
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld b,h	
	defb 0fdh,050h,0d4h	;illegal sequence
	ld sp,02031h
	ld b,d	
	ld d,l	
	ld d,d	
l7eaah:
	ld d,e	
	ld d,h	
	ld c,c	
l7eadh:
	ld c,(hl)	
	ld b,a	
	jr nz,l7f00h
l7eb1h:
	ld b,(hl)	
	jr nz,$+85
	ld c,(hl)	
	ld b,c	
	ld c,e	
	ld b,l	
l7eb8h:
	jr nz,l7f0ah
	ld c,a	
	ld d,h	
	defb 0fdh,090h,0d4h	;illegal sequence
	ld sp,02032h
	ld b,d	
	ld c,c	
	ld d,h	
	ld c,c	
l7ec6h:
	ld c,(hl)	
	ld b,a	
	jr nz,$+85
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld b,h	
	defb 0fdh,0d0h,0d4h	;illegal sequence
	ld sp,02033h
	ld d,e	
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld b,h	
	jr nz,l7f2ah
	ld b,(hl)	
l7edch:
	jr nz,l7f29h
	ld c,(hl)	
	ld c,c	
	ld d,(hl)	
	ld b,l	
	ld d,e	
	inc l	
	ld b,d	
	ld c,a	
	ld c,a	
	ld c,l	
	ld b,l	
	ld d,d	
	ld b,c	
	ld c,(hl)	
	ld b,a	
	ld d,e	
	defb 0fdh,010h,0d5h	;illegal sequence
	ld sp,02034h
	ld b,e	
	ld c,a	
	ld d,l	
	ld c,(hl)	
	ld d,h	
	ld c,c	
	ld c,(hl)	
	ld b,a	
	jr nz,l7f4eh
	ld c,a	
	ld c,c	
l7f00h:
	ld c,(hl)	
sub_7f01h:
	ld d,h	
	ld d,e	
	defb 0fdh,050h,0d5h	;illegal sequence
	ld sp,02035h
	ld b,a	
l7f0ah:
	ld b,c	
	ld c,l	
	ld b,l	
	jr nz,l7f62h
	ld d,h	
	ld b,c	
	ld d,d	
	ld d,h	
	defb 0fdh,090h,0d5h	;illegal sequence
	ld sp,02036h
	ld b,d	
	ld b,a	
	ld c,l	
	defb 0fdh,0d0h,0d5h	;illegal sequence
	ld sp,02037h
	ld b,e	
	ld c,a	
	ld c,l	
	ld d,b	
	ld c,h	
	ld b,l	
	ld d,h	
l7f29h:
	ld c,c	
l7f2ah:
	ld c,a	
	ld c,(hl)	
	jr nz,$+81
	ld b,(hl)	
	jr nz,l7f76h
	ld b,c	
	ld b,e	
	ld c,b	
	jr nz,l7f86h
	ld b,c	
	ld d,h	
	ld d,h	
	ld b,l	
	ld d,d	
	ld c,(hl)	
	defb 0fdh,010h,0d6h	;illegal sequence
	ld sp,02038h
	ld b,e	
	ld c,a	
	ld c,l	
	ld d,b	
	ld c,h	
	ld b,l	
	ld d,h	
	ld c,c	
	ld c,a	
	ld c,(hl)	
	jr nz,l7f9dh
l7f4eh:
	ld b,(hl)	
	jr nz,l7f98h
	ld b,c	
	ld c,l	
	ld b,l	
	defb 0fdh,050h,0d6h	;illegal sequence
	ld sp,02039h
	ld b,a	
	ld b,c	
	ld c,l	
	ld b,l	
	jr nz,l7fafh
	ld d,(hl)	
	ld b,l	
l7f62h:
	ld d,d	
	defb 0fdh,090h,0d6h	;illegal sequence
	ld (02030h),a
	ld d,h	
	ld c,c	
	ld c,l	
	ld b,l	
	jr nz,l7fc4h
	ld d,b	
	jr nz,l7fc9h
	ld b,c	
	ld d,d	
	ld c,(hl)	
	ld c,c	
l7f76h:
	ld c,(hl)	
	ld b,a	
	defb 0fdh,0d0h,0d6h	;illegal sequence
	ld (02031h),a
	ld b,c	
	ld b,h	
	ld b,h	
	ld c,c	
	ld d,h	
	ld c,c	
	ld c,a	
	ld c,(hl)	
l7f86h:
	ld b,c	
	ld c,h	
	jr nz,l7fd0h
	ld c,c	
	ld b,a	
	ld c,b	
	ld d,h	
	ld b,l	
	ld d,d	
	defb 0fdh,016h,0d7h	;illegal sequence
	ld c,l	
	ld d,l	
	ld d,e	
	ld c,c	
	ld b,e	
l7f98h:
	jr nz,l7fdfh
	ld c,(hl)	
	ld b,h	
	rst 38h	
l7f9dh:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l7fafh:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l7fc4h:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l7fc9h:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l7fd0h:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
l7fdfh:
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
	rst 0	
