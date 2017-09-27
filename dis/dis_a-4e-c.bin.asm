; z80dasm 1.1.4
; command line: z80dasm -g0 -l -t roms/a-4e-c.bin

; Check:
; $ z80asm dis/dis_a-4e-c.bin.asm && shasum a.bin 
; 17e2cfe2b9d6121239803aba7132918e54ae02bf  a.bin

; Examples of macros
makelabel: macro name
	label_name:
endm

callf: macro slot address
	rst 0x30 db slot dw address
endm

;DSW2: 004h

	org	00000h


	; ROM START
	; Disable interrupts
	; Interrupt mode 1: interrupt handler at address 038h
	di
	im 1

	; Stack at 0f00h
	ld sp,0f000h		;0003

	; Move 0fffh (4095) bytes from 0e000h to 0e001h
	; Pad (0e000h) = 0
	; This simply moves a memory region just before the stack one byte to
	; the right (?)
	ld hl,0e000h
	ld de,0e001h
	ld bc,00fffh
	ld (hl),000h
	ldir

l0013h:
	ld hl,0eb25h		;0013	21 25 eb 	! % . 
l0016h:
	ld (0eb03h),hl		;0016	22 03 eb 	" . . 
	in a,(004h)		;0019	db 04 	. . 
l001bh:
	bit 7,a		;001b	cb 7f 	.  
l001dh:
	jp z,07666h		;001d	ca 66 76 	. f v 
l0020h:
	call sub_058fh		;0020	cd 8f 05 	. . . 
l0023h:
	ld hl,l05cch		;0023	21 cc 05 	! . . 
	ld de,0ea06h		;0026	11 06 ea 	. . . 
l0029h:
	ld bc,l0078h		;0029	01 78 00 	. x . 
	ldir		;002c	ed b0 	. . 
	defb 02ah, 03fh, 006h
	ld a,l			;0031	7d 	} 
	ld l,h			;0032	6c 	l 
	ld h,a			;0033	67 	g 
	jr l0082h		;0034	18 4c 	. L 
l0036h:
	rst 0			;0036	c7 	. 
	rst 0			;0037	c7 	. 
	ex af,af'			;0038	08 	. 
l0039h:
	exx			;0039	d9 	. 
	ld hl,(0eb03h)		;003a	2a 03 eb 	* . . 
	ld de,0c020h		;003d	11 20 c0 	.   . 
l0040h:
	ld bc,l00c0h		;0040	01 c0 00 	. . . 
	ldir		;0043	ed b0 	. . 
	ld a,(0e902h)		;0045	3a 02 e9 	: . . 
	ld (0a000h),a		;0048	32 00 a0 	2 . . 
	ld a,(0e903h)		;004b	3a 03 e9 	: . . 
	ld (0b000h),a		;004e	32 00 b0 	2 . . 
	push iy		;0051	fd e5 	. . 
	push ix		;0053	dd e5 	. . 
l0055h:
	jp l008dh		;0055	c3 8d 00 	. . . 
	rst 0			;0058	c7 	. 
	rst 0			;0059	c7 	. 
l005ah:
	rst 0			;005a	c7 	. 
l005bh:
	rst 0			;005b	c7 	. 
	rst 0			;005c	c7 	. 
	rst 0			;005d	c7 	. 
	rst 0			;005e	c7 	. 
	rst 0			;005f	c7 	. 
l0060h:
	rst 0			;0060	c7 	. 
	rst 0			;0061	c7 	. 
	rst 0			;0062	c7 	. 
	rst 0			;0063	c7 	. 
	rst 0			;0064	c7 	. 
	rst 0			;0065	c7 	. 
	retn		;0066	ed 45 	. E 
	ld h,e			;0068	63 	c 
	xor l			;0069	ad 	. 
	sbc a,h			;006a	9c 	. 
	ld d,d			;006b	52 	R 
	ld (hl),d			;006c	72 	r 
	rst 8			;006d	cf 	. 
l006eh:
	add a,a			;006e	87 	. 
	ld b,c			;006f	41 	A 
	ld d,h			;0070	54 	T 
	scf			;0071	37 	7 
l0072h:
	and a			;0072	a7 	. 
	ld b,e			;0073	43 	C 
	sub c			;0074	91 	. 
	ld d,c			;0075	51 	Q 
	and a			;0076	a7 	. 
	ld b,e			;0077	43 	C 
l0078h:
	sub c			;0078	91 	. 
	ld d,c			;0079	51 	Q 
	sbc a,a			;007a	9f 	. 
	cp b			;007b	b8 	. 
	push hl			;007c	e5 	. 
l007dh:
	sub 085h		;007d	d6 85 	. . 
	ld d,(hl)			;007f	56 	V 
l0080h:
	dec (hl)			;0080	35 	5 
	inc hl			;0081	23 	# 
l0082h:
	ld (0e980h),hl		;0082	22 80 e9 	" . . 
	ld hl,0e917h		;0085	21 17 e9 	! . . 
	inc (hl)			;0088	34 	4 
	ei			;0089	fb 	. 
	jp 0487eh		;008a	c3 7e 48 	. ~ H 
l008dh:
	ld a,(0e000h)		;008d	3a 00 e0 	: . . 
	and a			;0090	a7 	. 
	jp m,l01f8h		;0091	fa f8 01 	. . . 
	in a,(004h)		;0094	db 04 	. . 
	bit 4,a		;0096	cb 67 	. g 
	jr nz,l00b7h		;0098	20 1d 	  . 
	ld hl,0e005h		;009a	21 05 e0 	! . . 
	bit 7,(hl)		;009d	cb 7e 	. ~ 
	jr nz,l00b7h		;009f	20 16 	  . 
	bit 0,(hl)		;00a1	cb 46 	. F 
	in a,(000h)		;00a3	db 00 	. . 
	jr nz,l00b0h		;00a5	20 09 	  . 
	and 002h		;00a7	e6 02 	. . 
	jr nz,l00b7h		;00a9	20 0c 	  . 
	set 0,(hl)		;00ab	cb c6 	. . 
	jp l01f0h		;00ad	c3 f0 01 	. . . 
l00b0h:
	and 001h		;00b0	e6 01 	. . 
	jp nz,l01f0h		;00b2	c2 f0 01 	. . . 
	res 0,(hl)		;00b5	cb 86 	. . 
l00b7h:
	in a,(004h)		;00b7	db 04 	. . 
	bit 3,a		;00b9	cb 5f 	. _ 
	jr nz,l00cdh		;00bb	20 10 	  . 
	ld hl,0e904h		;00bd	21 04 e9 	! . . 
l00c0h:
	bit 1,(hl)		;00c0	cb 4e 	. N 
	jr z,l00cdh		;00c2	28 09 	( . 
	ld hl,0e80eh		;00c4	21 0e e8 	! . . 
	dec (hl)			;00c7	35 	5 
	jp p,l01f0h		;00c8	f2 f0 01 	. . . 
	ld (hl),008h		;00cb	36 08 	6 . 
l00cdh:
	ld a,(0e000h)		;00cd	3a 00 e0 	: . . 
	cp 006h		;00d0	fe 06 	. . 
l00d2h:
	ld a,047h		;00d2	3e 47 	> G 
	jr z,l00d8h		;00d4	28 02 	( . 
	ld a,r		;00d6	ed 5f 	. _ 
l00d8h:
	ld hl,0e010h		;00d8	21 10 e0 	! . . 
	add a,(hl)			;00db	86 	. 
l00dch:
	ld (hl),a			;00dc	77 	w 
	inc hl			;00dd	23 	# 
l00deh:
	add a,(hl)			;00de	86 	. 
	ld (hl),a			;00df	77 	w 
l00e0h:
	ld hl,0e014h		;00e0	21 14 e0 	! . . 
	inc (hl)			;00e3	34 	4 
	ld a,(hl)			;00e4	7e 	~ 
	and 003h		;00e5	e6 03 	. . 
	ld d,000h		;00e7	16 00 	. . 
	ld e,a			;00e9	5f 	_ 
	ld a,(0e000h)		;00ea	3a 00 e0 	: . . 
	ld hl,l007dh+1		;00ed	21 7e 00 	! ~ . 
	cp 006h		;00f0	fe 06 	. . 
	jr z,l0107h		;00f2	28 13 	( . 
	ld hl,l006eh		;00f4	21 6e 00 	! n . 
	ld a,(0e080h)		;00f7	3a 80 e0 	: . . 
	and 038h		;00fa	e6 38 	. 8 
	cp 020h		;00fc	fe 20 	.   
	jr c,l0102h		;00fe	38 02 	8 . 
l0100h:
	ld a,018h		;0100	3e 18 	> . 
l0102h:
	rrca			;0102	0f 	. 
	ld c,a			;0103	4f 	O 
	ld b,000h		;0104	06 00 	. . 
	add hl,bc			;0106	09 	. 
l0107h:
	add hl,de			;0107	19 	. 
	ld a,(hl)			;0108	7e 	~ 
	ld hl,0e015h		;0109	21 15 e0 	! . . 
l010ch:
	add a,(hl)			;010c	86 	. 
	ld (hl),a			;010d	77 	w 
	inc hl			;010e	23 	# 
	add a,(hl)			;010f	86 	. 
l0110h:
	ld (hl),a			;0110	77 	w 
	inc hl			;0111	23 	# 
	add a,(hl)			;0112	86 	. 
	ld (hl),a			;0113	77 	w 
	call sub_0d05h		;0114	cd 05 0d 	. . . 
	call sub_0d48h		;0117	cd 48 0d 	. H . 
l011ah:
	call 0482fh		;011a	cd 2f 48 	. / H 
	call sub_0de5h		;011d	cd e5 0d 	. . . 
l0120h:
	ld a,(0e001h)		;0120	3a 01 e0 	: . . 
	and a			;0123	a7 	. 
	jr nz,l012dh		;0124	20 07 	  . 
	ld a,(0e913h)		;0126	3a 13 e9 	: . . 
	and a			;0129	a7 	. 
	jp nz,l0217h		;012a	c2 17 02 	. . . 
l012dh:
	call sub_03f8h		;012d	cd f8 03 	. . . 
	ld a,(0e000h)		;0130	3a 00 e0 	: . . 
	cp 00bh		;0133	fe 0b 	. . 
	jp nc,l01ddh		;0135	d2 dd 01 	. . . 
	ld a,018h		;0138	3e 18 	> . 
	ld (0eb00h),a		;013a	32 00 eb 	2 . . 
	ld hl,0eb25h		;013d	21 25 eb 	! % . 
l0140h:
	ld (0eb03h),hl		;0140	22 03 eb 	" . . 
l0143h:
	ld (0eb01h),hl		;0143	22 01 eb 	" . . 
	ld a,(0e000h)		;0146	3a 00 e0 	: . . 
	add a,a			;0149	87 	. 
	ld e,a			;014a	5f 	_ 
l014bh:
	ld d,000h		;014b	16 00 	. . 
	ld hl,l0156h		;014d	21 56 01 	! V . 
	add hl,de			;0150	19 	. 
	ld e,(hl)			;0151	5e 	^ 
l0152h:
	inc hl			;0152	23 	# 
	ld d,(hl)			;0153	56 	V 
	ex de,hl			;0154	eb 	. 
	jp (hl)			;0155	e9 	. 
l0156h:
	call nz,0c401h		;0156	c4 01 c4 	. . . 
	ld bc,l01beh		;0159	01 be 01 	. . . 
	ld l,b			;015c	68 	h 
	ld bc,l0168h		;015d	01 68 01 	. h . 
	or h			;0160	b4 	. 
	ld bc,l0168h		;0161	01 68 01 	. h . 
	cp c			;0164	b9 	. 
	ld bc,l01beh		;0165	01 be 01 	. . . 
l0168h:
	call 0413fh		;0168	cd 3f 41 	. ? A 
	call 0402ch		;016b	cd 2c 40 	. , @ 
	ld a,(0e080h)		;016e	3a 80 e0 	: . . 
	and 007h		;0171	e6 07 	. . 
	cp 004h		;0173	fe 04 	. . 
	jr z,l017fh		;0175	28 08 	( . 
	call 040e5h		;0177	cd e5 40 	. . @ 
	call sub_1cb3h		;017a	cd b3 1c 	. . . 
	jr l0185h		;017d	18 06 	. . 
l017fh:
	call sub_1cb3h		;017f	cd b3 1c 	. . . 
	call 040e5h		;0182	cd e5 40 	. . @ 
l0185h:
	call 047b6h		;0185	cd b6 47 	. . G 
	ld a,(0e100h)		;0188	3a 00 e1 	: . . 
l018bh:
	and a			;018b	a7 	. 
	jr z,l019ch		;018c	28 0e 	( . 
	cp 00ah		;018e	fe 0a 	. . 
	jr c,l0197h		;0190	38 05 	8 . 
	call sub_37deh		;0192	cd de 37 	. . 7 
	jr l019fh		;0195	18 08 	. . 
l0197h:
	call sub_3595h		;0197	cd 95 35 	. . 5 
	jr l019fh		;019a	18 03 	. . 
l019ch:
	call sub_12ach		;019c	cd ac 12 	. . . 
l019fh:
	call sub_2fc7h		;019f	cd c7 2f 	. . / 
	ld a,(0e33fh)		;01a2	3a 3f e3 	: ? . 
	and a			;01a5	a7 	. 
	call nz,sub_2ec1h		;01a6	c4 c1 2e 	. . . 
	call sub_39c0h		;01a9	cd c0 39 	. . 9 
	call 02d72h		;01ac	cd 72 2d 	. r - 
	call sub_2f06h		;01af	cd 06 2f 	. . / 
	jr l01c4h		;01b2	18 10 	. . 
	call 04d24h		;01b4	cd 24 4d 	. $ M 
	jr l01c4h		;01b7	18 0b 	. . 
	call 05436h		;01b9	cd 36 54 	. 6 T 
	jr l01c4h		;01bc	18 06 	. . 
l01beh:
	call 04000h		;01be	cd 00 40 	. . @ 
	call 040e5h		;01c1	cd e5 40 	. . @ 
l01c4h:
	ld a,(0eb00h)		;01c4	3a 00 eb 	: . . 
	and a			;01c7	a7 	. 
	jr z,l01ddh		;01c8	28 13 	( . 
	ld b,a			;01ca	47 	G 
	ld iy,(0eb01h)		;01cb	fd 2a 01 eb 	. * . . 
	xor a			;01cf	af 	. 
	ld de,0006h+2		;01d0	11 08 00 	. . . 
l01d3h:
	ld (iy+004h),a		;01d3	fd 77 04 	. w . 
	ld (iy+005h),a		;01d6	fd 77 05 	. w . 
	add iy,de		;01d9	fd 19 	. . 
	djnz l01d3h		;01db	10 f6 	. . 
l01ddh:
	ld a,(0e000h)		;01dd	3a 00 e0 	: . . 
l01e0h:
	cp 006h		;01e0	fe 06 	. . 
	ld a,037h		;01e2	3e 37 	> 7 
	jr z,l01e8h		;01e4	28 02 	( . 
	ld a,r		;01e6	ed 5f 	. _ 
l01e8h:
	ld hl,0e012h		;01e8	21 12 e0 	! . . 
	add a,(hl)			;01eb	86 	. 
	ld (hl),a			;01ec	77 	w 
	inc hl			;01ed	23 	# 
	add a,(hl)			;01ee	86 	. 
	ld (hl),a			;01ef	77 	w 
l01f0h:
	pop ix		;01f0	dd e1 	. . 
	pop iy		;01f2	fd e1 	. . 
	exx			;01f4	d9 	. 
	ex af,af'			;01f5	08 	. 
	ei			;01f6	fb 	. 
	ret			;01f7	c9 	. 
l01f8h:
	push af			;01f8	f5 	. 
	ld a,018h		;01f9	3e 18 	> . 
	ld (0eb00h),a		;01fb	32 00 eb 	2 . . 
	ld hl,0eb25h		;01fe	21 25 eb 	! % . 
	ld (0eb03h),hl		;0201	22 03 eb 	" . . 
	ld (0eb01h),hl		;0204	22 01 eb 	" . . 
	pop af			;0207	f1 	. 
	inc a			;0208	3c 	< 
	call nz,07aaeh		;0209	c4 ae 7a 	. . z 
	call sub_03f8h		;020c	cd f8 03 	. . . 
	call sub_0d05h		;020f	cd 05 0d 	. . . 
	call sub_0de5h		;0212	cd e5 0d 	. . . 
	jr l01c4h		;0215	18 ad 	. . 
l0217h:
	ld sp,0f000h		;0217	31 00 f0 	1 . . 
	ld a,001h		;021a	3e 01 	> . 
	ld (0e001h),a		;021c	32 01 e0 	2 . . 
	xor a			;021f	af 	. 
l0220h:
	ld (0e000h),a		;0220	32 00 e0 	2 . . 
	ei			;0223	fb 	. 
	call 05178h		;0224	cd 78 51 	. x Q 
	ld a,0ffh		;0227	3e ff 	> . 
	ld (0e006h),a		;0229	32 06 e0 	2 . . 
	ld hl,0e080h		;022c	21 80 e0 	! . . 
	ld de,0e081h		;022f	11 81 e0 	. . . 
	ld bc,l001dh+2		;0232	01 1f 00 	. . . 
	ld (hl),000h		;0235	36 00 	6 . 
	ldir		;0237	ed b0 	. . 
	in a,(003h)		;0239	db 03 	. . 
	and 001h		;023b	e6 01 	. . 
	jr nz,l0247h		;023d	20 08 	  . 
	ld a,008h		;023f	3e 08 	> . 
	ld (0e080h),a		;0241	32 80 e0 	2 . . 
	ld (0e090h),a		;0244	32 90 e0 	2 . . 
l0247h:
	call sub_056fh		;0247	cd 6f 05 	. o . 
	ld (0e084h),a		;024a	32 84 e0 	2 . . 
	ld (0e094h),a		;024d	32 94 e0 	2 . . 
sub_0250h:
	ld hl,0e005h		;0250	21 05 e0 	! . . 
	res 7,(hl)		;0253	cb be 	. . 
	xor a			;0255	af 	. 
	ld (0e000h),a		;0256	32 00 e0 	2 . . 
	in a,(004h)		;0259	db 04 	. . 
	and 002h		;025b	e6 02 	. . 
	ld hl,0e910h		;025d	21 10 e9 	! . . 
	jr z,l026dh		;0260	28 0b 	( . 
	ld a,(0e002h)		;0262	3a 02 e0 	: . . 
	and 001h		;0265	e6 01 	. . 
	jr z,l026dh		;0267	28 04 	( . 
	set 0,(hl)		;0269	cb c6 	. . 
	jr l026fh		;026b	18 02 	. . 
l026dh:
	res 0,(hl)		;026d	cb 86 	. . 
l026fh:
	ld hl,0e085h		;026f	21 85 e0 	! . . 
	bit 1,(hl)		;0272	cb 4e 	. N 
	jr nz,l0285h		;0274	20 0f 	  . 
	set 1,(hl)		;0276	cb ce 	. . 
	call 0520dh		;0278	cd 0d 52 	. . R 
	ld a,0e1h		;027b	3e e1 	> . 
	call 0570fh		;027d	cd 0f 57 	. . W 
l0280h:
	ld a,070h		;0280	3e 70 	> p 
	call 0570fh		;0282	cd 0f 57 	. . W 
l0285h:
	call sub_1157h		;0285	cd 57 11 	. W . 
	xor a			;0288	af 	. 
	ld (0e007h),a		;0289	32 07 e0 	2 . . 
	ld (0e008h),a		;028c	32 08 e0 	2 . . 
	call sub_0449h		;028f	cd 49 04 	. I . 
	ld a,004h		;0292	3e 04 	> . 
	ld (0e000h),a		;0294	32 00 e0 	2 . . 
	ld a,024h		;0297	3e 24 	> $ 
	call sub_0dfeh		;0299	cd fe 0d 	. . . 
l029ch:
	in a,(004h)		;029c	db 04 	. . 
	bit 4,a		;029e	cb 67 	. g 
l02a0h:
	jr z,l02aeh		;02a0	28 0c 	( . 
	bit 5,a		;02a2	cb 6f 	. o 
	jr nz,l02aeh		;02a4	20 08 	  . 
	ld hl,0e904h		;02a6	21 04 e9 	! . . 
	bit 0,(hl)		;02a9	cb 46 	. F 
	jp nz,l039ch		;02ab	c2 9c 03 	. . . 
l02aeh:
	ld a,(0e000h)		;02ae	3a 00 e0 	: . . 
	cp 00bh		;02b1	fe 0b 	. . 
	jp z,l033ah		;02b3	ca 3a 03 	. : . 
	cp 00ch		;02b6	fe 0c 	. . 
	jp z,l02c0h		;02b8	ca c0 02 	. . . 
	call sub_0fb8h		;02bb	cd b8 0f 	. . . 
	jr l029ch		;02be	18 dc 	. . 
l02c0h:
	ld a,000h		;02c0	3e 00 	> . 
	call sub_0dfeh		;02c2	cd fe 0d 	. . . 
	ld a,022h		;02c5	3e 22 	> " 
	call sub_0dfeh		;02c7	cd fe 0d 	. . . 
	ld a,0e1h		;02ca	3e e1 	> . 
	call sub_0582h		;02cc	cd 82 05 	. . . 
	ld a,038h		;02cf	3e 38 	> 8 
	call sub_0582h		;02d1	cd 82 05 	. . . 
l02d4h:
	ld a,001h		;02d4	3e 01 	> . 
	call sub_0582h		;02d6	cd 82 05 	. . . 
	ld hl,0e709h		;02d9	21 09 e7 	! . . 
	ld a,(hl)			;02dc	7e 	~ 
	and a			;02dd	a7 	. 
	jp m,l02eah		;02de	fa ea 02 	. . . 
	dec (hl)			;02e1	35 	5 
	call sub_2f97h		;02e2	cd 97 2f 	. . / 
	call sub_055fh		;02e5	cd 5f 05 	. _ . 
	jr l02d4h		;02e8	18 ea 	. . 
l02eah:
	ld de,0			;02ea	11 00 00 	. . . 
	push de			;02ed	d5 	. 
l02eeh:
	ld a,003h		;02ee	3e 03 	> . 
	call sub_0582h		;02f0	cd 82 05 	. . . 
	pop de			;02f3	d1 	. 
	ld hl,(0e003h)		;02f4	2a 03 e0 	* . . 
	ld a,l			;02f7	7d 	} 
	or h			;02f8	b4 	. 
	jr z,l031dh		;02f9	28 22 	( " 
	ld a,e			;02fb	7b 	{ 
	add a,001h		;02fc	c6 01 	. . 
	daa			;02fe	27 	' 
	ld e,a			;02ff	5f 	_ 
l0300h:
	sbc hl,de		;0300	ed 52 	. R 
	add hl,de			;0302	19 	. 
	jr nc,l0307h		;0303	30 02 	0 . 
	ld e,l			;0305	5d 	] 
	ld d,h			;0306	54 	T 
l0307h:
	ld a,l			;0307	7d 	} 
	sub e			;0308	93 	. 
	daa			;0309	27 	' 
	ld l,a			;030a	6f 	o 
	ld a,h			;030b	7c 	| 
	sbc a,d			;030c	9a 	. 
	daa			;030d	27 	' 
	ld h,a			;030e	67 	g 
	ld (0e003h),hl		;030f	22 03 e0 	" . . 
	push de			;0312	d5 	. 
	call sub_2f9ah		;0313	cd 9a 2f 	. . / 
	ld a,016h		;0316	3e 16 	> . 
	call sub_0dfeh		;0318	cd fe 0d 	. . . 
	jr l02eeh		;031b	18 d1 	. . 
l031dh:
	ld a,038h		;031d	3e 38 	> 8 
	call sub_0582h		;031f	cd 82 05 	. . . 
	ld a,(0e080h)		;0322	3a 80 e0 	: . . 
	and 001h		;0325	e6 01 	. . 
	call nz,053c2h		;0327	c4 c2 53 	. . S 
	ld a,(0e080h)		;032a	3a 80 e0 	: . . 
	and 007h		;032d	e6 07 	. . 
	cp 004h		;032f	fe 04 	. . 
	call z,04fe9h		;0331	cc e9 4f 	. . O 
	call sub_0432h		;0334	cd 32 04 	. 2 . 
	call sub_0250h		;0337	cd 50 02 	. P . 
l033ah:
	ld a,02dh		;033a	3e 2d 	> - 
	call 0570fh		;033c	cd 0f 57 	. . W 
	ld hl,(0e003h)		;033f	2a 03 e0 	* . . 
	ld a,l			;0342	7d 	} 
	or h			;0343	b4 	. 
	call z,056b5h		;0344	cc b5 56 	. . V 
	ld hl,0e084h		;0347	21 84 e0 	! . . 
	dec (hl)			;034a	35 	5 
	jr z,l035dh		;034b	28 10 	( . 
	ld a,(0e007h)		;034d	3a 07 e0 	: . . 
	and a			;0350	a7 	. 
	jr z,l0360h		;0351	28 0d 	( . 
	call sub_0dfeh		;0353	cd fe 0d 	. . . 
	ld a,0a9h		;0356	3e a9 	> . 
	call 0570fh		;0358	cd 0f 57 	. . W 
	jr l0360h		;035b	18 03 	. . 
l035dh:
	call 054f4h		;035d	cd f4 54 	. . T 
l0360h:
	ld hl,0e002h		;0360	21 02 e0 	! . . 
	bit 1,(hl)		;0363	cb 4e 	. N 
	jr z,l0382h		;0365	28 1b 	( . 
	ld a,(0e094h)		;0367	3a 94 e0 	: . . 
	and a			;036a	a7 	. 
	jr z,l0382h		;036b	28 15 	( . 
	ld a,(hl)			;036d	7e 	~ 
	xor 001h		;036e	ee 01 	. . 
	ld (hl),a			;0370	77 	w 
l0371h:
	ld b,010h		;0371	06 10 	. . 
	ld hl,0e080h		;0373	21 80 e0 	! . . 
	ld de,0e090h		;0376	11 90 e0 	. . . 
l0379h:
	ld c,(hl)			;0379	4e 	N 
	ld a,(de)			;037a	1a 	. 
	ex de,hl			;037b	eb 	. 
	ld (hl),c			;037c	71 	q 
	ld (de),a			;037d	12 	. 
	inc hl			;037e	23 	# 
	inc de			;037f	13 	. 
	djnz l0379h		;0380	10 f7 	. . 
l0382h:
	ld a,(0e084h)		;0382	3a 84 e0 	: . . 
	and a			;0385	a7 	. 
	jp nz,sub_0250h		;0386	c2 50 02 	. P . 
	ld hl,0e910h		;0389	21 10 e9 	! . . 
	res 0,(hl)		;038c	cb 86 	. . 
	xor a			;038e	af 	. 
	ld (0e006h),a		;038f	32 06 e0 	2 . . 
	ld a,(0e913h)		;0392	3a 13 e9 	: . . 
	and a			;0395	a7 	. 
	jp nz,l0217h		;0396	c2 17 02 	. . . 
	jp 0487eh		;0399	c3 7e 48 	. ~ H 
l039ch:
	ld hl,0e005h		;039c	21 05 e0 	! . . 
	set 7,(hl)		;039f	cb fe 	. . 
	ld a,000h		;03a1	3e 00 	> . 
	call sub_0dfeh		;03a3	cd fe 0d 	. . . 
	xor a			;03a6	af 	. 
	ld (0e000h),a		;03a7	32 00 e0 	2 . . 
	call sub_1157h		;03aa	cd 57 11 	. W . 
	ld hl,0				;03ad	21 00 00 	! . . 
	ld (0e902h),hl		;03b0	22 02 e9 	" . . 
	call 0570dh		;03b3	cd 0d 57 	. . W 
	ld hl,0595bh		;03b6	21 5b 59 	! [ Y 
	call sub_111ch		;03b9	cd 1c 11 	. . . 
l03bch:
	ld c,014h		;03bc	0e 14 	. . 
	ld de,0d3a7h		;03be	11 a7 d3 	. . . 
	ld a,(0e080h)		;03c1	3a 80 e0 	: . . 
	and 0f8h		;03c4	e6 f8 	. . 
	rrca			;03c6	0f 	. 
	rrca			;03c7	0f 	. 
	rrca			;03c8	0f 	. 
	call sub_055bh		;03c9	cd 5b 05 	. [ . 
	ld de,0d427h		;03cc	11 27 d4 	. ' . 
	call sub_0556h		;03cf	cd 56 05 	. V . 
l03d2h:
	ld a,(0e906h)		;03d2	3a 06 e9 	: . . 
	and 0a0h		;03d5	e6 a0 	. . 
	jr nz,l03d2h		;03d7	20 f9 	  . 
l03d9h:
	ld hl,0e904h		;03d9	21 04 e9 	! . . 
	bit 1,(hl)		;03dc	cb 4e 	. N 
	jp nz,sub_0250h		;03de	c2 50 02 	. P . 
	ld hl,0e906h		;03e1	21 06 e9 	! . . 
	bit 7,(hl)		;03e4	cb 7e 	. ~ 
	jr nz,l03eeh		;03e6	20 06 	  . 
	bit 5,(hl)		;03e8	cb 6e 	. n 
	jr nz,l03f3h		;03ea	20 07 	  . 
	jr l03d9h		;03ec	18 eb 	. . 
l03eeh:
	call sub_041bh		;03ee	cd 1b 04 	. . . 
	jr l03bch		;03f1	18 c9 	. . 
l03f3h:
	call sub_0432h		;03f3	cd 32 04 	. 2 . 
	jr l03bch		;03f6	18 c4 	. . 
sub_03f8h:
	ld hl,0e880h		;03f8	21 80 e8 	! . . 
	dec (hl)			;03fb	35 	5 
	inc hl			;03fc	23 	# 
	ld a,(hl)			;03fd	7e 	~ 
	and a			;03fe	a7 	. 
	jr z,l0402h		;03ff	28 01 	( . 
	dec (hl)			;0401	35 	5 
l0402h:
	inc hl			;0402	23 	# 
	ld a,(hl)			;0403	7e 	~ 
	and a			;0404	a7 	. 
	jr z,l0408h		;0405	28 01 	( . 
	dec (hl)			;0407	35 	5 
l0408h:
	inc hl			;0408	23 	# 
	ld a,(hl)			;0409	7e 	~ 
	and a			;040a	a7 	. 
	jr z,l040eh		;040b	28 01 	( . 
	dec (hl)			;040d	35 	5 
l040eh:
	inc hl			;040e	23 	# 
	ld a,(hl)			;040f	7e 	~ 
	and a			;0410	a7 	. 
	jr z,l0414h		;0411	28 01 	( . 
	dec (hl)			;0413	35 	5 
l0414h:
	inc hl			;0414	23 	# 
	ld a,(hl)			;0415	7e 	~ 
	and a			;0416	a7 	. 
	jr z,l041ah		;0417	28 01 	( . 
	dec (hl)			;0419	35 	5 
l041ah:
	ret			;041a	c9 	. 
sub_041bh:
	ld hl,0e080h		;041b	21 80 e0 	! . . 
	dec (hl)			;041e	35 	5 
	ld a,(hl)			;041f	7e 	~ 
	and 007h		;0420	e6 07 	. . 
	cp 007h		;0422	fe 07 	. . 
	ret nz			;0424	c0 	. 
	ld a,(hl)			;0425	7e 	~ 
	and 0f8h		;0426	e6 f8 	. . 
	cp 0f8h		;0428	fe f8 	. . 
	jr nz,l042eh		;042a	20 02 	  . 
	ld a,028h		;042c	3e 28 	> ( 
l042eh:
	or 004h		;042e	f6 04 	. . 
	ld (hl),a			;0430	77 	w 
	ret			;0431	c9 	. 
sub_0432h:
	ld hl,0e080h		;0432	21 80 e0 	! . . 
	inc (hl)			;0435	34 	4 
	ld a,(hl)			;0436	7e 	~ 
	and 007h		;0437	e6 07 	. . 
	cp 005h		;0439	fe 05 	. . 
	ret nz			;043b	c0 	. 
	ld a,(hl)			;043c	7e 	~ 
	and 0f8h		;043d	e6 f8 	. . 
	add a,008h		;043f	c6 08 	. . 
	cp 030h		;0441	fe 30 	. 0 
	jr nz,l0447h		;0443	20 02 	  . 
	ld a,028h		;0445	3e 28 	> ( 
l0447h:
	ld (hl),a			;0447	77 	w 
	ret			;0448	c9 	. 
sub_0449h:
	ld (0e81ch),a		;0449	32 1c e8 	2 . . 
	ld a,001h		;044c	3e 01 	> . 
	ld (0e000h),a		;044e	32 00 e0 	2 . . 
	call sub_0644h		;0451	cd 44 06 	. D . 
	ld a,(0e080h)		;0454	3a 80 e0 	: . . 
	and 001h		;0457	e6 01 	. . 
	ld hl,l0020h+1		;0459	21 21 00 	! ! . 
	jr nz,l0461h		;045c	20 03 	  . 
	ld hl,0bfe0h		;045e	21 e0 bf 	! . . 
l0461h:
	push hl			;0461	e5 	. 
	ld (0e817h),hl		;0462	22 17 e8 	" . . 
	call sub_0e9bh		;0465	cd 9b 0e 	. . . 
	xor a			;0468	af 	. 
	ld (0e915h),a		;0469	32 15 e9 	2 . . 
	call 05756h		;046c	cd 56 57 	. V W 
	ld a,(0e81ch)		;046f	3a 1c e8 	: . . 
	and a			;0472	a7 	. 
	call z,sub_04e5h		;0473	cc e5 04 	. . . 
	ld a,002h		;0476	3e 02 	> . 
	ld (0e000h),a		;0478	32 00 e0 	2 . . 
	ld a,027h		;047b	3e 27 	> ' 
	call 0570fh		;047d	cd 0f 57 	. . W 
	ld hl,0006h+1		;0480	21 07 00 	! . . 
	ld (0e817h),hl		;0483	22 17 e8 	" . . 
	ld hl,0e915h		;0486	21 15 e9 	! . . 
	inc (hl)			;0489	34 	4 
	ld hl,05aa1h		;048a	21 a1 5a 	! . Z 
	call sub_04bfh		;048d	cd bf 04 	. . . 
	ld a,00bh		;0490	3e 0b 	> . 
	call 0570fh		;0492	cd 0f 57 	. . W 
	ld hl,0e915h		;0495	21 15 e9 	! . . 
	inc (hl)			;0498	34 	4 
	ld hl,05af0h		;0499	21 f0 5a 	! . Z 
	call sub_04bfh		;049c	cd bf 04 	. . . 
	ld a,(0e81ch)		;049f	3a 1c e8 	: . . 
	and a			;04a2	a7 	. 
	
	defb 021h, 03fh, 005h
	
	call z,sub_111ch		;04a6	cc 1c 11 	. . . 
	ld a,054h		;04a9	3e 54 	> T 
	call 0570fh		;04ab	cd 0f 57 	. . W 
	pop hl			;04ae	e1 	. 
	ld (0e817h),hl		;04af	22 17 e8 	" . . 
	call 05756h		;04b2	cd 56 57 	. V W 
	ld hl,0		;04b5	21 00 00 	! . . 
	ld (0e014h),hl		;04b8	22 14 e0 	" . . 
	ld (0e016h),hl		;04bb	22 16 e0 	" . . 
	ret			;04be	c9 	. 
sub_04bfh:
	ld a,(0e080h)		;04bf	3a 80 e0 	: . . 
	and 007h		;04c2	e6 07 	. . 
	ret z			;04c4	c8 	. 
	and 001h		;04c5	e6 01 	. . 
	jp z,sub_111ch		;04c7	ca 1c 11 	. . . 
	call 05756h		;04ca	cd 56 57 	. V W 
	ld a,(0e915h)		;04cd	3a 15 e9 	: . . 
	cp 002h		;04d0	fe 02 	. . 
	ret nz			;04d2	c0 	. 
	ld hl,l04d9h		;04d3	21 d9 04 	! . . 
	jp sub_111ch		;04d6	c3 1c 11 	. . . 
l04d9h:
	defb 0fdh,067h,0d6h	;illegal sequence		;04d9	fd 67 d6 	. g . 
	cp 092h		;04dc	fe 92 	. . 
	add a,c			;04de	81 	. 
	ld a,a			;04df	7f 	 
	defb 0fdh,0a7h,0d6h	;illegal sequence		;04e0	fd a7 d6 	. . . 
	add a,e			;04e3	83 	. 
	rst 38h			;04e4	ff 	. 
sub_04e5h:
	ld hl,l04fdh		;04e5	21 fd 04 	! . . 
	call sub_111ch		;04e8	cd 1c 11 	. . . 
	ld a,(0e002h)		;04eb	3a 02 e0 	: . . 
	and 001h		;04ee	e6 01 	. . 
	inc a			;04f0	3c 	< 
	call sub_1108h		;04f1	cd 08 11 	. . . 
	call sub_111ch		;04f4	cd 1c 11 	. . . 
	call sub_0556h		;04f7	cd 56 05 	. V . 
	jp sub_111ch		;04fa	c3 1c 11 	. . . 
l04fdh:
	defb 0fdh,067h,0d3h	;illegal sequence		;04fd	fd 67 d3 	. g . 
	defb 0feh, 0dbh
	defb "                  "
	defb 0fdh,0a7h,0d3h
	defb 020h, 0ffh
	defb 02dh
	defb "PLAYER ", 0ffh ; 051ah
	defb 02dh
	defb "FLOOR ", 0fdh  ; 0523h
	defb 0e7h,0d3h
	defb "                  ", 0ffh
	defb 0feh,0dbh
	defb 0fdh,02ch,0d4h
	defb " READY ", 0fdh ; 0544h
	defb 06ch, 0d4h
	defb "       ", 0ffh
sub_0556h:
	ld a,(0e080h)		;0556	3a 80 e0 	: . . 
l0559h:
	and 007h		;0559	e6 07 	. . 
sub_055bh:
	inc a			;055b	3c 	< 
	jp sub_1108h		;055c	c3 08 11 	. . . 
sub_055fh:
	ld a,(0e883h)		;055f	3a 83 e8 	: . . 
	and a			;0562	a7 	. 
	ret nz			;0563	c0 	. 
	ld a,003h		;0564	3e 03 	> . 
	ld (0e883h),a		;0566	32 83 e8 	2 . . 
	ld a,016h		;0569	3e 16 	> . 
	call sub_0dfeh		;056b	cd fe 0d 	. . . 
	ret			;056e	c9 	. 
sub_056fh:
	in a,(003h)		;056f	db 03 	. . 
	cpl			;0571	2f 	/ 
l0572h:
	and 00ch		;0572	e6 0c 	. . 
l0574h:
	rrca			;0574	0f 	. 
	rrca			;0575	0f 	. 
	add a,002h		;0576	c6 02 	. . 
	cp 004h		;0578	fe 04 	. . 
	ret nc			;057a	d0 	. 
	inc a			;057b	3c 	< 
	cp 003h		;057c	fe 03 	. . 
	ret z			;057e	c8 	. 
	ld a,002h		;057f	3e 02 	> . 
	ret			;0581	c9 	. 
sub_0582h:
	ld (0e882h),a		;0582	32 82 e8 	2 . . 
l0585h:
	call sub_0fe3h		;0585	cd e3 0f 	. . . 
	ld a,(0e882h)		;0588	3a 82 e8 	: . . 
	and a			;058b	a7 	. 
	jr nz,l0585h		;058c	20 f7 	  . 
	ret			;058e	c9 	. 
sub_058fh:
	in a,(003h)		;058f	db 03 	. . 
	cpl			;0591	2f 	/ 
	rra			;0592	1f 	. 
	rra			;0593	1f 	. 
l0594h:
	rra			;0594	1f 	. 
	rra			;0595	1f 	. 
	ld b,a			;0596	47 	G 
	ld hl,0e90ah		;0597	21 0a e9 	! . . 
	in a,(004h)		;059a	db 04 	. . 
	bit 2,a		;059c	cb 57 	. W 
	jr nz,l05b1h		;059e	20 11 	  . 
	ld a,b			;05a0	78 	x 
	inc a			;05a1	3c 	< 
	and 003h		;05a2	e6 03 	. . 
	ld (hl),a			;05a4	77 	w 
	inc hl			;05a5	23 	# 
	ld a,b			;05a6	78 	x 
	rra			;05a7	1f 	. 
	rra			;05a8	1f 	. 
	and 003h		;05a9	e6 03 	. . 
	cp 002h		;05ab	fe 02 	. . 
	sbc a,0f5h		;05ad	de f5 	. . 
	ld (hl),a			;05af	77 	w 
	ret			;05b0	c9 	. 
l05b1h:
	ld a,b			;05b1	78 	x 
	inc a			;05b2	3c 	< 
	and 00fh		;05b3	e6 0f 	. . 
	cp 007h		;05b5	fe 07 	. . 
	jr c,l05c3h		;05b7	38 0a 	8 . 
	cp 009h		;05b9	fe 09 	. . 
	jr c,l05c1h		;05bb	38 04 	8 . 
	cp 00eh		;05bd	fe 0e 	. . 
	jr c,l05c3h		;05bf	38 02 	8 . 
l05c1h:
	ld a,001h		;05c1	3e 01 	> . 
l05c3h:
	bit 3,a		;05c3	cb 5f 	. _ 
	jr z,l05c8h		;05c5	28 01 	( . 
	inc a			;05c7	3c 	< 
l05c8h:
	ld (hl),a			;05c8	77 	w 
	inc hl			;05c9	23 	# 
	ld (hl),a			;05ca	77 	w 
	ret			;05cb	c9 	. 
l05cch:
	nop			;05cc	00 	.

	; Table "BEST 20 PLAYERS"
	;
	; Each entry is the record + a NULL-terminated string with the names (3 chars)
	; The record printed as first hex number + the second hex number + a cero char
	defb 014h, 095h ; 014h, 095h --> 14950 points for "TA."
	defb "TA.", 0

	defb 015h, 038h
	defb "AAA", 0

	defb 015h, 072h ;05d9
	defb "NNI", 0 ; 05dbh

	defb 016h, 052h ;05d9
	defb "AAA", 0 ; 05e1

	defb 018h, 021h
	defb "IKO", 0 ; 05e7

	defb 019h, 085h
	defb "AI.", 0 ; 05e7

	defb 020h, 007h
	defb "ANO", 0 ; 05f3

	defb 021h, 001h
	defb "M.K", 0

	defb 025h, 051h
	defb "IIA", 0

	defb 025h, 070h
	defb "HAT", 0

	defb 026h, 035h ;0609
	defb "A.T", 0

	defb 028h, 011h ;060f
	defb "YE.", 0

	defb 030h, 021h ;0615
	defb "SAI", 0

	defb 035h, 050h
	defb "IHM", 0

	defb 038h, 010h
	defb "ANI", 0

	defb 039h, 018h
	defb "TSI", 0

	defb 039h, 075h ;062d
	defb "BAH", 0

	defb 040h, 010h ;0633
	defb "T.K", 0

	defb 043h, 015h ;0639
	defb "SUI", 0

	defb 048h, 052h ;063f
	defb "N.A"

sub_0644h:
	ld hl,l0080h		;0644	21 80 00 	! . . 
	ld (0e902h),hl		;0647	22 02 e9 	" . . 
	ld hl,0eb25h		;064a	21 25 eb 	! % . 
	ld de,0eb26h		;064d	11 26 eb 	. & . 
	ld bc,000bfh		;0650	01 bf 00 	. . . 
	ld (hl),000h		;0653	36 00 	6 . 
	ldir		;0655	ed b0 	. . 
	call sub_074dh		;0657	cd 4d 07 	. M . 
	call sub_06beh		;065a	cd be 06 	. . . 
	ld hl,0e380h		;065d	21 80 e3 	! . . 
	ld de,0e381h		;0660	11 81 e3 	. . . 
	ld bc,00131h		;0663	01 31 01 	. 1 . 
	ld (hl),000h		;0666	36 00 	6 . 
	ldir		;0668	ed b0 	. . 
	call sub_0866h		;066a	cd 66 08 	. f . 
	ld hl,l0889h+1		;066d	21 8a 08 	! . . 
	add hl,bc			;0670	09 	. 
	ld a,(hl)			;0671	7e 	~ 
	ld (0e100h),a		;0672	32 00 e1 	2 . . 
	and a			;0675	a7 	. 
	jr z,l0689h		;0676	28 11 	( . 
	ld hl,l08b0h		;0678	21 b0 08 	! . . 
	ld de,0e360h		;067b	11 60 e3 	. ` . 
l067eh:
	ld bc,l0016h+2		;067e	01 18 00 	. . . 
	call sub_06b2h		;0681	cd b2 06 	. . . 
	ld a,001h		;0684	3e 01 	> . 
	ld (0e380h),a		;0686	32 80 e3 	2 . . 
l0689h:
	ld hl,0e520h		;0689	21 20 e5 	!   . 
	ld de,0e521h		;068c	11 21 e5 	. ! . 
	ld bc,l0143h		;068f	01 43 01 	. C . 
	ld (hl),000h		;0692	36 00 	6 . 
	ldir		;0694	ed b0 	. . 
	call sub_0866h		;0696	cd 66 08 	. f . 
	ld hl,l089eh		;0699	21 9e 08 	! . . 
	add hl,bc			;069c	09 	. 
	ld a,(hl)			;069d	7e 	~ 
	and a			;069e	a7 	. 
	ret z			;069f	c8 	. 
	ld (0e100h),a		;06a0	32 00 e1 	2 . . 
	ld hl,00920h		;06a3	21 20 09 	!   . 
	ld de,0e500h		;06a6	11 00 e5 	. . . 
	ld bc,0011h		;06a9	01 11 00 	. . . 
	call sub_06b2h		;06ac	cd b2 06 	. . . 
	jp l3d53h		;06af	c3 53 3d 	. S = 
sub_06b2h:
	add a,a			;06b2	87 	. 
	push bc			;06b3	c5 	. 
	ld c,a			;06b4	4f 	O 
	add hl,bc			;06b5	09 	. 
	pop bc			;06b6	c1 	. 
	ld a,(hl)			;06b7	7e 	~ 
	inc hl			;06b8	23 	# 
	ld h,(hl)			;06b9	66 	f 
	ld l,a			;06ba	6f 	o 
	ldir		;06bb	ed b0 	. . 
	ret			;06bd	c9 	. 
sub_06beh:
	ld hl,0e700h		;06be	21 00 e7 	! . . 
	ld de,0e701h		;06c1	11 01 e7 	. . . 
	ld bc,l0023h		;06c4	01 23 00 	. # . 
	ld (hl),000h		;06c7	36 00 	6 . 
	ldir		;06c9	ed b0 	. . 
	ld a,(0e080h)		;06cb	3a 80 e0 	: . . 
	and 007h		;06ce	e6 07 	. . 
	add a,a			;06d0	87 	. 
	ld c,a			;06d1	4f 	O 
	ld hl,l0880h		;06d2	21 80 08 	! . . 
	add hl,bc			;06d5	09 	. 
	ld a,(hl)			;06d6	7e 	~ 
	inc hl			;06d7	23 	# 
	ld h,(hl)			;06d8	66 	f 
	ld l,a			;06d9	6f 	o 
	ld (0e003h),hl		;06da	22 03 e0 	" . . 
	ld a,03fh		;06dd	3e 3f 	> ? 
	ld (0e709h),a		;06df	32 09 e7 	2 . . 
	ld hl,05000h		;06e2	21 00 50 	! . P 
	ld (0e710h),hl		;06e5	22 10 e7 	" . . 
	ld a,(0e080h)		;06e8	3a 80 e0 	: . . 
	and 001h		;06eb	e6 01 	. . 
	ld (0e101h),a		;06ed	32 01 e1 	2 . . 
	jr z,l071dh		;06f0	28 2b 	( + 
	ld hl,0e700h		;06f2	21 00 e7 	! . . 
	ld (hl),020h		;06f5	36 20 	6   
	inc hl			;06f7	23 	# 
	ld (hl),040h		;06f8	36 40 	6 @ 
	ld hl,0ce40h		;06fa	21 40 ce 	! @ . 
	ld (0e102h),hl		;06fd	22 02 e1 	" . . 
	ld hl,00900h		;0700	21 00 09 	! . . 
	ld (0e712h),hl		;0703	22 12 e7 	" . . 
	ld hl,l1000h		;0706	21 00 10 	! . . 
	ld (0e707h),hl		;0709	22 07 e7 	" . . 
	ld hl,0cd00h		;070c	21 00 cd 	! . . 
	ld (0e106h),hl		;070f	22 06 e1 	" . . 
	ld hl,l02c0h		;0712	21 c0 02 	! . . 
	ld (0e104h),hl		;0715	22 04 e1 	" . . 
	ld a,001h		;0718	3e 01 	> . 
	jp l0749h		;071a	c3 49 07 	. I . 
l071dh:
	ld a,(0e080h)		;071d	3a 80 e0 	: . . 
	and 007h		;0720	e6 07 	. . 
	ld hl,010e0h		;0722	21 e0 10 	! . . 
	cp 004h		;0725	fe 04 	. . 
	jr nz,l072ch		;0727	20 03 	  . 
	ld hl,l1000h		;0729	21 00 10 	! . . 
l072ch:
	ld (0e102h),hl		;072c	22 02 e1 	" . . 
	ld hl,0d560h		;072f	21 60 d5 	! ` . 
	ld (0e712h),hl		;0732	22 12 e7 	" . . 
	ld hl,0d000h		;0735	21 00 d0 	! . . 
	ld (0e707h),hl		;0738	22 07 e7 	" . . 
	ld hl,0dc40h		;073b	21 40 dc 	! @ . 
	ld (0e106h),hl		;073e	22 06 e1 	" . . 
	ld hl,011c0h		;0741	21 c0 11 	! . . 
	ld (0e104h),hl		;0744	22 04 e1 	" . . 
	ld a,0dfh		;0747	3e df 	> . 
l0749h:
	ld (0e714h),a		;0749	32 14 e7 	2 . . 
	ret			;074c	c9 	. 
sub_074dh:
	ld hl,0e200h		;074d	21 00 e2 	! . . 
	ld de,0e201h		;0750	11 01 e2 	. . . 
	ld bc,l0152h		;0753	01 52 01 	. R . 
	ld (hl),000h		;0756	36 00 	6 . 
	ldir		;0758	ed b0 	. . 
	ld a,(0e080h)		;075a	3a 80 e0 	: . . 
	and 007h		;075d	e6 07 	. . 
	cp 004h		;075f	fe 04 	. . 
	defb 020h, 02eh
	defb 021h, 000h, 006h
	ld (0e342h),hl		;0766	22 42 e3 	" B . 
	ld hl,00780h		;0769	21 80 07 	! . . 
	ld (0e34eh),hl		;076c	22 4e e3 	" N . 
	ld hl,05000h		;076f	21 00 50 	! . P 
	ld (0e344h),hl		;0772	22 44 e3 	" D . 
	ld (0e350h),hl		;0775	22 50 e3 	" P . 
	ld a,004h		;0778	3e 04 	> . 
	ld (0e346h),a		;077a	32 46 e3 	2 F . 
	ld a,007h		;077d	3e 07 	> . 
	ld (0e352h),a		;077f	32 52 e3 	2 R . 
	ld a,040h		;0782	3e 40 	> @ 
	ld (0e34ch),a		;0784	32 4c e3 	2 L . 
	ld a,050h		;0787	3e 50 	> P 
	ld (0e340h),a		;0789	32 40 e3 	2 @ . 
	ld a,005h		;078c	3e 05 	> . 
	ld (0e347h),a		;078e	32 47 e3 	2 G . 
l0791h:
	ld ix,0e2d8h		;0791	dd 21 d8 e2 	. ! . . 
	ld (ix+00ah),03fh		;0795	dd 36 0a 3f 	. 6 . ? 
	ld (ix+007h),007h		;0799	dd 36 07 07 	. 6 . . 
	ld hl,05000h		;079d	21 00 50 	! . P 
	ld (0e2dch),hl		;07a0	22 dc e2 	" . . 
	ld a,(0e080h)		;07a3	3a 80 e0 	: . . 
	and 001h		;07a6	e6 01 	. . 
	ld hl,l1500h		;07a8	21 00 15 	! . . 
	ld de,03100h		;07ab	11 00 31 	. . 1 
	jr z,l07b6h		;07ae	28 06 	( . 
	ld hl,0cc00h		;07b0	21 00 cc 	! . . 
	ld de,0b000h		;07b3	11 00 b0 	. . . 
l07b6h:
	ld (0e2dah),hl		;07b6	22 da e2 	" . . 
	ld (0e2d3h),de		;07b9	ed 53 d3 e2 	. S . . 
	call sub_0866h		;07bd	cd 66 08 	. f . 
	push bc			;07c0	c5 	. 
	sla c		;07c1	cb 21 	. ! 
	push bc			;07c3	c5 	. 
	push bc			;07c4	c5 	. 
	ld hl,l09b0h		;07c5	21 b0 09 	! . . 
	add hl,bc			;07c8	09 	. 
	ld a,(hl)			;07c9	7e 	~ 
	inc hl			;07ca	23 	# 
	ld h,(hl)			;07cb	66 	f 
	ld l,a			;07cc	6f 	o 
	ld de,0e19ch		;07cd	11 9c e1 	. . . 
	ld bc,l001dh		;07d0	01 1d 00 	. . . 
	ldir		;07d3	ed b0 	. . 
	ld hl,l097fh+1		;07d5	21 80 09 	! . . 
	pop bc			;07d8	c1 	. 
	add hl,bc			;07d9	09 	. 
	ld a,(hl)			;07da	7e 	~ 
	inc hl			;07db	23 	# 
	ld h,(hl)			;07dc	66 	f 
	ld l,a			;07dd	6f 	o 
	or h			;07de	b4 	. 
	jr z,l07e6h		;07df	28 05 	( . 
	ld bc,0006h+2		;07e1	01 08 00 	. . . 
	ldir		;07e4	ed b0 	. . 
l07e6h:
	pop bc			;07e6	c1 	. 
	ld hl,l0be0h		;07e7	21 e0 0b 	! . . 
	add hl,bc			;07ea	09 	. 
	ld de,0e196h		;07eb	11 96 e1 	. . . 
	ldi		;07ee	ed a0 	. . 
	ldi		;07f0	ed a0 	. . 
	xor a			;07f2	af 	. 
	ld (de),a			;07f3	12 	. 
	pop bc			;07f4	c1 	. 
	ld hl,l0b18h		;07f5	21 18 0b 	! . . 
	add hl,bc			;07f8	09 	. 
	ld a,(hl)			;07f9	7e 	~ 
	ld (0e1c1h),a		;07fa	32 c1 e1 	2 . . 
	ld hl,l0c08h		;07fd	21 08 0c 	! . . 
l0800h:
	add hl,bc			;0800	09 	. 
	ld a,(hl)			;0801	7e 	~ 
	ld (0e199h),a		;0802	32 99 e1 	2 . . 
	ld (0e19ah),a		;0805	32 9a e1 	2 . . 
	ld (0e19bh),a		;0808	32 9b e1 	2 . . 
	ld iy,0		;080b	fd 21 00 00 	. ! . . 
	ld hl,l0c2eh		;080f	21 2e 0c 	! . . 
	add hl,bc			;0812	09 	. 
	add hl,bc			;0813	09 	. 
	ld e,(hl)			;0814	5e 	^ 
	inc hl			;0815	23 	# 
	ld d,(hl)			;0816	56 	V 
	add iy,de		;0817	fd 19 	. . 
	ld ix,0e10ah		;0819	dd 21 0a e1 	. ! . . 
	ld de,l0c1ch		;081d	11 1c 0c 	. . . 
	ld b,023h		;0820	06 23 	. # 
l0822h:
	call sub_0845h		;0822	cd 45 08 	. E . 
	inc iy		;0825	fd 23 	. # 
	djnz l0822h		;0827	10 f9 	. . 
	ld hl,0e1ffh		;0829	21 ff e1 	! . . 
	ld (0e108h),hl		;082c	22 08 e1 	" . . 
	call sub_0866h		;082f	cd 66 08 	. f . 
	ld d,b			;0832	50 	P 
	ld e,c			;0833	59 	Y 
	ld hl,l0b2ch		;0834	21 2c 0b 	! , . 
	add hl,de			;0837	19 	. 
	ex de,hl			;0838	eb 	. 
	add hl,hl			;0839	29 	) 
	add hl,hl			;083a	29 	) 
	add hl,hl			;083b	29 	) 
	add hl,de			;083c	19 	. 
	ld de,0e1f0h		;083d	11 f0 e1 	. . . 
	ld c,009h		;0840	0e 09 	. . 
	ldir		;0842	ed b0 	. . 
	ret			;0844	c9 	. 
sub_0845h:
	ld a,(iy+000h)		;0845	fd 7e 00 	. ~ . 
	push af			;0848	f5 	. 
	rrca			;0849	0f 	. 
	rrca			;084a	0f 	. 
	rrca			;084b	0f 	. 
	rrca			;084c	0f 	. 
	call sub_0851h		;084d	cd 51 08 	. Q . 
	pop af			;0850	f1 	. 
sub_0851h:
	and 00fh		;0851	e6 0f 	. . 
	add a,a			;0853	87 	. 
	ld h,000h		;0854	26 00 	& . 
	ld l,a			;0856	6f 	o 
	add hl,de			;0857	19 	. 
	ld a,(hl)			;0858	7e 	~ 
	ld (ix+000h),a		;0859	dd 77 00 	. w . 
	inc hl			;085c	23 	# 
	ld a,(hl)			;085d	7e 	~ 
	ld (ix+001h),a		;085e	dd 77 01 	. w . 
	inc ix		;0861	dd 23 	. # 
	inc ix		;0863	dd 23 	. # 
	ret			;0865	c9 	. 
sub_0866h:
	ld a,(0e080h)		;0866	3a 80 e0 	: . . 
	ld l,a			;0869	6f 	o 
	and 007h		;086a	e6 07 	. . 
	ld h,a			;086c	67 	g 
	ld a,l			;086d	7d 	} 
	and 038h		;086e	e6 38 	. 8 
	cp 020h		;0870	fe 20 	.   
	jr c,l0876h		;0872	38 02 	8 . 
	ld a,018h		;0874	3e 18 	> . 
l0876h:
	rrca			;0876	0f 	. 
	ld l,a			;0877	6f 	o 
	rrca			;0878	0f 	. 
	rrca			;0879	0f 	. 
	add a,l			;087a	85 	. 
	add a,h			;087b	84 	. 
	ld c,a			;087c	4f 	O 
	ld b,000h		;087d	06 00 	. . 
	ret			;087f	c9 	. 
l0880h:
	nop			;0880	00 	. 
	jr nz,l0883h		;0881	20 00 	  . 
l0883h:
	jr nz,l0885h		;0883	20 00 	  . 
l0885h:
	jr nz,l0887h		;0885	20 00 	  . 
l0887h:
	jr nz,l0889h		;0887	20 00 	  . 
l0889h:
	jr nz,l088bh		;0889	20 00 	  . 
l088bh:
	ld bc,00200h		;088b	01 00 02 	. . . 
	nop			;088e	00 	. 
	nop			;088f	00 	. 
	inc bc			;0890	03 	. 
	nop			;0891	00 	. 
	ld (bc),a			;0892	02 	. 
	nop			;0893	00 	. 
	nop			;0894	00 	. 
	inc b			;0895	04 	. 
	nop			;0896	00 	. 
	ld (bc),a			;0897	02 	. 
	nop			;0898	00 	. 
	nop			;0899	00 	. 
	dec b			;089a	05 	. 
	nop			;089b	00 	. 
	ld (bc),a			;089c	02 	. 
	nop			;089d	00 	. 
l089eh:
	nop			;089e	00 	. 
	nop			;089f	00 	. 
	nop			;08a0	00 	. 
	ld a,(bc)			;08a1	0a 	. 
	nop			;08a2	00 	. 
	nop			;08a3	00 	. 
	nop			;08a4	00 	. 
	nop			;08a5	00 	. 
	dec bc			;08a6	0b 	. 
	nop			;08a7	00 	. 
	nop			;08a8	00 	. 
	nop			;08a9	00 	. 
	nop			;08aa	00 	. 
	inc c			;08ab	0c 	. 
	nop			;08ac	00 	. 
	nop			;08ad	00 	. 
	nop			;08ae	00 	. 
	nop			;08af	00 	. 
l08b0h:
	dec c			;08b0	0d 	. 
	nop			;08b1	00 	. 
	cp h			;08b2	bc 	. 
	ex af,af'			;08b3	08 	. 
	inc e			;08b4	1c 	. 
	add hl,bc			;08b5	09 	. 
	call nc,0ec08h		;08b6	d4 08 ec 	. . . 
	ex af,af'			;08b9	08 	. 
	inc b			;08ba	04 	. 
	add hl,bc			;08bb	09 	. 
	nop			;08bc	00 	. 
	nop			;08bd	00 	. 
	ld (hl),b			;08be	70 	p 
	nop			;08bf	00 	. 
	dec c			;08c0	0d 	. 
	ld d,h			;08c1	54 	T 
	xor b			;08c2	a8 	. 
	ld b,e			;08c3	43 	C 
	ld e,d			;08c4	5a 	Z 
	ld (hl),b			;08c5	70 	p 
	ld h,(hl)			;08c6	66 	f 
	call z,0		;08c7	cc 00 00 	. . . 
	ld (hl),000h		;08ca	36 00 	6 . 
	ld d,0a9h		;08cc	16 a9 	. . 
	or (hl)			;08ce	b6 	. 
	ld bc,l014bh		;08cf	01 4b 01 	. K . 
	ld a,h			;08d2	7c 	| 
	nop			;08d3	00 	. 
	nop			;08d4	00 	. 
	nop			;08d5	00 	. 
	ld (hl),b			;08d6	70 	p 
	nop			;08d7	00 	. 
	dec c			;08d8	0d 	. 
	ld d,h			;08d9	54 	T 
	xor b			;08da	a8 	. 
	dec l			;08db	2d 	- 
	ld b,e			;08dc	43 	C 
	ld e,d			;08dd	5a 	Z 
	ld h,(hl)			;08de	66 	f 
	call z,0		;08df	cc 00 00 	. . . 
	ld (hl),000h		;08e2	36 00 	6 . 
	ld d,0a9h		;08e4	16 a9 	. . 
	or (hl)			;08e6	b6 	. 
	ld bc,l014bh		;08e7	01 4b 01 	. K . 
	ld a,h			;08ea	7c 	| 
	nop			;08eb	00 	. 
	nop			;08ec	00 	. 
	nop			;08ed	00 	. 
	ld (hl),b			;08ee	70 	p 
	nop			;08ef	00 	. 
	dec c			;08f0	0d 	. 
	ld d,h			;08f1	54 	T 
	xor b			;08f2	a8 	. 
	inc e			;08f3	1c 	. 
	jr c,l0939h		;08f4	38 43 	8 C 
	ld h,(hl)			;08f6	66 	f 
	call z,0		;08f7	cc 00 00 	. . . 
	ld (hl),000h		;08fa	36 00 	6 . 
	ld d,0a9h		;08fc	16 a9 	. . 
	or (hl)			;08fe	b6 	. 
	ld bc,l014bh		;08ff	01 4b 01 	. K . 
	ld a,h			;0902	7c 	| 
	nop			;0903	00 	. 
	nop			;0904	00 	. 
	nop			;0905	00 	. 
	ld (hl),b			;0906	70 	p 
	nop			;0907	00 	. 
	dec c			;0908	0d 	. 
	ld d,h			;0909	54 	T 
	xor b			;090a	a8 	. 
	inc e			;090b	1c 	. 
	dec l			;090c	2d 	- 
	jr c,l0975h		;090d	38 66 	8 f 
	call z,0		;090f	cc 00 00 	. . . 
	ld (hl),000h		;0912	36 00 	6 . 
	ld d,0a9h		;0914	16 a9 	. . 
	or (hl)			;0916	b6 	. 
	ld bc,l014bh		;0917	01 4b 01 	. K . 
	ld a,h			;091a	7c 	| 
	nop			;091b	00 	. 
	nop			;091c	00 	. 
	nop			;091d	00 	. 
	nop			;091e	00 	. 
	ld (hl),000h		;091f	36 00 	6 . 
	jr nc,l096ch		;0921	30 49 	0 I 
	nop			;0923	00 	. 
	nop			;0924	00 	. 
	nop			;0925	00 	. 
	ld h,c			;0926	61 	a 
	nop			;0927	00 	. 
	and h			;0928	a4 	. 
	nop			;0929	00 	. 
	ld (hl),000h		;092a	36 00 	6 . 
	ld d,000h		;092c	16 00 	. . 
	ld d,d			;092e	52 	R 
	nop			;092f	00 	. 
	ld c,c			;0930	49 	I 
	nop			;0931	00 	. 
	dec l			;0932	2d 	- 
	nop			;0933	00 	. 
	inc a			;0934	3c 	< 
	add hl,bc			;0935	09 	. 
	ld c,l			;0936	4d 	M 
	add hl,bc			;0937	09 	. 
	ld e,(hl)			;0938	5e 	^ 
l0939h:
	add hl,bc			;0939	09 	. 
	ld l,a			;093a	6f 	o 
	add hl,bc			;093b	09 	. 
	jr nz,l093eh		;093c	20 00 	  . 
l093eh:
	ld (l2800h),a		;093e	32 00 28 	2 . ( 
	nop			;0941	00 	. 
	inc sp			;0942	33 	3 
	nop			;0943	00 	. 
	inc hl			;0944	23 	# 
	nop			;0945	00 	. 
	ld l,e			;0946	6b 	k 
	rlca			;0947	07 	. 
	ld a,a			;0948	7f 	 
	ccf			;0949	3f 	? 
	ccf			;094a	3f 	? 
	jr c,$+114		;094b	38 70 	8 p 
	ld (03b00h),a		;094d	32 00 3b 	2 . ; 
	nop			;0950	00 	. 
	ccf			;0951	3f 	? 
	nop			;0952	00 	. 
	ld d,b			;0953	50 	P 
	nop			;0954	00 	. 
	jr c,l0957h		;0955	38 00 	8 . 
l0957h:
	ld l,e			;0957	6b 	k 
	rlca			;0958	07 	. 
	or d			;0959	b2 	. 
	ccf			;095a	3f 	? 
	ld h,(hl)			;095b	66 	f 
	jr c,l09ceh		;095c	38 70 	8 p 
	ld (03b00h),a		;095e	32 00 3b 	2 . ; 
	nop			;0961	00 	. 
	ccf			;0962	3f 	? 
	nop			;0963	00 	. 
	ld d,b			;0964	50 	P 
	nop			;0965	00 	. 
	jr c,l0968h		;0966	38 00 	8 . 
l0968h:
	jr c,l096eh		;0968	38 04 	8 . 
	ld a,a			;096a	7f 	 
	ld h,(hl)			;096b	66 	f 
l096ch:
	ld h,(hl)			;096c	66 	f 
	inc e			;096d	1c 	. 
l096eh:
	jr c,l09abh		;096e	38 3b 	8 ; 
	nop			;0970	00 	. 
	ld b,h			;0971	44 	D 
	nop			;0972	00 	. 
	ld c,d			;0973	4a 	J 
	nop			;0974	00 	. 
l0975h:
	ld e,a			;0975	5f 	_ 
	nop			;0976	00 	. 
	ld b,h			;0977	44 	D 
	nop			;0978	00 	. 
	jr c,l097fh		;0979	38 04 	8 . 
	or d			;097b	b2 	. 
	ld h,(hl)			;097c	66 	f 
	ld a,a			;097d	7f 	 
	inc e			;097e	1c 	. 
l097fh:
	jr c,l0981h		;097f	38 00 	8 . 
l0981h:
	nop			;0981	00 	. 
	xor b			;0982	a8 	. 
	add hl,bc			;0983	09 	. 
	nop			;0984	00 	. 
	nop			;0985	00 	. 
	nop			;0986	00 	. 
	nop			;0987	00 	. 
	nop			;0988	00 	. 
	nop			;0989	00 	. 
	nop			;098a	00 	. 
	nop			;098b	00 	. 
	xor b			;098c	a8 	. 
	add hl,bc			;098d	09 	. 
	nop			;098e	00 	. 
	nop			;098f	00 	. 
	nop			;0990	00 	. 
	nop			;0991	00 	. 
	nop			;0992	00 	. 
	nop			;0993	00 	. 
	nop			;0994	00 	. 
	nop			;0995	00 	. 
	xor b			;0996	a8 	. 
	add hl,bc			;0997	09 	. 
	nop			;0998	00 	. 
	nop			;0999	00 	. 
	nop			;099a	00 	. 
	nop			;099b	00 	. 
	nop			;099c	00 	. 
	nop			;099d	00 	. 
	nop			;099e	00 	. 
	nop			;099f	00 	. 
	xor b			;09a0	a8 	. 
	add hl,bc			;09a1	09 	. 
	nop			;09a2	00 	. 
	nop			;09a3	00 	. 
	nop			;09a4	00 	. 
	nop			;09a5	00 	. 
	nop			;09a6	00 	. 
	nop			;09a7	00 	. 
	or e			;09a8	b3 	. 
	rst 38h			;09a9	ff 	. 
	rlca			;09aa	07 	. 
l09abh:
	nop			;09ab	00 	. 
	ld l,000h		;09ac	2e 00 	. . 
	rst 10h			;09ae	d7 	. 
	nop			;09af	00 	. 
l09b0h:
	ret c			;09b0	d8 	. 
	add hl,bc			;09b1	09 	. 
	pop hl			;09b2	e1 	. 
	add hl,bc			;09b3	09 	. 
	rst 28h			;09b4	ef 	. 
	add hl,bc			;09b5	09 	. 
	add iy,bc		;09b6	fd 09 	. . 
	dec bc			;09b8	0b 	. 
	ld a,(bc)			;09b9	0a 	. 
	jr z,l09c6h		;09ba	28 0a 	( . 
l09bch:
	defb 031h, 00ah, 03fh
	ld a,(bc)			;09bf	0a 	. 
	ld c,l			;09c0	4d 	M 
	ld a,(bc)			;09c1	0a 	. 
	ld e,e			;09c2	5b 	[ 
	ld a,(bc)			;09c3	0a 	. 
	ld a,b			;09c4	78 	x 
	ld a,(bc)			;09c5	0a 	. 
l09c6h:
	add a,c			;09c6	81 	. 
	ld a,(bc)			;09c7	0a 	. 
	adc a,a			;09c8	8f 	. 
	ld a,(bc)			;09c9	0a 	. 
	sbc a,l			;09ca	9d 	. 
	ld a,(bc)			;09cb	0a 	. 
	xor e			;09cc	ab 	. 
	ld a,(bc)			;09cd	0a 	. 
l09ceh:
	ret z			;09ce	c8 	. 
	ld a,(bc)			;09cf	0a 	. 
	pop de			;09d0	d1 	. 
	ld a,(bc)			;09d1	0a 	. 
	rst 18h			;09d2	df 	. 
	ld a,(bc)			;09d3	0a 	. 
	defb 0edh;next byte illegal after ed		;09d4	ed 	. 
	ld a,(bc)			;09d5	0a 	. 
	ei			;09d6	fb 	. 
	ld a,(bc)			;09d7	0a 	. 
	sbc a,c			;09d8	99 	. 
	push hl			;09d9	e5 	. 
	ld h,(hl)			;09da	66 	f 
	sbc a,c			;09db	99 	. 
	ld d,h			;09dc	54 	T 
	xor b			;09dd	a8 	. 
	ld hl,00b16h		;09de	21 16 0b 	! . . 
	ld h,(hl)			;09e1	66 	f 
	ld a,a			;09e2	7f 	 
	call z,05403h		;09e3	cc 03 54 	. . T 
	xor b			;09e6	a8 	. 
	dec l			;09e7	2d 	- 
	ld e,d			;09e8	5a 	Z 
	ld (hl),b			;09e9	70 	p 
	ld d,h			;09ea	54 	T 
	xor b			;09eb	a8 	. 
	inc e			;09ec	1c 	. 
	dec l			;09ed	2d 	- 
	jr c,l09bch		;09ee	38 cc 	8 . 
	push hl			;09f0	e5 	. 
	xor b			;09f1	a8 	. 
l09f2h:
	call m,0a854h		;09f2	fc 54 a8 	. T . 
	dec l			;09f5	2d 	- 
	ld e,d			;09f6	5a 	Z 
	ld (hl),b			;09f7	70 	p 
	nop			;09f8	00 	. 
	nop			;09f9	00 	. 
	nop			;09fa	00 	. 
	nop			;09fb	00 	. 
	ld d,054h		;09fc	16 54 	. T 
	xor b			;09fe	a8 	. 
	sbc a,c			;09ff	99 	. 
l0a00h:
	or a			;0a00	b7 	. 
	ld a,a			;0a01	7f 	 
	call m,0a970h		;0a02	fc 70 a9 	. p . 
	xor c			;0a05	a9 	. 
	ld d,h			;0a06	54 	T 
	ld d,h			;0a07	54 	T 
	jr c,l0a7ah		;0a08	38 70 	8 p 
	xor c			;0a0a	a9 	. 
	ld h,(hl)			;0a0b	66 	f 
	call z,0a854h		;0a0c	cc 54 a8 	. T . 
	ld d,h			;0a0f	54 	T 
	xor b			;0a10	a8 	. 
	dec bc			;0a11	0b 	. 
	ld d,021h		;0a12	16 21 	. ! 
	ld d,h			;0a14	54 	T 
	xor b			;0a15	a8 	. 
	dec b			;0a16	05 	. 
	ex af,af'			;0a17	08 	. 
	dec bc			;0a18	0b 	. 
	inc bc			;0a19	03 	. 
	add a,b			;0a1a	80 	. 
	nop			;0a1b	00 	. 
	sbc a,c			;0a1c	99 	. 
	ld a,a			;0a1d	7f 	 
	ld h,(hl)			;0a1e	66 	f 
	ld a,a			;0a1f	7f 	 
	call z,04c66h		;0a20	cc 66 4c 	. f L 
	ld a,a			;0a23	7f 	 
	sbc a,c			;0a24	99 	. 
	ld a,a			;0a25	7f 	 
	ld a,a			;0a26	7f 	 
	ld c,h			;0a27	4c 	L 
	ld a,a			;0a28	7f 	 
	cp a			;0a29	bf 	. 
	inc sp			;0a2a	33 	3 
	ld h,(hl)			;0a2b	66 	f 
	ld d,h			;0a2c	54 	T 
	xor b			;0a2d	a8 	. 
	rra			;0a2e	1f 	. 
	dec d			;0a2f	15 	. 
	dec bc			;0a30	0b 	. 
	ld c,h			;0a31	4c 	L 
	ld h,(hl)			;0a32	66 	f 
	or d			;0a33	b2 	. 
	inc bc			;0a34	03 	. 
	ld d,h			;0a35	54 	T 
	xor b			;0a36	a8 	. 
	dec l			;0a37	2d 	- 
	ld e,d			;0a38	5a 	Z 
	ld (hl),b			;0a39	70 	p 
	ld d,h			;0a3a	54 	T 
	xor b			;0a3b	a8 	. 
	inc e			;0a3c	1c 	. 
	dec l			;0a3d	2d 	- 
	jr c,l09f2h		;0a3e	38 b2 	8 . 
	push hl			;0a40	e5 	. 
	xor b			;0a41	a8 	. 
	call m,0a854h		;0a42	fc 54 a8 	. T . 
	ld hl,05a38h		;0a45	21 38 5a 	! 8 Z 
	nop			;0a48	00 	. 
	nop			;0a49	00 	. 
	nop			;0a4a	00 	. 
	nop			;0a4b	00 	. 
	djnz l0aa2h		;0a4c	10 54 	. T 
	xor b			;0a4e	a8 	. 
	ld a,a			;0a4f	7f 	 
	or d			;0a50	b2 	. 
	ld a,a			;0a51	7f 	 
	call m,0a970h		;0a52	fc 70 a9 	. p . 
	xor c			;0a55	a9 	. 
	ld d,h			;0a56	54 	T 
	ld d,h			;0a57	54 	T 
	inc e			;0a58	1c 	. 
	jr c,l0acbh		;0a59	38 70 	8 p 
	ld h,(hl)			;0a5b	66 	f 
	call z,0a854h		;0a5c	cc 54 a8 	. T . 
	ld d,h			;0a5f	54 	T 
	xor b			;0a60	a8 	. 
	dec bc			;0a61	0b 	. 
	ld d,021h		;0a62	16 21 	. ! 
	ld d,h			;0a64	54 	T 
	xor b			;0a65	a8 	. 
	dec b			;0a66	05 	. 
	ex af,af'			;0a67	08 	. 
	dec bc			;0a68	0b 	. 
	inc bc			;0a69	03 	. 
	add a,b			;0a6a	80 	. 
	nop			;0a6b	00 	. 
	sbc a,c			;0a6c	99 	. 
	ld a,a			;0a6d	7f 	 
	ld a,a			;0a6e	7f 	 
	ld a,a			;0a6f	7f 	 
	call z,0667fh		;0a70	cc 7f 66 	.  f 
	ld a,a			;0a73	7f 	 
	sbc a,c			;0a74	99 	. 
	ld a,a			;0a75	7f 	 
	ld a,a			;0a76	7f 	 
	ld a,a			;0a77	7f 	 
	ld c,h			;0a78	4c 	L 
	or d			;0a79	b2 	. 
l0a7ah:
	inc sp			;0a7a	33 	3 
	ld h,(hl)			;0a7b	66 	f 
	ld d,h			;0a7c	54 	T 
	xor b			;0a7d	a8 	. 
	inc e			;0a7e	1c 	. 
	inc de			;0a7f	13 	. 
	dec bc			;0a80	0b 	. 
	inc sp			;0a81	33 	3 
	ld a,a			;0a82	7f 	 
	call z,05403h		;0a83	cc 03 54 	. . T 
	xor b			;0a86	a8 	. 
	dec l			;0a87	2d 	- 
	ld e,d			;0a88	5a 	Z 
	ld (hl),b			;0a89	70 	p 
	ld d,h			;0a8a	54 	T 
	xor b			;0a8b	a8 	. 
	djnz $+30		;0a8c	10 1c 	. . 
	dec l			;0a8e	2d 	- 
	sbc a,c			;0a8f	99 	. 
	push hl			;0a90	e5 	. 
	ld a,a			;0a91	7f 	 
	call m,0a854h		;0a92	fc 54 a8 	. T . 
	ld d,02dh		;0a95	16 2d 	. - 
	ld b,e			;0a97	43 	C 
	nop			;0a98	00 	. 
	nop			;0a99	00 	. 
	nop			;0a9a	00 	. 
	nop			;0a9b	00 	. 
	dec bc			;0a9c	0b 	. 
	ld d,h			;0a9d	54 	T 
	xor b			;0a9e	a8 	. 
	ld h,(hl)			;0a9f	66 	f 
	or d			;0aa0	b2 	. 
	ld a,a			;0aa1	7f 	 
l0aa2h:
	call m,0a970h		;0aa2	fc 70 a9 	. p . 
	xor c			;0aa5	a9 	. 
	ld d,h			;0aa6	54 	T 
	ld d,h			;0aa7	54 	T 
	inc e			;0aa8	1c 	. 
	jr c,$+114		;0aa9	38 70 	8 p 
	ld h,(hl)			;0aab	66 	f 
	call z,0a854h		;0aac	cc 54 a8 	. T . 
	ld d,h			;0aaf	54 	T 
	xor b			;0ab0	a8 	. 
	dec bc			;0ab1	0b 	. 
	ld d,021h		;0ab2	16 21 	. ! 
	ld d,h			;0ab4	54 	T 
	xor b			;0ab5	a8 	. 
	dec b			;0ab6	05 	. 
	ex af,af'			;0ab7	08 	. 
	dec bc			;0ab8	0b 	. 
	inc bc			;0ab9	03 	. 
	add a,b			;0aba	80 	. 
	nop			;0abb	00 	. 
	call z,07fcch		;0abc	cc cc 7f 	. .  
	call z,07fcch		;0abf	cc cc 7f 	. .  
	ld c,h			;0ac2	4c 	L 
	ld a,a			;0ac3	7f 	 
	call z,0cccch		;0ac4	cc cc cc 	. . . 
	ld c,h			;0ac7	4c 	L 
	ld c,h			;0ac8	4c 	L 
	sbc a,c			;0ac9	99 	. 
	inc sp			;0aca	33 	3 
l0acbh:
	ld h,(hl)			;0acb	66 	f 
	ld d,h			;0acc	54 	T 
	xor b			;0acd	a8 	. 
	add hl,de			;0ace	19 	. 
	inc de			;0acf	13 	. 
	dec bc			;0ad0	0b 	. 
	add hl,de			;0ad1	19 	. 
	ld a,a			;0ad2	7f 	 
	push hl			;0ad3	e5 	. 
	inc bc			;0ad4	03 	. 
	ld d,h			;0ad5	54 	T 
	xor b			;0ad6	a8 	. 
	dec l			;0ad7	2d 	- 
	ld e,d			;0ad8	5a 	Z 
	ld (hl),b			;0ad9	70 	p 
	ld d,h			;0ada	54 	T 
	xor b			;0adb	a8 	. 
	djnz l0afah		;0adc	10 1c 	. . 
	dec l			;0ade	2d 	- 
	ld a,a			;0adf	7f 	 
	call z,0fc54h		;0ae0	cc 54 fc 	. T . 
	ld d,h			;0ae3	54 	T 
	xor b			;0ae4	a8 	. 
	ld d,02dh		;0ae5	16 2d 	. - 
	ld b,e			;0ae7	43 	C 
	nop			;0ae8	00 	. 
	nop			;0ae9	00 	. 
	nop			;0aea	00 	. 
	nop			;0aeb	00 	. 
	dec bc			;0aec	0b 	. 
	ld d,h			;0aed	54 	T 
	xor b			;0aee	a8 	. 
	ld d,h			;0aef	54 	T 
	xor b			;0af0	a8 	. 
	ld a,a			;0af1	7f 	 
	call m,0a970h		;0af2	fc 70 a9 	. p . 
	xor c			;0af5	a9 	. 
	ld d,h			;0af6	54 	T 
	ld d,h			;0af7	54 	T 
	inc e			;0af8	1c 	. 
	inc e			;0af9	1c 	. 
l0afah:
	ld (hl),b			;0afa	70 	p 
	ld h,(hl)			;0afb	66 	f 
	call z,0a854h		;0afc	cc 54 a8 	. T . 
	ld d,h			;0aff	54 	T 
	xor b			;0b00	a8 	. 
	dec bc			;0b01	0b 	. 
	ld d,021h		;0b02	16 21 	. ! 
	ld d,h			;0b04	54 	T 
	xor b			;0b05	a8 	. 
	dec b			;0b06	05 	. 
	ex af,af'			;0b07	08 	. 
	dec bc			;0b08	0b 	. 
	inc bc			;0b09	03 	. 
	add a,b			;0b0a	80 	. 
	nop			;0b0b	00 	. 
	push hl			;0b0c	e5 	. 
	call z,0cc7fh		;0b0d	cc 7f cc 	.  . 
l0b10h:
	push hl			;0b10	e5 	. 
	sbc a,c			;0b11	99 	. 
	ld a,a			;0b12	7f 	 
	ld a,a			;0b13	7f 	 
	push hl			;0b14	e5 	. 
	call z,07fcch		;0b15	cc cc 7f 	. .  
l0b18h:
	nop			;0b18	00 	. 
	nop			;0b19	00 	. 
	ld h,033h		;0b1a	26 33 	& 3 
	ld c,h			;0b1c	4c 	L 
	nop			;0b1d	00 	. 
	add hl,de			;0b1e	19 	. 
	ld h,033h		;0b1f	26 33 	& 3 
	ld c,h			;0b21	4c 	L 
	nop			;0b22	00 	. 
	add hl,de			;0b23	19 	. 
	inc sp			;0b24	33 	3 
	ld c,h			;0b25	4c 	L 
	ld h,(hl)			;0b26	66 	f 
	nop			;0b27	00 	. 
	add hl,de			;0b28	19 	. 
	ld c,h			;0b29	4c 	L 
	ld h,(hl)			;0b2a	66 	f 
	ld a,a			;0b2b	7f 	 
l0b2ch:
	inc b			;0b2c	04 	. 
	ccf			;0b2d	3f 	? 
	ld e,d			;0b2e	5a 	Z 
	or h			;0b2f	b4 	. 
	pop hl			;0b30	e1 	. 
	ld a,(de)			;0b31	1a 	. 
	ld bc,00049h		;0b32	01 49 00 	. I . 
	inc b			;0b35	04 	. 
	ccf			;0b36	3f 	? 
	ld e,d			;0b37	5a 	Z 
	or h			;0b38	b4 	. 
	pop hl			;0b39	e1 	. 
	ld a,(de)			;0b3a	1a 	. 
	ld bc,00049h		;0b3b	01 49 00 	. I . 
	inc b			;0b3e	04 	. 
	ld d,l			;0b3f	55 	U 
	ld e,d			;0b40	5a 	Z 
	or h			;0b41	b4 	. 
	pop hl			;0b42	e1 	. 
	ld a,(de)			;0b43	1a 	. 
	ld bc,00049h		;0b44	01 49 00 	. I . 
	inc b			;0b47	04 	. 
	ld d,l			;0b48	55 	U 
	ld e,d			;0b49	5a 	Z 
	or h			;0b4a	b4 	. 
	pop hl			;0b4b	e1 	. 
	ld a,(de)			;0b4c	1a 	. 
	ld bc,00049h		;0b4d	01 49 00 	. I . 
	inc b			;0b50	04 	. 
	ld h,(hl)			;0b51	66 	f 
	ld e,d			;0b52	5a 	Z 
	or h			;0b53	b4 	. 
	pop hl			;0b54	e1 	. 
	ld a,(de)			;0b55	1a 	. 
	ld bc,00049h		;0b56	01 49 00 	. I . 
	inc b			;0b59	04 	. 
	ld h,(hl)			;0b5a	66 	f 
	ld e,d			;0b5b	5a 	Z 
	or h			;0b5c	b4 	. 
	pop hl			;0b5d	e1 	. 
	pop hl			;0b5e	e1 	. 
	nop			;0b5f	00 	. 
	ld d,d			;0b60	52 	R 
	nop			;0b61	00 	. 
	inc b			;0b62	04 	. 
	ld h,(hl)			;0b63	66 	f 
	ld e,d			;0b64	5a 	Z 
	or h			;0b65	b4 	. 
	pop hl			;0b66	e1 	. 
	pop hl			;0b67	e1 	. 
	nop			;0b68	00 	. 
	ld d,d			;0b69	52 	R 
	nop			;0b6a	00 	. 
	inc b			;0b6b	04 	. 
	ld h,(hl)			;0b6c	66 	f 
	ld e,d			;0b6d	5a 	Z 
	or h			;0b6e	b4 	. 
	pop hl			;0b6f	e1 	. 
	pop hl			;0b70	e1 	. 
	nop			;0b71	00 	. 
	ld d,d			;0b72	52 	R 
	nop			;0b73	00 	. 
	inc b			;0b74	04 	. 
	ld h,(hl)			;0b75	66 	f 
	ld e,d			;0b76	5a 	Z 
	or h			;0b77	b4 	. 
	pop hl			;0b78	e1 	. 
	pop hl			;0b79	e1 	. 
	nop			;0b7a	00 	. 
	ld d,d			;0b7b	52 	R 
	nop			;0b7c	00 	. 
	inc b			;0b7d	04 	. 
	ld h,(hl)			;0b7e	66 	f 
	ld e,d			;0b7f	5a 	Z 
	or h			;0b80	b4 	. 
	pop hl			;0b81	e1 	. 
	pop hl			;0b82	e1 	. 
	nop			;0b83	00 	. 
	ld d,d			;0b84	52 	R 
	nop			;0b85	00 	. 
	inc b			;0b86	04 	. 
	ld a,a			;0b87	7f 	 
	ld e,d			;0b88	5a 	Z 
	or h			;0b89	b4 	. 
	pop hl			;0b8a	e1 	. 
	xor c			;0b8b	a9 	. 
	nop			;0b8c	00 	. 
	ld e,e			;0b8d	5b 	[ 
	nop			;0b8e	00 	. 
	inc b			;0b8f	04 	. 
	ld a,a			;0b90	7f 	 
	ld e,d			;0b91	5a 	Z 
	or h			;0b92	b4 	. 
	pop hl			;0b93	e1 	. 
	xor c			;0b94	a9 	. 
	nop			;0b95	00 	. 
	ld e,e			;0b96	5b 	[ 
	nop			;0b97	00 	. 
	inc b			;0b98	04 	. 
	ld a,a			;0b99	7f 	 
	ld e,d			;0b9a	5a 	Z 
	or h			;0b9b	b4 	. 
	pop hl			;0b9c	e1 	. 
	xor c			;0b9d	a9 	. 
	nop			;0b9e	00 	. 
	ld e,e			;0b9f	5b 	[ 
	nop			;0ba0	00 	. 
	inc b			;0ba1	04 	. 
	ld a,a			;0ba2	7f 	 
	ld e,d			;0ba3	5a 	Z 
	or h			;0ba4	b4 	. 
	pop hl			;0ba5	e1 	. 
	xor c			;0ba6	a9 	. 
	nop			;0ba7	00 	. 
	ld e,e			;0ba8	5b 	[ 
	nop			;0ba9	00 	. 
	inc b			;0baa	04 	. 
	ld a,a			;0bab	7f 	 
	ld e,d			;0bac	5a 	Z 
	or h			;0bad	b4 	. 
	pop hl			;0bae	e1 	. 
	xor c			;0baf	a9 	. 
	nop			;0bb0	00 	. 
	ld e,e			;0bb1	5b 	[ 
	nop			;0bb2	00 	. 
	inc b			;0bb3	04 	. 
	ld a,a			;0bb4	7f 	 
	ld e,d			;0bb5	5a 	Z 
	or h			;0bb6	b4 	. 
	pop hl			;0bb7	e1 	. 
	xor c			;0bb8	a9 	. 
	nop			;0bb9	00 	. 
	ld e,e			;0bba	5b 	[ 
	nop			;0bbb	00 	. 
	inc b			;0bbc	04 	. 
	ld a,a			;0bbd	7f 	 
	ld e,d			;0bbe	5a 	Z 
	or h			;0bbf	b4 	. 
	pop hl			;0bc0	e1 	. 
	xor c			;0bc1	a9 	. 
	nop			;0bc2	00 	. 
	ld e,e			;0bc3	5b 	[ 
	nop			;0bc4	00 	. 
	inc b			;0bc5	04 	. 
	ld a,a			;0bc6	7f 	 
	ld e,d			;0bc7	5a 	Z 
	or h			;0bc8	b4 	. 
	pop hl			;0bc9	e1 	. 
	xor c			;0bca	a9 	. 
	nop			;0bcb	00 	. 
	ld e,e			;0bcc	5b 	[ 
	nop			;0bcd	00 	. 
	inc b			;0bce	04 	. 
	ld a,a			;0bcf	7f 	 
	ld e,d			;0bd0	5a 	Z 
	or h			;0bd1	b4 	. 
	pop hl			;0bd2	e1 	. 
	xor c			;0bd3	a9 	. 
	nop			;0bd4	00 	. 
	ld e,e			;0bd5	5b 	[ 
	nop			;0bd6	00 	. 
	inc b			;0bd7	04 	. 
	ld a,a			;0bd8	7f 	 
	ld e,d			;0bd9	5a 	Z 
	or h			;0bda	b4 	. 
	pop hl			;0bdb	e1 	. 
	xor c			;0bdc	a9 	. 
	nop			;0bdd	00 	. 
	ld e,e			;0bde	5b 	[ 
	nop			;0bdf	00 	. 
l0be0h:
	inc bc			;0be0	03 	. 
	inc bc			;0be1	03 	. 
	inc b			;0be2	04 	. 
	inc bc			;0be3	03 	. 
	dec b			;0be4	05 	. 
	inc bc			;0be5	03 	. 
	dec b			;0be6	05 	. 
	inc bc			;0be7	03 	. 
	dec b			;0be8	05 	. 
	inc bc			;0be9	03 	. 
	dec b			;0bea	05 	. 
	inc bc			;0beb	03 	. 
	dec b			;0bec	05 	. 
	inc bc			;0bed	03 	. 
	dec b			;0bee	05 	. 
	inc bc			;0bef	03 	. 
	dec b			;0bf0	05 	. 
	inc bc			;0bf1	03 	. 
	dec b			;0bf2	05 	. 
	inc bc			;0bf3	03 	. 
	dec b			;0bf4	05 	. 
	inc bc			;0bf5	03 	. 
	dec b			;0bf6	05 	. 
	inc bc			;0bf7	03 	. 
	dec b			;0bf8	05 	. 
	inc bc			;0bf9	03 	. 
	dec b			;0bfa	05 	. 
	inc b			;0bfb	04 	. 
	dec b			;0bfc	05 	. 
	inc b			;0bfd	04 	. 
	dec b			;0bfe	05 	. 
	inc bc			;0bff	03 	. 
	dec b			;0c00	05 	. 
	inc bc			;0c01	03 	. 
	dec b			;0c02	05 	. 
	inc bc			;0c03	03 	. 
	dec b			;0c04	05 	. 
	dec b			;0c05	05 	. 
	dec b			;0c06	05 	. 
	dec b			;0c07	05 	. 
l0c08h:
	dec c			;0c08	0d 	. 
	inc c			;0c09	0c 	. 
	dec bc			;0c0a	0b 	. 
	ld a,(bc)			;0c0b	0a 	. 
	add hl,bc			;0c0c	09 	. 
	dec bc			;0c0d	0b 	. 
	ld a,(bc)			;0c0e	0a 	. 
	add hl,bc			;0c0f	09 	. 
	ex af,af'			;0c10	08 	. 
	ex af,af'			;0c11	08 	. 
	ld a,(bc)			;0c12	0a 	. 
	add hl,bc			;0c13	09 	. 
	add hl,bc			;0c14	09 	. 
	ex af,af'			;0c15	08 	. 
	rlca			;0c16	07 	. 
	add hl,bc			;0c17	09 	. 
	ex af,af'			;0c18	08 	. 
	ex af,af'			;0c19	08 	. 
	rlca			;0c1a	07 	. 
	rlca			;0c1b	07 	. 
l0c1ch:
	add a,b			;0c1c	80 	. 
	nop			;0c1d	00 	. 
	nop			;0c1e	00 	. 
	inc e			;0c1f	1c 	. 
	nop			;0c20	00 	. 
	jr c,l0c23h		;0c21	38 00 	8 . 
l0c23h:
	ld (hl),b			;0c23	70 	p 
	nop			;0c24	00 	. 
	pop hl			;0c25	e1 	. 
	inc b			;0c26	04 	. 
	inc e			;0c27	1c 	. 
	inc b			;0c28	04 	. 
	jr c,l0c2fh		;0c29	38 04 	8 . 
	ld (hl),b			;0c2b	70 	p 
	inc b			;0c2c	04 	. 
	pop hl			;0c2d	e1 	. 
l0c2eh:
	ld d,(hl)			;0c2e	56 	V 
l0c2fh:
	inc c			;0c2f	0c 	. 
	ld a,c			;0c30	79 	y 
	inc c			;0c31	0c 	. 
	sbc a,h			;0c32	9c 	. 
	inc c			;0c33	0c 	. 
	cp a			;0c34	bf 	. 
	inc c			;0c35	0c 	. 
	jp po,0560ch		;0c36	e2 0c 56 	. . V 
	inc c			;0c39	0c 	. 
	ld a,c			;0c3a	79 	y 
	inc c			;0c3b	0c 	. 
	sbc a,h			;0c3c	9c 	. 
	inc c			;0c3d	0c 	. 
	cp a			;0c3e	bf 	. 
	inc c			;0c3f	0c 	. 
	jp po,0560ch		;0c40	e2 0c 56 	. . V 
	inc c			;0c43	0c 	. 
	ld a,c			;0c44	79 	y 
	inc c			;0c45	0c 	. 
	sbc a,h			;0c46	9c 	. 
	inc c			;0c47	0c 	. 
	cp a			;0c48	bf 	. 
	inc c			;0c49	0c 	. 
	jp po,0560ch		;0c4a	e2 0c 56 	. . V 
	inc c			;0c4d	0c 	. 
	ld a,c			;0c4e	79 	y 
	inc c			;0c4f	0c 	. 
	sbc a,h			;0c50	9c 	. 
	inc c			;0c51	0c 	. 
	cp a			;0c52	bf 	. 
	inc c			;0c53	0c 	. 
	jp po,000ch		;0c54	e2 0c 00 	. . . 
	nop			;0c57	00 	. 
	nop			;0c58	00 	. 
	nop			;0c59	00 	. 
	nop			;0c5a	00 	. 
	nop			;0c5b	00 	. 
	nop			;0c5c	00 	. 
	nop			;0c5d	00 	. 
	nop			;0c5e	00 	. 
	nop			;0c5f	00 	. 
	nop			;0c60	00 	. 
	inc bc			;0c61	03 	. 
	nop			;0c62	00 	. 
	inc b			;0c63	04 	. 
	ld b,d			;0c64	42 	B 
	ld b,e			;0c65	43 	C 
	ld b,e			;0c66	43 	C 
	ld b,d			;0c67	42 	B 
	ld b,h			;0c68	44 	D 
	inc hl			;0c69	23 	# 
	inc (hl)			;0c6a	34 	4 
	ld b,e			;0c6b	43 	C 
	ld b,e			;0c6c	43 	C 
	ld b,e			;0c6d	43 	C 
	inc sp			;0c6e	33 	3 
	inc (hl)			;0c6f	34 	4 
	inc (hl)			;0c70	34 	4 
	ld b,e			;0c71	43 	C 
	ld b,e			;0c72	43 	C 
	inc sp			;0c73	33 	3 
	ld b,e			;0c74	43 	C 
	inc (hl)			;0c75	34 	4 
	ld b,e			;0c76	43 	C 
	jr nc,l0c79h		;0c77	30 00 	0 . 
l0c79h:
	nop			;0c79	00 	. 
	ld h,c			;0c7a	61 	a 
	inc bc			;0c7b	03 	. 
	ld (03000h),hl		;0c7c	22 00 30 	" . 0 
	ld (02740h),a		;0c7f	32 40 27 	2 @ ' 
	inc hl			;0c82	23 	# 
	nop			;0c83	00 	. 
	inc hl			;0c84	23 	# 
	ld (de),a			;0c85	12 	. 
	ld (hl),e			;0c86	73 	s 
	ld (02703h),a		;0c87	32 03 27 	2 . ' 
	jr nz,$+117		;0c8a	20 73 	  s 
	ld (l0371h),a		;0c8c	32 71 03 	2 q . 
	ld (bc),a			;0c8f	02 	. 
	ld d,d			;0c90	52 	R 
	ld (02175h),a		;0c91	32 75 21 	2 u ! 
	ld h,e			;0c94	63 	c 
	nop			;0c95	00 	. 
	nop			;0c96	00 	. 
	nop			;0c97	00 	. 
	nop			;0c98	00 	. 
	nop			;0c99	00 	. 
	nop			;0c9a	00 	. 
	nop			;0c9b	00 	. 
	nop			;0c9c	00 	. 
	nop			;0c9d	00 	. 
	nop			;0c9e	00 	. 
	nop			;0c9f	00 	. 
	nop			;0ca0	00 	. 
	nop			;0ca1	00 	. 
	nop			;0ca2	00 	. 
	nop			;0ca3	00 	. 
	nop			;0ca4	00 	. 
	nop			;0ca5	00 	. 
	nop			;0ca6	00 	. 
	nop			;0ca7	00 	. 
	nop			;0ca8	00 	. 
	inc (hl)			;0ca9	34 	4 
	ld b,l			;0caa	45 	E 
	inc de			;0cab	13 	. 
	rla			;0cac	17 	. 
	rla			;0cad	17 	. 
	ld (hl),e			;0cae	73 	s 
	ld hl,l2737h		;0caf	21 37 27 	! 7 ' 
	ld (l3763h),a		;0cb2	32 63 37 	2 c 7 
	inc (hl)			;0cb5	34 	4 
	ld (02243h),a		;0cb6	32 43 22 	2 C " 
	ld (02342h),a		;0cb9	32 42 23 	2 B # 
	inc hl			;0cbc	23 	# 
	jr nz,l0cbfh		;0cbd	20 00 	  . 
l0cbfh:
	ld bc,00323h		;0cbf	01 23 03 	. # . 
	dec h			;0cc2	25 	% 
	nop			;0cc3	00 	. 
	ld (hl),b			;0cc4	70 	p 
	ld d,031h		;0cc5	16 31 	. 1 
	ld b,031h		;0cc7	06 31 	. 1 
	nop			;0cc9	00 	. 
	dec h			;0cca	25 	% 
	inc de			;0ccb	13 	. 
	ld d,h			;0ccc	54 	T 
	inc hl			;0ccd	23 	# 
	nop			;0cce	00 	. 
	rlca			;0ccf	07 	. 
	ld (de),a			;0cd0	12 	. 
	ld h,e			;0cd1	63 	c 
	ld h,c			;0cd2	61 	a 
	ld h,c			;0cd3	61 	a 
	daa			;0cd4	27 	' 
	ld (de),a			;0cd5	12 	. 
	ld d,(hl)			;0cd6	56 	V 
	ld (hl),d			;0cd7	72 	r 
	ld d,021h		;0cd8	16 21 	. ! 
	ld d,d			;0cda	52 	R 
	nop			;0cdb	00 	. 
	nop			;0cdc	00 	. 
	nop			;0cdd	00 	. 
	nop			;0cde	00 	. 
	nop			;0cdf	00 	. 
	nop			;0ce0	00 	. 
	nop			;0ce1	00 	. 
	nop			;0ce2	00 	. 
	nop			;0ce3	00 	. 
	nop			;0ce4	00 	. 
	nop			;0ce5	00 	. 
	nop			;0ce6	00 	. 
	nop			;0ce7	00 	. 
	nop			;0ce8	00 	. 
	nop			;0ce9	00 	. 
	nop			;0cea	00 	. 
	nop			;0ceb	00 	. 
	nop			;0cec	00 	. 
	ld b,000h		;0ced	06 00 	. . 
	inc bc			;0cef	03 	. 
	ld sp,02321h		;0cf0	31 21 23 	1 ! # 
	rla			;0cf3	17 	. 
	ld h,e			;0cf4	63 	c 
	ld h,c			;0cf5	61 	a 
	ld (07225h),a		;0cf6	32 25 72 	2 % r 
	ld d,e			;0cf9	53 	S 
	daa			;0cfa	27 	' 
	ld (03115h),a		;0cfb	32 15 31 	2 . 1 
	ld b,021h		;0cfe	06 21 	. ! 
	ld (hl),e			;0d00	73 	s 
	ld d,013h		;0d01	16 13 	. . 
	ld d,b			;0d03	50 	P 
	nop			;0d04	00 	. 
sub_0d05h:
	ld a,(0e910h)		;0d05	3a 10 e9 	: . . 
	and 001h		;0d08	e6 01 	. . 
	in a,(001h)		;0d0a	db 01 	. . 
	jr z,l0d10h		;0d0c	28 02 	( . 
	in a,(002h)		;0d0e	db 02 	. . 
l0d10h:
	ld hl,(0e906h)		;0d10	2a 06 e9 	* . . 
	call sub_0d3bh		;0d13	cd 3b 0d 	. ; . 
	ld (0e906h),hl		;0d16	22 06 e9 	" . . 
	ld hl,0e908h		;0d19	21 08 e9 	! . . 
	rla			;0d1c	17 	. 
	rl (hl)		;0d1d	cb 16 	. . 
	rla			;0d1f	17 	. 
	rla			;0d20	17 	. 
	rl (hl)		;0d21	cb 16 	. . 
	rla			;0d23	17 	. 
	rla			;0d24	17 	. 
	rl (hl)		;0d25	cb 16 	. . 
	in a,(000h)		;0d27	db 00 	. . 
	and 00fh		;0d29	e6 0f 	. . 
	ld b,a			;0d2b	47 	G 
	in a,(002h)		;0d2c	db 02 	. . 
	and 010h		;0d2e	e6 10 	. . 
	or b			;0d30	b0 	. 
	ld hl,(0e904h)		;0d31	2a 04 e9 	* . . 
	call sub_0d3bh		;0d34	cd 3b 0d 	. ; . 
	ld (0e904h),hl		;0d37	22 04 e9 	" . . 
	ret			;0d3a	c9 	. 
sub_0d3bh:
	cpl			;0d3b	2f 	/ 
	ld b,a			;0d3c	47 	G 
	xor h			;0d3d	ac 	. 
	ld c,a			;0d3e	4f 	O 
	and l			;0d3f	a5 	. 
	ld l,a			;0d40	6f 	o 
	ld a,c			;0d41	79 	y 
	cpl			;0d42	2f 	/ 
	and h			;0d43	a4 	. 
	or l			;0d44	b5 	. 
	ld l,a			;0d45	6f 	o 
	ld h,b			;0d46	60 	` 
	ret			;0d47	c9 	. 
sub_0d48h:
	rrca			;0d48	0f 	. 
	rrca			;0d49	0f 	. 
	rrca			;0d4a	0f 	. 
	ld b,a			;0d4b	47 	G 
	ld a,(0e911h)		;0d4c	3a 11 e9 	: . . 
	rla			;0d4f	17 	. 
	ld c,a			;0d50	4f 	O 
	and 049h		;0d51	e6 49 	. I 
	cp 049h		;0d53	fe 49 	. I 
	jr nz,l0d61h		;0d55	20 0a 	  . 
	ld hl,0e914h		;0d57	21 14 e9 	! . . 
	inc (hl)			;0d5a	34 	4 
	ld a,(hl)			;0d5b	7e 	~ 
	and 00fh		;0d5c	e6 0f 	. . 
	call z,sub_0dd6h		;0d5e	cc d6 0d 	. . . 
l0d61h:
	ld hl,0e90ch		;0d61	21 0c e9 	! . . 
	ld de,0e90ah		;0d64	11 0a e9 	. . . 
	call sub_0db1h		;0d67	cd b1 0d 	. . . 
	ld hl,0e90eh		;0d6a	21 0e e9 	! . . 
	inc de			;0d6d	13 	. 
	call sub_0db1h		;0d6e	cd b1 0d 	. . . 
	ld hl,0e911h		;0d71	21 11 e9 	! . . 
	ld (hl),c			;0d74	71 	q 
	dec hl			;0d75	2b 	+ 
	ld c,(hl)			;0d76	4e 	N 
	dec hl			;0d77	2b 	+ 
	ld b,004h		;0d78	06 04 	. . 
	call sub_0da2h		;0d7a	cd a2 0d 	. . . 
	ld hl,0e90dh		;0d7d	21 0d e9 	! . . 
	ld b,002h		;0d80	06 02 	. . 
	call sub_0da2h		;0d82	cd a2 0d 	. . . 
	ld a,c			;0d85	79 	y 
	ld (0e910h),a		;0d86	32 10 e9 	2 . . 
	out (001h),a		;0d89	d3 01 	. . 
	in a,(004h)		;0d8b	db 04 	. . 
	cpl			;0d8d	2f 	/ 
	xor c			;0d8e	a9 	. 
	and 001h		;0d8f	e6 01 	. . 
	jr z,l0d94h		;0d91	28 01 	( . 
	inc a			;0d93	3c 	< 
l0d94h:
	ld (0e916h),a		;0d94	32 16 e9 	2 . . 
	ld a,(0e90ah)		;0d97	3a 0a e9 	: . . 
	and a			;0d9a	a7 	. 
	ret nz			;0d9b	c0 	. 
	ld a,002h		;0d9c	3e 02 	> . 
	ld (0e913h),a		;0d9e	32 13 e9 	2 . . 
	ret			;0da1	c9 	. 
sub_0da2h:
	dec (hl)			;0da2	35 	5 
	ret p			;0da3	f0 	. 
	ld (hl),00ch		;0da4	36 0c 	6 . 
	dec hl			;0da6	2b 	+ 
	ld a,(hl)			;0da7	7e 	~ 
	and a			;0da8	a7 	. 
	ret z			;0da9	c8 	. 
	ld a,b			;0daa	78 	x 
	xor c			;0dab	a9 	. 
	ld c,a			;0dac	4f 	O 
	and b			;0dad	a0 	. 
	ret nz			;0dae	c0 	. 
	dec (hl)			;0daf	35 	5 
	ret			;0db0	c9 	. 
sub_0db1h:
	rrc b		;0db1	cb 08 	. . 
	rl c		;0db3	cb 11 	. . 
	ld a,c			;0db5	79 	y 
	and 049h		;0db6	e6 49 	. I 
	cp 001h		;0db8	fe 01 	. . 
	ret nz			;0dba	c0 	. 
	inc (hl)			;0dbb	34 	4 
	ld a,(0e006h)		;0dbc	3a 06 e0 	: . . 
	and a			;0dbf	a7 	. 
	ld a,001h		;0dc0	3e 01 	> . 
	call z,sub_0dfeh		;0dc2	cc fe 0d 	. . . 
	ld a,(de)			;0dc5	1a 	. 
	cp 001h		;0dc6	fe 01 	. . 
	jr z,l0ddah		;0dc8	28 10 	( . 
	cp 008h		;0dca	fe 08 	. . 
	jr nc,l0dd8h		;0dcc	30 0a 	0 . 
	ld hl,0e912h		;0dce	21 12 e9 	! . . 
	inc (hl)			;0dd1	34 	4 
	cp (hl)			;0dd2	be 	. 
	ret nz			;0dd3	c0 	. 
	ld (hl),000h		;0dd4	36 00 	6 . 
sub_0dd6h:
	ld a,009h		;0dd6	3e 09 	> . 
l0dd8h:
	sub 008h		;0dd8	d6 08 	. . 
l0ddah:
	ld hl,0e913h		;0dda	21 13 e9 	! . . 
	add a,(hl)			;0ddd	86 	. 
	daa			;0dde	27 	' 
	jr nc,l0de3h		;0ddf	30 02 	0 . 
	ld a,099h		;0de1	3e 99 	> . 
l0de3h:
	ld (hl),a			;0de3	77 	w 
	ret			;0de4	c9 	. 
sub_0de5h:
	ld hl,0e917h		;0de5	21 17 e9 	! . . 
	ld a,(hl)			;0de8	7e 	~ 
	and a			;0de9	a7 	. 
	ret z			;0dea	c8 	. 
	dec (hl)			;0deb	35 	5 
	inc hl			;0dec	23 	# 
	ld a,(hl)			;0ded	7e 	~ 
	out (000h),a		;0dee	d3 00 	. . 
	or 080h		;0df0	f6 80 	. . 
	out (000h),a		;0df2	d3 00 	. . 
	inc hl			;0df4	23 	# 
	ld de,0e918h		;0df5	11 18 e9 	. . . 
	ld bc,00fh		;0df8	01 0f 00 	. . . 
	ldir		;0dfb	ed b0 	. . 
	ret			;0dfd	c9 	. 
sub_0dfeh:
	push hl			;0dfe	e5 	. 
	push de			;0dff	d5 	. 
	ld d,a			;0e00	57 	W 
	bit 7,d		;0e01	cb 7a 	. z 
	jr z,l0e0dh		;0e03	28 08 	( . 
	ld a,(0e006h)		;0e05	3a 06 e0 	: . . 
	and a			;0e08	a7 	. 
	jr z,l0e1dh		;0e09	28 12 	( . 
	res 7,d		;0e0b	cb ba 	. . 
l0e0dh:
	ld hl,0e917h		;0e0d	21 17 e9 	! . . 
	ld a,(hl)			;0e10	7e 	~ 
	cp 010h		;0e11	fe 10 	. . 
	jr nc,l0e1dh		;0e13	30 08 	0 . 
	inc (hl)			;0e15	34 	4 
	inc hl			;0e16	23 	# 
	ld e,a			;0e17	5f 	_ 
	ld a,d			;0e18	7a 	z 
	ld d,000h		;0e19	16 00 	. . 
	add hl,de			;0e1b	19 	. 
	ld (hl),a			;0e1c	77 	w 
l0e1dh:
	pop de			;0e1d	d1 	. 
	pop hl			;0e1e	e1 	. 
	ret			;0e1f	c9 	. 
l0e20h:
	push hl			;0e20	e5 	. 
	ld c,a			;0e21	4f 	O 
	ld a,(0eb00h)		;0e22	3a 00 eb 	: . . 
	ld b,a			;0e25	47 	G 
	ld iy,(0eb01h)		;0e26	fd 2a 01 eb 	. * . . 
	bit 6,c		;0e2a	cb 71 	. q 
	ld hl,l0020h		;0e2c	21 20 00 	!   . 
	jr nz,l0e34h		;0e2f	20 03 	  . 
	ld hl,0ffd0h		;0e31	21 d0 ff 	! . . 
l0e34h:
	add hl,de			;0e34	19 	. 
	ld (0e805h),hl		;0e35	22 05 e8 	" . . 
	pop hl			;0e38	e1 	. 
	dec b			;0e39	05 	. 
	inc b			;0e3a	04 	. 
	ret z			;0e3b	c8 	. 
l0e3ch:
	ld a,(hl)			;0e3c	7e 	~ 
	inc a			;0e3d	3c 	< 
	jr z,l0e92h		;0e3e	28 52 	( R 
	ld a,(0e805h)		;0e40	3a 05 e8 	: . . 
	bit 6,c		;0e43	cb 71 	. q 
	jr nz,l0e52h		;0e45	20 0b 	  . 
	add a,(hl)			;0e47	86 	. 
	ld (iy+006h),a		;0e48	fd 77 06 	. w . 
	ld a,(0e806h)		;0e4b	3a 06 e8 	: . . 
	adc a,000h		;0e4e	ce 00 	. . 
	jr l0e5bh		;0e50	18 09 	. . 
l0e52h:
	sub (hl)			;0e52	96 	. 
	ld (iy+006h),a		;0e53	fd 77 06 	. w . 
	ld a,(0e806h)		;0e56	3a 06 e8 	: . . 
	sbc a,000h		;0e59	de 00 	. . 
l0e5bh:
	ld (iy+007h),a		;0e5b	fd 77 07 	. w . 
	inc hl			;0e5e	23 	# 
	ld a,(0e916h)		;0e5f	3a 16 e9 	: . . 
	ld e,a			;0e62	5f 	_ 
	ld a,(hl)			;0e63	7e 	~ 
	sub e			;0e64	93 	. 
	ld e,a			;0e65	5f 	_ 
	ld a,(0e807h)		;0e66	3a 07 e8 	: . . 
	add a,e			;0e69	83 	. 
	ld (iy+002h),a		;0e6a	fd 77 02 	. w . 
	ld a,(0e808h)		;0e6d	3a 08 e8 	: . . 
	adc a,000h		;0e70	ce 00 	. . 
	ld (iy+003h),a		;0e72	fd 77 03 	. w . 
	inc hl			;0e75	23 	# 
	ld a,(hl)			;0e76	7e 	~ 
	and 01fh		;0e77	e6 1f 	. . 
	ld (iy+000h),a		;0e79	fd 77 00 	. w . 
	ld a,(hl)			;0e7c	7e 	~ 
	rlca			;0e7d	07 	. 
	rlca			;0e7e	07 	. 
	and 003h		;0e7f	e6 03 	. . 
	or c			;0e81	b1 	. 
	ld (iy+005h),a		;0e82	fd 77 05 	. w . 
	inc hl			;0e85	23 	# 
	ld a,(hl)			;0e86	7e 	~ 
	ld (iy+004h),a		;0e87	fd 77 04 	. w . 
	ld de,0006h+2		;0e8a	11 08 00 	. . . 
	add iy,de		;0e8d	fd 19 	. . 
	inc hl			;0e8f	23 	# 
	djnz l0e3ch		;0e90	10 aa 	. . 
l0e92h:
	ld (0eb01h),iy		;0e92	fd 22 01 eb 	. " . . 
	ld a,b			;0e96	78 	x 
	ld (0eb00h),a		;0e97	32 00 eb 	2 . . 
	ret			;0e9a	c9 	. 
sub_0e9bh:
	ld hl,059a7h		;0e9b	21 a7 59 	! . Y 
	call sub_111ch		;0e9e	cd 1c 11 	. . . 
	call sub_10a5h		;0ea1	cd a5 10 	. . . 
	call sub_10abh		;0ea4	cd ab 10 	. . . 
	call sub_10cfh		;0ea7	cd cf 10 	. . . 
	call sub_10d9h		;0eaa	cd d9 10 	. . . 
	call sub_10e6h		;0ead	cd e6 10 	. . . 
	ld a,(0e81ch)		;0eb0	3a 1c e8 	: . . 
	and a			;0eb3	a7 	. 
	call z,sub_0f1ah		;0eb4	cc 1a 0f 	. . . 
	ld a,003h		;0eb7	3e 03 	> . 
	ld (0e881h),a		;0eb9	32 81 e8 	2 . . 
	ld a,(0e709h)		;0ebc	3a 09 e7 	: . . 
	ld (0e81ah),a		;0ebf	32 1a e8 	2 . . 
	ld a,(0e2e2h)		;0ec2	3a e2 e2 	: . . 
	ld (0e819h),a		;0ec5	32 19 e8 	2 . . 
	call sub_0f78h		;0ec8	cd 78 0f 	. x . 
	call sub_0f6bh		;0ecb	cd 6b 0f 	. k . 
	ld de,0d0a0h		;0ece	11 a0 d0 	. . . 
	ld bc,l0594h		;0ed1	01 94 05 	. . . 
	ld a,0a1h		;0ed4	3e a1 	> . 
l0ed6h:
	call sub_1110h		;0ed6	cd 10 11 	. . . 
	inc a			;0ed9	3c 	< 
	inc de			;0eda	13 	. 
	djnz l0ed6h		;0edb	10 f9 	. . 
	ld a,(0e080h)		;0edd	3a 80 e0 	: . . 
	and 007h		;0ee0	e6 07 	. . 
	inc a			;0ee2	3c 	< 
	ld h,a			;0ee3	67 	g 
	ld a,0a6h		;0ee4	3e a6 	> . 
	ld de,0d0e0h		;0ee6	11 e0 d0 	. . . 
	call sub_0f0ah		;0ee9	cd 0a 0f 	. . . 
	inc a			;0eec	3c 	< 
	ld de,0d120h		;0eed	11 20 d1 	.   . 
	call sub_0f0ah		;0ef0	cd 0a 0f 	. . . 
	ld de,0d0e1h		;0ef3	11 e1 d0 	. . . 
	ld c,094h		;0ef6	0e 94 	. . 
	ld a,0a8h		;0ef8	3e a8 	> . 
	call sub_0f01h		;0efa	cd 01 0f 	. . . 
	ld de,0d121h		;0efd	11 21 d1 	. ! . 
	inc a			;0f00	3c 	< 
sub_0f01h:
	ld b,004h		;0f01	06 04 	. . 
l0f03h:
	call sub_1110h		;0f03	cd 10 11 	. . . 
	inc de			;0f06	13 	. 
	djnz l0f03h		;0f07	10 fa 	. . 
	ret			;0f09	c9 	. 
sub_0f0ah:
	ld l,h			;0f0a	6c 	l 
	ld b,005h		;0f0b	06 05 	. . 
	ld c,094h		;0f0d	0e 94 	. . 
l0f0fh:
	call sub_1110h		;0f0f	cd 10 11 	. . . 
	inc de			;0f12	13 	. 
	dec l			;0f13	2d 	- 
	jr nz,l0f17h		;0f14	20 01 	  . 
	inc c			;0f16	0c 	. 
l0f17h:
	djnz l0f0fh		;0f17	10 f6 	. . 
	ret			;0f19	c9 	. 
sub_0f1ah:
	ld a,(0e080h)		;0f1a	3a 80 e0 	: . . 
	and 0f8h		;0f1d	e6 f8 	. . 
	rrca			;0f1f	0f 	. 
	rrca			;0f20	0f 	. 
	rrca			;0f21	0f 	. 
	ld b,a			;0f22	47 	G 
	in a,(003h)		;0f23	db 03 	. . 
	and 001h		;0f25	e6 01 	. . 
	jr nz,l0f2ah		;0f27	20 01 	  . 
	dec b			;0f29	05 	. 
l0f2ah:
	ld a,b			;0f2a	78 	x 
	and a			;0f2b	a7 	. 
	ret z			;0f2c	c8 	. 
	cp 003h		;0f2d	fe 03 	. . 
	jr c,l0f33h		;0f2f	38 02 	8 . 
	ld a,003h		;0f31	3e 03 	> . 
l0f33h:
	ld b,a			;0f33	47 	G 
	ld c,080h		;0f34	0e 80 	. . 
	ld de,0d129h		;0f36	11 29 d1 	. ) . 
l0f39h:
	call sub_0f3fh		;0f39	cd 3f 0f 	. ? . 
	djnz l0f39h		;0f3c	10 fb 	. . 
	ret			;0f3e	c9 	. 
sub_0f3fh:
	ld a,0b8h		;0f3f	3e b8 	> . 
	call sub_0f4fh		;0f41	cd 4f 0f 	. O . 
	push de			;0f44	d5 	. 
	ld hl,0003eh		;0f45	21 3e 00 	! > . 
	add hl,de			;0f48	19 	. 
	ex de,hl			;0f49	eb 	. 
	call sub_0f4fh		;0f4a	cd 4f 0f 	. O . 
	pop de			;0f4d	d1 	. 
	ret			;0f4e	c9 	. 
sub_0f4fh:
	call sub_1110h		;0f4f	cd 10 11 	. . . 
	inc a			;0f52	3c 	< 
	call sub_1110h		;0f53	cd 10 11 	. . . 
	inc a			;0f56	3c 	< 
	ret			;0f57	c9 	. 
sub_0f58h:
	ld de,0d129h		;0f58	11 29 d1 	. ) . 
	xor a			;0f5b	af 	. 
	ld c,a			;0f5c	4f 	O 
	call sub_0f63h		;0f5d	cd 63 0f 	. c . 
	ld de,0d169h		;0f60	11 69 d1 	. i . 
sub_0f63h:
	ld b,006h		;0f63	06 06 	. . 
l0f65h:
	call sub_1110h		;0f65	cd 10 11 	. . . 
	djnz l0f65h		;0f68	10 fb 	. . 
	ret			;0f6a	c9 	. 
sub_0f6bh:
	ld de,0d116h		;0f6b	11 16 d1 	. . . 
	ld hl,0e819h		;0f6e	21 19 e8 	! . . 
	ld a,(0e2e2h)		;0f71	3a e2 e2 	: . . 
	ld c,015h		;0f74	0e 15 	. . 
	jr l0f83h		;0f76	18 0b 	. . 
sub_0f78h:
	ld de,0d096h		;0f78	11 96 d0 	. . . 
	ld hl,0e81ah		;0f7b	21 1a e8 	! . . 
	ld a,(0e709h)		;0f7e	3a 09 e7 	: . . 
	ld c,014h		;0f81	0e 14 	. . 
l0f83h:
	sub (hl)			;0f83	96 	. 
	jp m,l0f8fh		;0f84	fa 8f 0f 	. . . 
	cp 003h		;0f87	fe 03 	. . 
	jr c,l0f95h		;0f89	38 0a 	8 . 
	ld a,003h		;0f8b	3e 03 	> . 
	jr l0f95h		;0f8d	18 06 	. . 
l0f8fh:
	cp 0fdh		;0f8f	fe fd 	. . 
	jr nc,l0f95h		;0f91	30 02 	0 . 
	ld a,0fdh		;0f93	3e fd 	> . 
l0f95h:
	add a,(hl)			;0f95	86 	. 
	ld (hl),a			;0f96	77 	w 
	ld b,008h		;0f97	06 08 	. . 
l0f99h:
	sub 008h		;0f99	d6 08 	. . 
	ld l,a			;0f9b	6f 	o 
	jr c,l0fa3h		;0f9c	38 05 	8 . 
	jp m,l0fadh		;0f9e	fa ad 0f 	. . . 
	ld a,08ah		;0fa1	3e 8a 	> . 
l0fa3h:
	add a,078h		;0fa3	c6 78 	. x 
	cp 077h		;0fa5	fe 77 	. w 
	jr nz,l0fb1h		;0fa7	20 08 	  . 
	ld a,002h		;0fa9	3e 02 	> . 
	jr l0fb1h		;0fab	18 04 	. . 
l0fadh:
	ld l,0ffh		;0fad	2e ff 	. . 
	ld a,003h		;0faf	3e 03 	> . 
l0fb1h:
	call sub_1110h		;0fb1	cd 10 11 	. . . 
	ld a,l			;0fb4	7d 	} 
	djnz l0f99h		;0fb5	10 e2 	. . 
	ret			;0fb7	c9 	. 
sub_0fb8h:
	ld a,(0e000h)		;0fb8	3a 00 e0 	: . . 
	cp 003h		;0fbb	fe 03 	. . 
	jr z,sub_0fe3h		;0fbd	28 24 	( $ 
	ld hl,(0e003h)		;0fbf	2a 03 e0 	* . . 
	ld de,0fccdh		;0fc2	11 cd fc 	. . . 
	add hl,de			;0fc5	19 	. 
	jr c,sub_0fe3h		;0fc6	38 1b 	8 . 
	ld hl,0e008h		;0fc8	21 08 e0 	! . . 
	ld a,(hl)			;0fcb	7e 	~ 
	and a			;0fcc	a7 	. 
	jr nz,l0fd5h		;0fcd	20 06 	  . 
	ld a,000h		;0fcf	3e 00 	> . 
	call sub_0dfeh		;0fd1	cd fe 0d 	. . . 
	inc (hl)			;0fd4	34 	4 
l0fd5h:
	ld hl,0e885h		;0fd5	21 85 e8 	! . . 
	ld a,(hl)			;0fd8	7e 	~ 
	and a			;0fd9	a7 	. 
	jr nz,sub_0fe3h		;0fda	20 07 	  . 
	ld (hl),038h		;0fdc	36 38 	6 8 
	ld a,097h		;0fde	3e 97 	> . 
	call sub_0dfeh		;0fe0	cd fe 0d 	. . . 
sub_0fe3h:
	ld hl,0e81bh		;0fe3	21 1b e8 	! . . 
	ld a,(0e880h)		;0fe6	3a 80 e8 	: . . 
	cp (hl)			;0fe9	be 	. 
	jr z,l103ah		;0fea	28 4e 	( N 
	ld (hl),a			;0fec	77 	w 
	call sub_0f78h		;0fed	cd 78 0f 	. x . 
	call sub_0f6bh		;0ff0	cd 6b 0f 	. k . 
	ld hl,0d0e0h		;0ff3	21 e0 d0 	! . . 
	ld a,(0e080h)		;0ff6	3a 80 e0 	: . . 
	and 007h		;0ff9	e6 07 	. . 
	add a,a			;0ffb	87 	. 
	ld e,a			;0ffc	5f 	_ 
	ld d,000h		;0ffd	16 00 	. . 
	add hl,de			;0fff	19 	. 
l1000h:
	ld a,(0e880h)		;1000	3a 80 e8 	: . . 
	set 3,h		;1003	cb dc 	. . 
	ld a,(0e880h)		;1005	3a 80 e8 	: . . 
	and 018h		;1008	e6 18 	. . 
	ld a,095h		;100a	3e 95 	> . 
	jr z,l100fh		;100c	28 01 	( . 
	dec a			;100e	3d 	= 
l100fh:
	ld (hl),a			;100f	77 	w 
	ld de,l0040h		;1010	11 40 00 	. @ . 
	add hl,de			;1013	19 	. 
	ld (hl),a			;1014	77 	w 
	ld a,(0e81ch)		;1015	3a 1c e8 	: . . 
	and a			;1018	a7 	. 
	jr nz,l105ah		;1019	20 3f 	  ? 
	ld b,a			;101b	47 	G 
	in a,(003h)		;101c	db 03 	. . 
	and 001h		;101e	e6 01 	. . 
	ld a,(0e080h)		;1020	3a 80 e0 	: . . 
	jr nz,l1027h		;1023	20 02 	  . 
	sub 008h		;1025	d6 08 	. . 
l1027h:
	cp 020h		;1027	fe 20 	.   
	jr c,l103ah		;1029	38 0f 	8 . 
	ld a,(0e880h)		;102b	3a 80 e8 	: . . 
	and 018h		;102e	e6 18 	. . 
	jr z,l1037h		;1030	28 05 	( . 
	call sub_0f1ah		;1032	cd 1a 0f 	. . . 
	jr l103ah		;1035	18 03 	. . 
l1037h:
	call sub_0f58h		;1037	cd 58 0f 	. X . 
l103ah:
	ld a,(0e085h)		;103a	3a 85 e0 	: . . 
	and 001h		;103d	e6 01 	. . 
	jr nz,l105ah		;103f	20 19 	  . 
	ld hl,(0e081h)		;1041	2a 81 e0 	* . . 
	ld de,05000h		;1044	11 00 50 	. . P 
	sbc hl,de		;1047	ed 52 	. R 
	jr c,l105ah		;1049	38 0f 	8 . 
	ld hl,0e085h		;104b	21 85 e0 	! . . 
	set 0,(hl)		;104e	cb c6 	. . 
	dec hl			;1050	2b 	+ 
	inc (hl)			;1051	34 	4 
	ld a,098h		;1052	3e 98 	> . 
	call sub_0dfeh		;1054	cd fe 0d 	. . . 
	call sub_10e6h		;1057	cd e6 10 	. . . 
l105ah:
	ld a,(0e000h)		;105a	3a 00 e0 	: . . 
	cp 003h		;105d	fe 03 	. . 
	jr z,l1080h		;105f	28 1f 	( . 
	cp 00ch		;1061	fe 0c 	. . 
	jr z,l1080h		;1063	28 1b 	( . 
	ld hl,0e881h		;1065	21 81 e8 	! . . 
	ld a,(hl)			;1068	7e 	~ 
	and a			;1069	a7 	. 
	jr nz,l1080h		;106a	20 14 	  . 
	ld (hl),003h		;106c	36 03 	6 . 
	ld hl,(0e003h)		;106e	2a 03 e0 	* . . 
	ld a,l			;1071	7d 	} 
	sub 001h		;1072	d6 01 	. . 
	daa			;1074	27 	' 
	ld l,a			;1075	6f 	o 
	ld a,h			;1076	7c 	| 
	sbc a,000h		;1077	de 00 	. . 
	daa			;1079	27 	' 
	ld h,a			;107a	67 	g 
	jr c,l1080h		;107b	38 03 	8 . 
	ld (0e003h),hl		;107d	22 03 e0 	" . . 
l1080h:
	call sub_10d9h		;1080	cd d9 10 	. . . 
	ld a,(0e083h)		;1083	3a 83 e0 	: . . 
	ld c,a			;1086	4f 	O 
	ld de,(0e081h)		;1087	ed 5b 81 e0 	. [ . . 
	ld a,(0e982h)		;108b	3a 82 e9 	: . . 
	ld hl,(0e980h)		;108e	2a 80 e9 	* . . 
	sub c			;1091	91 	. 
	jr c,l109ah		;1092	38 06 	8 . 
	jr nz,sub_10a5h		;1094	20 0f 	  . 
	sbc hl,de		;1096	ed 52 	. R 
	jr nc,sub_10a5h		;1098	30 0b 	0 . 
l109ah:
	ld a,c			;109a	79 	y 
	ld (0e982h),a		;109b	32 82 e9 	2 . . 
	ld (0e980h),de		;109e	ed 53 80 e9 	. S . . 
	call sub_10cfh		;10a2	cd cf 10 	. . . 
sub_10a5h:
	xor a			;10a5	af 	. 
	ld de,0e083h		;10a6	11 83 e0 	. . . 
	jr l10b0h		;10a9	18 05 	. . 
sub_10abh:
	ld a,001h		;10ab	3e 01 	> . 
	ld de,0e093h		;10ad	11 93 e0 	. . . 
l10b0h:
	ld hl,0e002h		;10b0	21 02 e0 	! . . 
	xor (hl)			;10b3	ae 	. 
	ex de,hl			;10b4	eb 	. 
	and 001h		;10b5	e6 01 	. . 
	ld de,0d029h		;10b7	11 29 d0 	. ) . 
	jr nz,l10bfh		;10ba	20 03 	  . 
	ld de,0d014h		;10bc	11 14 d0 	. . . 
l10bfh:
	ld c,015h		;10bf	0e 15 	. . 
l10c1h:
	ld a,(hl)			;10c1	7e 	~ 
	dec hl			;10c2	2b 	+ 
	call sub_1108h		;10c3	cd 08 11 	. . . 
	call sub_10fdh		;10c6	cd fd 10 	. . . 
	call sub_10fdh		;10c9	cd fd 10 	. . . 
	xor a			;10cc	af 	. 
	jr sub_1108h		;10cd	18 39 	. 9 
sub_10cfh:
	ld hl,0e982h		;10cf	21 82 e9 	! . . 
	ld de,0d01fh		;10d2	11 1f d0 	. . . 
	ld c,000h		;10d5	0e 00 	. . 
	jr l10c1h		;10d7	18 e8 	. . 
sub_10d9h:
	ld c,014h		;10d9	0e 14 	. . 
	ld hl,0e004h		;10db	21 04 e0 	! . . 
	ld de,0d0eah		;10de	11 ea d0 	. . . 
	call sub_10fdh		;10e1	cd fd 10 	. . . 
	jr sub_10fdh		;10e4	18 17 	. . 
sub_10e6h:
	ld a,(0e084h)		;10e6	3a 84 e0 	: . . 
	ld de,0d162h		;10e9	11 62 d1 	. b . 
	ld l,a			;10ec	6f 	o 
	ld b,007h		;10ed	06 07 	. . 
	ld c,003h		;10ef	0e 03 	. . 
	ld a,0feh		;10f1	3e fe 	> . 
l10f3h:
	dec l			;10f3	2d 	- 
	jr nz,l10f7h		;10f4	20 01 	  . 
	xor a			;10f6	af 	. 
l10f7h:
	call sub_1110h		;10f7	cd 10 11 	. . . 
	djnz l10f3h		;10fa	10 f7 	. . 
	ret			;10fc	c9 	. 
sub_10fdh:
	ld a,(hl)			;10fd	7e 	~ 
	dec hl			;10fe	2b 	+ 
	push af			;10ff	f5 	. 
l1100h:
	rrca			;1100	0f 	. 
	rrca			;1101	0f 	. 
	rrca			;1102	0f 	. 
	rrca			;1103	0f 	. 
	call sub_1108h		;1104	cd 08 11 	. . . 
	pop af			;1107	f1 	. 
sub_1108h:
	and 00fh		;1108	e6 0f 	. . 
	add a,090h		;110a	c6 90 	. . 
	daa			;110c	27 	' 
	adc a,040h		;110d	ce 40 	. @ 
	daa			;110f	27 	' 
sub_1110h:
	ex de,hl			;1110	eb 	. 
	ld (hl),a			;1111	77 	w 
	set 3,h		;1112	cb dc 	. . 
	ld (hl),c			;1114	71 	q 
	res 3,h		;1115	cb 9c 	. . 
	inc hl			;1117	23 	# 
	ex de,hl			;1118	eb 	. 
	ret			;1119	c9 	. 
l111ah:
	ld c,(hl)			;111a	4e 	N 
l111bh:
	inc hl			;111b	23 	# 
sub_111ch:
	ld a,(hl)			;111c	7e 	~ 
	inc hl			;111d	23 	# 
	inc a			;111e	3c 	< 
	ret z			;111f	c8 	. 
	inc a			;1120	3c 	< 
	jr z,l111ah		;1121	28 f7 	( . 
	inc a			;1123	3c 	< 
	jr z,l112dh		;1124	28 07 	( . 
	sub 003h		;1126	d6 03 	. . 
	call sub_1110h		;1128	cd 10 11 	. . . 
	jr sub_111ch		;112b	18 ef 	. . 
l112dh:
	ld e,(hl)			;112d	5e 	^ 
	inc hl			;112e	23 	# 
	ld d,(hl)			;112f	56 	V 
	jr l111bh		;1130	18 e9 	. . 
l1132h:
	ld c,(hl)			;1132	4e 	N 
l1133h:
	inc hl			;1133	23 	# 
l1134h:
	ld a,(hl)			;1134	7e 	~ 
	inc hl			;1135	23 	# 
	inc a			;1136	3c 	< 
	ret z			;1137	c8 	. 
	inc a			;1138	3c 	< 
	jr z,l1132h		;1139	28 f7 	( . 
	inc a			;113b	3c 	< 
	jr z,l114eh		;113c	28 10 	( . 
	sub 003h		;113e	d6 03 	. . 
	call sub_1110h		;1140	cd 10 11 	. . . 
	cp 020h		;1143	fe 20 	.   
	jr nz,l1134h		;1145	20 ed 	  . 
	ld a,00bh		;1147	3e 0b 	> . 
	call 0570fh		;1149	cd 0f 57 	. . W 
	jr l1134h		;114c	18 e6 	. . 
l114eh:
	ld e,(hl)			;114e	5e 	^ 
	inc hl			;114f	23 	# 
	ld d,(hl)			;1150	56 	V 
	jr l1133h		;1151	18 e0 	. . 
	ld d,001h		;1153	16 01 	. . 
	jr l1159h		;1155	18 02 	. . 
sub_1157h:
	ld d,0dbh		;1157	16 db 	. . 
l1159h:
	ld e,020h		;1159	1e 20 	.   
	ld bc,l0800h		;115b	01 00 08 	. . . 
	ld hl,0d000h		;115e	21 00 d0 	! . . 
	ld iy,0d800h		;1161	fd 21 00 d8 	. ! . . 
l1165h:
	ld (hl),e			;1165	73 	s 
	ld (iy+000h),d		;1166	fd 72 00 	. r . 
	inc hl			;1169	23 	# 
	inc iy		;116a	fd 23 	. # 
	dec bc			;116c	0b 	. 
	ld a,b			;116d	78 	x 
	or c			;116e	b1 	. 
	jr nz,l1165h		;116f	20 f4 	  . 
	ret			;1171	c9 	. 
sub_1172h:
	xor a			;1172	af 	. 
	add hl,hl			;1173	29 	) 
	rla			;1174	17 	. 
	ld l,h			;1175	6c 	l 
	ld h,a			;1176	67 	g 
	push de			;1177	d5 	. 
	ld de,000fh+1		;1178	11 10 00 	. . . 
	add hl,de			;117b	19 	. 
	pop de			;117c	d1 	. 
	ld (0e815h),hl		;117d	22 15 e8 	" . . 
	add hl,de			;1180	19 	. 
	ld (0e813h),hl		;1181	22 13 e8 	" . . 
	ld a,(0e706h)		;1184	3a 06 e7 	: . . 
	add a,a			;1187	87 	. 
	ld e,a			;1188	5f 	_ 
	ld d,000h		;1189	16 00 	. . 
	ld hl,0664dh		;118b	21 4d 66 	! M f 
	add hl,de			;118e	19 	. 
	ld e,(hl)			;118f	5e 	^ 
	inc hl			;1190	23 	# 
	ld d,(hl)			;1191	56 	V 
	ld iy,0		;1192	fd 21 00 00 	. ! . . 
	add iy,de		;1196	fd 19 	. . 
l1198h:
	ld hl,(0e717h)		;1198	2a 17 e7 	* . . 
	ld a,(iy+000h)		;119b	fd 7e 00 	. ~ . 
	cp 0ffh		;119e	fe ff 	. . 
	ret z			;11a0	c8 	. 
	ld e,a			;11a1	5f 	_ 
	ld d,000h		;11a2	16 00 	. . 
	add hl,de			;11a4	19 	. 
	ld de,(0e813h)		;11a5	ed 5b 13 e8 	. [ . . 
	sbc hl,de		;11a9	ed 52 	. R 
	jr nc,l1201h		;11ab	30 54 	0 T 
	ld hl,(0e717h)		;11ad	2a 17 e7 	* . . 
	ld e,(iy+001h)		;11b0	fd 5e 01 	. ^ . 
	ld d,000h		;11b3	16 00 	. . 
	add hl,de			;11b5	19 	. 
	ld de,(0e815h)		;11b6	ed 5b 15 e8 	. [ . . 
	sbc hl,de		;11ba	ed 52 	. R 
	jr c,l1201h		;11bc	38 43 	8 C 
	ld hl,(0e712h)		;11be	2a 12 e7 	* . . 
	ld a,(0e701h)		;11c1	3a 01 e7 	: . . 
	and 040h		;11c4	e6 40 	. @ 
	jr z,l11d2h		;11c6	28 0a 	( . 
	ld e,(iy+004h)		;11c8	fd 5e 04 	. ^ . 
	ld d,(iy+005h)		;11cb	fd 56 05 	. V . 
	sbc hl,de		;11ce	ed 52 	. R 
	jr l11d9h		;11d0	18 07 	. . 
l11d2h:
	ld e,(iy+002h)		;11d2	fd 5e 02 	. ^ . 
	ld d,(iy+003h)		;11d5	fd 56 03 	. V . 
	add hl,de			;11d8	19 	. 
l11d9h:
	and a			;11d9	a7 	. 
	ld de,(0e80fh)		;11da	ed 5b 0f e8 	. [ . . 
	sbc hl,de		;11de	ed 52 	. R 
	jr c,l1201h		;11e0	38 1f 	8 . 
	ld hl,(0e712h)		;11e2	2a 12 e7 	* . . 
	and a			;11e5	a7 	. 
	jr z,l11f2h		;11e6	28 0a 	( . 
	ld e,(iy+002h)		;11e8	fd 5e 02 	. ^ . 
	ld d,(iy+003h)		;11eb	fd 56 03 	. V . 
	sbc hl,de		;11ee	ed 52 	. R 
	jr l11f9h		;11f0	18 07 	. . 
l11f2h:
	ld e,(iy+004h)		;11f2	fd 5e 04 	. ^ . 
	ld d,(iy+005h)		;11f5	fd 56 05 	. V . 
	add hl,de			;11f8	19 	. 
l11f9h:
	and a			;11f9	a7 	. 
	ld de,(0e811h)		;11fa	ed 5b 11 e8 	. [ . . 
	sbc hl,de		;11fe	ed 52 	. R 
l1200h:
	ret c			;1200	d8 	. 
l1201h:
	ld de,0006h		;1201	11 06 00 	. . . 
	add iy,de		;1204	fd 19 	. . 
	jr l1198h		;1206	18 90 	. . 
sub_1208h:
	ld a,(0e000h)		;1208	3a 00 e0 	: . . 
	cp 006h		;120b	fe 06 	. . 
	ret z			;120d	c8 	. 
	in a,(004h)		;120e	db 04 	. . 
	cpl			;1210	2f 	/ 
	bit 6,a		;1211	cb 77 	. w 
	ret			;1213	c9 	. 
sub_1214h:
	cp (hl)			;1214	be 	. 
	jr c,l121ch		;1215	38 05 	8 . 
	inc hl			;1217	23 	# 
	cp (hl)			;1218	be 	. 
	jr c,l121ch		;1219	38 01 	8 . 
	inc hl			;121b	23 	# 
l121ch:
	inc hl			;121c	23 	# 
	inc hl			;121d	23 	# 
	ld a,(hl)			;121e	7e 	~ 
	ret			;121f	c9 	. 
sub_1220h:
	ld (0e805h),hl		;1220	22 05 e8 	" . . 
	ld a,(0e706h)		;1223	3a 06 e7 	: . . 
	ld hl,l126eh		;1226	21 6e 12 	! n . 
	ld d,000h		;1229	16 00 	. . 
	ld e,a			;122b	5f 	_ 
	add hl,de			;122c	19 	. 
	ld a,(hl)			;122d	7e 	~ 
	and a			;122e	a7 	. 
	ret z			;122f	c8 	. 
	ld iy,l1290h		;1230	fd 21 90 12 	. ! . . 
	add a,a			;1234	87 	. 
	add a,a			;1235	87 	. 
	ld e,a			;1236	5f 	_ 
	add iy,de		;1237	fd 19 	. . 
	ld hl,(0e710h)		;1239	2a 10 e7 	* . . 
	ld e,(iy+002h)		;123c	fd 5e 02 	. ^ . 
	ld d,(iy+003h)		;123f	fd 56 03 	. V . 
	add hl,de			;1242	19 	. 
	push hl			;1243	e5 	. 
	ld e,(iy+000h)		;1244	fd 5e 00 	. ^ . 
	ld d,(iy+001h)		;1247	fd 56 01 	. V . 
	ld hl,(0e712h)		;124a	2a 12 e7 	* . . 
	ld a,(0e701h)		;124d	3a 01 e7 	: . . 
	and 040h		;1250	e6 40 	. @ 
	jr z,l1257h		;1252	28 03 	( . 
	add hl,de			;1254	19 	. 
	jr l1259h		;1255	18 02 	. . 
l1257h:
	sbc hl,de		;1257	ed 52 	. R 
l1259h:
	ld e,(ix+002h)		;1259	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;125c	dd 56 03 	. V . 
	sbc hl,de		;125f	ed 52 	. R 
	ld de,(0e805h)		;1261	ed 5b 05 e8 	. [ . . 
	jr c,l126bh		;1265	38 04 	8 . 
	sbc hl,de		;1267	ed 52 	. R 
	jr l126ch		;1269	18 01 	. . 
l126bh:
	add hl,de			;126b	19 	. 
l126ch:
	pop de			;126c	d1 	. 
	ret			;126d	c9 	. 
l126eh:
	nop			;126e	00 	. 
	nop			;126f	00 	. 
	nop			;1270	00 	. 
	nop			;1271	00 	. 
	nop			;1272	00 	. 
	nop			;1273	00 	. 
	nop			;1274	00 	. 
	inc b			;1275	04 	. 
	nop			;1276	00 	. 
	defb 001h, 001h, 000h
	inc bc			;127a	03 	. 
	nop			;127b	00 	. 
	ld (bc),a			;127c	02 	. 
	ld (bc),a			;127d	02 	. 
	nop			;127e	00 	. 
	nop			;127f	00 	. 
	nop			;1280	00 	. 
	nop			;1281	00 	. 
	nop			;1282	00 	. 
	ld bc,l0100h+1		;1283	01 01 01 	. . . 
	dec b			;1286	05 	. 
	dec b			;1287	05 	. 
	nop			;1288	00 	. 
	ld b,000h		;1289	06 00 	. . 
	nop			;128b	00 	. 
	nop			;128c	00 	. 
	nop			;128d	00 	. 
	nop			;128e	00 	. 
	nop			;128f	00 	. 
l1290h:
	nop			;1290	00 	. 
	nop			;1291	00 	. 
	nop			;1292	00 	. 
	nop			;1293	00 	. 
	nop			;1294	00 	. 
	ld (bc),a			;1295	02 	. 
	add a,b			;1296	80 	. 
	jr l1299h		;1297	18 00 	. . 
l1299h:
	ld (bc),a			;1299	02 	. 
	add a,b			;129a	80 	. 
	inc de			;129b	13 	. 
	add a,b			;129c	80 	. 
	inc bc			;129d	03 	. 
	nop			;129e	00 	. 
	inc b			;129f	04 	. 
	add a,b			;12a0	80 	. 
	inc bc			;12a1	03 	. 
	add a,b			;12a2	80 	. 
	jr $-94		;12a3	18 a0 	. . 
	ld (bc),a			;12a5	02 	. 
	nop			;12a6	00 	. 
	jr l12c9h		;12a7	18 20 	.   
	inc bc			;12a9	03 	. 
	add a,b			;12aa	80 	. 
	rrca			;12ab	0f 	. 
sub_12ach:
	ld hl,0e700h		;12ac	21 00 e7 	! . . 
	bit 1,(hl)		;12af	cb 4e 	. N 
	jr nz,l12c5h		;12b1	20 12 	  . 
	ld hl,0e200h		;12b3	21 00 e2 	! . . 
	call sub_12cbh		;12b6	cd cb 12 	. . . 
	call sub_12feh		;12b9	cd fe 12 	. . . 
	call sub_138fh		;12bc	cd 8f 13 	. . . 
	call sub_13eeh		;12bf	cd ee 13 	. . . 
	call sub_143fh		;12c2	cd 3f 14 	. ? . 
l12c5h:
	call sub_153dh		;12c5	cd 3d 15 	. = . 
	ret			;12c8	c9 	. 
l12c9h:
	inc hl			;12c9	23 	# 
l12cah:
	inc hl			;12ca	23 	# 
sub_12cbh:
	ld a,(hl)			;12cb	7e 	~ 
	and a			;12cc	a7 	. 
	ret z			;12cd	c8 	. 
	dec (hl)			;12ce	35 	5 
	jp nz,l12c9h		;12cf	c2 c9 12 	. . . 
	inc hl			;12d2	23 	# 
	ld c,(hl)			;12d3	4e 	N 
	ld b,000h		;12d4	06 00 	. . 
	ex de,hl			;12d6	eb 	. 
	ld hl,0e10ah		;12d7	21 0a e1 	! . . 
	add hl,bc			;12da	09 	. 
	add hl,bc			;12db	09 	. 
	res 7,(hl)		;12dc	cb be 	. . 
	ld hl,(0e108h)		;12de	2a 08 e1 	* . . 
	ldd		;12e1	ed a8 	. . 
	ldd		;12e3	ed a8 	. . 
	ld (0e108h),hl		;12e5	22 08 e1 	" . . 
	inc hl			;12e8	23 	# 
	ld (hl),000h		;12e9	36 00 	6 . 
	ex de,hl			;12eb	eb 	. 
	jp l12cah		;12ec	c3 ca 12 	. . . 
l12efh:
	nop			;12ef	00 	. 
	nop			;12f0	00 	. 
	nop			;12f1	00 	. 
	ld bc,l0100h+1		;12f2	01 01 01 	. . . 
	ld (bc),a			;12f5	02 	. 
	ld (bc),a			;12f6	02 	. 
	ld (bc),a			;12f7	02 	. 
	inc bc			;12f8	03 	. 
	inc bc			;12f9	03 	. 
	inc bc			;12fa	03 	. 
	inc b			;12fb	04 	. 
	inc b			;12fc	04 	. 
	inc b			;12fd	04 	. 
sub_12feh:
	ld a,(0e701h)		;12fe	3a 01 e7 	: . . 
	and 080h		;1301	e6 80 	. . 
	ld c,0e4h		;1303	0e e4 	. . 
	jr z,l1309h		;1305	28 02 	( . 
	ld c,01ch		;1307	0e 1c 	. . 
l1309h:
	ld a,(0e713h)		;1309	3a 13 e7 	: . . 
	add a,c			;130c	81 	. 
	cp 0e0h		;130d	fe e0 	. . 
	ret nc			;130f	d0 	. 
	ld (0e809h),a		;1310	32 09 e8 	2 . . 
	ld e,a			;1313	5f 	_ 
	and 00fh		;1314	e6 0f 	. . 
	dec a			;1316	3d 	= 
	ret m			;1317	f8 	. 
	ld hl,l12efh		;1318	21 ef 12 	! . . 
	ld b,000h		;131b	06 00 	. . 
	ld c,a			;131d	4f 	O 
	add hl,bc			;131e	09 	. 
	ld c,(hl)			;131f	4e 	N 
	ld a,e			;1320	7b 	{ 
	and 0f0h		;1321	e6 f0 	. . 
	rrca			;1323	0f 	. 
	rrca			;1324	0f 	. 
	ld e,a			;1325	5f 	_ 
	rrca			;1326	0f 	. 
	rrca			;1327	0f 	. 
	add a,e			;1328	83 	. 
	add a,c			;1329	81 	. 
	ld c,a			;132a	4f 	O 
	ld ix,0e10ah		;132b	dd 21 0a e1 	. ! . . 
	add ix,bc		;132f	dd 09 	. . 
	add ix,bc		;1331	dd 09 	. . 
	bit 7,(ix+000h)		;1333	dd cb 00 7e 	. . . ~ 
	ret nz			;1337	c0 	. 
	ld hl,(0e108h)		;1338	2a 08 e1 	* . . 
	ld de,0e213h		;133b	11 13 e2 	. . . 
	sbc hl,de		;133e	ed 52 	. R 
	ret z			;1340	c8 	. 
	ld b,a			;1341	47 	G 
	ld a,(0e701h)		;1342	3a 01 e7 	: . . 
	and 080h		;1345	e6 80 	. . 
	ld hl,0e235h		;1347	21 35 e2 	! 5 . 
	ld de,0e19ah		;134a	11 9a e1 	. . . 
	jr z,l1353h		;134d	28 04 	( . 
	ld hl,0e215h		;134f	21 15 e2 	! . . 
	inc de			;1352	13 	. 
l1353h:
	ld a,(hl)			;1353	7e 	~ 
	and a			;1354	a7 	. 
	ret nz			;1355	c0 	. 
	inc hl			;1356	23 	# 
	ld a,(hl)			;1357	7e 	~ 
	cp 00ah		;1358	fe 0a 	. . 
	ret nc			;135a	d0 	. 
	push hl			;135b	e5 	. 
	push de			;135c	d5 	. 
	inc (hl)			;135d	34 	4 
	inc hl			;135e	23 	# 
	ld e,a			;135f	5f 	_ 
	add a,a			;1360	87 	. 
	add a,e			;1361	83 	. 
	ld d,000h		;1362	16 00 	. . 
	ld e,a			;1364	5f 	_ 
	add hl,de			;1365	19 	. 
	ld (hl),d			;1366	72 	r 
	inc hl			;1367	23 	# 
	ld a,(0e809h)		;1368	3a 09 e8 	: . . 
	ld (hl),a			;136b	77 	w 
	inc hl			;136c	23 	# 
	ld a,(ix+000h)		;136d	dd 7e 00 	. ~ . 
	ld (hl),a			;1370	77 	w 
	ld a,(ix+001h)		;1371	dd 7e 01 	. ~ . 
	ld hl,(0e108h)		;1374	2a 08 e1 	* . . 
	inc hl			;1377	23 	# 
	ld (hl),a			;1378	77 	w 
	inc hl			;1379	23 	# 
	ld (hl),c			;137a	71 	q 
	ld (0e108h),hl		;137b	22 08 e1 	" . . 
	set 7,(ix+000h)		;137e	dd cb 00 fe 	. . . . 
	pop hl			;1382	e1 	. 
	pop de			;1383	d1 	. 
	dec (hl)			;1384	35 	5 
	ret nz			;1385	c0 	. 
	ld a,(0e199h)		;1386	3a 99 e1 	: . . 
	ld (hl),a			;1389	77 	w 
	ex de,hl			;138a	eb 	. 
	dec hl			;138b	2b 	+ 
	ld (hl),001h		;138c	36 01 	6 . 
	ret			;138e	c9 	. 
sub_138fh:
	ld hl,0e236h		;138f	21 36 e2 	! 6 . 
	ld a,(hl)			;1392	7e 	~ 
	and a			;1393	a7 	. 
	ret z			;1394	c8 	. 
	ld b,a			;1395	47 	G 
	ld d,000h		;1396	16 00 	. . 
	inc hl			;1398	23 	# 
l1399h:
	ld a,(hl)			;1399	7e 	~ 
	add a,036h		;139a	c6 36 	. 6 
	ld (hl),a			;139c	77 	w 
	inc hl			;139d	23 	# 
	ld a,(hl)			;139e	7e 	~ 
	adc a,d			;139f	8a 	. 
	jp nc,l13a4h		;13a0	d2 a4 13 	. . . 
	dec a			;13a3	3d 	= 
l13a4h:
	ld (hl),a			;13a4	77 	w 
	inc hl			;13a5	23 	# 
	inc hl			;13a6	23 	# 
	djnz l1399h		;13a7	10 f0 	. . 
	ld hl,(0e237h)		;13a9	2a 37 e2 	* 7 . 
	ld a,h			;13ac	7c 	| 
	cp 0beh		;13ad	fe be 	. . 
	jr nc,l13bch		;13af	30 0b 	0 . 
	ld bc,l1200h		;13b1	01 00 12 	. . . 
	add hl,bc			;13b4	09 	. 
	ld bc,(0e712h)		;13b5	ed 4b 12 e7 	. K . . 
	sbc hl,bc		;13b9	ed 42 	. B 
	ret c			;13bb	d8 	. 
l13bch:
	ld hl,0e255h		;13bc	21 55 e2 	! U . 
	ld a,(hl)			;13bf	7e 	~ 
	cp 00ah		;13c0	fe 0a 	. . 
	ret nc			;13c2	d0 	. 
	inc (hl)			;13c3	34 	4 
	ld e,a			;13c4	5f 	_ 
	ld hl,0e256h		;13c5	21 56 e2 	! V . 
	add hl,de			;13c8	19 	. 
	ld a,(0e239h)		;13c9	3a 39 e2 	: 9 . 
	or 058h		;13cc	f6 58 	. X 
	ld (hl),a			;13ce	77 	w 
	ex de,hl			;13cf	eb 	. 
	ld hl,0e236h		;13d0	21 36 e2 	! 6 . 
	dec (hl)			;13d3	35 	5 
	jr z,l13e6h		;13d4	28 10 	( . 
	ld a,(hl)			;13d6	7e 	~ 
	ld de,0e237h		;13d7	11 37 e2 	. 7 . 
	ld hl,0e23ah		;13da	21 3a e2 	! : . 
l13ddh:
	ld c,a			;13dd	4f 	O 
	add a,a			;13de	87 	. 
	add a,c			;13df	81 	. 
	ld c,a			;13e0	4f 	O 
	ld b,000h		;13e1	06 00 	. . 
	ldir		;13e3	ed b0 	. . 
	ret			;13e5	c9 	. 
l13e6h:
	dec hl			;13e6	2b 	+ 
	ld a,(hl)			;13e7	7e 	~ 
	and a			;13e8	a7 	. 
	ret z			;13e9	c8 	. 
	ex de,hl			;13ea	eb 	. 
	set 0,(hl)		;13eb	cb c6 	. . 
	ret			;13ed	c9 	. 
sub_13eeh:
	ld hl,0e216h		;13ee	21 16 e2 	! . . 
	ld a,(hl)			;13f1	7e 	~ 
	and a			;13f2	a7 	. 
	ret z			;13f3	c8 	. 
	ld b,a			;13f4	47 	G 
	ld d,000h		;13f5	16 00 	. . 
	inc hl			;13f7	23 	# 
l13f8h:
	ld a,(hl)			;13f8	7e 	~ 
	sub 036h		;13f9	d6 36 	. 6 
	ld (hl),a			;13fb	77 	w 
	inc hl			;13fc	23 	# 
	ld a,(hl)			;13fd	7e 	~ 
	sbc a,d			;13fe	9a 	. 
	jp nc,l1403h		;13ff	d2 03 14 	. . . 
	inc a			;1402	3c 	< 
l1403h:
	ld (hl),a			;1403	77 	w 
	inc hl			;1404	23 	# 
	inc hl			;1405	23 	# 
	djnz l13f8h		;1406	10 f0 	. . 
	ld hl,(0e217h)		;1408	2a 17 e2 	* . . 
	ld a,h			;140b	7c 	| 
	cp 022h		;140c	fe 22 	. " 
	jr c,l141ch		;140e	38 0c 	8 . 
	ld bc,l1200h		;1410	01 00 12 	. . . 
	sbc hl,bc		;1413	ed 42 	. B 
	ld bc,(0e712h)		;1415	ed 4b 12 e7 	. K . . 
	sbc hl,bc		;1419	ed 42 	. B 
	ret nc			;141b	d0 	. 
l141ch:
	ld hl,0e255h		;141c	21 55 e2 	! U . 
	ld a,(hl)			;141f	7e 	~ 
	cp 00ah		;1420	fe 0a 	. . 
	ret nc			;1422	d0 	. 
	inc (hl)			;1423	34 	4 
	ld e,a			;1424	5f 	_ 
	ld hl,0e256h		;1425	21 56 e2 	! V . 
	add hl,de			;1428	19 	. 
	ld a,(0e219h)		;1429	3a 19 e2 	: . . 
	or 030h		;142c	f6 30 	. 0 
	ld (hl),a			;142e	77 	w 
	ex de,hl			;142f	eb 	. 
	ld hl,0e216h		;1430	21 16 e2 	! . . 
	dec (hl)			;1433	35 	5 
	jr z,l13e6h		;1434	28 b0 	( . 
	ld a,(hl)			;1436	7e 	~ 
	ld de,0e217h		;1437	11 17 e2 	. . . 
	ld hl,0e21ah		;143a	21 1a e2 	! . . 
	jr l13ddh		;143d	18 9e 	. . 
sub_143fh:
	ld a,(0e260h)		;143f	3a 60 e2 	: ` . 
	ld b,a			;1442	47 	G 
	xor 028h		;1443	ee 28 	. ( 
	ret z			;1445	c8 	. 
	ld a,(0e2d8h)		;1446	3a d8 e2 	: . . 
	and 010h		;1449	e6 10 	. . 
	ld a,(0e196h)		;144b	3a 96 e1 	: . . 
	jr z,l1453h		;144e	28 03 	( . 
	ld a,(0e197h)		;1450	3a 97 e1 	: . . 
l1453h:
	and a			;1453	a7 	. 
	jr z,l145ch		;1454	28 06 	( . 
	ld c,a			;1456	4f 	O 
	ld a,(0e261h)		;1457	3a 61 e2 	: a . 
	cp c			;145a	b9 	. 
	ret nc			;145b	d0 	. 
l145ch:
	ld hl,0e255h		;145c	21 55 e2 	! U . 
	ld a,(hl)			;145f	7e 	~ 
	and a			;1460	a7 	. 
	ret z			;1461	c8 	. 
	ld c,a			;1462	4f 	O 
	inc hl			;1463	23 	# 
	bit 6,(hl)		;1464	cb 76 	. v 
	jr nz,l1475h		;1466	20 0d 	  . 
	bit 5,b		;1468	cb 68 	. h 
	jr z,l14bfh		;146a	28 53 	( S 
l146ch:
	dec c			;146c	0d 	. 
	ret z			;146d	c8 	. 
	inc hl			;146e	23 	# 
	bit 6,(hl)		;146f	cb 76 	. v 
	jr z,l146ch		;1471	28 f9 	( . 
	jr l1479h		;1473	18 04 	. . 
l1475h:
	bit 3,b		;1475	cb 58 	. X 
	jr nz,l14b8h		;1477	20 3f 	  ? 
l1479h:
	call sub_1524h		;1479	cd 24 15 	. $ . 
	push af			;147c	f5 	. 
	ld hl,(0e712h)		;147d	2a 12 e7 	* . . 
	ld de,l1200h		;1480	11 00 12 	. . . 
	sbc hl,de		;1483	ed 52 	. R 
	ld de,0be00h		;1485	11 00 be 	. . . 
	sbc hl,de		;1488	ed 52 	. R 
	jr nc,l148eh		;148a	30 02 	0 . 
	add hl,de			;148c	19 	. 
	ex de,hl			;148d	eb 	. 
l148eh:
	ld a,(0e2d8h)		;148e	3a d8 e2 	: . . 
	ld l,a			;1491	6f 	o 
	bit 4,l		;1492	cb 65 	. e 
	jr z,l14b1h		;1494	28 1b 	( . 
	ld a,(0e197h)		;1496	3a 97 e1 	: . . 
	and a			;1499	a7 	. 
	jr z,l14a7h		;149a	28 0b 	( . 
	bit 6,l		;149c	cb 75 	. u 
	jr z,l14b1h		;149e	28 11 	( . 
	ld hl,(0e2dah)		;14a0	2a da e2 	* . . 
	sbc hl,de		;14a3	ed 52 	. R 
	jr c,l14b1h		;14a5	38 0a 	8 . 
l14a7h:
	ld hl,0e235h		;14a7	21 35 e2 	! 5 . 
l14aah:
	pop af			;14aa	f1 	. 
	and 001h		;14ab	e6 01 	. . 
	ret z			;14ad	c8 	. 
	ld (hl),000h		;14ae	36 00 	6 . 
	ret			;14b0	c9 	. 
l14b1h:
	ld hl,0e260h		;14b1	21 60 e2 	! ` . 
	set 3,(hl)		;14b4	cb de 	. . 
	jr l14f6h		;14b6	18 3e 	. > 
l14b8h:
	dec c			;14b8	0d 	. 
	ret z			;14b9	c8 	. 
	inc hl			;14ba	23 	# 
	bit 6,(hl)		;14bb	cb 76 	. v 
	jr nz,l14b8h		;14bd	20 f9 	  . 
l14bfh:
	call sub_1524h		;14bf	cd 24 15 	. $ . 
	push af			;14c2	f5 	. 
	ld hl,(0e712h)		;14c3	2a 12 e7 	* . . 
	ld de,l1200h		;14c6	11 00 12 	. . . 
	add hl,de			;14c9	19 	. 
	ld de,l2200h		;14ca	11 00 22 	. . " 
	sbc hl,de		;14cd	ed 52 	. R 
	jr c,l14d3h		;14cf	38 02 	8 . 
	add hl,de			;14d1	19 	. 
	ex de,hl			;14d2	eb 	. 
l14d3h:
	ld a,(0e2d8h)		;14d3	3a d8 e2 	: . . 
	ld l,a			;14d6	6f 	o 
	bit 4,l		;14d7	cb 65 	. e 
	jr z,l14f1h		;14d9	28 16 	( . 
	ld a,(0e197h)		;14db	3a 97 e1 	: . . 
	and a			;14de	a7 	. 
	jr z,l14ech		;14df	28 0b 	( . 
	bit 6,l		;14e1	cb 75 	. u 
	jr nz,l14f1h		;14e3	20 0c 	  . 
	ld hl,(0e2dah)		;14e5	2a da e2 	* . . 
	sbc hl,de		;14e8	ed 52 	. R 
	jr nc,l14f1h		;14ea	30 05 	0 . 
l14ech:
	ld hl,0e215h		;14ec	21 15 e2 	! . . 
	jr l14aah		;14ef	18 b9 	. . 
l14f1h:
	ld hl,0e260h		;14f1	21 60 e2 	! ` . 
	set 5,(hl)		;14f4	cb ee 	. . 
l14f6h:
	ld hl,0e261h		;14f6	21 61 e2 	! a . 
	inc (hl)			;14f9	34 	4 
	inc hl			;14fa	23 	# 
	ld bc,000fh+1		;14fb	01 10 00 	. . . 
l14feh:
	ld a,(hl)			;14fe	7e 	~ 
	and a			;14ff	a7 	. 
l1500h:
	jr z,l1505h		;1500	28 03 	( . 
	add hl,bc			;1502	09 	. 
	jr l14feh		;1503	18 f9 	. . 
l1505h:
	pop af			;1505	f1 	. 
	ld (hl),a			;1506	77 	w 
	xor a			;1507	af 	. 
	inc hl			;1508	23 	# 
	ld (hl),000h		;1509	36 00 	6 . 
	inc hl			;150b	23 	# 
	ld (hl),e			;150c	73 	s 
	inc hl			;150d	23 	# 
	ld (hl),d			;150e	72 	r 
	inc hl			;150f	23 	# 
	ld (hl),000h		;1510	36 00 	6 . 
	inc hl			;1512	23 	# 
	ld (hl),050h		;1513	36 50 	6 P 
	inc hl			;1515	23 	# 
	ld (hl),a			;1516	77 	w 
	inc hl			;1517	23 	# 
	ld (hl),007h		;1518	36 07 	6 . 
	inc hl			;151a	23 	# 
	ld (hl),a			;151b	77 	w 
	inc hl			;151c	23 	# 
	ld (hl),a			;151d	77 	w 
	inc hl			;151e	23 	# 
	ld (hl),002h		;151f	36 02 	6 . 
	inc hl			;1521	23 	# 
	ld (hl),a			;1522	77 	w 
	ret			;1523	c9 	. 
sub_1524h:
	ld a,(hl)			;1524	7e 	~ 
	dec c			;1525	0d 	. 
	jr z,l152fh		;1526	28 07 	( . 
	ld d,h			;1528	54 	T 
	ld e,l			;1529	5d 	] 
	inc hl			;152a	23 	# 
	ld b,000h		;152b	06 00 	. . 
	ldir		;152d	ed b0 	. . 
l152fh:
	ld hl,0e255h		;152f	21 55 e2 	! U . 
	dec (hl)			;1532	35 	5 
	ret			;1533	c9 	. 
l1534h:
	pop bc			;1534	c1 	. 
	ld de,000fh+1		;1535	11 10 00 	. . . 
	add ix,de		;1538	dd 19 	. . 
	djnz l1556h		;153a	10 1a 	. . 
	ret			;153c	c9 	. 
sub_153dh:
	ld a,(0e701h)		;153d	3a 01 e7 	: . . 
	and 003h		;1540	e6 03 	. . 
	jr nz,l1547h		;1542	20 03 	  . 
	ld (0e2d2h),a		;1544	32 d2 e2 	2 . . 
l1547h:
	ld hl,l0100h+1		;1547	21 01 01 	! . . 
	ld (0e71bh),hl		;154a	22 1b e7 	" . . 
	ld (0e71dh),hl		;154d	22 1d e7 	" . . 
	ld ix,0e262h		;1550	dd 21 62 e2 	. ! b . 
	ld b,005h		;1554	06 05 	. . 
l1556h:
	push bc			;1556	c5 	. 
	ld hl,l1534h		;1557	21 34 15 	! 4 . 
	push hl			;155a	e5 	. 
	ld c,(ix+000h)		;155b	dd 4e 00 	. N . 
	bit 4,c		;155e	cb 61 	. a 
	ret z			;1560	c8 	. 
	bit 5,c		;1561	cb 69 	. i 
	call nz,sub_1c26h		;1563	c4 26 1c 	. & . 
	bit 3,c		;1566	cb 59 	. Y 
	call nz,sub_1c3dh		;1568	c4 3d 1c 	. = . 
	bit 0,c		;156b	cb 41 	. A 
	ld a,(ix+001h)		;156d	dd 7e 01 	. ~ . 
	jp nz,l186eh		;1570	c2 6e 18 	. n . 
	bit 2,c		;1573	cb 51 	. Q 
	jp nz,l168ah		;1575	c2 8a 16 	. . . 
	ld hl,l162fh		;1578	21 2f 16 	! / . 
	push hl			;157b	e5 	. 
	ld hl,0e700h		;157c	21 00 e7 	! . . 
	bit 1,(hl)		;157f	cb 4e 	. N 
	jp nz,l1be2h		;1581	c2 e2 1b 	. . . 
	cp 001h		;1584	fe 01 	. . 
	jp z,l1baah		;1586	ca aa 1b 	. . . 
	jr c,l15d2h		;1589	38 47 	8 G 
	cp 009h		;158b	fe 09 	. . 
	jp z,l15ddh		;158d	ca dd 15 	. . . 
	jr nc,l15a8h		;1590	30 16 	0 . 
l1592h:
	call sub_1befh		;1592	cd ef 1b 	. . . 
	ld de,0ef00h		;1595	11 00 ef 	. . . 
	add hl,de			;1598	19 	. 
	ret nc			;1599	d0 	. 
	call sub_1b7ah		;159a	cd 7a 1b 	. z . 
	ld a,c			;159d	79 	y 
	and 028h		;159e	e6 28 	. ( 
	cpl			;15a0	2f 	/ 
	ld hl,0e260h		;15a1	21 60 e2 	! ` . 
	and (hl)			;15a4	a6 	. 
	ld (hl),a			;15a5	77 	w 
	pop hl			;15a6	e1 	. 
	ret			;15a7	c9 	. 
l15a8h:
	call sub_1be7h		;15a8	cd e7 1b 	. . . 
	ld a,(ix+006h)		;15ab	dd 7e 06 	. ~ . 
	cp 00ah		;15ae	fe 0a 	. . 
	jr nc,l15b6h		;15b0	30 04 	0 . 
	ld (ix+006h),00dh		;15b2	dd 36 06 0d 	. 6 . . 
l15b6h:
	call sub_163eh		;15b6	cd 3e 16 	. > . 
	ret c			;15b9	d8 	. 
	ld de,0ff00h		;15ba	11 00 ff 	. . . 
	ld hl,(0e80ch)		;15bd	2a 0c e8 	* . . 
	add hl,de			;15c0	19 	. 
	jp nc,l1b20h		;15c1	d2 20 1b 	.   . 
	ret			;15c4	c9 	. 
l15c5h:
	ld a,00ah		;15c5	3e 0a 	> . 
	add a,(ix+006h)		;15c7	dd 86 06 	. . . 
	ld (ix+006h),a		;15ca	dd 77 06 	. w . 
	ld (ix+001h),00ah		;15cd	dd 36 01 0a 	. 6 . . 
	ret			;15d1	c9 	. 
l15d2h:
	call sub_1be7h		;15d2	cd e7 1b 	. . . 
	ld de,0f800h		;15d5	11 00 f8 	. . . 
	add hl,de			;15d8	19 	. 
	jp nc,l15c5h		;15d9	d2 c5 15 	. . . 
	ret			;15dc	c9 	. 
l15ddh:
	call sub_1b54h		;15dd	cd 54 1b 	. T . 
	call sub_1c61h		;15e0	cd 61 1c 	. a . 
	cp (ix+00fh)		;15e3	dd be 0f 	. . . 
	jr z,l15f2h		;15e6	28 0a 	( . 
	dec (ix+00bh)		;15e8	dd 35 0b 	. 5 . 
	jr z,l1626h		;15eb	28 39 	( 9 
	ld (ix+00fh),a		;15ed	dd 77 0f 	. w . 
	jr l15fbh		;15f0	18 09 	. . 
l15f2h:
	dec (ix+00eh)		;15f2	dd 35 0e 	. 5 . 
	jr nz,l15ffh		;15f5	20 08 	  . 
	ld (ix+00bh),006h		;15f7	dd 36 0b 06 	. 6 . . 
l15fbh:
	ld (ix+00eh),005h		;15fb	dd 36 0e 05 	. 6 . . 
l15ffh:
	dec (ix+007h)		;15ff	dd 35 07 	. 5 . 
	ret nz			;1602	c0 	. 
	ld a,(0e81ch)		;1603	3a 1c e8 	: . . 
	and a			;1606	a7 	. 
	ld a,002h		;1607	3e 02 	> . 
	jr nz,l1615h		;1609	20 0a 	  . 
	in a,(003h)		;160b	db 03 	. . 
	and 002h		;160d	e6 02 	. . 
	ld a,004h		;160f	3e 04 	> . 
	jr nz,l1615h		;1611	20 02 	  . 
	ld a,003h		;1613	3e 03 	> . 
l1615h:
	ld (ix+007h),a		;1615	dd 77 07 	. w . 
	ld hl,0e709h		;1618	21 09 e7 	! . . 
	ld a,(hl)			;161b	7e 	~ 
	and a			;161c	a7 	. 
	ret m			;161d	f8 	. 
	dec (hl)			;161e	35 	5 
	ret p			;161f	f0 	. 
	ld hl,0e71fh		;1620	21 1f e7 	! . . 
	set 1,(hl)		;1623	cb ce 	. . 
	ret			;1625	c9 	. 
l1626h:
	ld hl,0e71ah		;1626	21 1a e7 	! . . 
	dec (hl)			;1629	35 	5 
	ld a,009h		;162a	3e 09 	> . 
	jp l1b90h		;162c	c3 90 1b 	. . . 
l162fh:
	ld hl,06a7bh		;162f	21 7b 6a 	! { j 
l1632h:
	ld a,(ix+001h)		;1632	dd 7e 01 	. ~ . 
	cp 005h		;1635	fe 05 	. . 
	jp nz,l1a7dh		;1637	c2 7d 1a 	. } . 
	ld a,c			;163a	79 	y 
	jp l1a80h		;163b	c3 80 1a 	. . . 
sub_163eh:
	ld de,l1680h		;163e	11 80 16 	. . . 
	call sub_1ad2h		;1641	cd d2 1a 	. . . 
	ret nc			;1644	d0 	. 
	push af			;1645	f5 	. 
	ld a,091h		;1646	3e 91 	> . 
	call sub_0dfeh		;1648	cd fe 0d 	. . . 
	pop af			;164b	f1 	. 
	jp m,l1653h		;164c	fa 53 16 	. S . 
	ld a,080h		;164f	3e 80 	> . 
	jr l1677h		;1651	18 24 	. $ 
l1653h:
	ld hl,0e2d2h		;1653	21 d2 e2 	! . . 
	inc (hl)			;1656	34 	4 
	call sub_1ac9h		;1657	cd c9 1a 	. . . 
	ld a,(hl)			;165a	7e 	~ 
	jr nz,l166bh		;165b	20 0e 	  . 
	cp 002h		;165d	fe 02 	. . 
	ld a,080h		;165f	3e 80 	> . 
	jr c,l1677h		;1661	38 14 	8 . 
	ld a,082h		;1663	3e 82 	> . 
	jr z,l1677h		;1665	28 10 	( . 
	ld a,085h		;1667	3e 85 	> . 
	jr l1677h		;1669	18 0c 	. . 
l166bh:
	cp 002h		;166b	fe 02 	. . 
	ld a,08ch		;166d	3e 8c 	> . 
	jr c,l1677h		;166f	38 06 	8 . 
	ld a,080h		;1671	3e 80 	> . 
	jr z,l1677h		;1673	28 02 	( . 
	ld a,082h		;1675	3e 82 	> . 
l1677h:
	ld hl,l00d2h		;1677	21 d2 00 	! . . 
l167ah:
	ex de,hl			;167a	eb 	. 
	call sub_2f60h		;167b	cd 60 2f 	. ` / 
	scf			;167e	37 	7 
	ret			;167f	c9 	. 
l1680h:
	jp p,0f2f0h		;1680	f2 f0 f2 	. . . 
	jp p,002f2h		;1683	f2 f2 02 	. . . 
	ld bc,0ffffh		;1686	01 ff ff 	. . . 
	rst 38h			;1689	ff 	. 
l168ah:
	ld hl,l1822h		;168a	21 22 18 	! " . 
	push hl			;168d	e5 	. 
	ld hl,0e700h		;168e	21 00 e7 	! . . 
	bit 1,(hl)		;1691	cb 4e 	. N 
	jp nz,l1be2h		;1693	c2 e2 1b 	. . . 
	cp 009h		;1696	fe 09 	. . 
	jp z,l15ddh		;1698	ca dd 15 	. . . 
	jp nc,l170bh		;169b	d2 0b 17 	. . . 
	cp 001h		;169e	fe 01 	. . 
	jp z,l1baah		;16a0	ca aa 1b 	. . . 
	jp nc,l1592h		;16a3	d2 92 15 	. . . 
	call sub_1be7h		;16a6	cd e7 1b 	. . . 
	call sub_1828h		;16a9	cd 28 18 	. ( . 
	ret c			;16ac	d8 	. 
	ld hl,(0e80ch)		;16ad	2a 0c e8 	* . . 
	ld de,0e100h		;16b0	11 00 e1 	. . . 
	add hl,de			;16b3	19 	. 
	jp c,sub_1b7ah		;16b4	da 7a 1b 	. z . 
	bit 0,(ix+00bh)		;16b7	dd cb 0b 46 	. . . F 
	jr nz,l16e3h		;16bb	20 26 	  & 
	ld hl,(0e80ch)		;16bd	2a 0c e8 	* . . 
	ld de,0fa00h		;16c0	11 00 fa 	. . . 
	add hl,de			;16c3	19 	. 
	jr c,l16e3h		;16c4	38 1d 	8 . 
	set 0,(ix+00bh)		;16c6	dd cb 0b c6 	. . . . 
	ld a,(0e702h)		;16ca	3a 02 e7 	: . . 
	cp 003h		;16cd	fe 03 	. . 
	jr z,l16d9h		;16cf	28 08 	( . 
	cp 006h		;16d1	fe 06 	. . 
	jr z,l16d9h		;16d3	28 04 	( . 
	cp 007h		;16d5	fe 07 	. . 
	jr nz,l16e3h		;16d7	20 0a 	  . 
l16d9h:
	ld a,(0e013h)		;16d9	3a 13 e0 	: . . 
	ld hl,0e1c1h		;16dc	21 c1 e1 	! . . 
	cp (hl)			;16df	be 	. 
	jp c,l17e5h		;16e0	da e5 17 	. . . 
l16e3h:
	ld hl,(0e710h)		;16e3	2a 10 e7 	* . . 
	ld de,0a180h		;16e6	11 80 a1 	. . . 
	add hl,de			;16e9	19 	. 
	ret c			;16ea	d8 	. 
	ld hl,(0e80ah)		;16eb	2a 0a e8 	* . . 
	ld de,l00c0h		;16ee	11 c0 00 	. . . 
	bit 6,c		;16f1	cb 71 	. q 
	jr z,l16f8h		;16f3	28 03 	( . 
	add hl,de			;16f5	19 	. 
	jr l16fah		;16f6	18 02 	. . 
l16f8h:
	sbc hl,de		;16f8	ed 52 	. R 
l16fah:
	jp c,l1b20h		;16fa	da 20 1b 	.   . 
	ret			;16fd	c9 	. 
l16feh:
	ld (ix+001h),000h		;16fe	dd 36 01 00 	. 6 . . 
	ld (ix+006h),000h		;1702	dd 36 06 00 	. 6 . . 
	ld (ix+007h),007h		;1706	dd 36 07 07 	. 6 . . 
	ret			;170a	c9 	. 
l170bh:
	ld e,(ix+00eh)		;170b	dd 5e 0e 	. ^ . 
	ld d,(ix+00fh)		;170e	dd 56 0f 	. V . 
	ld a,(ix+006h)		;1711	dd 7e 06 	. ~ . 
	cp 00ah		;1714	fe 0a 	. . 
	push af			;1716	f5 	. 
	call nz,sub_1c70h		;1717	c4 70 1c 	. p . 
	call l1be2h		;171a	cd e2 1b 	. . . 
	pop af			;171d	f1 	. 
	jr z,l173dh		;171e	28 1d 	( . 
	ld de,0ffd6h		;1720	11 d6 ff 	. . . 
	call sub_1cach		;1723	cd ac 1c 	. . . 
	add hl,de			;1726	19 	. 
	call sub_1ca5h		;1727	cd a5 1c 	. . . 
	ex de,hl			;172a	eb 	. 
	call sub_1c9eh		;172b	cd 9e 1c 	. . . 
	add hl,de			;172e	19 	. 
	ld de,05000h		;172f	11 00 50 	. . P 
	sbc hl,de		;1732	ed 52 	. R 
	add hl,de			;1734	19 	. 
	jr nc,l1738h		;1735	30 01 	0 . 
	ex de,hl			;1737	eb 	. 
l1738h:
	call sub_1c97h		;1738	cd 97 1c 	. . . 
	jr c,l16feh		;173b	38 c1 	8 . 
l173dh:
	bit 1,(ix+00bh)		;173d	dd cb 0b 4e 	. . . N 
	jr nz,l175fh		;1741	20 1c 	  . 
	call sub_1c8ah		;1743	cd 8a 1c 	. . . 
	ld de,0ff60h		;1746	11 60 ff 	. ` . 
	add hl,de			;1749	19 	. 
	ld (0e80fh),hl		;174a	22 0f e8 	" . . 
	ld de,l0140h		;174d	11 40 01 	. @ . 
	add hl,de			;1750	19 	. 
	ld (0e811h),hl		;1751	22 11 e8 	" . . 
	call sub_1c9eh		;1754	cd 9e 1c 	. . . 
	ld de,l0013h+1		;1757	11 14 00 	. . . 
	call sub_1172h		;175a	cd 72 11 	. r . 
	jr c,l1787h		;175d	38 28 	8 ( 
l175fh:
	dec (ix+007h)		;175f	dd 35 07 	. 5 . 
	jr nz,l177ch		;1762	20 18 	  . 
	ld a,(ix+00ah)		;1764	dd 7e 0a 	. ~ . 
	inc a			;1767	3c 	< 
l1768h:
	ld (ix+00ah),a		;1768	dd 77 0a 	. w . 
	add a,a			;176b	87 	. 
	ld e,a			;176c	5f 	_ 
	ld d,000h		;176d	16 00 	. . 
	ld hl,l17fch		;176f	21 fc 17 	! . . 
	add hl,de			;1772	19 	. 
	ld a,(hl)			;1773	7e 	~ 
	ld (ix+007h),a		;1774	dd 77 07 	. w . 
	inc hl			;1777	23 	# 
	ld a,(hl)			;1778	7e 	~ 
	ld (ix+006h),a		;1779	dd 77 06 	. w . 
l177ch:
	ld a,(ix+006h)		;177c	dd 7e 06 	. ~ . 
	cp 00fh		;177f	fe 0f 	. . 
	ret c			;1781	d8 	. 
	ld a,c			;1782	79 	y 
	xor 0c0h		;1783	ee c0 	. . 
	ld c,a			;1785	4f 	O 
	ret			;1786	c9 	. 
l1787h:
	ld a,(0e702h)		;1787	3a 02 e7 	: . . 
	cp 003h		;178a	fe 03 	. . 
	jr z,l1796h		;178c	28 08 	( . 
	cp 006h		;178e	fe 06 	. . 
	jr z,l1796h		;1790	28 04 	( . 
	cp 007h		;1792	fe 07 	. . 
	jr nz,l17bah		;1794	20 24 	  $ 
l1796h:
	call sub_1c9eh		;1796	cd 9e 1c 	. . . 
	ld de,l010ch		;1799	11 0c 01 	. . . 
	ld a,091h		;179c	3e 91 	> . 
	call sub_0dfeh		;179e	cd fe 0d 	. . . 
	call sub_2ee2h		;17a1	cd e2 2e 	. . . 
	ld a,007h		;17a4	3e 07 	> . 
	push af			;17a6	f5 	. 
	call sub_1cach		;17a7	cd ac 1c 	. . . 
	ex de,hl			;17aa	eb 	. 
	ld hl,0		;17ab	21 00 00 	! . . 
	sbc hl,de		;17ae	ed 52 	. R 
	call sub_1ca5h		;17b0	cd a5 1c 	. . . 
	set 1,(ix+00bh)		;17b3	dd cb 0b ce 	. . . . 
	pop af			;17b7	f1 	. 
	jr l1768h		;17b8	18 ae 	. . 
l17bah:
	ld (ix+006h),009h		;17ba	dd 36 06 09 	. 6 . . 
	call sub_1c9eh		;17be	cd 9e 1c 	. . . 
	ld de,l0a00h		;17c1	11 00 0a 	. . . 
	add hl,de			;17c4	19 	. 
	xor a			;17c5	af 	. 
	add hl,hl			;17c6	29 	) 
	rlca			;17c7	07 	. 
	ld l,h			;17c8	6c 	l 
	ld h,a			;17c9	67 	g 
	ex de,hl			;17ca	eb 	. 
	call sub_1c8ah		;17cb	cd 8a 1c 	. . . 
	call sub_1ac9h		;17ce	cd c9 1a 	. . . 
	ld a,080h		;17d1	3e 80 	> . 
	jr nz,l17d7h		;17d3	20 02 	  . 
	ld a,082h		;17d5	3e 82 	> . 
l17d7h:
	call sub_2f60h		;17d7	cd 60 2f 	. ` / 
	ld a,091h		;17da	3e 91 	> . 
	call sub_0dfeh		;17dc	cd fe 0d 	. . . 
	ld hl,01c5bh		;17df	21 5b 1c 	! [ . 
	jp l1b96h		;17e2	c3 96 1b 	. . . 
l17e5h:
	ld (ix+001h),00ah		;17e5	dd 36 01 0a 	. 6 . . 
	ld hl,003a0h		;17e9	21 a0 03 	! . . 
	call sub_1ca5h		;17ec	cd a5 1c 	. . . 
	ld hl,00028h		;17ef	21 28 00 	! ( . 
	ld (ix+00eh),l		;17f2	dd 75 0e 	. u . 
	ld (ix+00fh),h		;17f5	dd 74 0f 	. t . 
	xor a			;17f8	af 	. 
	jp l1768h		;17f9	c3 68 17 	. h . 
l17fch:
	inc bc			;17fc	03 	. 
	ld a,(bc)			;17fd	0a 	. 
	rlca			;17fe	07 	. 
	inc c			;17ff	0c 	. 
	rlca			;1800	07 	. 
	dec c			;1801	0d 	. 
	rlca			;1802	07 	. 
	ld c,007h		;1803	0e 07 	. . 
	rrca			;1805	0f 	. 
	rlca			;1806	07 	. 
	djnz $+1		;1807	10 ff 	. . 
	dec bc			;1809	0b 	. 
	inc bc			;180a	03 	. 
	ld a,(bc)			;180b	0a 	. 
	rlca			;180c	07 	. 
	dec c			;180d	0d 	. 
	rlca			;180e	07 	. 
	ld c,007h		;180f	0e 07 	. . 
	rrca			;1811	0f 	. 
	rlca			;1812	07 	. 
	djnz $+1		;1813	10 ff 	. . 
	dec bc			;1815	0b 	. 
	inc bc			;1816	03 	. 
	ld a,(bc)			;1817	0a 	. 
	rlca			;1818	07 	. 
	djnz l1822h		;1819	10 07 	. . 
	rrca			;181b	0f 	. 
	rlca			;181c	07 	. 
	ld c,007h		;181d	0e 07 	. . 
	dec c			;181f	0d 	. 
	rst 38h			;1820	ff 	. 
	dec bc			;1821	0b 	. 
l1822h:
	ld hl,06b2fh		;1822	21 2f 6b 	! / k 
	jp l1632h		;1825	c3 32 16 	. 2 . 
sub_1828h:
	ld de,l1864h		;1828	11 64 18 	. d . 
	call sub_1ad2h		;182b	cd d2 1a 	. . . 
	ret nc			;182e	d0 	. 
	push af			;182f	f5 	. 
	ld a,(0e80bh)		;1830	3a 0b e8 	: . . 
	and 080h		;1833	e6 80 	. . 
	res 6,c		;1835	cb b1 	. . 
	jr z,l183bh		;1837	28 02 	( . 
	set 6,c		;1839	cb f1 	. . 
l183bh:
	ld (ix+000h),c		;183b	dd 71 00 	. q . 
	ld a,091h		;183e	3e 91 	> . 
	call sub_0dfeh		;1840	cd fe 0d 	. . . 
	pop af			;1843	f1 	. 
	jp m,l184bh		;1844	fa 4b 18 	. K . 
	ld a,081h		;1847	3e 81 	> . 
	jr l185eh		;1849	18 13 	. . 
l184bh:
	ld hl,0e2d2h		;184b	21 d2 e2 	! . . 
	inc (hl)			;184e	34 	4 
	ld a,(hl)			;184f	7e 	~ 
	cp 002h		;1850	fe 02 	. . 
	ld a,080h		;1852	3e 80 	> . 
	jp c,l1677h		;1854	da 77 16 	. w . 
	ld a,081h		;1857	3e 81 	> . 
	jp z,l1677h		;1859	ca 77 16 	. w . 
	ld a,084h		;185c	3e 84 	> . 
l185eh:
	ld hl,000beh		;185e	21 be 00 	! . . 
	jp l167ah		;1861	c3 7a 16 	. z . 
l1864h:
	rst 38h			;1864	ff 	. 
	ret p			;1865	f0 	. 
	rst 38h			;1866	ff 	. 
	rst 38h			;1867	ff 	. 
	rst 38h			;1868	ff 	. 
	rst 38h			;1869	ff 	. 
	ld bc,0ffffh		;186a	01 ff ff 	. . . 
	rst 38h			;186d	ff 	. 
l186eh:
	ld hl,l1a72h		;186e	21 72 1a 	! r . 
	push hl			;1871	e5 	. 
	ld hl,0e700h		;1872	21 00 e7 	! . . 
	bit 1,(hl)		;1875	cb 4e 	. N 
	jr nz,l18a3h		;1877	20 2a 	  * 
	ld l,(ix+008h)		;1879	dd 6e 08 	. n . 
	ld h,(ix+009h)		;187c	dd 66 09 	. f . 
	dec hl			;187f	2b 	+ 
	bit 7,h		;1880	cb 7c 	. | 
	jr nz,l188ah		;1882	20 06 	  . 
	ld (ix+008h),l		;1884	dd 75 08 	. u . 
	ld (ix+009h),h		;1887	dd 74 09 	. t . 
l188ah:
	add a,a			;188a	87 	. 
	ld d,000h		;188b	16 00 	. . 
	ld e,a			;188d	5f 	_ 
	ld hl,l1897h		;188e	21 97 18 	! . . 
	add hl,de			;1891	19 	. 
	ld a,(hl)			;1892	7e 	~ 
	inc hl			;1893	23 	# 
	ld h,(hl)			;1894	66 	f 
	ld l,a			;1895	6f 	o 
	jp (hl)			;1896	e9 	. 
l1897h:
	jr z,$+28		;1897	28 1a 	( . 
	xor d			;1899	aa 	. 
	dec de			;189a	1b 	. 
	ld l,h			;189b	6c 	l 
	add hl,de			;189c	19 	. 
	jp nz,0ae19h		;189d	c2 19 ae 	. . . 
	jr l183bh		;18a0	18 99 	. . 
	add hl,de			;18a2	19 	. 
l18a3h:
	push af			;18a3	f5 	. 
	call l1be2h		;18a4	cd e2 1b 	. . . 
	pop af			;18a7	f1 	. 
	cp 005h		;18a8	fe 05 	. . 
	jp z,l19bdh		;18aa	ca bd 19 	. . . 
	ret			;18ad	c9 	. 
	call l1be2h		;18ae	cd e2 1b 	. . . 
	call sub_1a49h		;18b1	cd 49 1a 	. I . 
	jr nc,l18d6h		;18b4	30 20 	0   
l18b6h:
	dec (ix+00ah)		;18b6	dd 35 0a 	. 5 . 
	push af			;18b9	f5 	. 
	ld a,091h		;18ba	3e 91 	> . 
	call sub_0dfeh		;18bc	cd fe 0d 	. . . 
	pop af			;18bf	f1 	. 
	jr z,l18c6h		;18c0	28 04 	( . 
	inc (ix+001h)		;18c2	dd 34 01 	. 4 . 
	ret			;18c5	c9 	. 
l18c6h:
	call l1677h		;18c6	cd 77 16 	. w . 
	ld hl,0e215h		;18c9	21 15 e2 	! . . 
	bit 6,c		;18cc	cb 71 	. q 
	jr z,l18d3h		;18ce	28 03 	( . 
	ld hl,0e235h		;18d0	21 35 e2 	! 5 . 
l18d3h:
	ld (hl),000h		;18d3	36 00 	6 . 
	ret			;18d5	c9 	. 
l18d6h:
	ld de,0ff00h		;18d6	11 00 ff 	. . . 
	ld hl,(0e80ch)		;18d9	2a 0c e8 	* . . 
	add hl,de			;18dc	19 	. 
	jr c,l18eah		;18dd	38 0b 	8 . 
	ld a,005h		;18df	3e 05 	> . 
	ld hl,l005ah		;18e1	21 5a 00 	! Z . 
	ld (ix+006h),002h		;18e4	dd 36 06 02 	. 6 . . 
	jr l194fh		;18e8	18 65 	. e 
l18eah:
	ld a,(ix+008h)		;18ea	dd 7e 08 	. ~ . 
	and a			;18ed	a7 	. 
	jp z,l19fdh		;18ee	ca fd 19 	. . . 
	ld a,(ix+006h)		;18f1	dd 7e 06 	. ~ . 
	cp 002h		;18f4	fe 02 	. . 
	jr z,l195dh		;18f6	28 65 	( e 
	dec (ix+007h)		;18f8	dd 35 07 	. 5 . 
	ret nz			;18fb	c0 	. 
	ld a,(ix+00eh)		;18fc	dd 7e 0e 	. ~ . 
l18ffh:
	and a			;18ff	a7 	. 
	jp nz,l1942h		;1900	c2 42 19 	. B . 
	ld hl,0e32bh		;1903	21 2b e3 	! + . 
	ld a,(hl)			;1906	7e 	~ 
	cp 003h		;1907	fe 03 	. . 
	inc (ix+007h)		;1909	dd 34 07 	. 4 . 
	ret nc			;190c	d0 	. 
	add a,a			;190d	87 	. 
	add a,(hl)			;190e	86 	. 
	inc (hl)			;190f	34 	4 
	inc hl			;1910	23 	# 
	ld d,000h		;1911	16 00 	. . 
	ld e,a			;1913	5f 	_ 
	add hl,de			;1914	19 	. 
	push hl			;1915	e5 	. 
	call sub_1c8ah		;1916	cd 8a 1c 	. . . 
	ld de,l00c0h		;1919	11 c0 00 	. . . 
	ld a,c			;191c	79 	y 
	and 040h		;191d	e6 40 	. @ 
	jr z,l1924h		;191f	28 03 	( . 
	add hl,de			;1921	19 	. 
	jr l1926h		;1922	18 02 	. . 
l1924h:
	sbc hl,de		;1924	ed 52 	. R 
l1926h:
	ex de,hl			;1926	eb 	. 
	pop hl			;1927	e1 	. 
	ld b,a			;1928	47 	G 
	ld a,(ix+006h)		;1929	dd 7e 06 	. ~ . 
	sub 009h		;192c	d6 09 	. . 
	or b			;192e	b0 	. 
	ld (hl),a			;192f	77 	w 
	inc hl			;1930	23 	# 
sub_1931h:
	ld (hl),e			;1931	73 	s 
	inc hl			;1932	23 	# 
	ld (hl),d			;1933	72 	r 
	call sub_1dbfh		;1934	cd bf 1d 	. . . 
	dec (ix+00eh)		;1937	dd 35 0e 	. 5 . 
	ld (ix+007h),010h		;193a	dd 36 07 10 	. 6 . . 
	inc (ix+006h)		;193e	dd 34 06 	. 4 . 
	ret			;1941	c9 	. 
l1942h:
	ld (ix+006h),002h		;1942	dd 36 06 02 	. 6 . . 
	dec (ix+00bh)		;1946	dd 35 0b 	. 5 . 
	ret nz			;1949	c0 	. 
	ld hl,(0e1f5h)		;194a	2a f5 e1 	* . . 
	ld a,003h		;194d	3e 03 	> . 
l194fh:
	ld (ix+008h),l		;194f	dd 75 08 	. u . 
	ld (ix+009h),h		;1952	dd 74 09 	. t . 
	ld (ix+001h),a		;1955	dd 77 01 	. w . 
	ld (ix+007h),002h		;1958	dd 36 07 02 	. 6 . . 
	ret			;195c	c9 	. 
l195dh:
	ld hl,(0e80ch)		;195d	2a 0c e8 	* . . 
	ld de,0f5a0h		;1960	11 a0 f5 	. . . 
	add hl,de			;1963	19 	. 
	ld hl,l005ah		;1964	21 5a 00 	! Z . 
	ld a,000h		;1967	3e 00 	> . 
	jr c,l194fh		;1969	38 e4 	8 . 
	ret			;196b	c9 	. 
	call l1be2h		;196c	cd e2 1b 	. . . 
	ld a,002h		;196f	3e 02 	> . 
	cp (ix+006h)		;1971	dd be 06 	. . . 
	jr z,l1982h		;1974	28 0c 	( . 
	dec (ix+007h)		;1976	dd 35 07 	. 5 . 
	ret nz			;1979	c0 	. 
	ld (ix+006h),a		;197a	dd 77 06 	. w . 
	ld (ix+007h),003h		;197d	dd 36 07 03 	. 6 . . 
	ret			;1981	c9 	. 
l1982h:
	call sub_1a49h		;1982	cd 49 1a 	. I . 
	jp c,l18b6h		;1985	da b6 18 	. . . 
	dec (ix+007h)		;1988	dd 35 07 	. 5 . 
	ret nz			;198b	c0 	. 
	ld (ix+008h),004h		;198c	dd 36 08 04 	. 6 . . 
	ld (ix+009h),000h		;1990	dd 36 09 00 	. 6 . . 
	ld (ix+001h),003h		;1994	dd 36 01 03 	. 6 . . 
	ret			;1998	c9 	. 
	call sub_1befh		;1999	cd ef 1b 	. . . 
	call sub_1a49h		;199c	cd 49 1a 	. I . 
	jp c,l18b6h		;199f	da b6 18 	. . . 
	ld a,(ix+008h)		;19a2	dd 7e 08 	. ~ . 
	and a			;19a5	a7 	. 
	jr nz,l19aeh		;19a6	20 06 	  . 
	ld a,(ix+009h)		;19a8	dd 7e 09 	. ~ . 
	and a			;19ab	a7 	. 
	jr z,l19f3h		;19ac	28 45 	( E 
l19aeh:
	ld de,0f600h		;19ae	11 00 f6 	. . . 
	ld hl,(0e80ch)		;19b1	2a 0c e8 	* . . 
	add hl,de			;19b4	19 	. 
	jp c,l1a3ch		;19b5	da 3c 1a 	. < . 
	call sub_1ab8h		;19b8	cd b8 1a 	. . . 
	jr c,l1a3ch		;19bb	38 7f 	8  
l19bdh:
	ld a,c			;19bd	79 	y 
	xor 040h		;19be	ee 40 	. @ 
	ld c,a			;19c0	4f 	O 
	ret			;19c1	c9 	. 
	call l1be2h		;19c2	cd e2 1b 	. . . 
	call sub_1a49h		;19c5	cd 49 1a 	. I . 
	jp c,l18b6h		;19c8	da b6 18 	. . . 
	ld a,(ix+008h)		;19cb	dd 7e 08 	. ~ . 
	and a			;19ce	a7 	. 
	jr nz,l19d7h		;19cf	20 06 	  . 
	ld a,(ix+009h)		;19d1	dd 7e 09 	. ~ . 
	and a			;19d4	a7 	. 
	jr z,l19f3h		;19d5	28 1c 	( . 
l19d7h:
	ld de,0f700h		;19d7	11 00 f7 	. . . 
	ld hl,(0e80ch)		;19da	2a 0c e8 	* . . 
	add hl,de			;19dd	19 	. 
	jr nc,l19eah		;19de	30 0a 	0 . 
	ld de,0fe00h		;19e0	11 00 fe 	. . . 
	add hl,de			;19e3	19 	. 
	ret nc			;19e4	d0 	. 
	ld (ix+001h),000h		;19e5	dd 36 01 00 	. 6 . . 
	ret			;19e9	c9 	. 
l19eah:
	call sub_1ab8h		;19ea	cd b8 1a 	. . . 
	ret c			;19ed	d8 	. 
	ld (ix+001h),005h		;19ee	dd 36 01 05 	. 6 . . 
	ret			;19f2	c9 	. 
l19f3h:
	ld (ix+001h),004h		;19f3	dd 36 01 04 	. 6 . . 
	ld a,(0e1f0h)		;19f7	3a f0 e1 	: . . 
	ld (ix+00bh),a		;19fa	dd 77 0b 	. w . 
l19fdh:
	ld hl,0e1f1h		;19fd	21 f1 e1 	! . . 
	ld a,(0e010h)		;1a00	3a 10 e0 	: . . 
	cp (hl)			;1a03	be 	. 
	ld a,009h		;1a04	3e 09 	> . 
	jr c,l1a0ah		;1a06	38 02 	8 . 
	ld a,00bh		;1a08	3e 0b 	> . 
l1a0ah:
	ld (ix+006h),a		;1a0a	dd 77 06 	. w . 
	inc hl			;1a0d	23 	# 
	ld a,(0e011h)		;1a0e	3a 11 e0 	: . . 
	cp 055h		;1a11	fe 55 	. U 
	jr c,l1a1bh		;1a13	38 06 	8 . 
	inc hl			;1a15	23 	# 
	cp 0aah		;1a16	fe aa 	. . 
	jr c,l1a1bh		;1a18	38 01 	8 . 
	inc hl			;1a1a	23 	# 
l1a1bh:
	ld a,(hl)			;1a1b	7e 	~ 
	ld (ix+008h),a		;1a1c	dd 77 08 	. w . 
	ld (ix+00eh),000h		;1a1f	dd 36 0e 00 	. 6 . . 
	ld (ix+007h),00bh		;1a23	dd 36 07 0b 	. 6 . . 
	ret			;1a27	c9 	. 
	call sub_1be7h		;1a28	cd e7 1b 	. . . 
	ld de,0f600h		;1a2b	11 00 f6 	. . . 
	add hl,de			;1a2e	19 	. 
	ret c			;1a2f	d8 	. 
	ld a,(ix+008h)		;1a30	dd 7e 08 	. ~ . 
	and a			;1a33	a7 	. 
	jr nz,l1a3ch		;1a34	20 06 	  . 
	ld a,(ix+009h)		;1a36	dd 7e 09 	. ~ . 
	and a			;1a39	a7 	. 
	jr z,l19f3h		;1a3a	28 b7 	( . 
l1a3ch:
	ld (ix+001h),003h		;1a3c	dd 36 01 03 	. 6 . . 
	ld (ix+006h),002h		;1a40	dd 36 06 02 	. 6 . . 
	ld (ix+007h),002h		;1a44	dd 36 07 02 	. 6 . . 
	ret			;1a48	c9 	. 
sub_1a49h:
	ld a,(0e701h)		;1a49	3a 01 e7 	: . . 
	and 003h		;1a4c	e6 03 	. . 
	jr nz,l1a54h		;1a4e	20 04 	  . 
	res 2,(ix+000h)		;1a50	dd cb 00 96 	. . . . 
l1a54h:
	bit 2,(ix+000h)		;1a54	dd cb 00 56 	. . . V 
	ret nz			;1a58	c0 	. 
	ld de,l1680h		;1a59	11 80 16 	. . . 
	call sub_1ad2h		;1a5c	cd d2 1a 	. . . 
	ret nc			;1a5f	d0 	. 
	set 2,(ix+000h)		;1a60	dd cb 00 d6 	. . . . 
	ld a,085h		;1a64	3e 85 	> . 
	ret p			;1a66	f0 	. 
	call sub_1ac9h		;1a67	cd c9 1a 	. . . 
	ld a,083h		;1a6a	3e 83 	> . 
	jr nz,l1a70h		;1a6c	20 02 	  . 
	ld a,087h		;1a6e	3e 87 	> . 
l1a70h:
	scf			;1a70	37 	7 
	ret			;1a71	c9 	. 
l1a72h:
	ld hl,(0e80ch)		;1a72	2a 0c e8 	* . . 
	ld de,0e400h		;1a75	11 00 e4 	. . . 
	add hl,de			;1a78	19 	. 
	ret c			;1a79	d8 	. 
	ld hl,06be7h		;1a7a	21 e7 6b 	! . k 
l1a7dh:
	ld a,c			;1a7d	79 	y 
l1a7eh:
	xor 040h		;1a7e	ee 40 	. @ 
l1a80h:
	and 0c0h		;1a80	e6 c0 	. . 
	bit 4,(ix+000h)		;1a82	dd cb 00 66 	. . . f 
	ret z			;1a86	c8 	. 
	ex de,hl			;1a87	eb 	. 
	call sub_1c9eh		;1a88	cd 9e 1c 	. . . 
	add hl,hl			;1a8b	29 	) 
	ld l,h			;1a8c	6c 	l 
	ld h,000h		;1a8d	26 00 	& . 
	rl h		;1a8f	cb 14 	. . 
	ld (0e807h),hl		;1a91	22 07 e8 	" . . 
	ld hl,(0e80ah)		;1a94	2a 0a e8 	* . . 
	ld c,(ix+006h)		;1a97	dd 4e 06 	. N . 
sub_1a9ah:
	push de			;1a9a	d5 	. 
	ld b,000h		;1a9b	06 00 	. . 
	ld d,0ffh		;1a9d	16 ff 	. . 
	add hl,hl			;1a9f	29 	) 
	jr c,l1aa3h		;1aa0	38 01 	8 . 
	ld d,b			;1aa2	50 	P 
l1aa3h:
	add hl,hl			;1aa3	29 	) 
	add hl,hl			;1aa4	29 	) 
	ld e,h			;1aa5	5c 	\ 
	ld hl,(0e715h)		;1aa6	2a 15 e7 	* . . 
	add hl,de			;1aa9	19 	. 
	ld (0e803h),hl		;1aaa	22 03 e8 	" . . 
	ex de,hl			;1aad	eb 	. 
	pop hl			;1aae	e1 	. 
	add hl,bc			;1aaf	09 	. 
	add hl,bc			;1ab0	09 	. 
	ld c,(hl)			;1ab1	4e 	N 
	inc hl			;1ab2	23 	# 
	ld h,(hl)			;1ab3	66 	f 
	ld l,c			;1ab4	69 	i 
	jp l0e20h		;1ab5	c3 20 0e 	.   . 
sub_1ab8h:
	call sub_1c91h		;1ab8	cd 91 1c 	. . . 
	ld hl,(0e106h)		;1abb	2a 06 e1 	* . . 
	bit 6,c		;1abe	cb 71 	. q 
	jr z,l1ac6h		;1ac0	28 04 	( . 
	ld hl,(0e104h)		;1ac2	2a 04 e1 	* . . 
	ex de,hl			;1ac5	eb 	. 
l1ac6h:
	sbc hl,de		;1ac6	ed 52 	. R 
	ret			;1ac8	c9 	. 
sub_1ac9h:
	ld a,(0e702h)		;1ac9	3a 02 e7 	: . . 
	cp 008h		;1acc	fe 08 	. . 
	ret z			;1ace	c8 	. 
	cp 009h		;1acf	fe 09 	. . 
	ret			;1ad1	c9 	. 
sub_1ad2h:
	push de			;1ad2	d5 	. 
	call sub_1ae7h		;1ad3	cd e7 1a 	. . . 
	pop hl			;1ad6	e1 	. 
	ret nc			;1ad7	d0 	. 
	call sub_1b18h		;1ad8	cd 18 1b 	. . . 
	ret nc			;1adb	d0 	. 
	push af			;1adc	f5 	. 
	and 00fh		;1add	e6 0f 	. . 
	call sub_1b8eh		;1adf	cd 8e 1b 	. . . 
	call sub_1c91h		;1ae2	cd 91 1c 	. . . 
	pop af			;1ae5	f1 	. 
	ret			;1ae6	c9 	. 
sub_1ae7h:
	ld a,(0e80bh)		;1ae7	3a 0b e8 	: . . 
	ld b,a			;1aea	47 	G 
	ld a,(0e701h)		;1aeb	3a 01 e7 	: . . 
	rlca			;1aee	07 	. 
	xor b			;1aef	a8 	. 
	and 080h		;1af0	e6 80 	. . 
	ret z			;1af2	c8 	. 
	ld a,(0e701h)		;1af3	3a 01 e7 	: . . 
	and 003h		;1af6	e6 03 	. . 
	ret z			;1af8	c8 	. 
	and 002h		;1af9	e6 02 	. . 
	ld de,l02c0h		;1afb	11 c0 02 	. . . 
	ld b,005h		;1afe	06 05 	. . 
	jr nz,l1b06h		;1b00	20 04 	  . 
	ld de,00400h		;1b02	11 00 04 	. . . 
	ld b,a			;1b05	47 	G 
l1b06h:
	sbc hl,de		;1b06	ed 52 	. R 
	ret nc			;1b08	d0 	. 
	ld a,(0e702h)		;1b09	3a 02 e7 	: . . 
	cp 006h		;1b0c	fe 06 	. . 
	ret c			;1b0e	d8 	. 
	inc b			;1b0f	04 	. 
	sub 008h		;1b10	d6 08 	. . 
	ret c			;1b12	d8 	. 
	inc b			;1b13	04 	. 
	add a,b			;1b14	80 	. 
	ld b,a			;1b15	47 	G 
	scf			;1b16	37 	7 
	ret			;1b17	c9 	. 
sub_1b18h:
	ld e,b			;1b18	58 	X 
	ld d,000h		;1b19	16 00 	. . 
	add hl,de			;1b1b	19 	. 
	ld a,(hl)			;1b1c	7e 	~ 
	cp 0ffh		;1b1d	fe ff 	. . 
	ret			;1b1f	c9 	. 
l1b20h:
	call sub_1208h		;1b20	cd 08 12 	. . . 
	jr nz,sub_1b7ah		;1b23	20 55 	  U 
	ld a,(0e81ch)		;1b25	3a 1c e8 	: . . 
	and a			;1b28	a7 	. 
	ld a,002h		;1b29	3e 02 	> . 
	jr nz,l1b37h		;1b2b	20 0a 	  . 
	in a,(003h)		;1b2d	db 03 	. . 
	and 002h		;1b2f	e6 02 	. . 
	ld a,004h		;1b31	3e 04 	> . 
	jr nz,l1b37h		;1b33	20 02 	  . 
	ld a,003h		;1b35	3e 03 	> . 
l1b37h:
	ld (ix+007h),a		;1b37	dd 77 07 	. w . 
	ld (ix+006h),009h		;1b3a	dd 36 06 09 	. 6 . . 
	ld (ix+001h),009h		;1b3e	dd 36 01 09 	. 6 . . 
	ld hl,0e71ah		;1b42	21 1a e7 	! . . 
	inc (hl)			;1b45	34 	4 
	call sub_1c61h		;1b46	cd 61 1c 	. a . 
	ld (ix+00fh),a		;1b49	dd 77 0f 	. w . 
	ld (ix+00bh),006h		;1b4c	dd 36 0b 06 	. 6 . . 
	ld (ix+00eh),005h		;1b50	dd 36 0e 05 	. 6 . . 
sub_1b54h:
	bit 2,(ix+000h)		;1b54	dd cb 00 56 	. . . V 
	ld hl,0e71bh		;1b58	21 1b e7 	! . . 
	jr z,l1b5fh		;1b5b	28 02 	( . 
	inc hl			;1b5d	23 	# 
	inc hl			;1b5e	23 	# 
l1b5fh:
	bit 6,(ix+000h)		;1b5f	dd cb 00 76 	. . . v 
	ld de,0ff80h		;1b63	11 80 ff 	. . . 
	jr nz,l1b6ch		;1b66	20 04 	  . 
	inc hl			;1b68	23 	# 
	ld de,l0080h		;1b69	11 80 00 	. . . 
l1b6ch:
	inc (hl)			;1b6c	34 	4 
	ld b,(hl)			;1b6d	46 	F 
	ld hl,(0e712h)		;1b6e	2a 12 e7 	* . . 
l1b71h:
	add hl,de			;1b71	19 	. 
	djnz l1b71h		;1b72	10 fd 	. . 
	call sub_1c83h		;1b74	cd 83 1c 	. . . 
	jp l1be2h		;1b77	c3 e2 1b 	. . . 
sub_1b7ah:
	bit 1,(ix+000h)		;1b7a	dd cb 00 4e 	. . . N 
	jr nz,l1b89h		;1b7e	20 09 	  . 
	ld (ix+000h),000h		;1b80	dd 36 00 00 	. 6 . . 
	ld hl,0e261h		;1b84	21 61 e2 	! a . 
	dec (hl)			;1b87	35 	5 
	ret			;1b88	c9 	. 
l1b89h:
	res 4,(ix+000h)		;1b89	dd cb 00 a6 	. . . . 
	ret			;1b8d	c9 	. 
sub_1b8eh:
	add a,004h		;1b8e	c6 04 	. . 
l1b90h:
	ld (ix+006h),a		;1b90	dd 77 06 	. w . 
	ld hl,l1c55h		;1b93	21 55 1c 	! U . 
l1b96h:
	ld (ix+001h),001h		;1b96	dd 36 01 01 	. 6 . . 
	ld a,(hl)			;1b9a	7e 	~ 
	inc hl			;1b9b	23 	# 
	ld (ix+007h),a		;1b9c	dd 77 07 	. w . 
	call sub_1ca5h		;1b9f	cd a5 1c 	. . . 
	xor a			;1ba2	af 	. 
	ld (ix+00eh),a		;1ba3	dd 77 0e 	. w . 
	ld (ix+00fh),a		;1ba6	dd 77 0f 	. w . 
	ret			;1ba9	c9 	. 
l1baah:
	dec (ix+007h)		;1baa	dd 35 07 	. 5 . 
	jp nz,l1bc4h		;1bad	c2 c4 1b 	. . . 
	call sub_1cach		;1bb0	cd ac 1c 	. . . 
	ld a,(hl)			;1bb3	7e 	~ 
	and a			;1bb4	a7 	. 
	jp m,sub_1b7ah		;1bb5	fa 7a 1b 	. z . 
	inc hl			;1bb8	23 	# 
	ld (ix+006h),a		;1bb9	dd 77 06 	. w . 
	ld a,(hl)			;1bbc	7e 	~ 
	inc hl			;1bbd	23 	# 
	ld (ix+007h),a		;1bbe	dd 77 07 	. w . 
	call sub_1ca5h		;1bc1	cd a5 1c 	. . . 
l1bc4h:
	ld e,(ix+00eh)		;1bc4	dd 5e 0e 	. ^ . 
	ld d,(ix+00fh)		;1bc7	dd 56 0f 	. V . 
	ld hl,l0016h		;1bca	21 16 00 	! . . 
	add hl,de			;1bcd	19 	. 
	ld (ix+00eh),l		;1bce	dd 75 0e 	. u . 
	ld (ix+00fh),h		;1bd1	dd 74 0f 	. t . 
	call sub_1c9eh		;1bd4	cd 9e 1c 	. . . 
	sbc hl,de		;1bd7	ed 52 	. R 
	call sub_1c97h		;1bd9	cd 97 1c 	. . . 
	ld de,l0039h		;1bdc	11 39 00 	. 9 . 
	call sub_1c7ah		;1bdf	cd 7a 1c 	. z . 
l1be2h:
	call sub_1c8ah		;1be2	cd 8a 1c 	. . . 
	jr l1c08h		;1be5	18 21 	. ! 
sub_1be7h:
	ld de,l0036h		;1be7	11 36 00 	. 6 . 
l1beah:
	call sub_1c70h		;1bea	cd 70 1c 	. p . 
	jr l1bf5h		;1bed	18 06 	. . 
sub_1befh:
	ld de,l0036h		;1bef	11 36 00 	. 6 . 
l1bf2h:
	call sub_1c7ah		;1bf2	cd 7a 1c 	. z . 
l1bf5h:
	dec (ix+007h)		;1bf5	dd 35 07 	. 5 . 
	jr nz,l1c08h		;1bf8	20 0e 	  . 
	ld (ix+007h),007h		;1bfa	dd 36 07 07 	. 6 . . 
	dec (ix+006h)		;1bfe	dd 35 06 	. 5 . 
	jp p,l1c08h		;1c01	f2 08 1c 	. . . 
	ld (ix+006h),003h		;1c04	dd 36 06 03 	. 6 . . 
l1c08h:
	ld de,(0e712h)		;1c08	ed 5b 12 e7 	. [ . . 
	ld a,e			;1c0c	7b 	{ 
	and 0e0h		;1c0d	e6 e0 	. . 
	ld e,a			;1c0f	5f 	_ 
	ld a,l			;1c10	7d 	} 
	and 0e0h		;1c11	e6 e0 	. . 
	ld l,a			;1c13	6f 	o 
	sbc hl,de		;1c14	ed 52 	. R 
	ld (0e80ah),hl		;1c16	22 0a e8 	" . . 
	jr nc,l1c21h		;1c19	30 06 	0 . 
	ld de,0001h		;1c1b	11 01 00 	. . . 
	ex de,hl			;1c1e	eb 	. 
	sbc hl,de		;1c1f	ed 52 	. R 
l1c21h:
	ld (0e80ch),hl		;1c21	22 0c e8 	" . . 
	and a			;1c24	a7 	. 
	ret			;1c25	c9 	. 
sub_1c26h:
	ld hl,(0e712h)		;1c26	2a 12 e7 	* . . 
	ld de,l1000h		;1c29	11 00 10 	. . . 
	add hl,de			;1c2c	19 	. 
	call sub_1c91h		;1c2d	cd 91 1c 	. . . 
	sbc hl,de		;1c30	ed 52 	. R 
	ret c			;1c32	d8 	. 
	res 5,(ix+000h)		;1c33	dd cb 00 ae 	. . . . 
	ld hl,0e260h		;1c37	21 60 e2 	! ` . 
	res 5,(hl)		;1c3a	cb ae 	. . 
	ret			;1c3c	c9 	. 
sub_1c3dh:
	call sub_1c8ah		;1c3d	cd 8a 1c 	. . . 
	ld de,l1000h		;1c40	11 00 10 	. . . 
	add hl,de			;1c43	19 	. 
	ld de,(0e712h)		;1c44	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;1c48	ed 52 	. R 
	ret c			;1c4a	d8 	. 
	res 3,(ix+000h)		;1c4b	dd cb 00 9e 	. . . . 
	ld hl,0e260h		;1c4f	21 60 e2 	! ` . 
	res 3,(hl)		;1c52	cb 9e 	. . 
	ret			;1c54	c9 	. 
l1c55h:
	dec b			;1c55	05 	. 
	rlca			;1c56	07 	. 
	rlca			;1c57	07 	. 
	ex af,af'			;1c58	08 	. 
	defb 011h, 0ffh, 005h
	rlca			;1c5c	07 	. 
	ld a,(bc)			;1c5d	0a 	. 
	ex af,af'			;1c5e	08 	. 
	rla			;1c5f	17 	. 
	rst 38h			;1c60	ff 	. 
sub_1c61h:
	ld a,(0e000h)		;1c61	3a 00 e0 	: . . 
	cp 006h		;1c64	fe 06 	. . 
	ld a,(0e909h)		;1c66	3a 09 e9 	: . . 
	ret z			;1c69	c8 	. 
	ld a,(0e907h)		;1c6a	3a 07 e9 	: . . 
	and 00fh		;1c6d	e6 0f 	. . 
	ret			;1c6f	c9 	. 
sub_1c70h:
	call sub_1c8ah		;1c70	cd 8a 1c 	. . . 
	bit 6,c		;1c73	cb 71 	. q 
	jr z,l1c81h		;1c75	28 0a 	( . 
l1c77h:
	add hl,de			;1c77	19 	. 
	jr sub_1c83h		;1c78	18 09 	. . 
sub_1c7ah:
	call sub_1c8ah		;1c7a	cd 8a 1c 	. . . 
	bit 6,c		;1c7d	cb 71 	. q 
	jr z,l1c77h		;1c7f	28 f6 	( . 
l1c81h:
	sbc hl,de		;1c81	ed 52 	. R 
sub_1c83h:
	ld (ix+002h),l		;1c83	dd 75 02 	. u . 
	ld (ix+003h),h		;1c86	dd 74 03 	. t . 
	ret			;1c89	c9 	. 
sub_1c8ah:
	ld l,(ix+002h)		;1c8a	dd 6e 02 	. n . 
	ld h,(ix+003h)		;1c8d	dd 66 03 	. f . 
	ret			;1c90	c9 	. 
sub_1c91h:
	ex de,hl			;1c91	eb 	. 
	call sub_1c8ah		;1c92	cd 8a 1c 	. . . 
	ex de,hl			;1c95	eb 	. 
	ret			;1c96	c9 	. 
sub_1c97h:
	ld (ix+004h),l		;1c97	dd 75 04 	. u . 
	ld (ix+005h),h		;1c9a	dd 74 05 	. t . 
	ret			;1c9d	c9 	. 
sub_1c9eh:
	ld l,(ix+004h)		;1c9e	dd 6e 04 	. n . 
	ld h,(ix+005h)		;1ca1	dd 66 05 	. f . 
	ret			;1ca4	c9 	. 
sub_1ca5h:
	ld (ix+00ch),l		;1ca5	dd 75 0c 	. u . 
	ld (ix+00dh),h		;1ca8	dd 74 0d 	. t . 
	ret			;1cab	c9 	. 
sub_1cach:
	ld l,(ix+00ch)		;1cac	dd 6e 0c 	. n . 
	ld h,(ix+00dh)		;1caf	dd 66 0d 	. f . 
	ret			;1cb2	c9 	. 
sub_1cb3h:
	call sub_1e4ah		;1cb3	cd 4a 1e 	. J . 
	call sub_1dfdh		;1cb6	cd fd 1d 	. . . 
	ld ix,0e2fbh		;1cb9	dd 21 fb e2 	. ! . . 
	call sub_1cc4h		;1cbd	cd c4 1c 	. . . 
	ld ix,0e30bh		;1cc0	dd 21 0b e3 	. ! . . 
sub_1cc4h:
	ld a,(ix+000h)		;1cc4	dd 7e 00 	. ~ . 
	ld c,a			;1cc7	4f 	O 
	and 010h		;1cc8	e6 10 	. . 
	ret z			;1cca	c8 	. 
	ld a,(0e700h)		;1ccb	3a 00 e7 	: . . 
	and 002h		;1cce	e6 02 	. . 
	jp nz,l1da7h		;1cd0	c2 a7 1d 	. . . 
	ld a,(ix+001h)		;1cd3	dd 7e 01 	. ~ . 
	cp 001h		;1cd6	fe 01 	. . 
	jp c,l1d4bh		;1cd8	da 4b 1d 	. K . 
	jr z,l1d03h		;1cdb	28 26 	( & 
	call sub_1de9h		;1cdd	cd e9 1d 	. . . 
	ld a,(0e2d9h)		;1ce0	3a d9 e2 	: . . 
	cp 001h		;1ce3	fe 01 	. . 
	jr z,l1ceeh		;1ce5	28 07 	( . 
	ld a,(0e2d8h)		;1ce7	3a d8 e2 	: . . 
	and 010h		;1cea	e6 10 	. . 
	jr nz,l1d5bh		;1cec	20 6d 	  m 
l1ceeh:
	ld de,(0e712h)		;1cee	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;1cf2	ed 52 	. R 
	jp c,l1d5bh		;1cf4	da 5b 1d 	. [ . 
	ld de,0ec00h		;1cf7	11 00 ec 	. . . 
	add hl,de			;1cfa	19 	. 
	jr nc,l1d5bh		;1cfb	30 5e 	0 ^ 
	ld (ix+000h),000h		;1cfd	dd 36 00 00 	. 6 . . 
	jr l1d5bh		;1d01	18 58 	. X 
l1d03h:
	ld a,(ix+00bh)		;1d03	dd 7e 0b 	. ~ . 
	ld l,(ix+004h)		;1d06	dd 6e 04 	. n . 
	ld h,(ix+005h)		;1d09	dd 66 05 	. f . 
	bit 0,a		;1d0c	cb 47 	. G 
	jr z,l1d1ch		;1d0e	28 0c 	( . 
	ld de,(0e1bfh)		;1d10	ed 5b bf e1 	. [ . . 
	cp 003h		;1d14	fe 03 	. . 
	jr z,l1d20h		;1d16	28 08 	( . 
	sbc hl,de		;1d18	ed 52 	. R 
	jr l1d21h		;1d1a	18 05 	. . 
l1d1ch:
	ld de,(0e1bdh)		;1d1c	ed 5b bd e1 	. [ . . 
l1d20h:
	add hl,de			;1d20	19 	. 
l1d21h:
	ld (ix+004h),l		;1d21	dd 75 04 	. u . 
	ld (ix+005h),h		;1d24	dd 74 05 	. t . 
	ld l,(ix+00ch)		;1d27	dd 6e 0c 	. n . 
	ld h,(ix+00dh)		;1d2a	dd 66 0d 	. f . 
	ld de,(0e1bbh)		;1d2d	ed 5b bb e1 	. [ . . 
	add hl,de			;1d31	19 	. 
	ld (ix+00ch),l		;1d32	dd 75 0c 	. u . 
	ld (ix+00dh),h		;1d35	dd 74 0d 	. t . 
	call sub_1defh		;1d38	cd ef 1d 	. . . 
	ld e,(ix+00eh)		;1d3b	dd 5e 0e 	. ^ . 
	ld d,(ix+00fh)		;1d3e	dd 56 0f 	. V . 
	sbc hl,de		;1d41	ed 52 	. R 
	jr c,l1d5bh		;1d43	38 16 	8 . 
	res 5,(ix+000h)		;1d45	dd cb 00 ae 	. . . . 
	jr l1d58h		;1d49	18 0d 	. . 
l1d4bh:
	call sub_1de9h		;1d4b	cd e9 1d 	. . . 
	ld e,(ix+00eh)		;1d4e	dd 5e 0e 	. ^ . 
	ld d,(ix+00fh)		;1d51	dd 56 0f 	. V . 
	sbc hl,de		;1d54	ed 52 	. R 
	jr nc,l1d5bh		;1d56	30 03 	0 . 
l1d58h:
	inc (ix+001h)		;1d58	dd 34 01 	. 4 . 
l1d5bh:
	bit 5,(ix+000h)		;1d5b	dd cb 00 6e 	. . . n 
	jr nz,l1d8fh		;1d5f	20 2e 	  . 
	ld l,(ix+002h)		;1d61	dd 6e 02 	. n . 
	ld h,(ix+003h)		;1d64	dd 66 03 	. f . 
	ld de,0ff40h		;1d67	11 40 ff 	. @ . 
	add hl,de			;1d6a	19 	. 
	ld (0e80fh),hl		;1d6b	22 0f e8 	" . . 
	ld de,l017fh+1		;1d6e	11 80 01 	. . . 
	add hl,de			;1d71	19 	. 
	ld (0e811h),hl		;1d72	22 11 e8 	" . . 
	ld l,(ix+004h)		;1d75	dd 6e 04 	. n . 
	ld h,(ix+005h)		;1d78	dd 66 05 	. f . 
	ld de,0006h+2		;1d7b	11 08 00 	. . . 
	push hl			;1d7e	e5 	. 
	call sub_1172h		;1d7f	cd 72 11 	. r . 
	pop hl			;1d82	e1 	. 
	jr nc,l1d8fh		;1d83	30 0a 	0 . 
	ld de,00118h		;1d85	11 18 01 	. . . 
	call sub_2c9ah		;1d88	cd 9a 2c 	. . , 
	set 5,(ix+000h)		;1d8b	dd cb 00 ee 	. . . . 
l1d8fh:
	dec (ix+007h)		;1d8f	dd 35 07 	. 5 . 
	jr nz,l1da7h		;1d92	20 13 	  . 
	ld (ix+007h),002h		;1d94	dd 36 07 02 	. 6 . . 
	ld a,(ix+006h)		;1d98	dd 7e 06 	. ~ . 
	inc a			;1d9b	3c 	< 
	cp 006h		;1d9c	fe 06 	. . 
	jr c,l1da4h		;1d9e	38 04 	8 . 
	call sub_1dbfh		;1da0	cd bf 1d 	. . . 
	xor a			;1da3	af 	. 
l1da4h:
	ld (ix+006h),a		;1da4	dd 77 06 	. w . 
l1da7h:
	call l1be2h		;1da7	cd e2 1b 	. . . 
	ld de,0e800h		;1daa	11 00 e8 	. . . 
	add hl,de			;1dad	19 	. 
	ret c			;1dae	d8 	. 
	ld a,(ix+006h)		;1daf	dd 7e 06 	. ~ . 
	cp 003h		;1db2	fe 03 	. . 
	ld a,040h		;1db4	3e 40 	> @ 
	jr c,l1db9h		;1db6	38 01 	8 . 
	xor a			;1db8	af 	. 
l1db9h:
	ld hl,075a5h		;1db9	21 a5 75 	! . u 
	jp l1a7eh		;1dbc	c3 7e 1a 	. ~ . 
sub_1dbfh:
	push hl			;1dbf	e5 	. 
	push de			;1dc0	d5 	. 
	ld hl,(0e003h)		;1dc1	2a 03 e0 	* . . 
	ld de,0fccdh		;1dc4	11 cd fc 	. . . 
	add hl,de			;1dc7	19 	. 
	ld a,095h		;1dc8	3e 95 	> . 
	jr c,l1dceh		;1dca	38 02 	8 . 
	ld a,099h		;1dcc	3e 99 	> . 
l1dceh:
	call sub_0dfeh		;1dce	cd fe 0d 	. . . 
	pop de			;1dd1	d1 	. 
	pop hl			;1dd2	e1 	. 
	ret			;1dd3	c9 	. 
sub_1dd4h:
	push hl			;1dd4	e5 	. 
	push de			;1dd5	d5 	. 
	ld hl,(0e003h)		;1dd6	2a 03 e0 	* . . 
	ld de,0fccdh		;1dd9	11 cd fc 	. . . 
	add hl,de			;1ddc	19 	. 
	ld a,092h		;1ddd	3e 92 	> . 
	jr c,l1de3h		;1ddf	38 02 	8 . 
	ld a,09ah		;1de1	3e 9a 	> . 
l1de3h:
	call sub_0dfeh		;1de3	cd fe 0d 	. . . 
	pop de			;1de6	d1 	. 
	pop hl			;1de7	e1 	. 
	ret			;1de8	c9 	. 
sub_1de9h:
	ld l,(ix+00ch)		;1de9	dd 6e 0c 	. n . 
	ld h,(ix+00dh)		;1dec	dd 66 0d 	. f . 
sub_1defh:
	ld e,(ix+002h)		;1def	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;1df2	dd 56 03 	. V . 
	add hl,de			;1df5	19 	. 
	ld (ix+002h),l		;1df6	dd 75 02 	. u . 
	ld (ix+003h),h		;1df9	dd 74 03 	. t . 
	ret			;1dfc	c9 	. 
sub_1dfdh:
	ld ix,0e31bh		;1dfd	dd 21 1b e3 	. ! . . 
	ld c,(ix+000h)		;1e01	dd 4e 00 	. N . 
	bit 4,c		;1e04	cb 61 	. a 
	ret z			;1e06	c8 	. 
	dec (ix+007h)		;1e07	dd 35 07 	. 5 . 
	jr nz,l1e20h		;1e0a	20 14 	  . 
	ld (ix+007h),005h		;1e0c	dd 36 07 05 	. 6 . . 
	inc (ix+006h)		;1e10	dd 34 06 	. 4 . 
	ld a,(0e321h)		;1e13	3a 21 e3 	: ! . 
	cp 004h		;1e16	fe 04 	. . 
	jr c,l1e20h		;1e18	38 06 	8 . 
	jr nz,l1e45h		;1e1a	20 29 	  ) 
	set 7,(ix+000h)		;1e1c	dd cb 00 fe 	. . . . 
l1e20h:
	ld de,l0072h		;1e20	11 72 00 	. r . 
	call sub_1c7ah		;1e23	cd 7a 1c 	. z . 
	call l1be2h		;1e26	cd e2 1b 	. . . 
	ld hl,(0e327h)		;1e29	2a 27 e3 	* ' . 
	ld de,l001bh		;1e2c	11 1b 00 	. . . 
	add hl,de			;1e2f	19 	. 
	ld (0e327h),hl		;1e30	22 27 e3 	" ' . 
	ex de,hl			;1e33	eb 	. 
	ld hl,(0e31fh)		;1e34	2a 1f e3 	* . . 
	sbc hl,de		;1e37	ed 52 	. R 
	ld (0e31fh),hl		;1e39	22 1f e3 	" . . 
	ld hl,073d2h		;1e3c	21 d2 73 	! . s 
	ld a,(0e31bh)		;1e3f	3a 1b e3 	: . . 
	jp l1a7eh		;1e42	c3 7e 1a 	. ~ . 
l1e45h:
	ld (ix+000h),000h		;1e45	dd 36 00 00 	. 6 . . 
	ret			;1e49	c9 	. 
sub_1e4ah:
	ld a,(0e2d8h)		;1e4a	3a d8 e2 	: . . 
	ld c,a			;1e4d	4f 	O 
	and a			;1e4e	a7 	. 
	jr z,$+63		;1e4f	28 3d 	( = 
	and 010h		;1e51	e6 10 	. . 
	ret z			;1e53	c8 	. 
	ld hl,(0e2e0h)		;1e54	2a e0 e2 	* . . 
	dec hl			;1e57	2b 	+ 
	bit 7,h		;1e58	cb 7c 	. | 
	jr nz,l1e5fh		;1e5a	20 03 	  . 
	ld (0e2e0h),hl		;1e5c	22 e0 e2 	" . . 
l1e5fh:
	ld ix,0e2d8h		;1e5f	dd 21 d8 e2 	. ! . . 
	ld a,(0e2e2h)		;1e63	3a e2 e2 	: . . 
	ld hl,0e2fah		;1e66	21 fa e2 	! . . 
	and a			;1e69	a7 	. 
	jp m,l1e77h		;1e6a	fa 77 1e 	. w . 
	cp 03fh		;1e6d	fe 3f 	. ? 
	jr z,l1e77h		;1e6f	28 06 	( . 
	dec (hl)			;1e71	35 	5 
	jr nz,l1e79h		;1e72	20 05 	  . 
	inc (ix+00ah)		;1e74	dd 34 0a 	. 4 . 
l1e77h:
	ld (hl),070h		;1e77	36 70 	6 p 
l1e79h:
	ld a,(0e080h)		;1e79	3a 80 e0 	: . . 
	and 007h		;1e7c	e6 07 	. . 
	ld hl,l1e84h		;1e7e	21 84 1e 	! . . 
	jp l1f26h		;1e81	c3 26 1f 	. & . 
l1e84h:
	add hl,de			;1e84	19 	. 
	rra			;1e85	1f 	. 
	sbc a,b			;1e86	98 	. 
	ld (l213eh),hl		;1e87	22 3e 21 	" > ! 
	ret p			;1e8a	f0 	. 
	inc h			;1e8b	24 	$ 
	jp p,l3a26h+2		;1e8c	f2 28 3a 	. ( : 
	add a,b			;1e8f	80 	. 
	ret po			;1e90	e0 	. 
	and 007h		;1e91	e6 07 	. . 
	ld hl,(0e2d3h)		;1e93	2a d3 e2 	* . . 
	ld de,(0e712h)		;1e96	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;1e9a	ed 52 	. R 
	bit 0,a		;1e9c	cb 47 	. G 
	jr z,l1ea1h		;1e9e	28 01 	( . 
	ccf			;1ea0	3f 	? 
l1ea1h:
	ret c			;1ea1	d8 	. 
	cp 003h		;1ea2	fe 03 	. . 
	jr nz,l1each		;1ea4	20 06 	  . 
	ld hl,0034fh		;1ea6	21 4f 03 	! O . 
	ld (0e2f8h),hl		;1ea9	22 f8 e2 	" . . 
l1each:
	bit 0,a		;1eac	cb 47 	. G 
	ld c,a			;1eae	4f 	O 
	ld a,012h		;1eaf	3e 12 	> . 
	jr nz,l1eb5h		;1eb1	20 02 	  . 
	ld a,052h		;1eb3	3e 52 	> R 
l1eb5h:
	ld (0e2d8h),a		;1eb5	32 d8 e2 	2 . . 
	ld a,070h		;1eb8	3e 70 	> p 
	ld (0e2fah),a		;1eba	32 fa e2 	2 . . 
	ld a,(0e261h)		;1ebd	3a 61 e2 	: a . 
	ld hl,0e197h		;1ec0	21 97 e1 	! . . 
	sub (hl)			;1ec3	96 	. 
	ret c			;1ec4	d8 	. 
	ret z			;1ec5	c8 	. 
	ld b,005h		;1ec6	06 05 	. . 
	ld ix,0e262h		;1ec8	dd 21 62 e2 	. ! b . 
l1ecch:
	bit 0,(ix+000h)		;1ecc	dd cb 00 46 	. . . F 
	jr nz,l1f03h		;1ed0	20 31 	  1 
	ld hl,(0e712h)		;1ed2	2a 12 e7 	* . . 
	ld e,(ix+002h)		;1ed5	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;1ed8	dd 56 03 	. V . 
	bit 0,c		;1edb	cb 41 	. A 
	jr z,l1eebh		;1edd	28 0c 	( . 
	bit 6,(ix+000h)		;1edf	dd cb 00 76 	. . . v 
	jr z,l1f03h		;1ee3	28 1e 	( . 
	sbc hl,de		;1ee5	ed 52 	. R 
l1ee7h:
	jr c,l1f03h		;1ee7	38 1a 	8 . 
	jr l1ef5h		;1ee9	18 0a 	. . 
l1eebh:
	bit 6,(ix+000h)		;1eeb	dd cb 00 76 	. . . v 
	jr nz,l1f03h		;1eef	20 12 	  . 
	sbc hl,de		;1ef1	ed 52 	. R 
	jr nc,l1f03h		;1ef3	30 0e 	0 . 
l1ef5h:
	ld l,a			;1ef5	6f 	o 
	ld a,(ix+001h)		;1ef6	dd 7e 01 	. ~ . 
	and a			;1ef9	a7 	. 
	ld a,l			;1efa	7d 	} 
	jr nz,l1f03h		;1efb	20 06 	  . 
	ld (ix+001h),005h		;1efd	dd 36 01 05 	. 6 . . 
	dec a			;1f01	3d 	= 
	ret z			;1f02	c8 	. 
l1f03h:
	ld de,000fh+1		;1f03	11 10 00 	. . . 
	add ix,de		;1f06	dd 19 	. . 
	djnz l1ecch		;1f08	10 c2 	. . 
	ret			;1f0a	c9 	. 
l1f0bh:
	jr nc,l1f2ch		;1f0b	30 1f 	0 . 
	ld sp,hl			;1f0d	f9 	. 
	rra			;1f0e	1f 	. 
	ld de,04520h		;1f0f	11 20 45 	.   E 
	rra			;1f12	1f 	. 
	ld e,c			;1f13	59 	Y 
	rra			;1f14	1f 	. 
	ld h,h			;1f15	64 	d 
	jr nz,l1f33h		;1f16	20 1b 	  . 
	jr nz,l1ee7h		;1f18	20 cd 	  . 
	ld l,a			;1f1a	6f 	o 
	inc l			;1f1b	2c 	, 
	ld hl,l2096h		;1f1c	21 96 20 	! .   
	push hl			;1f1f	e5 	. 
	ld hl,l1f0bh		;1f20	21 0b 1f 	! . . 
l1f23h:
	ld a,(ix+001h)		;1f23	dd 7e 01 	. ~ . 
l1f26h:
	add a,a			;1f26	87 	. 
	ld d,000h		;1f27	16 00 	. . 
	ld e,a			;1f29	5f 	_ 
	add hl,de			;1f2a	19 	. 
	ld a,(hl)			;1f2b	7e 	~ 
l1f2ch:
	inc hl			;1f2c	23 	# 
	ld h,(hl)			;1f2d	66 	f 
	ld l,a			;1f2e	6f 	o 
	jp (hl)			;1f2f	e9 	. 
	call sub_2d0dh		;1f30	cd 0d 2d 	. . - 
l1f33h:
	ld de,0fa00h		;1f33	11 00 fa 	. . . 
	add hl,de			;1f36	19 	. 
	jp nc,l1fcfh		;1f37	d2 cf 1f 	. . . 
	ld de,0c000h		;1f3a	11 00 c0 	. . . 
	ld hl,(0e2dah)		;1f3d	2a da e2 	* . . 
	add hl,de			;1f40	19 	. 
	jp c,l1f50h		;1f41	da 50 1f 	. P . 
	ret			;1f44	c9 	. 
	call l1be2h		;1f45	cd e2 1b 	. . . 
	ld de,0fa00h		;1f48	11 00 fa 	. . . 
	add hl,de			;1f4b	19 	. 
	jp nc,l1fcfh		;1f4c	d2 cf 1f 	. . . 
	ret			;1f4f	c9 	. 
l1f50h:
	ld (ix+001h),003h		;1f50	dd 36 01 03 	. 6 . . 
	ld (ix+006h),000h		;1f54	dd 36 06 00 	. 6 . . 
	ret			;1f58	c9 	. 
	call l1be2h		;1f59	cd e2 1b 	. . . 
	call sub_20e3h		;1f5c	cd e3 20 	. .   
	jp c,l2036h		;1f5f	da 36 20 	. 6   
	dec (ix+007h)		;1f62	dd 35 07 	. 5 . 
	ret nz			;1f65	c0 	. 
	dec (ix+00eh)		;1f66	dd 35 0e 	. 5 . 
	jp m,l2085h		;1f69	fa 85 20 	. .   
	jr z,l1fc2h		;1f6c	28 54 	( T 
	inc (ix+006h)		;1f6e	dd 34 06 	. 4 . 
	ld (ix+007h),005h		;1f71	dd 36 07 05 	. 6 . . 
	ld a,(0e2e6h)		;1f75	3a e6 e2 	: . . 
	cp 002h		;1f78	fe 02 	. . 
	ret nz			;1f7a	c0 	. 
	call sub_1dd4h		;1f7b	cd d4 1d 	. . . 
	ld de,(0e80ch)		;1f7e	ed 5b 0c e8 	. [ . . 
	ld hl,0fa60h		;1f82	21 60 fa 	! ` . 
	add hl,de			;1f85	19 	. 
	ret c			;1f86	d8 	. 
	ld hl,0fe00h		;1f87	21 00 fe 	! . . 
	add hl,de			;1f8a	19 	. 
	ret nc			;1f8b	d0 	. 
	ld hl,(0e2dah)		;1f8c	2a da e2 	* . . 
	ld de,00200h		;1f8f	11 00 02 	. . . 
	add hl,de			;1f92	19 	. 
	ld (0e80fh),hl		;1f93	22 0f e8 	" . . 
	ld de,l02c0h		;1f96	11 c0 02 	. . . 
	add hl,de			;1f99	19 	. 
	ld (0e811h),hl		;1f9a	22 11 e8 	" . . 
	ld a,(0e2deh)		;1f9d	3a de e2 	: . . 
	cp 00bh		;1fa0	fe 0b 	. . 
	jr c,l1fb0h		;1fa2	38 0c 	8 . 
	jr z,l1fabh		;1fa4	28 05 	( . 
	ld hl,06900h		;1fa6	21 00 69 	! . i 
	jr l1fb3h		;1fa9	18 08 	. . 
l1fabh:
	ld hl,06180h		;1fab	21 80 61 	! . a 
	jr l1fb3h		;1fae	18 03 	. . 
l1fb0h:
	ld hl,05980h		;1fb0	21 80 59 	! . Y 
l1fb3h:
	ld de,5		;1fb3	11 05 00 	. . . 
	push hl			;1fb6	e5 	. 
	call sub_1172h		;1fb7	cd 72 11 	. r . 
	pop hl			;1fba	e1 	. 
	ret nc			;1fbb	d0 	. 
	ld de,l0110h		;1fbc	11 10 01 	. . . 
	jp l2c95h		;1fbf	c3 95 2c 	. . , 
l1fc2h:
	dec (ix+00bh)		;1fc2	dd 35 0b 	. 5 . 
	jr nz,l1fd2h		;1fc5	20 0b 	  . 
	inc (ix+006h)		;1fc7	dd 34 06 	. 4 . 
	ld (ix+007h),005h		;1fca	dd 36 07 05 	. 6 . . 
	ret			;1fce	c9 	. 
l1fcfh:
	call sub_2ce8h		;1fcf	cd e8 2c 	. . , 
l1fd2h:
	ld a,(0e011h)		;1fd2	3a 11 e0 	: . . 
	ld hl,0e19eh		;1fd5	21 9e e1 	! . . 
	ld b,004h		;1fd8	06 04 	. . 
	cp (hl)			;1fda	be 	. 
	jr c,l1fe5h		;1fdb	38 08 	8 . 
	inc hl			;1fdd	23 	# 
	ld b,009h		;1fde	06 09 	. . 
	cp (hl)			;1fe0	be 	. 
	jr c,l1fe5h		;1fe1	38 02 	8 . 
	ld b,00eh		;1fe3	06 0e 	. . 
l1fe5h:
	ld (ix+006h),b		;1fe5	dd 70 06 	. p . 
	ld (ix+00eh),004h		;1fe8	dd 36 0e 04 	. 6 . . 
	ld a,(0e012h)		;1fec	3a 12 e0 	: . . 
	ld hl,0e1a0h		;1fef	21 a0 e1 	! . . 
	call sub_1214h		;1ff2	cd 14 12 	. . . 
	ld (0e2dfh),a		;1ff5	32 df e2 	2 . . 
	ret			;1ff8	c9 	. 
l1ff9h:
	call l1baah		;1ff9	cd aa 1b 	. . . 
	bit 4,(ix+000h)		;1ffc	dd cb 00 66 	. . . f 
	ret nz			;2000	c0 	. 
	pop hl			;2001	e1 	. 
	ld hl,0e2d8h		;2002	21 d8 e2 	! . . 
	res 4,(hl)		;2005	cb a6 	. . 
	ld hl,0e2e8h		;2007	21 e8 e2 	! . . 
	res 4,(hl)		;200a	cb a6 	. . 
	ret			;200c	c9 	. 
l200dh:
	ld (ix+001h),002h		;200d	dd 36 01 02 	. 6 . . 
l2011h:
	call l1be2h		;2011	cd e2 1b 	. . . 
	dec (ix+007h)		;2014	dd 35 07 	. 5 . 
	jp z,l1fcfh		;2017	ca cf 1f 	. . . 
	ret			;201a	c9 	. 
	ld de,(0e104h)		;201b	ed 5b 04 e1 	. [ . . 
	ld l,(ix+002h)		;201f	dd 6e 02 	. n . 
	ld h,(ix+003h)		;2022	dd 66 03 	. f . 
	sbc hl,de		;2025	ed 52 	. R 
	jr c,l200dh		;2027	38 e4 	8 . 
	ld de,l0055h		;2029	11 55 00 	. U . 
	call sub_1c7ah		;202c	cd 7a 1c 	. z . 
	jr l2011h		;202f	18 e0 	. . 
l2031h:
	ld (ix+001h),006h		;2031	dd 36 01 06 	. 6 . . 
	ret			;2035	c9 	. 
l2036h:
	add a,013h		;2036	c6 13 	. . 
	ld (0e2deh),a		;2038	32 de e2 	2 . . 
	cp 016h		;203b	fe 16 	. . 
	ld hl,l2126h		;203d	21 26 21 	! & ! 
	jr c,l2045h		;2040	38 03 	8 . 
	ld hl,0212ch		;2042	21 2c 21 	! , ! 
l2045h:
	call l1b96h		;2045	cd 96 1b 	. . . 
	ld hl,l2d67h		;2048	21 67 2d 	! g - 
	ld de,l00d8h		;204b	11 d8 00 	. . . 
	call sub_2d19h		;204e	cd 19 2d 	. . - 
	ld a,008h		;2051	3e 08 	> . 
	jp c,l247ah		;2053	da 7a 24 	. z $ 
	ld a,(ix-002h)		;2056	dd 7e fe 	. ~ . 
	ld (ix-002h),01ch		;2059	dd 36 fe 1c 	. 6 . . 
	and a			;205d	a7 	. 
	jr nz,l2031h		;205e	20 d1 	  . 
	inc (ix+001h)		;2060	dd 34 01 	. 4 . 
	ret			;2063	c9 	. 
	call sub_2d13h		;2064	cd 13 2d 	. . - 
	call sub_20e3h		;2067	cd e3 20 	. .   
	jp c,l2036h		;206a	da 36 20 	. 6   
l206dh:
	ld de,(0e104h)		;206d	ed 5b 04 e1 	. [ . . 
l2071h:
	ld l,(ix+002h)		;2071	dd 6e 02 	. n . 
	ld h,(ix+003h)		;2074	dd 66 03 	. f . 
	sbc hl,de		;2077	ed 52 	. R 
	jr c,l2080h		;2079	38 05 	8 . 
	ld a,(ix+008h)		;207b	dd 7e 08 	. ~ . 
	and a			;207e	a7 	. 
	ret nz			;207f	c0 	. 
l2080h:
	ld (ix+001h),000h		;2080	dd 36 01 00 	. 6 . . 
	ret			;2084	c9 	. 
l2085h:
	ld (ix+006h),000h		;2085	dd 36 06 00 	. 6 . . 
	ld (ix+007h),007h		;2089	dd 36 07 07 	. 6 . . 
	ld (ix+001h),005h		;208d	dd 36 01 05 	. 6 . . 
	ld (ix+008h),025h		;2091	dd 36 08 25 	. 6 . % 
	ret			;2095	c9 	. 
l2096h:
	call sub_2cb9h		;2096	cd b9 2c 	. . , 
	call sub_2c78h		;2099	cd 78 2c 	. x , 
	ld hl,06c8dh		;209c	21 8d 6c 	! . l 
l209fh:
	ld de,0fea0h		;209f	11 a0 fe 	. . . 
sub_20a2h:
	ld a,(0e701h)		;20a2	3a 01 e7 	: . . 
	and 003h		;20a5	e6 03 	. . 
	jr nz,l20adh		;20a7	20 04 	  . 
	res 5,(ix+000h)		;20a9	dd cb 00 ae 	. . . . 
l20adh:
	push hl			;20ad	e5 	. 
	ld a,(ix+001h)		;20ae	dd 7e 01 	. ~ . 
	cp 001h		;20b1	fe 01 	. . 
	jr z,l20d2h		;20b3	28 1d 	( . 
	ld hl,(0e80ch)		;20b5	2a 0c e8 	* . . 
	add hl,de			;20b8	19 	. 
	ld hl,0e701h		;20b9	21 01 e7 	! . . 
	bit 6,(ix+000h)		;20bc	dd cb 00 76 	. . . v 
	jr z,l20cch		;20c0	28 0a 	( . 
	jr c,l20c8h		;20c2	38 04 	8 . 
	set 4,(hl)		;20c4	cb e6 	. . 
	jr l20d9h		;20c6	18 11 	. . 
l20c8h:
	res 4,(hl)		;20c8	cb a6 	. . 
	jr l20d9h		;20ca	18 0d 	. . 
l20cch:
	jr c,l20d7h		;20cc	38 09 	8 . 
	set 5,(hl)		;20ce	cb ee 	. . 
	jr l20d9h		;20d0	18 07 	. . 
l20d2h:
	ld hl,0e701h		;20d2	21 01 e7 	! . . 
	res 4,(hl)		;20d5	cb a6 	. . 
l20d7h:
	res 5,(hl)		;20d7	cb ae 	. . 
l20d9h:
	pop hl			;20d9	e1 	. 
	call sub_2d01h		;20da	cd 01 2d 	. . - 
	ld a,(ix+000h)		;20dd	dd 7e 00 	. ~ . 
	jp l1a7eh		;20e0	c3 7e 1a 	. ~ . 
sub_20e3h:
	call sub_2109h		;20e3	cd 09 21 	. . ! 
	ret nc			;20e6	d0 	. 
	ld hl,(0e80ch)		;20e7	2a 0c e8 	* . . 
	ld de,0fe60h		;20ea	11 60 fe 	. ` . 
	add hl,de			;20ed	19 	. 
	ret nc			;20ee	d0 	. 
	ld a,(0e2deh)		;20ef	3a de e2 	: . . 
	cp 004h		;20f2	fe 04 	. . 
	jr c,l20fdh		;20f4	38 07 	8 . 
	cp 009h		;20f6	fe 09 	. . 
	ld hl,l2112h		;20f8	21 12 21 	! . ! 
	jr c,l2100h		;20fb	38 03 	8 . 
l20fdh:
	ld hl,l211ch		;20fd	21 1c 21 	! . ! 
l2100h:
	call sub_1b18h		;2100	cd 18 1b 	. . . 
	ret nc			;2103	d0 	. 
	set 5,(ix+000h)		;2104	dd cb 00 ee 	. . . . 
	ret			;2108	c9 	. 
sub_2109h:
	ld a,(ix+000h)		;2109	dd 7e 00 	. ~ . 
	and 020h		;210c	e6 20 	.   
	ret nz			;210e	c0 	. 
	jp sub_1ae7h		;210f	c3 e7 1a 	. . . 
l2112h:
	inc b			;2112	04 	. 
	inc bc			;2113	03 	. 
	rst 38h			;2114	ff 	. 
	rst 38h			;2115	ff 	. 
	rst 38h			;2116	ff 	. 
	rst 38h			;2117	ff 	. 
	inc b			;2118	04 	. 
	rst 38h			;2119	ff 	. 
	rst 38h			;211a	ff 	. 
	rst 38h			;211b	ff 	. 
l211ch:
	ld (bc),a			;211c	02 	. 
	nop			;211d	00 	. 
	ld (bc),a			;211e	02 	. 
	ld (bc),a			;211f	02 	. 
	ld (bc),a			;2120	02 	. 
	ld (bc),a			;2121	02 	. 
	ld bc,0ffffh		;2122	01 ff ff 	. . . 
	rst 38h			;2125	ff 	. 
l2126h:
	ld b,018h		;2126	06 18 	. . 
	ex af,af'			;2128	08 	. 
	add hl,de			;2129	19 	. 
	ld de,006ffh		;212a	11 ff 06 	. . . 
	ld a,(de)			;212d	1a 	. 
	ex af,af'			;212e	08 	. 
	dec de			;212f	1b 	. 
	ld de,048ffh		;2130	11 ff 48 	. . H 
	ld hl,l1ff9h		;2133	21 f9 1f 	! . . 
	nop			;2136	00 	. 
	ld (l215dh),hl		;2137	22 5d 21 	" ] ! 
	ld h,a			;213a	67 	g 
	ld hl,l2217h		;213b	21 17 22 	! . " 
l213eh:
	ld hl,l2239h		;213e	21 39 22 	! 9 " 
	push hl			;2141	e5 	. 
	ld hl,02132h		;2142	21 32 21 	! 2 ! 
	jp l1f23h		;2145	c3 23 1f 	. # . 
	call sub_2d0dh		;2148	cd 0d 2d 	. . - 
	ld de,0fb00h		;214b	11 00 fb 	. . . 
	add hl,de			;214e	19 	. 
	jp nc,l21dch		;214f	d2 dc 21 	. . ! 
	ld de,0c000h		;2152	11 00 c0 	. . . 
	ld hl,(0e2dah)		;2155	2a da e2 	* . . 
	add hl,de			;2158	19 	. 
	jp c,l1f50h		;2159	da 50 1f 	. P . 
	ret			;215c	c9 	. 
l215dh:
	call l1be2h		;215d	cd e2 1b 	. . . 
	ld de,0fb00h		;2160	11 00 fb 	. . . 
	add hl,de			;2163	19 	. 
	jr nc,l21dch		;2164	30 76 	0 v 
	ret			;2166	c9 	. 
	call l1be2h		;2167	cd e2 1b 	. . . 
	call sub_224bh		;216a	cd 4b 22 	. K " 
	jp c,l220ah		;216d	da 0a 22 	. . " 
	dec (ix+007h)		;2170	dd 35 07 	. 5 . 
	ret nz			;2173	c0 	. 
	dec (ix+00eh)		;2174	dd 35 0e 	. 5 . 
	jr z,l21d4h		;2177	28 5b 	( [ 
	inc (ix+006h)		;2179	dd 34 06 	. 4 . 
	ld (ix+007h),00bh		;217c	dd 36 07 0b 	. 6 . . 
	ld a,(0e2e6h)		;2180	3a e6 e2 	: . . 
	cp 002h		;2183	fe 02 	. . 
	ret nz			;2185	c0 	. 
	call sub_1dd4h		;2186	cd d4 1d 	. . . 
	ld hl,(0e2dah)		;2189	2a da e2 	* . . 
	ld a,(0e2deh)		;218c	3a de e2 	: . . 
	cp 007h		;218f	fe 07 	. . 
	jr c,l21a9h		;2191	38 16 	8 . 
	ld de,l01e0h		;2193	11 e0 01 	. . . 
	add hl,de			;2196	19 	. 
	ld (0e80fh),hl		;2197	22 0f e8 	" . . 
	ld de,l0220h		;219a	11 20 02 	.   . 
	add hl,de			;219d	19 	. 
	ld (0e811h),hl		;219e	22 11 e8 	" . . 
	ld hl,05e00h		;21a1	21 00 5e 	! . ^ 
	ld de,0011h		;21a4	11 11 00 	. . . 
	jr l21bdh		;21a7	18 14 	. . 
l21a9h:
	ld de,00240h		;21a9	11 40 02 	. @ . 
	add hl,de			;21ac	19 	. 
	ld (0e80fh),hl		;21ad	22 0f e8 	" . . 
	ld de,l01e0h		;21b0	11 e0 01 	. . . 
	add hl,de			;21b3	19 	. 
	ld (0e811h),hl		;21b4	22 11 e8 	" . . 
	ld hl,06a00h		;21b7	21 00 6a 	! . j 
	ld de,0000ah		;21ba	11 0a 00 	. . . 
l21bdh:
	call sub_1172h		;21bd	cd 72 11 	. r . 
	ret nc			;21c0	d0 	. 
	ld a,(0e2deh)		;21c1	3a de e2 	: . . 
	cp 007h		;21c4	fe 07 	. . 
	ld hl,06c80h		;21c6	21 80 6c 	! . l 
	jr c,l21ceh		;21c9	38 03 	8 . 
	ld hl,06080h		;21cb	21 80 60 	! . ` 
l21ceh:
	ld de,l0016h+2		;21ce	11 18 00 	. . . 
	jp l2c95h		;21d1	c3 95 2c 	. . , 
l21d4h:
	dec (ix+00bh)		;21d4	dd 35 0b 	. 5 . 
	jr nz,l21dfh		;21d7	20 06 	  . 
	jp l2220h		;21d9	c3 20 22 	.   " 
l21dch:
	call sub_2ce8h		;21dc	cd e8 2c 	. . , 
l21dfh:
	ld a,(0e011h)		;21df	3a 11 e0 	: . . 
	ld hl,0e19eh		;21e2	21 9e e1 	! . . 
	ld b,004h		;21e5	06 04 	. . 
	cp (hl)			;21e7	be 	. 
	jr c,l21ech		;21e8	38 02 	8 . 
	ld b,007h		;21ea	06 07 	. . 
l21ech:
	ld (ix+006h),b		;21ec	dd 70 06 	. p . 
	ld a,(0e012h)		;21ef	3a 12 e0 	: . . 
	ld hl,0e1a5h		;21f2	21 a5 e1 	! . . 
	call sub_1214h		;21f5	cd 14 12 	. . . 
	ld (0e2dfh),a		;21f8	32 df e2 	2 . . 
	ld (ix+00eh),003h		;21fb	dd 36 0e 03 	. 6 . . 
	ret			;21ff	c9 	. 
l2200h:
	call l1be2h		;2200	cd e2 1b 	. . . 
	dec (ix+007h)		;2203	dd 35 07 	. 5 . 
	jp z,l1f50h		;2206	ca 50 1f 	. P . 
	ret			;2209	c9 	. 
l220ah:
	ld (ix+006h),000h		;220a	dd 36 06 00 	. 6 . . 
	ld (ix+007h),00bh		;220e	dd 36 07 0b 	. 6 . . 
	ld (ix+001h),002h		;2212	dd 36 01 02 	. 6 . . 
	ret			;2216	c9 	. 
l2217h:
	call sub_2d13h		;2217	cd 13 2d 	. . - 
	call sub_224bh		;221a	cd 4b 22 	. K " 
	jp l206dh		;221d	c3 6d 20 	. m   
l2220h:
	ld (ix+006h),000h		;2220	dd 36 06 00 	. 6 . . 
	ld (ix+007h),007h		;2224	dd 36 07 07 	. 6 . . 
	ld (ix+001h),005h		;2228	dd 36 01 05 	. 6 . . 
	ld a,(0e013h)		;222c	3a 13 e0 	: . . 
	ld hl,0e1a0h		;222f	21 a0 e1 	! . . 
	call sub_1214h		;2232	cd 14 12 	. . . 
	ld (ix+008h),a		;2235	dd 77 08 	. w . 
	ret			;2238	c9 	. 
l2239h:
	call sub_2cb9h		;2239	cd b9 2c 	. . , 
	call sub_2c78h		;223c	cd 78 2c 	. x , 
	ld hl,06e65h		;223f	21 65 6e 	! e n 
	ld de,0fe20h		;2242	11 20 fe 	.   . 
	call sub_20a2h		;2245	cd a2 20 	. .   
	jp l2e70h		;2248	c3 70 2e 	. p . 
sub_224bh:
	ld a,(0e2d8h)		;224b	3a d8 e2 	: . . 
	and 020h		;224e	e6 20 	.   
	ret nz			;2250	c0 	. 
	ld hl,l00e0h		;2251	21 e0 00 	! . . 
	call sub_1220h		;2254	cd 20 12 	.   . 
	ret nc			;2257	d0 	. 
	set 5,(ix+000h)		;2258	dd cb 00 ee 	. . . . 
	push de			;225c	d5 	. 
	ld hl,5		;225d	21 05 00 	! . . 
	call sub_2e5ch		;2260	cd 5c 2e 	. \ . 
	ld hl,l2d6ah		;2263	21 6a 2d 	! j - 
	call sub_2d19h		;2266	cd 19 2d 	. . - 
	pop de			;2269	d1 	. 
	jr c,l2271h		;226a	38 05 	8 . 
	ld hl,09000h		;226c	21 00 90 	! . . 
	add hl,de			;226f	19 	. 
	ret			;2270	c9 	. 
l2271h:
	pop af			;2271	f1 	. 
	ld de,000eeh		;2272	11 ee 00 	. . . 
	ld a,009h		;2275	3e 09 	> . 
	call l247ah		;2277	cd 7a 24 	. z $ 
	ld (ix+006h),000h		;227a	dd 36 06 00 	. 6 . . 
	ld hl,l2284h		;227e	21 84 22 	! . " 
	jp l1b96h		;2281	c3 96 1b 	. . . 
l2284h:
	ld b,00ah		;2284	06 0a 	. . 
	ex af,af'			;2286	08 	. 
	dec bc			;2287	0b 	. 
	inc de			;2288	13 	. 
	rst 38h			;2289	ff 	. 
l228ah:
	and l			;228a	a5 	. 
	ld (l1ff9h),hl		;228b	22 f9 1f 	" . . 
	add hl,bc			;228e	09 	. 
	inc h			;228f	24 	$ 
	rst 0			;2290	c7 	. 
	ld (l22d2h),hl		;2291	22 d2 22 	" . " 
	add a,b			;2294	80 	. 
	inc h			;2295	24 	$ 
	ld (0cd24h),a		;2296	32 24 cd 	2 $ . 
	ld l,a			;2299	6f 	o 
	inc l			;229a	2c 	, 
	ld hl,l249fh		;229b	21 9f 24 	! . $ 
	push hl			;229e	e5 	. 
	ld hl,l228ah		;229f	21 8a 22 	! . " 
	jp l1f23h		;22a2	c3 23 1f 	. # . 
	call sub_2d0dh		;22a5	cd 0d 2d 	. . - 
	ld de,0f600h		;22a8	11 00 f6 	. . . 
	add hl,de			;22ab	19 	. 
	jp nc,l23c6h		;22ac	d2 c6 23 	. . # 
	ld de,05f00h		;22af	11 00 5f 	. . _ 
	ld hl,(0e2dah)		;22b2	2a da e2 	* . . 
	add hl,de			;22b5	19 	. 
	jp nc,l1f50h		;22b6	d2 50 1f 	. P . 
	ret			;22b9	c9 	. 
l22bah:
	ld (ix+001h),000h		;22ba	dd 36 01 00 	. 6 . . 
	ld (ix+006h),000h		;22be	dd 36 06 00 	. 6 . . 
	ld (ix+007h),002h		;22c2	dd 36 07 02 	. 6 . . 
	ret			;22c6	c9 	. 
	call l1be2h		;22c7	cd e2 1b 	. . . 
	ld de,0f600h		;22ca	11 00 f6 	. . . 
	add hl,de			;22cd	19 	. 
	jp nc,l23c6h		;22ce	d2 c6 23 	. . # 
	ret			;22d1	c9 	. 
l22d2h:
	call l1be2h		;22d2	cd e2 1b 	. . . 
	call sub_24b0h		;22d5	cd b0 24 	. . $ 
	jp c,l2448h		;22d8	da 48 24 	. H $ 
	dec (ix+007h)		;22db	dd 35 07 	. 5 . 
	ret nz			;22de	c0 	. 
	dec (ix+00eh)		;22df	dd 35 0e 	. 5 . 
	jr z,l2344h		;22e2	28 60 	( ` 
	jp m,l23b4h		;22e4	fa b4 23 	. . # 
	inc (ix+006h)		;22e7	dd 34 06 	. 4 . 
	ld (ix+007h),00bh		;22ea	dd 36 07 0b 	. 6 . . 
	ld iy,0e2fbh		;22ee	fd 21 fb e2 	. ! . . 
	bit 4,(iy+000h)		;22f2	fd cb 00 66 	. . . f 
	jr z,l22fch		;22f6	28 04 	( . 
	ld iy,0e30bh		;22f8	fd 21 0b e3 	. ! . . 
l22fch:
	ld a,(0e2e7h)		;22fc	3a e7 e2 	: . . 
	cp 002h		;22ff	fe 02 	. . 
	ld hl,06900h		;2301	21 00 69 	! . i 
	jr c,l2309h		;2304	38 03 	8 . 
	ld hl,05680h		;2306	21 80 56 	! . V 
l2309h:
	ld (iy+004h),l		;2309	fd 75 04 	. u . 
	ld (iy+005h),h		;230c	fd 74 05 	. t . 
	ld (iy+00bh),a		;230f	fd 77 0b 	. w . 
	ld hl,(0e2dah)		;2312	2a da e2 	* . . 
	ld de,0ff00h		;2315	11 00 ff 	. . . 
	add hl,de			;2318	19 	. 
	ld (iy+002h),l		;2319	fd 75 02 	. u . 
	ld (iy+003h),h		;231c	fd 74 03 	. t . 
	ld de,0ed00h		;231f	11 00 ed 	. . . 
	add hl,de			;2322	19 	. 
	ld (iy+00eh),l		;2323	fd 75 0e 	. u . 
	ld (iy+00fh),h		;2326	fd 74 0f 	. t . 
	ld hl,(0e1b9h)		;2329	2a b9 e1 	* . . 
	ld (iy+00ch),l		;232c	fd 75 0c 	. u . 
	ld (iy+00dh),h		;232f	fd 74 0d 	. t . 
	ld a,050h		;2332	3e 50 	> P 
	ld (iy+000h),a		;2334	fd 77 00 	. w . 
	xor a			;2337	af 	. 
	ld (iy+001h),a		;2338	fd 77 01 	. w . 
	ld (iy+006h),a		;233b	fd 77 06 	. w . 
	ld a,002h		;233e	3e 02 	> . 
	ld (iy+007h),a		;2340	fd 77 07 	. w . 
	ret			;2343	c9 	. 
l2344h:
	inc (ix+00eh)		;2344	dd 34 0e 	. 4 . 
	inc (ix+007h)		;2347	dd 34 07 	. 4 . 
	ld iy,0e2fbh		;234a	fd 21 fb e2 	. ! . . 
	bit 4,(iy+000h)		;234e	fd cb 00 66 	. . . f 
	jr z,l2368h		;2352	28 14 	( . 
	bit 7,(iy+00dh)		;2354	fd cb 0d 7e 	. . . ~ 
	ret nz			;2358	c0 	. 
	bit 0,(ix-001h)		;2359	dd cb ff 46 	. . . F 
	jr z,l2371h		;235d	28 12 	( . 
	bit 4,(iy+010h)		;235f	fd cb 10 66 	. . . f 
	jr nz,l2371h		;2363	20 0c 	  . 
	jp l23d3h		;2365	c3 d3 23 	. . # 
l2368h:
	ld iy,0e30bh		;2368	fd 21 0b e3 	. ! . . 
	bit 7,(iy+00dh)		;236c	fd cb 0d 7e 	. . . ~ 
	ret nz			;2370	c0 	. 
l2371h:
	ld a,(iy+00bh)		;2371	fd 7e 0b 	. ~ . 
	and a			;2374	a7 	. 
	jr z,l237fh		;2375	28 08 	( . 
	cp 003h		;2377	fe 03 	. . 
	jr z,l237fh		;2379	28 04 	( . 
	ld a,00ah		;237b	3e 0a 	> . 
	jr l2381h		;237d	18 02 	. . 
l237fh:
	ld a,00ch		;237f	3e 0c 	> . 
l2381h:
	ld (ix+006h),a		;2381	dd 77 06 	. w . 
	ld hl,(0e2dah)		;2384	2a da e2 	* . . 
	ld de,0fec0h		;2387	11 c0 fe 	. . . 
	add hl,de			;238a	19 	. 
	ld e,(iy+002h)		;238b	fd 5e 02 	. ^ . 
	ld d,(iy+003h)		;238e	fd 56 03 	. V . 
	sbc hl,de		;2391	ed 52 	. R 
	ret nc			;2393	d0 	. 
	ld (iy+000h),000h		;2394	fd 36 00 00 	. 6 . . 
	dec (ix+006h)		;2398	dd 35 06 	. 5 . 
	ld a,(0e30bh)		;239b	3a 0b e3 	: . . 
	and 010h		;239e	e6 10 	. . 
	ld a,00bh		;23a0	3e 0b 	> . 
	jr nz,l23b0h		;23a2	20 0c 	  . 
	dec (ix+00eh)		;23a4	dd 35 0e 	. 5 . 
	ld a,(0e011h)		;23a7	3a 11 e0 	: . . 
	ld hl,0e1a5h		;23aa	21 a5 e1 	! . . 
	call sub_1214h		;23ad	cd 14 12 	. . . 
l23b0h:
	ld (0e2dfh),a		;23b0	32 df e2 	2 . . 
	ret			;23b3	c9 	. 
l23b4h:
	ld hl,(0e80ch)		;23b4	2a 0c e8 	* . . 
	ld de,0f500h		;23b7	11 00 f5 	. . . 
	add hl,de			;23ba	19 	. 
	jp c,l22bah		;23bb	da ba 22 	. . " 
	dec (ix+00bh)		;23be	dd 35 0b 	. 5 . 
	jr nz,l23cch		;23c1	20 09 	  . 
	jp l2220h		;23c3	c3 20 22 	.   " 
l23c6h:
	ld a,(0e19fh)		;23c6	3a 9f e1 	: . . 
	ld (0e2e3h),a		;23c9	32 e3 e2 	2 . . 
l23cch:
	ld a,r		;23cc	ed 5f 	. _ 
	and 001h		;23ce	e6 01 	. . 
	ld (ix-001h),a		;23d0	dd 77 ff 	. w . 
l23d3h:
	ld (ix+001h),004h		;23d3	dd 36 01 04 	. 6 . . 
	ld a,(0e010h)		;23d7	3a 10 e0 	: . . 
	ld hl,0e19ch		;23da	21 9c e1 	! . . 
	ld b,000h		;23dd	06 00 	. . 
	cp (hl)			;23df	be 	. 
	jr c,l23edh		;23e0	38 0b 	8 . 
	inc hl			;23e2	23 	# 
	inc b			;23e3	04 	. 
	cp (hl)			;23e4	be 	. 
	jr c,l23edh		;23e5	38 06 	8 . 
	inc hl			;23e7	23 	# 
	inc b			;23e8	04 	. 
	cp (hl)			;23e9	be 	. 
	jr c,l23edh		;23ea	38 01 	8 . 
	inc b			;23ec	04 	. 
l23edh:
	ld (ix+00fh),b		;23ed	dd 70 0f 	. p . 
	ld a,b			;23f0	78 	x 
	ld b,009h		;23f1	06 09 	. . 
	cp 002h		;23f3	fe 02 	. . 
	jr nc,l23f9h		;23f5	30 02 	0 . 
	ld b,00bh		;23f7	06 0b 	. . 
l23f9h:
	ld (ix+006h),b		;23f9	dd 70 06 	. p . 
	ld (ix+007h),00bh		;23fc	dd 36 07 0b 	. 6 . . 
	ld (ix+00eh),002h		;2400	dd 36 0e 02 	. 6 . . 
	ret			;2404	c9 	. 
l2405h:
	ld (ix+001h),002h		;2405	dd 36 01 02 	. 6 . . 
l2409h:
	call l1be2h		;2409	cd e2 1b 	. . . 
	dec (ix+007h)		;240c	dd 35 07 	. 5 . 
	ret nz			;240f	c0 	. 
	inc (ix+007h)		;2410	dd 34 07 	. 4 . 
	ld a,(0e30bh)		;2413	3a 0b e3 	: . . 
	and 010h		;2416	e6 10 	. . 
	jr nz,l2427h		;2418	20 0d 	  . 
	ld a,(0e2fbh)		;241a	3a fb e2 	: . . 
	and 010h		;241d	e6 10 	. . 
	jr z,l23c6h		;241f	28 a5 	( . 
	bit 0,(ix-001h)		;2421	dd cb ff 46 	. . . F 
	jr nz,l23d3h		;2425	20 ac 	  . 
l2427h:
	ld a,(0e2e4h)		;2427	3a e4 e2 	: . . 
	ld (0e2deh),a		;242a	32 de e2 	2 . . 
	ld (ix+001h),004h		;242d	dd 36 01 04 	. 6 . . 
	ret			;2431	c9 	. 
	ld de,(0e106h)		;2432	ed 5b 06 e1 	. [ . . 
	ld l,(ix+002h)		;2436	dd 6e 02 	. n . 
	ld h,(ix+003h)		;2439	dd 66 03 	. f . 
	sbc hl,de		;243c	ed 52 	. R 
	jr nc,l2405h		;243e	30 c5 	0 . 
	ld de,l0055h		;2440	11 55 00 	. U . 
	call sub_1c7ah		;2443	cd 7a 1c 	. z . 
	jr l2409h		;2446	18 c1 	. . 
l2448h:
	ld b,(ix+006h)		;2448	dd 46 06 	. F . 
	add a,004h		;244b	c6 04 	. . 
	ld (0e2deh),a		;244d	32 de e2 	2 . . 
	ld hl,l2d6dh		;2450	21 6d 2d 	! m - 
	call sub_2d19h		;2453	cd 19 2d 	. . - 
	jr c,l246fh		;2456	38 17 	8 . 
	ld (ix+00ch),b		;2458	dd 70 0c 	. p . 
	ld (ix+007h),006h		;245b	dd 36 07 06 	. 6 . . 
	ld a,(ix-002h)		;245f	dd 7e fe 	. ~ . 
	ld (ix-002h),01ch		;2462	dd 36 fe 1c 	. 6 . . 
	and a			;2466	a7 	. 
	jp nz,l2031h		;2467	c2 31 20 	. 1   
	ld (ix+001h),002h		;246a	dd 36 01 02 	. 6 . . 
	ret			;246e	c9 	. 
l246fh:
	ld hl,l24cch		;246f	21 cc 24 	! . $ 
	call l1b96h		;2472	cd 96 1b 	. . . 
	ld de,l00dch		;2475	11 dc 00 	. . . 
	ld a,009h		;2478	3e 09 	> . 
l247ah:
	ld hl,(0e2dah)		;247a	2a da e2 	* . . 
	jp sub_2f60h		;247d	c3 60 2f 	. ` / 
	call sub_2d13h		;2480	cd 13 2d 	. . - 
	call sub_24b0h		;2483	cd b0 24 	. . $ 
	jr c,l2448h		;2486	38 c0 	8 . 
l2488h:
	ld de,(0e106h)		;2488	ed 5b 06 e1 	. [ . . 
	ld l,(ix+002h)		;248c	dd 6e 02 	. n . 
	ld h,(ix+003h)		;248f	dd 66 03 	. f . 
	sbc hl,de		;2492	ed 52 	. R 
	jp nc,l2080h		;2494	d2 80 20 	. .   
	ld a,(ix+008h)		;2497	dd 7e 08 	. ~ . 
	and a			;249a	a7 	. 
	jp z,l2080h		;249b	ca 80 20 	. .   
	ret			;249e	c9 	. 
l249fh:
	ld hl,0e700h		;249f	21 00 e7 	! . . 
	set 6,(hl)		;24a2	cb f6 	. . 
	call sub_2cb9h		;24a4	cd b9 2c 	. . , 
	call sub_2c78h		;24a7	cd 78 2c 	. x , 
	ld hl,06f4eh		;24aa	21 4e 6f 	! N o 
	jp l209fh		;24ad	c3 9f 20 	. .   
sub_24b0h:
	call sub_2109h		;24b0	cd 09 21 	. . ! 
	ret nc			;24b3	d0 	. 
	ld hl,(0e80ch)		;24b4	2a 0c e8 	* . . 
	ld de,0fe60h		;24b7	11 60 fe 	. ` . 
	add hl,de			;24ba	19 	. 
	ret nc			;24bb	d0 	. 
	ld hl,l24c2h		;24bc	21 c2 24 	! . $ 
	jp l2100h		;24bf	c3 00 21 	. . ! 
l24c2h:
	ld (bc),a			;24c2	02 	. 
	nop			;24c3	00 	. 
	ld (bc),a			;24c4	02 	. 
	ld (bc),a			;24c5	02 	. 
	ld (bc),a			;24c6	02 	. 
	ld (bc),a			;24c7	02 	. 
	ld bc,0ffffh		;24c8	01 ff ff 	. . . 
	rst 38h			;24cb	ff 	. 
l24cch:
	ld b,007h		;24cc	06 07 	. . 
	ex af,af'			;24ce	08 	. 
	ex af,af'			;24cf	08 	. 
	ld de,l18ffh		;24d0	11 ff 18 	. . . 
	dec h			;24d3	25 	% 
	ld sp,hl			;24d4	f9 	. 
	rra			;24d5	1f 	. 
	jp l3525h		;24d6	c3 25 35 	. % 5 
	dec h			;24d9	25 	% 
	ld b,b			;24da	40 	@ 
	dec h			;24db	25 	% 
	dec de			;24dc	1b 	. 
	daa			;24dd	27 	' 
	ld a,a			;24de	7f 	 
	ld h,0d6h		;24df	26 d6 	& . 
	ld h,0e2h		;24e1	26 e2 	& . 
	dec de			;24e3	1b 	. 
	inc bc			;24e4	03 	. 
	jr z,$-68		;24e5	28 ba 	( . 
	daa			;24e7	27 	' 
	scf			;24e8	37 	7 
	daa			;24e9	27 	' 
	add a,h			;24ea	84 	. 
	daa			;24eb	27 	' 
	ex (sp),hl			;24ec	e3 	. 
	dec h			;24ed	25 	% 
	cpl			;24ee	2f 	/ 
	ld h,02ah		;24ef	26 2a 	& * 
	ret m			;24f1	f8 	. 
	jp po,0b47dh		;24f2	e2 7d b4 	. } . 
	jr z,l24fbh		;24f5	28 04 	( . 
	dec hl			;24f7	2b 	+ 
	ld (0e2f8h),hl		;24f8	22 f8 e2 	" . . 
l24fbh:
	ld hl,0e2d6h		;24fb	21 d6 e2 	! . . 
	ld a,(hl)			;24fe	7e 	~ 
	and a			;24ff	a7 	. 
	jr z,l2503h		;2500	28 01 	( . 
	dec (hl)			;2502	35 	5 
l2503h:
	call sub_250fh		;2503	cd 0f 25 	. . % 
	ld ix,0e2e8h		;2506	dd 21 e8 e2 	. ! . . 
	bit 4,(ix+000h)		;250a	dd cb 00 66 	. . . f 
	ret z			;250e	c8 	. 
sub_250fh:
	ld hl,024d2h		;250f	21 d2 24 	! . $ 
	call l1f23h		;2512	cd 23 1f 	. # . 
	jp l2893h		;2515	c3 93 28 	. . ( 
	call sub_2d0dh		;2518	cd 0d 2d 	. . - 
	ld de,0f800h		;251b	11 00 f8 	. . . 
	add hl,de			;251e	19 	. 
	jp nc,l2589h		;251f	d2 89 25 	. . % 
	bit 6,(ix+000h)		;2522	dd cb 00 76 	. . . v 
	ret nz			;2526	c0 	. 
	ld de,05f00h		;2527	11 00 5f 	. . _ 
	ld l,(ix+002h)		;252a	dd 6e 02 	. n . 
	ld h,(ix+003h)		;252d	dd 66 03 	. f . 
	add hl,de			;2530	19 	. 
	jp nc,l1f50h		;2531	d2 50 1f 	. P . 
	ret			;2534	c9 	. 
	call l1be2h		;2535	cd e2 1b 	. . . 
	ld de,0f800h		;2538	11 00 f8 	. . . 
	add hl,de			;253b	19 	. 
	jp nc,l2589h		;253c	d2 89 25 	. . % 
	ret			;253f	c9 	. 
	call l1be2h		;2540	cd e2 1b 	. . . 
	call sub_28bah		;2543	cd ba 28 	. . ( 
	jp c,l264bh		;2546	da 4b 26 	. K & 
	ld a,(ix+00eh)		;2549	dd 7e 0e 	. ~ . 
	and a			;254c	a7 	. 
	call m,sub_25afh		;254d	fc af 25 	. . % 
	dec (ix+007h)		;2550	dd 35 07 	. 5 . 
	ret nz			;2553	c0 	. 
	and a			;2554	a7 	. 
	jr z,l256ch		;2555	28 15 	( . 
	jp m,l258ch		;2557	fa 8c 25 	. . % 
	add a,(ix+006h)		;255a	dd 86 06 	. . . 
	ld (ix+006h),a		;255d	dd 77 06 	. w . 
	call sub_34ddh		;2560	cd dd 34 	. . 4 
l2563h:
	ld (ix+007h),00bh		;2563	dd 36 07 0b 	. 6 . . 
	ld (ix+00eh),000h		;2567	dd 36 0e 00 	. 6 . . 
	ret			;256b	c9 	. 
l256ch:
	dec (ix+00bh)		;256c	dd 35 0b 	. 5 . 
	jp z,l2220h		;256f	ca 20 22 	.   " 
	call sub_25afh		;2572	cd af 25 	. . % 
l2575h:
	ld (ix+006h),000h		;2575	dd 36 06 00 	. 6 . . 
	dec (ix+00eh)		;2579	dd 35 0e 	. 5 . 
	ld a,(0e011h)		;257c	3a 11 e0 	: . . 
	ld hl,0e1a5h		;257f	21 a5 e1 	! . . 
	call sub_1214h		;2582	cd 14 12 	. . . 
	ld (ix+007h),a		;2585	dd 77 07 	. w . 
	ret			;2588	c9 	. 
l2589h:
	call sub_2ce8h		;2589	cd e8 2c 	. . , 
l258ch:
	call sub_2cd4h		;258c	cd d4 2c 	. . , 
	jp z,l27dfh		;258f	ca df 27 	. . ' 
l2592h:
	ld a,(0e012h)		;2592	3a 12 e0 	: . . 
	ld hl,0e19eh		;2595	21 9e e1 	! . . 
	ld b,001h		;2598	06 01 	. . 
	cp (hl)			;259a	be 	. 
	jr c,l25a3h		;259b	38 06 	8 . 
	inc b			;259d	04 	. 
	inc hl			;259e	23 	# 
	cp (hl)			;259f	be 	. 
	jr c,l25a3h		;25a0	38 01 	8 . 
	inc b			;25a2	04 	. 
l25a3h:
	ld (ix+00eh),b		;25a3	dd 70 0e 	. p . 
	ld (ix+006h),004h		;25a6	dd 36 06 04 	. 6 . . 
	ld (ix+007h),00bh		;25aa	dd 36 07 0b 	. 6 . . 
	ret			;25ae	c9 	. 
sub_25afh:
	ld hl,(0e80ch)		;25af	2a 0c e8 	* . . 
	ld de,0f380h		;25b2	11 80 f3 	. . . 
	add hl,de			;25b5	19 	. 
	ret nc			;25b6	d0 	. 
	pop af			;25b7	f1 	. 
	ld (ix+006h),000h		;25b8	dd 36 06 00 	. 6 . . 
	ld (ix+007h),007h		;25bc	dd 36 07 07 	. 6 . . 
	jp l2080h		;25c0	c3 80 20 	. .   
	call l1be2h		;25c3	cd e2 1b 	. . . 
	dec (ix+007h)		;25c6	dd 35 07 	. 5 . 
	ret nz			;25c9	c0 	. 
	ld a,(0e2d7h)		;25ca	3a d7 e2 	: . . 
	and a			;25cd	a7 	. 
	jp z,l1f50h		;25ce	ca 50 1f 	. P . 
	ld (ix+001h),00dh		;25d1	dd 36 01 0d 	. 6 . . 
	ld (ix+006h),01ah		;25d5	dd 36 06 1a 	. 6 . . 
	ld (ix+007h),008h		;25d9	dd 36 07 08 	. 6 . . 
	ld hl,0e700h		;25dd	21 00 e7 	! . . 
	set 0,(hl)		;25e0	cb c6 	. . 
	ret			;25e2	c9 	. 
	call l1be2h		;25e3	cd e2 1b 	. . . 
	dec (ix+007h)		;25e6	dd 35 07 	. 5 . 
	ret nz			;25e9	c0 	. 
	ld (ix+007h),008h		;25ea	dd 36 07 08 	. 6 . . 
	inc (ix+006h)		;25ee	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;25f1	dd 7e 06 	. ~ . 
	cp 022h		;25f4	fe 22 	. " 
	ret nz			;25f6	c0 	. 
	inc (ix+001h)		;25f7	dd 34 01 	. 4 . 
	ld (ix+006h),01eh		;25fa	dd 36 06 1e 	. 6 . . 
	ld l,(ix+002h)		;25fe	dd 6e 02 	. n . 
	ld h,(ix+003h)		;2601	dd 66 03 	. f . 
	bit 6,(ix+000h)		;2604	dd cb 00 76 	. . . v 
	jr z,l2618h		;2608	28 0e 	( . 
	ld de,0a100h		;260a	11 00 a1 	. . . 
	sbc hl,de		;260d	ed 52 	. R 
	add hl,de			;260f	19 	. 
	jr c,l2626h		;2610	38 14 	8 . 
	ld de,0fd80h		;2612	11 80 fd 	. . . 
	add hl,de			;2615	19 	. 
	jr l2626h		;2616	18 0e 	. . 
l2618h:
	ld de,l0280h		;2618	11 80 02 	. . . 
	add hl,de			;261b	19 	. 
	ld de,(0e106h)		;261c	ed 5b 06 e1 	. [ . . 
	sbc hl,de		;2620	ed 52 	. R 
	add hl,de			;2622	19 	. 
	jr c,l2626h		;2623	38 01 	8 . 
	ex de,hl			;2625	eb 	. 
l2626h:
	ld (ix+002h),l		;2626	dd 75 02 	. u . 
	ld (ix+003h),h		;2629	dd 74 03 	. t . 
	jp l1be2h		;262c	c3 e2 1b 	. . . 
	call l1be2h		;262f	cd e2 1b 	. . . 
	dec (ix+007h)		;2632	dd 35 07 	. 5 . 
	ret nz			;2635	c0 	. 
	ld (ix+007h),008h		;2636	dd 36 07 08 	. 6 . . 
	inc (ix+006h)		;263a	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;263d	dd 7e 06 	. ~ . 
	cp 026h		;2640	fe 26 	. & 
	ret nz			;2642	c0 	. 
	ld hl,0e700h		;2643	21 00 e7 	! . . 
	res 0,(hl)		;2646	cb 86 	. . 
	jp l1f50h		;2648	c3 50 1f 	. P . 
l264bh:
	and a			;264b	a7 	. 
	jr z,l2698h		;264c	28 4a 	( J 
	ld (ix+006h),008h		;264e	dd 36 06 08 	. 6 . . 
	ld hl,02d70h		;2652	21 70 2d 	! p - 
	call sub_2d19h		;2655	cd 19 2d 	. . - 
	ld hl,l28d6h		;2658	21 d6 28 	! . ( 
	jr c,l266eh		;265b	38 11 	8 . 
	ld a,(hl)			;265d	7e 	~ 
	ld (ix+007h),a		;265e	dd 77 07 	. w . 
	ld (ix+001h),002h		;2661	dd 36 01 02 	. 6 . . 
	ld hl,0e2d6h		;2665	21 d6 e2 	! . . 
	ld a,(hl)			;2668	7e 	~ 
	ld (hl),01ch		;2669	36 1c 	6 . 
	inc hl			;266b	23 	# 
	ld (hl),a			;266c	77 	w 
	ret			;266d	c9 	. 
l266eh:
	call l1b96h		;266e	cd 96 1b 	. . . 
	ld l,(ix+002h)		;2671	dd 6e 02 	. n . 
	ld h,(ix+003h)		;2674	dd 66 03 	. f . 
	ld de,000d7h		;2677	11 d7 00 	. . . 
	ld a,00ah		;267a	3e 0a 	> . 
	jp sub_2f60h		;267c	c3 60 2f 	. ` / 
	call l1be2h		;267f	cd e2 1b 	. . . 
	dec (ix+007h)		;2682	dd 35 07 	. 5 . 
	ret nz			;2685	c0 	. 
	ld a,(ix+006h)		;2686	dd 7e 06 	. ~ . 
	inc a			;2689	3c 	< 
	cp 013h		;268a	fe 13 	. . 
	jr c,l26ceh		;268c	38 40 	8 @ 
	jr nz,l26edh		;268e	20 5d 	  ] 
	ld (ix+007h),01ch		;2690	dd 36 07 1c 	. 6 . . 
	ld a,026h		;2694	3e 26 	> & 
	jr l26d2h		;2696	18 3a 	. : 
l2698h:
	ld a,091h		;2698	3e 91 	> . 
	call sub_0dfeh		;269a	cd fe 0d 	. . . 
	ld l,(ix+002h)		;269d	dd 6e 02 	. n . 
	ld h,(ix+003h)		;26a0	dd 66 03 	. f . 
	ld (0e31dh),hl		;26a3	22 1d e3 	" . . 
	ld a,(ix+000h)		;26a6	dd 7e 00 	. ~ . 
	and 050h		;26a9	e6 50 	. P 
	ld (0e31bh),a		;26ab	32 1b e3 	2 . . 
	ld hl,06500h		;26ae	21 00 65 	! . e 
	ld (0e31fh),hl		;26b1	22 1f e3 	" . . 
	ld hl,l005bh		;26b4	21 5b 00 	! [ . 
	ld (0e327h),hl		;26b7	22 27 e3 	" ' . 
	ld a,005h		;26ba	3e 05 	> . 
	ld (0e322h),a		;26bc	32 22 e3 	2 " . 
	xor a			;26bf	af 	. 
	ld (0e321h),a		;26c0	32 21 e3 	2 ! . 
	ld hl,0e700h		;26c3	21 00 e7 	! . . 
	set 0,(hl)		;26c6	cb c6 	. . 
	ld (ix+001h),006h		;26c8	dd 36 01 06 	. 6 . . 
	ld a,00bh		;26cc	3e 0b 	> . 
l26ceh:
	ld (ix+007h),008h		;26ce	dd 36 07 08 	. 6 . . 
l26d2h:
	ld (ix+006h),a		;26d2	dd 77 06 	. w . 
	ret			;26d5	c9 	. 
	call l1be2h		;26d6	cd e2 1b 	. . . 
	dec (ix+007h)		;26d9	dd 35 07 	. 5 . 
	ret nz			;26dc	c0 	. 
	ld a,(ix+006h)		;26dd	dd 7e 06 	. ~ . 
	inc a			;26e0	3c 	< 
	cp 01ah		;26e1	fe 1a 	. . 
	jr c,l26ceh		;26e3	38 e9 	8 . 
	ld hl,0e700h		;26e5	21 00 e7 	! . . 
	res 0,(hl)		;26e8	cb 86 	. . 
	jp l2589h		;26ea	c3 89 25 	. . % 
l26edh:
	inc (ix+001h)		;26ed	dd 34 01 	. 4 . 
	ld l,(ix+002h)		;26f0	dd 6e 02 	. n . 
	ld h,(ix+003h)		;26f3	dd 66 03 	. f . 
	ld de,l0280h		;26f6	11 80 02 	. . . 
	bit 6,(ix+000h)		;26f9	dd cb 00 76 	. . . v 
	jr nz,l270ch		;26fd	20 0d 	  . 
	add hl,de			;26ff	19 	. 
	ex de,hl			;2700	eb 	. 
	ld hl,(0e106h)		;2701	2a 06 e1 	* . . 
	sbc hl,de		;2704	ed 52 	. R 
	add hl,de			;2706	19 	. 
	jr c,l270eh		;2707	38 05 	8 . 
	ex de,hl			;2709	eb 	. 
	jr l270eh		;270a	18 02 	. . 
l270ch:
	sbc hl,de		;270c	ed 52 	. R 
l270eh:
	ld (ix+002h),l		;270e	dd 75 02 	. u . 
	ld (ix+003h),h		;2711	dd 74 03 	. t . 
	call l1be2h		;2714	cd e2 1b 	. . . 
	ld a,00fh		;2717	3e 0f 	> . 
	jr l26ceh		;2719	18 b3 	. . 
	call sub_2d13h		;271b	cd 13 2d 	. . - 
	call sub_28bah		;271e	cd ba 28 	. . ( 
	jp c,l264bh		;2721	da 4b 26 	. K & 
	call sub_2cd4h		;2724	cd d4 2c 	. . , 
	jp z,l2080h		;2727	ca 80 20 	. .   
	bit 6,(ix+000h)		;272a	dd cb 00 76 	. . . v 
	jp z,l2488h		;272e	ca 88 24 	. . $ 
	ld de,0a100h		;2731	11 00 a1 	. . . 
	jp l2071h		;2734	c3 71 20 	. q   
l2737h:
	dec (ix+007h)		;2737	dd 35 07 	. 5 . 
	jr nz,l2752h		;273a	20 16 	  . 
	inc (ix+007h)		;273c	dd 34 07 	. 4 . 
	call sub_2887h		;273f	cd 87 28 	. . ( 
	jr nz,l27b0h		;2742	20 6c 	  l 
	ld (ix+007h),007h		;2744	dd 36 07 07 	. 6 . . 
	dec (ix+006h)		;2748	dd 35 06 	. 5 . 
	jp p,l2752h		;274b	f2 52 27 	. R ' 
	ld (ix+006h),003h		;274e	dd 36 06 03 	. 6 . . 
l2752h:
	ld hl,(0e712h)		;2752	2a 12 e7 	* . . 
	ld e,(ix+00ch)		;2755	dd 5e 0c 	. ^ . 
	ld d,(ix+00dh)		;2758	dd 56 0d 	. V . 
	sbc hl,de		;275b	ed 52 	. R 
	ex de,hl			;275d	eb 	. 
	bit 6,(ix+000h)		;275e	dd cb 00 76 	. . . v 
	jr nz,l2771h		;2762	20 0d 	  . 
	ld hl,(0e106h)		;2764	2a 06 e1 	* . . 
	sbc hl,de		;2767	ed 52 	. R 
	jr nc,l276fh		;2769	30 04 	0 . 
	ld de,(0e106h)		;276b	ed 5b 06 e1 	. [ . . 
l276fh:
	jr l277bh		;276f	18 0a 	. . 
l2771h:
	ld hl,08580h		;2771	21 80 85 	! . . 
	sbc hl,de		;2774	ed 52 	. R 
	jr c,l277bh		;2776	38 03 	8 . 
	ld de,08580h		;2778	11 80 85 	. . . 
l277bh:
	ld (ix+002h),e		;277b	dd 73 02 	. s . 
	ld (ix+003h),d		;277e	dd 72 03 	. r . 
	jp l1be2h		;2781	c3 e2 1b 	. . . 
	call l1be2h		;2784	cd e2 1b 	. . . 
	call sub_2887h		;2787	cd 87 28 	. . ( 
	jr z,l27a3h		;278a	28 17 	( . 
	dec (ix+007h)		;278c	dd 35 07 	. 5 . 
	ret nz			;278f	c0 	. 
	ld a,(ix+00eh)		;2790	dd 7e 0e 	. ~ . 
	and a			;2793	a7 	. 
	jp z,l2575h		;2794	ca 75 25 	. u % 
	jp m,l2592h		;2797	fa 92 25 	. . % 
	add a,(ix+006h)		;279a	dd 86 06 	. . . 
	ld (ix+006h),a		;279d	dd 77 06 	. w . 
	jp l2563h		;27a0	c3 63 25 	. c % 
l27a3h:
	ld (ix+006h),000h		;27a3	dd 36 06 00 	. 6 . . 
	ld (ix+007h),002h		;27a7	dd 36 07 02 	. 6 . . 
	ld (ix+001h),00bh		;27ab	dd 36 01 0b 	. 6 . . 
	ret			;27af	c9 	. 
l27b0h:
	ld (ix+001h),00ch		;27b0	dd 36 01 0c 	. 6 . . 
	call l2592h		;27b4	cd 92 25 	. . % 
	jp l1be2h		;27b7	c3 e2 1b 	. . . 
	call l1be2h		;27ba	cd e2 1b 	. . . 
	dec (ix+007h)		;27bd	dd 35 07 	. 5 . 
	ret nz			;27c0	c0 	. 
	ld (ix+007h),008h		;27c1	dd 36 07 08 	. 6 . . 
	inc (ix+006h)		;27c5	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;27c8	dd 7e 06 	. ~ . 
	cp 022h		;27cb	fe 22 	. " 
	ret nz			;27cd	c0 	. 
	ld hl,l018bh		;27ce	21 8b 01 	! . . 
	ld (0e2f8h),hl		;27d1	22 f8 e2 	" . . 
	ld (ix+000h),000h		;27d4	dd 36 00 00 	. 6 . . 
	ld hl,0e701h		;27d8	21 01 e7 	! . . 
	res 4,(hl)		;27db	cb a6 	. . 
	jr l283dh		;27dd	18 5e 	. ^ 
l27dfh:
	ld hl,0e700h		;27df	21 00 e7 	! . . 
	set 0,(hl)		;27e2	cb c6 	. . 
	ld a,(0e2e8h)		;27e4	3a e8 e2 	: . . 
	and 010h		;27e7	e6 10 	. . 
	jr z,l284fh		;27e9	28 64 	( d 
	push ix		;27eb	dd e5 	. . 
	ld ix,0e2d8h		;27ed	dd 21 d8 e2 	. ! . . 
	call sub_287eh		;27f1	cd 7e 28 	. ~ ( 
	ld (ix+017h),008h		;27f4	dd 36 17 08 	. 6 . . 
	ld (ix+016h),01ah		;27f8	dd 36 16 1a 	. 6 . . 
	ld (ix+011h),00ah		;27fc	dd 36 11 0a 	. 6 . . 
l2800h:
	pop ix		;2800	dd e1 	. . 
	ret			;2802	c9 	. 
	call l1be2h		;2803	cd e2 1b 	. . . 
	dec (ix+007h)		;2806	dd 35 07 	. 5 . 
	ret nz			;2809	c0 	. 
	ld (ix+007h),008h		;280a	dd 36 07 08 	. 6 . . 
	inc (ix+006h)		;280e	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;2811	dd 7e 06 	. ~ . 
	cp 026h		;2814	fe 26 	. & 
	ret nz			;2816	c0 	. 
	ld hl,l011ah		;2817	21 1a 01 	! . . 
	ld (0e2f8h),hl		;281a	22 f8 e2 	" . . 
	call l27a3h		;281d	cd a3 27 	. . ' 
	call l283dh		;2820	cd 3d 28 	. = ( 
	ld a,r		;2823	ed 5f 	. _ 
	and 001h		;2825	e6 01 	. . 
	ret z			;2827	c8 	. 
	ld (ix-00fh),00bh		;2828	dd 36 f1 0b 	. 6 . . 
	ld (ix+001h),000h		;282c	dd 36 01 00 	. 6 . . 
	ld hl,0		;2830	21 00 00 	! . . 
	ld de,(0e2f4h)		;2833	ed 5b f4 e2 	. [ . . 
	sbc hl,de		;2837	ed 52 	. R 
	ld (0e2e4h),hl		;2839	22 e4 e2 	" . . 
	ret			;283c	c9 	. 
l283dh:
	ld (ix-00ah),000h		;283d	dd 36 f6 00 	. 6 . . 
	ld (ix-009h),002h		;2841	dd 36 f7 02 	. 6 . . 
	ld (ix-00fh),000h		;2845	dd 36 f1 00 	. 6 . . 
	ld hl,0e700h		;2849	21 00 e7 	! . . 
	res 0,(hl)		;284c	cb 86 	. . 
	ret			;284e	c9 	. 
l284fh:
	ld de,(0e80ah)		;284f	ed 5b 0a e8 	. [ . . 
	ld hl,0fd60h		;2853	21 60 fd 	! ` . 
	add hl,de			;2856	19 	. 
	jr c,l285ch		;2857	38 03 	8 . 
	ld de,l02a0h		;2859	11 a0 02 	. . . 
l285ch:
	ld hl,(0e712h)		;285c	2a 12 e7 	* . . 
	ld (0e2f4h),de		;285f	ed 53 f4 e2 	. S . . 
	sbc hl,de		;2863	ed 52 	. R 
	ld (0e2eah),hl		;2865	22 ea e2 	" . . 
	ld hl,05000h		;2868	21 00 50 	! . P 
	ld (0e2ech),hl		;286b	22 ec e2 	" . . 
	ld (ix+010h),050h		;286e	dd 36 10 50 	. 6 . P 
	ld (ix+017h),008h		;2872	dd 36 17 08 	. 6 . . 
	ld (ix+016h),01eh		;2876	dd 36 16 1e 	. 6 . . 
	ld (ix+011h),009h		;287a	dd 36 11 09 	. 6 . . 
sub_287eh:
	ld (ix+001h),008h		;287e	dd 36 01 08 	. 6 . . 
	ld (ix+006h),01ah		;2882	dd 36 06 1a 	. 6 . . 
	ret			;2886	c9 	. 
sub_2887h:
	ld a,(0e702h)		;2887	3a 02 e7 	: . . 
	cp 001h		;288a	fe 01 	. . 
	ret z			;288c	c8 	. 
	cp 009h		;288d	fe 09 	. . 
	ret z			;288f	c8 	. 
	cp 00ah		;2890	fe 0a 	. . 
	ret			;2892	c9 	. 
l2893h:
	ld hl,(0e80ch)		;2893	2a 0c e8 	* . . 
	ld de,0e800h		;2896	11 00 e8 	. . . 
	add hl,de			;2899	19 	. 
	ld hl,0e197h		;289a	21 97 e1 	! . . 
	ld de,0e198h		;289d	11 98 e1 	. . . 
	jr nc,l28aah		;28a0	30 08 	0 . 
	ld a,(0e2e8h)		;28a2	3a e8 e2 	: . . 
	and 010h		;28a5	e6 10 	. . 
	jr nz,l28aah		;28a7	20 01 	  . 
	ex de,hl			;28a9	eb 	. 
l28aah:
	ld a,(hl)			;28aa	7e 	~ 
	and a			;28ab	a7 	. 
	jr z,l28b1h		;28ac	28 03 	( . 
	ld (de),a			;28ae	12 	. 
	ld (hl),000h		;28af	36 00 	6 . 
l28b1h:
	ld hl,07047h		;28b1	21 47 70 	! G p 
	ld de,0fe00h		;28b4	11 00 fe 	. . . 
	jp l20adh		;28b7	c3 ad 20 	. .   
sub_28bah:
	call sub_1ae7h		;28ba	cd e7 1a 	. . . 
	ret nc			;28bd	d0 	. 
	ld hl,(0e80ch)		;28be	2a 0c e8 	* . . 
	ld de,0fe60h		;28c1	11 60 fe 	. ` . 
	add hl,de			;28c4	19 	. 
	ret nc			;28c5	d0 	. 
	ld hl,l28cch		;28c6	21 cc 28 	! . ( 
	jp sub_1b18h		;28c9	c3 18 1b 	. . . 
l28cch:
	nop			;28cc	00 	. 
	rst 38h			;28cd	ff 	. 
	nop			;28ce	00 	. 
	nop			;28cf	00 	. 
	nop			;28d0	00 	. 
	nop			;28d1	00 	. 
	ld bc,0ffffh		;28d2	01 ff ff 	. . . 
	rst 38h			;28d5	ff 	. 
l28d6h:
	ld b,009h		;28d6	06 09 	. . 
	ex af,af'			;28d8	08 	. 
	ld a,(bc)			;28d9	0a 	. 
	inc de			;28da	13 	. 
	rst 38h			;28db	ff 	. 
l28dch:
	call m,0f928h		;28dc	fc 28 f9 	. ( . 
	rra			;28df	1f 	. 
	xor 02ah		;28e0	ee 2a 	. * 
	ld d,(hl)			;28e2	56 	V 
	add hl,hl			;28e3	29 	) 
	call z,08c29h		;28e4	cc 29 8c 	. ) . 
	ld hl,(l2914h)		;28e7	2a 14 29 	* . ) 
	adc a,a			;28ea	8f 	. 
	add hl,hl			;28eb	29 	) 
	ret z			;28ec	c8 	. 
	ld hl,(l2b28h)		;28ed	2a 28 2b 	* ( + 
	ld (0212bh),a		;28f0	32 2b 21 	2 + ! 
	ld e,d			;28f3	5a 	Z 
	inc l			;28f4	2c 	, 
	push hl			;28f5	e5 	. 
	ld hl,l28dch		;28f6	21 dc 28 	! . ( 
	jp l1f23h		;28f9	c3 23 1f 	. # . 
	call sub_2d0dh		;28fc	cd 0d 2d 	. . - 
	ld de,0f760h		;28ff	11 60 f7 	. ` . 
	add hl,de			;2902	19 	. 
	jr nc,l292fh		;2903	30 2a 	0 * 
	jr l2923h		;2905	18 1c 	. . 
l2907h:
	ld (ix+007h),007h		;2907	dd 36 07 07 	. 6 . . 
	ld (ix+001h),000h		;290b	dd 36 01 00 	. 6 . . 
	ld (ix+006h),000h		;290f	dd 36 06 00 	. 6 . . 
	ret			;2913	c9 	. 
l2914h:
	call sub_293ch		;2914	cd 3c 29 	. < ) 
	call sub_1c70h		;2917	cd 70 1c 	. p . 
	call l1be2h		;291a	cd e2 1b 	. . . 
	ld de,0f760h		;291d	11 60 f7 	. ` . 
	add hl,de			;2920	19 	. 
	jr c,l2907h		;2921	38 e4 	8 . 
l2923h:
	ld de,0c000h		;2923	11 00 c0 	. . . 
	ld hl,(0e2dah)		;2926	2a da e2 	* . . 
	add hl,de			;2929	19 	. 
	jp c,l1f50h		;292a	da 50 1f 	. P . 
	jr l2965h		;292d	18 36 	. 6 
l292fh:
	ld (ix+007h),009h		;292f	dd 36 07 09 	. 6 . . 
	ld (ix+006h),004h		;2933	dd 36 06 04 	. 6 . . 
l2937h:
	ld (ix+001h),006h		;2937	dd 36 01 06 	. 6 . . 
	ret			;293b	c9 	. 
sub_293ch:
	dec (ix+007h)		;293c	dd 35 07 	. 5 . 
	jr nz,l2952h		;293f	20 11 	  . 
	ld (ix+007h),009h		;2941	dd 36 07 09 	. 6 . . 
	ld a,(ix+006h)		;2945	dd 7e 06 	. ~ . 
	inc a			;2948	3c 	< 
	cp 005h		;2949	fe 05 	. . 
	jr z,l294fh		;294b	28 02 	( . 
	ld a,004h		;294d	3e 04 	> . 
l294fh:
	ld (ix+006h),a		;294f	dd 77 06 	. w . 
l2952h:
	ld de,0011h+1		;2952	11 12 00 	. . . 
	ret			;2955	c9 	. 
	call l1be2h		;2956	cd e2 1b 	. . . 
	ld de,0f760h		;2959	11 60 f7 	. ` . 
	add hl,de			;295c	19 	. 
	ld a,004h		;295d	3e 04 	> . 
	jr nc,l2962h		;295f	30 01 	0 . 
	xor a			;2961	af 	. 
l2962h:
	ld (ix+006h),a		;2962	dd 77 06 	. w . 
l2965h:
	call sub_2ba0h		;2965	cd a0 2b 	. . + 
	ld hl,(0e80ch)		;2968	2a 0c e8 	* . . 
	ld de,0fb80h		;296b	11 80 fb 	. . . 
	add hl,de			;296e	19 	. 
	ret c			;296f	d8 	. 
	ld a,(ix+008h)		;2970	dd 7e 08 	. ~ . 
	and a			;2973	a7 	. 
	jp nz,l2ae9h		;2974	c2 e9 2a 	. . * 
l2977h:
	ld (ix+006h),004h		;2977	dd 36 06 04 	. 6 . . 
	ld hl,(0e80ch)		;297b	2a 0c e8 	* . . 
	ld de,0fd00h		;297e	11 00 fd 	. . . 
	add hl,de			;2981	19 	. 
	jr nc,l29a0h		;2982	30 1c 	0 . 
	ld a,(0e1aah)		;2984	3a aa e1 	: . . 
	ld (ix+007h),a		;2987	dd 77 07 	. w . 
	ld (ix+001h),007h		;298a	dd 36 01 07 	. 6 . . 
	ret			;298e	c9 	. 
	ld de,(0e1abh)		;298f	ed 5b ab e1 	. [ . . 
	call sub_1c70h		;2993	cd 70 1c 	. p . 
	call l1be2h		;2996	cd e2 1b 	. . . 
	call sub_2ba0h		;2999	cd a0 2b 	. . + 
	dec (ix+007h)		;299c	dd 35 07 	. 5 . 
	ret nz			;299f	c0 	. 
l29a0h:
	call sub_2ce8h		;29a0	cd e8 2c 	. . , 
l29a3h:
	ld hl,(0e80ch)		;29a3	2a 0c e8 	* . . 
	ld de,0fc80h		;29a6	11 80 fc 	. . . 
	add hl,de			;29a9	19 	. 
	jp c,l2a55h		;29aa	da 55 2a 	. U * 
	ld a,(0e011h)		;29ad	3a 11 e0 	: . . 
	ld hl,0e19eh		;29b0	21 9e e1 	! . . 
	ld b,006h		;29b3	06 06 	. . 
	cp (hl)			;29b5	be 	. 
	jr c,l29c0h		;29b6	38 08 	8 . 
	inc hl			;29b8	23 	# 
	ld b,00bh		;29b9	06 0b 	. . 
	cp (hl)			;29bb	be 	. 
	jr c,l29c0h		;29bc	38 02 	8 . 
	ld b,010h		;29be	06 10 	. . 
l29c0h:
	ld (ix+006h),b		;29c0	dd 70 06 	. p . 
	ld (ix+007h),005h		;29c3	dd 36 07 05 	. 6 . . 
	ld (ix+00eh),005h		;29c7	dd 36 0e 05 	. 6 . . 
	ret			;29cb	c9 	. 
	call l1be2h		;29cc	cd e2 1b 	. . . 
	call sub_2ba0h		;29cf	cd a0 2b 	. . + 
	dec (ix+007h)		;29d2	dd 35 07 	. 5 . 
	ret nz			;29d5	c0 	. 
	dec (ix+00eh)		;29d6	dd 35 0e 	. 5 . 
	jr z,l2a3dh		;29d9	28 62 	( b 
	jp m,l29a3h		;29db	fa a3 29 	. . ) 
	ld a,(ix+00eh)		;29de	dd 7e 0e 	. ~ . 
	cp 003h		;29e1	fe 03 	. . 
	jr nz,l2a2ch		;29e3	20 47 	  G 
	ld a,(ix+006h)		;29e5	dd 7e 06 	. ~ . 
	cp 00ch		;29e8	fe 0c 	. . 
	ld hl,l2a73h		;29ea	21 73 2a 	! s * 
	jr c,l29f7h		;29ed	38 08 	8 . 
	ld hl,l2a7ah		;29ef	21 7a 2a 	! z * 
	jr z,l29f7h		;29f2	28 03 	( . 
	ld hl,02a81h		;29f4	21 81 2a 	! . * 
l29f7h:
	ld a,(ix+002h)		;29f7	dd 7e 02 	. ~ . 
	add a,(hl)			;29fa	86 	. 
	inc hl			;29fb	23 	# 
	ld e,a			;29fc	5f 	_ 
	ld a,(ix+003h)		;29fd	dd 7e 03 	. ~ . 
	adc a,(hl)			;2a00	8e 	. 
	inc hl			;2a01	23 	# 
	ld d,a			;2a02	57 	W 
	ld (0e80fh),de		;2a03	ed 53 0f e8 	. S . . 
	ld a,e			;2a07	7b 	{ 
	add a,(hl)			;2a08	86 	. 
	inc hl			;2a09	23 	# 
	ld e,a			;2a0a	5f 	_ 
	ld a,d			;2a0b	7a 	z 
	adc a,(hl)			;2a0c	8e 	. 
	inc hl			;2a0d	23 	# 
	ld d,a			;2a0e	57 	W 
	ld (0e811h),de		;2a0f	ed 53 11 e8 	. S . . 
	ld e,(hl)			;2a13	5e 	^ 
	inc hl			;2a14	23 	# 
	ld d,(hl)			;2a15	56 	V 
	inc hl			;2a16	23 	# 
	ld l,(hl)			;2a17	6e 	n 
	ld h,000h		;2a18	26 00 	& . 
	ex de,hl			;2a1a	eb 	. 
	push hl			;2a1b	e5 	. 
	call sub_1172h		;2a1c	cd 72 11 	. r . 
	pop hl			;2a1f	e1 	. 
	jr nc,l2a2ch		;2a20	30 0a 	0 . 
	ld de,00400h		;2a22	11 00 04 	. . . 
	add hl,de			;2a25	19 	. 
	ld de,l0016h+2		;2a26	11 18 00 	. . . 
	call l2c95h		;2a29	cd 95 2c 	. . , 
l2a2ch:
	inc (ix+006h)		;2a2c	dd 34 06 	. 4 . 
	ld e,(ix+00eh)		;2a2f	dd 5e 0e 	. ^ . 
	ld d,000h		;2a32	16 00 	. . 
	ld hl,l2a87h		;2a34	21 87 2a 	! . * 
	add hl,de			;2a37	19 	. 
	ld a,(hl)			;2a38	7e 	~ 
	ld (ix+007h),a		;2a39	dd 77 07 	. w . 
	ret			;2a3c	c9 	. 
l2a3dh:
	dec (ix+00bh)		;2a3d	dd 35 0b 	. 5 . 
	jr z,l2a55h		;2a40	28 13 	( . 
	ld a,(0e012h)		;2a42	3a 12 e0 	: . . 
	ld hl,0e1a5h		;2a45	21 a5 e1 	! . . 
	call sub_1214h		;2a48	cd 14 12 	. . . 
	ld (ix+007h),a		;2a4b	dd 77 07 	. w . 
	ret			;2a4e	c9 	. 
l2a4fh:
	ld hl,05000h		;2a4f	21 00 50 	! . P 
	ld (0e2dch),hl		;2a52	22 dc e2 	" . . 
l2a55h:
	ld (ix+006h),004h		;2a55	dd 36 06 04 	. 6 . . 
	ld hl,(0e2dah)		;2a59	2a da e2 	* . . 
	ld de,0fe00h		;2a5c	11 00 fe 	. . . 
	add hl,de			;2a5f	19 	. 
	ld de,(0e104h)		;2a60	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2a64	ed 52 	. R 
	jr c,l2ad9h		;2a66	38 71 	8 q 
	ld (ix+001h),008h		;2a68	dd 36 01 08 	. 6 . . 
	ld a,(0e1aah)		;2a6c	3a aa e1 	: . . 
	ld (ix+007h),a		;2a6f	dd 77 07 	. w . 
	ret			;2a72	c9 	. 
l2a73h:
	jr nz,l2a76h		;2a73	20 01 	  . 
	ld h,b			;2a75	60 	` 
l2a76h:
	ld bc,06780h		;2a76	01 80 67 	. . g 
	rlca			;2a79	07 	. 
l2a7ah:
	ld b,b			;2a7a	40 	@ 
	ld bc,l0220h		;2a7b	01 20 02 	.   . 
	nop			;2a7e	00 	. 
	ld h,(hl)			;2a7f	66 	f 
	ld c,080h		;2a80	0e 80 	. . 
	ld bc,00200h		;2a82	01 00 02 	. . . 
	nop			;2a85	00 	. 
	ld d,b			;2a86	50 	P 
l2a87h:
	ld a,(bc)			;2a87	0a 	. 
	ld bc,l0b10h		;2a88	01 10 0b 	. . . 
	djnz $-49		;2a8b	10 cd 	. . 
	inc a			;2a8d	3c 	< 
	add hl,hl			;2a8e	29 	) 
	call sub_1c7ah		;2a8f	cd 7a 1c 	. z . 
	call sub_2ab6h		;2a92	cd b6 2a 	. . * 
	call sub_2ba0h		;2a95	cd a0 2b 	. . + 
	ld a,(ix+008h)		;2a98	dd 7e 08 	. ~ . 
	and a			;2a9b	a7 	. 
	jp z,l2977h		;2a9c	ca 77 29 	. w ) 
	ld hl,(0e80ch)		;2a9f	2a 0c e8 	* . . 
	ld de,0fb00h		;2aa2	11 00 fb 	. . . 
	add hl,de			;2aa5	19 	. 
	jp c,l2937h		;2aa6	da 37 29 	. 7 ) 
	ld hl,(0e2dah)		;2aa9	2a da e2 	* . . 
	ld de,(0e104h)		;2aac	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2ab0	ed 52 	. R 
	jp c,l2977h		;2ab2	da 77 29 	. w ) 
	ret			;2ab5	c9 	. 
sub_2ab6h:
	ld hl,(0e2dah)		;2ab6	2a da e2 	* . . 
	ld de,(0e104h)		;2ab9	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2abd	ed 52 	. R 
	jr nc,l2ac5h		;2abf	30 04 	0 . 
	ld (0e2dah),de		;2ac1	ed 53 da e2 	. S . . 
l2ac5h:
	jp l1be2h		;2ac5	c3 e2 1b 	. . . 
	ld de,(0e1abh)		;2ac8	ed 5b ab e1 	. [ . . 
	call sub_1c7ah		;2acc	cd 7a 1c 	. z . 
	call sub_2ab6h		;2acf	cd b6 2a 	. . * 
	call sub_2ba0h		;2ad2	cd a0 2b 	. . + 
	dec (ix+007h)		;2ad5	dd 35 07 	. 5 . 
	ret nz			;2ad8	c0 	. 
l2ad9h:
	ld a,(0e012h)		;2ad9	3a 12 e0 	: . . 
	ld hl,0e1a0h		;2adc	21 a0 e1 	! . . 
	call sub_1214h		;2adf	cd 14 12 	. . . 
	ld (ix+008h),a		;2ae2	dd 77 08 	. w . 
	ld (ix+007h),009h		;2ae5	dd 36 07 09 	. 6 . . 
l2ae9h:
	ld (ix+001h),005h		;2ae9	dd 36 01 05 	. 6 . . 
	ret			;2aed	c9 	. 
	call l1be2h		;2aee	cd e2 1b 	. . . 
	dec (ix+007h)		;2af1	dd 35 07 	. 5 . 
	jp z,l2a4fh		;2af4	ca 4f 2a 	. O * 
	ret			;2af7	c9 	. 
l2af8h:
	pop hl			;2af8	e1 	. 
	ld a,b			;2af9	78 	x 
	cp 002h		;2afa	fe 02 	. . 
	ld a,01bh		;2afc	3e 1b 	> . 
	jr c,l2b04h		;2afe	38 04 	8 . 
	jr z,l2b03h		;2b00	28 01 	( . 
	dec a			;2b02	3d 	= 
l2b03h:
	dec a			;2b03	3d 	= 
l2b04h:
	ld (ix+006h),a		;2b04	dd 77 06 	. w . 
	ld a,b			;2b07	78 	x 
	cp 003h		;2b08	fe 03 	. . 
	jr z,l2b10h		;2b0a	28 04 	( . 
	xor a			;2b0c	af 	. 
	ld (0e2d6h),a		;2b0d	32 d6 e2 	2 . . 
l2b10h:
	ld hl,l2c69h		;2b10	21 69 2c 	! i , 
	call l1b96h		;2b13	cd 96 1b 	. . . 
	ld hl,l2d67h		;2b16	21 67 2d 	! g - 
	ld de,l00deh		;2b19	11 de 00 	. . . 
	call sub_2d19h		;2b1c	cd 19 2d 	. . - 
	ld a,00bh		;2b1f	3e 0b 	> . 
	jp c,l247ah		;2b21	da 7a 24 	. z $ 
	inc (ix+001h)		;2b24	dd 34 01 	. 4 . 
	ret			;2b27	c9 	. 
l2b28h:
	call l1be2h		;2b28	cd e2 1b 	. . . 
	dec (ix+007h)		;2b2b	dd 35 07 	. 5 . 
	jp z,l2a55h		;2b2e	ca 55 2a 	. U * 
	ret			;2b31	c9 	. 
	call l1be2h		;2b32	cd e2 1b 	. . . 
	ld hl,0e2d7h		;2b35	21 d7 e2 	! . . 
	ld a,(hl)			;2b38	7e 	~ 
	and a			;2b39	a7 	. 
	jr nz,l2b4eh		;2b3a	20 12 	  . 
	ld a,(0e2deh)		;2b3c	3a de e2 	: . . 
	cp 01eh		;2b3f	fe 1e 	. . 
	jr nz,l2b4eh		;2b41	20 0b 	  . 
	ld (hl),001h		;2b43	36 01 	6 . 
	ld hl,06000h		;2b45	21 00 60 	! . ` 
	ld de,l0016h+2		;2b48	11 18 00 	. . . 
	call l2c95h		;2b4b	cd 95 2c 	. . , 
l2b4eh:
	ld hl,(0e2e4h)		;2b4e	2a e4 e2 	* . . 
	dec (ix+007h)		;2b51	dd 35 07 	. 5 . 
	jr nz,l2b6ah		;2b54	20 14 	  . 
	inc hl			;2b56	23 	# 
	inc hl			;2b57	23 	# 
	ld a,(hl)			;2b58	7e 	~ 
	cp 0ffh		;2b59	fe ff 	. . 
	jp z,l2a4fh		;2b5b	ca 4f 2a 	. O * 
	ld (ix+006h),a		;2b5e	dd 77 06 	. w . 
	inc hl			;2b61	23 	# 
	ld a,(hl)			;2b62	7e 	~ 
	ld (ix+007h),a		;2b63	dd 77 07 	. w . 
	inc hl			;2b66	23 	# 
	ld (0e2e4h),hl		;2b67	22 e4 e2 	" . . 
l2b6ah:
	ld a,(hl)			;2b6a	7e 	~ 
	add a,(ix+004h)		;2b6b	dd 86 04 	. . . 
	ld (ix+004h),a		;2b6e	dd 77 04 	. w . 
	inc hl			;2b71	23 	# 
	ld a,(hl)			;2b72	7e 	~ 
	adc a,(ix+005h)		;2b73	dd 8e 05 	. . . 
	ld (ix+005h),a		;2b76	dd 77 05 	. w . 
	ret			;2b79	c9 	. 
l2b7ah:
	jr nz,$+3		;2b7a	20 01 	  . 
	jr $+5		;2b7c	18 03 	. . 
	xor d			;2b7e	aa 	. 
	nop			;2b7f	00 	. 
	jr l2b84h		;2b80	18 02 	. . 
	nop			;2b82	00 	. 
	nop			;2b83	00 	. 
l2b84h:
	jr l2b89h		;2b84	18 03 	. . 
	ld d,(hl)			;2b86	56 	V 
	rst 38h			;2b87	ff 	. 
	rla			;2b88	17 	. 
l2b89h:
	inc b			;2b89	04 	. 
	ret po			;2b8a	e0 	. 
	cp 0ffh		;2b8b	fe ff 	. . 
l2b8dh:
	jr nz,$+3		;2b8d	20 01 	  . 
	ld e,003h		;2b8f	1e 03 	. . 
	xor d			;2b91	aa 	. 
	nop			;2b92	00 	. 
	ld e,002h		;2b93	1e 02 	. . 
	nop			;2b95	00 	. 
	nop			;2b96	00 	. 
	ld e,003h		;2b97	1e 03 	. . 
	ld d,(hl)			;2b99	56 	V 
	rst 38h			;2b9a	ff 	. 
	rla			;2b9b	17 	. 
	inc b			;2b9c	04 	. 
	ret po			;2b9d	e0 	. 
	cp 0ffh		;2b9e	fe ff 	. . 
sub_2ba0h:
	call sub_1ae7h		;2ba0	cd e7 1a 	. . . 
	ret nc			;2ba3	d0 	. 
	ld hl,l2c36h		;2ba4	21 36 2c 	! 6 , 
	call sub_1b18h		;2ba7	cd 18 1b 	. . . 
	ret nc			;2baa	d0 	. 
	ld b,a			;2bab	47 	G 
	ld e,(ix+006h)		;2bac	dd 5e 06 	. ^ . 
	ld d,000h		;2baf	16 00 	. . 
	ld hl,l2c40h		;2bb1	21 40 2c 	! @ , 
	add hl,de			;2bb4	19 	. 
	ld a,(hl)			;2bb5	7e 	~ 
	cp 0ffh		;2bb6	fe ff 	. . 
	ret z			;2bb8	c8 	. 
	ld hl,0e2d6h		;2bb9	21 d6 e2 	! . . 
	inc (hl)			;2bbc	34 	4 
	cp 0feh		;2bbd	fe fe 	. . 
	jr z,l2bddh		;2bbf	28 1c 	( . 
	cp 008h		;2bc1	fe 08 	. . 
	jr c,l2bd0h		;2bc3	38 0b 	8 . 
	ld e,a			;2bc5	5f 	_ 
	ld a,b			;2bc6	78 	x 
	cp 002h		;2bc7	fe 02 	. . 
	jr c,l2c2dh		;2bc9	38 62 	8 b 
	ld a,e			;2bcb	7b 	{ 
	cp 009h		;2bcc	fe 09 	. . 
	jr z,l2bddh		;2bce	28 0d 	( . 
l2bd0h:
	add a,b			;2bd0	80 	. 
	ld e,a			;2bd1	5f 	_ 
	ld hl,0e1adh		;2bd2	21 ad e1 	! . . 
	add hl,de			;2bd5	19 	. 
	ld a,(0e013h)		;2bd6	3a 13 e0 	: . . 
	cp (hl)			;2bd9	be 	. 
	jp nc,l2af8h		;2bda	d2 f8 2a 	. . * 
l2bddh:
	pop hl			;2bdd	e1 	. 
	ld a,b			;2bde	78 	x 
	cp 002h		;2bdf	fe 02 	. . 
	jr z,l2c1bh		;2be1	28 38 	( 8 
	jr c,l2c17h		;2be3	38 32 	8 2 
	ld (ix+007h),005h		;2be5	dd 36 07 05 	. 6 . . 
	ld (ix+001h),00ah		;2be9	dd 36 01 0a 	. 6 . . 
	ld (ix+006h),017h		;2bed	dd 36 06 17 	. 6 . . 
	ld a,(0e080h)		;2bf1	3a 80 e0 	: . . 
	rrca			;2bf4	0f 	. 
	rrca			;2bf5	0f 	. 
	rrca			;2bf6	0f 	. 
	and 003h		;2bf7	e6 03 	. . 
	ld e,a			;2bf9	5f 	_ 
	ld d,000h		;2bfa	16 00 	. . 
	ld hl,l2c32h		;2bfc	21 32 2c 	! 2 , 
	add hl,de			;2bff	19 	. 
	ld a,(0e2d6h)		;2c00	3a d6 e2 	: . . 
	cp (hl)			;2c03	be 	. 
	ld hl,l2b7ah		;2c04	21 7a 2b 	! z + 
	jr c,l2c13h		;2c07	38 0a 	8 . 
	ld hl,l2b8dh		;2c09	21 8d 2b 	! . + 
	xor a			;2c0c	af 	. 
	ld (0e2d7h),a		;2c0d	32 d7 e2 	2 . . 
	ld (0e2d6h),a		;2c10	32 d6 e2 	2 . . 
l2c13h:
	ld (0e2e4h),hl		;2c13	22 e4 e2 	" . . 
	ret			;2c16	c9 	. 
l2c17h:
	ld a,015h		;2c17	3e 15 	> . 
	jr l2c1dh		;2c19	18 02 	. . 
l2c1bh:
	ld a,016h		;2c1b	3e 16 	> . 
l2c1dh:
	ld (ix+006h),a		;2c1d	dd 77 06 	. w . 
	ld (ix+001h),009h		;2c20	dd 36 01 09 	. 6 . . 
	ld (ix+007h),00bh		;2c24	dd 36 07 0b 	. 6 . . 
	ld a,091h		;2c28	3e 91 	> . 
	call sub_0dfeh		;2c2a	cd fe 0d 	. . . 
l2c2dh:
	xor a			;2c2d	af 	. 
	ld (0e2d6h),a		;2c2e	32 d6 e2 	2 . . 
	ret			;2c31	c9 	. 
l2c32h:
	inc b			;2c32	04 	. 
	inc bc			;2c33	03 	. 
	ld (bc),a			;2c34	02 	. 
	ld (bc),a			;2c35	02 	. 
l2c36h:
	nop			;2c36	00 	. 
	inc bc			;2c37	03 	. 
	nop			;2c38	00 	. 
	nop			;2c39	00 	. 
	nop			;2c3a	00 	. 
	ld bc,0ff02h		;2c3b	01 02 ff 	. . . 
	rst 38h			;2c3e	ff 	. 
	rst 38h			;2c3f	ff 	. 
l2c40h:
	rst 38h			;2c40	ff 	. 
	rst 38h			;2c41	ff 	. 
	rst 38h			;2c42	ff 	. 
	rst 38h			;2c43	ff 	. 
	cp 0feh		;2c44	fe fe 	. . 
	cp 000h		;2c46	fe 00 	. . 
	nop			;2c48	00 	. 
	nop			;2c49	00 	. 
	cp 0feh		;2c4a	fe fe 	. . 
	inc b			;2c4c	04 	. 
	inc b			;2c4d	04 	. 
	inc b			;2c4e	04 	. 
	cp 009h		;2c4f	fe 09 	. . 
	ex af,af'			;2c51	08 	. 
	ex af,af'			;2c52	08 	. 
	ex af,af'			;2c53	08 	. 
	add hl,bc			;2c54	09 	. 
	rst 38h			;2c55	ff 	. 
	rst 38h			;2c56	ff 	. 
	rst 38h			;2c57	ff 	. 
	rst 38h			;2c58	ff 	. 
	rst 38h			;2c59	ff 	. 
	call sub_2cb9h		;2c5a	cd b9 2c 	. . , 
	call sub_2c7eh		;2c5d	cd 7e 2c 	. ~ , 
	ld de,0fe00h		;2c60	11 00 fe 	. . . 
	ld hl,071fah		;2c63	21 fa 71 	! . q 
	jp l20adh		;2c66	c3 ad 20 	. .   
l2c69h:
	dec bc			;2c69	0b 	. 
	inc e			;2c6a	1c 	. 
	ex af,af'			;2c6b	08 	. 
	dec e			;2c6c	1d 	. 
	inc de			;2c6d	13 	. 
	rst 38h			;2c6e	ff 	. 
	ld a,(ix-002h)		;2c6f	dd 7e fe 	. ~ . 
	and a			;2c72	a7 	. 
	ret z			;2c73	c8 	. 
	dec (ix-002h)		;2c74	dd 35 fe 	. 5 . 
	ret			;2c77	c9 	. 
sub_2c78h:
	ld a,(0e080h)		;2c78	3a 80 e0 	: . . 
	and 0fch		;2c7b	e6 fc 	. . 
	ret nz			;2c7d	c0 	. 
sub_2c7eh:
	ld hl,(0e80ch)		;2c7e	2a 0c e8 	* . . 
	ld de,0e800h		;2c81	11 00 e8 	. . . 
	add hl,de			;2c84	19 	. 
	ld hl,0e198h		;2c85	21 98 e1 	! . . 
	ld de,0e197h		;2c88	11 97 e1 	. . . 
	jr c,l2c8eh		;2c8b	38 01 	8 . 
	ex de,hl			;2c8d	eb 	. 
l2c8eh:
	ld a,(hl)			;2c8e	7e 	~ 
	and a			;2c8f	a7 	. 
	ret z			;2c90	c8 	. 
	ld (de),a			;2c91	12 	. 
	ld (hl),000h		;2c92	36 00 	6 . 
	ret			;2c94	c9 	. 
l2c95h:
	ld a,091h		;2c95	3e 91 	> . 
	call sub_0dfeh		;2c97	cd fe 0d 	. . . 
sub_2c9ah:
	ld a,(0e709h)		;2c9a	3a 09 e7 	: . . 
	sub e			;2c9d	93 	. 
	jp p,l2cb6h		;2c9e	f2 b6 2c 	. . , 
	call sub_1208h		;2ca1	cd 08 12 	. . . 
	jr nz,l2cb6h		;2ca4	20 10 	  . 
	ld a,(0e080h)		;2ca6	3a 80 e0 	: . . 
	and 007h		;2ca9	e6 07 	. . 
	cp 002h		;2cab	fe 02 	. . 
	ld a,004h		;2cad	3e 04 	> . 
	jr nz,l2cb3h		;2caf	20 02 	  . 
	ld a,005h		;2cb1	3e 05 	> . 
l2cb3h:
	ld (0e007h),a		;2cb3	32 07 e0 	2 . . 
l2cb6h:
	jp sub_2ee2h		;2cb6	c3 e2 2e 	. . . 
sub_2cb9h:
	ld hl,(0e80ch)		;2cb9	2a 0c e8 	* . . 
	ld de,0f760h		;2cbc	11 60 f7 	. ` . 
	add hl,de			;2cbf	19 	. 
	ld hl,0e700h		;2cc0	21 00 e7 	! . . 
	res 4,(hl)		;2cc3	cb a6 	. . 
	ret c			;2cc5	d8 	. 
	ld a,(ix+001h)		;2cc6	dd 7e 01 	. ~ . 
	cp 001h		;2cc9	fe 01 	. . 
	ret z			;2ccb	c8 	. 
	ld a,(0e261h)		;2ccc	3a 61 e2 	: a . 
	and a			;2ccf	a7 	. 
	ret nz			;2cd0	c0 	. 
	set 4,(hl)		;2cd1	cb e6 	. . 
	ret			;2cd3	c9 	. 
sub_2cd4h:
	ld hl,(0e2f8h)		;2cd4	2a f8 e2 	* . . 
	ld a,l			;2cd7	7d 	} 
	or h			;2cd8	b4 	. 
	ret nz			;2cd9	c0 	. 
	ld a,(0e702h)		;2cda	3a 02 e7 	: . . 
	cp 009h		;2cdd	fe 09 	. . 
	jr z,l2ce6h		;2cdf	28 05 	( . 
	cp 00ah		;2ce1	fe 0a 	. . 
	jr z,l2ce6h		;2ce3	28 01 	( . 
	ld a,h			;2ce5	7c 	| 
l2ce6h:
	and a			;2ce6	a7 	. 
	ret			;2ce7	c9 	. 
sub_2ce8h:
	ld a,(0e010h)		;2ce8	3a 10 e0 	: . . 
	ld hl,0e19ch		;2ceb	21 9c e1 	! . . 
	ld b,001h		;2cee	06 01 	. . 
	cp (hl)			;2cf0	be 	. 
	jr c,l2cf9h		;2cf1	38 06 	8 . 
	inc hl			;2cf3	23 	# 
	inc b			;2cf4	04 	. 
	cp (hl)			;2cf5	be 	. 
	jr c,l2cf9h		;2cf6	38 01 	8 . 
	inc b			;2cf8	04 	. 
l2cf9h:
	ld (ix+00bh),b		;2cf9	dd 70 0b 	. p . 
	ld (ix+001h),004h		;2cfc	dd 36 01 04 	. 6 . . 
	ret			;2d00	c9 	. 
sub_2d01h:
	push hl			;2d01	e5 	. 
	ld hl,(0e80ch)		;2d02	2a 0c e8 	* . . 
	ld de,0ee00h		;2d05	11 00 ee 	. . . 
	add hl,de			;2d08	19 	. 
	pop hl			;2d09	e1 	. 
	ret nc			;2d0a	d0 	. 
	pop af			;2d0b	f1 	. 
	ret			;2d0c	c9 	. 
sub_2d0dh:
	ld de,l001bh		;2d0d	11 1b 00 	. . . 
	jp l1beah		;2d10	c3 ea 1b 	. . . 
sub_2d13h:
	ld de,l001bh		;2d13	11 1b 00 	. . . 
	jp l1bf2h		;2d16	c3 f2 1b 	. . . 
sub_2d19h:
	ld a,083h		;2d19	3e 83 	> . 
	call sub_0dfeh		;2d1b	cd fe 0d 	. . . 
	ld a,091h		;2d1e	3e 91 	> . 
	call sub_0dfeh		;2d20	cd fe 0d 	. . . 
	push de			;2d23	d5 	. 
	ld a,(0e706h)		;2d24	3a 06 e7 	: . . 
	push hl			;2d27	e5 	. 
	ld hl,l2d42h		;2d28	21 42 2d 	! B - 
	ld e,a			;2d2b	5f 	_ 
	ld d,000h		;2d2c	16 00 	. . 
	add hl,de			;2d2e	19 	. 
	ld e,(hl)			;2d2f	5e 	^ 
	pop hl			;2d30	e1 	. 
	add hl,de			;2d31	19 	. 
	ld a,(0e2e2h)		;2d32	3a e2 e2 	: . . 
	sub (hl)			;2d35	96 	. 
	ld (0e2e2h),a		;2d36	32 e2 e2 	2 . . 
	pop de			;2d39	d1 	. 
	ret nc			;2d3a	d0 	. 
	ld a,087h		;2d3b	3e 87 	> . 
	call sub_0dfeh		;2d3d	cd fe 0d 	. . . 
	scf			;2d40	37 	7 
	ret			;2d41	c9 	. 
l2d42h:
	nop			;2d42	00 	. 
	nop			;2d43	00 	. 
	nop			;2d44	00 	. 
	nop			;2d45	00 	. 
	nop			;2d46	00 	. 
	nop			;2d47	00 	. 
	nop			;2d48	00 	. 
	ld (bc),a			;2d49	02 	. 
	nop			;2d4a	00 	. 
	ld bc,0001h		;2d4b	01 01 00 	. . . 
	ld (bc),a			;2d4e	02 	. 
	nop			;2d4f	00 	. 
	ld bc,0001h		;2d50	01 01 00 	. . . 
	nop			;2d53	00 	. 
	nop			;2d54	00 	. 
	nop			;2d55	00 	. 
	nop			;2d56	00 	. 
	ld bc,0001h		;2d57	01 01 00 	. . . 
	inc bc			;2d5a	03 	. 
	inc bc			;2d5b	03 	. 
	nop			;2d5c	00 	. 
	nop			;2d5d	00 	. 
	nop			;2d5e	00 	. 
	nop			;2d5f	00 	. 
	nop			;2d60	00 	. 
	nop			;2d61	00 	. 
	nop			;2d62	00 	. 
	nop			;2d63	00 	. 
	nop			;2d64	00 	. 
	nop			;2d65	00 	. 
	nop			;2d66	00 	. 
l2d67h:
	nop			;2d67	00 	. 
	djnz l2d76h		;2d68	10 0c 	. . 
l2d6ah:
	jr nz,l2d78h		;2d6a	20 0c 	  . 
	ex af,af'			;2d6c	08 	. 
l2d6dh:
	jr l2d7fh		;2d6d	18 10 	. . 
	djnz l2d91h		;2d6f	10 20 	.   
	djnz $+35		;2d71	10 21 	. ! 
	dec hl			;2d73	2b 	+ 
	ex (sp),hl			;2d74	e3 	. 
	ld a,(hl)			;2d75	7e 	~ 
l2d76h:
	and a			;2d76	a7 	. 
	ret z			;2d77	c8 	. 
l2d78h:
	ld b,a			;2d78	47 	G 
	inc hl			;2d79	23 	# 
l2d7ah:
	push bc			;2d7a	c5 	. 
	ld c,(hl)			;2d7b	4e 	N 
	ld de,000b4h		;2d7c	11 b4 00 	. . . 
l2d7fh:
	bit 1,c		;2d7f	cb 49 	. I 
	jr z,l2d86h		;2d81	28 03 	( . 
	ld de,l00d2h		;2d83	11 d2 00 	. . . 
l2d86h:
	bit 4,c		;2d86	cb 61 	. a 
	jr z,l2d91h		;2d88	28 07 	( . 
	push hl			;2d8a	e5 	. 
	ld hl,l0016h+2		;2d8b	21 18 00 	! . . 
	add hl,de			;2d8e	19 	. 
	ex de,hl			;2d8f	eb 	. 
	pop hl			;2d90	e1 	. 
l2d91h:
	ld (0e807h),de		;2d91	ed 53 07 e8 	. S . . 
	inc hl			;2d95	23 	# 
	ld e,(hl)			;2d96	5e 	^ 
	push hl			;2d97	e5 	. 
	inc hl			;2d98	23 	# 
	ld d,(hl)			;2d99	56 	V 
	ld a,(0e700h)		;2d9a	3a 00 e7 	: . . 
	ld hl,(0e1f7h)		;2d9d	2a f7 e1 	* . . 
	bit 6,c		;2da0	cb 71 	. q 
	jr z,l2dbeh		;2da2	28 1a 	( . 
	ex de,hl			;2da4	eb 	. 
	bit 1,a		;2da5	cb 4f 	. O 
	jr nz,l2daah		;2da7	20 01 	  . 
	add hl,de			;2da9	19 	. 
l2daah:
	push hl			;2daa	e5 	. 
	ld de,(0e712h)		;2dab	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;2daf	ed 52 	. R 
	ld (0e80ah),hl		;2db1	22 0a e8 	" . . 
	jr c,l2ddch		;2db4	38 26 	8 & 
	ld de,0f000h		;2db6	11 00 f0 	. . . 
	add hl,de			;2db9	19 	. 
	jr c,l2e1ah		;2dba	38 5e 	8 ^ 
	jr l2dd9h		;2dbc	18 1b 	. . 
l2dbeh:
	ex de,hl			;2dbe	eb 	. 
	bit 1,a		;2dbf	cb 4f 	. O 
	jr nz,l2dc5h		;2dc1	20 02 	  . 
	sbc hl,de		;2dc3	ed 52 	. R 
l2dc5h:
	push hl			;2dc5	e5 	. 
	jr c,l2e1ah		;2dc6	38 52 	8 R 
	ld de,(0e712h)		;2dc8	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;2dcc	ed 52 	. R 
	ld (0e80ah),hl		;2dce	22 0a e8 	" . . 
	jr nc,l2ddch		;2dd1	30 09 	0 . 
	ld de,l1000h		;2dd3	11 00 10 	. . . 
	add hl,de			;2dd6	19 	. 
	jr nc,l2e1ah		;2dd7	30 41 	0 A 
l2dd9h:
	ld hl,(0e80ah)		;2dd9	2a 0a e8 	* . . 
l2ddch:
	bit 1,a		;2ddc	cb 4f 	. O 
	jr nz,l2df0h		;2dde	20 10 	  . 
	bit 4,c		;2de0	cb 61 	. a 
	jr nz,l2df0h		;2de2	20 0c 	  . 
	ld de,l0060h		;2de4	11 60 00 	. ` . 
	add hl,de			;2de7	19 	. 
	ld de,l00c0h		;2de8	11 c0 00 	. . . 
	sbc hl,de		;2deb	ed 52 	. R 
	call c,sub_2e31h		;2ded	dc 31 2e 	. 1 . 
l2df0h:
	ld hl,(0e80ah)		;2df0	2a 0a e8 	* . . 
	ld d,0ffh		;2df3	16 ff 	. . 
	add hl,hl			;2df5	29 	) 
	jr c,l2dfah		;2df6	38 02 	8 . 
	ld d,000h		;2df8	16 00 	. . 
l2dfah:
	add hl,hl			;2dfa	29 	) 
	add hl,hl			;2dfb	29 	) 
	ld e,h			;2dfc	5c 	\ 
	ld hl,(0e715h)		;2dfd	2a 15 e7 	* . . 
	add hl,de			;2e00	19 	. 
	ex de,hl			;2e01	eb 	. 
	ld hl,075a0h		;2e02	21 a0 75 	! . u 
	ld a,c			;2e05	79 	y 
	xor 040h		;2e06	ee 40 	. @ 
	and 040h		;2e08	e6 40 	. @ 
	call l0e20h		;2e0a	cd 20 0e 	.   . 
	pop de			;2e0d	d1 	. 
	pop hl			;2e0e	e1 	. 
	ld (hl),e			;2e0f	73 	s 
	inc hl			;2e10	23 	# 
	ld (hl),d			;2e11	72 	r 
l2e12h:
	inc hl			;2e12	23 	# 
	pop bc			;2e13	c1 	. 
	dec b			;2e14	05 	. 
	jp nz,l2d7ah		;2e15	c2 7a 2d 	. z - 
	ret			;2e18	c9 	. 
l2e19h:
	pop hl			;2e19	e1 	. 
l2e1ah:
	ld hl,0e32bh		;2e1a	21 2b e3 	! + . 
	ld a,(hl)			;2e1d	7e 	~ 
	dec (hl)			;2e1e	35 	5 
	add a,a			;2e1f	87 	. 
	add a,(hl)			;2e20	86 	. 
	inc hl			;2e21	23 	# 
	ld d,000h		;2e22	16 00 	. . 
	ld e,a			;2e24	5f 	_ 
	add hl,de			;2e25	19 	. 
	pop de			;2e26	d1 	. 
	pop de			;2e27	d1 	. 
	inc de			;2e28	13 	. 
	ld bc,3			;2e29	01 03 00 	. . . 
	lddr		;2e2c	ed b8 	. . 
	ex de,hl			;2e2e	eb 	. 
	jr l2e12h		;2e2f	18 e1 	. . 
sub_2e31h:
	bit 1,c		;2e31	cb 49 	. I 
	jr nz,l2e42h		;2e33	20 0d 	  . 
	ld hl,(0e710h)		;2e35	2a 10 e7 	* . . 
	ld de,0a600h		;2e38	11 00 a6 	. . . 
	add hl,de			;2e3b	19 	. 
	ret c			;2e3c	d8 	. 
	ld hl,05a00h		;2e3d	21 00 5a 	! . Z 
	jr l2e54h		;2e40	18 12 	. . 
l2e42h:
	ld a,(0e702h)		;2e42	3a 02 e7 	: . . 
	cp 006h		;2e45	fe 06 	. . 
	ret z			;2e47	c8 	. 
	cp 007h		;2e48	fe 07 	. . 
	ret z			;2e4a	c8 	. 
	ld a,(0e706h)		;2e4b	3a 06 e7 	: . . 
	cp 005h		;2e4e	fe 05 	. . 
	ret z			;2e50	c8 	. 
	ld hl,06900h		;2e51	21 00 69 	! . i 
l2e54h:
	ld de,00118h		;2e54	11 18 01 	. . . 
	call sub_2ee2h		;2e57	cd e2 2e 	. . . 
	jr l2e19h		;2e5a	18 bd 	. . 
sub_2e5ch:
	ld (0e338h),hl		;2e5c	22 38 e3 	" 8 . 
	ex de,hl			;2e5f	eb 	. 
	add hl,hl			;2e60	29 	) 
	ld l,h			;2e61	6c 	l 
	ld h,000h		;2e62	26 00 	& . 
	jr nc,l2e67h		;2e64	30 01 	0 . 
	inc h			;2e66	24 	$ 
l2e67h:
	ld (0e336h),hl		;2e67	22 36 e3 	" 6 . 
	ld a,007h		;2e6a	3e 07 	> . 
	ld (0e335h),a		;2e6c	32 35 e3 	2 5 . 
	ret			;2e6f	c9 	. 
l2e70h:
	ld hl,0e335h		;2e70	21 35 e3 	! 5 . 
	ld a,(hl)			;2e73	7e 	~ 
	and a			;2e74	a7 	. 
	ret z			;2e75	c8 	. 
	dec (hl)			;2e76	35 	5 
	ret z			;2e77	c8 	. 
	ld hl,(0e336h)		;2e78	2a 36 e3 	* 6 . 
	push bc			;2e7b	c5 	. 
	ld (0e807h),hl		;2e7c	22 07 e8 	" . . 
	ld hl,(0e338h)		;2e7f	2a 38 e3 	* 8 . 
	ld de,(0e803h)		;2e82	ed 5b 03 e8 	. [ . . 
	add hl,de			;2e86	19 	. 
	ex de,hl			;2e87	eb 	. 
	xor a			;2e88	af 	. 
	ld hl,07484h		;2e89	21 84 74 	! . t 
	call l0e20h		;2e8c	cd 20 0e 	.   . 
	pop bc			;2e8f	c1 	. 
	ret			;2e90	c9 	. 
	ld a,(0e720h)		;2e91	3a 20 e7 	:   . 
	cp 003h		;2e94	fe 03 	. . 
	ld a,001h		;2e96	3e 01 	> . 
	jr z,l2e9bh		;2e98	28 01 	( . 
	xor a			;2e9a	af 	. 
l2e9bh:
	ld (0e33fh),a		;2e9b	32 3f e3 	2 ? . 
	ld a,(0e701h)		;2e9e	3a 01 e7 	: . . 
	bit 6,a		;2ea1	cb 77 	. w 
	ld hl,0fffeh		;2ea3	21 fe ff 	! . . 
	jr z,l2eabh		;2ea6	28 03 	( . 
	ld hl,0001h+1		;2ea8	21 02 00 	! . . 
l2eabh:
	ld (0e33dh),hl		;2eab	22 3d e3 	" = . 
	ld hl,(0e722h)		;2eae	2a 22 e7 	* " . 
	add hl,hl			;2eb1	29 	) 
	ld l,h			;2eb2	6c 	l 
	ld h,000h		;2eb3	26 00 	& . 
	jr nc,l2eb8h		;2eb5	30 01 	0 . 
	inc h			;2eb7	24 	$ 
l2eb8h:
	ld (0e33bh),hl		;2eb8	22 3b e3 	" ; . 
	ld a,00eh		;2ebb	3e 0e 	> . 
	ld (0e33ah),a		;2ebd	32 3a e3 	2 : . 
	ret			;2ec0	c9 	. 
sub_2ec1h:
	ld hl,0e33ah		;2ec1	21 3a e3 	! : . 
	ld a,(hl)			;2ec4	7e 	~ 
	and a			;2ec5	a7 	. 
	ret z			;2ec6	c8 	. 
	dec (hl)			;2ec7	35 	5 
	ret z			;2ec8	c8 	. 
	ld hl,(0e33bh)		;2ec9	2a 3b e3 	* ; . 
	push bc			;2ecc	c5 	. 
	ld (0e807h),hl		;2ecd	22 07 e8 	" . . 
	ld hl,(0e33dh)		;2ed0	2a 3d e3 	* = . 
	ld de,(0e715h)		;2ed3	ed 5b 15 e7 	. [ . . 
	add hl,de			;2ed7	19 	. 
	ex de,hl			;2ed8	eb 	. 
	xor a			;2ed9	af 	. 
	ld hl,07489h		;2eda	21 89 74 	! . t 
	call l0e20h		;2edd	cd 20 0e 	.   . 
	pop bc			;2ee0	c1 	. 
	ret			;2ee1	c9 	. 
sub_2ee2h:
	ld a,(0e71fh)		;2ee2	3a 1f e7 	: . . 
	and 001h		;2ee5	e6 01 	. . 
	jr nz,l2efbh		;2ee7	20 12 	  . 
	ld (0e722h),hl		;2ee9	22 22 e7 	" " . 
	ld hl,0e71fh		;2eec	21 1f e7 	! . . 
	set 0,(hl)		;2eef	cb c6 	. . 
	inc hl			;2ef1	23 	# 
	ld (hl),d			;2ef2	72 	r 
	inc hl			;2ef3	23 	# 
	ld (hl),e			;2ef4	73 	s 
	ld a,083h		;2ef5	3e 83 	> . 
	call sub_0dfeh		;2ef7	cd fe 0d 	. . . 
	ret			;2efa	c9 	. 
l2efbh:
	ld a,(0e709h)		;2efb	3a 09 e7 	: . . 
	sub e			;2efe	93 	. 
	jr nc,l2f02h		;2eff	30 01 	0 . 
	xor a			;2f01	af 	. 
l2f02h:
	ld (0e709h),a		;2f02	32 09 e7 	2 . . 
	ret			;2f05	c9 	. 
sub_2f06h:
	ld hl,0e64ch		;2f06	21 4c e6 	! L . 
	ld b,004h		;2f09	06 04 	. . 
l2f0bh:
	ld a,(hl)			;2f0b	7e 	~ 
	and a			;2f0c	a7 	. 
	ret z			;2f0d	c8 	. 
	dec (hl)			;2f0e	35 	5 
	jr z,l2f46h		;2f0f	28 35 	( 5 
	push bc			;2f11	c5 	. 
	inc hl			;2f12	23 	# 
	ld e,(hl)			;2f13	5e 	^ 
	inc hl			;2f14	23 	# 
	ld d,(hl)			;2f15	56 	V 
	ld (0e807h),de		;2f16	ed 53 07 e8 	. S . . 
	inc hl			;2f1a	23 	# 
	ld e,(hl)			;2f1b	5e 	^ 
	inc hl			;2f1c	23 	# 
	ld d,(hl)			;2f1d	56 	V 
	inc hl			;2f1e	23 	# 
	ld c,(hl)			;2f1f	4e 	N 
	inc hl			;2f20	23 	# 
	push hl			;2f21	e5 	. 
	ld hl,(0e712h)		;2f22	2a 12 e7 	* . . 
	ld a,l			;2f25	7d 	} 
	and 0e0h		;2f26	e6 e0 	. . 
	ld l,a			;2f28	6f 	o 
	ex de,hl			;2f29	eb 	. 
	sbc hl,de		;2f2a	ed 52 	. R 
	push hl			;2f2c	e5 	. 
	ld de,01c00h		;2f2d	11 00 1c 	. . . 
	jr c,l2f36h		;2f30	38 04 	8 . 
	sbc hl,de		;2f32	ed 52 	. R 
	jr l2f37h		;2f34	18 01 	. . 
l2f36h:
	add hl,de			;2f36	19 	. 
l2f37h:
	pop hl			;2f37	e1 	. 
	jr nc,l2f41h		;2f38	30 07 	0 . 
	ld de,075f7h		;2f3a	11 f7 75 	. . u 
	xor a			;2f3d	af 	. 
	call sub_1a9ah		;2f3e	cd 9a 1a 	. . . 
l2f41h:
	pop hl			;2f41	e1 	. 
	pop bc			;2f42	c1 	. 
	djnz l2f0bh		;2f43	10 c6 	. . 
	ret			;2f45	c9 	. 
l2f46h:
	dec b			;2f46	05 	. 
	jr z,l2f5dh		;2f47	28 14 	( . 
	push bc			;2f49	c5 	. 
	push hl			;2f4a	e5 	. 
	ex de,hl			;2f4b	eb 	. 
	ld hl,0006h		;2f4c	21 06 00 	! . . 
	add hl,de			;2f4f	19 	. 
	ld a,b			;2f50	78 	x 
	add a,a			;2f51	87 	. 
	add a,b			;2f52	80 	. 
	add a,a			;2f53	87 	. 
	ld c,a			;2f54	4f 	O 
	ld b,000h		;2f55	06 00 	. . 
	ldir		;2f57	ed b0 	. . 
	xor a			;2f59	af 	. 
	ld (de),a			;2f5a	12 	. 
	jr l2f41h		;2f5b	18 e4 	. . 
l2f5dh:
	ld (hl),000h		;2f5d	36 00 	6 . 
	ret			;2f5f	c9 	. 
sub_2f60h:
	push bc			;2f60	c5 	. 
	push de			;2f61	d5 	. 
	push hl			;2f62	e5 	. 
	ld de,0e663h		;2f63	11 63 e6 	. c . 
	ld hl,0e65dh		;2f66	21 5d e6 	! ] . 
	ld bc,0011h+1		;2f69	01 12 00 	. . . 
	lddr		;2f6c	ed b8 	. . 
	ld d,a			;2f6e	57 	W 
	and 07fh		;2f6f	e6 7f 	.  
	ld e,a			;2f71	5f 	_ 
	ld (0e651h),a		;2f72	32 51 e6 	2 Q . 
	pop hl			;2f75	e1 	. 
	ld (0e64fh),hl		;2f76	22 4f e6 	" O . 
	pop hl			;2f79	e1 	. 
	ld (0e64dh),hl		;2f7a	22 4d e6 	" M . 
	ld a,0a9h		;2f7d	3e a9 	> . 
	bit 7,d		;2f7f	cb 7a 	. z 
	jr z,l2f85h		;2f81	28 02 	( . 
	ld a,00bh		;2f83	3e 0b 	> . 
l2f85h:
	ld (0e64ch),a		;2f85	32 4c e6 	2 L . 
	ld d,000h		;2f88	16 00 	. . 
	ld hl,l2fadh		;2f8a	21 ad 2f 	! . / 
	add hl,de			;2f8d	19 	. 
	add hl,de			;2f8e	19 	. 
	ld e,(hl)			;2f8f	5e 	^ 
	inc hl			;2f90	23 	# 
	ld d,(hl)			;2f91	56 	V 
	call sub_2f9ah		;2f92	cd 9a 2f 	. . / 
	pop bc			;2f95	c1 	. 
l2f96h:
	ret			;2f96	c9 	. 
sub_2f97h:
	ld de,000fh+1		;2f97	11 10 00 	. . . 
sub_2f9ah:
	ld hl,0e081h		;2f9a	21 81 e0 	! . . 
	ld a,(hl)			;2f9d	7e 	~ 
	add a,e			;2f9e	83 	. 
	daa			;2f9f	27 	' 
	ld (hl),a			;2fa0	77 	w 
	inc hl			;2fa1	23 	# 
	ld a,(hl)			;2fa2	7e 	~ 
	adc a,d			;2fa3	8a 	. 
	daa			;2fa4	27 	' 
	ld (hl),a			;2fa5	77 	w 
	inc hl			;2fa6	23 	# 
	ld a,(hl)			;2fa7	7e 	~ 
	adc a,000h		;2fa8	ce 00 	. . 
	daa			;2faa	27 	' 
	ld (hl),a			;2fab	77 	w 
	ret			;2fac	c9 	. 
l2fadh:
	jr nz,l2fafh		;2fad	20 00 	  . 
l2fafh:
	jr nc,l2fb1h		;2faf	30 00 	0 . 
l2fb1h:
	ld b,b			;2fb1	40 	@ 
	nop			;2fb2	00 	. 
	ld d,b			;2fb3	50 	P 
	nop			;2fb4	00 	. 
	ld h,b			;2fb5	60 	` 
	nop			;2fb6	00 	. 
	add a,b			;2fb7	80 	. 
	nop			;2fb8	00 	. 
	sub b			;2fb9	90 	. 
	nop			;2fba	00 	. 
	nop			;2fbb	00 	. 
	ld bc,00200h		;2fbc	01 00 02 	. . . 
	nop			;2fbf	00 	. 
	inc bc			;2fc0	03 	. 
	nop			;2fc1	00 	. 
	dec b			;2fc2	05 	. 
	nop			;2fc3	00 	. 
	djnz l2fd6h		;2fc4	10 10 	. . 
	nop			;2fc6	00 	. 
sub_2fc7h:
	ld a,(0e381h)		;2fc7	3a 81 e3 	: . . 
	and a			;2fca	a7 	. 
	ret z			;2fcb	c8 	. 
	ld ix,0e382h		;2fcc	dd 21 82 e3 	. ! . . 
	ld b,010h		;2fd0	06 10 	. . 
l2fd2h:
	push bc			;2fd2	c5 	. 
	ld c,(ix+000h)		;2fd3	dd 4e 00 	. N . 
l2fd6h:
	bit 4,c		;2fd6	cb 61 	. a 
	call nz,sub_2fe4h		;2fd8	c4 e4 2f 	. . / 
	pop bc			;2fdb	c1 	. 
	ld de,l0013h		;2fdc	11 13 00 	. . . 
	add ix,de		;2fdf	dd 19 	. . 
	djnz l2fd2h		;2fe1	10 ef 	. . 
	ret			;2fe3	c9 	. 
sub_2fe4h:
	ld hl,l36e7h		;2fe4	21 e7 36 	! . 6 
	push hl			;2fe7	e5 	. 
	ld hl,l2ff7h		;2fe8	21 f7 2f 	! . / 
	ld e,(ix+001h)		;2feb	dd 5e 01 	. ^ . 
	ld d,000h		;2fee	16 00 	. . 
	add hl,de			;2ff0	19 	. 
	add hl,de			;2ff1	19 	. 
	ld a,(hl)			;2ff2	7e 	~ 
	inc hl			;2ff3	23 	# 
	ld h,(hl)			;2ff4	66 	f 
	ld l,a			;2ff5	6f 	o 
	jp (hl)			;2ff6	e9 	. 
l2ff7h:
	ld a,a			;2ff7	7f 	 
	inc sp			;2ff8	33 	3 
	call nc,sub_1931h		;2ff9	d4 31 19 	. 1 . 
	jr nc,l2f96h		;2ffc	30 98 	0 . 
	inc sp			;2ffe	33 	3 
	call nc,0c833h		;2fff	d4 33 c8 	. 3 . 
	ld (l3049h),a		;3002	32 49 30 	2 I 0 
	xor 031h		;3005	ee 31 	. 1 
	dec h			;3007	25 	% 
	ld (l328bh),a		;3008	32 8b 32 	2 . 2 
	ld d,h			;300b	54 	T 
	ld sp,l315dh		;300c	31 5d 31 	1 ] 1 
	ld h,(hl)			;300f	66 	f 
	ld sp,l3444h		;3010	31 44 34 	1 D 4 
	ld a,b			;3013	78 	x 
	inc (hl)			;3014	34 	4 
	add a,h			;3015	84 	. 
	inc (hl)			;3016	34 	4 
	scf			;3017	37 	7 
	dec (hl)			;3018	35 	5 
	call l1be2h		;3019	cd e2 1b 	. . . 
	ld hl,07000h		;301c	21 00 70 	! . p 
	call sub_371dh		;301f	cd 1d 37 	. . 7 
	jp c,l30cdh		;3022	da cd 30 	. . 0 
l3025h:
	call sub_3773h		;3025	cd 73 37 	. s 7 
	jp c,l331eh		;3028	da 1e 33 	. . 3 
	call sub_3746h		;302b	cd 46 37 	. F 7 
	ld a,091h		;302e	3e 91 	> . 
	jp c,l3327h		;3030	da 27 33 	. ' 3 
	dec (ix+007h)		;3033	dd 35 07 	. 5 . 
	ret nz			;3036	c0 	. 
	ld (ix+007h),003h		;3037	dd 36 07 03 	. 6 . . 
	ld a,(ix+006h)		;303b	dd 7e 06 	. ~ . 
	inc a			;303e	3c 	< 
	cp 004h		;303f	fe 04 	. . 
	jr nz,l3045h		;3041	20 02 	  . 
	ld a,002h		;3043	3e 02 	> . 
l3045h:
	ld (ix+006h),a		;3045	dd 77 06 	. w . 
	ret			;3048	c9 	. 
l3049h:
	call l1be2h		;3049	cd e2 1b 	. . . 
	dec (ix+008h)		;304c	dd 35 08 	. 5 . 
	jp z,l3106h		;304f	ca 06 31 	. . 1 
	ld l,(ix+00eh)		;3052	dd 6e 0e 	. n . 
	ld h,(ix+00fh)		;3055	dd 66 0f 	. f . 
	ld de,l0020h		;3058	11 20 00 	.   . 
	bit 2,(ix+000h)		;305b	dd cb 00 56 	. . . V 
	jr z,l306eh		;305f	28 0d 	( . 
	sbc hl,de		;3061	ed 52 	. R 
	jr nc,l307bh		;3063	30 16 	0 . 
	res 2,(ix+000h)		;3065	dd cb 00 96 	. . . . 
	ld hl,0		;3069	21 00 00 	! . . 
	jr l307bh		;306c	18 0d 	. . 
l306eh:
	add hl,de			;306e	19 	. 
	push hl			;306f	e5 	. 
	ld de,0ff80h		;3070	11 80 ff 	. . . 
	add hl,de			;3073	19 	. 
	pop hl			;3074	e1 	. 
	jr nc,l307bh		;3075	30 04 	0 . 
	set 2,(ix+000h)		;3077	dd cb 00 d6 	. . . . 
l307bh:
	ld (ix+00eh),l		;307b	dd 75 0e 	. u . 
	ld (ix+00fh),h		;307e	dd 74 0f 	. t . 
	ld e,(ix+00ah)		;3081	dd 5e 0a 	. ^ . 
	ld d,(ix+00bh)		;3084	dd 56 0b 	. V . 
	add hl,de			;3087	19 	. 
	ld (ix+002h),l		;3088	dd 75 02 	. u . 
	ld (ix+003h),h		;308b	dd 74 03 	. t . 
	ld l,(ix+010h)		;308e	dd 6e 10 	. n . 
	ld h,(ix+011h)		;3091	dd 66 11 	. f . 
	ld de,00049h		;3094	11 49 00 	. I . 
	bit 0,(ix+000h)		;3097	dd cb 00 46 	. . . F 
	jr z,l30aah		;309b	28 0d 	( . 
	sbc hl,de		;309d	ed 52 	. R 
	jr nc,l30b7h		;309f	30 16 	0 . 
	res 0,(ix+000h)		;30a1	dd cb 00 86 	. . . . 
	ld hl,0		;30a5	21 00 00 	! . . 
	jr l30b7h		;30a8	18 0d 	. . 
l30aah:
	add hl,de			;30aa	19 	. 
	push hl			;30ab	e5 	. 
	ld de,0fe00h		;30ac	11 00 fe 	. . . 
	add hl,de			;30af	19 	. 
	pop hl			;30b0	e1 	. 
	jr nc,l30b7h		;30b1	30 04 	0 . 
	set 0,(ix+000h)		;30b3	dd cb 00 c6 	. . . . 
l30b7h:
	ld (ix+010h),l		;30b7	dd 75 10 	. u . 
	ld (ix+011h),h		;30ba	dd 74 11 	. t . 
	ld e,(ix+00ch)		;30bd	dd 5e 0c 	. ^ . 
	ld d,(ix+00dh)		;30c0	dd 56 0d 	. V . 
	add hl,de			;30c3	19 	. 
	ld (ix+004h),l		;30c4	dd 75 04 	. u . 
	ld (ix+005h),h		;30c7	dd 74 05 	. t . 
	jp l3025h		;30ca	c3 25 30 	. % 0 
l30cdh:
	ld (ix+001h),006h		;30cd	dd 36 01 06 	. 6 . . 
	ld a,(0e371h)		;30d1	3a 71 e3 	: q . 
	ld (ix+008h),a		;30d4	dd 77 08 	. w . 
	ld de,l0040h		;30d7	11 40 00 	. @ . 
	ld l,(ix+002h)		;30da	dd 6e 02 	. n . 
	ld h,(ix+003h)		;30dd	dd 66 03 	. f . 
	sbc hl,de		;30e0	ed 52 	. R 
	ld (ix+00ah),l		;30e2	dd 75 0a 	. u . 
	ld (ix+00bh),h		;30e5	dd 74 0b 	. t . 
	ld (ix+00eh),e		;30e8	dd 73 0e 	. s . 
	ld (ix+00fh),d		;30eb	dd 72 0f 	. r . 
	ld de,l0100h		;30ee	11 00 01 	. . . 
	ld l,(ix+004h)		;30f1	dd 6e 04 	. n . 
	ld h,(ix+005h)		;30f4	dd 66 05 	. f . 
	sbc hl,de		;30f7	ed 52 	. R 
	ld (ix+00ch),l		;30f9	dd 75 0c 	. u . 
	ld (ix+00dh),h		;30fc	dd 74 0d 	. t . 
	ld (ix+010h),e		;30ff	dd 73 10 	. s . 
	ld (ix+011h),d		;3102	dd 72 11 	. r . 
	ret			;3105	c9 	. 
l3106h:
	call sub_333ah		;3106	cd 3a 33 	. : 3 
	ld a,086h		;3109	3e 86 	> . 
	call sub_0dfeh		;310b	cd fe 0d 	. . . 
	ld iy,0e382h		;310e	fd 21 82 e3 	. ! . . 
	ld b,010h		;3112	06 10 	. . 
	ld c,00ah		;3114	0e 0a 	. . 
	ld l,(ix+002h)		;3116	dd 6e 02 	. n . 
	ld h,(ix+003h)		;3119	dd 66 03 	. f . 
l311ch:
	bit 4,(iy+000h)		;311c	fd cb 00 66 	. . . f 
	jr nz,l314ch		;3120	20 2a 	  * 
	set 4,(iy+000h)		;3122	fd cb 00 e6 	. . . . 
	ld (iy+007h),007h		;3126	fd 36 07 07 	. 6 . . 
	ld (iy+006h),014h		;312a	fd 36 06 14 	. 6 . . 
	ld (iy+002h),l		;312e	fd 75 02 	. u . 
	ld (iy+003h),h		;3131	fd 74 03 	. t . 
	ld de,07400h		;3134	11 00 74 	. . t 
	ld (iy+004h),e		;3137	fd 73 04 	. s . 
	ld (iy+005h),d		;313a	fd 72 05 	. r . 
	ld (iy+001h),c		;313d	fd 71 01 	. q . 
	ld a,(0e381h)		;3140	3a 81 e3 	: . . 
	inc a			;3143	3c 	< 
	ld (0e381h),a		;3144	32 81 e3 	2 . . 
	ld a,c			;3147	79 	y 
	inc c			;3148	0c 	. 
	cp 00ch		;3149	fe 0c 	. . 
	ret z			;314b	c8 	. 
l314ch:
	ld de,l0013h		;314c	11 13 00 	. . . 
	add iy,de		;314f	fd 19 	. . 
	djnz l311ch		;3151	10 c9 	. . 
	ret			;3153	c9 	. 
	ld de,(0e376h)		;3154	ed 5b 76 e3 	. [ v . 
	call sub_1c70h		;3158	cd 70 1c 	. p . 
	jr l316dh		;315b	18 10 	. . 
l315dh:
	call l1be2h		;315d	cd e2 1b 	. . . 
	ld de,(0e372h)		;3160	ed 5b 72 e3 	. [ r . 
	jr l3174h		;3164	18 0e 	. . 
	ld de,(0e376h)		;3166	ed 5b 76 e3 	. [ v . 
	call sub_1c7ah		;316a	cd 7a 1c 	. z . 
l316dh:
	call l1be2h		;316d	cd e2 1b 	. . . 
	ld de,(0e374h)		;3170	ed 5b 74 e3 	. [ t . 
l3174h:
	ld hl,05000h		;3174	21 00 50 	! . P 
	call sub_3732h		;3177	cd 32 37 	. 2 7 
	jp c,l3713h		;317a	da 13 37 	. . 7 
	ld hl,(0e80ch)		;317d	2a 0c e8 	* . . 
	ld de,l0300h		;3180	11 00 03 	. . . 
	sbc hl,de		;3183	ed 52 	. R 
	jr nc,l31aah		;3185	30 23 	0 # 
	ld e,(ix+002h)		;3187	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;318a	dd 56 03 	. V . 
	ld hl,0ffe0h		;318d	21 e0 ff 	! . . 
	add hl,de			;3190	19 	. 
	ld (0e80fh),hl		;3191	22 0f e8 	" . . 
	ld hl,l0020h		;3194	21 20 00 	!   . 
	add hl,de			;3197	19 	. 
	ld (0e811h),hl		;3198	22 11 e8 	" . . 
	ld l,(ix+004h)		;319b	dd 6e 04 	. n . 
	ld h,(ix+005h)		;319e	dd 66 05 	. f . 
	ld de,0001h		;31a1	11 01 00 	. . . 
	call sub_1172h		;31a4	cd 72 11 	. r . 
	jp c,l31c0h		;31a7	da c0 31 	. . 1 
l31aah:
	dec (ix+007h)		;31aa	dd 35 07 	. 5 . 
	ret nz			;31ad	c0 	. 
	ld (ix+007h),003h		;31ae	dd 36 07 03 	. 6 . . 
	ld a,(ix+006h)		;31b2	dd 7e 06 	. ~ . 
	inc a			;31b5	3c 	< 
	cp 016h		;31b6	fe 16 	. . 
	jr nz,l31bch		;31b8	20 02 	  . 
	ld a,014h		;31ba	3e 14 	> . 
l31bch:
	ld (ix+006h),a		;31bc	dd 77 06 	. w . 
	ret			;31bf	c9 	. 
l31c0h:
	ld l,(ix+004h)		;31c0	dd 6e 04 	. n . 
	ld h,(ix+005h)		;31c3	dd 66 05 	. f . 
	ld de,l0120h		;31c6	11 20 01 	.   . 
	ld a,091h		;31c9	3e 91 	> . 
	call sub_0dfeh		;31cb	cd fe 0d 	. . . 
	call sub_2ee2h		;31ce	cd e2 2e 	. . . 
	jp l3713h		;31d1	c3 13 37 	. . 7 
	call l1be2h		;31d4	cd e2 1b 	. . . 
	call sub_3773h		;31d7	cd 73 37 	. s 7 
	jp c,l32edh		;31da	da ed 32 	. . 2 
	call sub_3746h		;31dd	cd 46 37 	. F 7 
	ld a,091h		;31e0	3e 91 	> . 
	jp c,l3327h		;31e2	da 27 33 	. ' 3 
	ld hl,05000h		;31e5	21 00 50 	! . P 
	call sub_371dh		;31e8	cd 1d 37 	. . 7 
	jr c,l3213h		;31eb	38 26 	8 & 
	ret			;31ed	c9 	. 
	call l1be2h		;31ee	cd e2 1b 	. . . 
	dec (ix+007h)		;31f1	dd 35 07 	. 5 . 
	ret nz			;31f4	c0 	. 
	inc (ix+006h)		;31f5	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;31f8	dd 7e 06 	. ~ . 
	cp 010h		;31fb	fe 10 	. . 
	jr nz,l3220h		;31fd	20 21 	  ! 
	inc (ix+001h)		;31ff	dd 34 01 	. 4 . 
	ld a,(0e80bh)		;3202	3a 0b e8 	: . . 
	bit 7,a		;3205	cb 7f 	.  
	set 6,(ix+000h)		;3207	dd cb 00 f6 	. . . . 
	jr nz,l3220h		;320b	20 13 	  . 
	res 6,(ix+000h)		;320d	dd cb 00 b6 	. . . . 
	jr l3220h		;3211	18 0d 	. . 
l3213h:
	ld a,086h		;3213	3e 86 	> . 
	call sub_0dfeh		;3215	cd fe 0d 	. . . 
l3218h:
	ld (ix+001h),007h		;3218	dd 36 01 07 	. 6 . . 
	ld (ix+006h),00dh		;321c	dd 36 06 0d 	. 6 . . 
l3220h:
	ld (ix+007h),007h		;3220	dd 36 07 07 	. 6 . . 
	ret			;3224	c9 	. 
	call l1be2h		;3225	cd e2 1b 	. . . 
	ld hl,l0140h		;3228	21 40 01 	! @ . 
	call sub_1220h		;322b	cd 20 12 	.   . 
	ld a,(0e702h)		;322e	3a 02 e7 	: . . 
	jr nc,l323dh		;3231	30 0a 	0 . 
	cp 004h		;3233	fe 04 	. . 
	jp z,l32a8h		;3235	ca a8 32 	. . 2 
	cp 005h		;3238	fe 05 	. . 
	jp z,l32a8h		;323a	ca a8 32 	. . 2 
l323dh:
	cp 006h		;323d	fe 06 	. . 
	jr z,l3275h		;323f	28 34 	( 4 
	cp 007h		;3241	fe 07 	. . 
	jr z,l3275h		;3243	28 30 	( 0 
	ld a,(0e706h)		;3245	3a 06 e7 	: . . 
	cp 005h		;3248	fe 05 	. . 
	jr z,l3275h		;324a	28 29 	( ) 
	bit 5,c		;324c	cb 69 	. i 
	jr nz,l3275h		;324e	20 25 	  % 
	ld a,(ix+006h)		;3250	dd 7e 06 	. ~ . 
	cp 012h		;3253	fe 12 	. . 
	jr nz,l3275h		;3255	20 1e 	  . 
	ld hl,(0e80ah)		;3257	2a 0a e8 	* . . 
	ld de,l067eh+2		;325a	11 80 06 	. . . 
	bit 6,c		;325d	cb 71 	. q 
	jr nz,l3265h		;325f	20 04 	  . 
	sbc hl,de		;3261	ed 52 	. R 
	jr l3266h		;3263	18 01 	. . 
l3265h:
	add hl,de			;3265	19 	. 
l3266h:
	jr nc,l3275h		;3266	30 0d 	0 . 
	ld hl,06b00h		;3268	21 00 6b 	! . k 
	ld de,l0120h		;326b	11 20 01 	.   . 
	call sub_36cah		;326e	cd ca 36 	. . 6 
	set 5,(ix+000h)		;3271	dd cb 00 ee 	. . . . 
l3275h:
	dec (ix+007h)		;3275	dd 35 07 	. 5 . 
	ret nz			;3278	c0 	. 
	ld a,(ix+006h)		;3279	dd 7e 06 	. ~ . 
	cp 013h		;327c	fe 13 	. . 
	jp z,l32a2h		;327e	ca a2 32 	. . 2 
	inc (ix+006h)		;3281	dd 34 06 	. 4 . 
	ld a,(0e370h)		;3284	3a 70 e3 	: p . 
	ld (ix+007h),a		;3287	dd 77 07 	. w . 
	ret			;328a	c9 	. 
l328bh:
	call l1be2h		;328b	cd e2 1b 	. . . 
	dec (ix+007h)		;328e	dd 35 07 	. 5 . 
	ret nz			;3291	c0 	. 
	ld a,(ix+006h)		;3292	dd 7e 06 	. ~ . 
	cp 018h		;3295	fe 18 	. . 
	jp z,l3713h		;3297	ca 13 37 	. . 7 
	inc (ix+006h)		;329a	dd 34 06 	. 4 . 
	ld (ix+007h),007h		;329d	dd 36 07 07 	. 6 . . 
	ret			;32a1	c9 	. 
l32a2h:
	ld (ix+006h),017h		;32a2	dd 36 06 17 	. 6 . . 
	jr l32bfh		;32a6	18 17 	. . 
l32a8h:
	ld a,086h		;32a8	3e 86 	> . 
	call sub_0dfeh		;32aa	cd fe 0d 	. . . 
	ld l,(ix+002h)		;32ad	dd 6e 02 	. n . 
	ld h,(ix+003h)		;32b0	dd 66 03 	. f . 
	ld de,l00dch		;32b3	11 dc 00 	. . . 
	ld a,088h		;32b6	3e 88 	> . 
	call sub_2f60h		;32b8	cd 60 2f 	. ` / 
	ld (ix+006h),016h		;32bb	dd 36 06 16 	. 6 . . 
l32bfh:
	ld (ix+001h),009h		;32bf	dd 36 01 09 	. 6 . . 
	ld (ix+007h),007h		;32c3	dd 36 07 07 	. 6 . . 
	ret			;32c7	c9 	. 
	call l1be2h		;32c8	cd e2 1b 	. . . 
	dec (ix+007h)		;32cb	dd 35 07 	. 5 . 
	ret nz			;32ce	c0 	. 
	ld a,(ix+006h)		;32cf	dd 7e 06 	. ~ . 
	inc (ix+006h)		;32d2	dd 34 06 	. 4 . 
	ld (ix+007h),007h		;32d5	dd 36 07 07 	. 6 . . 
	cp 00ch		;32d9	fe 0c 	. . 
	ret nz			;32db	c0 	. 
	ld a,(ix+00eh)		;32dc	dd 7e 0e 	. ~ . 
	and a			;32df	a7 	. 
	call m,sub_3cbah		;32e0	fc ba 3c 	. . < 
	jp l3713h		;32e3	c3 13 37 	. . 7 
l32e6h:
	ld a,093h		;32e6	3e 93 	> . 
	call sub_0dfeh		;32e8	cd fe 0d 	. . . 
	jr l32f2h		;32eb	18 05 	. . 
l32edh:
	ld a,086h		;32ed	3e 86 	> . 
	call sub_0dfeh		;32ef	cd fe 0d 	. . . 
l32f2h:
	ld a,(0e701h)		;32f2	3a 01 e7 	: . . 
	and 001h		;32f5	e6 01 	. . 
	jr nz,l3300h		;32f7	20 07 	  . 
	ld b,084h		;32f9	06 84 	. . 
	ld de,08081h		;32fb	11 81 80 	. . . 
	jr l3305h		;32fe	18 05 	. . 
l3300h:
	ld b,082h		;3300	06 82 	. . 
	ld de,08c80h		;3302	11 80 8c 	. . . 
l3305h:
	ld a,r		;3305	ed 5f 	. _ 
	and 07fh		;3307	e6 7f 	.  
	cp 02ah		;3309	fe 2a 	. * 
	jr c,l333ch		;330b	38 2f 	8 / 
	ld b,e			;330d	43 	C 
	cp 055h		;330e	fe 55 	. U 
	jr c,l333ch		;3310	38 2a 	8 * 
	ld b,d			;3312	42 	B 
	jr l333ch		;3313	18 27 	. ' 
l3315h:
	ld b,088h		;3315	06 88 	. . 
	ld a,086h		;3317	3e 86 	> . 
	call sub_0dfeh		;3319	cd fe 0d 	. . . 
	jr l333ch		;331c	18 1e 	. . 
l331eh:
	ld b,087h		;331e	06 87 	. . 
	ld a,086h		;3320	3e 86 	> . 
	call sub_0dfeh		;3322	cd fe 0d 	. . . 
	jr l333ch		;3325	18 15 	. . 
l3327h:
	call sub_0dfeh		;3327	cd fe 0d 	. . . 
	ld l,(ix+004h)		;332a	dd 6e 04 	. n . 
	ld h,(ix+005h)		;332d	dd 66 05 	. f . 
	ld de,l0280h		;3330	11 80 02 	. . . 
	add hl,de			;3333	19 	. 
	ld de,l0120h		;3334	11 20 01 	.   . 
	call sub_36cah		;3337	cd ca 36 	. . 6 
sub_333ah:
	ld b,000h		;333a	06 00 	. . 
l333ch:
	ld (ix+00eh),b		;333c	dd 70 0e 	. p . 
	ld (ix+007h),007h		;333f	dd 36 07 07 	. 6 . . 
	ld (ix+001h),005h		;3343	dd 36 01 05 	. 6 . . 
	ld (ix+006h),00ah		;3347	dd 36 06 0a 	. 6 . . 
	ret			;334b	c9 	. 
l334ch:
	ld a,086h		;334c	3e 86 	> . 
	call sub_0dfeh		;334e	cd fe 0d 	. . . 
	jr sub_333ah		;3351	18 e7 	. . 
sub_3353h:
	call sub_36f6h		;3353	cd f6 36 	. . 6 
	ld a,(ix+002h)		;3356	dd 7e 02 	. ~ . 
	ld (iy+002h),a		;3359	fd 77 02 	. w . 
	ld a,(ix+003h)		;335c	dd 7e 03 	. ~ . 
	ld (iy+003h),a		;335f	fd 77 03 	. w . 
	ld a,(ix+004h)		;3362	dd 7e 04 	. ~ . 
	ld (iy+004h),a		;3365	fd 77 04 	. w . 
	ld a,(ix+005h)		;3368	dd 7e 05 	. ~ . 
	ld (iy+005h),a		;336b	fd 77 05 	. w . 
	set 4,(iy+000h)		;336e	fd cb 00 e6 	. . . . 
	ld (iy+007h),007h		;3372	fd 36 07 07 	. 6 . . 
	ld (iy+001h),005h		;3376	fd 36 01 05 	. 6 . . 
	ld (iy+006h),00ah		;337a	fd 36 06 0a 	. 6 . . 
	ret			;337e	c9 	. 
	call l1be2h		;337f	cd e2 1b 	. . . 
	call sub_3773h		;3382	cd 73 37 	. s 7 
	jp c,l32e6h		;3385	da e6 32 	. . 2 
	call sub_3746h		;3388	cd 46 37 	. F 7 
	ld a,093h		;338b	3e 93 	> . 
	jr c,l3327h		;338d	38 98 	8 . 
	ld hl,05000h		;338f	21 00 50 	! . P 
	call sub_371dh		;3392	cd 1d 37 	. . 7 
	jr c,l33c2h		;3395	38 2b 	8 + 
	ret			;3397	c9 	. 
	call l1be2h		;3398	cd e2 1b 	. . . 
	call sub_3773h		;339b	cd 73 37 	. s 7 
	jp c,l32f2h		;339e	da f2 32 	. . 2 
	dec (ix+007h)		;33a1	dd 35 07 	. 5 . 
	ret nz			;33a4	c0 	. 
	ld (ix+007h),005h		;33a5	dd 36 07 05 	. 6 . . 
	inc (ix+006h)		;33a9	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;33ac	dd 7e 06 	. ~ . 
	cp 007h		;33af	fe 07 	. . 
	jr nz,l3432h		;33b1	20 7f 	   
l33b3h:
	ld a,(0e80bh)		;33b3	3a 0b e8 	: . . 
	bit 7,a		;33b6	cb 7f 	.  
	set 6,(ix+000h)		;33b8	dd cb 00 f6 	. . . . 
	ret z			;33bc	c8 	. 
	res 6,(ix+000h)		;33bd	dd cb 00 b6 	. . . . 
	ret			;33c1	c9 	. 
l33c2h:
	ld (ix+001h),003h		;33c2	dd 36 01 03 	. 6 . . 
	ld (ix+007h),005h		;33c6	dd 36 07 05 	. 6 . . 
	ld (ix+006h),004h		;33ca	dd 36 06 04 	. 6 . . 
	ld a,093h		;33ce	3e 93 	> . 
	call sub_0dfeh		;33d0	cd fe 0d 	. . . 
	ret			;33d3	c9 	. 
	ld de,(0e36eh)		;33d4	ed 5b 6e e3 	. [ n . 
	call sub_1c7ah		;33d8	cd 7a 1c 	. z . 
	call l1be2h		;33db	cd e2 1b 	. . . 
	ld de,0e400h		;33de	11 00 e4 	. . . 
	add hl,de			;33e1	19 	. 
	jp c,l3713h		;33e2	da 13 37 	. . 7 
	bit 5,c		;33e5	cb 69 	. i 
	jr nz,l341ch		;33e7	20 33 	  3 
	ld a,(0e702h)		;33e9	3a 02 e7 	: . . 
	cp 00ch		;33ec	fe 0c 	. . 
	jr z,l341ch		;33ee	28 2c 	( , 
	ld hl,(0e80ah)		;33f0	2a 0a e8 	* . . 
	ld de,l00e0h		;33f3	11 e0 00 	. . . 
	bit 6,c		;33f6	cb 71 	. q 
	jr z,l33feh		;33f8	28 04 	( . 
	sbc hl,de		;33fa	ed 52 	. R 
	jr l33ffh		;33fc	18 01 	. . 
l33feh:
	add hl,de			;33fe	19 	. 
l33ffh:
	jr nc,l341ch		;33ff	30 1b 	0 . 
	ld hl,(0e710h)		;3401	2a 10 e7 	* . . 
	ld de,0ad00h		;3404	11 00 ad 	. . . 
	add hl,de			;3407	19 	. 
	jr c,l341ch		;3408	38 12 	8 . 
	ld hl,05600h		;340a	21 00 56 	! . V 
	ld de,00320h		;340d	11 20 03 	.   . 
	ld a,094h		;3410	3e 94 	> . 
	call sub_0dfeh		;3412	cd fe 0d 	. . . 
	call sub_36cah		;3415	cd ca 36 	. . 6 
	set 5,(ix+000h)		;3418	dd cb 00 ee 	. . . . 
l341ch:
	dec (ix+007h)		;341c	dd 35 07 	. 5 . 
	ret nz			;341f	c0 	. 
	ld (ix+007h),009h		;3420	dd 36 07 09 	. 6 . . 
	ld a,(ix+006h)		;3424	dd 7e 06 	. ~ . 
	inc a			;3427	3c 	< 
	cp 00ah		;3428	fe 0a 	. . 
	jr nz,l342eh		;342a	20 02 	  . 
	ld a,008h		;342c	3e 08 	> . 
l342eh:
	ld (ix+006h),a		;342e	dd 77 06 	. w . 
	ret			;3431	c9 	. 
l3432h:
	cp 008h		;3432	fe 08 	. . 
	ret nz			;3434	c0 	. 
l3435h:
	ld (ix+001h),004h		;3435	dd 36 01 04 	. 6 . . 
	ld (ix+006h),008h		;3439	dd 36 06 08 	. 6 . . 
	ld (ix+007h),009h		;343d	dd 36 07 09 	. 6 . . 
	jp l33b3h		;3441	c3 b3 33 	. . 3 
l3444h:
	ld de,(0e372h)		;3444	ed 5b 72 e3 	. [ r . 
	call sub_1c7ah		;3448	cd 7a 1c 	. z . 
	call l1be2h		;344b	cd e2 1b 	. . . 
	call sub_37bfh		;344e	cd bf 37 	. . 7 
	jp c,l3315h		;3451	da 15 33 	. . 3 
	call sub_3792h		;3454	cd 92 37 	. . 7 
	ld a,091h		;3457	3e 91 	> . 
	jp c,l3327h		;3459	da 27 33 	. ' 3 
	dec (ix+008h)		;345c	dd 35 08 	. 5 . 
	jp z,l356bh		;345f	ca 6b 35 	. k 5 
	dec (ix+007h)		;3462	dd 35 07 	. 5 . 
	ret z			;3465	c8 	. 
	ld (ix+007h),00bh		;3466	dd 36 07 0b 	. 6 . . 
	ld a,(ix+006h)		;346a	dd 7e 06 	. ~ . 
	inc a			;346d	3c 	< 
	cp 01bh		;346e	fe 1b 	. . 
	jr c,l3474h		;3470	38 02 	8 . 
	ld a,019h		;3472	3e 19 	> . 
l3474h:
	ld (ix+006h),a		;3474	dd 77 06 	. w . 
	ret			;3477	c9 	. 
	ld de,(0e374h)		;3478	ed 5b 74 e3 	. [ t . 
	call sub_1c7ah		;347c	cd 7a 1c 	. z . 
	ld hl,(0e36ah)		;347f	2a 6a e3 	* j . 
	jr l348eh		;3482	18 0a 	. . 
	ld de,(0e376h)		;3484	ed 5b 76 e3 	. [ v . 
	call sub_1c7ah		;3488	cd 7a 1c 	. z . 
	ld hl,(0e36ch)		;348b	2a 6c e3 	* l . 
l348eh:
	ld (0e800h),hl		;348e	22 00 e8 	" . . 
	call l1be2h		;3491	cd e2 1b 	. . . 
	call sub_37bfh		;3494	cd bf 37 	. . 7 
	jp c,l3315h		;3497	da 15 33 	. . 3 
	call sub_3792h		;349a	cd 92 37 	. . 7 
	ld a,091h		;349d	3e 91 	> . 
	jp c,l3327h		;349f	da 27 33 	. ' 3 
	ld de,(0e800h)		;34a2	ed 5b 00 e8 	. [ . . 
	ld hl,05000h		;34a6	21 00 50 	! . P 
	call sub_3732h		;34a9	cd 32 37 	. 2 7 
	jr c,l34c4h		;34ac	38 16 	8 . 
	dec (ix+007h)		;34ae	dd 35 07 	. 5 . 
	ret z			;34b1	c8 	. 
	ld (ix+007h),00bh		;34b2	dd 36 07 0b 	. 6 . . 
	ld a,(ix+006h)		;34b6	dd 7e 06 	. ~ . 
	inc a			;34b9	3c 	< 
	cp 01dh		;34ba	fe 1d 	. . 
	jr c,l34c0h		;34bc	38 02 	8 . 
	ld a,01bh		;34be	3e 1b 	> . 
l34c0h:
	ld (ix+006h),a		;34c0	dd 77 06 	. w . 
	ret			;34c3	c9 	. 
l34c4h:
	ld a,086h		;34c4	3e 86 	> . 
	call sub_0dfeh		;34c6	cd fe 0d 	. . . 
	ld a,r		;34c9	ed 5f 	. _ 
	and 003h		;34cb	e6 03 	. . 
	jp z,l3218h		;34cd	ca 18 32 	. . 2 
	push af			;34d0	f5 	. 
	call sub_3353h		;34d1	cd 53 33 	. S 3 
	pop af			;34d4	f1 	. 
	cp 001h		;34d5	fe 01 	. . 
	jp z,l3435h		;34d7	ca 35 34 	. 5 4 
	jp l3713h		;34da	c3 13 37 	. . 7 
sub_34ddh:
	call sub_36f6h		;34dd	cd f6 36 	. . 6 
	ld l,(ix+002h)		;34e0	dd 6e 02 	. n . 
	ld h,(ix+003h)		;34e3	dd 66 03 	. f . 
	ld de,00200h		;34e6	11 00 02 	. . . 
	ld a,(ix+000h)		;34e9	dd 7e 00 	. ~ . 
	and 040h		;34ec	e6 40 	. @ 
	jr z,l34f3h		;34ee	28 03 	( . 
	add hl,de			;34f0	19 	. 
	jr l34f5h		;34f1	18 02 	. . 
l34f3h:
	sbc hl,de		;34f3	ed 52 	. R 
l34f5h:
	ld (iy+002h),l		;34f5	fd 75 02 	. u . 
	ld (iy+003h),h		;34f8	fd 74 03 	. t . 
	xor 050h		;34fb	ee 50 	. P 
	ld (iy+000h),a		;34fd	fd 77 00 	. w . 
	ld a,(ix+00eh)		;3500	dd 7e 0e 	. ~ . 
	add a,00ch		;3503	c6 0c 	. . 
	ld (iy+001h),a		;3505	fd 77 01 	. w . 
	add a,a			;3508	87 	. 
	ld e,a			;3509	5f 	_ 
	ld d,000h		;350a	16 00 	. . 
	ld hl,03517h		;350c	21 17 35 	! . 5 
	add hl,de			;350f	19 	. 
	ld e,(hl)			;3510	5e 	^ 
	ld (iy+004h),e		;3511	fd 73 04 	. s . 
	inc hl			;3514	23 	# 
	ld e,(hl)			;3515	5e 	^ 
	ld (iy+005h),e		;3516	fd 73 05 	. s . 
	ld (iy+007h),00bh		;3519	fd 36 07 0b 	. 6 . . 
	cp 01ah		;351d	fe 1a 	. . 
	jr nz,l352ch		;351f	20 0b 	  . 
	ld (iy+006h),019h		;3521	fd 36 06 19 	. 6 . . 
l3525h:
	ld a,(0e365h)		;3525	3a 65 e3 	: e . 
	ld (iy+008h),a		;3528	fd 77 08 	. w . 
	ret			;352b	c9 	. 
l352ch:
	ld (iy+006h),01bh		;352c	fd 36 06 1b 	. 6 . . 
	ret			;3530	c9 	. 
	nop			;3531	00 	. 
	ld h,(hl)			;3532	66 	f 
	nop			;3533	00 	. 
	ld e,a			;3534	5f 	_ 
	nop			;3535	00 	. 
	ld e,d			;3536	5a 	Z 
	ld de,(0e363h)		;3537	ed 5b 63 e3 	. [ c . 
	call sub_1c7ah		;353b	cd 7a 1c 	. z . 
	call l1be2h		;353e	cd e2 1b 	. . . 
	call sub_3773h		;3541	cd 73 37 	. s 7 
	jp c,l3315h		;3544	da 15 33 	. . 3 
	call sub_3746h		;3547	cd 46 37 	. F 7 
	ld a,094h		;354a	3e 94 	> . 
	jp c,l3327h		;354c	da 27 33 	. ' 3 
	dec (ix+008h)		;354f	dd 35 08 	. 5 . 
	jp z,l334ch		;3552	ca 4c 33 	. L 3 
	dec (ix+007h)		;3555	dd 35 07 	. 5 . 
	ret nz			;3558	c0 	. 
	ld (ix+007h),00bh		;3559	dd 36 07 0b 	. 6 . . 
	ld a,(ix+006h)		;355d	dd 7e 06 	. ~ . 
	inc a			;3560	3c 	< 
	cp 01fh		;3561	fe 1f 	. . 
	jr c,l3567h		;3563	38 02 	8 . 
	ld a,01dh		;3565	3e 1d 	> . 
l3567h:
	ld (ix+006h),a		;3567	dd 77 06 	. w . 
	ret			;356a	c9 	. 
l356bh:
	call sub_3353h		;356b	cd 53 33 	. S 3 
	ld a,086h		;356e	3e 86 	> . 
	call sub_0dfeh		;3570	cd fe 0d 	. . . 
	ld a,r		;3573	ed 5f 	. _ 
	and 001h		;3575	e6 01 	. . 
	jp z,l3713h		;3577	ca 13 37 	. . 7 
	ld a,040h		;357a	3e 40 	> @ 
	xor (ix+000h)		;357c	dd ae 00 	. . . 
	ld (ix+000h),a		;357f	dd 77 00 	. w . 
	ld (ix+001h),010h		;3582	dd 36 01 10 	. 6 . . 
	ld (ix+006h),01dh		;3586	dd 36 06 1d 	. 6 . . 
	ld (ix+007h),00bh		;358a	dd 36 07 0b 	. 6 . . 
	ld a,(0e366h)		;358e	3a 66 e3 	: f . 
	ld (ix+008h),a		;3591	dd 77 08 	. w . 
	ret			;3594	c9 	. 
sub_3595h:
	ld a,(0e360h)		;3595	3a 60 e3 	: ` . 
	ld de,(0e712h)		;3598	ed 5b 12 e7 	. [ . . 
	ld hl,(0e361h)		;359c	2a 61 e3 	* a . 
	sbc hl,de		;359f	ed 52 	. R 
	jr c,l35aeh		;35a1	38 0b 	8 . 
	ld hl,(0e363h)		;35a3	2a 63 e3 	* c . 
	sbc hl,de		;35a6	ed 52 	. R 
	jr c,l35b5h		;35a8	38 0b 	8 . 
	cp 001h		;35aa	fe 01 	. . 
	jr l35afh		;35ac	18 01 	. . 
l35aeh:
	and a			;35ae	a7 	. 
l35afh:
	ret nz			;35af	c0 	. 
	xor a			;35b0	af 	. 
	ld (0e100h),a		;35b1	32 00 e1 	2 . . 
	ret			;35b4	c9 	. 
l35b5h:
	ld hl,0e380h		;35b5	21 80 e3 	! . . 
	dec (hl)			;35b8	35 	5 
	ret nz			;35b9	c0 	. 
	inc (hl)			;35ba	34 	4 
	inc hl			;35bb	23 	# 
	ld a,(hl)			;35bc	7e 	~ 
	cp 010h		;35bd	fe 10 	. . 
	ret nc			;35bf	d0 	. 
	ld a,(0e017h)		;35c0	3a 17 e0 	: . . 
	ld hl,0e36ah		;35c3	21 6a e3 	! j . 
	ld e,000h		;35c6	1e 00 	. . 
	cp (hl)			;35c8	be 	. 
	jr c,l35e8h		;35c9	38 1d 	8 . 
	inc hl			;35cb	23 	# 
	inc e			;35cc	1c 	. 
	cp (hl)			;35cd	be 	. 
	jr c,l35e8h		;35ce	38 18 	8 . 
	inc e			;35d0	1c 	. 
	ld a,(0e016h)		;35d1	3a 16 e0 	: . . 
	cp 07fh		;35d4	fe 7f 	.  
	ld a,0f8h		;35d6	3e f8 	> . 
	jr c,l35dch		;35d8	38 02 	8 . 
	ld a,006h		;35da	3e 06 	> . 
l35dch:
	ld hl,0e701h		;35dc	21 01 e7 	! . . 
	bit 6,(hl)		;35df	cb 76 	. v 
	jr nz,l35e5h		;35e1	20 02 	  . 
	neg		;35e3	ed 44 	. D 
l35e5h:
	ld d,a			;35e5	57 	W 
	jr l360bh		;35e6	18 23 	. # 
l35e8h:
	ld a,(0e016h)		;35e8	3a 16 e0 	: . . 
	ld d,0f7h		;35eb	16 f7 	. . 
	cp 02ah		;35ed	fe 2a 	. * 
	jr c,l360bh		;35ef	38 1a 	8 . 
	ld d,0fah		;35f1	16 fa 	. . 
	cp 055h		;35f3	fe 55 	. U 
	jr c,l360bh		;35f5	38 14 	8 . 
	ld d,0fdh		;35f7	16 fd 	. . 
	cp 07fh		;35f9	fe 7f 	.  
	jr c,l360bh		;35fb	38 0e 	8 . 
	ld d,003h		;35fd	16 03 	. . 
	cp 0aah		;35ff	fe aa 	. . 
	jr c,l360bh		;3601	38 08 	8 . 
	ld d,006h		;3603	16 06 	. . 
	cp 0d4h		;3605	fe d4 	. . 
	jr c,l360bh		;3607	38 02 	8 . 
	ld d,009h		;3609	16 09 	. . 
l360bh:
	ld a,(0e702h)		;360b	3a 02 e7 	: . . 
	cp 001h		;360e	fe 01 	. . 
	jr z,l3618h		;3610	28 06 	( . 
	cp 009h		;3612	fe 09 	. . 
	ld a,003h		;3614	3e 03 	> . 
	jr nz,l361ah		;3616	20 02 	  . 
l3618h:
	ld a,006h		;3618	3e 06 	> . 
l361ah:
	ld hl,0e701h		;361a	21 01 e7 	! . . 
	bit 6,(hl)		;361d	cb 76 	. v 
	jr z,l3623h		;361f	28 02 	( . 
	neg		;3621	ed 44 	. D 
l3623h:
	cp d			;3623	ba 	. 
	jr nz,l3628h		;3624	20 02 	  . 
	ld d,000h		;3626	16 00 	. . 
l3628h:
	ld a,(0e702h)		;3628	3a 02 e7 	: . . 
	cp 001h		;362b	fe 01 	. . 
	jr z,l3635h		;362d	28 06 	( . 
	cp 009h		;362f	fe 09 	. . 
	ld a,003h		;3631	3e 03 	> . 
	jr nz,l3637h		;3633	20 02 	  . 
l3635h:
	ld a,009h		;3635	3e 09 	> . 
l3637h:
	bit 6,(hl)		;3637	cb 76 	. v 
	jr nz,l363dh		;3639	20 02 	  . 
	neg		;363b	ed 44 	. D 
l363dh:
	add a,d			;363d	82 	. 
	ld d,a			;363e	57 	W 
	ld a,(0e713h)		;363f	3a 13 e7 	: . . 
	add a,d			;3642	82 	. 
	ld d,a			;3643	57 	W 
	set 0,d		;3644	cb c2 	. . 
	ex de,hl			;3646	eb 	. 
	ld ix,0e36fh		;3647	dd 21 6f e3 	. ! o . 
	ld de,l0013h		;364b	11 13 00 	. . . 
	ld b,010h		;364e	06 10 	. . 
l3650h:
	add ix,de		;3650	dd 19 	. . 
	bit 4,(ix+000h)		;3652	dd cb 00 66 	. . . f 
	jr z,l366ch		;3656	28 14 	( . 
	ld a,(ix+001h)		;3658	dd 7e 01 	. ~ . 
	cp 003h		;365b	fe 03 	. . 
	jr c,l3667h		;365d	38 08 	8 . 
	cp 006h		;365f	fe 06 	. . 
	jr c,l366ch		;3661	38 09 	8 . 
	cp 009h		;3663	fe 09 	. . 
	jr nc,l366ch		;3665	30 05 	0 . 
l3667h:
	ld a,(ix+012h)		;3667	dd 7e 12 	. ~ . 
	cp h			;366a	bc 	. 
	ret z			;366b	c8 	. 
l366ch:
	djnz l3650h		;366c	10 e2 	. . 
	ex de,hl			;366e	eb 	. 
	ld a,(0e015h)		;366f	3a 15 e0 	: . . 
	ld hl,0e365h		;3672	21 65 e3 	! e . 
	call sub_1214h		;3675	cd 14 12 	. . . 
	ld hl,0e380h		;3678	21 80 e3 	! . . 
	ld (hl),a			;367b	77 	w 
	inc hl			;367c	23 	# 
	inc (hl)			;367d	34 	4 
	ld ix,0e36fh		;367e	dd 21 6f e3 	. ! o . 
	ld bc,l0013h		;3682	01 13 00 	. . . 
l3685h:
	add ix,bc		;3685	dd 09 	. . 
	bit 4,(ix+000h)		;3687	dd cb 00 66 	. . . f 
	jr nz,l3685h		;368b	20 f8 	  . 
	ld a,r		;368d	ed 5f 	. _ 
	and 040h		;368f	e6 40 	. @ 
	or 010h		;3691	f6 10 	. . 
	ld (ix+000h),a		;3693	dd 77 00 	. w . 
	ld (ix+001h),e		;3696	dd 73 01 	. s . 
	ld (ix+006h),e		;3699	dd 73 06 	. s . 
	ld (ix+012h),d		;369c	dd 72 12 	. r . 
	ld (ix+003h),d		;369f	dd 72 03 	. r . 
	ld (ix+002h),000h		;36a2	dd 36 02 00 	. 6 . . 
	ld hl,09000h		;36a6	21 00 90 	! . . 
	ld (ix+004h),l		;36a9	dd 75 04 	. u . 
	ld (ix+005h),h		;36ac	dd 74 05 	. t . 
	ld (ix+007h),003h		;36af	dd 36 07 03 	. 6 . . 
	ld hl,0000ah		;36b3	21 0a 00 	! . . 
	ld de,l007dh		;36b6	11 7d 00 	. } . 
	ld (ix+00ah),l		;36b9	dd 75 0a 	. u . 
	ld (ix+00bh),h		;36bc	dd 74 0b 	. t . 
	ld hl,(0e36ch)		;36bf	2a 6c e3 	* l . 
	add hl,de			;36c2	19 	. 
	ld (ix+00ch),l		;36c3	dd 75 0c 	. u . 
	ld (ix+00dh),h		;36c6	dd 74 0d 	. t . 
	ret			;36c9	c9 	. 
sub_36cah:
	ld a,(0e080h)		;36ca	3a 80 e0 	: . . 
	and 007h		;36cd	e6 07 	. . 
	cp 003h		;36cf	fe 03 	. . 
	jr nz,l36e4h		;36d1	20 11 	  . 
	ld a,(0e709h)		;36d3	3a 09 e7 	: . . 
	sub e			;36d6	93 	. 
	jp p,l36e4h		;36d7	f2 e4 36 	. . 6 
	call sub_1208h		;36da	cd 08 12 	. . . 
	jr nz,l36e4h		;36dd	20 05 	  . 
	ld a,005h		;36df	3e 05 	> . 
	ld (0e007h),a		;36e1	32 07 e0 	2 . . 
l36e4h:
	jp sub_2ee2h		;36e4	c3 e2 2e 	. . . 
l36e7h:
	ld hl,(0e80ch)		;36e7	2a 0c e8 	* . . 
	ld de,0e400h		;36ea	11 00 e4 	. . . 
	add hl,de			;36ed	19 	. 
	ret c			;36ee	d8 	. 
	ld hl,0748eh		;36ef	21 8e 74 	! . t 
	ld a,c			;36f2	79 	y 
	jp l1a7eh		;36f3	c3 7e 1a 	. ~ . 
sub_36f6h:
	ld a,(0e381h)		;36f6	3a 81 e3 	: . . 
	cp 010h		;36f9	fe 10 	. . 
	jr nc,l3711h		;36fb	30 14 	0 . 
	inc a			;36fd	3c 	< 
	ld (0e381h),a		;36fe	32 81 e3 	2 . . 
	ld iy,0e36fh		;3701	fd 21 6f e3 	. ! o . 
	ld de,l0013h		;3705	11 13 00 	. . . 
l3708h:
	add iy,de		;3708	fd 19 	. . 
	bit 4,(iy+000h)		;370a	fd cb 00 66 	. . . f 
	jr nz,l3708h		;370e	20 f8 	  . 
	ret			;3710	c9 	. 
l3711h:
	pop af			;3711	f1 	. 
	ret			;3712	c9 	. 
l3713h:
	ld (ix+000h),000h		;3713	dd 36 00 00 	. 6 . . 
	ld hl,0e381h		;3717	21 81 e3 	! . . 
	dec (hl)			;371a	35 	5 
	pop af			;371b	f1 	. 
	ret			;371c	c9 	. 
sub_371dh:
	push hl			;371d	e5 	. 
	ld l,(ix+00ah)		;371e	dd 6e 0a 	. n . 
	ld h,(ix+00bh)		;3721	dd 66 0b 	. f . 
	ld e,(ix+00ch)		;3724	dd 5e 0c 	. ^ . 
	ld d,(ix+00dh)		;3727	dd 56 0d 	. V . 
	add hl,de			;372a	19 	. 
	ld (ix+00ch),l		;372b	dd 75 0c 	. u . 
	ld (ix+00dh),h		;372e	dd 74 0d 	. t . 
	pop hl			;3731	e1 	. 
sub_3732h:
	push hl			;3732	e5 	. 
	and a			;3733	a7 	. 
	ld l,(ix+004h)		;3734	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3737	dd 66 05 	. f . 
	sbc hl,de		;373a	ed 52 	. R 
	ld (ix+004h),l		;373c	dd 75 04 	. u . 
	ld (ix+005h),h		;373f	dd 74 05 	. t . 
	pop de			;3742	d1 	. 
	sbc hl,de		;3743	ed 52 	. R 
	ret			;3745	c9 	. 
sub_3746h:
	ld hl,(0e80ch)		;3746	2a 0c e8 	* . . 
	ld de,l0300h		;3749	11 00 03 	. . . 
	sbc hl,de		;374c	ed 52 	. R 
	ret nc			;374e	d0 	. 
	ld e,(ix+002h)		;374f	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;3752	dd 56 03 	. V . 
	ld hl,0ff80h		;3755	21 80 ff 	! . . 
	add hl,de			;3758	19 	. 
	ld (0e80fh),hl		;3759	22 0f e8 	" . . 
	ld hl,l0080h		;375c	21 80 00 	! . . 
	add hl,de			;375f	19 	. 
	ld (0e811h),hl		;3760	22 11 e8 	" . . 
l3763h:
	ld l,(ix+004h)		;3763	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3766	dd 66 05 	. f . 
	ld de,l0080h		;3769	11 80 00 	. . . 
	add hl,de			;376c	19 	. 
	ld de,0006h+2		;376d	11 08 00 	. . . 
	jp sub_1172h		;3770	c3 72 11 	. r . 
sub_3773h:
	ld hl,l0140h		;3773	21 40 01 	! @ . 
	call sub_1220h		;3776	cd 20 12 	.   . 
	ret nc			;3779	d0 	. 
	and a			;377a	a7 	. 
	ld l,(ix+004h)		;377b	dd 6e 04 	. n . 
	ld h,(ix+005h)		;377e	dd 66 05 	. f . 
	sbc hl,de		;3781	ed 52 	. R 
	ret nc			;3783	d0 	. 
	ld hl,0f800h		;3784	21 00 f8 	! . . 
	add hl,de			;3787	19 	. 
	ld e,(ix+004h)		;3788	dd 5e 04 	. ^ . 
	ld d,(ix+005h)		;378b	dd 56 05 	. V . 
	and a			;378e	a7 	. 
	sbc hl,de		;378f	ed 52 	. R 
	ret			;3791	c9 	. 
sub_3792h:
	ld hl,(0e80ch)		;3792	2a 0c e8 	* . . 
	ld de,l0300h		;3795	11 00 03 	. . . 
	sbc hl,de		;3798	ed 52 	. R 
	ret nc			;379a	d0 	. 
	ld e,(ix+002h)		;379b	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;379e	dd 56 03 	. V . 
	ld hl,0ffc0h		;37a1	21 c0 ff 	! . . 
	add hl,de			;37a4	19 	. 
	ld (0e80fh),hl		;37a5	22 0f e8 	" . . 
	ld hl,l0040h		;37a8	21 40 00 	! @ . 
	add hl,de			;37ab	19 	. 
	ld (0e811h),hl		;37ac	22 11 e8 	" . . 
	ld l,(ix+004h)		;37af	dd 6e 04 	. n . 
	ld h,(ix+005h)		;37b2	dd 66 05 	. f . 
	ld de,l0080h		;37b5	11 80 00 	. . . 
	add hl,de			;37b8	19 	. 
	ld de,4				;37b9	11 04 00 	. . . 
	jp sub_1172h		;37bc	c3 72 11 	. r . 
sub_37bfh:
	ld hl,l00e0h		;37bf	21 e0 00 	! . . 
	call sub_1220h		;37c2	cd 20 12 	.   . 
	ret nc			;37c5	d0 	. 
	and a			;37c6	a7 	. 
	ld l,(ix+004h)		;37c7	dd 6e 04 	. n . 
	ld h,(ix+005h)		;37ca	dd 66 05 	. f . 
	sbc hl,de		;37cd	ed 52 	. R 
	ret nc			;37cf	d0 	. 
	ld hl,0fb80h		;37d0	21 80 fb 	! . . 
	add hl,de			;37d3	19 	. 
	ld e,(ix+004h)		;37d4	dd 5e 04 	. ^ . 
	ld d,(ix+005h)		;37d7	dd 56 05 	. V . 
	and a			;37da	a7 	. 
	sbc hl,de		;37db	ed 52 	. R 
	ret			;37dd	c9 	. 
sub_37deh:
	ld hl,(0e712h)		;37de	2a 12 e7 	* . . 
	ld de,08000h		;37e1	11 00 80 	. . . 
	add hl,de			;37e4	19 	. 
	jr c,l37f1h		;37e5	38 0a 	8 . 
	call sub_37f6h		;37e7	cd f6 37 	. . 7 
	call sub_38ffh		;37ea	cd ff 38 	. . 8 
	call sub_3960h		;37ed	cd 60 39 	. ` 9 
	ret			;37f0	c9 	. 
l37f1h:
	xor a			;37f1	af 	. 
	ld (0e100h),a		;37f2	32 00 e1 	2 . . 
	ret			;37f5	c9 	. 
sub_37f6h:
	ld b,004h		;37f6	06 04 	. . 
	ld hl,0e572h		;37f8	21 72 e5 	! r . 
l37fbh:
	ld a,(hl)			;37fb	7e 	~ 
	and a			;37fc	a7 	. 
	jr z,l3804h		;37fd	28 05 	( . 
	dec (hl)			;37ff	35 	5 
l3800h:
	inc hl			;3800	23 	# 
	djnz l37fbh		;3801	10 f8 	. . 
	ret			;3803	c9 	. 
l3804h:
	push bc			;3804	c5 	. 
	push hl			;3805	e5 	. 
	ld a,(0e080h)		;3806	3a 80 e0 	: . . 
	cp 010h		;3809	fe 10 	. . 
	ld hl,l38dbh		;380b	21 db 38 	! . 8 
	jr c,l3813h		;380e	38 03 	8 . 
	ld hl,l38ebh		;3810	21 eb 38 	! . 8 
l3813h:
	ld d,000h		;3813	16 00 	. . 
	ld e,b			;3815	58 	X 
	rlc e		;3816	cb 03 	. . 
	rlc e		;3818	cb 03 	. . 
	add hl,de			;381a	19 	. 
	ld e,(hl)			;381b	5e 	^ 
	inc hl			;381c	23 	# 
	ld d,(hl)			;381d	56 	V 
	push hl			;381e	e5 	. 
	ld bc,(0e712h)		;381f	ed 4b 12 e7 	. K . . 
	ld hl,sub_0f3fh+1		;3823	21 40 0f 	! @ . 
	add hl,bc			;3826	09 	. 
	sbc hl,de		;3827	ed 52 	. R 
	jp c,l38d9h		;3829	da d9 38 	. . 8 
	ld hl,0f0c0h		;382c	21 c0 f0 	! . . 
	add hl,bc			;382f	09 	. 
	sbc hl,de		;3830	ed 52 	. R 
	jp nc,l38d9h		;3832	d2 d9 38 	. . 8 
	ld hl,0e576h		;3835	21 76 e5 	! v . 
	ld a,(0e50bh)		;3838	3a 0b e5 	: . . 
	cp (hl)			;383b	be 	. 
	jp c,l38d9h		;383c	da d9 38 	. . 8 
	inc (hl)			;383f	34 	4 
	ld iy,0e562h		;3840	fd 21 62 e5 	. ! b . 
	ld bc,l0013h+2		;3844	01 15 00 	. . . 
l3847h:
	add iy,bc		;3847	fd 09 	. . 
	bit 4,(iy+000h)		;3849	fd cb 00 66 	. . . f 
	jr nz,l3847h		;384d	20 f8 	  . 
	ld (iy+002h),e		;384f	fd 73 02 	. s . 
	ld (iy+003h),d		;3852	fd 72 03 	. r . 
	ld hl,(0e712h)		;3855	2a 12 e7 	* . . 
	ld a,010h		;3858	3e 10 	> . 
	sbc hl,de		;385a	ed 52 	. R 
	jr c,l3860h		;385c	38 02 	8 . 
	ld a,050h		;385e	3e 50 	> P 
l3860h:
	ld (iy+000h),a		;3860	fd 77 00 	. w . 
	call sub_3dc5h		;3863	cd c5 3d 	. . = 
	push de			;3866	d5 	. 
	ld a,(0e012h)		;3867	3a 12 e0 	: . . 
	ld hl,0e50dh		;386a	21 0d e5 	! . . 
	cp (hl)			;386d	be 	. 
	jr nc,l387fh		;386e	30 0f 	0 . 
	set 1,(iy+014h)		;3870	fd cb 14 ce 	. . . . 
	and 002h		;3874	e6 02 	. . 
	ld a,038h		;3876	3e 38 	> 8 
	jr z,l387ch		;3878	28 02 	( . 
	ld a,0a9h		;387a	3e a9 	> . 
l387ch:
	ld (iy+013h),a		;387c	fd 77 13 	. w . 
l387fh:
	ld a,(0e013h)		;387f	3a 13 e0 	: . . 
	ld hl,0e50eh		;3882	21 0e e5 	! . . 
	cp (hl)			;3885	be 	. 
	jr nc,l3896h		;3886	30 0e 	0 . 
	set 0,(iy+014h)		;3888	fd cb 14 c6 	. . . . 
	and 002h		;388c	e6 02 	. . 
	inc hl			;388e	23 	# 
	jr z,l3892h		;388f	28 01 	( . 
	inc hl			;3891	23 	# 
l3892h:
	ld a,(hl)			;3892	7e 	~ 
	ld (iy+012h),a		;3893	fd 77 12 	. w . 
l3896h:
	pop de			;3896	d1 	. 
	pop hl			;3897	e1 	. 
	inc hl			;3898	23 	# 
	ld a,(hl)			;3899	7e 	~ 
	inc hl			;389a	23 	# 
	ld h,(hl)			;389b	66 	f 
	ld l,a			;389c	6f 	o 
	ld (iy+004h),l		;389d	fd 75 04 	. u . 
	ld (iy+005h),h		;38a0	fd 74 05 	. t . 
	sbc hl,de		;38a3	ed 52 	. R 
	ld (iy+00ch),l		;38a5	fd 75 0c 	. u . 
	ld (iy+00dh),h		;38a8	fd 74 0d 	. t . 
	push af			;38ab	f5 	. 
	ld a,(iy+001h)		;38ac	fd 7e 01 	. ~ . 
	add a,004h		;38af	c6 04 	. . 
	ld (iy+001h),a		;38b1	fd 77 01 	. w . 
	cp 004h		;38b4	fe 04 	. . 
	jr z,l38c1h		;38b6	28 09 	( . 
	pop af			;38b8	f1 	. 
	ld a,r		;38b9	ed 5f 	. _ 
	bit 0,a		;38bb	cb 47 	. G 
	jr z,l38c4h		;38bd	28 05 	( . 
	jr l38c8h		;38bf	18 07 	. . 
l38c1h:
	pop af			;38c1	f1 	. 
	jr c,l38c8h		;38c2	38 04 	8 . 
l38c4h:
	set 3,(iy+000h)		;38c4	fd cb 00 de 	. . . . 
l38c8h:
	ld (iy+006h),006h		;38c8	fd 36 06 06 	. 6 . . 
	ld (iy+007h),010h		;38cc	fd 36 07 10 	. 6 . . 
	ld a,(0e50ah)		;38d0	3a 0a e5 	: . . 
	pop hl			;38d3	e1 	. 
	ld (hl),a			;38d4	77 	w 
	pop bc			;38d5	c1 	. 
	jp l3800h		;38d6	c3 00 38 	. . 8 
l38d9h:
	pop hl			;38d9	e1 	. 
	pop hl			;38da	e1 	. 
l38dbh:
	pop bc			;38db	c1 	. 
	jp l3800h		;38dc	c3 00 38 	. . 8 
	nop			;38df	00 	. 
	ld (hl),c			;38e0	71 	q 
	nop			;38e1	00 	. 
	add a,b			;38e2	80 	. 
	nop			;38e3	00 	. 
	ld e,e			;38e4	5b 	[ 
	nop			;38e5	00 	. 
	ld d,h			;38e6	54 	T 
	nop			;38e7	00 	. 
	dec a			;38e8	3d 	= 
	nop			;38e9	00 	. 
	ld (hl),b			;38ea	70 	p 
l38ebh:
	nop			;38eb	00 	. 
	inc hl			;38ec	23 	# 
	nop			;38ed	00 	. 
	add a,b			;38ee	80 	. 
	nop			;38ef	00 	. 
	ld (hl),c			;38f0	71 	q 
	nop			;38f1	00 	. 
	add a,b			;38f2	80 	. 
	nop			;38f3	00 	. 
	ld e,e			;38f4	5b 	[ 
	nop			;38f5	00 	. 
	ld (hl),b			;38f6	70 	p 
	nop			;38f7	00 	. 
	dec a			;38f8	3d 	= 
	nop			;38f9	00 	. 
	ld (hl),b			;38fa	70 	p 
	nop			;38fb	00 	. 
	inc hl			;38fc	23 	# 
	nop			;38fd	00 	. 
	add a,b			;38fe	80 	. 
sub_38ffh:
	ld a,(0e520h)		;38ff	3a 20 e5 	:   . 
	and a			;3902	a7 	. 
	ret z			;3903	c8 	. 
	ld b,a			;3904	47 	G 
	ld ix,0e521h		;3905	dd 21 21 e5 	. ! ! . 
l3909h:
	ld l,(ix+000h)		;3909	dd 6e 00 	. n . 
	ld h,(ix+001h)		;390c	dd 66 01 	. f . 
l390fh:
	ld de,l0029h		;390f	11 29 00 	. ) . 
	sbc hl,de		;3912	ed 52 	. R 
	ex de,hl			;3914	eb 	. 
	ld hl,l0800h		;3915	21 00 08 	! . . 
	sbc hl,de		;3918	ed 52 	. R 
	jr c,l3921h		;391a	38 05 	8 . 
	call sub_3d0eh		;391c	cd 0e 3d 	. . = 
	jr l3945h		;391f	18 24 	. $ 
l3921h:
	ld (ix+000h),e		;3921	dd 73 00 	. s . 
	ld (ix+001h),d		;3924	dd 72 01 	. r . 
	ld hl,(0e712h)		;3927	2a 12 e7 	* . . 
	sbc hl,de		;392a	ed 52 	. R 
	jr c,l3938h		;392c	38 0a 	8 . 
	ld de,0f000h		;392e	11 00 f0 	. . . 
	add hl,de			;3931	19 	. 
	jr c,l3959h		;3932	38 25 	8 % 
	ld c,0ffh		;3934	0e ff 	. . 
	jr l3940h		;3936	18 08 	. . 
l3938h:
	ld de,l1000h		;3938	11 00 10 	. . . 
	add hl,de			;393b	19 	. 
	jr nc,l3959h		;393c	30 1b 	0 . 
	ld c,000h		;393e	0e 00 	. . 
l3940h:
	push bc			;3940	c5 	. 
	call sub_3d55h		;3941	cd 55 3d 	. U = 
	pop bc			;3944	c1 	. 
l3945h:
	ld hl,0e520h		;3945	21 20 e5 	!   . 
	dec (hl)			;3948	35 	5 
	ret z			;3949	c8 	. 
	dec b			;394a	05 	. 
	ret z			;394b	c8 	. 
	ld a,(hl)			;394c	7e 	~ 
	inc hl			;394d	23 	# 
	rlca			;394e	07 	. 
	ld d,000h		;394f	16 00 	. . 
	ld e,a			;3951	5f 	_ 
	add hl,de			;3952	19 	. 
	ld a,(hl)			;3953	7e 	~ 
	inc hl			;3954	23 	# 
	ld h,(hl)			;3955	66 	f 
	ld l,a			;3956	6f 	o 
	jr l390fh		;3957	18 b6 	. . 
l3959h:
	inc ix		;3959	dd 23 	. # 
	inc ix		;395b	dd 23 	. # 
	djnz l3909h		;395d	10 aa 	. . 
	ret			;395f	c9 	. 
sub_3960h:
	ld a,(0e549h)		;3960	3a 49 e5 	: I . 
	and a			;3963	a7 	. 
	ret z			;3964	c8 	. 
	ld b,a			;3965	47 	G 
	ld ix,0e54ah		;3966	dd 21 4a e5 	. ! J . 
l396ah:
	ld l,(ix+000h)		;396a	dd 6e 00 	. n . 
	ld h,(ix+001h)		;396d	dd 66 01 	. f . 
l3970h:
	ld de,l0029h		;3970	11 29 00 	. ) . 
	add hl,de			;3973	19 	. 
	ex de,hl			;3974	eb 	. 
	ld hl,08000h		;3975	21 00 80 	! . . 
	sbc hl,de		;3978	ed 52 	. R 
	jr nc,l3981h		;397a	30 05 	0 . 
	call sub_3d09h		;397c	cd 09 3d 	. . = 
	jr l39a5h		;397f	18 24 	. $ 
l3981h:
	ld (ix+000h),e		;3981	dd 73 00 	. s . 
	ld (ix+001h),d		;3984	dd 72 01 	. r . 
	ld hl,(0e712h)		;3987	2a 12 e7 	* . . 
	sbc hl,de		;398a	ed 52 	. R 
	jr c,l3998h		;398c	38 0a 	8 . 
	ld de,0f000h		;398e	11 00 f0 	. . . 
	add hl,de			;3991	19 	. 
	jr c,l39b9h		;3992	38 25 	8 % 
	ld c,0ffh		;3994	0e ff 	. . 
	jr l39a0h		;3996	18 08 	. . 
l3998h:
	ld de,l1000h		;3998	11 00 10 	. . . 
	add hl,de			;399b	19 	. 
	jr nc,l39b9h		;399c	30 1b 	0 . 
	ld c,000h		;399e	0e 00 	. . 
l39a0h:
	push bc			;39a0	c5 	. 
	call sub_3d59h		;39a1	cd 59 3d 	. Y = 
	pop bc			;39a4	c1 	. 
l39a5h:
	ld hl,0e549h		;39a5	21 49 e5 	! I . 
	dec (hl)			;39a8	35 	5 
	ret z			;39a9	c8 	. 
	dec b			;39aa	05 	. 
	ret z			;39ab	c8 	. 
	ld a,(hl)			;39ac	7e 	~ 
	inc hl			;39ad	23 	# 
	rlca			;39ae	07 	. 
	ld d,000h		;39af	16 00 	. . 
	ld e,a			;39b1	5f 	_ 
	add hl,de			;39b2	19 	. 
	ld a,(hl)			;39b3	7e 	~ 
	inc hl			;39b4	23 	# 
	ld h,(hl)			;39b5	66 	f 
	ld l,a			;39b6	6f 	o 
	jr l3970h		;39b7	18 b7 	. . 
l39b9h:
	inc ix		;39b9	dd 23 	. # 
	inc ix		;39bb	dd 23 	. # 
	djnz l396ah		;39bd	10 ab 	. . 
	ret			;39bf	c9 	. 
sub_39c0h:
	ld a,(0e576h)		;39c0	3a 76 e5 	: v . 
	and a			;39c3	a7 	. 
	ret z			;39c4	c8 	. 
	ld ix,0e577h		;39c5	dd 21 77 e5 	. ! w . 
	ld a,(0e50bh)		;39c9	3a 0b e5 	: . . 
	ld b,a			;39cc	47 	G 
l39cdh:
	push bc			;39cd	c5 	. 
	ld c,(ix+000h)		;39ce	dd 4e 00 	. N . 
	bit 4,c		;39d1	cb 61 	. a 
	call nz,sub_39dfh		;39d3	c4 df 39 	. . 9 
	pop bc			;39d6	c1 	. 
	ld de,l0013h+2		;39d7	11 15 00 	. . . 
	add ix,de		;39da	dd 19 	. . 
	djnz l39cdh		;39dc	10 ef 	. . 
	ret			;39de	c9 	. 
sub_39dfh:
	ld a,(ix+001h)		;39df	dd 7e 01 	. ~ . 
	cp 004h		;39e2	fe 04 	. . 
	jr c,l39f1h		;39e4	38 0b 	8 . 
	cp 007h		;39e6	fe 07 	. . 
	jp c,l3c3bh		;39e8	da 3b 3c 	. ; < 
	jp z,l3be9h		;39eb	ca e9 3b 	. . ; 
	jp l3b1fh		;39ee	c3 1f 3b 	. . ; 
l39f1h:
	dec (ix+007h)		;39f1	dd 35 07 	. 5 . 
	jr nz,l3a03h		;39f4	20 0d 	  . 
	ld (ix+007h),005h		;39f6	dd 36 07 05 	. 6 . . 
	dec (ix+006h)		;39fa	dd 35 06 	. 5 . 
	jr z,l3a03h		;39fd	28 04 	( . 
	ld (ix+006h),001h		;39ff	dd 36 06 01 	. 6 . . 
l3a03h:
	bit 1,(ix+014h)		;3a03	dd cb 14 4e 	. . . N 
	jr z,l3a26h		;3a07	28 1d 	( . 
	dec (ix+013h)		;3a09	dd 35 13 	. 5 . 
	jr nz,l3a26h		;3a0c	20 18 	  . 
	bit 2,(ix+014h)		;3a0e	dd cb 14 56 	. . . V 
	jr nz,l3a1eh		;3a12	20 0a 	  . 
	set 2,(ix+014h)		;3a14	dd cb 14 d6 	. . . . 
	ld (ix+013h),0a9h		;3a18	dd 36 13 a9 	. 6 . . 
	jr l3a26h		;3a1c	18 08 	. . 
l3a1eh:
	res 2,(ix+014h)		;3a1e	dd cb 14 96 	. . . . 
	res 1,(ix+014h)		;3a22	dd cb 14 8e 	. . . . 
l3a26h:
	bit 0,(ix+014h)		;3a26	dd cb 14 46 	. . . F 
	jr z,l3a32h		;3a2a	28 06 	( . 
	dec (ix+012h)		;3a2c	dd 35 12 	. 5 . 
	jp z,l3b92h		;3a2f	ca 92 3b 	. . ; 
l3a32h:
	ld l,(ix+002h)		;3a32	dd 6e 02 	. n . 
	ld h,(ix+003h)		;3a35	dd 66 03 	. f . 
	ld e,(ix+010h)		;3a38	dd 5e 10 	. ^ . 
	ld d,(ix+011h)		;3a3b	dd 56 11 	. V . 
	bit 2,(ix+014h)		;3a3e	dd cb 14 56 	. . . V 
	jr z,l3a47h		;3a42	28 03 	( . 
	ld de,0		;3a44	11 00 00 	. . . 
l3a47h:
	bit 6,c		;3a47	cb 71 	. q 
	jr nz,l3a5eh		;3a49	20 13 	  . 
	sbc hl,de		;3a4b	ed 52 	. R 
	ex de,hl			;3a4d	eb 	. 
	ld hl,0f400h		;3a4e	21 00 f4 	! . . 
	add hl,de			;3a51	19 	. 
	jr c,l3a70h		;3a52	38 1c 	8 . 
	set 6,(ix+000h)		;3a54	dd cb 00 f6 	. . . . 
	ld hl,l3eabh		;3a58	21 ab 3e 	! . > 
	jp l3baah		;3a5b	c3 aa 3b 	. . ; 
l3a5eh:
	add hl,de			;3a5e	19 	. 
	ex de,hl			;3a5f	eb 	. 
	ld hl,08400h		;3a60	21 00 84 	! . . 
	add hl,de			;3a63	19 	. 
	jr nc,l3a70h		;3a64	30 0a 	0 . 
	res 6,(ix+000h)		;3a66	dd cb 00 b6 	. . . . 
	ld hl,l3e7fh		;3a6a	21 7f 3e 	!  > 
	jp l3baah		;3a6d	c3 aa 3b 	. . ; 
l3a70h:
	ld (ix+002h),e		;3a70	dd 73 02 	. s . 
	ld (ix+003h),d		;3a73	dd 72 03 	. r . 
	push de			;3a76	d5 	. 
	ld hl,(0e712h)		;3a77	2a 12 e7 	* . . 
	sbc hl,de		;3a7a	ed 52 	. R 
	ld de,l1100h		;3a7c	11 00 11 	. . . 
	jr c,l3a89h		;3a7f	38 08 	8 . 
	sbc hl,de		;3a81	ed 52 	. R 
	pop de			;3a83	d1 	. 
	jr c,l3a94h		;3a84	38 0e 	8 . 
	jp l3cfbh		;3a86	c3 fb 3c 	. . < 
l3a89h:
	add hl,de			;3a89	19 	. 
	pop de			;3a8a	d1 	. 
	jr c,l3a94h		;3a8b	38 07 	8 . 
	ld hl,0df00h		;3a8d	21 00 df 	! . . 
	add hl,de			;3a90	19 	. 
	jp c,l3cfbh		;3a91	da fb 3c 	. . < 
l3a94h:
	cp 003h		;3a94	fe 03 	. . 
	jr z,l3af4h		;3a96	28 5c 	( \ 
	call sub_3d22h		;3a98	cd 22 3d 	. " = 
	dec a			;3a9b	3d 	= 
	jp m,l3ae4h		;3a9c	fa e4 3a 	. . : 
	push de			;3a9f	d5 	. 
	ld l,(ix+00ch)		;3aa0	dd 6e 0c 	. n . 
	ld h,(ix+00dh)		;3aa3	dd 66 0d 	. f . 
	jr z,l3aaeh		;3aa6	28 06 	( . 
	ld de,(0e504h)		;3aa8	ed 5b 04 e5 	. [ . . 
	jr l3ab2h		;3aac	18 04 	. . 
l3aaeh:
	ld de,(0e506h)		;3aae	ed 5b 06 e5 	. [ . . 
l3ab2h:
	bit 3,c		;3ab2	cb 59 	. Y 
	jr z,l3ac3h		;3ab4	28 0d 	( . 
	sbc hl,de		;3ab6	ed 52 	. R 
	ex de,hl			;3ab8	eb 	. 
	bit 7,d		;3ab9	cb 7a 	. z 
	jr z,l3adbh		;3abb	28 1e 	( . 
	res 3,(ix+000h)		;3abd	dd cb 00 9e 	. . . . 
	jr l3adbh		;3ac1	18 18 	. . 
l3ac3h:
	add hl,de			;3ac3	19 	. 
	ex de,hl			;3ac4	eb 	. 
	bit 7,d		;3ac5	cb 7a 	. z 
	jr nz,l3adbh		;3ac7	20 12 	  . 
	and a			;3ac9	a7 	. 
	jr z,l3ad1h		;3aca	28 05 	( . 
	ld hl,0ec00h		;3acc	21 00 ec 	! . . 
	jr l3ad4h		;3acf	18 03 	. . 
l3ad1h:
	ld hl,0f000h		;3ad1	21 00 f0 	! . . 
l3ad4h:
	add hl,de			;3ad4	19 	. 
	jr nc,l3adbh		;3ad5	30 04 	0 . 
	set 3,(ix+000h)		;3ad7	dd cb 00 de 	. . . . 
l3adbh:
	ld (ix+00ch),e		;3adb	dd 73 0c 	. s . 
	ld (ix+00dh),d		;3ade	dd 72 0d 	. r . 
	pop hl			;3ae1	e1 	. 
	add hl,de			;3ae2	19 	. 
	ex de,hl			;3ae3	eb 	. 
l3ae4h:
	ld l,(ix+008h)		;3ae4	dd 6e 08 	. n . 
	ld h,(ix+009h)		;3ae7	dd 66 09 	. f . 
	add hl,de			;3aea	19 	. 
	ld (ix+004h),l		;3aeb	dd 75 04 	. u . 
	ld (ix+005h),h		;3aee	dd 74 05 	. t . 
	jp l3c7ah		;3af1	c3 7a 3c 	. z < 
l3af4h:
	call sub_3d22h		;3af4	cd 22 3d 	. " = 
	push de			;3af7	d5 	. 
	ld de,(0e504h)		;3af8	ed 5b 04 e5 	. [ . . 
	ld l,(ix+00ch)		;3afc	dd 6e 0c 	. n . 
	ld h,(ix+00dh)		;3aff	dd 66 0d 	. f . 
	bit 3,c		;3b02	cb 59 	. Y 
	jr z,l3b0ah		;3b04	28 04 	( . 
	sbc hl,de		;3b06	ed 52 	. R 
	jr l3b0bh		;3b08	18 01 	. . 
l3b0ah:
	add hl,de			;3b0a	19 	. 
l3b0bh:
	jr nc,l3b14h		;3b0b	30 07 	0 . 
	ld (ix+001h),000h		;3b0d	dd 36 01 00 	. 6 . . 
	ld hl,0		;3b11	21 00 00 	! . . 
l3b14h:
	ld (ix+00ch),l		;3b14	dd 75 0c 	. u . 
	ld (ix+00dh),h		;3b17	dd 74 0d 	. t . 
	pop de			;3b1a	d1 	. 
	add hl,de			;3b1b	19 	. 
	ex de,hl			;3b1c	eb 	. 
	jr l3ae4h		;3b1d	18 c5 	. . 
l3b1fh:
	ld l,(ix+00eh)		;3b1f	dd 6e 0e 	. n . 
	ld h,(ix+00fh)		;3b22	dd 66 0f 	. f . 
	dec (ix+007h)		;3b25	dd 35 07 	. 5 . 
	jr nz,l3b33h		;3b28	20 09 	  . 
	ld de,5				;3b2a	11 05 00 	. . . 
	add hl,de			;3b2d	19 	. 
	call sub_3bd5h		;3b2e	cd d5 3b 	. . ; 
	jr z,l3b57h		;3b31	28 24 	( $ 
l3b33h:
	ld a,(hl)			;3b33	7e 	~ 
	add a,(ix+002h)		;3b34	dd 86 02 	. . . 
	ld (ix+002h),a		;3b37	dd 77 02 	. w . 
	inc hl			;3b3a	23 	# 
	ld a,(hl)			;3b3b	7e 	~ 
	adc a,(ix+003h)		;3b3c	dd 8e 03 	. . . 
	ld (ix+003h),a		;3b3f	dd 77 03 	. w . 
	inc hl			;3b42	23 	# 
	ld a,(hl)			;3b43	7e 	~ 
	add a,(ix+004h)		;3b44	dd 86 04 	. . . 
	ld (ix+004h),a		;3b47	dd 77 04 	. w . 
	inc hl			;3b4a	23 	# 
	ld a,(hl)			;3b4b	7e 	~ 
	adc a,(ix+005h)		;3b4c	dd 8e 05 	. . . 
	ld (ix+005h),a		;3b4f	dd 77 05 	. w . 
	inc hl			;3b52	23 	# 
	ld c,(hl)			;3b53	4e 	N 
	jp l3c7ah		;3b54	c3 7a 3c 	. z < 
l3b57h:
	ld (ix+00ah),000h		;3b57	dd 36 0a 00 	. 6 . . 
	ld (ix+006h),000h		;3b5b	dd 36 06 00 	. 6 . . 
	ld (ix+007h),005h		;3b5f	dd 36 07 05 	. 6 . . 
	ld l,(ix+004h)		;3b63	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3b66	dd 66 05 	. f . 
	ld e,(ix+008h)		;3b69	dd 5e 08 	. ^ . 
	ld d,(ix+009h)		;3b6c	dd 56 09 	. V . 
	sbc hl,de		;3b6f	ed 52 	. R 
	ld (ix+00ch),l		;3b71	dd 75 0c 	. u . 
	ld (ix+00dh),h		;3b74	dd 74 0d 	. t . 
	ld a,(ix+001h)		;3b77	dd 7e 01 	. ~ . 
	sub 008h		;3b7a	d6 08 	. . 
	jr nz,l3b8ch		;3b7c	20 0e 	  . 
	ld a,003h		;3b7e	3e 03 	> . 
	res 3,(ix+000h)		;3b80	dd cb 00 9e 	. . . . 
	bit 7,h		;3b84	cb 7c 	. | 
	jr nz,l3b8ch		;3b86	20 04 	  . 
	set 3,(ix+000h)		;3b88	dd cb 00 de 	. . . . 
l3b8ch:
	ld (ix+001h),a		;3b8c	dd 77 01 	. w . 
	jp l3c7ah		;3b8f	c3 7a 3c 	. z < 
l3b92h:
	res 0,(ix+014h)		;3b92	dd cb 14 86 	. . . . 
	bit 6,(ix+000h)		;3b96	dd cb 00 76 	. . . v 
	ld hl,l3e7fh		;3b9a	21 7f 3e 	!  > 
	res 6,(ix+000h)		;3b9d	dd cb 00 b6 	. . . . 
	jr nz,l3baah		;3ba1	20 07 	  . 
	set 6,(ix+000h)		;3ba3	dd cb 00 f6 	. . . . 
	ld hl,l3eabh		;3ba7	21 ab 3e 	! . > 
l3baah:
	push hl			;3baa	e5 	. 
	ld l,(ix+004h)		;3bab	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3bae	dd 66 05 	. f . 
	ld de,09800h		;3bb1	11 00 98 	. . . 
	add hl,de			;3bb4	19 	. 
	pop hl			;3bb5	e1 	. 
	jr nc,l3bbch		;3bb6	30 04 	0 . 
	ld de,l0016h		;3bb8	11 16 00 	. . . 
	add hl,de			;3bbb	19 	. 
l3bbch:
	call sub_3bd5h		;3bbc	cd d5 3b 	. . ; 
	ld de,4				;3bbf	11 04 00 	. . . 
	add hl,de			;3bc2	19 	. 
	ld c,(hl)			;3bc3	4e 	N 
	ld a,(ix+001h)		;3bc4	dd 7e 01 	. ~ . 
	add a,008h		;3bc7	c6 08 	. . 
	cp 00bh		;3bc9	fe 0b 	. . 
	jr nz,l3bcfh		;3bcb	20 02 	  . 
	ld a,008h		;3bcd	3e 08 	> . 
l3bcfh:
	ld (ix+001h),a		;3bcf	dd 77 01 	. w . 
	jp l3c7ah		;3bd2	c3 7a 3c 	. z < 
sub_3bd5h:
	ld a,(hl)			;3bd5	7e 	~ 
	cp 0ffh		;3bd6	fe ff 	. . 
	ret z			;3bd8	c8 	. 
	ld (ix+007h),a		;3bd9	dd 77 07 	. w . 
	inc hl			;3bdc	23 	# 
	ld a,(hl)			;3bdd	7e 	~ 
	ld (ix+006h),a		;3bde	dd 77 06 	. w . 
	inc hl			;3be1	23 	# 
	ld (ix+00eh),l		;3be2	dd 75 0e 	. u . 
	ld (ix+00fh),h		;3be5	dd 74 0f 	. t . 
	ret			;3be8	c9 	. 
l3be9h:
	dec (ix+007h)		;3be9	dd 35 07 	. 5 . 
	jp nz,l3ca9h		;3bec	c2 a9 3c 	. . < 
	ld a,(ix+006h)		;3bef	dd 7e 06 	. ~ . 
	cp 009h		;3bf2	fe 09 	. . 
	jr z,l3c00h		;3bf4	28 0a 	( . 
	ld (ix+007h),005h		;3bf6	dd 36 07 05 	. 6 . . 
	inc (ix+006h)		;3bfa	dd 34 06 	. 4 . 
	jp l3ca9h		;3bfd	c3 a9 3c 	. . < 
l3c00h:
	ld a,(ix+00eh)		;3c00	dd 7e 0e 	. ~ . 
	and a			;3c03	a7 	. 
	jp z,l3cf2h		;3c04	ca f2 3c 	. . < 
	call sub_3cbah		;3c07	cd ba 3c 	. . < 
	jp l3cf2h		;3c0a	c3 f2 3c 	. . < 
l3c0dh:
	ld a,086h		;3c0d	3e 86 	> . 
	call sub_0dfeh		;3c0f	cd fe 0d 	. . . 
	ld a,(0e701h)		;3c12	3a 01 e7 	: . . 
	and 001h		;3c15	e6 01 	. . 
	ld a,083h		;3c17	3e 83 	> . 
	jr nz,l3c2ah		;3c19	20 0f 	  . 
	inc a			;3c1b	3c 	< 
	jr l3c2ah		;3c1c	18 0c 	. . 
l3c1eh:
	ld de,00115h		;3c1e	11 15 01 	. . . 
	call sub_2ee2h		;3c21	cd e2 2e 	. . . 
	ld a,094h		;3c24	3e 94 	> . 
	call sub_0dfeh		;3c26	cd fe 0d 	. . . 
	xor a			;3c29	af 	. 
l3c2ah:
	ld (ix+00eh),a		;3c2a	dd 77 0e 	. w . 
	ld (ix+007h),005h		;3c2d	dd 36 07 05 	. 6 . . 
	ld (ix+006h),007h		;3c31	dd 36 06 07 	. 6 . . 
	ld (ix+001h),007h		;3c35	dd 36 01 07 	. 6 . . 
	jr l3ca9h		;3c39	18 6e 	. n 
l3c3bh:
	dec (ix+007h)		;3c3b	dd 35 07 	. 5 . 
	jr z,l3c66h		;3c3e	28 26 	( & 
	ld a,(0eb00h)		;3c40	3a 00 eb 	: . . 
	push af			;3c43	f5 	. 
	ld a,001h		;3c44	3e 01 	> . 
	ld (0eb00h),a		;3c46	32 00 eb 	2 . . 
	ld hl,(0eb01h)		;3c49	2a 01 eb 	* . . 
	push hl			;3c4c	e5 	. 
	ld hl,(0eb03h)		;3c4d	2a 03 eb 	* . . 
	ld de,0fff8h		;3c50	11 f8 ff 	. . . 
	add hl,de			;3c53	19 	. 
	ld (0eb01h),hl		;3c54	22 01 eb 	" . . 
	ld (0eb03h),hl		;3c57	22 03 eb 	" . . 
	call l3ca9h		;3c5a	cd a9 3c 	. . < 
	pop hl			;3c5d	e1 	. 
	ld (0eb01h),hl		;3c5e	22 01 eb 	" . . 
	pop af			;3c61	f1 	. 
	ld (0eb00h),a		;3c62	32 00 eb 	2 . . 
	ret			;3c65	c9 	. 
l3c66h:
	ld (ix+006h),000h		;3c66	dd 36 06 00 	. 6 . . 
	ld (ix+007h),005h		;3c6a	dd 36 07 05 	. 6 . . 
	ld a,(ix+001h)		;3c6e	dd 7e 01 	. ~ . 
	sub 004h		;3c71	d6 04 	. . 
	jr nz,l3c77h		;3c73	20 02 	  . 
	ld a,003h		;3c75	3e 03 	> . 
l3c77h:
	ld (ix+001h),a		;3c77	dd 77 01 	. w . 
l3c7ah:
	call sub_3ccfh		;3c7a	cd cf 3c 	. . < 
	jp c,l3c0dh		;3c7d	da 0d 3c 	. . < 
	ld e,(ix+002h)		;3c80	dd 5e 02 	. ^ . 
	ld d,(ix+003h)		;3c83	dd 56 03 	. V . 
	ld hl,0ffc0h		;3c86	21 c0 ff 	! . . 
	add hl,de			;3c89	19 	. 
	ld (0e80fh),hl		;3c8a	22 0f e8 	" . . 
	ld hl,l0080h		;3c8d	21 80 00 	! . . 
	add hl,de			;3c90	19 	. 
	ld (0e811h),hl		;3c91	22 11 e8 	" . . 
	ld l,(ix+004h)		;3c94	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3c97	dd 66 05 	. f . 
	ld de,00200h		;3c9a	11 00 02 	. . . 
	add hl,de			;3c9d	19 	. 
	ld de,0006h		;3c9e	11 06 00 	. . . 
	push hl			;3ca1	e5 	. 
	call sub_1172h		;3ca2	cd 72 11 	. r . 
	pop hl			;3ca5	e1 	. 
	jp c,l3c1eh		;3ca6	da 1e 3c 	. . < 
l3ca9h:
	call l1be2h		;3ca9	cd e2 1b 	. . . 
	ld de,0e400h		;3cac	11 00 e4 	. . . 
	add hl,de			;3caf	19 	. 
	ret c			;3cb0	d8 	. 
	ld hl,075c0h		;3cb1	21 c0 75 	! . u 
	ld a,c			;3cb4	79 	y 
	xor 040h		;3cb5	ee 40 	. @ 
	jp l1a80h		;3cb7	c3 80 1a 	. . . 
sub_3cbah:
	ld l,(ix+004h)		;3cba	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3cbd	dd 66 05 	. f . 
	add hl,hl			;3cc0	29 	) 
	ld d,000h		;3cc1	16 00 	. . 
	rl d		;3cc3	cb 12 	. . 
	ld e,h			;3cc5	5c 	\ 
	ld l,(ix+002h)		;3cc6	dd 6e 02 	. n . 
	ld h,(ix+003h)		;3cc9	dd 66 03 	. f . 
	jp sub_2f60h		;3ccc	c3 60 2f 	. ` / 
sub_3ccfh:
	ld hl,l0140h		;3ccf	21 40 01 	! @ . 
	call sub_1220h		;3cd2	cd 20 12 	.   . 
	ret nc			;3cd5	d0 	. 
	ld hl,l017fh+1		;3cd6	21 80 01 	! . . 
	add hl,de			;3cd9	19 	. 
	ex de,hl			;3cda	eb 	. 
	ld l,(ix+004h)		;3cdb	dd 6e 04 	. n . 
	ld h,(ix+005h)		;3cde	dd 66 05 	. f . 
	sbc hl,de		;3ce1	ed 52 	. R 
	ret nc			;3ce3	d0 	. 
	ld hl,0f380h		;3ce4	21 80 f3 	! . . 
	add hl,de			;3ce7	19 	. 
	ld e,(ix+004h)		;3ce8	dd 5e 04 	. ^ . 
	ld d,(ix+005h)		;3ceb	dd 56 05 	. V . 
	and a			;3cee	a7 	. 
	sbc hl,de		;3cef	ed 52 	. R 
	ret			;3cf1	c9 	. 
l3cf2h:
	ld hl,0e576h		;3cf2	21 76 e5 	! v . 
	dec (hl)			;3cf5	35 	5 
	ld (ix+000h),000h		;3cf6	dd 36 00 00 	. 6 . . 
	ret			;3cfa	c9 	. 
l3cfbh:
	ld hl,0e576h		;3cfb	21 76 e5 	! v . 
	dec (hl)			;3cfe	35 	5 
	bit 6,(ix+000h)		;3cff	dd cb 00 76 	. . . v 
	ld (ix+000h),000h		;3d03	dd 36 00 00 	. 6 . . 
	jr nz,sub_3d0eh		;3d07	20 05 	  . 
sub_3d09h:
	ld hl,0e520h		;3d09	21 20 e5 	!   . 
	jr l3d11h		;3d0c	18 03 	. . 
sub_3d0eh:
	ld hl,0e549h		;3d0e	21 49 e5 	! I . 
l3d11h:
	ld a,(hl)			;3d11	7e 	~ 
	cp 014h		;3d12	fe 14 	. . 
	ret z			;3d14	c8 	. 
	inc (hl)			;3d15	34 	4 
	inc hl			;3d16	23 	# 
	push bc			;3d17	c5 	. 
	rlca			;3d18	07 	. 
	ld b,000h		;3d19	06 00 	. . 
	ld c,a			;3d1b	4f 	O 
	add hl,bc			;3d1c	09 	. 
	ld (hl),e			;3d1d	73 	s 
	inc hl			;3d1e	23 	# 
	ld (hl),d			;3d1f	72 	r 
	pop bc			;3d20	c1 	. 
	ret			;3d21	c9 	. 
sub_3d22h:
	ld l,(ix+00ah)		;3d22	dd 6e 0a 	. n . 
	ld h,(ix+00bh)		;3d25	dd 66 0b 	. f . 
	ld de,(0e508h)		;3d28	ed 5b 08 e5 	. [ . . 
	bit 2,(ix+000h)		;3d2c	dd cb 00 56 	. . . V 
	jr z,l3d40h		;3d30	28 0e 	( . 
	sbc hl,de		;3d32	ed 52 	. R 
	ex de,hl			;3d34	eb 	. 
	jr nc,l3d4ch		;3d35	30 15 	0 . 
	res 2,(ix+000h)		;3d37	dd cb 00 96 	. . . . 
	ld de,0		;3d3b	11 00 00 	. . . 
	jr l3d4ch		;3d3e	18 0c 	. . 
l3d40h:
	add hl,de			;3d40	19 	. 
	ex de,hl			;3d41	eb 	. 
	ld hl,0fc00h		;3d42	21 00 fc 	! . . 
	add hl,de			;3d45	19 	. 
	jr nc,l3d4ch		;3d46	30 04 	0 . 
	set 2,(ix+000h)		;3d48	dd cb 00 d6 	. . . . 
l3d4ch:
	ld (ix+00ah),e		;3d4c	dd 73 0a 	. s . 
	ld (ix+00bh),d		;3d4f	dd 72 0b 	. r . 
	ret			;3d52	c9 	. 
l3d53h:
	ld c,000h		;3d53	0e 00 	. . 
sub_3d55h:
	ld b,010h		;3d55	06 10 	. . 
	jr l3d5bh		;3d57	18 02 	. . 
sub_3d59h:
	ld b,050h		;3d59	06 50 	. P 
l3d5bh:
	ld hl,0e576h		;3d5b	21 76 e5 	! v . 
	ld a,(0e50bh)		;3d5e	3a 0b e5 	: . . 
	cp (hl)			;3d61	be 	. 
	ret c			;3d62	d8 	. 
	inc (hl)			;3d63	34 	4 
	ld iy,0e562h		;3d64	fd 21 62 e5 	. ! b . 
	ld de,l0013h+2		;3d68	11 15 00 	. . . 
l3d6bh:
	add iy,de		;3d6b	fd 19 	. . 
	bit 4,(iy+000h)		;3d6d	fd cb 00 66 	. . . f 
	jr nz,l3d6bh		;3d71	20 f8 	  . 
	ld a,r		;3d73	ed 5f 	. _ 
	and 00ch		;3d75	e6 0c 	. . 
	or b			;3d77	b0 	. 
	ld (iy+000h),a		;3d78	fd 77 00 	. w . 
	ld hl,(0e712h)		;3d7b	2a 12 e7 	* . . 
	ld de,l1080h		;3d7e	11 80 10 	. . . 
	bit 0,c		;3d81	cb 41 	. A 
	jr z,l3d89h		;3d83	28 04 	( . 
	sbc hl,de		;3d85	ed 52 	. R 
	jr l3d93h		;3d87	18 0a 	. . 
l3d89h:
	add hl,de			;3d89	19 	. 
	ld de,l2080h		;3d8a	11 80 20 	. .   
	sbc hl,de		;3d8d	ed 52 	. R 
	add hl,de			;3d8f	19 	. 
	jr nc,l3d93h		;3d90	30 01 	0 . 
	ex de,hl			;3d92	eb 	. 
l3d93h:
	ld (iy+002h),l		;3d93	fd 75 02 	. u . 
	ld (iy+003h),h		;3d96	fd 74 03 	. t . 
	ld (iy+007h),005h		;3d99	fd 36 07 05 	. 6 . . 
	ld (iy+006h),000h		;3d9d	fd 36 06 00 	. 6 . . 
	call sub_3dc5h		;3da1	cd c5 3d 	. . = 
	ld a,(iy+001h)		;3da4	fd 7e 01 	. ~ . 
	cp 001h		;3da7	fe 01 	. . 
	ret c			;3da9	d8 	. 
	ld hl,l3e5fh		;3daa	21 5f 3e 	! _ > 
	jr z,l3db2h		;3dad	28 03 	( . 
	ld hl,03e6fh		;3daf	21 6f 3e 	! o > 
l3db2h:
	ld a,(0e010h)		;3db2	3a 10 e0 	: . . 
	and 00eh		;3db5	e6 0e 	. . 
	ld d,000h		;3db7	16 00 	. . 
	ld e,a			;3db9	5f 	_ 
	add hl,de			;3dba	19 	. 
	ld a,(hl)			;3dbb	7e 	~ 
	ld (iy+00ch),a		;3dbc	fd 77 0c 	. w . 
	inc hl			;3dbf	23 	# 
	ld a,(hl)			;3dc0	7e 	~ 
	ld (iy+00dh),a		;3dc1	fd 77 0d 	. w . 
	ret			;3dc4	c9 	. 
sub_3dc5h:
	ld hl,0e649h		;3dc5	21 49 e6 	! I . 
	ld a,(hl)			;3dc8	7e 	~ 
	and a			;3dc9	a7 	. 
	jr nz,l3ddbh		;3dca	20 0f 	  . 
	ld (hl),003h		;3dcc	36 03 	6 . 
	ld a,r		;3dce	ed 5f 	. _ 
	and 01ch		;3dd0	e6 1c 	. . 
	ld hl,l3e1fh		;3dd2	21 1f 3e 	! . > 
	ld d,000h		;3dd5	16 00 	. . 
	ld e,a			;3dd7	5f 	_ 
	add hl,de			;3dd8	19 	. 
	jr l3ddfh		;3dd9	18 04 	. . 
l3ddbh:
	dec (hl)			;3ddb	35 	5 
	ld hl,(0e64ah)		;3ddc	2a 4a e6 	* J . 
l3ddfh:
	ld a,(hl)			;3ddf	7e 	~ 
	inc hl			;3de0	23 	# 
	ld (0e64ah),hl		;3de1	22 4a e6 	" J . 
	ld (iy+001h),a		;3de4	fd 77 01 	. w . 
	ld (iy+014h),000h		;3de7	fd 36 14 00 	. 6 . . 
	ld hl,l3e3fh		;3deb	21 3f 3e 	! ? > 
	and a			;3dee	a7 	. 
	jr z,l3df4h		;3def	28 03 	( . 
	ld hl,l3e4fh		;3df1	21 4f 3e 	! O > 
l3df4h:
	ld a,r		;3df4	ed 5f 	. _ 
	and 00eh		;3df6	e6 0e 	. . 
	ld d,000h		;3df8	16 00 	. . 
	ld e,a			;3dfa	5f 	_ 
	add hl,de			;3dfb	19 	. 
	ld e,(hl)			;3dfc	5e 	^ 
	inc hl			;3dfd	23 	# 
	ld d,(hl)			;3dfe	56 	V 
	ld (iy+008h),e		;3dff	fd 73 08 	. s . 
	ld (iy+009h),d		;3e02	fd 72 09 	. r . 
	ld (iy+00bh),002h		;3e05	fd 36 0b 02 	. 6 . . 
	ld a,(0e011h)		;3e09	3a 11 e0 	: . . 
	ld hl,0e50ch		;3e0c	21 0c e5 	! . . 
	cp (hl)			;3e0f	be 	. 
	ld hl,(0e500h)		;3e10	2a 00 e5 	* . . 
	jr c,l3e18h		;3e13	38 03 	8 . 
	ld hl,(0e502h)		;3e15	2a 02 e5 	* . . 
l3e18h:
	ld (iy+010h),l		;3e18	fd 75 10 	. u . 
	ld (iy+011h),h		;3e1b	fd 74 11 	. t . 
	ret			;3e1e	c9 	. 
l3e1fh:
	ld (bc),a			;3e1f	02 	. 
	nop			;3e20	00 	. 
	ld bc,l0100h		;3e21	01 00 01 	. . . 
	ld (bc),a			;3e24	02 	. 
	nop			;3e25	00 	. 
	nop			;3e26	00 	. 
	nop			;3e27	00 	. 
	nop			;3e28	00 	. 
	ld (bc),a			;3e29	02 	. 
	ld bc,l0100h		;3e2a	01 00 01 	. . . 
	nop			;3e2d	00 	. 
	ld (bc),a			;3e2e	02 	. 
	ld (bc),a			;3e2f	02 	. 
	nop			;3e30	00 	. 
	nop			;3e31	00 	. 
	ld bc,00200h		;3e32	01 00 02 	. . . 
	ld bc,0		;3e35	01 00 00 	. . . 
	ld bc,0002h			;3e38	01 02 00 	. . . 
	ld bc,0		;3e3b	01 00 00 	. . . 
	ld (bc),a			;3e3e	02 	. 
l3e3fh:
	nop			;3e3f	00 	. 
	ld d,b			;3e40	50 	P 
	add a,b			;3e41	80 	. 
	ld d,h			;3e42	54 	T 
	nop			;3e43	00 	. 
	ld e,c			;3e44	59 	Y 
	add a,b			;3e45	80 	. 
	ld e,l			;3e46	5d 	] 
	nop			;3e47	00 	. 
	ld h,d			;3e48	62 	b 
	add a,b			;3e49	80 	. 
	ld h,(hl)			;3e4a	66 	f 
	nop			;3e4b	00 	. 
	ld l,e			;3e4c	6b 	k 
	add a,b			;3e4d	80 	. 
	ld l,a			;3e4e	6f 	o 
l3e4fh:
	nop			;3e4f	00 	. 
	ld c,(hl)			;3e50	4e 	N 
	add a,b			;3e51	80 	. 
	ld d,c			;3e52	51 	Q 
	nop			;3e53	00 	. 
	ld d,l			;3e54	55 	U 
	add a,b			;3e55	80 	. 
	ld e,b			;3e56	58 	X 
	nop			;3e57	00 	. 
	ld e,h			;3e58	5c 	\ 
	add a,b			;3e59	80 	. 
	ld e,a			;3e5a	5f 	_ 
	nop			;3e5b	00 	. 
	ld h,e			;3e5c	63 	c 
	add a,b			;3e5d	80 	. 
	ld h,(hl)			;3e5e	66 	f 
l3e5fh:
	nop			;3e5f	00 	. 
	nop			;3e60	00 	. 
	add a,b			;3e61	80 	. 
	ld (bc),a			;3e62	02 	. 
	nop			;3e63	00 	. 
	dec b			;3e64	05 	. 
	nop			;3e65	00 	. 
	rlca			;3e66	07 	. 
	add a,b			;3e67	80 	. 
	add hl,bc			;3e68	09 	. 
	add a,b			;3e69	80 	. 
	dec bc			;3e6a	0b 	. 
	nop			;3e6b	00 	. 
	ld c,000h		;3e6c	0e 00 	. . 
	djnz l3e70h		;3e6e	10 00 	. . 
l3e70h:
	nop			;3e70	00 	. 
	nop			;3e71	00 	. 
	inc bc			;3e72	03 	. 
	nop			;3e73	00 	. 
	ld b,080h		;3e74	06 80 	. . 
	ex af,af'			;3e76	08 	. 
	add a,b			;3e77	80 	. 
	dec bc			;3e78	0b 	. 
	nop			;3e79	00 	. 
	ld c,000h		;3e7a	0e 00 	. . 
	inc c			;3e7c	0c 	. 
	nop			;3e7d	00 	. 
	inc d			;3e7e	14 	. 
l3e7fh:
	ld (de),a			;3e7f	12 	. 
	ld (bc),a			;3e80	02 	. 
	ld hl,(04700h)		;3e81	2a 00 47 	* . G 
	nop			;3e84	00 	. 
	ld b,b			;3e85	40 	@ 
	ld (de),a			;3e86	12 	. 
	inc bc			;3e87	03 	. 
	nop			;3e88	00 	. 
	nop			;3e89	00 	. 
	adc a,(hl)			;3e8a	8e 	. 
	nop			;3e8b	00 	. 
	ld b,b			;3e8c	40 	@ 
	ld (de),a			;3e8d	12 	. 
	ld (bc),a			;3e8e	02 	. 
	sub 0ffh		;3e8f	d6 ff 	. . 
	ld b,a			;3e91	47 	G 
	nop			;3e92	00 	. 
	nop			;3e93	00 	. 
	rst 38h			;3e94	ff 	. 
	ld (de),a			;3e95	12 	. 
	inc b			;3e96	04 	. 
	ld hl,(0b900h)		;3e97	2a 00 b9 	* . . 
	rst 38h			;3e9a	ff 	. 
	ret nz			;3e9b	c0 	. 
	ld (de),a			;3e9c	12 	. 
	dec b			;3e9d	05 	. 
	nop			;3e9e	00 	. 
	nop			;3e9f	00 	. 
	ld (hl),d			;3ea0	72 	r 
	rst 38h			;3ea1	ff 	. 
	ret nz			;3ea2	c0 	. 
	ld (de),a			;3ea3	12 	. 
	inc b			;3ea4	04 	. 
	sub 0ffh		;3ea5	d6 ff 	. . 
	cp c			;3ea7	b9 	. 
	rst 38h			;3ea8	ff 	. 
	add a,b			;3ea9	80 	. 
	rst 38h			;3eaa	ff 	. 
l3eabh:
	ld (de),a			;3eab	12 	. 
	ld (bc),a			;3eac	02 	. 
	sub 0ffh		;3ead	d6 ff 	. . 
	ld b,a			;3eaf	47 	G 
	nop			;3eb0	00 	. 
	nop			;3eb1	00 	. 
	ld (de),a			;3eb2	12 	. 
	inc bc			;3eb3	03 	. 
	nop			;3eb4	00 	. 
	nop			;3eb5	00 	. 
	adc a,(hl)			;3eb6	8e 	. 
	nop			;3eb7	00 	. 
	nop			;3eb8	00 	. 
	ld (de),a			;3eb9	12 	. 
	ld (bc),a			;3eba	02 	. 
	ld hl,(04700h)		;3ebb	2a 00 47 	* . G 
	nop			;3ebe	00 	. 
	ld b,b			;3ebf	40 	@ 
	rst 38h			;3ec0	ff 	. 
	ld (de),a			;3ec1	12 	. 
	inc b			;3ec2	04 	. 
	sub 0ffh		;3ec3	d6 ff 	. . 
	cp c			;3ec5	b9 	. 
	rst 38h			;3ec6	ff 	. 
	add a,b			;3ec7	80 	. 
	ld (de),a			;3ec8	12 	. 
	dec b			;3ec9	05 	. 
	nop			;3eca	00 	. 
	nop			;3ecb	00 	. 
	ld (hl),d			;3ecc	72 	r 
	rst 38h			;3ecd	ff 	. 
	add a,b			;3ece	80 	. 
	ld (de),a			;3ecf	12 	. 
	inc b			;3ed0	04 	. 
	ld hl,(0b900h)		;3ed1	2a 00 b9 	* . . 
	rst 38h			;3ed4	ff 	. 
	ret nz			;3ed5	c0 	. 
	rst 38h			;3ed6	ff 	. 
	; 3ed7. The ROM finishes with 297 bytes of value 0c7h
	defs 297, 0c7h
