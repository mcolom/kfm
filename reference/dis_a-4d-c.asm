; z80dasm 1.1.4
; command line: z80dasm -g0x4000 -lt roms/a-4d-c.bin

	org	04000h

l4000h:
	ld hl,(0e712h)		;4000	2a 12 e7 	* . . 
	ld de,(0e707h)		;4003	ed 5b 07 e7 	. [ . . 
	ld a,(0e080h)		;4007	3a 80 e0 	: . . 
	and 001h		;400a	e6 01 	. . 
	jr z,l400fh		;400c	28 01 	( . 
	ex de,hl			;400e	eb 	. 
l400fh:
	sbc hl,de		;400f	ed 52 	. R 
	ld a,001h		;4011	3e 01 	> . 
	jr nc,l4017h		;4013	30 02 	0 . 
	ld a,000h		;4015	3e 00 	> . 
l4017h:
	ld (0e702h),a		;4017	32 02 e7 	2 . . 
	jr c,l402ch		;401a	38 10 	8 . 
	ld hl,0e703h		;401c	21 03 e7 	! . . 
	ld a,(hl)			;401f	7e 	~ 
	dec (hl)			;4020	35 	5 
	and a			;4021	a7 	. 
	jr nz,l402ch		;4022	20 08 	  . 
	call sub_433fh		;4024	cd 3f 43 	. ? C 
	ld a,090h		;4027	3e 90 	> . 
	call 00dfeh		;4029	cd fe 0d 	. . . 
l402ch:
	ld hl,(0e712h)		;402c	2a 12 e7 	* . . 
	ld a,(0e71ah)		;402f	3a 1a e7 	: . . 
	and a			;4032	a7 	. 
	jp nz,l40adh		;4033	c2 ad 40 	. . @ 
	ld a,(0e000h)		;4036	3a 00 e0 	: . . 
	cp 003h		;4039	fe 03 	. . 
	jr z,l40adh		;403b	28 70 	( p 
	ld a,(0e702h)		;403d	3a 02 e7 	: . . 
	cp 00bh		;4040	fe 0b 	. . 
	jr z,l40adh		;4042	28 69 	( i 
	jr nc,l4080h		;4044	30 3a 	0 : 
	cp 009h		;4046	fe 09 	. . 
	jr nc,l4055h		;4048	30 0b 	0 . 
	cp 001h		;404a	fe 01 	. . 
	jr nz,l40adh		;404c	20 5f 	  _ 
	ld a,(0e706h)		;404e	3a 06 e7 	: . . 
	cp 004h		;4051	fe 04 	. . 
	jr z,l40adh		;4053	28 58 	( X 
l4055h:
	ld a,(0e700h)		;4055	3a 00 e7 	: . . 
	bit 5,a		;4058	cb 6f 	. o 
	ld a,(0e701h)		;405a	3a 01 e7 	: . . 
	ld de,00029h		;405d	11 29 00 	. ) . 
	jr z,l4089h		;4060	28 27 	( ' 
	and 020h		;4062	e6 20 	.   
	jr nz,l40adh		;4064	20 47 	  G 
	add hl,de			;4066	19 	. 
	ld de,0db00h		;4067	11 00 db 	. . . 
	sbc hl,de		;406a	ed 52 	. R 
	add hl,de			;406c	19 	. 
	jr c,l4070h		;406d	38 01 	8 . 
	ex de,hl			;406f	eb 	. 
l4070h:
	push hl			;4070	e5 	. 
	ld a,h			;4071	7c 	| 
	sub 00fh		;4072	d6 0f 	. . 
	ld hl,0e714h		;4074	21 14 e7 	! . . 
	cp (hl)			;4077	be 	. 
	jr nz,l40a9h		;4078	20 2f 	  / 
	inc (hl)			;407a	34 	4 
	ld a,(hl)			;407b	7e 	~ 
	add a,01fh		;407c	c6 1f 	. . 
	jr l40a6h		;407e	18 26 	. & 
l4080h:
	ld a,(0e700h)		;4080	3a 00 e7 	: . . 
	and 020h		;4083	e6 20 	.   
	jr nz,l4098h		;4085	20 11 	  . 
	jr l4070h		;4087	18 e7 	. . 
l4089h:
	and 010h		;4089	e6 10 	. . 
	jr nz,l40adh		;408b	20 20 	    
	sbc hl,de		;408d	ed 52 	. R 
	ld de,00400h		;408f	11 00 04 	. . . 
	sbc hl,de		;4092	ed 52 	. R 
	add hl,de			;4094	19 	. 
	jr nc,l4098h		;4095	30 01 	0 . 
	ex de,hl			;4097	eb 	. 
l4098h:
	push hl			;4098	e5 	. 
	ld a,010h		;4099	3e 10 	> . 
	add a,h			;409b	84 	. 
	ld hl,0e714h		;409c	21 14 e7 	! . . 
	cp (hl)			;409f	be 	. 
	jr nz,l40a9h		;40a0	20 07 	  . 
	dec (hl)			;40a2	35 	5 
	ld a,(hl)			;40a3	7e 	~ 
	add a,0e0h		;40a4	c6 e0 	. . 
l40a6h:
	call sub_5765h		;40a6	cd 65 57 	. e W 
l40a9h:
	pop hl			;40a9	e1 	. 
	ld (0e712h),hl		;40aa	22 12 e7 	" . . 
l40adh:
	xor a			;40ad	af 	. 
	add hl,hl			;40ae	29 	) 
	rla			;40af	17 	. 
	add hl,hl			;40b0	29 	) 
	rla			;40b1	17 	. 
	add hl,hl			;40b2	29 	) 
	rla			;40b3	17 	. 
	ld l,h			;40b4	6c 	l 
	ld h,a			;40b5	67 	g 
	ld de,00080h		;40b6	11 80 00 	. . . 
	sbc hl,de		;40b9	ed 52 	. R 
	jr c,l40ceh		;40bb	38 11 	8 . 
	add hl,de			;40bd	19 	. 
	ld de,00680h		;40be	11 80 06 	. . . 
	sbc hl,de		;40c1	ed 52 	. R 
	jr nc,l40ceh		;40c3	30 09 	0 . 
	add hl,de			;40c5	19 	. 
	ld (0e900h),hl		;40c6	22 00 e9 	" . . 
	ld hl,00100h		;40c9	21 00 01 	! . . 
	jr l40d6h		;40cc	18 08 	. . 
l40ceh:
	ld (0e900h),de		;40ce	ed 53 00 e9 	. S . . 
	ld de,00100h		;40d2	11 00 01 	. . . 
	add hl,de			;40d5	19 	. 
l40d6h:
	ld (0e715h),hl		;40d6	22 15 e7 	" . . 
	xor a			;40d9	af 	. 
	ld hl,(0e710h)		;40da	2a 10 e7 	* . . 
	add hl,hl			;40dd	29 	) 
	rla			;40de	17 	. 
	ld l,h			;40df	6c 	l 
	ld h,a			;40e0	67 	g 
	ld (0e717h),hl		;40e1	22 17 e7 	" . . 
	ret			;40e4	c9 	. 
sub_40e5h:
	ld hl,(0e717h)		;40e5	2a 17 e7 	* . . 
	ld (0e807h),hl		;40e8	22 07 e8 	" . . 
	ld a,(0e706h)		;40eb	3a 06 e7 	: . . 
	add a,a			;40ee	87 	. 
	ld hl,l65ffh		;40ef	21 ff 65 	! . e 
	ld b,000h		;40f2	06 00 	. . 
	ld c,a			;40f4	4f 	O 
	add hl,bc			;40f5	09 	. 
	ld a,(hl)			;40f6	7e 	~ 
	inc hl			;40f7	23 	# 
	ld h,(hl)			;40f8	66 	f 
	ld l,a			;40f9	6f 	o 
	ld a,(0e701h)		;40fa	3a 01 e7 	: . . 
	and 040h		;40fd	e6 40 	. @ 
	ld de,(0e715h)		;40ff	ed 5b 15 e7 	. [ . . 
	call 00e20h		;4103	cd 20 0e 	.   . 
	ld a,(0e000h)		;4106	3a 00 e0 	: . . 
	cp 005h		;4109	fe 05 	. . 
	ret z			;410b	c8 	. 
	cp 007h		;410c	fe 07 	. . 
	ret z			;410e	c8 	. 
	cp 003h		;410f	fe 03 	. . 
	ld hl,(0e900h)		;4111	2a 00 e9 	* . . 
	jr nz,l4134h		;4114	20 1e 	  . 
	ex de,hl			;4116	eb 	. 
	ld hl,(0e902h)		;4117	2a 02 e9 	* . . 
	ld a,(0e101h)		;411a	3a 01 e1 	: . . 
	ld bc,00002h		;411d	01 02 00 	. . . 
	and a			;4120	a7 	. 
	jr nz,l412bh		;4121	20 08 	  . 
	sbc hl,bc		;4123	ed 42 	. B 
	sbc hl,de		;4125	ed 52 	. R 
	jr nc,l4130h		;4127	30 07 	0 . 
	jr l4133h		;4129	18 08 	. . 
l412bh:
	add hl,bc			;412b	09 	. 
	sbc hl,de		;412c	ed 52 	. R 
	jr nc,l4133h		;412e	30 03 	0 . 
l4130h:
	add hl,de			;4130	19 	. 
	jr l4134h		;4131	18 01 	. . 
l4133h:
	ex de,hl			;4133	eb 	. 
l4134h:
	ld (0e902h),hl		;4134	22 02 e9 	" . . 
	ld a,(0e33fh)		;4137	3a 3f e3 	: ? . 
	and a			;413a	a7 	. 
	call z,02ec1h		;413b	cc c1 2e 	. . . 
	ret			;413e	c9 	. 
	call 01208h		;413f	cd 08 12 	. . . 
	jr nz,l4150h		;4142	20 0c 	  . 
	ld hl,(0e003h)		;4144	2a 03 e0 	* . . 
	ld a,h			;4147	7c 	| 
	or l			;4148	b5 	. 
	jr nz,l4150h		;4149	20 05 	  . 
	ld hl,0e71fh		;414b	21 1f e7 	! . . 
	set 1,(hl)		;414e	cb ce 	. . 
l4150h:
	call sub_4174h		;4150	cd 74 41 	. t A 
	ld hl,0e700h		;4153	21 00 e7 	! . . 
	bit 4,(hl)		;4156	cb 66 	. f 
	jr z,l4168h		;4158	28 0e 	( . 
	bit 5,(hl)		;415a	cb 6e 	. n 
	jr z,l4163h		;415c	28 05 	( . 
	bit 6,(hl)		;415e	cb 76 	. v 
	jr nz,l4170h		;4160	20 0e 	  . 
	ret			;4162	c9 	. 
l4163h:
	bit 6,(hl)		;4163	cb 76 	. v 
	jr z,l416ch		;4165	28 05 	( . 
	ret			;4167	c9 	. 
l4168h:
	bit 5,(hl)		;4168	cb 6e 	. n 
	jr nz,l4170h		;416a	20 04 	  . 
l416ch:
	inc hl			;416c	23 	# 
	res 6,(hl)		;416d	cb b6 	. . 
	ret			;416f	c9 	. 
l4170h:
	inc hl			;4170	23 	# 
	set 6,(hl)		;4171	cb f6 	. . 
	ret			;4173	c9 	. 
sub_4174h:
	ld hl,0e719h		;4174	21 19 e7 	! . . 
	dec (hl)			;4177	35 	5 
	jp nz,l419ah		;4178	c2 9a 41 	. . A 
	ld a,(0e080h)		;417b	3a 80 e0 	: . . 
	and 018h		;417e	e6 18 	. . 
	cp 008h		;4180	fe 08 	. . 
	ld d,000h		;4182	16 00 	. . 
	jr c,l4192h		;4184	38 0c 	8 . 
	ld d,0a9h		;4186	16 a9 	. . 
	jr z,l4192h		;4188	28 08 	( . 
	cp 010h		;418a	fe 10 	. . 
	ld d,070h		;418c	16 70 	. p 
	jr z,l4192h		;418e	28 02 	( . 
	ld d,038h		;4190	16 38 	. 8 
l4192h:
	ld (hl),d			;4192	72 	r 
	ld hl,0e701h		;4193	21 01 e7 	! . . 
	ld a,(hl)			;4196	7e 	~ 
	xor 080h		;4197	ee 80 	. . 
	ld (hl),a			;4199	77 	w 
l419ah:
	ld a,(0e000h)		;419a	3a 00 e0 	: . . 
	cp 003h		;419d	fe 03 	. . 
	jp z,l46a0h		;419f	ca a0 46 	. . F 
	call sub_4704h		;41a2	cd 04 47 	. . G 
	ld hl,0e702h		;41a5	21 02 e7 	! . . 
	ld a,(hl)			;41a8	7e 	~ 
	cp 00dh		;41a9	fe 0d 	. . 
	jp z,l45f6h		;41ab	ca f6 45 	. . E 
	cp 004h		;41ae	fe 04 	. . 
	jp c,l4289h		;41b0	da 89 42 	. . B 
	cp 00bh		;41b3	fe 0b 	. . 
	jp z,l44deh		;41b5	ca de 44 	. . D 
	jp nc,l4502h		;41b8	d2 02 45 	. . E 
	cp 008h		;41bb	fe 08 	. . 
	jp nc,l4406h		;41bd	d2 06 44 	. . D 
	ld a,(0e71fh)		;41c0	3a 1f e7 	: . . 
	and 001h		;41c3	e6 01 	. . 
	jp nz,l4551h		;41c5	c2 51 45 	. Q E 
	ld a,(0e909h)		;41c8	3a 09 e9 	: . . 
	ld d,a			;41cb	57 	W 
	ld a,(hl)			;41cc	7e 	~ 
	cp 006h		;41cd	fe 06 	. . 
	jr nc,l41d6h		;41cf	30 05 	0 . 
	bit 2,d		;41d1	cb 52 	. R 
	jp nz,l4387h		;41d3	c2 87 43 	. . C 
l41d6h:
	bit 3,d		;41d6	cb 5a 	. Z 
	jp nz,l43b5h		;41d8	c2 b5 43 	. . C 
	ld hl,0e700h		;41db	21 00 e7 	! . . 
	bit 1,d		;41de	cb 4a 	. J 
	jr z,l41e4h		;41e0	28 02 	( . 
	res 5,(hl)		;41e2	cb ae 	. . 
l41e4h:
	bit 0,d		;41e4	cb 42 	. B 
	jr z,l41eah		;41e6	28 02 	( . 
	set 5,(hl)		;41e8	cb ee 	. . 
l41eah:
	ld hl,0e703h		;41ea	21 03 e7 	! . . 
	dec (hl)			;41ed	35 	5 
	jr nz,l4229h		;41ee	20 39 	  9 
	ld a,(0e704h)		;41f0	3a 04 e7 	: . . 
	inc a			;41f3	3c 	< 
	jr z,l4240h		;41f4	28 4a 	( J 
	dec a			;41f6	3d 	= 
	jr nz,l4212h		;41f7	20 19 	  . 
	inc a			;41f9	3c 	< 
	ld (0e704h),a		;41fa	32 04 e7 	2 . . 
	ld hl,(0e70ah)		;41fd	2a 0a e7 	* . . 
	ld a,(hl)			;4200	7e 	~ 
	ld (0e703h),a		;4201	32 03 e7 	2 . . 
	inc hl			;4204	23 	# 
	ld a,(0e701h)		;4205	3a 01 e7 	: . . 
	and (hl)			;4208	a6 	. 
	ld (0e701h),a		;4209	32 01 e7 	2 . . 
	inc hl			;420c	23 	# 
	ld a,(hl)			;420d	7e 	~ 
	ld (0e706h),a		;420e	32 06 e7 	2 . . 
	ret			;4211	c9 	. 
l4212h:
	ld hl,0e702h		;4212	21 02 e7 	! . . 
	ld a,(hl)			;4215	7e 	~ 
	cp 006h		;4216	fe 06 	. . 
	ld bc,00400h		;4218	01 00 04 	. . . 
	jr c,l4220h		;421b	38 03 	8 . 
	ld bc,00503h		;421d	01 03 05 	. . . 
l4220h:
	ld (hl),c			;4220	71 	q 
	ld a,b			;4221	78 	x 
	ld (0e706h),a		;4222	32 06 e7 	2 . . 
	inc hl			;4225	23 	# 
	ld (hl),005h		;4226	36 05 	6 . 
	ret			;4228	c9 	. 
l4229h:
	ld a,(0e704h)		;4229	3a 04 e7 	: . . 
	dec a			;422c	3d 	= 
	ret nz			;422d	c0 	. 
	ld hl,(0e70ah)		;422e	2a 0a e7 	* . . 
	inc hl			;4231	23 	# 
	bit 1,(hl)		;4232	cb 4e 	. N 
	jr z,l423bh		;4234	28 05 	( . 
	bit 5,d		;4236	cb 6a 	. j 
	jr nz,l4244h		;4238	20 0a 	  . 
	ret			;423a	c9 	. 
l423bh:
	bit 4,d		;423b	cb 62 	. b 
	jr nz,l4244h		;423d	20 05 	  . 
	ret			;423f	c9 	. 
l4240h:
	xor a			;4240	af 	. 
	ld (0e705h),a		;4241	32 05 e7 	2 . . 
l4244h:
	xor a			;4244	af 	. 
	ld (0e704h),a		;4245	32 04 e7 	2 . . 
	ld d,a			;4248	57 	W 
	ld a,(0e702h)		;4249	3a 02 e7 	: . . 
	sub 004h		;424c	d6 04 	. . 
	add a,a			;424e	87 	. 
	ld e,a			;424f	5f 	_ 
	add a,a			;4250	87 	. 
	add a,e			;4251	83 	. 
	ld e,a			;4252	5f 	_ 
	ld hl,l658dh		;4253	21 8d 65 	! . e 
	add hl,de			;4256	19 	. 
	ld a,(hl)			;4257	7e 	~ 
	ld (0e703h),a		;4258	32 03 e7 	2 . . 
	inc hl			;425b	23 	# 
	ld a,(0e701h)		;425c	3a 01 e7 	: . . 
	or (hl)			;425f	b6 	. 
	ld (0e701h),a		;4260	32 01 e7 	2 . . 
	inc hl			;4263	23 	# 
	bit 1,a		;4264	cb 4f 	. O 
	ld a,(hl)			;4266	7e 	~ 
	inc hl			;4267	23 	# 
	ld (0e70ah),hl		;4268	22 0a e7 	" . . 
	ld hl,0e705h		;426b	21 05 e7 	! . . 
	jr z,l4275h		;426e	28 05 	( . 
	bit 0,(hl)		;4270	cb 46 	. F 
	jr z,l4275h		;4272	28 01 	( . 
	inc a			;4274	3c 	< 
l4275h:
	ld (0e706h),a		;4275	32 06 e7 	2 . . 
	inc (hl)			;4278	34 	4 
sub_4279h:
	ld a,(0e884h)		;4279	3a 84 e8 	: . . 
	and a			;427c	a7 	. 
	ret nz			;427d	c0 	. 
	ld a,00bh		;427e	3e 0b 	> . 
	ld (0e884h),a		;4280	32 84 e8 	2 . . 
	ld a,082h		;4283	3e 82 	> . 
	call 00dfeh		;4285	cd fe 0d 	. . . 
	ret			;4288	c9 	. 
l4289h:
	ld a,(0e71fh)		;4289	3a 1f e7 	: . . 
	bit 1,a		;428c	cb 4f 	. O 
	jp nz,l4636h		;428e	c2 36 46 	. 6 F 
	bit 0,a		;4291	cb 47 	. G 
	jp nz,l455ah		;4293	c2 5a 45 	. Z E 
	ld a,(0e703h)		;4296	3a 03 e7 	: . . 
	dec a			;4299	3d 	= 
	jp m,l42a0h		;429a	fa a0 42 	. . B 
	ld (0e703h),a		;429d	32 03 e7 	2 . . 
l42a0h:
	ld a,(0e909h)		;42a0	3a 09 e9 	: . . 
	bit 5,a		;42a3	cb 6f 	. o 
	jp nz,l4365h		;42a5	c2 65 43 	. e C 
	bit 4,a		;42a8	cb 67 	. g 
	jp nz,l4352h		;42aa	c2 52 43 	. R C 
	bit 3,a		;42ad	cb 5f 	. _ 
	jp nz,l43bdh		;42af	c2 bd 43 	. . C 
	bit 2,a		;42b2	cb 57 	. W 
	jp nz,l4387h		;42b4	c2 87 43 	. . C 
	bit 1,a		;42b7	cb 4f 	. O 
	jr nz,l4307h		;42b9	20 4c 	  L 
	bit 0,a		;42bb	cb 47 	. G 
	jr nz,l42dfh		;42bd	20 20 	    
l42bfh:
	ld hl,0e702h		;42bf	21 02 e7 	! . . 
	ld a,(hl)			;42c2	7e 	~ 
	cp 002h		;42c3	fe 02 	. . 
	ld (hl),000h		;42c5	36 00 	6 . 
	jp nc,l4347h		;42c7	d2 47 43 	. G C 
	cp 000h		;42ca	fe 00 	. . 
	ld a,(0e705h)		;42cc	3a 05 e7 	: . . 
	jr z,l42d3h		;42cf	28 02 	( . 
	ld a,005h		;42d1	3e 05 	> . 
l42d3h:
	dec a			;42d3	3d 	= 
	ld (0e705h),a		;42d4	32 05 e7 	2 . . 
	ret nz			;42d7	c0 	. 
	ld hl,(0e712h)		;42d8	2a 12 e7 	* . . 
	ld (0e707h),hl		;42db	22 07 e7 	" . . 
	ret			;42de	c9 	. 
l42dfh:
	ld hl,(0e712h)		;42df	2a 12 e7 	* . . 
	ld de,0db00h		;42e2	11 00 db 	. . . 
	sbc hl,de		;42e5	ed 52 	. R 
	jr z,l42bfh		;42e7	28 d6 	( . 
	ld hl,0e701h		;42e9	21 01 e7 	! . . 
	bit 5,(hl)		;42ec	cb 6e 	. n 
	dec hl			;42ee	2b 	+ 
	jr nz,l42f9h		;42ef	20 08 	  . 
	bit 5,(hl)		;42f1	cb 6e 	. n 
	jr nz,l4331h		;42f3	20 3c 	  < 
	set 5,(hl)		;42f5	cb ee 	. . 
	jr l431fh		;42f7	18 26 	. & 
l42f9h:
	set 5,(hl)		;42f9	cb ee 	. . 
	jr l42ffh		;42fb	18 02 	. . 
l42fdh:
	res 5,(hl)		;42fd	cb ae 	. . 
l42ffh:
	ld hl,(0e712h)		;42ff	2a 12 e7 	* . . 
	ld (0e707h),hl		;4302	22 07 e7 	" . . 
	jr l42bfh		;4305	18 b8 	. . 
l4307h:
	ld hl,(0e712h)		;4307	2a 12 e7 	* . . 
	ld de,00400h		;430a	11 00 04 	. . . 
	sbc hl,de		;430d	ed 52 	. R 
	jr z,l42bfh		;430f	28 ae 	( . 
	ld hl,0e701h		;4311	21 01 e7 	! . . 
	bit 4,(hl)		;4314	cb 66 	. f 
	dec hl			;4316	2b 	+ 
	jr nz,l42fdh		;4317	20 e4 	  . 
	bit 5,(hl)		;4319	cb 6e 	. n 
	jr z,l4331h		;431b	28 14 	( . 
	res 5,(hl)		;431d	cb ae 	. . 
l431fh:
	ld a,(0e702h)		;431f	3a 02 e7 	: . . 
	cp 004h		;4322	fe 04 	. . 
	jr nz,l432bh		;4324	20 05 	  . 
	ld a,005h		;4326	3e 05 	> . 
	ld (0e703h),a		;4328	32 03 e7 	2 . . 
l432bh:
	ld hl,(0e712h)		;432b	2a 12 e7 	* . . 
	ld (0e707h),hl		;432e	22 07 e7 	" . . 
l4331h:
	ld hl,0e702h		;4331	21 02 e7 	! . . 
	ld a,001h		;4334	3e 01 	> . 
	cp (hl)			;4336	be 	. 
	ld (hl),a			;4337	77 	w 
	jr c,l4347h		;4338	38 0d 	8 . 
	ld a,(0e703h)		;433a	3a 03 e7 	: . . 
	and a			;433d	a7 	. 
	ret nz			;433e	c0 	. 
sub_433fh:
	ld a,(0e706h)		;433f	3a 06 e7 	: . . 
	inc a			;4342	3c 	< 
	cp 004h		;4343	fe 04 	. . 
	jr c,l4349h		;4345	38 02 	8 . 
l4347h:
	ld a,000h		;4347	3e 00 	> . 
l4349h:
	ld (0e706h),a		;4349	32 06 e7 	2 . . 
	ld a,005h		;434c	3e 05 	> . 
	ld (0e703h),a		;434e	32 03 e7 	2 . . 
	ret			;4351	c9 	. 
l4352h:
	ld a,(hl)			;4352	7e 	~ 
	cp 003h		;4353	fe 03 	. . 
	ld a,005h		;4355	3e 05 	> . 
	jr nz,l435bh		;4357	20 02 	  . 
	ld a,007h		;4359	3e 07 	> . 
l435bh:
	ld (hl),a			;435b	77 	w 
	ld hl,(0e712h)		;435c	2a 12 e7 	* . . 
	ld (0e707h),hl		;435f	22 07 e7 	" . . 
	jp l4240h		;4362	c3 40 42 	. @ B 
l4365h:
	ld a,001h		;4365	3e 01 	> . 
	ld (0e703h),a		;4367	32 03 e7 	2 . . 
	ld a,(hl)			;436a	7e 	~ 
	cp 003h		;436b	fe 03 	. . 
	ld c,004h		;436d	0e 04 	. . 
	ld a,006h		;436f	3e 06 	> . 
	jr nz,l4377h		;4371	20 04 	  . 
	ld c,006h		;4373	0e 06 	. . 
	ld a,00bh		;4375	3e 0b 	> . 
l4377h:
	ld (hl),c			;4377	71 	q 
	ld (0e706h),a		;4378	32 06 e7 	2 . . 
	ld a,0ffh		;437b	3e ff 	> . 
	ld (0e704h),a		;437d	32 04 e7 	2 . . 
	ld hl,(0e712h)		;4380	2a 12 e7 	* . . 
	ld (0e707h),hl		;4383	22 07 e7 	" . . 
	ret			;4386	c9 	. 
l4387h:
	ld a,(hl)			;4387	7e 	~ 
	cp 002h		;4388	fe 02 	. . 
	jr z,l43a5h		;438a	28 19 	( . 
	cp 003h		;438c	fe 03 	. . 
	ret z			;438e	c8 	. 
	ld (hl),002h		;438f	36 02 	6 . 
	ld hl,(0e712h)		;4391	2a 12 e7 	* . . 
	ld (0e707h),hl		;4394	22 07 e7 	" . . 
	ld a,002h		;4397	3e 02 	> . 
	ld (0e703h),a		;4399	32 03 e7 	2 . . 
	ld a,(0e701h)		;439c	3a 01 e7 	: . . 
	and 0fch		;439f	e6 fc 	. . 
	ld (0e701h),a		;43a1	32 01 e7 	2 . . 
	ret			;43a4	c9 	. 
l43a5h:
	ld a,(0e703h)		;43a5	3a 03 e7 	: . . 
	and a			;43a8	a7 	. 
	ret nz			;43a9	c0 	. 
	ld a,003h		;43aa	3e 03 	> . 
	ld (0e702h),a		;43ac	32 02 e7 	2 . . 
	ld a,005h		;43af	3e 05 	> . 
	ld (0e706h),a		;43b1	32 06 e7 	2 . . 
	ret			;43b4	c9 	. 
l43b5h:
	ld a,(0e701h)		;43b5	3a 01 e7 	: . . 
	and 0fch		;43b8	e6 fc 	. . 
	ld (0e701h),a		;43ba	32 01 e7 	2 . . 
l43bdh:
	ld hl,(0e712h)		;43bd	2a 12 e7 	* . . 
	ld de,(0e707h)		;43c0	ed 5b 07 e7 	. [ . . 
	ld a,(0e700h)		;43c4	3a 00 e7 	: . . 
	and 020h		;43c7	e6 20 	.   
	jr nz,l43cch		;43c9	20 01 	  . 
	ex de,hl			;43cb	eb 	. 
l43cch:
	sbc hl,de		;43cc	ed 52 	. R 
	ld a,008h		;43ce	3e 08 	> . 
	ld de,00400h		;43d0	11 00 04 	. . . 
	sbc hl,de		;43d3	ed 52 	. R 
	jr c,l43d8h		;43d5	38 01 	8 . 
	inc a			;43d7	3c 	< 
l43d8h:
	ld (0e702h),a		;43d8	32 02 e7 	2 . . 
	sub 008h		;43db	d6 08 	. . 
	add a,a			;43dd	87 	. 
	ld b,000h		;43de	06 00 	. . 
	ld c,a			;43e0	4f 	O 
	ld de,0e703h		;43e1	11 03 e7 	. . . 
	ld hl,065a5h		;43e4	21 a5 65 	! . e 
	add hl,bc			;43e7	09 	. 
	ld a,(hl)			;43e8	7e 	~ 
	inc hl			;43e9	23 	# 
	ld h,(hl)			;43ea	66 	f 
	ld l,a			;43eb	6f 	o 
	ldi		;43ec	ed a0 	. . 
	inc bc			;43ee	03 	. 
	ld (0e70ch),hl		;43ef	22 0c e7 	" . . 
	ld hl,l65a9h		;43f2	21 a9 65 	! . e 
	add hl,bc			;43f5	09 	. 
	ld a,(hl)			;43f6	7e 	~ 
	inc hl			;43f7	23 	# 
	ld h,(hl)			;43f8	66 	f 
	ld l,a			;43f9	6f 	o 
	ldi		;43fa	ed a0 	. . 
	ld (0e70eh),hl		;43fc	22 0e e7 	" . . 
	xor a			;43ff	af 	. 
	ld (de),a			;4400	12 	. 
	ld a,(hl)			;4401	7e 	~ 
	ld (0e706h),a		;4402	32 06 e7 	2 . . 
	ret			;4405	c9 	. 
l4406h:
	ld hl,0e71fh		;4406	21 1f e7 	! . . 
	bit 0,(hl)		;4409	cb 46 	. F 
	jp nz,l464bh		;440b	c2 4b 46 	. K F 
	ld a,(0e71ah)		;440e	3a 1a e7 	: . . 
	and a			;4411	a7 	. 
	jp nz,l4656h		;4412	c2 56 46 	. V F 
	ld hl,(0e70ch)		;4415	2a 0c e7 	* . . 
	ld e,(hl)			;4418	5e 	^ 
	inc hl			;4419	23 	# 
	ld d,(hl)			;441a	56 	V 
	push hl			;441b	e5 	. 
	ld hl,(0e710h)		;441c	2a 10 e7 	* . . 
	add hl,de			;441f	19 	. 
l4420h:
	ld (0e710h),hl		;4420	22 10 e7 	" . . 
	pop hl			;4423	e1 	. 
	ld a,(0e703h)		;4424	3a 03 e7 	: . . 
	dec a			;4427	3d 	= 
	jr nz,l4430h		;4428	20 06 	  . 
	inc hl			;442a	23 	# 
	ld a,(hl)			;442b	7e 	~ 
	inc hl			;442c	23 	# 
	ld (0e70ch),hl		;442d	22 0c e7 	" . . 
l4430h:
	ld (0e703h),a		;4430	32 03 e7 	2 . . 
	ld hl,(0e70eh)		;4433	2a 0e e7 	* . . 
	ld a,(0e704h)		;4436	3a 04 e7 	: . . 
	dec a			;4439	3d 	= 
	jr nz,l4445h		;443a	20 09 	  . 
	inc hl			;443c	23 	# 
	ld a,(hl)			;443d	7e 	~ 
	and a			;443e	a7 	. 
	jr z,l446eh		;443f	28 2d 	( - 
	inc hl			;4441	23 	# 
	ld (0e70eh),hl		;4442	22 0e e7 	" . . 
l4445h:
	ld (0e704h),a		;4445	32 04 e7 	2 . . 
	ld c,(hl)			;4448	4e 	N 
	ld a,(0e705h)		;4449	3a 05 e7 	: . . 
	and a			;444c	a7 	. 
	jr z,l44a7h		;444d	28 58 	( X 
	ld hl,(0e70ah)		;444f	2a 0a e7 	* . . 
	ld a,(0e705h)		;4452	3a 05 e7 	: . . 
	dec a			;4455	3d 	= 
	jr nz,l4486h		;4456	20 2e 	  . 
	bit 7,(hl)		;4458	cb 7e 	. ~ 
	jr z,l4460h		;445a	28 04 	( . 
	bit 7,c		;445c	cb 79 	. y 
	jr nz,l4489h		;445e	20 29 	  ) 
l4460h:
	inc hl			;4460	23 	# 
	ld a,(hl)			;4461	7e 	~ 
	ld (0e705h),a		;4462	32 05 e7 	2 . . 
	inc hl			;4465	23 	# 
	and a			;4466	a7 	. 
	jr z,l448ah		;4467	28 21 	( ! 
	ld (0e70ah),hl		;4469	22 0a e7 	" . . 
	jr l4489h		;446c	18 1b 	. . 
l446eh:
	ld hl,00500h		;446e	21 00 05 	! . . 
	ld (0e702h),hl		;4471	22 02 e7 	" . . 
	ld a,004h		;4474	3e 04 	> . 
	ld (0e706h),a		;4476	32 06 e7 	2 . . 
	ld hl,l5000h		;4479	21 00 50 	! . P 
	ld (0e710h),hl		;447c	22 10 e7 	" . . 
	ld hl,(0e712h)		;447f	2a 12 e7 	* . . 
	ld (0e707h),hl		;4482	22 07 e7 	" . . 
	ret			;4485	c9 	. 
l4486h:
	ld (0e705h),a		;4486	32 05 e7 	2 . . 
l4489h:
	ld c,(hl)			;4489	4e 	N 
l448ah:
	ld a,(0e701h)		;448a	3a 01 e7 	: . . 
	set 1,a		;448d	cb cf 	. . 
	bit 6,c		;448f	cb 71 	. q 
	jr nz,l449dh		;4491	20 0a 	  . 
	res 1,a		;4493	cb 8f 	. . 
	set 0,a		;4495	cb c7 	. . 
	bit 5,c		;4497	cb 69 	. i 
	jr nz,l449dh		;4499	20 02 	  . 
	res 0,a		;449b	cb 87 	. . 
l449dh:
	ld (0e701h),a		;449d	32 01 e7 	2 . . 
l44a0h:
	ld a,c			;44a0	79 	y 
	and 01fh		;44a1	e6 1f 	. . 
	ld (0e706h),a		;44a3	32 06 e7 	2 . . 
	ret			;44a6	c9 	. 
l44a7h:
	bit 7,c		;44a7	cb 79 	. y 
	jr z,l44a0h		;44a9	28 f5 	( . 
	ld a,(0e909h)		;44ab	3a 09 e9 	: . . 
	and 030h		;44ae	e6 30 	. 0 
	jr z,l44a0h		;44b0	28 ee 	( . 
	ld b,0f8h		;44b2	06 f8 	. . 
	bit 4,a		;44b4	cb 67 	. g 
	jr nz,l44c1h		;44b6	20 09 	  . 
	ld b,0fbh		;44b8	06 fb 	. . 
	ld a,081h		;44ba	3e 81 	> . 
	call 00dfeh		;44bc	cd fe 0d 	. . . 
	jr l44c4h		;44bf	18 03 	. . 
l44c1h:
	call sub_4279h		;44c1	cd 79 42 	. y B 
l44c4h:
	ld a,(0e702h)		;44c4	3a 02 e7 	: . . 
	add a,b			;44c7	80 	. 
	add a,a			;44c8	87 	. 
	ld d,000h		;44c9	16 00 	. . 
	ld e,a			;44cb	5f 	_ 
	ld hl,l65adh		;44cc	21 ad 65 	! . e 
	add hl,de			;44cf	19 	. 
	ld a,(hl)			;44d0	7e 	~ 
	inc hl			;44d1	23 	# 
	ld h,(hl)			;44d2	66 	f 
	ld l,a			;44d3	6f 	o 
	ld a,(hl)			;44d4	7e 	~ 
	ld (0e705h),a		;44d5	32 05 e7 	2 . . 
	inc hl			;44d8	23 	# 
	ld (0e70ah),hl		;44d9	22 0a e7 	" . . 
	jr l4489h		;44dc	18 ab 	. . 
l44deh:
	ld a,(0e71fh)		;44de	3a 1f e7 	: . . 
	and 001h		;44e1	e6 01 	. . 
	jr nz,l455ah		;44e3	20 75 	  u 
	ld hl,0e703h		;44e5	21 03 e7 	! . . 
	dec (hl)			;44e8	35 	5 
	ret nz			;44e9	c0 	. 
	ld hl,0e702h		;44ea	21 02 e7 	! . . 
	ld a,(0e706h)		;44ed	3a 06 e7 	: . . 
	cp 005h		;44f0	fe 05 	. . 
	ld (hl),003h		;44f2	36 03 	6 . 
	ret z			;44f4	c8 	. 
	ld (hl),000h		;44f5	36 00 	6 . 
	ld a,000h		;44f7	3e 00 	> . 
	ld (0e706h),a		;44f9	32 06 e7 	2 . . 
	ld a,005h		;44fc	3e 05 	> . 
	ld (0e703h),a		;44fe	32 03 e7 	2 . . 
	ret			;4501	c9 	. 
l4502h:
	ld hl,0e703h		;4502	21 03 e7 	! . . 
	dec (hl)			;4505	35 	5 
	jr nz,l4521h		;4506	20 19 	  . 
	ld hl,(0e70ah)		;4508	2a 0a e7 	* . . 
	ld a,(hl)			;450b	7e 	~ 
	cp 0ffh		;450c	fe ff 	. . 
	jr z,l454bh		;450e	28 3b 	( ; 
	ld (0e706h),a		;4510	32 06 e7 	2 . . 
	inc hl			;4513	23 	# 
	ld a,(hl)			;4514	7e 	~ 
	inc hl			;4515	23 	# 
	ld (0e703h),a		;4516	32 03 e7 	2 . . 
	ld (0e70ah),hl		;4519	22 0a e7 	" . . 
	ld hl,0e700h		;451c	21 00 e7 	! . . 
	set 1,(hl)		;451f	cb ce 	. . 
l4521h:
	ld de,(0e70eh)		;4521	ed 5b 0e e7 	. [ . . 
	ld hl,(0e707h)		;4525	2a 07 e7 	* . . 
	add hl,de			;4528	19 	. 
	ld (0e70eh),hl		;4529	22 0e e7 	" . . 
	ld hl,(0e710h)		;452c	2a 10 e7 	* . . 
	sbc hl,de		;452f	ed 52 	. R 
	ld (0e710h),hl		;4531	22 10 e7 	" . . 
	ld hl,(0e712h)		;4534	2a 12 e7 	* . . 
	ld de,(0e70ch)		;4537	ed 5b 0c e7 	. [ . . 
	ld a,(0e700h)		;453b	3a 00 e7 	: . . 
	and 020h		;453e	e6 20 	.   
	jr z,l4546h		;4540	28 04 	( . 
	sbc hl,de		;4542	ed 52 	. R 
	jr l4547h		;4544	18 01 	. . 
l4546h:
	add hl,de			;4546	19 	. 
l4547h:
	ld (0e712h),hl		;4547	22 12 e7 	" . . 
	ret			;454a	c9 	. 
l454bh:
	ld a,00bh		;454b	3e 0b 	> . 
	ld (0e000h),a		;454d	32 00 e0 	2 . . 
	ret			;4550	c9 	. 
l4551h:
	ld a,(hl)			;4551	7e 	~ 
	cp 006h		;4552	fe 06 	. . 
	ld a,005h		;4554	3e 05 	> . 
	jr nc,l4564h		;4556	30 0c 	0 . 
	jr l4561h		;4558	18 07 	. . 
l455ah:
	ld a,(0e706h)		;455a	3a 06 e7 	: . . 
	cp 005h		;455d	fe 05 	. . 
	jr z,l4567h		;455f	28 06 	( . 
l4561h:
	call sub_468eh		;4561	cd 8e 46 	. . F 
l4564h:
	ld (0e706h),a		;4564	32 06 e7 	2 . . 
l4567h:
	call 02e91h		;4567	cd 91 2e 	. . . 
	ld hl,(0e712h)		;456a	2a 12 e7 	* . . 
	ld (0e707h),hl		;456d	22 07 e7 	" . . 
	ld a,(0e701h)		;4570	3a 01 e7 	: . . 
	and 0fch		;4573	e6 fc 	. . 
	ld (0e701h),a		;4575	32 01 e7 	2 . . 
	ld hl,0e71fh		;4578	21 1f e7 	! . . 
	res 0,(hl)		;457b	cb 86 	. . 
	ld a,008h		;457d	3e 08 	> . 
	ld (0e703h),a		;457f	32 03 e7 	2 . . 
	ld hl,0e721h		;4582	21 21 e7 	! ! . 
	ld a,(0e709h)		;4585	3a 09 e7 	: . . 
	and a			;4588	a7 	. 
	scf			;4589	37 	7 
	jp m,l4591h		;458a	fa 91 45 	. . E 
	sub (hl)			;458d	96 	. 
	ld (0e709h),a		;458e	32 09 e7 	2 . . 
l4591h:
	ld hl,0e702h		;4591	21 02 e7 	! . . 
	ld (hl),00bh		;4594	36 0b 	6 . 
	ret nc			;4596	d0 	. 
	call 01208h		;4597	cd 08 12 	. . . 
	ret nz			;459a	c0 	. 
	inc (hl)			;459b	34 	4 
	ld a,(0e720h)		;459c	3a 20 e7 	:   . 
l459fh:
	and a			;459f	a7 	. 
	push af			;45a0	f5 	. 
	ld a,000h		;45a1	3e 00 	> . 
	call 00dfeh		;45a3	cd fe 0d 	. . . 
	ld a,087h		;45a6	3e 87 	> . 
	call 00dfeh		;45a8	cd fe 0d 	. . . 
	pop af			;45ab	f1 	. 
	ld hl,l45ech		;45ac	21 ec 45 	! . E 
	ld de,0000ch		;45af	11 0c 00 	. . . 
	ld bc,00012h		;45b2	01 12 00 	. . . 
	jr nz,l45dah		;45b5	20 23 	  # 
	ld hl,(0e712h)		;45b7	2a 12 e7 	* . . 
	ld de,(0e2dah)		;45ba	ed 5b da e2 	. [ . . 
	sbc hl,de		;45be	ed 52 	. R 
	ld hl,0e701h		;45c0	21 01 e7 	! . . 
	jr c,l45cch		;45c3	38 07 	8 . 
	res 6,(hl)		;45c5	cb b6 	. . 
	dec hl			;45c7	2b 	+ 
	res 5,(hl)		;45c8	cb ae 	. . 
	jr l45d1h		;45ca	18 05 	. . 
l45cch:
	set 6,(hl)		;45cc	cb f6 	. . 
	dec hl			;45ce	2b 	+ 
	set 5,(hl)		;45cf	cb ee 	. . 
l45d1h:
	ld hl,l45f1h		;45d1	21 f1 45 	! . E 
	ld de,00039h		;45d4	11 39 00 	. 9 . 
	ld bc,0001bh		;45d7	01 1b 00 	. . . 
l45dah:
	ld (0e70ah),hl		;45da	22 0a e7 	" . . 
	ld (0e70ch),de		;45dd	ed 53 0c e7 	. S . . 
	ld (0e707h),bc		;45e1	ed 43 07 e7 	. C . . 
	ld hl,00000h		;45e5	21 00 00 	! . . 
	ld (0e70eh),hl		;45e8	22 0e e7 	" . . 
	ret			;45eb	c9 	. 
l45ech:
	ld (0230ah),hl		;45ec	22 0a 23 	" . # 
	jr $+1		;45ef	18 ff 	. . 
l45f1h:
	inc h			;45f1	24 	$ 
	ex af,af'			;45f2	08 	. 
	dec h			;45f3	25 	% 
	ld d,0ffh		;45f4	16 ff 	. . 
l45f6h:
	ld hl,0e71fh		;45f6	21 1f e7 	! . . 
	bit 0,(hl)		;45f9	cb 46 	. F 
	jr z,l4609h		;45fb	28 0c 	( . 
	call 02e91h		;45fd	cd 91 2e 	. . . 
	call sub_4675h		;4600	cd 75 46 	. u F 
	call sub_468eh		;4603	cd 8e 46 	. . F 
	ld (0e706h),a		;4606	32 06 e7 	2 . . 
l4609h:
	ld de,(0e70eh)		;4609	ed 5b 0e e7 	. [ . . 
	ld hl,00012h		;460d	21 12 00 	! . . 
l4610h:
	add hl,de			;4610	19 	. 
	ld (0e70eh),hl		;4611	22 0e e7 	" . . 
	ld hl,(0e710h)		;4614	2a 10 e7 	* . . 
	sbc hl,de		;4617	ed 52 	. R 
	ex de,hl			;4619	eb 	. 
	ld hl,0b000h		;461a	21 00 b0 	! . . 
	add hl,de			;461d	19 	. 
	jr nc,l4625h		;461e	30 05 	0 . 
	ld (0e710h),de		;4620	ed 53 10 e7 	. S . . 
	ret			;4624	c9 	. 
l4625h:
	ld hl,l5000h		;4625	21 00 50 	! . P 
	ld hl,0e71fh		;4628	21 1f e7 	! . . 
	bit 1,(hl)		;462b	cb 4e 	. N 
	jr z,l4643h		;462d	28 14 	( . 
	res 1,(hl)		;462f	cb 8e 	. . 
	call 01208h		;4631	cd 08 12 	. . . 
	jr nz,l4643h		;4634	20 0d 	  . 
l4636h:
	ld a,00ch		;4636	3e 0c 	> . 
	ld (0e702h),a		;4638	32 02 e7 	2 . . 
	ld a,005h		;463b	3e 05 	> . 
	ld (0e703h),a		;463d	32 03 e7 	2 . . 
	jp l459fh		;4640	c3 9f 45 	. . E 
l4643h:
	ld hl,0e702h		;4643	21 02 e7 	! . . 
	ld (hl),000h		;4646	36 00 	6 . 
	jp l4347h		;4648	c3 47 43 	. G C 
l464bh:
	call 02e91h		;464b	cd 91 2e 	. . . 
	call sub_4675h		;464e	cd 75 46 	. u F 
	call sub_468eh		;4651	cd 8e 46 	. . F 
	jr l4658h		;4654	18 02 	. . 
l4656h:
	ld a,010h		;4656	3e 10 	> . 
l4658h:
	ld (0e706h),a		;4658	32 06 e7 	2 . . 
	ld a,00dh		;465b	3e 0d 	> . 
	ld (0e702h),a		;465d	32 02 e7 	2 . . 
	ld hl,00080h		;4660	21 80 00 	! . . 
	ld (0e70eh),hl		;4663	22 0e e7 	" . . 
	ld hl,(0e712h)		;4666	2a 12 e7 	* . . 
	ld (0e707h),hl		;4669	22 07 e7 	" . . 
	ld a,(0e701h)		;466c	3a 01 e7 	: . . 
	and 0fch		;466f	e6 fc 	. . 
	ld (0e701h),a		;4671	32 01 e7 	2 . . 
	ret			;4674	c9 	. 
sub_4675h:
	ld hl,0e721h		;4675	21 21 e7 	! ! . 
	ld a,(0e709h)		;4678	3a 09 e7 	: . . 
	and a			;467b	a7 	. 
	jp m,l4684h		;467c	fa 84 46 	. . F 
	sub (hl)			;467f	96 	. 
	ld c,000h		;4680	0e 00 	. . 
	jr nc,l4686h		;4682	30 02 	0 . 
l4684h:
	ld c,002h		;4684	0e 02 	. . 
l4686h:
	ld (0e709h),a		;4686	32 09 e7 	2 . . 
	ld hl,0e71fh		;4689	21 1f e7 	! . . 
	ld (hl),c			;468c	71 	q 
	ret			;468d	c9 	. 
sub_468eh:
	ld hl,(0e710h)		;468e	2a 10 e7 	* . . 
	ld de,01800h		;4691	11 00 18 	. . . 
	add hl,de			;4694	19 	. 
	ld de,(0e722h)		;4695	ed 5b 22 e7 	. [ " . 
	sbc hl,de		;4699	ed 52 	. R 
	ld a,020h		;469b	3e 20 	>   
	ret c			;469d	d8 	. 
	inc a			;469e	3c 	< 
	ret			;469f	c9 	. 
l46a0h:
	call sub_5903h		;46a0	cd 03 59 	. . Y 
	cp 004h		;46a3	fe 04 	. . 
	jr z,l46f4h		;46a5	28 4d 	( M 
	ld hl,0e703h		;46a7	21 03 e7 	! . . 
	dec (hl)			;46aa	35 	5 
	ret nz			;46ab	c0 	. 
	ld (hl),008h		;46ac	36 08 	6 . 
	ld hl,0e705h		;46ae	21 05 e7 	! . . 
	dec (hl)			;46b1	35 	5 
	jr nz,l46d8h		;46b2	20 24 	  $ 
	ld (hl),002h		;46b4	36 02 	6 . 
	dec hl			;46b6	2b 	+ 
	dec (hl)			;46b7	35 	5 
	jr z,l46eeh		;46b8	28 34 	( 4 
	ld hl,(0e712h)		;46ba	2a 12 e7 	* . . 
	ld de,00100h		;46bd	11 00 01 	. . . 
	ld a,(0e101h)		;46c0	3a 01 e1 	: . . 
	and a			;46c3	a7 	. 
	jr z,l46c9h		;46c4	28 03 	( . 
	add hl,de			;46c6	19 	. 
	jr l46cbh		;46c7	18 02 	. . 
l46c9h:
	sbc hl,de		;46c9	ed 52 	. R 
l46cbh:
	ld (0e712h),hl		;46cb	22 12 e7 	" . . 
	ld hl,(0e710h)		;46ce	2a 10 e7 	* . . 
	ld de,00600h		;46d1	11 00 06 	. . . 
	add hl,de			;46d4	19 	. 
	ld (0e710h),hl		;46d5	22 10 e7 	" . . 
l46d8h:
	ld a,(0e706h)		;46d8	3a 06 e7 	: . . 
	inc a			;46db	3c 	< 
	cp 020h		;46dc	fe 20 	.   
	jr nz,l46e2h		;46de	20 02 	  . 
	ld a,01ch		;46e0	3e 1c 	> . 
l46e2h:
	ld (0e706h),a		;46e2	32 06 e7 	2 . . 
	and 001h		;46e5	e6 01 	. . 
	ret nz			;46e7	c0 	. 
	ld a,090h		;46e8	3e 90 	> . 
	call 00dfeh		;46ea	cd fe 0d 	. . . 
	ret			;46ed	c9 	. 
l46eeh:
	ld a,00ch		;46ee	3e 0c 	> . 
	ld (0e000h),a		;46f0	32 00 e0 	2 . . 
	ret			;46f3	c9 	. 
l46f4h:
	ld a,(0e706h)		;46f4	3a 06 e7 	: . . 
	cp 026h		;46f7	fe 26 	. & 
	ret nz			;46f9	c0 	. 
	ld a,00ch		;46fa	3e 0c 	> . 
	ld (0e000h),a		;46fc	32 00 e0 	2 . . 
	xor a			;46ff	af 	. 
	ld (0e340h),a		;4700	32 40 e3 	2 @ . 
	ret			;4703	c9 	. 
sub_4704h:
	ld hl,(0e102h)		;4704	2a 02 e1 	* . . 
	ld de,(0e712h)		;4707	ed 5b 12 e7 	. [ . . 
	call sub_5903h		;470b	cd 03 59 	. . Y 
	cp 004h		;470e	fe 04 	. . 
	jr z,l4784h		;4710	28 72 	( r 
	ld a,(0e101h)		;4712	3a 01 e1 	: . . 
	cp 001h		;4715	fe 01 	. . 
	ld iy,l5000h		;4717	fd 21 00 50 	. ! . P 
	jr c,l4723h		;471b	38 06 	8 . 
	ret nz			;471d	c0 	. 
	ld iy,l5200h		;471e	fd 21 00 52 	. ! . R 
	ex de,hl			;4722	eb 	. 
l4723h:
	and a			;4723	a7 	. 
	sbc hl,de		;4724	ed 52 	. R 
	ret c			;4726	d8 	. 
	push hl			;4727	e5 	. 
	ld hl,(0e710h)		;4728	2a 10 e7 	* . . 
	ld de,l5000h		;472b	11 00 50 	. . P 
	sbc hl,de		;472e	ed 52 	. R 
	jr c,l4782h		;4730	38 50 	8 P 
	add hl,hl			;4732	29 	) 
	ld a,h			;4733	7c 	| 
	pop hl			;4734	e1 	. 
	ld b,00ch		;4735	06 0c 	. . 
l4737h:
	sub 00ch		;4737	d6 0c 	. . 
	jr c,l4749h		;4739	38 0e 	8 . 
	ld de,00100h		;473b	11 00 01 	. . . 
	sbc hl,de		;473e	ed 52 	. R 
	ret c			;4740	d8 	. 
	ld de,00600h		;4741	11 00 06 	. . . 
	add iy,de		;4744	fd 19 	. . 
	dec b			;4746	05 	. 
	jr l4737h		;4747	18 ee 	. . 
l4749h:
	ld (0e710h),iy		;4749	fd 22 10 e7 	. " . . 
	ld a,000h		;474d	3e 00 	> . 
	call 00dfeh		;474f	cd fe 0d 	. . . 
	ld a,003h		;4752	3e 03 	> . 
	ld (0e000h),a		;4754	32 00 e0 	2 . . 
	ex de,hl			;4757	eb 	. 
	ld hl,(0e712h)		;4758	2a 12 e7 	* . . 
	ld a,(0e101h)		;475b	3a 01 e1 	: . . 
	and a			;475e	a7 	. 
	jr z,l4766h		;475f	28 05 	( . 
	sbc hl,de		;4761	ed 52 	. R 
	ld de,00100h		;4763	11 00 01 	. . . 
l4766h:
	add hl,de			;4766	19 	. 
	ld (0e712h),hl		;4767	22 12 e7 	" . . 
	ld hl,0e700h		;476a	21 00 e7 	! . . 
	set 1,(hl)		;476d	cb ce 	. . 
	ld a,01ch		;476f	3e 1c 	> . 
	ld (0e706h),a		;4771	32 06 e7 	2 . . 
	ld a,008h		;4774	3e 08 	> . 
	ld (0e703h),a		;4776	32 03 e7 	2 . . 
	ld a,001h		;4779	3e 01 	> . 
	ld (0e705h),a		;477b	32 05 e7 	2 . . 
	ld a,b			;477e	78 	x 
	ld (0e704h),a		;477f	32 04 e7 	2 . . 
l4782h:
	pop af			;4782	f1 	. 
	ret			;4783	c9 	. 
l4784h:
	sbc hl,de		;4784	ed 52 	. R 
	ret c			;4786	d8 	. 
	ld a,(0e702h)		;4787	3a 02 e7 	: . . 
	cp 002h		;478a	fe 02 	. . 
	ret nc			;478c	d0 	. 
	ld hl,0e341h		;478d	21 41 e3 	! A . 
	inc (hl)			;4790	34 	4 
	ld a,005h		;4791	3e 05 	> . 
	ld (0e346h),a		;4793	32 46 e3 	2 F . 
	ld a,005h		;4796	3e 05 	> . 
	ld (0e347h),a		;4798	32 47 e3 	2 G . 
	ld a,003h		;479b	3e 03 	> . 
	ld hl,0e701h		;479d	21 01 e7 	! . . 
	res 6,(hl)		;47a0	cb b6 	. . 
	dec hl			;47a2	2b 	+ 
	res 5,(hl)		;47a3	cb ae 	. . 
	set 1,(hl)		;47a5	cb ce 	. . 
	ld (0e000h),a		;47a7	32 00 e0 	2 . . 
	ld a,000h		;47aa	3e 00 	> . 
	call 00dfeh		;47ac	cd fe 0d 	. . . 
	pop af			;47af	f1 	. 
	ld a,003h		;47b0	3e 03 	> . 
	ld (0e706h),a		;47b2	32 06 e7 	2 . . 
	ret			;47b5	c9 	. 
l47b6h:
	ld ix,0e34ch		;47b6	dd 21 4c e3 	. ! L . 
	bit 4,(ix+000h)		;47ba	dd cb 00 66 	. . . f 
	call nz,sub_4821h		;47be	c4 21 48 	. ! H 
	ld ix,0e340h		;47c1	dd 21 40 e3 	. ! @ . 
	ld c,(ix+000h)		;47c5	dd 4e 00 	. N . 
	bit 4,c		;47c8	cb 61 	. a 
	ret z			;47ca	c8 	. 
	ld a,(ix+001h)		;47cb	dd 7e 01 	. ~ . 
	cp 001h		;47ce	fe 01 	. . 
	jr c,l480bh		;47d0	38 39 	8 9 
	jr z,l47e7h		;47d2	28 13 	( . 
sub_47d4h:
	ld de,0001bh		;47d4	11 1b 00 	. . . 
	call 01beah		;47d7	cd ea 1b 	. . . 
	ld de,0ff20h		;47da	11 20 ff 	.   . 
	add hl,de			;47dd	19 	. 
	jr c,sub_4821h		;47de	38 41 	8 A 
	ld a,026h		;47e0	3e 26 	> & 
	ld (0e706h),a		;47e2	32 06 e7 	2 . . 
	jr sub_4821h		;47e5	18 3a 	. : 
l47e7h:
	dec (ix+007h)		;47e7	dd 35 07 	. 5 . 
	jr nz,sub_4821h		;47ea	20 35 	  5 
	ld (ix+007h),00bh		;47ec	dd 36 07 0b 	. 6 . . 
	inc (ix+006h)		;47f0	dd 34 06 	. 4 . 
	ld a,(ix+006h)		;47f3	dd 7e 06 	. ~ . 
	cp 007h		;47f6	fe 07 	. . 
	jr c,sub_4821h		;47f8	38 27 	8 ' 
	ld (ix+007h),007h		;47fa	dd 36 07 07 	. 6 . . 
	inc (ix+001h)		;47fe	dd 34 01 	. 4 . 
	ld (ix+006h),001h		;4801	dd 36 06 01 	. 6 . . 
	set 4,(ix+00ch)		;4805	dd cb 0c e6 	. . . . 
	jr sub_4821h		;4809	18 16 	. . 
l480bh:
	dec (ix+007h)		;480b	dd 35 07 	. 5 . 
	jr nz,sub_4821h		;480e	20 11 	  . 
l4810h:
	ld (ix+007h),008h		;4810	dd 36 07 08 	. 6 . . 
	ld a,(ix+006h)		;4814	dd 7e 06 	. ~ . 
	inc a			;4817	3c 	< 
	cp 005h		;4818	fe 05 	. . 
	jr z,l481eh		;481a	28 02 	( . 
	ld a,004h		;481c	3e 04 	> . 
l481eh:
	ld (ix+006h),a		;481e	dd 77 06 	. w . 
sub_4821h:
	call 01be2h		;4821	cd e2 1b 	. . . 
	ld de,0ee00h		;4824	11 00 ee 	. . . 
	add hl,de			;4827	19 	. 
	ret c			;4828	d8 	. 
	ld hl,l73f0h		;4829	21 f0 73 	! . s 
	jp 01a7dh		;482c	c3 7d 1a 	. } . 
	ld a,(0e000h)		;482f	3a 00 e0 	: . . 
	cp 006h		;4832	fe 06 	. . 
	jr nz,l484dh		;4834	20 17 	  . 
	ld hl,0e022h		;4836	21 22 e0 	! " . 
	dec (hl)			;4839	35 	5 
	ret nz			;483a	c0 	. 
	ex de,hl			;483b	eb 	. 
	ld hl,(0e023h)		;483c	2a 23 e0 	* # . 
	ld a,(hl)			;483f	7e 	~ 
	cp 0ffh		;4840	fe ff 	. . 
	jr z,l4878h		;4842	28 34 	( 4 
	inc hl			;4844	23 	# 
	ld (de),a			;4845	12 	. 
	ld a,(hl)			;4846	7e 	~ 
	inc hl			;4847	23 	# 
	ld (0e023h),hl		;4848	22 23 e0 	" # . 
	jr l4874h		;484b	18 27 	. ' 
l484dh:
	ld a,(0e906h)		;484d	3a 06 e9 	: . . 
	and 004h		;4850	e6 04 	. . 
	ld hl,0e700h		;4852	21 00 e7 	! . . 
	bit 0,(hl)		;4855	cb 46 	. F 
	jr nz,l4874h		;4857	20 1b 	  . 
	ld a,(0e906h)		;4859	3a 06 e9 	: . . 
	and 007h		;485c	e6 07 	. . 
	ld c,a			;485e	4f 	O 
	ld a,(0e71ah)		;485f	3a 1a e7 	: . . 
	and a			;4862	a7 	. 
	ld a,c			;4863	79 	y 
	jr nz,l4874h		;4864	20 0e 	  . 
	ld a,(0e908h)		;4866	3a 08 e9 	: . . 
	cpl			;4869	2f 	/ 
	ld b,a			;486a	47 	G 
	cpl			;486b	2f 	/ 
	rlca			;486c	07 	. 
	rlca			;486d	07 	. 
	rlca			;486e	07 	. 
	and b			;486f	a0 	. 
	and 038h		;4870	e6 38 	. 8 
	ld b,a			;4872	47 	G 
	or c			;4873	b1 	. 
l4874h:
	ld (0e909h),a		;4874	32 09 e9 	2 . . 
	ret			;4877	c9 	. 
l4878h:
	ld a,00bh		;4878	3e 0b 	> . 
	ld (0e000h),a		;487a	32 00 e0 	2 . . 
	ret			;487d	c9 	. 
l487eh:
	di			;487e	f3 	. 
	ld sp,0f000h		;487f	31 00 f0 	1 . . 
	xor a			;4882	af 	. 
	ld (0e001h),a		;4883	32 01 e0 	2 . . 
	ld (0e020h),a		;4886	32 20 e0 	2   . 
	ld (0e021h),a		;4889	32 21 e0 	2 ! . 
	ld (0e080h),a		;488c	32 80 e0 	2 . . 
	ei			;488f	fb 	. 
	call sub_5700h		;4890	cd 00 57 	. . W 
	call 0064ah		;4893	cd 4a 06 	. J . 
	ld hl,l4b6dh		;4896	21 6d 4b 	! m K 
	call 0111ch		;4899	cd 1c 11 	. . . 
	ld hl,l4f01h		;489c	21 01 4f 	! . O 
	ld (0e70eh),hl		;489f	22 0e e7 	" . . 
	ld a,09ch		;48a2	3e 9c 	> . 
	ld (0e705h),a		;48a4	32 05 e7 	2 . . 
	ld hl,030a0h		;48a7	21 a0 30 	! . 0 
	ld (0e712h),hl		;48aa	22 12 e7 	" . . 
	ld hl,l5c00h		;48ad	21 00 5c 	! . \ 
	ld (0e710h),hl		;48b0	22 10 e7 	" . . 
	ld (0e344h),hl		;48b3	22 44 e3 	" D . 
	ld hl,034a0h		;48b6	21 a0 34 	! . 4 
	ld (0e342h),hl		;48b9	22 42 e3 	" B . 
	ld a,010h		;48bc	3e 10 	> . 
	ld (0e340h),a		;48be	32 40 e3 	2 @ . 
	ld a,005h		;48c1	3e 05 	> . 
	ld (0e347h),a		;48c3	32 47 e3 	2 G . 
	ld ix,0e262h		;48c6	dd 21 62 e2 	. ! b . 
	ld bc,00750h		;48ca	01 50 07 	. P . 
	ld hl,00f00h		;48cd	21 00 0f 	! . . 
	ld b,007h		;48d0	06 07 	. . 
l48d2h:
	ld (ix+004h),000h		;48d2	dd 36 04 00 	. 6 . . 
	ld (ix+005h),05ch		;48d6	dd 36 05 5c 	. 6 . \ 
	ld (ix+007h),007h		;48da	dd 36 07 07 	. 6 . . 
	ld (ix+00eh),038h		;48de	dd 36 0e 38 	. 6 . 8 
	ld (ix+00fh),b		;48e2	dd 70 0f 	. p . 
	ld (ix+000h),c		;48e5	dd 71 00 	. q . 
	ld (ix+002h),l		;48e8	dd 75 02 	. u . 
	ld (ix+003h),h		;48eb	dd 74 03 	. t . 
	ld a,b			;48ee	78 	x 
	cp 007h		;48ef	fe 07 	. . 
	jr z,l48fbh		;48f1	28 08 	( . 
	cp 004h		;48f3	fe 04 	. . 
	jr c,l48fbh		;48f5	38 04 	8 . 
	ld (ix+006h),00ah		;48f7	dd 36 06 0a 	. 6 . . 
l48fbh:
	cp 005h		;48fb	fe 05 	. . 
	jr nc,l4904h		;48fd	30 05 	0 . 
	ld hl,03100h		;48ff	21 00 31 	! . 1 
	ld c,010h		;4902	0e 10 	. . 
l4904h:
	ld de,00010h		;4904	11 10 00 	. . . 
	add ix,de		;4907	dd 19 	. . 
	djnz l48d2h		;4909	10 c7 	. . 
	ld a,005h		;490b	3e 05 	> . 
	ld (0e000h),a		;490d	32 00 e0 	2 . . 
	ld de,0d152h		;4910	11 52 d1 	. R . 
	ld c,00bh		;4913	0e 0b 	. . 
	ld hl,l4b86h		;4915	21 86 4b 	! . K 
	call 01134h		;4918	cd 34 11 	. 4 . 
l491bh:
	ld a,(0e020h)		;491b	3a 20 e0 	:   . 
	cp 008h		;491e	fe 08 	. . 
l4920h:
	jr nz,l491bh		;4920	20 f9 	  . 
	call 0111ch		;4922	cd 1c 11 	. . . 
l4925h:
	ld a,(0e020h)		;4925	3a 20 e0 	:   . 
	cp 00bh		;4928	fe 0b 	. . 
	jr nz,l4925h		;492a	20 f9 	  . 
	call sub_49aeh		;492c	cd ae 49 	. . I 
	ld hl,l4c0eh		;492f	21 0e 4c 	! . L 
	call 01134h		;4932	cd 34 11 	. 4 . 
	ld a,0e1h		;4935	3e e1 	> . 
	call sub_570fh		;4937	cd 0f 57 	. . W 
	call sub_49aeh		;493a	cd ae 49 	. . I 
	ld hl,l4c71h		;493d	21 71 4c 	! q L 
	call 0111ch		;4940	cd 1c 11 	. . . 
l4943h:
	call sub_49c0h		;4943	cd c0 49 	. . I 
	ld a,(0e000h)		;4946	3a 00 e0 	: . . 
	cp 00bh		;4949	fe 0b 	. . 
	jr nz,l4943h		;494b	20 f6 	  . 
	xor a			;494d	af 	. 
	ld hl,00000h		;494e	21 00 00 	! . . 
	ld (0e081h),a		;4951	32 81 e0 	2 . . 
	ld (0e082h),hl		;4954	22 82 e0 	" . . 
	inc a			;4957	3c 	< 
	ld (0e084h),a		;4958	32 84 e0 	2 . . 
	ld (0e022h),a		;495b	32 22 e0 	2 " . 
	ld hl,0e025h		;495e	21 25 e0 	! % . 
	ld a,(hl)			;4961	7e 	~ 
	ld (hl),009h		;4962	36 09 	6 . 
	ld de,l4a55h		;4964	11 55 4a 	. U J 
	and a			;4967	a7 	. 
	jr z,l496fh		;4968	28 05 	( . 
	ld de,l4b0ah		;496a	11 0a 4b 	. . K 
	ld (hl),000h		;496d	36 00 	6 . 
l496fh:
	ld (0e080h),a		;496f	32 80 e0 	2 . . 
	ld (0e023h),de		;4972	ed 53 23 e0 	. S # . 
	call 01157h		;4976	cd 57 11 	. W . 
	ld a,001h		;4979	3e 01 	> . 
	call 00449h		;497b	cd 49 04 	. I . 
	di			;497e	f3 	. 
	ld a,006h		;497f	3e 06 	> . 
	ld (0e000h),a		;4981	32 00 e0 	2 . . 
	ld hl,00000h		;4984	21 00 00 	! . . 
	ld (0e081h),hl		;4987	22 81 e0 	" . . 
	ld (0e082h),hl		;498a	22 82 e0 	" . . 
	ld (0e010h),hl		;498d	22 10 e0 	" . . 
	ld (0e012h),hl		;4990	22 12 e0 	" . . 
	ei			;4993	fb 	. 
l4994h:
	call 00fb8h		;4994	cd b8 0f 	. . . 
	ld a,(0e000h)		;4997	3a 00 e0 	: . . 
	cp 00bh		;499a	fe 0b 	. . 
	jr nz,l4994h		;499c	20 f6 	  . 
	ld a,038h		;499e	3e 38 	> 8 
	call sub_570fh		;49a0	cd 0f 57 	. . W 
	call sub_5620h		;49a3	cd 20 56 	.   V 
	ld a,0e1h		;49a6	3e e1 	> . 
	call sub_570fh		;49a8	cd 0f 57 	. . W 
	jp l487eh		;49ab	c3 7e 48 	. ~ H 
sub_49aeh:
	ld de,0d150h		;49ae	11 50 d1 	. P . 
	ld b,004h		;49b1	06 04 	. . 
l49b3h:
	push de			;49b3	d5 	. 
	call sub_572ah		;49b4	cd 2a 57 	. * W 
	pop hl			;49b7	e1 	. 
	ld de,00080h		;49b8	11 80 00 	. . . 
	add hl,de			;49bb	19 	. 
	ex de,hl			;49bc	eb 	. 
	djnz l49b3h		;49bd	10 f4 	. . 
	ret			;49bf	c9 	. 
sub_49c0h:
	ld de,0d316h		;49c0	11 16 d3 	. . . 
	ld bc,0190bh		;49c3	01 0b 19 	. . . 
	ld a,(0e880h)		;49c6	3a 80 e8 	: . . 
	and 030h		;49c9	e6 30 	. 0 
	jp z,l571fh		;49cb	ca 1f 57 	. . W 
	ld hl,(0e90ah)		;49ce	2a 0a e9 	* . . 
	ld a,l			;49d1	7d 	} 
	xor h			;49d2	ac 	. 
	jr nz,l49e9h		;49d3	20 14 	  . 
	inc de			;49d5	13 	. 
	call sub_49f7h		;49d6	cd f7 49 	. . I 
	bit 3,l		;49d9	cb 5d 	. ] 
	ret nz			;49db	c0 	. 
	ld de,0d397h		;49dc	11 97 d3 	. . . 
	ld a,l			;49df	7d 	} 
	add a,a			;49e0	87 	. 
	daa			;49e1	27 	' 
	call sub_4a10h		;49e2	cd 10 4a 	. . J 
	ld a,002h		;49e5	3e 02 	> . 
	jr l4a0ah		;49e7	18 21 	. ! 
l49e9h:
	ld a,041h		;49e9	3e 41 	> A 
	call sub_49f4h		;49eb	cd f4 49 	. . I 
	ld l,h			;49ee	6c 	l 
	ld de,0d396h		;49ef	11 96 d3 	. . . 
	ld a,042h		;49f2	3e 42 	> B 
sub_49f4h:
	call sub_4a2ch		;49f4	cd 2c 4a 	. , J 
sub_49f7h:
	bit 3,l		;49f7	cb 5d 	. ] 
	ld a,001h		;49f9	3e 01 	> . 
	jr nz,l49feh		;49fb	20 01 	  . 
	ld a,l			;49fd	7d 	} 
l49feh:
	call sub_4a10h		;49fe	cd 10 4a 	. . J 
	bit 3,l		;4a01	cb 5d 	. ] 
	ld a,001h		;4a03	3e 01 	> . 
	jr z,l4a0ah		;4a05	28 03 	( . 
	ld a,l			;4a07	7d 	} 
	and 007h		;4a08	e6 07 	. . 
l4a0ah:
	push hl			;4a0a	e5 	. 
	ld hl,l4a39h		;4a0b	21 39 4a 	! 9 J 
	jr l4a14h		;4a0e	18 04 	. . 
sub_4a10h:
	push hl			;4a10	e5 	. 
	ld hl,l4a34h		;4a11	21 34 4a 	! 4 J 
l4a14h:
	push af			;4a14	f5 	. 
	push bc			;4a15	c5 	. 
	ld c,b			;4a16	48 	H 
	call sub_56f7h		;4a17	cd f7 56 	. . V 
	pop bc			;4a1a	c1 	. 
	inc de			;4a1b	13 	. 
	call 0111ch		;4a1c	cd 1c 11 	. . . 
	pop af			;4a1f	f1 	. 
	push de			;4a20	d5 	. 
	cp 001h		;4a21	fe 01 	. . 
	ld a,053h		;4a23	3e 53 	> S 
	call nz,01110h		;4a25	c4 10 11 	. . . 
	pop de			;4a28	d1 	. 
	inc de			;4a29	13 	. 
	pop hl			;4a2a	e1 	. 
	ret			;4a2b	c9 	. 
sub_4a2ch:
	call 01110h		;4a2c	cd 10 11 	. . . 
	ld a,02dh		;4a2f	3e 2d 	> - 
	jp 01110h		;4a31	c3 10 11 	. . . 
l4a34h:
	ld b,e			;4a34	43 	C 
	ld c,a			;4a35	4f 	O 
	ld c,c			;4a36	49 	I 
	ld c,(hl)			;4a37	4e 	N 
	rst 38h			;4a38	ff 	. 
l4a39h:
	ld d,b			;4a39	50 	P 
	ld c,h			;4a3a	4c 	L 
	ld b,c			;4a3b	41 	A 
	ld e,c			;4a3c	59 	Y 
	ld b,l			;4a3d	45 	E 
	ld d,d			;4a3e	52 	R 
	rst 38h			;4a3f	ff 	. 
	jr nz,l4a62h		;4a40	20 20 	    
	jr nz,l4a64h		;4a42	20 20 	    
	jr nz,l4a66h		;4a44	20 20 	    
	jr nz,l4a68h		;4a46	20 20 	    
	jr nz,l4a6ah		;4a48	20 20 	    
	jr nz,$+34		;4a4a	20 20 	    
	jr nz,l4a6eh		;4a4c	20 20 	    
	jr nz,l4a70h		;4a4e	20 20 	    
	jr nz,$+34		;4a50	20 20 	    
	jr nz,l4a74h		;4a52	20 20 	    
	rst 38h			;4a54	ff 	. 
l4a55h:
	ld b,d			;4a55	42 	B 
	ld (bc),a			;4a56	02 	. 
	ld bc,02820h		;4a57	01 20 28 	.   ( 
	ld (bc),a			;4a5a	02 	. 
	ld (bc),a			;4a5b	02 	. 
	djnz l4a76h		;4a5c	10 18 	. . 
	ld (bc),a			;4a5e	02 	. 
	inc bc			;4a5f	03 	. 
	djnz $+26		;4a60	10 18 	. . 
l4a62h:
	ld (bc),a			;4a62	02 	. 
	ld (bc),a			;4a63	02 	. 
l4a64h:
	djnz l4a8ah		;4a64	10 24 	. $ 
l4a66h:
	ld (bc),a			;4a66	02 	. 
	ld (bc),a			;4a67	02 	. 
l4a68h:
	jr nz,$+58		;4a68	20 38 	  8 
l4a6ah:
	ld (bc),a			;4a6a	02 	. 
	djnz l4a71h		;4a6b	10 04 	. . 
	ld (bc),a			;4a6d	02 	. 
l4a6eh:
	jr nz,l4a8eh		;4a6e	20 1e 	  . 
l4a70h:
	ld (bc),a			;4a70	02 	. 
l4a71h:
	djnz l4a7bh		;4a71	10 08 	. . 
	ld (bc),a			;4a73	02 	. 
l4a74h:
	jr nz,$+46		;4a74	20 2c 	  , 
l4a76h:
	ld bc,02004h		;4a76	01 04 20 	. .   
	jr z,$+4		;4a79	28 02 	( . 
l4a7bh:
	ex af,af'			;4a7b	08 	. 
	ld bc,01002h		;4a7c	01 02 10 	. . . 
	jr z,$+3		;4a7f	28 01 	( . 
	djnz l4a8bh		;4a81	10 08 	. . 
	jr l4aa5h		;4a83	18 20 	.   
	ex af,af'			;4a85	08 	. 
	ld bc,00240h		;4a86	01 40 02 	. @ . 
	ex af,af'			;4a89	08 	. 
l4a8ah:
	ex af,af'			;4a8a	08 	. 
l4a8bh:
	ex af,af'			;4a8b	08 	. 
	jr nz,l4ad6h		;4a8c	20 48 	  H 
l4a8eh:
	ld (bc),a			;4a8e	02 	. 
	inc bc			;4a8f	03 	. 
	ld bc,00203h		;4a90	01 03 02 	. . . 
	inc bc			;4a93	03 	. 
	ld bc,00603h		;4a94	01 03 06 	. . . 
	inc bc			;4a97	03 	. 
	dec b			;4a98	05 	. 
	inc bc			;4a99	03 	. 
	ld b,003h		;4a9a	06 03 	. . 
	ld bc,00203h		;4a9c	01 03 02 	. . . 
	inc bc			;4a9f	03 	. 
	ld bc,00103h		;4aa0	01 03 01 	. . . 
	inc bc			;4aa3	03 	. 
	ld (bc),a			;4aa4	02 	. 
l4aa5h:
	inc bc			;4aa5	03 	. 
	ld bc,00603h		;4aa6	01 03 06 	. . . 
	inc bc			;4aa9	03 	. 
	dec b			;4aaa	05 	. 
	inc bc			;4aab	03 	. 
	ld b,003h		;4aac	06 03 	. . 
	ld bc,00203h		;4aae	01 03 02 	. . . 
	inc bc			;4ab1	03 	. 
	ld bc,00203h		;4ab2	01 03 02 	. . . 
	inc bc			;4ab5	03 	. 
	ld bc,00603h		;4ab6	01 03 06 	. . . 
	inc bc			;4ab9	03 	. 
	dec b			;4aba	05 	. 
	inc bc			;4abb	03 	. 
	ld b,003h		;4abc	06 03 	. . 
	ld bc,00218h		;4abe	01 18 02 	. . . 
	ld (bc),a			;4ac1	02 	. 
	ex af,af'			;4ac2	08 	. 
	ld c,b			;4ac3	48 	H 
	ld (bc),a			;4ac4	02 	. 
	ld (bc),a			;4ac5	02 	. 
	djnz l4ae0h		;4ac6	10 18 	. . 
	nop			;4ac8	00 	. 
	ld (bc),a			;4ac9	02 	. 
	djnz $+26		;4aca	10 18 	. . 
	nop			;4acc	00 	. 
	ld a,(bc)			;4acd	0a 	. 
	ld bc,0040ah		;4ace	01 0a 04 	. . . 
	ld (bc),a			;4ad1	02 	. 
	djnz $+26		;4ad2	10 18 	. . 
	inc b			;4ad4	04 	. 
	ld (bc),a			;4ad5	02 	. 
l4ad6h:
	jr nz,l4af0h		;4ad6	20 18 	  . 
	inc b			;4ad8	04 	. 
	ld (bc),a			;4ad9	02 	. 
	djnz $+18		;4ada	10 10 	. . 
	inc b			;4adc	04 	. 
	jr z,l4ae0h		;4add	28 01 	( . 
	inc bc			;4adf	03 	. 
l4ae0h:
	jr nz,$+34		;4ae0	20 20 	    
	ld bc,02003h		;4ae2	01 03 20 	. .   
	jr l4ae8h		;4ae5	18 01 	. . 
	inc bc			;4ae7	03 	. 
l4ae8h:
	jr nz,l4af2h		;4ae8	20 08 	  . 
	nop			;4aea	00 	. 
	jr z,l4aefh		;4aeb	28 02 	( . 
	ex af,af'			;4aed	08 	. 
	inc b			;4aee	04 	. 
l4aefh:
	inc bc			;4aef	03 	. 
l4af0h:
	jr nz,$+18		;4af0	20 10 	  . 
l4af2h:
	djnz l4b28h		;4af2	10 34 	. 4 
	ld (bc),a			;4af4	02 	. 
	inc b			;4af5	04 	. 
	ex af,af'			;4af6	08 	. 
	djnz l4b19h		;4af7	10 20 	.   
	jr z,$+4		;4af9	28 02 	( . 
	dec b			;4afb	05 	. 
	ld bc,00205h		;4afc	01 05 02 	. . . 
	dec b			;4aff	05 	. 
	ld bc,00605h		;4b00	01 05 06 	. . . 
	dec b			;4b03	05 	. 
	dec b			;4b04	05 	. 
	dec b			;4b05	05 	. 
	ld b,080h		;4b06	06 80 	. . 
	nop			;4b08	00 	. 
	rst 38h			;4b09	ff 	. 
l4b0ah:
	inc e			;4b0a	1c 	. 
	ld bc,00004h		;4b0b	01 04 00 	. . . 
	ld bc,04410h		;4b0e	01 10 44 	. . D 
	ld bc,00010h		;4b11	01 10 00 	. . . 
	jr z,l4b17h		;4b14	28 01 	( . 
	ld (bc),a			;4b16	02 	. 
l4b17h:
	jr nz,$+18		;4b17	20 10 	  . 
l4b19h:
	ld (bc),a			;4b19	02 	. 
	jr nz,l4b1dh		;4b1a	20 01 	  . 
	ld (bc),a			;4b1c	02 	. 
l4b1dh:
	ex af,af'			;4b1d	08 	. 
	ld d,b			;4b1e	50 	P 
	ld bc,00802h		;4b1f	01 02 08 	. . . 
	ld (hl),001h		;4b22	36 01 	6 . 
	ld a,(bc)			;4b24	0a 	. 
	ld (bc),a			;4b25	02 	. 
	jr nc,l4b28h		;4b26	30 00 	0 . 
l4b28h:
	djnz l4b3ah		;4b28	10 10 	. . 
	jr nz,l4b2ch		;4b2a	20 00 	  . 
l4b2ch:
	dec de			;4b2c	1b 	. 
	ld (bc),a			;4b2d	02 	. 
	ld (bc),a			;4b2e	02 	. 
	ex af,af'			;4b2f	08 	. 
	djnz l4b42h		;4b30	10 10 	. . 
	ld c,b			;4b32	48 	H 
	ld (bc),a			;4b33	02 	. 
	ld (bc),a			;4b34	02 	. 
	ex af,af'			;4b35	08 	. 
	djnz $+34		;4b36	10 20 	.   
	jr z,l4b3eh		;4b38	28 04 	( . 
l4b3ah:
	ld (bc),a			;4b3a	02 	. 
	jr nz,$+34		;4b3b	20 20 	    
	inc b			;4b3d	04 	. 
l4b3eh:
	ld l,b			;4b3e	68 	h 
	ld bc,0000ah		;4b3f	01 0a 00 	. . . 
l4b42h:
	inc b			;4b42	04 	. 
	jr nz,$+18		;4b43	20 10 	  . 
	ld (bc),a			;4b45	02 	. 
	djnz l4b48h		;4b46	10 00 	. . 
l4b48h:
	jr z,$+3		;4b48	28 01 	( . 
	ld bc,06002h		;4b4a	01 02 60 	. . ` 
	inc b			;4b4d	04 	. 
	jr c,l4b51h		;4b4e	38 01 	8 . 
	ld (bc),a			;4b50	02 	. 
l4b51h:
	ex af,af'			;4b51	08 	. 
	djnz l4b64h		;4b52	10 10 	. . 
	jr nc,l4b56h		;4b54	30 00 	0 . 
l4b56h:
	ld d,b			;4b56	50 	P 
	ld bc,00220h		;4b57	01 20 02 	.   . 
	ld (bc),a			;4b5a	02 	. 
	ex af,af'			;4b5b	08 	. 
	djnz l4b7eh		;4b5c	10 20 	.   
	jr nz,l4b60h		;4b5e	20 00 	  . 
l4b60h:
	jr l4b64h		;4b60	18 02 	. . 
	djnz l4b6ch		;4b62	10 08 	. . 
l4b64h:
	djnz l4b86h		;4b64	10 20 	.   
	djnz l4b68h		;4b66	10 00 	. . 
l4b68h:
	ld b,b			;4b68	40 	@ 
	ld bc,004a0h		;4b69	01 a0 04 	. . . 
l4b6ch:
	rst 38h			;4b6c	ff 	. 
l4b6dh:
	cp 01dh		;4b6d	fe 1d 	. . 
	defb 0fdh,0d8h,0d6h	;illegal sequence		;4b6f	fd d8 d6 	. . . 
	ld b,b			;4b72	40 	@ 
	jr nz,$+51		;4b73	20 31 	  1 
	add hl,sp			;4b75	39 	9 
	jr c,l4bach		;4b76	38 34 	8 4 
l4b78h:
	jr nz,l4b78h		;4b78	20 fe 	  . 
	jp c,l5249h		;4b7a	da 49 52 	. I R 
	ld b,l			;4b7d	45 	E 
l4b7eh:
	ld c,l			;4b7e	4d 	M 
	jr nz,l4bc4h		;4b7f	20 43 	  C 
	ld c,a			;4b81	4f 	O 
	ld d,d			;4b82	52 	R 
	ld d,b			;4b83	50 	P 
	ld l,0ffh		;4b84	2e ff 	. . 
l4b86h:
	ld b,c			;4b86	41 	A 
	jr nz,l4bd4h		;4b87	20 4b 	  K 
	ld d,l			;4b89	55 	U 
	ld c,(hl)			;4b8a	4e 	N 
	ld b,a			;4b8b	47 	G 
	dec l			;4b8c	2d 	- 
	ld b,(hl)			;4b8d	46 	F 
	ld d,l			;4b8e	55 	U 
	jr nz,l4bdeh		;4b8f	20 4d 	  M 
	ld b,c			;4b91	41 	A 
	ld d,e			;4b92	53 	S 
	ld d,h			;4b93	54 	T 
	ld b,l			;4b94	45 	E 
	ld d,d			;4b95	52 	R 
	inc l			;4b96	2c 	, 
	cp 01ah		;4b97	fe 1a 	. . 
	ld d,h			;4b99	54 	T 
	ld c,b			;4b9a	48 	H 
	ld c,a			;4b9b	4f 	O 
	ld c,l			;4b9c	4d 	M 
	ld b,c			;4b9d	41 	A 
	ld d,e			;4b9e	53 	S 
	cp 00bh		;4b9f	fe 0b 	. . 
	jr nz,l4be4h		;4ba1	20 41 	  A 
	ld c,(hl)			;4ba3	4e 	N 
l4ba4h:
	ld b,h			;4ba4	44 	D 
	jr nz,l4ba4h		;4ba5	20 fd 	  . 
	jp nc,0fed1h		;4ba7	d2 d1 fe 	. . . 
	ld a,(de)			;4baa	1a 	. 
	ld d,e			;4bab	53 	S 
l4bach:
	ld c,c			;4bac	49 	I 
	ld c,h			;4bad	4c 	L 
	ld d,(hl)			;4bae	56 	V 
	ld c,c			;4baf	49 	I 
	ld b,c			;4bb0	41 	A 
	cp 00bh		;4bb1	fe 0b 	. . 
	jr nz,$+89		;4bb3	20 57 	  W 
	ld b,l			;4bb5	45 	E 
	ld d,d			;4bb6	52 	R 
	ld b,l			;4bb7	45 	E 
	jr nz,l4c0dh		;4bb8	20 53 	  S 
	ld d,l			;4bba	55 	U 
	ld b,h			;4bbb	44 	D 
	ld b,h			;4bbc	44 	D 
	ld b,l			;4bbd	45 	E 
	ld c,(hl)			;4bbe	4e 	N 
	ld c,h			;4bbf	4c 	L 
	ld e,c			;4bc0	59 	Y 
	jr nz,$+67		;4bc1	20 41 	  A 
	ld d,h			;4bc3	54 	T 
l4bc4h:
	ld d,h			;4bc4	54 	T 
	ld b,c			;4bc5	41 	A 
	ld b,e			;4bc6	43 	C 
	ld c,e			;4bc7	4b 	K 
	ld b,l			;4bc8	45 	E 
l4bc9h:
	ld b,h			;4bc9	44 	D 
	jr nz,l4bc9h		;4bca	20 fd 	  . 
	ld d,d			;4bcc	52 	R 
	jp nc,l5942h		;4bcd	d2 42 59 	. B Y 
	jr nz,l4c25h		;4bd0	20 53 	  S 
	ld b,l			;4bd2	45 	E 
	ld d,(hl)			;4bd3	56 	V 
l4bd4h:
	ld b,l			;4bd4	45 	E 
	ld d,d			;4bd5	52 	R 
	ld b,c			;4bd6	41 	A 
	ld c,h			;4bd7	4c 	L 
	jr nz,l4c2fh		;4bd8	20 55 	  U 
	ld c,(hl)			;4bda	4e 	N 
	ld c,e			;4bdb	4b 	K 
	ld c,(hl)			;4bdc	4e 	N 
	ld c,a			;4bdd	4f 	O 
l4bdeh:
	ld d,a			;4bde	57 	W 
	ld c,(hl)			;4bdf	4e 	N 
	jr nz,l4c29h		;4be0	20 47 	  G 
	ld d,l			;4be2	55 	U 
	ld e,c			;4be3	59 	Y 
l4be4h:
	ld d,e			;4be4	53 	S 
	ld l,0ffh		;4be5	2e ff 	. . 
	defb 0fdh,0d0h,0d2h	;illegal sequence		;4be7	fd d0 d2 	. . . 
l4beah:
	jr z,l4beah		;4bea	28 fe 	( . 
	ld a,(de)			;4bec	1a 	. 
	ld d,e			;4bed	53 	S 
	ld c,c			;4bee	49 	I 
	ld c,h			;4bef	4c 	L 
	ld d,(hl)			;4bf0	56 	V 
	ld c,c			;4bf1	49 	I 
	ld b,c			;4bf2	41 	A 
	cp 00bh		;4bf3	fe 0b 	. . 
	jr nz,l4c4eh		;4bf5	20 57 	  W 
	ld b,c			;4bf7	41 	A 
	ld d,e			;4bf8	53 	S 
	jr nz,$+77		;4bf9	20 4b 	  K 
	ld c,c			;4bfb	49 	I 
	ld b,h			;4bfc	44 	D 
	ld c,(hl)			;4bfd	4e 	N 
l4bfeh:
	ld b,c			;4bfe	41 	A 
	ld d,b			;4bff	50 	P 
	ld d,b			;4c00	50 	P 
	ld b,l			;4c01	45 	E 
	ld b,h			;4c02	44 	D 
	jr nz,l4c47h		;4c03	20 42 	  B 
	ld e,c			;4c05	59 	Y 
	jr nz,l4c5ch		;4c06	20 54 	  T 
	ld c,b			;4c08	48 	H 
	ld b,l			;4c09	45 	E 
	ld c,l			;4c0a	4d 	M 
	ld l,029h		;4c0b	2e 29 	. ) 
l4c0dh:
	rst 38h			;4c0d	ff 	. 
l4c0eh:
	defb 0fdh,053h,0d1h	;illegal sequence		;4c0e	fd 53 d1 	. S . 
	ld c,h			;4c11	4c 	L 
	ld b,c			;4c12	41 	A 
	ld d,h			;4c13	54 	T 
	ld b,l			;4c14	45 	E 
	ld d,d			;4c15	52 	R 
l4c16h:
	jr nz,l4c16h		;4c16	20 fe 	  . 
	ld a,(de)			;4c18	1a 	. 
	ld d,h			;4c19	54 	T 
	ld c,b			;4c1a	48 	H 
	ld c,a			;4c1b	4f 	O 
	ld c,l			;4c1c	4d 	M 
	ld b,c			;4c1d	41 	A 
	ld d,e			;4c1e	53 	S 
	cp 00bh		;4c1f	fe 0b 	. . 
	jr nz,$+72		;4c21	20 46 	  F 
	ld c,a			;4c23	4f 	O 
	ld d,l			;4c24	55 	U 
l4c25h:
	ld c,(hl)			;4c25	4e 	N 
	ld b,h			;4c26	44 	D 
	jr nz,l4c6ah		;4c27	20 41 	  A 
l4c29h:
	jr nz,l4c77h		;4c29	20 4c 	  L 
	ld b,l			;4c2b	45 	E 
	ld d,h			;4c2c	54 	T 
	ld d,h			;4c2d	54 	T 
	ld b,l			;4c2e	45 	E 
l4c2fh:
	ld d,d			;4c2f	52 	R 
	jr nz,l4c2fh		;4c30	20 fd 	  . 
	out (0d1h),a		;4c32	d3 d1 	. . 
	ld b,(hl)			;4c34	46 	F 
	ld d,d			;4c35	52 	R 
	ld c,a			;4c36	4f 	O 
	ld c,l			;4c37	4d 	M 
l4c38h:
	jr nz,l4c38h		;4c38	20 fe 	  . 
	ld a,(de)			;4c3a	1a 	. 
	ld e,b			;4c3b	58 	X 
	cp 00bh		;4c3c	fe 0b 	. . 
	ld l,020h		;4c3e	2e 20 	.   
	defb 0fdh,053h,0d2h	;illegal sequence		;4c40	fd 53 d2 	. S . 
	ld c,b			;4c43	48 	H 
	ld b,l			;4c44	45 	E 
	jr nz,$+75		;4c45	20 49 	  I 
l4c47h:
	ld d,e			;4c47	53 	S 
	jr nz,l4c8bh		;4c48	20 41 	  A 
	ld c,(hl)			;4c4a	4e 	N 
	jr nz,l4c96h		;4c4b	20 49 	  I 
	ld c,(hl)			;4c4d	4e 	N 
l4c4eh:
	ld c,b			;4c4e	48 	H 
	ld b,c			;4c4f	41 	A 
	ld b,d			;4c50	42 	B 
	ld c,c			;4c51	49 	I 
	ld d,h			;4c52	54 	T 
	ld b,c			;4c53	41 	A 
	ld c,(hl)			;4c54	4e 	N 
	ld d,h			;4c55	54 	T 
	jr nz,l4ca7h		;4c56	20 4f 	  O 
	ld b,(hl)			;4c58	46 	F 
	jr nz,l4cafh		;4c59	20 54 	  T 
	ld c,b			;4c5b	48 	H 
l4c5ch:
	ld b,l			;4c5c	45 	E 
	jr nz,l4c5ch		;4c5d	20 fd 	  . 
	out (0d2h),a		;4c5f	d3 d2 	. . 
	ld b,h			;4c61	44 	D 
	ld b,l			;4c62	45 	E 
	ld d,(hl)			;4c63	56 	V 
	ld c,c			;4c64	49 	I 
	ld c,h			;4c65	4c 	L 
	daa			;4c66	27 	' 
	ld d,e			;4c67	53 	S 
	jr nz,l4cbeh		;4c68	20 54 	  T 
l4c6ah:
	ld b,l			;4c6a	45 	E 
	ld c,l			;4c6b	4d 	M 
	ld d,b			;4c6c	50 	P 
	ld c,h			;4c6d	4c 	L 
	ld b,l			;4c6e	45 	E 
	ld l,0ffh		;4c6f	2e ff 	. . 
l4c71h:
	cp 0dah		;4c71	fe da 	. . 
	defb 0fdh,0dah,0d0h	;illegal sequence		;4c73	fd da d0 	. . . 
	add a,b			;4c76	80 	. 
l4c77h:
	add a,c			;4c77	81 	. 
	add a,d			;4c78	82 	. 
	add a,e			;4c79	83 	. 
	add a,h			;4c7a	84 	. 
	add a,l			;4c7b	85 	. 
	add a,(hl)			;4c7c	86 	. 
	add a,a			;4c7d	87 	. 
	adc a,b			;4c7e	88 	. 
	adc a,c			;4c7f	89 	. 
	adc a,d			;4c80	8a 	. 
	defb 0fdh,01ah,0d1h	;illegal sequence		;4c81	fd 1a d1 	. . . 
	adc a,e			;4c84	8b 	. 
	adc a,h			;4c85	8c 	. 
	adc a,l			;4c86	8d 	. 
	adc a,(hl)			;4c87	8e 	. 
	adc a,a			;4c88	8f 	. 
	sub b			;4c89	90 	. 
	sub c			;4c8a	91 	. 
l4c8bh:
	sub d			;4c8b	92 	. 
	sub e			;4c8c	93 	. 
	sub h			;4c8d	94 	. 
	sub l			;4c8e	95 	. 
	defb 0fdh,057h,0d1h	;illegal sequence		;4c8f	fd 57 d1 	. W . 
	sub (hl)			;4c92	96 	. 
	sub a			;4c93	97 	. 
	sbc a,b			;4c94	98 	. 
	sbc a,c			;4c95	99 	. 
l4c96h:
	sbc a,d			;4c96	9a 	. 
	sbc a,e			;4c97	9b 	. 
	sbc a,h			;4c98	9c 	. 
	sbc a,l			;4c99	9d 	. 
	sbc a,(hl)			;4c9a	9e 	. 
	sbc a,a			;4c9b	9f 	. 
	and b			;4c9c	a0 	. 
	and c			;4c9d	a1 	. 
	and d			;4c9e	a2 	. 
	and e			;4c9f	a3 	. 
	and h			;4ca0	a4 	. 
	and l			;4ca1	a5 	. 
	and h			;4ca2	a4 	. 
	and (hl)			;4ca3	a6 	. 
	sub (iy-02fh)		;4ca4	fd 96 d1 	. . . 
l4ca7h:
	and a			;4ca7	a7 	. 
	xor b			;4ca8	a8 	. 
	xor c			;4ca9	a9 	. 
	xor d			;4caa	aa 	. 
	xor e			;4cab	ab 	. 
	xor h			;4cac	ac 	. 
	xor l			;4cad	ad 	. 
	xor (hl)			;4cae	ae 	. 
l4cafh:
	xor a			;4caf	af 	. 
	or b			;4cb0	b0 	. 
	or c			;4cb1	b1 	. 
	or d			;4cb2	b2 	. 
	or e			;4cb3	b3 	. 
	or h			;4cb4	b4 	. 
	or l			;4cb5	b5 	. 
	or (hl)			;4cb6	b6 	. 
	or a			;4cb7	b7 	. 
	or e			;4cb8	b3 	. 
	cp b			;4cb9	b8 	. 
	cp c			;4cba	b9 	. 
	defb 0fdh,0d6h,0d1h	;illegal sequence		;4cbb	fd d6 d1 	. . . 
l4cbeh:
	cp d			;4cbe	ba 	. 
	cp e			;4cbf	bb 	. 
	cp h			;4cc0	bc 	. 
	cp l			;4cc1	bd 	. 
	cp (hl)			;4cc2	be 	. 
	cp a			;4cc3	bf 	. 
	ret nz			;4cc4	c0 	. 
	pop bc			;4cc5	c1 	. 
	jp nz,0c4c3h		;4cc6	c2 c3 c4 	. . . 
	push bc			;4cc9	c5 	. 
	add a,0c7h		;4cca	c6 c7 	. . 
	ret z			;4ccc	c8 	. 
	ret			;4ccd	c9 	. 
	jp z,0cccbh		;4cce	ca cb cc 	. . . 
	call 015fdh		;4cd1	cd fd 15 	. . . 
	jp nc,0cfceh		;4cd4	d2 ce cf 	. . . 
	ret nc			;4cd7	d0 	. 
	pop de			;4cd8	d1 	. 
	jp nc,0d4d3h		;4cd9	d2 d3 d4 	. . . 
	push de			;4cdc	d5 	. 
	sub 0d7h		;4cdd	d6 d7 	. . 
	ret c			;4cdf	d8 	. 
	exx			;4ce0	d9 	. 
	ld b,0dah		;4ce1	06 da 	. . 
	in a,(0dch)		;4ce3	db dc 	. . 
	defb 0ddh,0deh,0dfh	;illegal sequence		;4ce5	dd de df 	. . . 
	ret po			;4ce8	e0 	. 
	pop hl			;4ce9	e1 	. 
	defb 0fdh,055h,0d2h	;illegal sequence		;4cea	fd 55 d2 	. U . 
	jp po,0e4e3h		;4ced	e2 e3 e4 	. . . 
	push hl			;4cf0	e5 	. 
	and 0e7h		;4cf1	e6 e7 	. . 
	ret pe			;4cf3	e8 	. 
	jp (hl)			;4cf4	e9 	. 
	jp pe,0ecebh		;4cf5	ea eb ec 	. . . 
	defb 0edh;next byte illegal after ed		;4cf8	ed 	. 
	ld b,0eeh		;4cf9	06 ee 	. . 
	rst 28h			;4cfb	ef 	. 
	ret p			;4cfc	f0 	. 
	pop af			;4cfd	f1 	. 
	ld b,0f2h		;4cfe	06 f2 	. . 
	di			;4d00	f3 	. 
	call p,0fdf5h		;4d01	f4 f5 fd 	. . . 
	sub l			;4d04	95 	. 
	jp nc,0f7f6h		;4d05	d2 f6 f7 	. . . 
	ret m			;4d08	f8 	. 
	ld sp,hl			;4d09	f9 	. 
	jp m,070fbh		;4d0a	fa fb 70 	. . p 
	ld (hl),c			;4d0d	71 	q 
	ld (hl),d			;4d0e	72 	r 
	ld (hl),e			;4d0f	73 	s 
	ld (hl),h			;4d10	74 	t 
	ld (hl),l			;4d11	75 	u 
	ld b,076h		;4d12	06 76 	. v 
	ld (hl),a			;4d14	77 	w 
	ld a,b			;4d15	78 	x 
	ld a,c			;4d16	79 	y 
	ld a,d			;4d17	7a 	z 
	ld a,e			;4d18	7b 	{ 
	ld a,h			;4d19	7c 	| 
	ld a,l			;4d1a	7d 	} 
	ld a,(hl)			;4d1b	7e 	~ 
	rst 38h			;4d1c	ff 	. 
l4d1dh:
	ld a,00bh		;4d1d	3e 0b 	> . 
	ld (0e000h),a		;4d1f	32 00 e0 	2 . . 
	jr l4d54h		;4d22	18 30 	. 0 
	ld hl,0e703h		;4d24	21 03 e7 	! . . 
	ld a,(hl)			;4d27	7e 	~ 
	and a			;4d28	a7 	. 
	jr z,l4d2ch		;4d29	28 01 	( . 
	dec (hl)			;4d2b	35 	5 
l4d2ch:
	ld hl,0e705h		;4d2c	21 05 e7 	! . . 
	dec (hl)			;4d2f	35 	5 
	jr nz,l4d7fh		;4d30	20 4d 	  M 
	ld de,(0e70eh)		;4d32	ed 5b 0e e7 	. [ . . 
	ld a,(de)			;4d36	1a 	. 
	and a			;4d37	a7 	. 
	jp m,l4d1dh		;4d38	fa 1d 4d 	. . M 
	bit 6,a		;4d3b	cb 77 	. w 
	jr z,l4d43h		;4d3d	28 04 	( . 
	ld hl,0e020h		;4d3f	21 20 e0 	!   . 
	inc (hl)			;4d42	34 	4 
l4d43h:
	bit 5,a		;4d43	cb 6f 	. o 
	jr z,l4d54h		;4d45	28 0d 	( . 
	push af			;4d47	f5 	. 
	ld hl,l65b7h		;4d48	21 b7 65 	! . e 
	ld a,(hl)			;4d4b	7e 	~ 
	inc hl			;4d4c	23 	# 
	ld (0e70ch),hl		;4d4d	22 0c e7 	" . . 
	ld (0e703h),a		;4d50	32 03 e7 	2 . . 
	pop af			;4d53	f1 	. 
l4d54h:
	ld l,a			;4d54	6f 	o 
	bit 4,l		;4d55	cb 65 	. e 
	jr z,l4d5eh		;4d57	28 05 	( . 
	ld a,002h		;4d59	3e 02 	> . 
	ld (0e703h),a		;4d5b	32 03 e7 	2 . . 
l4d5eh:
	bit 3,l		;4d5e	cb 5d 	. ] 
	jr z,l4d6ah		;4d60	28 08 	( . 
	ld a,(0e701h)		;4d62	3a 01 e7 	: . . 
	xor 040h		;4d65	ee 40 	. @ 
	ld (0e701h),a		;4d67	32 01 e7 	2 . . 
l4d6ah:
	ld a,l			;4d6a	7d 	} 
	and 003h		;4d6b	e6 03 	. . 
	ld (0e021h),a		;4d6d	32 21 e0 	2 ! . 
	inc de			;4d70	13 	. 
	ld a,(de)			;4d71	1a 	. 
	ld (0e705h),a		;4d72	32 05 e7 	2 . . 
	inc de			;4d75	13 	. 
	ld a,(de)			;4d76	1a 	. 
	ld (0e706h),a		;4d77	32 06 e7 	2 . . 
	inc de			;4d7a	13 	. 
	ld (0e70eh),de		;4d7b	ed 53 0e e7 	. S . . 
l4d7fh:
	ld a,(0e021h)		;4d7f	3a 21 e0 	: ! . 
	ld hl,l4dbch		;4d82	21 bc 4d 	! . M 
	call 01f26h		;4d85	cd 26 1f 	. & . 
	ld a,(0e020h)		;4d88	3a 20 e0 	:   . 
	ld ix,0e340h		;4d8b	dd 21 40 e3 	. ! @ . 
	ld c,(ix+000h)		;4d8f	dd 4e 00 	. N . 
	cp 00ah		;4d92	fe 0a 	. . 
	jr z,l4da0h		;4d94	28 0a 	( . 
	jr nc,l4da9h		;4d96	30 11 	0 . 
	and a			;4d98	a7 	. 
	jr nz,l4da6h		;4d99	20 0b 	  . 
	call sub_47d4h		;4d9b	cd d4 47 	. . G 
	jr l4da9h		;4d9e	18 09 	. . 
l4da0h:
	ld de,00036h		;4da0	11 36 00 	. 6 . 
	call 01c7ah		;4da3	cd 7a 1c 	. z . 
l4da6h:
	call sub_4821h		;4da6	cd 21 48 	. ! H 
l4da9h:
	ld a,(0e020h)		;4da9	3a 20 e0 	:   . 
	ld ix,0e262h		;4dac	dd 21 62 e2 	. ! b . 
	ld c,(ix+000h)		;4db0	dd 4e 00 	. N . 
	ld hl,04dc2h		;4db3	21 c2 4d 	! . M 
	call 01f26h		;4db6	cd 26 1f 	. & . 
	jp 02d72h		;4db9	c3 72 2d 	. r - 
l4dbch:
	jp m,0124dh		;4dbc	fa 4d 12 	. M . 
	ld c,(hl)			;4dbf	4e 	N 
	jp c,0244dh		;4dc0	da 4d 24 	. M $ 
	ld c,(hl)			;4dc3	4e 	N 
	dec h			;4dc4	25 	% 
	ld c,(hl)			;4dc5	4e 	N 
	ld a,(0714eh)		;4dc6	3a 4e 71 	: N q 
	ld c,(hl)			;4dc9	4e 	N 
	xor a			;4dca	af 	. 
	ld c,(hl)			;4dcb	4e 	N 
	xor b			;4dcc	a8 	. 
	ld c,(hl)			;4dcd	4e 	N 
	and c			;4dce	a1 	. 
	ld c,(hl)			;4dcf	4e 	N 
	sbc a,d			;4dd0	9a 	. 
	ld c,(hl)			;4dd1	4e 	N 
	sub e			;4dd2	93 	. 
	ld c,(hl)			;4dd3	4e 	N 
	adc a,h			;4dd4	8c 	. 
	ld c,(hl)			;4dd5	4e 	N 
	ld a,a			;4dd6	7f 	 
	ld c,(hl)			;4dd7	4e 	N 
	inc h			;4dd8	24 	$ 
	ld c,(hl)			;4dd9	4e 	N 
	ld hl,(0e70ch)		;4dda	2a 0c e7 	* . . 
	ld e,(hl)			;4ddd	5e 	^ 
	inc hl			;4dde	23 	# 
	ld d,(hl)			;4ddf	56 	V 
	push hl			;4de0	e5 	. 
	ld hl,(0e710h)		;4de1	2a 10 e7 	* . . 
	add hl,de			;4de4	19 	. 
	ld (0e710h),hl		;4de5	22 10 e7 	" . . 
	pop hl			;4de8	e1 	. 
	ld a,(0e703h)		;4de9	3a 03 e7 	: . . 
	and a			;4dec	a7 	. 
	jr nz,l4e12h		;4ded	20 23 	  # 
	inc hl			;4def	23 	# 
	ld a,(hl)			;4df0	7e 	~ 
	inc hl			;4df1	23 	# 
	ld (0e70ch),hl		;4df2	22 0c e7 	" . . 
	ld (0e703h),a		;4df5	32 03 e7 	2 . . 
	jr l4e12h		;4df8	18 18 	. . 
	call l431fh		;4dfa	cd 1f 43 	. . C 
	ld hl,(0e712h)		;4dfd	2a 12 e7 	* . . 
	ld de,0ffe5h		;4e00	11 e5 ff 	. . . 
	ld a,(0e701h)		;4e03	3a 01 e7 	: . . 
	and 040h		;4e06	e6 40 	. @ 
	jr nz,l4e0dh		;4e08	20 03 	  . 
	add hl,de			;4e0a	19 	. 
	jr l4e0fh		;4e0b	18 02 	. . 
l4e0dh:
	sbc hl,de		;4e0d	ed 52 	. R 
l4e0fh:
	ld (0e712h),hl		;4e0f	22 12 e7 	" . . 
l4e12h:
	ld hl,(0e712h)		;4e12	2a 12 e7 	* . . 
	xor a			;4e15	af 	. 
	add hl,hl			;4e16	29 	) 
	rla			;4e17	17 	. 
	add hl,hl			;4e18	29 	) 
	rla			;4e19	17 	. 
	add hl,hl			;4e1a	29 	) 
	rla			;4e1b	17 	. 
	ld l,h			;4e1c	6c 	l 
	ld h,a			;4e1d	67 	g 
	call l40d6h		;4e1e	cd d6 40 	. . @ 
	call sub_40e5h		;4e21	cd e5 40 	. . @ 
	ret			;4e24	c9 	. 
	call 01be7h		;4e25	cd e7 1b 	. . . 
	ld hl,(0e264h)		;4e28	2a 64 e2 	* d . 
	ld de,0e700h		;4e2b	11 00 e7 	. . . 
	add hl,de			;4e2e	19 	. 
	jr nc,l4e6bh		;4e2f	30 3a 	0 : 
	ld hl,0e020h		;4e31	21 20 e0 	!   . 
	inc (hl)			;4e34	34 	4 
	ld hl,l4ee5h		;4e35	21 e5 4e 	! . N 
	jr l4e43h		;4e38	18 09 	. . 
	ld hl,0e269h		;4e3a	21 69 e2 	! i . 
	dec (hl)			;4e3d	35 	5 
	jr nz,l4e68h		;4e3e	20 28 	  ( 
	ld hl,(0e26eh)		;4e40	2a 6e e2 	* n . 
l4e43h:
	ld a,(hl)			;4e43	7e 	~ 
	cp 0ffh		;4e44	fe ff 	. . 
	jr z,l4e76h		;4e46	28 2e 	( . 
	ld (0e268h),a		;4e48	32 68 e2 	2 h . 
	inc hl			;4e4b	23 	# 
	ld a,(hl)			;4e4c	7e 	~ 
	ld (0e269h),a		;4e4d	32 69 e2 	2 i . 
	inc hl			;4e50	23 	# 
	ld a,(hl)			;4e51	7e 	~ 
	and a			;4e52	a7 	. 
	jr z,l4e64h		;4e53	28 0f 	( . 
	push hl			;4e55	e5 	. 
	ld hl,0e32bh		;4e56	21 2b e3 	! + . 
	ld (hl),001h		;4e59	36 01 	6 . 
	inc hl			;4e5b	23 	# 
	ld (hl),a			;4e5c	77 	w 
	inc hl			;4e5d	23 	# 
	ld (hl),040h		;4e5e	36 40 	6 @ 
	inc hl			;4e60	23 	# 
	ld (hl),01ah		;4e61	36 1a 	6 . 
	pop hl			;4e63	e1 	. 
l4e64h:
	inc hl			;4e64	23 	# 
	ld (0e26eh),hl		;4e65	22 6e e2 	" n . 
l4e68h:
	call 01be2h		;4e68	cd e2 1b 	. . . 
l4e6bh:
	bit 4,c		;4e6b	cb 61 	. a 
	jp nz,01a72h		;4e6d	c2 72 1a 	. r . 
	ret			;4e70	c9 	. 
	call sub_4edfh		;4e71	cd df 4e 	. . N 
	jr l4e6bh		;4e74	18 f5 	. . 
l4e76h:
	ld hl,0e020h		;4e76	21 20 e0 	!   . 
	inc (hl)			;4e79	34 	4 
	call 017dfh		;4e7a	cd df 17 	. . . 
	jr l4e68h		;4e7d	18 e9 	. . 
	ld hl,0e2a2h		;4e7f	21 a2 e2 	! . . 
	ld de,00010h		;4e82	11 10 00 	. . . 
	ld b,003h		;4e85	06 03 	. . 
l4e87h:
	set 6,(hl)		;4e87	cb f6 	. . 
	add hl,de			;4e89	19 	. 
	djnz l4e87h		;4e8a	10 fb 	. . 
	ld ix,0e2c2h		;4e8c	dd 21 c2 e2 	. ! . . 
	call sub_4ed7h		;4e90	cd d7 4e 	. . N 
	ld ix,0e2b2h		;4e93	dd 21 b2 e2 	. ! . . 
	call sub_4ed7h		;4e97	cd d7 4e 	. . N 
	ld ix,0e2a2h		;4e9a	dd 21 a2 e2 	. ! . . 
	call sub_4ed7h		;4e9e	cd d7 4e 	. . N 
	ld ix,0e282h		;4ea1	dd 21 82 e2 	. ! . . 
	call sub_4eb3h		;4ea5	cd b3 4e 	. . N 
	ld ix,0e292h		;4ea8	dd 21 92 e2 	. ! . . 
	call sub_4eb3h		;4eac	cd b3 4e 	. . N 
	ld ix,0e272h		;4eaf	dd 21 72 e2 	. ! r . 
sub_4eb3h:
	ld c,(ix+000h)		;4eb3	dd 4e 00 	. N . 
	ld hl,l4ed1h		;4eb6	21 d1 4e 	! . N 
	push hl			;4eb9	e5 	. 
	ld a,(ix+001h)		;4eba	dd 7e 01 	. ~ . 
	cp 001h		;4ebd	fe 01 	. . 
	jr z,sub_4edfh		;4ebf	28 1e 	( . 
	call 015a8h		;4ec1	cd a8 15 	. . . 
	dec (ix+00eh)		;4ec4	dd 35 0e 	. 5 . 
	ret nz			;4ec7	c0 	. 
	ld a,(ix+00fh)		;4ec8	dd 7e 0f 	. ~ . 
	ld (ix+006h),a		;4ecb	dd 77 06 	. w . 
	jp 017dfh		;4ece	c3 df 17 	. . . 
l4ed1h:
	bit 4,c		;4ed1	cb 61 	. a 
	ret z			;4ed3	c8 	. 
	jp 0162fh		;4ed4	c3 2f 16 	. / . 
sub_4ed7h:
	ld c,(ix+000h)		;4ed7	dd 4e 00 	. N . 
	call 01be7h		;4eda	cd e7 1b 	. . . 
	jr l4ed1h		;4edd	18 f2 	. . 
sub_4edfh:
	bit 4,c		;4edf	cb 61 	. a 
	jp nz,01baah		;4ee1	c2 aa 1b 	. . . 
	ret			;4ee4	c9 	. 
l4ee5h:
	dec bc			;4ee5	0b 	. 
	dec bc			;4ee6	0b 	. 
	nop			;4ee7	00 	. 
	inc c			;4ee8	0c 	. 
	jr c,l4f3dh		;4ee9	38 52 	8 R 
	nop			;4eeb	00 	. 
	dec bc			;4eec	0b 	. 
	nop			;4eed	00 	. 
	add hl,bc			;4eee	09 	. 
	dec bc			;4eef	0b 	. 
	nop			;4ef0	00 	. 
	ld a,(bc)			;4ef1	0a 	. 
	jr c,$+82		;4ef2	38 50 	8 P 
	nop			;4ef4	00 	. 
	dec hl			;4ef5	2b 	+ 
	nop			;4ef6	00 	. 
	ld b,00ah		;4ef7	06 0a 	. . 
	nop			;4ef9	00 	. 
	nop			;4efa	00 	. 
	jr l4efdh		;4efb	18 00 	. . 
l4efdh:
	ld b,001h		;4efd	06 01 	. . 
	nop			;4eff	00 	. 
	rst 38h			;4f00	ff 	. 
l4f01h:
	ld b,c			;4f01	41 	A 
	ld d,000h		;4f02	16 00 	. . 
	ld bc,00432h		;4f04	01 32 04 	. 2 . 
	ld bc,0051ch		;4f07	01 1c 05 	. . . 
	ld bc,0042dh		;4f0a	01 2d 04 	. - . 
	ld (01004h),hl		;4f0d	22 04 10 	" . . 
	ld (bc),a			;4f10	02 	. 
	ld b,012h		;4f11	06 12 	. . 
	ld (bc),a			;4f13	02 	. 
	djnz l4f29h		;4f14	10 13 	. . 
	ld (bc),a			;4f16	02 	. 
	ld b,014h		;4f17	06 14 	. . 
	ld (bc),a			;4f19	02 	. 
	inc b			;4f1a	04 	. 
	djnz $+18		;4f1b	10 10 	. . 
	ld hl,00100h		;4f1d	21 00 01 	! . . 
l4f20h:
	dec bc			;4f20	0b 	. 
	inc b			;4f21	04 	. 
	ld (01004h),hl		;4f22	22 04 10 	" . . 
	ld (bc),a			;4f25	02 	. 
	ld b,012h		;4f26	06 12 	. . 
	ld (bc),a			;4f28	02 	. 
l4f29h:
	djnz l4f43h		;4f29	10 18 	. . 
	ld (bc),a			;4f2b	02 	. 
	ld b,014h		;4f2c	06 14 	. . 
l4f2eh:
	ld (bc),a			;4f2e	02 	. 
	inc b			;4f2f	04 	. 
	djnz l4f33h		;4f30	10 01 	. . 
	ex af,af'			;4f32	08 	. 
l4f33h:
	ld b,001h		;4f33	06 01 	. . 
	ex af,af'			;4f35	08 	. 
	rlca			;4f36	07 	. 
	ld bc,00608h		;4f37	01 08 06 	. . . 
	ld bc,00413h		;4f3a	01 13 04 	. . . 
l4f3dh:
	ld b,c			;4f3d	41 	A 
	ld hl,04104h		;4f3e	21 04 41 	! . A 
	ld c,004h		;4f41	0e 04 	. . 
l4f43h:
	ld bc,00808h		;4f43	01 08 08 	. . . 
	ld bc,00908h		;4f46	01 08 09 	. . . 
	ld bc,00802h		;4f49	01 02 08 	. . . 
	ld b,c			;4f4c	41 	A 
	dec b			;4f4d	05 	. 
	ex af,af'			;4f4e	08 	. 
	ld b,c			;4f4f	41 	A 
	ex af,af'			;4f50	08 	. 
	dec b			;4f51	05 	. 
	ld b,c			;4f52	41 	A 
	ex af,af'			;4f53	08 	. 
	dec bc			;4f54	0b 	. 
	ld b,c			;4f55	41 	A 
	ex af,af'			;4f56	08 	. 
	inc c			;4f57	0c 	. 
	ld bc,00b08h		;4f58	01 08 0b 	. . . 
	ld bc,00508h		;4f5b	01 08 05 	. . . 
	ld bc,00d08h		;4f5e	01 08 0d 	. . . 
	ld bc,00e08h		;4f61	01 08 0e 	. . . 
	ld bc,00d09h		;4f64	01 09 0d 	. . . 
	ld b,c			;4f67	41 	A 
	ex af,af'			;4f68	08 	. 
	dec b			;4f69	05 	. 
	ld bc,0041ch		;4f6a	01 1c 04 	. . . 
	add hl,bc			;4f6d	09 	. 
	djnz l4f70h		;4f6e	10 00 	. . 
l4f70h:
	djnz $+41		;4f70	10 27 	. ' 
	nop			;4f72	00 	. 
	ld b,c			;4f73	41 	A 
	pop hl			;4f74	e1 	. 
	inc bc			;4f75	03 	. 
	ld bc,003a9h		;4f76	01 a9 03 	. . . 
	ld bc,00416h		;4f79	01 16 04 	. . . 
	ld bc,00608h		;4f7c	01 08 06 	. . . 
	ld bc,00708h		;4f7f	01 08 07 	. . . 
	ld bc,00608h		;4f82	01 08 06 	. . . 
	ld bc,00408h		;4f85	01 08 04 	. . . 
	ld bc,00808h		;4f88	01 08 08 	. . . 
	ld bc,00908h		;4f8b	01 08 09 	. . . 
	ld bc,00808h		;4f8e	01 08 08 	. . . 
	add hl,bc			;4f91	09 	. 
	ex af,af'			;4f92	08 	. 
	inc b			;4f93	04 	. 
	ld bc,00608h		;4f94	01 08 06 	. . . 
	ld bc,00708h		;4f97	01 08 07 	. . . 
	ld bc,00608h		;4f9a	01 08 06 	. . . 
	ld bc,00408h		;4f9d	01 08 04 	. . . 
	ld bc,00508h		;4fa0	01 08 05 	. . . 
	ld bc,00b08h		;4fa3	01 08 0b 	. . . 
	ld bc,00c08h		;4fa6	01 08 0c 	. . . 
	ld bc,00b08h		;4fa9	01 08 0b 	. . . 
	ld bc,00508h		;4fac	01 08 05 	. . . 
	ld bc,00408h		;4faf	01 08 04 	. . . 
	ld bc,00808h		;4fb2	01 08 08 	. . . 
	ld bc,00908h		;4fb5	01 08 09 	. . . 
	ld bc,00808h		;4fb8	01 08 08 	. . . 
	add hl,bc			;4fbb	09 	. 
	ex af,af'			;4fbc	08 	. 
	dec b			;4fbd	05 	. 
	ld bc,00b08h		;4fbe	01 08 0b 	. . . 
	ld bc,00c08h		;4fc1	01 08 0c 	. . . 
	ld bc,00b08h		;4fc4	01 08 0b 	. . . 
	ld bc,00508h		;4fc7	01 08 05 	. . . 
	ld (01004h),hl		;4fca	22 04 10 	" . . 
	ld (bc),a			;4fcd	02 	. 
	ld b,012h		;4fce	06 12 	. . 
	ld (bc),a			;4fd0	02 	. 
	djnz l4febh		;4fd1	10 18 	. . 
	ld (bc),a			;4fd3	02 	. 
	ld b,014h		;4fd4	06 14 	. . 
	ld (bc),a			;4fd6	02 	. 
	inc b			;4fd7	04 	. 
	djnz $+11		;4fd8	10 09 	. . 
	ex af,af'			;4fda	08 	. 
	inc b			;4fdb	04 	. 
	ld bc,00608h		;4fdc	01 08 06 	. . . 
	ld bc,00708h		;4fdf	01 08 07 	. . . 
	ld bc,00608h		;4fe2	01 08 06 	. . . 
	ld bc,004a9h		;4fe5	01 a9 04 	. . . 
	rst 38h			;4fe8	ff 	. 
	ld a,023h		;4fe9	3e 23 	> # 
l4febh:
	call 00dfeh		;4feb	cd fe 0d 	. . . 
	xor a			;4fee	af 	. 
	ld (0e702h),a		;4fef	32 02 e7 	2 . . 
	ld (0e020h),a		;4ff2	32 20 e0 	2   . 
	ld (0e883h),a		;4ff5	32 83 e8 	2 . . 
	ld a,008h		;4ff8	3e 08 	> . 
	ld (0e000h),a		;4ffa	32 00 e0 	2 . . 
	call sub_5095h		;4ffd	cd 95 50 	. . P 
l5000h:
	ld c,0d9h		;5000	0e d9 	. . 
	ld hl,l5132h		;5002	21 32 51 	! 2 Q 
	call 0111ch		;5005	cd 1c 11 	. . . 
	ld hl,l5147h		;5008	21 47 51 	! G Q 
	call 0111ch		;500b	cd 1c 11 	. . . 
	ld hl,l5157h		;500e	21 57 51 	! W Q 
	call 0111ch		;5011	cd 1c 11 	. . . 
	ld hl,l5162h		;5014	21 62 51 	! b Q 
	call 0111ch		;5017	cd 1c 11 	. . . 
	ld hl,l516dh		;501a	21 6d 51 	! m Q 
	call 0111ch		;501d	cd 1c 11 	. . . 
	ld hl,l50a7h		;5020	21 a7 50 	! . P 
	call sub_5079h		;5023	cd 79 50 	. y P 
	ld a,0f8h		;5026	3e f8 	> . 
	call sub_5038h		;5028	cd 38 50 	. 8 P 
	call sub_5091h		;502b	cd 91 50 	. . P 
	ld hl,l50ffh		;502e	21 ff 50 	! . P 
	ld c,0d9h		;5031	0e d9 	. . 
	call sub_5079h		;5033	cd 79 50 	. y P 
	ld a,0f8h		;5036	3e f8 	> . 
sub_5038h:
	push hl			;5038	e5 	. 
	push bc			;5039	c5 	. 
	push de			;503a	d5 	. 
	ld (0e882h),a		;503b	32 82 e8 	2 . . 
	ld c,0d9h		;503e	0e d9 	. . 
l5040h:
	ld hl,0e883h		;5040	21 83 e8 	! . . 
	ld a,(hl)			;5043	7e 	~ 
	and a			;5044	a7 	. 
	jr nz,l5061h		;5045	20 1a 	  . 
	ld (hl),00bh		;5047	36 0b 	6 . 
	ld hl,0e020h		;5049	21 20 e0 	!   . 
	dec (hl)			;504c	35 	5 
	dec (hl)			;504d	35 	5 
	jp p,l5053h		;504e	f2 53 50 	. S P 
	ld (hl),008h		;5051	36 08 	6 . 
l5053h:
	ld e,(hl)			;5053	5e 	^ 
	ld d,000h		;5054	16 00 	. . 
	ld hl,l506bh		;5056	21 6b 50 	! k P 
	add hl,de			;5059	19 	. 
	ld a,(hl)			;505a	7e 	~ 
	inc hl			;505b	23 	# 
	ld h,(hl)			;505c	66 	f 
	ld l,a			;505d	6f 	o 
	call 0111ch		;505e	cd 1c 11 	. . . 
l5061h:
	ld a,(0e882h)		;5061	3a 82 e8 	: . . 
	and a			;5064	a7 	. 
	jr nz,l5040h		;5065	20 d9 	  . 
	pop de			;5067	d1 	. 
	pop bc			;5068	c1 	. 
	pop hl			;5069	e1 	. 
	ret			;506a	c9 	. 
l506bh:
	ld e,l			;506b	5d 	] 
	ld d,c			;506c	51 	Q 
	ld l,b			;506d	68 	h 
	ld d,c			;506e	51 	Q 
	ld c,l			;506f	4d 	M 
	ld d,c			;5070	51 	Q 
	dec l			;5071	2d 	- 
	ld d,c			;5072	51 	Q 
	dec a			;5073	3d 	= 
	ld d,c			;5074	51 	Q 
l5075h:
	ld e,(hl)			;5075	5e 	^ 
	inc hl			;5076	23 	# 
	ld d,(hl)			;5077	56 	V 
	inc hl			;5078	23 	# 
sub_5079h:
	ld a,(hl)			;5079	7e 	~ 
	inc hl			;507a	23 	# 
	inc a			;507b	3c 	< 
	ret z			;507c	c8 	. 
	inc a			;507d	3c 	< 
	inc a			;507e	3c 	< 
	jr z,l5075h		;507f	28 f4 	( . 
	sub 003h		;5081	d6 03 	. . 
	call 01110h		;5083	cd 10 11 	. . . 
	cp 020h		;5086	fe 20 	.   
	jr nz,sub_5079h		;5088	20 ef 	  . 
	ld a,00bh		;508a	3e 0b 	> . 
	call sub_5038h		;508c	cd 38 50 	. 8 P 
	jr sub_5079h		;508f	18 e8 	. . 
sub_5091h:
	ld b,008h		;5091	06 08 	. . 
	jr l5097h		;5093	18 02 	. . 
sub_5095h:
	ld b,019h		;5095	06 19 	. . 
l5097h:
	ld c,00bh		;5097	0e 0b 	. . 
	ld de,0d19fh		;5099	11 9f d1 	. . . 
l509ch:
	call sub_571ah		;509c	cd 1a 57 	. . W 
	ld hl,0001fh		;509f	21 1f 00 	! . . 
	add hl,de			;50a2	19 	. 
	ex de,hl			;50a3	eb 	. 
	djnz l509ch		;50a4	10 f6 	. . 
	ret			;50a6	c9 	. 
l50a7h:
	defb 0fdh,063h,0d2h	;illegal sequence		;50a7	fd 63 d2 	. c . 
	ld b,c			;50aa	41 	A 
	jr nz,$+77		;50ab	20 4b 	  K 
	ld d,l			;50ad	55 	U 
	ld c,(hl)			;50ae	4e 	N 
	ld b,a			;50af	47 	G 
	dec l			;50b0	2d 	- 
	ld b,(hl)			;50b1	46 	F 
	ld d,l			;50b2	55 	U 
	jr nz,l5102h		;50b3	20 4d 	  M 
	ld b,c			;50b5	41 	A 
	ld d,e			;50b6	53 	S 
	ld d,h			;50b7	54 	T 
	ld b,l			;50b8	45 	E 
	ld d,d			;50b9	52 	R 
	inc l			;50ba	2c 	, 
	ld d,h			;50bb	54 	T 
	ld c,b			;50bc	48 	H 
	ld c,a			;50bd	4f 	O 
	ld c,l			;50be	4d 	M 
	ld b,c			;50bf	41 	A 
	ld d,e			;50c0	53 	S 
	jr nz,l5104h		;50c1	20 41 	  A 
	ld c,(hl)			;50c3	4e 	N 
l50c4h:
	ld b,h			;50c4	44 	D 
	jr nz,l50c4h		;50c5	20 fd 	  . 
	ex (sp),hl			;50c7	e3 	. 
	jp nc,04953h		;50c8	d2 53 49 	. S I 
	ld c,h			;50cb	4c 	L 
	ld d,(hl)			;50cc	56 	V 
	ld c,c			;50cd	49 	I 
	ld b,c			;50ce	41 	A 
	jr nz,l5116h		;50cf	20 45 	  E 
	ld c,(hl)			;50d1	4e 	N 
	ld c,d			;50d2	4a 	J 
	ld c,a			;50d3	4f 	O 
	ld e,c			;50d4	59 	Y 
	ld b,l			;50d5	45 	E 
	ld b,h			;50d6	44 	D 
	jr nz,l5121h		;50d7	20 48 	  H 
	ld b,c			;50d9	41 	A 
	ld d,b			;50da	50 	P 
	ld d,b			;50db	50 	P 
	ld c,c			;50dc	49 	I 
	ld c,(hl)			;50dd	4e 	N 
	ld b,l			;50de	45 	E 
	ld d,e			;50df	53 	S 
l50e0h:
	ld d,e			;50e0	53 	S 
	jr nz,l50e0h		;50e1	20 fd 	  . 
	ld h,e			;50e3	63 	c 
	out (041h),a		;50e4	d3 41 	. A 
	ld b,a			;50e6	47 	G 
	ld b,c			;50e7	41 	A 
	ld c,c			;50e8	49 	I 
	ld c,(hl)			;50e9	4e 	N 
	jr nz,l5132h		;50ea	20 46 	  F 
	ld c,a			;50ec	4f 	O 
l50edh:
	ld d,d			;50ed	52 	R 
	jr nz,l5131h		;50ee	20 41 	  A 
	jr nz,$+78		;50f0	20 4c 	  L 
	ld c,c			;50f2	49 	I 
	ld d,h			;50f3	54 	T 
	ld d,h			;50f4	54 	T 
	ld c,h			;50f5	4c 	L 
	ld b,l			;50f6	45 	E 
	jr nz,l5150h		;50f7	20 57 	  W 
	ld c,b			;50f9	48 	H 
	ld c,c			;50fa	49 	I 
	ld c,h			;50fb	4c 	L 
	ld b,l			;50fc	45 	E 
	ld l,0ffh		;50fd	2e ff 	. . 
l50ffh:
	and (iy-02eh)		;50ff	fd a6 d2 	. . . 
l5102h:
	ld b,d			;5102	42 	B 
	ld d,l			;5103	55 	U 
l5104h:
	ld d,h			;5104	54 	T 
	jr nz,l515bh		;5105	20 54 	  T 
	ld c,b			;5107	48 	H 
	ld b,l			;5108	45 	E 
	ld c,c			;5109	49 	I 
	ld d,d			;510a	52 	R 
	jr nz,l5155h		;510b	20 48 	  H 
	ld b,c			;510d	41 	A 
	ld d,b			;510e	50 	P 
	ld d,b			;510f	50 	P 
	ld e,c			;5110	59 	Y 
	jr nz,l5157h		;5111	20 44 	  D 
	ld b,c			;5113	41 	A 
	ld e,c			;5114	59 	Y 
l5115h:
	ld d,e			;5115	53 	S 
l5116h:
	jr nz,l5115h		;5116	20 fd 	  . 
	jr z,l50edh		;5118	28 d3 	( . 
	ld b,h			;511a	44 	D 
	ld c,c			;511b	49 	I 
	ld b,h			;511c	44 	D 
	jr nz,l516dh		;511d	20 4e 	  N 
	ld c,a			;511f	4f 	O 
	ld d,h			;5120	54 	T 
l5121h:
	jr nz,$+78		;5121	20 4c 	  L 
	ld b,c			;5123	41 	A 
	ld d,e			;5124	53 	S 
	ld d,h			;5125	54 	T 
	jr nz,$+78		;5126	20 4c 	  L 
	ld c,a			;5128	4f 	O 
	ld c,(hl)			;5129	4e 	N 
	ld b,a			;512a	47 	G 
	ld l,0ffh		;512b	2e ff 	. . 
	defb 0fdh,02eh,0d4h	;illegal sequence		;512d	fd 2e d4 	. . . 
	nop			;5130	00 	. 
l5131h:
	nop			;5131	00 	. 
l5132h:
	defb 0fdh,0ach,0d4h	;illegal sequence		;5132	fd ac d4 	. . . 
	ld h,b			;5135	60 	` 
	ld h,c			;5136	61 	a 
	defb 0fdh,0ech,0d4h	;illegal sequence		;5137	fd ec d4 	. . . 
	ld h,d			;513a	62 	b 
	ld h,e			;513b	63 	c 
	rst 38h			;513c	ff 	. 
	defb 0fdh,0ach,0d4h	;illegal sequence		;513d	fd ac d4 	. . . 
	nop			;5140	00 	. 
	nop			;5141	00 	. 
	defb 0fdh,0ech,0d4h	;illegal sequence		;5142	fd ec d4 	. . . 
	nop			;5145	00 	. 
	nop			;5146	00 	. 
l5147h:
	defb 0fdh,06dh,0d4h	;illegal sequence		;5147	fd 6d d4 	. m . 
	ld h,h			;514a	64 	d 
	ld h,l			;514b	65 	e 
	rst 38h			;514c	ff 	. 
	defb 0fdh,0b0h,0d4h	;illegal sequence		;514d	fd b0 d4 	. . . 
l5150h:
	nop			;5150	00 	. 
	nop			;5151	00 	. 
	defb 0fdh,0f0h,0d4h	;illegal sequence		;5152	fd f0 d4 	. . . 
l5155h:
	nop			;5155	00 	. 
	nop			;5156	00 	. 
l5157h:
	defb 0fdh,02eh,0d4h	;illegal sequence		;5157	fd 2e d4 	. . . 
	ld h,(hl)			;515a	66 	f 
l515bh:
	ld h,a			;515b	67 	g 
	rst 38h			;515c	ff 	. 
	defb 0fdh,06dh,0d4h	;illegal sequence		;515d	fd 6d d4 	. m . 
	nop			;5160	00 	. 
	nop			;5161	00 	. 
l5162h:
	defb 0fdh,06fh,0d4h	;illegal sequence		;5162	fd 6f d4 	. o . 
	ld l,b			;5165	68 	h 
	ld l,c			;5166	69 	i 
	rst 38h			;5167	ff 	. 
	defb 0fdh,06fh,0d4h	;illegal sequence		;5168	fd 6f d4 	. o . 
	nop			;516b	00 	. 
	nop			;516c	00 	. 
l516dh:
	defb 0fdh,0b0h,0d4h	;illegal sequence		;516d	fd b0 d4 	. . . 
	ld l,d			;5170	6a 	j 
	ld l,e			;5171	6b 	k 
	defb 0fdh,0f0h,0d4h	;illegal sequence		;5172	fd f0 d4 	. . . 
	ld l,h			;5175	6c 	l 
	ld l,l			;5176	6d 	m 
	rst 38h			;5177	ff 	. 
	ld hl,0e005h		;5178	21 05 e0 	! . . 
	set 7,(hl)		;517b	cb fe 	. . 
	call 01157h		;517d	cd 57 11 	. W . 
	call sub_5703h		;5180	cd 03 57 	. . W 
l5183h:
	ld de,0d25ah		;5183	11 5a d2 	. Z . 
	ld c,014h		;5186	0e 14 	. . 
	ld a,(0e880h)		;5188	3a 80 e8 	: . . 
	and 018h		;518b	e6 18 	. . 
	jr z,l5197h		;518d	28 08 	( . 
	ld hl,l51d8h		;518f	21 d8 51 	! . Q 
	call 0111ch		;5192	cd 1c 11 	. . . 
	jr l519ah		;5195	18 03 	. . 
l5197h:
	call sub_5725h		;5197	cd 25 57 	. % W 
l519ah:
	ld de,0d319h		;519a	11 19 d3 	. . . 
	ld a,(0e913h)		;519d	3a 13 e9 	: . . 
	push af			;51a0	f5 	. 
	cp 001h		;51a1	fe 01 	. . 
	ld hl,l51e5h		;51a3	21 e5 51 	! . Q 
	jr z,l51abh		;51a6	28 03 	( . 
	ld hl,l51f3h		;51a8	21 f3 51 	! . Q 
l51abh:
	call 0111ch		;51ab	cd 1c 11 	. . . 
	ld hl,l5202h		;51ae	21 02 52 	! . R 
	call 0111ch		;51b1	cd 1c 11 	. . . 
	pop af			;51b4	f1 	. 
	call 010ffh		;51b5	cd ff 10 	. . . 
	ld a,(0e904h)		;51b8	3a 04 e9 	: . . 
	and 003h		;51bb	e6 03 	. . 
	jr z,l5183h		;51bd	28 c4 	( . 
	and 002h		;51bf	e6 02 	. . 
	ld (0e002h),a		;51c1	32 02 e0 	2 . . 
	ld b,001h		;51c4	06 01 	. . 
	jr z,l51c9h		;51c6	28 01 	( . 
	inc b			;51c8	04 	. 
l51c9h:
	ld hl,0e913h		;51c9	21 13 e9 	! . . 
	ld a,(hl)			;51cc	7e 	~ 
	sub b			;51cd	90 	. 
	jr c,l5183h		;51ce	38 b3 	8 . 
	daa			;51d0	27 	' 
	ld (hl),a			;51d1	77 	w 
	ld hl,0e005h		;51d2	21 05 e0 	! . . 
	res 7,(hl)		;51d5	cb be 	. . 
	ret			;51d7	c9 	. 
l51d8h:
	ld d,b			;51d8	50 	P 
	ld d,l			;51d9	55 	U 
	ld d,e			;51da	53 	S 
	ld c,b			;51db	48 	H 
	jr nz,l51feh		;51dc	20 20 	    
	ld b,d			;51de	42 	B 
	ld d,l			;51df	55 	U 
	ld d,h			;51e0	54 	T 
	ld d,h			;51e1	54 	T 
	ld c,a			;51e2	4f 	O 
	ld c,(hl)			;51e3	4e 	N 
	rst 38h			;51e4	ff 	. 
l51e5h:
	ld c,a			;51e5	4f 	O 
	ld c,(hl)			;51e6	4e 	N 
	ld c,h			;51e7	4c 	L 
	ld e,c			;51e8	59 	Y 
	jr nz,$+51		;51e9	20 31 	  1 
	jr nz,l523dh		;51eb	20 50 	  P 
	ld c,h			;51ed	4c 	L 
	ld b,c			;51ee	41 	A 
	ld e,c			;51ef	59 	Y 
	ld b,l			;51f0	45 	E 
	ld d,d			;51f1	52 	R 
	rst 38h			;51f2	ff 	. 
l51f3h:
	ld sp,l4f20h		;51f3	31 20 4f 	1   O 
	ld d,d			;51f6	52 	R 
	jr nz,$+52		;51f7	20 32 	  2 
	jr nz,$+82		;51f9	20 50 	  P 
	ld c,h			;51fb	4c 	L 
	ld b,c			;51fc	41 	A 
	ld e,c			;51fd	59 	Y 
l51feh:
	ld b,l			;51fe	45 	E 
	ld d,d			;51ff	52 	R 
l5200h:
	ld d,e			;5200	53 	S 
	rst 38h			;5201	ff 	. 
l5202h:
	pop iy		;5202	fd e1 	. . 
	push de			;5204	d5 	. 
	ld b,e			;5205	43 	C 
	ld d,d			;5206	52 	R 
	ld b,l			;5207	45 	E 
	ld b,h			;5208	44 	D 
	ld c,c			;5209	49 	I 
	ld d,h			;520a	54 	T 
	jr nz,$+1		;520b	20 ff 	  . 
	call 01157h		;520d	cd 57 11 	. W . 
	call sub_5703h		;5210	cd 03 57 	. . W 
	ld a,020h		;5213	3e 20 	>   
	call 00dfeh		;5215	cd fe 0d 	. . . 
	ld c,01bh		;5218	0e 1b 	. . 
	ld de,0d153h		;521a	11 53 d1 	. S . 
	ld b,017h		;521d	06 17 	. . 
l521fh:
	call sub_5725h		;521f	cd 25 57 	. % W 
	ld hl,00026h		;5222	21 26 00 	! & . 
	add hl,de			;5225	19 	. 
	ex de,hl			;5226	eb 	. 
	djnz l521fh		;5227	10 f6 	. . 
	ld hl,l5232h		;5229	21 32 52 	! 2 R 
	call sub_5739h		;522c	cd 39 57 	. 9 W 
	jp 0111ch		;522f	c3 1c 11 	. . . 
l5232h:
	defb 0fdh,055h,0d1h	;illegal sequence		;5232	fd 55 d1 	. U . 
	call z,sub_60fdh		;5235	cc fd 60 	. . ` 
	pop de			;5238	d1 	. 
	call z,sub_67fdh		;5239	cc fd 67 	. . g 
	pop de			;523c	d1 	. 
l523dh:
	call z,092fdh		;523d	cc fd 92 	. . . 
	out (0e3h),a		;5240	d3 e3 	. . 
	defb 0fdh,0d1h,0d3h	;illegal sequence		;5242	fd d1 d3 	. . . 
	exx			;5245	d9 	. 
	ret c			;5246	d8 	. 
	nop			;5247	00 	. 
	ret nc			;5248	d0 	. 
l5249h:
	pop de			;5249	d1 	. 
	call 010fdh		;524a	cd fd 10 	. . . 
	call nc,0dbe0h		;524d	d4 e0 db 	. . . 
	jp c,0d200h		;5250	da 00 d2 	. . . 
	out (0cfh),a		;5253	d3 cf 	. . 
	defb 0fdh,050h,0d4h	;illegal sequence		;5255	fd 50 d4 	. P . 
	jp po,0dc07h		;5258	e2 07 dc 	. . . 
	defb 0ddh,0d4h,0d5h	;illegal sequence		;525b	dd d4 d5 	. . . 
	defb 0fdh,090h,0d4h	;illegal sequence		;525e	fd 90 d4 	. . . 
	call po,0de07h		;5261	e4 07 de 	. . . 
l5264h:
	rst 18h			;5264	df 	. 
	sub 0d7h		;5265	d6 d7 	. . 
	defb 0fdh,0d0h,0d4h	;illegal sequence		;5267	fd d0 d4 	. . . 
	and 007h		;526a	e6 07 	. . 
	rlca			;526c	07 	. 
	rlca			;526d	07 	. 
	push hl			;526e	e5 	. 
	defb 0fdh,010h,0d5h	;illegal sequence		;526f	fd 10 d5 	. . . 
	pop hl			;5272	e1 	. 
	rlca			;5273	07 	. 
	ret pe			;5274	e8 	. 
	jp (hl)			;5275	e9 	. 
	rst 20h			;5276	e7 	. 
	defb 0fdh,050h,0d5h	;illegal sequence		;5277	fd 50 d5 	. P . 
	rlca			;527a	07 	. 
	rlca			;527b	07 	. 
	jp pe,0fdebh		;527c	ea eb fd 	. . . 
	sub b			;527f	90 	. 
	push de			;5280	d5 	. 
	rlca			;5281	07 	. 
	rlca			;5282	07 	. 
	call pe,0fdedh		;5283	ec ed fd 	. . . 
	ret nc			;5286	d0 	. 
	push de			;5287	d5 	. 
	rlca			;5288	07 	. 
	rst 28h			;5289	ef 	. 
	xor 0fdh		;528a	ee fd 	. . 
	djnz l5264h		;528c	10 d6 	. . 
	rlca			;528e	07 	. 
	pop af			;528f	f1 	. 
	defb 0fdh,050h,0d6h	;illegal sequence		;5290	fd 50 d6 	. P . 
	ret p			;5293	f0 	. 
	di			;5294	f3 	. 
	defb 0fdh,090h,0d6h	;illegal sequence		;5295	fd 90 d6 	. . . 
	jp p,0d0fdh		;5298	f2 fd d0 	. . . 
	sub 0f4h		;529b	d6 f4 	. . 
	defb 0fdh,0d6h,0d6h	;illegal sequence		;529d	fd d6 d6 	. . . 
	adc a,0fdh		;52a0	ce fd 	. . 
	call po,0ced6h		;52a2	e4 d6 ce 	. . . 
	cp 0fdh		;52a5	fe fd 	. . 
	xor l			;52a7	ad 	. 
	out (0e3h),a		;52a8	d3 e3 	. . 
	jp (iy)		;52aa	fd e9 	. . 
	out (0cdh),a		;52ac	d3 cd 	. . 
	pop de			;52ae	d1 	. 
	ret nc			;52af	d0 	. 
	nop			;52b0	00 	. 
	ret c			;52b1	d8 	. 
	exx			;52b2	d9 	. 
	add iy,iy		;52b3	fd 29 	. ) 
	call nc,0d3cfh		;52b5	d4 cf d3 	. . . 
	jp nc,0da00h		;52b8	d2 00 da 	. . . 
	in a,(0e0h)		;52bb	db e0 	. . 
	defb 0fdh,06ah,0d4h	;illegal sequence		;52bd	fd 6a d4 	. j . 
	push de			;52c0	d5 	. 
	call nc,0dcddh		;52c1	d4 dd dc 	. . . 
	rlca			;52c4	07 	. 
	jp po,0aafdh		;52c5	e2 fd aa 	. . . 
	call nc,0d6d7h		;52c8	d4 d7 d6 	. . . 
	rst 18h			;52cb	df 	. 
	sbc a,007h		;52cc	de 07 	. . 
	call po,0ebfdh		;52ce	e4 fd eb 	. . . 
	call nc,007e5h		;52d1	d4 e5 07 	. . . 
	rlca			;52d4	07 	. 
	rlca			;52d5	07 	. 
	and 0fdh		;52d6	e6 fd 	. . 
	dec hl			;52d8	2b 	+ 
	push de			;52d9	d5 	. 
	rst 20h			;52da	e7 	. 
	jp (hl)			;52db	e9 	. 
	ret pe			;52dc	e8 	. 
	rlca			;52dd	07 	. 
	pop hl			;52de	e1 	. 
	defb 0fdh,06ch,0d5h	;illegal sequence		;52df	fd 6c d5 	. l . 
	ex de,hl			;52e2	eb 	. 
	jp pe,00707h		;52e3	ea 07 07 	. . . 
	defb 0fdh,0ach,0d5h	;illegal sequence		;52e6	fd ac d5 	. . . 
	defb 0edh;next byte illegal after ed		;52e9	ed 	. 
	call pe,00707h		;52ea	ec 07 07 	. . . 
	defb 0fdh,0edh,0d5h	;illegal sequence		;52ed	fd ed d5 	. . . 
	xor 0efh		;52f0	ee ef 	. . 
	rlca			;52f2	07 	. 
	defb 0fdh,02eh,0d6h	;illegal sequence		;52f3	fd 2e d6 	. . . 
	pop af			;52f6	f1 	. 
	rlca			;52f7	07 	. 
	ld l,(iy-02ah)		;52f8	fd 6e d6 	. n . 
	di			;52fb	f3 	. 
	ret p			;52fc	f0 	. 
	defb 0fdh,0afh,0d6h	;illegal sequence		;52fd	fd af d6 	. . . 
	jp p,0effdh		;5300	f2 fd ef 	. . . 
	sub 0f4h		;5303	d6 f4 	. . 
	rst 38h			;5305	ff 	. 
	cp 01bh		;5306	fe 1b 	. . 
	defb 0fdh,017h,0d2h	;illegal sequence		;5308	fd 17 d2 	. . . 
	ld e,c			;530b	59 	Y 
	ld c,a			;530c	4f 	O 
	ld d,l			;530d	55 	U 
	ld d,d			;530e	52 	R 
	jr nz,l535dh		;530f	20 4c 	  L 
	ld c,a			;5311	4f 	O 
	ld d,(hl)			;5312	56 	V 
	ld b,l			;5313	45 	E 
l5314h:
	jr nz,l5314h		;5314	20 fe 	  . 
	rra			;5316	1f 	. 
	ld d,e			;5317	53 	S 
	ld c,c			;5318	49 	I 
	ld c,h			;5319	4c 	L 
	ld d,(hl)			;531a	56 	V 
	ld c,c			;531b	49 	I 
	ld b,c			;531c	41 	A 
	cp 01bh		;531d	fe 1b 	. . 
	defb 0fdh,097h,0d2h	;illegal sequence		;531f	fd 97 d2 	. . . 
	ld c,c			;5322	49 	I 
	ld d,e			;5323	53 	S 
	jr nz,l536fh		;5324	20 49 	  I 
	ld c,(hl)			;5326	4e 	N 
	jr nz,l536ch		;5327	20 43 	  C 
	ld d,l			;5329	55 	U 
	ld d,e			;532a	53 	S 
	ld d,h			;532b	54 	T 
	ld c,a			;532c	4f 	O 
	ld b,h			;532d	44 	D 
	ld e,c			;532e	59 	Y 
	jr nz,l537fh		;532f	20 4e 	  N 
	ld c,a			;5331	4f 	O 
	ld d,a			;5332	57 	W 
	ld l,0fdh		;5333	2e fd 	. . 
	ld d,0d3h		;5335	16 d3 	. . 
	ld c,c			;5337	49 	I 
	ld b,(hl)			;5338	46 	F 
	jr nz,l5394h		;5339	20 59 	  Y 
	ld c,a			;533b	4f 	O 
	ld d,l			;533c	55 	U 
	jr nz,l5396h		;533d	20 57 	  W 
	ld b,c			;533f	41 	A 
	ld c,(hl)			;5340	4e 	N 
	ld d,h			;5341	54 	T 
	jr nz,l5398h		;5342	20 54 	  T 
	ld c,a			;5344	4f 	O 
	jr nz,$+85		;5345	20 53 	  S 
	ld b,c			;5347	41 	A 
	ld d,(hl)			;5348	56 	V 
	ld b,l			;5349	45 	E 
	defb 0fdh,097h,0d3h	;illegal sequence		;534a	fd 97 d3 	. . . 
	ld e,c			;534d	59 	Y 
	ld c,a			;534e	4f 	O 
	ld d,l			;534f	55 	U 
	ld d,d			;5350	52 	R 
	jr nz,l5397h		;5351	20 44 	  D 
	ld b,l			;5353	45 	E 
	ld b,c			;5354	41 	A 
	ld d,d			;5355	52 	R 
l5356h:
	jr nz,l5356h		;5356	20 fe 	  . 
	rra			;5358	1f 	. 
	ld d,e			;5359	53 	S 
	ld c,c			;535a	49 	I 
	ld c,h			;535b	4c 	L 
	ld d,(hl)			;535c	56 	V 
l535dh:
	ld c,c			;535d	49 	I 
	ld b,c			;535e	41 	A 
	daa			;535f	27 	' 
	ld d,e			;5360	53 	S 
	add iy,de		;5361	fd 19 	. . 
	call nc,01ffeh		;5363	d4 fe 1f 	. . . 
	ld c,h			;5366	4c 	L 
	ld c,c			;5367	49 	I 
	ld b,(hl)			;5368	46 	F 
	ld b,l			;5369	45 	E 
	cp 01bh		;536a	fe 1b 	. . 
l536ch:
	inc l			;536c	2c 	, 
	jr nz,l53b2h		;536d	20 43 	  C 
l536fh:
	ld c,a			;536f	4f 	O 
	ld c,l			;5370	4d 	M 
	ld b,l			;5371	45 	E 
	jr nz,$+86		;5372	20 54 	  T 
	ld c,a			;5374	4f 	O 
	defb 0fdh,097h,0d4h	;illegal sequence		;5375	fd 97 d4 	. . . 
	ld d,h			;5378	54 	T 
	ld c,b			;5379	48 	H 
	ld b,l			;537a	45 	E 
	jr nz,$+70		;537b	20 44 	  D 
	ld b,l			;537d	45 	E 
	ld d,(hl)			;537e	56 	V 
l537fh:
	ld c,c			;537f	49 	I 
	ld c,h			;5380	4c 	L 
	daa			;5381	27 	' 
	ld d,e			;5382	53 	S 
	jr nz,l53d9h		;5383	20 54 	  T 
	ld b,l			;5385	45 	E 
	ld c,l			;5386	4d 	M 
	ld d,b			;5387	50 	P 
	ld c,h			;5388	4c 	L 
	ld b,l			;5389	45 	E 
	defb 0fdh,017h,0d5h	;illegal sequence		;538a	fd 17 d5 	. . . 
	ld b,c			;538d	41 	A 
	ld d,h			;538e	54 	T 
	jr nz,$+81		;538f	20 4f 	  O 
	ld c,(hl)			;5391	4e 	N 
	ld b,e			;5392	43 	C 
	ld b,l			;5393	45 	E 
l5394h:
	ld l,0fdh		;5394	2e fd 	. . 
l5396h:
	sub (hl)			;5396	96 	. 
l5397h:
	push de			;5397	d5 	. 
l5398h:
	dec (hl)			;5398	35 	5 
	jr nz,$+85		;5399	20 53 	  S 
	ld c,a			;539b	4f 	O 
	ld c,(hl)			;539c	4e 	N 
	ld d,e			;539d	53 	S 
	jr nz,l53efh		;539e	20 4f 	  O 
	ld b,(hl)			;53a0	46 	F 
	jr nz,l53f7h		;53a1	20 54 	  T 
	ld c,b			;53a3	48 	H 
	ld b,l			;53a4	45 	E 
	jr nz,l53ebh		;53a5	20 44 	  D 
	ld b,l			;53a7	45 	E 
	ld d,(hl)			;53a8	56 	V 
	ld c,c			;53a9	49 	I 
	ld c,h			;53aa	4c 	L 
	defb 0fdh,017h,0d6h	;illegal sequence		;53ab	fd 17 d6 	. . . 
	ld d,a			;53ae	57 	W 
	ld c,c			;53af	49 	I 
	ld c,h			;53b0	4c 	L 
	ld c,h			;53b1	4c 	L 
l53b2h:
	jr nz,$+71		;53b2	20 45 	  E 
	ld c,(hl)			;53b4	4e 	N 
	ld d,h			;53b5	54 	T 
	ld b,l			;53b6	45 	E 
	ld d,d			;53b7	52 	R 
	ld d,h			;53b8	54 	T 
	ld b,c			;53b9	41 	A 
	ld c,c			;53ba	49 	I 
	ld c,(hl)			;53bb	4e 	N 
	jr nz,$+91		;53bc	20 59 	  Y 
	ld c,a			;53be	4f 	O 
	ld d,l			;53bf	55 	U 
	ld l,0ffh		;53c0	2e ff 	. . 
	call sub_5700h		;53c2	cd 00 57 	. . W 
	ld a,005h		;53c5	3e 05 	> . 
	call 00dfeh		;53c7	cd fe 0d 	. . . 
	ld a,(0e080h)		;53ca	3a 80 e0 	: . . 
	push af			;53cd	f5 	. 
	ld a,004h		;53ce	3e 04 	> . 
	ld (0e080h),a		;53d0	32 80 e0 	2 . . 
	call 0064ah		;53d3	cd 4a 06 	. J . 
	ld hl,05400h		;53d6	21 00 54 	! . T 
l53d9h:
	ld (0e710h),hl		;53d9	22 10 e7 	" . . 
	ld (0e344h),hl		;53dc	22 44 e3 	" D . 
	ld hl,02700h		;53df	21 00 27 	! . ' 
	ld (0e712h),hl		;53e2	22 12 e7 	" . . 
	ld hl,01a00h		;53e5	21 00 1a 	! . . 
	ld (0e342h),hl		;53e8	22 42 e3 	" B . 
l53ebh:
	pop af			;53eb	f1 	. 
	ld (0e080h),a		;53ec	32 80 e0 	2 . . 
l53efh:
	ld hl,l5447h		;53ef	21 47 54 	! G T 
	call 0111ch		;53f2	cd 1c 11 	. . . 
	ld a,007h		;53f5	3e 07 	> . 
l53f7h:
	ld (0e000h),a		;53f7	32 00 e0 	2 . . 
	ld a,070h		;53fa	3e 70 	> p 
	call sub_5416h		;53fc	cd 16 54 	. . T 
	ld hl,l54abh		;53ff	21 ab 54 	! . T 
	call 0111ch		;5402	cd 1c 11 	. . . 
	ld a,005h		;5405	3e 05 	> . 
	call 00dfeh		;5407	cd fe 0d 	. . . 
	ld a,070h		;540a	3e 70 	> p 
	call sub_5416h		;540c	cd 16 54 	. . T 
	ld a,005h		;540f	3e 05 	> . 
	call 00dfeh		;5411	cd fe 0d 	. . . 
	ld a,0c0h		;5414	3e c0 	> . 
sub_5416h:
	ld (0e882h),a		;5416	32 82 e8 	2 . . 
l5419h:
	ld a,(0e880h)		;5419	3a 80 e8 	: . . 
	ld de,0d295h		;541c	11 95 d2 	. . . 
	ld c,0d9h		;541f	0e d9 	. . 
	ld hl,l5485h		;5421	21 85 54 	! . T 
	and 018h		;5424	e6 18 	. . 
	jr nz,l542bh		;5426	20 03 	  . 
	ld hl,05498h		;5428	21 98 54 	! . T 
l542bh:
	call 0111ch		;542b	cd 1c 11 	. . . 
	ld hl,0e882h		;542e	21 82 e8 	! . . 
	ld a,(hl)			;5431	7e 	~ 
	and a			;5432	a7 	. 
	jr nz,l5419h		;5433	20 e4 	  . 
	ret			;5435	c9 	. 
	ld hl,0e703h		;5436	21 03 e7 	! . . 
	ld a,(hl)			;5439	7e 	~ 
	and a			;543a	a7 	. 
	jr z,l543eh		;543b	28 01 	( . 
	dec (hl)			;543d	35 	5 
l543eh:
	call l431fh		;543e	cd 1f 43 	. . C 
	call l4e12h		;5441	cd 12 4e 	. . N 
	jp l47b6h		;5444	c3 b6 47 	. . G 
l5447h:
	cp 096h		;5447	fe 96 	. . 
	defb 0fdh,018h,0d5h	;illegal sequence		;5449	fd 18 d5 	. . . 
	or a			;544c	b7 	. 
	defb 0fdh,057h,0d5h	;illegal sequence		;544d	fd 57 d5 	. W . 
	xor d			;5450	aa 	. 
	xor e			;5451	ab 	. 
	defb 0fdh,097h,0d5h	;illegal sequence		;5452	fd 97 d5 	. . . 
	xor h			;5455	ac 	. 
	xor l			;5456	ad 	. 
	defb 0fdh,0d7h,0d5h	;illegal sequence		;5457	fd d7 d5 	. . . 
	or 0f5h		;545a	f6 f5 	. . 
	call m,017fdh		;545c	fc fd 17 	. . . 
	sub 0f8h		;545f	d6 f8 	. . 
	ld sp,hl			;5461	f9 	. 
	rst 30h			;5462	f7 	. 
	defb 0fdh,057h,0d6h	;illegal sequence		;5463	fd 57 d6 	. W . 
	jp m,0fefbh		;5466	fa fb fe 	. . . 
	sub 018h		;5469	d6 18 	. . 
	ld d,(iy-02fh)		;546b	fd 56 d1 	. V . 
	cp 0d7h		;546e	fe d7 	. . 
	ld c,h			;5470	4c 	L 
	ld b,l			;5471	45 	E 
	ld d,h			;5472	54 	T 
	daa			;5473	27 	' 
	ld d,e			;5474	53 	S 
	jr nz,l54cbh		;5475	20 54 	  T 
	ld d,d			;5477	52 	R 
	ld e,c			;5478	59 	Y 
	jr nz,$+80		;5479	20 4e 	  N 
	ld b,l			;547b	45 	E 
	ld e,b			;547c	58 	X 
	ld d,h			;547d	54 	T 
	jr nz,l54c6h		;547e	20 46 	  F 
	ld c,h			;5480	4c 	L 
	ld c,a			;5481	4f 	O 
	ld c,a			;5482	4f 	O 
	ld d,d			;5483	52 	R 
	rst 38h			;5484	ff 	. 
l5485h:
	ld c,b			;5485	48 	H 
	ld b,l			;5486	45 	E 
	ld c,h			;5487	4c 	L 
	ld d,b			;5488	50 	P 
	jr nz,l54d8h		;5489	20 4d 	  M 
	ld b,l			;548b	45 	E 
	inc l			;548c	2c 	, 
	defb 0fdh,015h,0d3h	;illegal sequence		;548d	fd 15 d3 	. . . 
	ld d,h			;5490	54 	T 
	ld c,b			;5491	48 	H 
	ld c,a			;5492	4f 	O 
	ld c,l			;5493	4d 	M 
	ld b,c			;5494	41 	A 
	ld d,e			;5495	53 	S 
	ld hl,020ffh		;5496	21 ff 20 	! .   
	jr nz,$+34		;5499	20 20 	    
	jr nz,$+34		;549b	20 20 	    
	jr nz,l54bfh		;549d	20 20 	    
	jr nz,$-1		;549f	20 fd 	  . 
	dec d			;54a1	15 	. 
	out (020h),a		;54a2	d3 20 	.   
	jr nz,l54c6h		;54a4	20 20 	    
	jr nz,l54c8h		;54a6	20 20 	    
	jr nz,$+34		;54a8	20 20 	    
	rst 38h			;54aa	ff 	. 
l54abh:
	cp 0dah		;54ab	fe da 	. . 
	defb 0fdh,0a3h,0d2h	;illegal sequence		;54ad	fd a3 d2 	. . . 
	ld c,c			;54b0	49 	I 
	daa			;54b1	27 	' 
	ld c,l			;54b2	4d 	M 
	jr nz,$+69		;54b3	20 43 	  C 
	ld c,a			;54b5	4f 	O 
	ld c,l			;54b6	4d 	M 
	ld c,c			;54b7	49 	I 
	ld c,(hl)			;54b8	4e 	N 
	ld b,a			;54b9	47 	G 
	inc iy		;54ba	fd 23 	. # 
	out (052h),a		;54bc	d3 52 	. R 
	ld c,c			;54be	49 	I 
l54bfh:
	ld b,a			;54bf	47 	G 
	ld c,b			;54c0	48 	H 
	ld d,h			;54c1	54 	T 
	jr nz,l5505h		;54c2	20 41 	  A 
	ld d,a			;54c4	57 	W 
	ld b,c			;54c5	41 	A 
l54c6h:
	ld e,c			;54c6	59 	Y 
	inc l			;54c7	2c 	, 
l54c8h:
	defb 0fdh,0a5h,0d3h	;illegal sequence		;54c8	fd a5 d3 	. . . 
l54cbh:
	ld d,e			;54cb	53 	S 
	ld c,c			;54cc	49 	I 
	ld c,h			;54cd	4c 	L 
	ld d,(hl)			;54ce	56 	V 
	ld c,c			;54cf	49 	I 
	ld b,c			;54d0	41 	A 
	ld hl,020ffh		;54d1	21 ff 20 	! .   
	jr nz,l54f6h		;54d4	20 20 	    
	jr nz,$+34		;54d6	20 20 	    
l54d8h:
	jr nz,$+34		;54d8	20 20 	    
	jr nz,l54fch		;54da	20 20 	    
	jr nz,l54feh		;54dc	20 20 	    
	jr nz,$+73		;54de	20 47 	  G 
	ld b,c			;54e0	41 	A 
	ld c,l			;54e1	4d 	M 
	ld b,l			;54e2	45 	E 
	jr nz,l5534h		;54e3	20 4f 	  O 
	ld d,(hl)			;54e5	56 	V 
	ld b,l			;54e6	45 	E 
	ld d,d			;54e7	52 	R 
	jr nz,l550ah		;54e8	20 20 	    
	jr nz,l550ch		;54ea	20 20 	    
	jr nz,$+34		;54ec	20 20 	    
	jr nz,l5510h		;54ee	20 20 	    
	jr nz,$+34		;54f0	20 20 	    
	jr nz,$+34		;54f2	20 20 	    
	ld a,021h		;54f4	3e 21 	> ! 
l54f6h:
	call 00dfeh		;54f6	cd fe 0d 	. . . 
	ld de,0d340h		;54f9	11 40 d3 	. @ . 
l54fch:
	ld c,0dbh		;54fc	0e db 	. . 
l54feh:
	ld ix,054d3h		;54fe	dd 21 d3 54 	. ! . T 
	call sub_56c3h		;5502	cd c3 56 	. . V 
l5505h:
	ld a,0e1h		;5505	3e e1 	> . 
	call sub_570fh		;5507	cd 0f 57 	. . W 
l550ah:
	ld a,038h		;550a	3e 38 	> 8 
l550ch:
	call sub_570fh		;550c	cd 0f 57 	. . W 
	xor a			;550f	af 	. 
l5510h:
	ld (0e700h),a		;5510	32 00 e7 	2 . . 
	ld (0e71ah),a		;5513	32 1a e7 	2 . . 
	ld de,0e083h		;5516	11 83 e0 	. . . 
	ld hl,0ea00h		;5519	21 00 ea 	! . . 
	ld b,003h		;551c	06 03 	. . 
l551eh:
	ld a,(de)			;551e	1a 	. 
	ld (hl),a			;551f	77 	w 
	inc hl			;5520	23 	# 
	dec de			;5521	1b 	. 
	djnz l551eh		;5522	10 fa 	. . 
	ld b,003h		;5524	06 03 	. . 
l5526h:
	ld (hl),020h		;5526	36 20 	6   
	inc hl			;5528	23 	# 
	djnz l5526h		;5529	10 fb 	. . 
	ld c,014h		;552b	0e 14 	. . 
	ld de,0ea00h		;552d	11 00 ea 	. . . 
l5530h:
	ld b,003h		;5530	06 03 	. . 
l5532h:
	ld a,(de)			;5532	1a 	. 
	cp (hl)			;5533	be 	. 
l5534h:
	jr c,l5552h		;5534	38 1c 	8 . 
	jr nz,l553eh		;5536	20 06 	  . 
	inc de			;5538	13 	. 
	inc hl			;5539	23 	# 
	djnz l5532h		;553a	10 f6 	. . 
	jr l5552h		;553c	18 14 	. . 
l553eh:
	ld a,b			;553e	78 	x 
	add a,003h		;553f	c6 03 	. . 
	ld b,a			;5541	47 	G 
l5542h:
	ld a,(hl)			;5542	7e 	~ 
	push af			;5543	f5 	. 
	ld a,(de)			;5544	1a 	. 
	ld (hl),a			;5545	77 	w 
	pop af			;5546	f1 	. 
	ld (de),a			;5547	12 	. 
	inc hl			;5548	23 	# 
	inc de			;5549	13 	. 
	djnz l5542h		;554a	10 f6 	. . 
	dec c			;554c	0d 	. 
	jr nz,l5530h		;554d	20 e1 	  . 
	inc de			;554f	13 	. 
	inc de			;5550	13 	. 
	inc de			;5551	13 	. 
l5552h:
	ld a,c			;5552	79 	y 
	cp 014h		;5553	fe 14 	. . 
	ret z			;5555	c8 	. 
	inc b			;5556	04 	. 
	dec b			;5557	05 	. 
	jr z,l555dh		;5558	28 03 	( . 
l555ah:
	inc de			;555a	13 	. 
	djnz l555ah		;555b	10 fd 	. . 
l555dh:
	push de			;555d	d5 	. 
	push af			;555e	f5 	. 
	ld a,024h		;555f	3e 24 	> $ 
	call 00dfeh		;5561	cd fe 0d 	. . . 
	call sub_5620h		;5564	cd 20 56 	.   V 
	ld hl,l568ah		;5567	21 8a 56 	! . V 
	call 0111ch		;556a	cd 1c 11 	. . . 
	pop af			;556d	f1 	. 
	ld de,0da11h		;556e	11 11 da 	. . . 
	cp 00ah		;5571	fe 0a 	. . 
	jr c,l557ah		;5573	38 05 	8 . 
	sub 00ah		;5575	d6 0a 	. . 
	ld de,0da21h		;5577	11 21 da 	. ! . 
l557ah:
	ld l,000h		;557a	2e 00 	. . 
	srl a		;557c	cb 3f 	. ? 
	rr l		;557e	cb 1d 	. . 
	ld h,a			;5580	67 	g 
	add hl,de			;5581	19 	. 
	pop de			;5582	d1 	. 
	ld b,00dh		;5583	06 0d 	. . 
l5585h:
	ld (hl),000h		;5585	36 00 	6 . 
	inc hl			;5587	23 	# 
	djnz l5585h		;5588	10 fb 	. . 
	ld bc,0f7fdh		;558a	01 fd f7 	. . . 
	add hl,bc			;558d	09 	. 
	ld b,003h		;558e	06 03 	. . 
	ld a,041h		;5590	3e 41 	> A 
	ld (hl),a			;5592	77 	w 
	ld (de),a			;5593	12 	. 
	ld a,020h		;5594	3e 20 	>   
l5596h:
	ld (0e026h),a		;5596	32 26 e0 	2 & . 
	push de			;5599	d5 	. 
	ld de,0d160h		;559a	11 60 d1 	. ` . 
	ld c,000h		;559d	0e 00 	. . 
	call 010ffh		;559f	cd ff 10 	. . . 
	pop de			;55a2	d1 	. 
	ld a,038h		;55a3	3e 38 	> 8 
	ld (0e881h),a		;55a5	32 81 e8 	2 . . 
l55a8h:
	call sub_570dh		;55a8	cd 0d 57 	. . W 
	ld a,(0e904h)		;55ab	3a 04 e9 	: . . 
	and 003h		;55ae	e6 03 	. . 
	jr nz,l561bh		;55b0	20 69 	  i 
	ld a,(0e906h)		;55b2	3a 06 e9 	: . . 
	and 003h		;55b5	e6 03 	. . 
	jr z,l55deh		;55b7	28 25 	( % 
	ld a,(0e883h)		;55b9	3a 83 e8 	: . . 
	and a			;55bc	a7 	. 
	jr nz,l55e2h		;55bd	20 23 	  # 
	ld a,00bh		;55bf	3e 0b 	> . 
	ld (0e883h),a		;55c1	32 83 e8 	2 . . 
	ld a,(0e906h)		;55c4	3a 06 e9 	: . . 
	bit 0,a		;55c7	cb 47 	. G 
	ld a,(hl)			;55c9	7e 	~ 
	jr nz,l55d5h		;55ca	20 09 	  . 
	dec a			;55cc	3d 	= 
	cp 041h		;55cd	fe 41 	. A 
	jr nc,l55f5h		;55cf	30 24 	0 $ 
	ld a,05ch		;55d1	3e 5c 	> \ 
	jr l55f5h		;55d3	18 20 	.   
l55d5h:
	inc a			;55d5	3c 	< 
	cp 05dh		;55d6	fe 5d 	. ] 
	jr c,l55f5h		;55d8	38 1b 	8 . 
	ld a,041h		;55da	3e 41 	> A 
	jr l55f5h		;55dc	18 17 	. . 
l55deh:
	xor a			;55de	af 	. 
	ld (0e883h),a		;55df	32 83 e8 	2 . . 
l55e2h:
	ld a,(0e909h)		;55e2	3a 09 e9 	: . . 
	and 030h		;55e5	e6 30 	. 0 
	jr z,l55f7h		;55e7	28 0e 	( . 
	ld a,(hl)			;55e9	7e 	~ 
	cp 05ch		;55ea	fe 5c 	. \ 
	jr z,l561bh		;55ec	28 2d 	( - 
	inc de			;55ee	13 	. 
	inc hl			;55ef	23 	# 
	dec b			;55f0	05 	. 
	jr z,l560dh		;55f1	28 1a 	( . 
	ld a,041h		;55f3	3e 41 	> A 
l55f5h:
	ld (hl),a			;55f5	77 	w 
	ld (de),a			;55f6	12 	. 
l55f7h:
	ld a,(0e881h)		;55f7	3a 81 e8 	: . . 
	and a			;55fa	a7 	. 
	jr nz,l55a8h		;55fb	20 ab 	  . 
	ld a,(0e026h)		;55fd	3a 26 e0 	: & . 
	sub 001h		;5600	d6 01 	. . 
	daa			;5602	27 	' 
	jr nz,l5596h		;5603	20 91 	  . 
	ld de,0d160h		;5605	11 60 d1 	. ` . 
	ld c,000h		;5608	0e 00 	. . 
	call 010ffh		;560a	cd ff 10 	. . . 
l560dh:
	call sub_562ch		;560d	cd 2c 56 	. , V 
	ld a,01ch		;5610	3e 1c 	> . 
	call sub_570fh		;5612	cd 0f 57 	. . W 
	ld a,000h		;5615	3e 00 	> . 
	call 00dfeh		;5617	cd fe 0d 	. . . 
	ret			;561a	c9 	. 
l561bh:
	ld a,020h		;561b	3e 20 	>   
	ld (de),a			;561d	12 	. 
	jr l560dh		;561e	18 ed 	. . 
sub_5620h:
	call 01157h		;5620	cd 57 11 	. W . 
	call sub_5703h		;5623	cd 03 57 	. . W 
	ld hl,l5675h		;5626	21 75 56 	! u V 
	call 0111ch		;5629	cd 1c 11 	. . . 
sub_562ch:
	ld hl,0ea06h		;562c	21 06 ea 	! . . 
	ld de,0d6a1h		;562f	11 a1 d6 	. . . 
	ld a,020h		;5632	3e 20 	>   
l5634h:
	push af			;5634	f5 	. 
	ld c,0d8h		;5635	0e d8 	. . 
	call sub_56f7h		;5637	cd f7 56 	. . V 
	ld c,015h		;563a	0e 15 	. . 
	inc de			;563c	13 	. 
	ld a,(hl)			;563d	7e 	~ 
	inc hl			;563e	23 	# 
	and a			;563f	a7 	. 
	push de			;5640	d5 	. 
	call nz,01108h		;5641	c4 08 11 	. . . 
	pop de			;5644	d1 	. 
	inc de			;5645	13 	. 
	ld b,002h		;5646	06 02 	. . 
l5648h:
	ld a,(hl)			;5648	7e 	~ 
	inc hl			;5649	23 	# 
	call 010ffh		;564a	cd ff 10 	. . . 
	djnz l5648h		;564d	10 f9 	. . 
	ld a,030h		;564f	3e 30 	> 0 
	call 01110h		;5651	cd 10 11 	. . . 
	ld c,000h		;5654	0e 00 	. . 
	inc de			;5656	13 	. 
	ld b,003h		;5657	06 03 	. . 
l5659h:
	ld a,(hl)			;5659	7e 	~ 
	inc hl			;565a	23 	# 
	call 01110h		;565b	cd 10 11 	. . . 
	djnz l5659h		;565e	10 f9 	. . 
	pop af			;5660	f1 	. 
	sub 001h		;5661	d6 01 	. . 
	daa			;5663	27 	' 
	ret z			;5664	c8 	. 
	push hl			;5665	e5 	. 
	ld hl,0ff73h		;5666	21 73 ff 	! s . 
	add hl,de			;5669	19 	. 
	ex de,hl			;566a	eb 	. 
	pop hl			;566b	e1 	. 
	cp 010h		;566c	fe 10 	. . 
	jr nz,l5634h		;566e	20 c4 	  . 
	ld de,0d691h		;5670	11 91 d6 	. . . 
	jr l5634h		;5673	18 bf 	. . 
l5675h:
	cp 0dbh		;5675	fe db 	. . 
	defb 0fdh,0d8h,0d0h	;illegal sequence		;5677	fd d8 d0 	. . . 
	ld b,d			;567a	42 	B 
	ld b,l			;567b	45 	E 
	ld d,e			;567c	53 	S 
	ld d,h			;567d	54 	T 
	jr nz,$+52		;567e	20 32 	  2 
	jr nc,l56a2h		;5680	30 20 	0   
	ld d,b			;5682	50 	P 
	ld c,h			;5683	4c 	L 
	ld b,c			;5684	41 	A 
	ld e,c			;5685	59 	Y 
	ld b,l			;5686	45 	E 
	ld d,d			;5687	52 	R 
	ld d,e			;5688	53 	S 
	rst 38h			;5689	ff 	. 
l568ah:
	defb 0fdh,05ah,0d1h	;illegal sequence		;568a	fd 5a d1 	. Z . 
	cp 014h		;568d	fe 14 	. . 
	ld d,h			;568f	54 	T 
	ld c,c			;5690	49 	I 
	ld c,l			;5691	4d 	M 
	ld b,l			;5692	45 	E 
	rst 38h			;5693	ff 	. 
l5694h:
	jr nz,$+34		;5694	20 20 	    
	jr nz,$+34		;5696	20 20 	    
	jr nz,$+34		;5698	20 20 	    
	jr nz,$+34		;569a	20 20 	    
	jr nz,l56beh		;569c	20 20 	    
	jr nz,l56c0h		;569e	20 20 	    
	ld d,h			;56a0	54 	T 
	ld c,c			;56a1	49 	I 
l56a2h:
	ld c,l			;56a2	4d 	M 
	ld b,l			;56a3	45 	E 
	jr nz,$+81		;56a4	20 4f 	  O 
	ld d,(hl)			;56a6	56 	V 
	ld b,l			;56a7	45 	E 
	ld d,d			;56a8	52 	R 
	jr nz,l56cbh		;56a9	20 20 	    
	jr nz,l56cdh		;56ab	20 20 	    
	jr nz,l56cfh		;56ad	20 20 	    
	jr nz,$+34		;56af	20 20 	    
	jr nz,$+34		;56b1	20 20 	    
	jr nz,l56d5h		;56b3	20 20 	    
	ld c,0d8h		;56b5	0e d8 	. . 
	ld ix,l5694h		;56b7	dd 21 94 56 	. ! . V 
	call sub_56c3h		;56bb	cd c3 56 	. . V 
l56beh:
	ld a,070h		;56be	3e 70 	> p 
l56c0h:
	jp sub_570fh		;56c0	c3 0f 57 	. . W 
sub_56c3h:
	ld hl,(0e902h)		;56c3	2a 02 e9 	* . . 
	ld de,00004h		;56c6	11 04 00 	. . . 
	add hl,de			;56c9	19 	. 
	add hl,hl			;56ca	29 	) 
l56cbh:
	add hl,hl			;56cb	29 	) 
	add hl,hl			;56cc	29 	) 
l56cdh:
	add hl,hl			;56cd	29 	) 
	add hl,hl			;56ce	29 	) 
l56cfh:
	ld a,h			;56cf	7c 	| 
	add a,01ah		;56d0	c6 1a 	. . 
	ld de,0d340h		;56d2	11 40 d3 	. @ . 
l56d5h:
	ld l,a			;56d5	6f 	o 
	ld h,003h		;56d6	26 03 	& . 
l56d8h:
	push hl			;56d8	e5 	. 
	ld b,00bh		;56d9	06 0b 	. . 
l56dbh:
	push de			;56db	d5 	. 
	ld a,l			;56dc	7d 	} 
	inc l			;56dd	2c 	, 
	and 03fh		;56de	e6 3f 	. ? 
	or e			;56e0	b3 	. 
	ld e,a			;56e1	5f 	_ 
	ld a,(ix+000h)		;56e2	dd 7e 00 	. ~ . 
	inc ix		;56e5	dd 23 	. # 
	call 01110h		;56e7	cd 10 11 	. . . 
	pop de			;56ea	d1 	. 
	djnz l56dbh		;56eb	10 ee 	. . 
	ld hl,00040h		;56ed	21 40 00 	! @ . 
	add hl,de			;56f0	19 	. 
	ex de,hl			;56f1	eb 	. 
	pop hl			;56f2	e1 	. 
	dec h			;56f3	25 	% 
	jr nz,l56d8h		;56f4	20 e2 	  . 
	ret			;56f6	c9 	. 
sub_56f7h:
	cp 010h		;56f7	fe 10 	. . 
	jp nc,010ffh		;56f9	d2 ff 10 	. . . 
	inc de			;56fc	13 	. 
	jp 01108h		;56fd	c3 08 11 	. . . 
sub_5700h:
	call 01153h		;5700	cd 53 11 	. S . 
sub_5703h:
	xor a			;5703	af 	. 
	ld (0e000h),a		;5704	32 00 e0 	2 . . 
	ld hl,00000h		;5707	21 00 00 	! . . 
	ld (0e902h),hl		;570a	22 02 e9 	" . . 
sub_570dh:
	ld a,001h		;570d	3e 01 	> . 
sub_570fh:
	push hl			;570f	e5 	. 
	ld hl,0e882h		;5710	21 82 e8 	! . . 
	ld (hl),a			;5713	77 	w 
l5714h:
	ld a,(hl)			;5714	7e 	~ 
	and a			;5715	a7 	. 
	jr nz,l5714h		;5716	20 fc 	  . 
	pop hl			;5718	e1 	. 
	ret			;5719	c9 	. 
sub_571ah:
	push bc			;571a	c5 	. 
	ld b,021h		;571b	06 21 	. ! 
	jr l572dh		;571d	18 0e 	. . 
l571fh:
	call sub_5725h		;571f	cd 25 57 	. % W 
	ld de,0d396h		;5722	11 96 d3 	. . . 
sub_5725h:
	push bc			;5725	c5 	. 
	ld b,01ah		;5726	06 1a 	. . 
	jr l572dh		;5728	18 03 	. . 
sub_572ah:
	push bc			;572a	c5 	. 
	ld b,020h		;572b	06 20 	.   
l572dh:
	xor a			;572d	af 	. 
l572eh:
	call 01110h		;572e	cd 10 11 	. . . 
	djnz l572eh		;5731	10 fb 	. . 
	pop bc			;5733	c1 	. 
	ret			;5734	c9 	. 
l5735h:
	ld e,(hl)			;5735	5e 	^ 
	inc hl			;5736	23 	# 
	ld d,(hl)			;5737	56 	V 
	inc hl			;5738	23 	# 
sub_5739h:
	ld a,(hl)			;5739	7e 	~ 
	inc hl			;573a	23 	# 
	inc a			;573b	3c 	< 
	ret z			;573c	c8 	. 
	inc a			;573d	3c 	< 
	jr nz,l5744h		;573e	20 04 	  . 
	set 5,c		;5740	cb e9 	. . 
	jr sub_5739h		;5742	18 f5 	. . 
l5744h:
	inc a			;5744	3c 	< 
	jr z,l5735h		;5745	28 ee 	( . 
	sub 003h		;5747	d6 03 	. . 
	res 7,c		;5749	cb b9 	. . 
	cp 008h		;574b	fe 08 	. . 
	jr c,l5751h		;574d	38 02 	8 . 
	set 7,c		;574f	cb f9 	. . 
l5751h:
	call 01110h		;5751	cd 10 11 	. . . 
	jr sub_5739h		;5754	18 e3 	. . 
	ld hl,(0e817h)		;5756	2a 17 e8 	* . . 
	ld a,h			;5759	7c 	| 
l575ah:
	push hl			;575a	e5 	. 
	call sub_5765h		;575b	cd 65 57 	. e W 
	pop hl			;575e	e1 	. 
	inc h			;575f	24 	$ 
	ld a,h			;5760	7c 	| 
	cp l			;5761	bd 	. 
	jr nz,l575ah		;5762	20 f6 	  . 
	ret			;5764	c9 	. 
sub_5765h:
	cp 0e0h		;5765	fe e0 	. . 
	ret nc			;5767	d0 	. 
	ld (0e802h),a		;5768	32 02 e8 	2 . . 
	add a,020h		;576b	c6 20 	.   
	and 03fh		;576d	e6 3f 	. ? 
	ld hl,0d180h		;576f	21 80 d1 	! . . 
	or l			;5772	b5 	. 
	ld l,a			;5773	6f 	o 
	ld a,(0e802h)		;5774	3a 02 e8 	: . . 
	call sub_5800h		;5777	cd 00 58 	. . X 
	ld a,(0e080h)		;577a	3a 80 e0 	: . . 
	and 001h		;577d	e6 01 	. . 
	jr nz,l5786h		;577f	20 05 	  . 
	call sub_585fh		;5781	cd 5f 58 	. _ X 
	jr l5789h		;5784	18 03 	. . 
l5786h:
	call sub_5835h		;5786	cd 35 58 	. 5 X 
l5789h:
	call sub_5903h		;5789	cd 03 59 	. . Y 
	jr nz,l5793h		;578c	20 05 	  . 
	call sub_58d3h		;578e	cd d3 58 	. . X 
	jr l5796h		;5791	18 03 	. . 
l5793h:
	call sub_58f1h		;5793	cd f1 58 	. . X 
l5796h:
	call sub_57d4h		;5796	cd d4 57 	. . W 
	call sub_5903h		;5799	cd 03 59 	. . Y 
	cp 003h		;579c	fe 03 	. . 
	ret nz			;579e	c0 	. 
	ld a,(0e802h)		;579f	3a 02 e8 	: . . 
	ld bc,00008h		;57a2	01 08 00 	. . . 
	ld hl,l5a30h		;57a5	21 30 5a 	! 0 Z 
	cpdr		;57a8	ed b9 	. . 
	ret nz			;57aa	c0 	. 
	rlc c		;57ab	cb 01 	. . 
	rlc c		;57ad	cb 01 	. . 
	ld a,(0e080h)		;57af	3a 80 e0 	: . . 
	cp 010h		;57b2	fe 10 	. . 
	ld hl,l5a31h		;57b4	21 31 5a 	! 1 Z 
	jr c,l57bch		;57b7	38 03 	8 . 
	ld hl,l5a51h		;57b9	21 51 5a 	! Q Z 
l57bch:
	add hl,bc			;57bc	09 	. 
	ld e,(hl)			;57bd	5e 	^ 
	inc hl			;57be	23 	# 
	ld d,(hl)			;57bf	56 	V 
	inc hl			;57c0	23 	# 
	ex de,hl			;57c1	eb 	. 
	ld c,011h		;57c2	0e 11 	. . 
l57c4h:
	ld a,(de)			;57c4	1a 	. 
	inc de			;57c5	13 	. 
	ld (hl),a			;57c6	77 	w 
	set 3,h		;57c7	cb dc 	. . 
	ld (hl),c			;57c9	71 	q 
	ld a,(de)			;57ca	1a 	. 
	ld de,0f840h		;57cb	11 40 f8 	. @ . 
	add hl,de			;57ce	19 	. 
	ld (hl),a			;57cf	77 	w 
	set 3,h		;57d0	cb dc 	. . 
	ld (hl),c			;57d2	71 	q 
	ret			;57d3	c9 	. 
sub_57d4h:
	ld a,(0e080h)		;57d4	3a 80 e0 	: . . 
	and 001h		;57d7	e6 01 	. . 
	ld hl,l5a7ch		;57d9	21 7c 5a 	! | Z 
	jr nz,l57e1h		;57dc	20 03 	  . 
	ld hl,l5a88h		;57de	21 88 5a 	! . Z 
l57e1h:
	ld a,(0e802h)		;57e1	3a 02 e8 	: . . 
	ld bc,0000ch		;57e4	01 0c 00 	. . . 
	cpdr		;57e7	ed b9 	. . 
	ret nz			;57e9	c0 	. 
	ld hl,l5a88h+1		;57ea	21 89 5a 	! . Z 
	add hl,bc			;57ed	09 	. 
	add hl,bc			;57ee	09 	. 
	ld a,(0e802h)		;57ef	3a 02 e8 	: . . 
	ex de,hl			;57f2	eb 	. 
	add a,020h		;57f3	c6 20 	.   
	and 03fh		;57f5	e6 3f 	. ? 
	ld hl,0d380h		;57f7	21 80 d3 	! . . 
	or l			;57fa	b5 	. 
	ld l,a			;57fb	6f 	o 
	ld c,08bh		;57fc	0e 8b 	. . 
	jr l57c4h		;57fe	18 c4 	. . 
sub_5800h:
	ld de,l61e7h		;5800	11 e7 61 	. . a 
	cp 0dah		;5803	fe da 	. . 
	jp nc,l5918h		;5805	d2 18 59 	. . Y 
	sub 0d5h		;5808	d6 d5 	. . 
	jr c,l5818h		;580a	38 0c 	8 . 
	push hl			;580c	e5 	. 
	ld hl,l59dbh		;580d	21 db 59 	! . Y 
	ld e,a			;5810	5f 	_ 
	ld d,000h		;5811	16 00 	. . 
	add hl,de			;5813	19 	. 
	ld a,(hl)			;5814	7e 	~ 
	pop hl			;5815	e1 	. 
	jr l581ch		;5816	18 04 	. . 
l5818h:
	and 001h		;5818	e6 01 	. . 
	add a,052h		;581a	c6 52 	. R 
l581ch:
	ld c,05ch		;581c	0e 5c 	. \ 
	call sub_5909h		;581e	cd 09 59 	. . Y 
	ld a,(0e802h)		;5821	3a 02 e8 	: . . 
	and 007h		;5824	e6 07 	. . 
	push hl			;5826	e5 	. 
	ld hl,l59e1h		;5827	21 e1 59 	! . Y 
	ld c,a			;582a	4f 	O 
	add hl,bc			;582b	09 	. 
	ld a,(hl)			;582c	7e 	~ 
	pop hl			;582d	e1 	. 
	ld (hl),a			;582e	77 	w 
	set 3,h		;582f	cb dc 	. . 
	ld (hl),05eh		;5831	36 5e 	6 ^ 
	add hl,de			;5833	19 	. 
	ret			;5834	c9 	. 
sub_5835h:
	ld a,(0e802h)		;5835	3a 02 e8 	: . . 
	cp 0ddh		;5838	fe dd 	. . 
	ret nc			;583a	d0 	. 
	cp 00dh		;583b	fe 0d 	. . 
	jr c,l5849h		;583d	38 0a 	8 . 
	cp 0cfh		;583f	fe cf 	. . 
	jr c,l586dh		;5841	38 2a 	8 * 
	ld de,l5f83h		;5843	11 83 5f 	. . _ 
	jp l58c5h		;5846	c3 c5 58 	. . X 
l5849h:
	ld b,a			;5849	47 	G 
	ld a,(0e915h)		;584a	3a 15 e9 	: . . 
	cp 001h		;584d	fe 01 	. . 
	ld a,b			;584f	78 	x 
	ld de,l5d48h		;5850	11 48 5d 	. H ] 
	jr z,l58c5h		;5853	28 70 	( p 
	ld de,l5e18h		;5855	11 18 5e 	. . ^ 
	jr nc,l58c5h		;5858	30 6b 	0 k 
	ld de,l5c8eh		;585a	11 8e 5c 	. . \ 
	jr l58c5h		;585d	18 66 	. f 
sub_585fh:
	ld a,(0e802h)		;585f	3a 02 e8 	: . . 
	cp 0ddh		;5862	fe dd 	. . 
	ret nc			;5864	d0 	. 
	cp 013h		;5865	fe 13 	. . 
	jr c,l589fh		;5867	38 36 	8 6 
	cp 0d3h		;5869	fe d3 	. . 
	jr nc,l5886h		;586b	30 19 	0 . 
l586dh:
	and 01fh		;586d	e6 1f 	. . 
	push af			;586f	f5 	. 
	push hl			;5870	e5 	. 
	add a,a			;5871	87 	. 
	ld c,a			;5872	4f 	O 
	ld hl,l59e9h		;5873	21 e9 59 	! . Y 
	add hl,bc			;5876	09 	. 
	ld a,(hl)			;5877	7e 	~ 
	inc hl			;5878	23 	# 
	ld c,(hl)			;5879	4e 	N 
	pop hl			;587a	e1 	. 
	ld (hl),a			;587b	77 	w 
	set 3,h		;587c	cb dc 	. . 
	ld (hl),c			;587e	71 	q 
	add hl,de			;587f	19 	. 
	pop af			;5880	f1 	. 
	ld de,l5b6ah		;5881	11 6a 5b 	. j [ 
	jr l58c5h		;5884	18 3f 	. ? 
l5886h:
	ld b,a			;5886	47 	G 
	ld de,l61cbh		;5887	11 cb 61 	. . a 
	call sub_5903h		;588a	cd 03 59 	. . Y 
	jr z,l589ch		;588d	28 0d 	( . 
	ld a,(0e915h)		;588f	3a 15 e9 	: . . 
	cp 001h		;5892	fe 01 	. . 
	ld de,l6176h		;5894	11 76 61 	. v a 
	jr nc,l589ch		;5897	30 03 	0 . 
	ld de,l60f5h		;5899	11 f5 60 	. . ` 
l589ch:
	ld a,b			;589c	78 	x 
	jr l58c5h		;589d	18 26 	. & 
l589fh:
	ld e,a			;589f	5f 	_ 
	call sub_5903h		;58a0	cd 03 59 	. . Y 
	cp 004h		;58a3	fe 04 	. . 
	ld a,e			;58a5	7b 	{ 
	ld de,l60b3h		;58a6	11 b3 60 	. . ` 
	jr z,l58c5h		;58a9	28 1a 	( . 
	ld de,l5ea9h		;58ab	11 a9 5e 	. . ^ 
	call l5918h		;58ae	cd 18 59 	. . Y 
	call sub_5903h		;58b1	cd 03 59 	. . Y 
	ld a,(0e802h)		;58b4	3a 02 e8 	: . . 
	jr nz,l58beh		;58b7	20 05 	  . 
	cp 003h		;58b9	fe 03 	. . 
	jr nc,l58c8h		;58bb	30 0b 	0 . 
	ret			;58bd	c9 	. 
l58beh:
	cp 002h		;58be	fe 02 	. . 
	jr nc,l58c8h		;58c0	30 06 	0 . 
	ld de,l6554h		;58c2	11 54 65 	. T e 
l58c5h:
	call l5918h		;58c5	cd 18 59 	. . Y 
l58c8h:
	ld (hl),005h		;58c8	36 05 	6 . 
	set 3,h		;58ca	cb dc 	. . 
	ld (hl),001h		;58cc	36 01 	6 . 
	ld de,0f840h		;58ce	11 40 f8 	. @ . 
	add hl,de			;58d1	19 	. 
	ret			;58d2	c9 	. 
sub_58d3h:
	ld c,04fh		;58d3	0e 4f 	. O 
	ld a,(0e802h)		;58d5	3a 02 e8 	: . . 
	cp 0c0h		;58d8	fe c0 	. . 
	jr nc,l58ech		;58da	30 10 	0 . 
	cp 020h		;58dc	fe 20 	.   
	jr c,l58e7h		;58de	38 07 	8 . 
	and 01fh		;58e0	e6 1f 	. . 
	ld de,l650ch		;58e2	11 0c 65 	. . e 
	jr l5918h		;58e5	18 31 	. 1 
l58e7h:
	ld de,l6402h		;58e7	11 02 64 	. . d 
	jr l5918h		;58ea	18 2c 	. , 
l58ech:
	ld de,l62f8h		;58ec	11 f8 62 	. . b 
	jr l5918h		;58ef	18 27 	. ' 
sub_58f1h:
	ld a,(0e802h)		;58f1	3a 02 e8 	: . . 
	ld de,l63a7h		;58f4	11 a7 63 	. . c 
	cp 0dch		;58f7	fe dc 	. . 
	jr nc,l5918h		;58f9	30 1d 	0 . 
	and 001h		;58fb	e6 01 	. . 
	add a,024h		;58fd	c6 24 	. $ 
	ld c,042h		;58ff	0e 42 	. B 
	jr sub_5909h		;5901	18 06 	. . 
sub_5903h:
	ld a,(0e080h)		;5903	3a 80 e0 	: . . 
	and 007h		;5906	e6 07 	. . 
	ret			;5908	c9 	. 
sub_5909h:
	ld b,003h		;5909	06 03 	. . 
	ld de,0f840h		;590b	11 40 f8 	. @ . 
l590eh:
	ld (hl),a			;590e	77 	w 
	set 3,h		;590f	cb dc 	. . 
	ld (hl),c			;5911	71 	q 
	add hl,de			;5912	19 	. 
	add a,002h		;5913	c6 02 	. . 
	djnz l590eh		;5915	10 f7 	. . 
	ret			;5917	c9 	. 
l5918h:
	ex de,hl			;5918	eb 	. 
	push bc			;5919	c5 	. 
	ld b,000h		;591a	06 00 	. . 
	ld c,a			;591c	4f 	O 
	add hl,bc			;591d	09 	. 
	add hl,bc			;591e	09 	. 
	pop bc			;591f	c1 	. 
	ld a,(hl)			;5920	7e 	~ 
	inc hl			;5921	23 	# 
	ld h,(hl)			;5922	66 	f 
	ld l,a			;5923	6f 	o 
	ex de,hl			;5924	eb 	. 
	ld b,001h		;5925	06 01 	. . 
l5927h:
	ld a,(de)			;5927	1a 	. 
	inc de			;5928	13 	. 
	inc a			;5929	3c 	< 
	jr z,l593fh		;592a	28 13 	( . 
	inc a			;592c	3c 	< 
	jr z,l5946h		;592d	28 17 	( . 
	add a,0feh		;592f	c6 fe 	. . 
	ld (hl),a			;5931	77 	w 
	set 3,h		;5932	cb dc 	. . 
	ld (hl),c			;5934	71 	q 
	ld a,040h		;5935	3e 40 	> @ 
	add a,l			;5937	85 	. 
	ld l,a			;5938	6f 	o 
	ld a,0f8h		;5939	3e f8 	> . 
	adc a,h			;593b	8c 	. 
	ld h,a			;593c	67 	g 
	jr l5927h		;593d	18 e8 	. . 
l593fh:
	dec b			;593f	05 	. 
	ret z			;5940	c8 	. 
	pop de			;5941	d1 	. 
l5942h:
	inc de			;5942	13 	. 
	inc de			;5943	13 	. 
	jr l5927h		;5944	18 e1 	. . 
l5946h:
	ld a,(de)			;5946	1a 	. 
	inc de			;5947	13 	. 
	cp 0fch		;5948	fe fc 	. . 
	jr c,l5958h		;594a	38 0c 	8 . 
	jr z,l5950h		;594c	28 02 	( . 
	push de			;594e	d5 	. 
	inc b			;594f	04 	. 
l5950h:
	ex de,hl			;5950	eb 	. 
	ld a,(hl)			;5951	7e 	~ 
	inc hl			;5952	23 	# 
	ld h,(hl)			;5953	66 	f 
	ld l,a			;5954	6f 	o 
	ex de,hl			;5955	eb 	. 
	jr l5927h		;5956	18 cf 	. . 
l5958h:
	ld c,a			;5958	4f 	O 
	jr l5927h		;5959	18 cc 	. . 
	cp 015h		;595b	fe 15 	. . 
	defb 0fdh,0d8h,0d2h	;illegal sequence		;595d	fd d8 d2 	. . . 
	ld d,e			;5960	53 	S 
	ld b,l			;5961	45 	E 
	ld c,h			;5962	4c 	L 
	ld b,l			;5963	45 	E 
	ld b,e			;5964	43 	C 
	ld d,h			;5965	54 	T 
	jr nz,l59afh		;5966	20 47 	  G 
	ld b,c			;5968	41 	A 
	ld c,l			;5969	4d 	M 
	ld b,l			;596a	45 	E 
	jr nz,$+72		;596b	20 46 	  F 
	ld c,h			;596d	4c 	L 
	ld c,a			;596e	4f 	O 
	ld c,a			;596f	4f 	O 
	ld d,d			;5970	52 	R 
	defb 0fdh,09ah,0d3h	;illegal sequence		;5971	fd 9a d3 	. . . 
	ld c,b			;5974	48 	H 
	ld c,a			;5975	4f 	O 
	ld d,l			;5976	55 	U 
	ld d,e			;5977	53 	S 
	ld b,l			;5978	45 	E 
	jr nz,l59c9h		;5979	20 4e 	  N 
	ld d,l			;597b	55 	U 
	ld c,l			;597c	4d 	M 
	ld b,d			;597d	42 	B 
	ld b,l			;597e	45 	E 
	ld d,d			;597f	52 	R 
	dec l			;5980	2d 	- 
	defb 0fdh,01ah,0d4h	;illegal sequence		;5981	fd 1a d4 	. . . 
	ld b,(hl)			;5984	46 	F 
	ld c,h			;5985	4c 	L 
	ld c,a			;5986	4f 	O 
	ld c,a			;5987	4f 	O 
	ld d,d			;5988	52 	R 
	jr nz,l59d9h		;5989	20 4e 	  N 
	ld d,l			;598b	55 	U 
	ld c,l			;598c	4d 	M 
	ld b,d			;598d	42 	B 
	ld b,l			;598e	45 	E 
	ld d,d			;598f	52 	R 
	dec l			;5990	2d 	- 
	defb 0fdh,098h,0d4h	;illegal sequence		;5991	fd 98 d4 	. . . 
	ld d,b			;5994	50 	P 
	ld d,l			;5995	55 	U 
	ld c,(hl)			;5996	4e 	N 
	ld b,e			;5997	43 	C 
	ld c,b			;5998	48 	H 
	dec l			;5999	2d 	- 
	ld d,l			;599a	55 	U 
	ld d,b			;599b	50 	P 
	jr nz,l59e9h		;599c	20 4b 	  K 
	ld c,c			;599e	49 	I 
	ld b,e			;599f	43 	C 
	ld c,e			;59a0	4b 	K 
	dec l			;59a1	2d 	- 
	ld b,h			;59a2	44 	D 
	ld c,a			;59a3	4f 	O 
	ld d,a			;59a4	57 	W 
	ld c,(hl)			;59a5	4e 	N 
	rst 38h			;59a6	ff 	. 
	cp 015h		;59a7	fe 15 	. . 
	defb 0fdh,011h,0d0h	;illegal sequence		;59a9	fd 11 d0 	. . . 
	ld sp,02d50h		;59ac	31 50 2d 	1 P - 
l59afh:
	defb 0fdh,026h,0d0h	;illegal sequence		;59af	fd 26 d0 	. & . 
	ld (02d50h),a		;59b2	32 50 2d 	2 P - 
	cp 000h		;59b5	fe 00 	. . 
	defb 0fdh,01bh,0d0h	;illegal sequence		;59b7	fd 1b d0 	. . . 
	ld d,h			;59ba	54 	T 
	ld c,a			;59bb	4f 	O 
	ld d,b			;59bc	50 	P 
	dec l			;59bd	2d 	- 
	cp 014h		;59be	fe 14 	. . 
	defb 0fdh,0aah,0d0h	;illegal sequence		;59c0	fd aa d0 	. . . 
	ld d,h			;59c3	54 	T 
	ld c,c			;59c4	49 	I 
	ld c,l			;59c5	4d 	M 
	ld b,l			;59c6	45 	E 
	cp 094h		;59c7	fe 94 	. . 
l59c9h:
	defb 0fdh,091h,0d0h	;illegal sequence		;59c9	fd 91 d0 	. . . 
	sbc a,b			;59cc	98 	. 
	sbc a,c			;59cd	99 	. 
	sbc a,d			;59ce	9a 	. 
	sbc a,e			;59cf	9b 	. 
	sbc a,h			;59d0	9c 	. 
	cp 095h		;59d1	fe 95 	. . 
	defb 0fdh,011h,0d1h	;illegal sequence		;59d3	fd 11 d1 	. . . 
	sbc a,l			;59d6	9d 	. 
	sbc a,(hl)			;59d7	9e 	. 
	sbc a,a			;59d8	9f 	. 
l59d9h:
	and b			;59d9	a0 	. 
	rst 38h			;59da	ff 	. 
l59dbh:
	ld e,b			;59db	58 	X 
	ld e,c			;59dc	59 	Y 
	ld h,b			;59dd	60 	` 
	ld h,c			;59de	61 	a 
	ld l,b			;59df	68 	h 
	ld l,c			;59e0	69 	i 
l59e1h:
	ld h,a			;59e1	67 	g 
	ld l,(hl)			;59e2	6e 	n 
	ld e,(hl)			;59e3	5e 	^ 
	ld e,(hl)			;59e4	5e 	^ 
	ld e,(hl)			;59e5	5e 	^ 
	ld e,(hl)			;59e6	5e 	^ 
	ld e,a			;59e7	5f 	_ 
	ld h,(hl)			;59e8	66 	f 
l59e9h:
	pop af			;59e9	f1 	. 
	ex af,af'			;59ea	08 	. 
	ld b,001h		;59eb	06 01 	. . 
	ld b,001h		;59ed	06 01 	. . 
	ld b,001h		;59ef	06 01 	. . 
	ld b,001h		;59f1	06 01 	. . 
	inc d			;59f3	14 	. 
	ld b,c			;59f4	41 	A 
	dec d			;59f5	15 	. 
	ld b,c			;59f6	41 	A 
	xor 008h		;59f7	ee 08 	. . 
	rst 28h			;59f9	ef 	. 
	ex af,af'			;59fa	08 	. 
	ld b,001h		;59fb	06 01 	. . 
	ld b,001h		;59fd	06 01 	. . 
	jr $+67		;59ff	18 41 	. A 
	add hl,de			;5a01	19 	. 
	ld b,c			;5a02	41 	A 
	ld b,001h		;5a03	06 01 	. . 
	ld b,001h		;5a05	06 01 	. . 
	xor 008h		;5a07	ee 08 	. . 
	rst 28h			;5a09	ef 	. 
	ex af,af'			;5a0a	08 	. 
	ld b,001h		;5a0b	06 01 	. . 
	ld b,001h		;5a0d	06 01 	. . 
	inc d			;5a0f	14 	. 
	ld b,c			;5a10	41 	A 
	dec d			;5a11	15 	. 
	ld b,c			;5a12	41 	A 
	ld b,001h		;5a13	06 01 	. . 
	ld b,001h		;5a15	06 01 	. . 
	xor 008h		;5a17	ee 08 	. . 
	rst 28h			;5a19	ef 	. 
	ex af,af'			;5a1a	08 	. 
	jr l5a5eh		;5a1b	18 41 	. A 
	add hl,de			;5a1d	19 	. 
	ld b,c			;5a1e	41 	A 
	ld b,001h		;5a1f	06 01 	. . 
	ld b,001h		;5a21	06 01 	. . 
	ld b,001h		;5a23	06 01 	. . 
	ld b,001h		;5a25	06 01 	. . 
	ret p			;5a27	f0 	. 
	ex af,af'			;5a28	08 	. 
	ld (03c23h),hl		;5a29	22 23 3c 	" # < 
	dec a			;5a2c	3d 	= 
	ld e,d			;5a2d	5a 	Z 
	ld e,e			;5a2e	5b 	[ 
	ld (hl),b			;5a2f	70 	p 
l5a30h:
	ld (hl),c			;5a30	71 	q 
l5a31h:
	ld (bc),a			;5a31	02 	. 
	out (07ch),a		;5a32	d3 7c 	. | 
	ld a,(hl)			;5a34	7e 	~ 
	inc bc			;5a35	03 	. 
	out (001h),a		;5a36	d3 01 	. . 
	ld a,a			;5a38	7f 	 
	inc e			;5a39	1c 	. 
	call nc,07e7ch		;5a3a	d4 7c 7e 	. | ~ 
	dec e			;5a3d	1d 	. 
l5a3eh:
	call nc,sub_7f01h		;5a3e	d4 01 7f 	. .  
	jp m,l7cd4h+1		;5a41	fa d5 7c 	. . | 
	ld a,(hl)			;5a44	7e 	~ 
	ei			;5a45	fb 	. 
	push de			;5a46	d5 	. 
	ld bc,0107fh		;5a47	01 7f 10 	.  . 
	out (07ch),a		;5a4a	d3 7c 	. | 
	ld a,(hl)			;5a4c	7e 	~ 
	ld de,001d3h		;5a4d	11 d3 01 	. . . 
	ld a,a			;5a50	7f 	 
l5a51h:
	ld (bc),a			;5a51	02 	. 
	out (07ch),a		;5a52	d3 7c 	. | 
	ld a,(hl)			;5a54	7e 	~ 
	inc bc			;5a55	03 	. 
	out (001h),a		;5a56	d3 01 	. . 
	ld a,a			;5a58	7f 	 
	inc e			;5a59	1c 	. 
	call nc,07e7ch		;5a5a	d4 7c 7e 	. | ~ 
	dec e			;5a5d	1d 	. 
l5a5eh:
	call nc,sub_7f01h		;5a5e	d4 01 7f 	. .  
	ld a,(l7cd4h)		;5a61	3a d4 7c 	: . | 
	ld a,(hl)			;5a64	7e 	~ 
	dec sp			;5a65	3b 	; 
	call nc,sub_7f01h		;5a66	d4 01 7f 	. .  
	djnz l5a3eh		;5a69	10 d3 	. . 
	ld a,h			;5a6b	7c 	| 
	ld a,(hl)			;5a6c	7e 	~ 
	ld de,001d3h		;5a6d	11 d3 01 	. . . 
	ld a,a			;5a70	7f 	 
	rra			;5a71	1f 	. 
	jr nz,$+65		;5a72	20 3f 	  ? 
	ld b,b			;5a74	40 	@ 
	ld e,a			;5a75	5f 	_ 
	ld h,b			;5a76	60 	` 
	ld a,a			;5a77	7f 	 
	add a,b			;5a78	80 	. 
	sbc a,a			;5a79	9f 	. 
	and b			;5a7a	a0 	. 
	cp a			;5a7b	bf 	. 
l5a7ch:
	ret nz			;5a7c	c0 	. 
	cp a			;5a7d	bf 	. 
	ret nz			;5a7e	c0 	. 
	sbc a,a			;5a7f	9f 	. 
	and b			;5a80	a0 	. 
	ld a,a			;5a81	7f 	 
	add a,b			;5a82	80 	. 
	ld e,a			;5a83	5f 	_ 
	ld h,b			;5a84	60 	` 
	ccf			;5a85	3f 	? 
	ld b,b			;5a86	40 	@ 
	rra			;5a87	1f 	. 
l5a88h:
	jr nz,l5a8eh		;5a88	20 04 	  . 
	ld b,005h		;5a8a	06 05 	. . 
	ld a,l			;5a8c	7d 	} 
	ld a,(hl)			;5a8d	7e 	~ 
l5a8eh:
	sub (hl)			;5a8e	96 	. 
	sub l			;5a8f	95 	. 
	sub a			;5a90	97 	. 
	cp h			;5a91	bc 	. 
	cp (hl)			;5a92	be 	. 
	cp l			;5a93	bd 	. 
	cp a			;5a94	bf 	. 
	ret nz			;5a95	c0 	. 
	jp nz,0c3c1h		;5a96	c2 c1 c3 	. . . 
	call nz,0c5c6h		;5a99	c4 c6 c5 	. . . 
	rst 0			;5a9c	c7 	. 
	ret z			;5a9d	c8 	. 
	jp z,0cbc9h		;5a9e	ca c9 cb 	. . . 
	defb 0fdh,0fbh,0d4h	;illegal sequence		;5aa1	fd fb d4 	. . . 
	cp 041h		;5aa4	fe 41 	. A 
	ld (03afdh),hl		;5aa6	22 fd 3a 	" . : 
	push de			;5aa9	d5 	. 
	add a,b			;5aaa	80 	. 
	cp 091h		;5aab	fe 91 	. . 
	rra			;5aad	1f 	. 
	sub h			;5aae	94 	. 
	defb 0fdh,079h,0d5h	;illegal sequence		;5aaf	fd 79 d5 	. y . 
	ld h,0feh		;5ab2	26 fe 	& . 
	ld de,00000h		;5ab4	11 00 00 	. . . 
	nop			;5ab7	00 	. 
	defb 0fdh,0b8h,0d5h	;illegal sequence		;5ab8	fd b8 d5 	. . . 
	cp 091h		;5abb	fe 91 	. . 
	daa			;5abd	27 	' 
	jr z,$+43		;5abe	28 29 	( ) 
	cp 011h		;5ac0	fe 11 	. . 
	nop			;5ac2	00 	. 
	nop			;5ac3	00 	. 
	defb 0fdh,0f8h,0d5h	;illegal sequence		;5ac4	fd f8 d5 	. . . 
	cp 091h		;5ac7	fe 91 	. . 
	jr nc,l5af5h		;5ac9	30 2a 	0 * 
	cp 011h		;5acb	fe 11 	. . 
	inc bc			;5acd	03 	. 
	cp 091h		;5ace	fe 91 	. . 
	jr nz,l5af3h		;5ad0	20 21 	  ! 
	defb 0fdh,038h,0d6h	;illegal sequence		;5ad2	fd 38 d6 	. 8 . 
	ld sp,02d2ch		;5ad5	31 2c 2d 	1 , - 
	cp 011h		;5ad8	fe 11 	. . 
	inc bc			;5ada	03 	. 
	cp 091h		;5adb	fe 91 	. . 
	inc hl			;5add	23 	# 
	defb 0fdh,079h,0d6h	;illegal sequence		;5ade	fd 79 d6 	. y . 
	ld l,02fh		;5ae1	2e 2f 	. / 
	ld (011feh),hl		;5ae3	22 fe 11 	" . . 
	inc bc			;5ae6	03 	. 
	defb 0fdh,0bah,0d6h	;illegal sequence		;5ae7	fd ba d6 	. . . 
	cp 091h		;5aea	fe 91 	. . 
	dec hl			;5aec	2b 	+ 
	inc h			;5aed	24 	$ 
	dec h			;5aee	25 	% 
	rst 38h			;5aef	ff 	. 
	defb 0fdh,0fch,0d4h	;illegal sequence		;5af0	fd fc d4 	. . . 
l5af3h:
	cp 041h		;5af3	fe 41 	. A 
l5af5h:
	ld (03bfdh),hl		;5af5	22 fd 3b 	" . ; 
	push de			;5af8	d5 	. 
	add a,b			;5af9	80 	. 
	add a,b			;5afa	80 	. 
	defb 0fdh,079h,0d5h	;illegal sequence		;5afb	fd 79 d5 	. y . 
	add a,b			;5afe	80 	. 
	defb 0fdh,0b8h,0d5h	;illegal sequence		;5aff	fd b8 d5 	. . . 
	add a,b			;5b02	80 	. 
	add a,b			;5b03	80 	. 
	add a,b			;5b04	80 	. 
	defb 0fdh,0f8h,0d5h	;illegal sequence		;5b05	fd f8 d5 	. . . 
	add a,b			;5b08	80 	. 
	add a,b			;5b09	80 	. 
	add a,b			;5b0a	80 	. 
	add a,b			;5b0b	80 	. 
	add a,b			;5b0c	80 	. 
	defb 0fdh,038h,0d6h	;illegal sequence		;5b0d	fd 38 d6 	. 8 . 
	add a,(hl)			;5b10	86 	. 
	add a,(hl)			;5b11	86 	. 
	add a,(hl)			;5b12	86 	. 
	add a,(hl)			;5b13	86 	. 
	add a,(hl)			;5b14	86 	. 
	ld (iy-02ah),a		;5b15	fd 77 d6 	. w . 
	cp 091h		;5b18	fe 91 	. . 
	ld (hl),037h		;5b1a	36 37 	6 7 
	ld (03232h),a		;5b1c	32 32 32 	2 2 2 
	inc sp			;5b1f	33 	3 
	or (iy-02ah)		;5b20	fd b6 d6 	. . . 
	jr c,l5b5eh		;5b23	38 39 	8 9 
	inc (hl)			;5b25	34 	4 
	inc (hl)			;5b26	34 	4 
	inc (hl)			;5b27	34 	4 
	inc (hl)			;5b28	34 	4 
	dec (hl)			;5b29	35 	5 
	rst 38h			;5b2a	ff 	. 
	cp 001h		;5b2b	fe 01 	. . 
	ld b,0feh		;5b2d	06 fe 	. . 
	add iy,sp		;5b2f	fd 39 	. 9 
	ld e,e			;5b31	5b 	[ 
	add a,b			;5b32	80 	. 
	add a,b			;5b33	80 	. 
	add a,(hl)			;5b34	86 	. 
	rst 38h			;5b35	ff 	. 
	cp 001h		;5b36	fe 01 	. . 
	ld b,0feh		;5b38	06 fe 	. . 
	ld bc,0fdfeh		;5b3a	01 fe fd 	. . . 
	ld d,d			;5b3d	52 	R 
	ld e,e			;5b3e	5b 	[ 
	cp 041h		;5b3f	fe 41 	. A 
	ld (08080h),hl		;5b41	22 80 80 	" . . 
	rst 38h			;5b44	ff 	. 
	cp 009h		;5b45	fe 09 	. . 
	cp 0fdh		;5b47	fe fd 	. . 
	ld d,e			;5b49	53 	S 
	ld e,e			;5b4a	5b 	[ 
	cp 0fch		;5b4b	fe fc 	. . 
	ld d,e			;5b4d	53 	S 
	ld e,e			;5b4e	5b 	[ 
	cp 001h		;5b4f	fe 01 	. . 
	ld b,0f9h		;5b51	06 f9 	. . 
	nop			;5b53	00 	. 
	nop			;5b54	00 	. 
	nop			;5b55	00 	. 
	nop			;5b56	00 	. 
	nop			;5b57	00 	. 
	nop			;5b58	00 	. 
	nop			;5b59	00 	. 
	rst 38h			;5b5a	ff 	. 
	cp 001h		;5b5b	fe 01 	. . 
	inc bc			;5b5d	03 	. 
l5b5eh:
	inc bc			;5b5e	03 	. 
	inc bc			;5b5f	03 	. 
	inc bc			;5b60	03 	. 
	inc bc			;5b61	03 	. 
	inc bc			;5b62	03 	. 
	inc bc			;5b63	03 	. 
	inc bc			;5b64	03 	. 
	inc bc			;5b65	03 	. 
	inc bc			;5b66	03 	. 
	inc bc			;5b67	03 	. 
	inc bc			;5b68	03 	. 
	rst 38h			;5b69	ff 	. 
l5b6ah:
	xor d			;5b6a	aa 	. 
	ld e,e			;5b6b	5b 	[ 
	or e			;5b6c	b3 	. 
	ld e,e			;5b6d	5b 	[ 
	call nz,0ce5bh		;5b6e	c4 5b ce 	. [ . 
	ld e,e			;5b71	5b 	[ 
	call nz,0d55bh		;5b72	c4 5b d5 	. [ . 
	ld e,e			;5b75	5b 	[ 
	ret pe			;5b76	e8 	. 
	ld e,e			;5b77	5b 	[ 
	ei			;5b78	fb 	. 
	ld e,e			;5b79	5b 	[ 
	djnz $+94		;5b7a	10 5c 	. \ 
	dec h			;5b7c	25 	% 
	ld e,h			;5b7d	5c 	\ 
	ld a,(04f5ch)		;5b7e	3a 5c 4f 	: \ O 
	ld e,h			;5b81	5c 	\ 
	ld h,d			;5b82	62 	b 
	ld e,h			;5b83	5c 	\ 
	adc a,05bh		;5b84	ce 5b 	. [ 
	call nz,0ce5bh		;5b86	c4 5b ce 	. [ . 
	ld e,e			;5b89	5b 	[ 
	call nz,0ce5bh		;5b8a	c4 5b ce 	. [ . 
	ld e,e			;5b8d	5b 	[ 
	call nz,0d55bh		;5b8e	c4 5b d5 	. [ . 
	ld e,e			;5b91	5b 	[ 
	ret pe			;5b92	e8 	. 
	ld e,e			;5b93	5b 	[ 
	ei			;5b94	fb 	. 
	ld e,e			;5b95	5b 	[ 
	djnz l5bf4h		;5b96	10 5c 	. \ 
	dec h			;5b98	25 	% 
	ld e,h			;5b99	5c 	\ 
	ld a,(04f5ch)		;5b9a	3a 5c 4f 	: \ O 
	ld e,h			;5b9d	5c 	\ 
	ld h,d			;5b9e	62 	b 
	ld e,h			;5b9f	5c 	\ 
	adc a,05bh		;5ba0	ce 5b 	. [ 
	call nz,0ce5bh		;5ba2	c4 5b ce 	. [ . 
	ld e,e			;5ba5	5b 	[ 
	ld (hl),l			;5ba6	75 	u 
	ld e,h			;5ba7	5c 	\ 
	add a,e			;5ba8	83 	. 
	ld e,h			;5ba9	5c 	\ 
	cp 0fdh		;5baa	fe fd 	. . 
	ld e,e			;5bac	5b 	[ 
	ld e,e			;5bad	5b 	[ 
	jp p,0f6f4h		;5bae	f2 f4 f6 	. . . 
	inc b			;5bb1	04 	. 
	rst 38h			;5bb2	ff 	. 
	cp 0fdh		;5bb3	fe fd 	. . 
	add hl,sp			;5bb5	39 	9 
	ld e,e			;5bb6	5b 	[ 
	cp 001h		;5bb7	fe 01 	. . 
	rst 30h			;5bb9	f7 	. 
	di			;5bba	f3 	. 
	push af			;5bbb	f5 	. 
	cp 041h		;5bbc	fe 41 	. A 
	add a,h			;5bbe	84 	. 
	ld a,h			;5bbf	7c 	| 
	rst 38h			;5bc0	ff 	. 
	cp 001h		;5bc1	fe 01 	. . 
	ld b,0feh		;5bc3	06 fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;5bc5	fd 2e 5b 	. . [ 
	ld a,h			;5bc8	7c 	| 
	add a,h			;5bc9	84 	. 
	rst 38h			;5bca	ff 	. 
	cp 001h		;5bcb	fe 01 	. . 
	ld b,0feh		;5bcd	06 fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;5bcf	fd 2e 5b 	. . [ 
	add a,h			;5bd2	84 	. 
	ld a,h			;5bd3	7c 	| 
	rst 38h			;5bd4	ff 	. 
	cp 041h		;5bd5	fe 41 	. A 
	ld d,080h		;5bd7	16 80 	. . 
	add a,b			;5bd9	80 	. 
	add a,b			;5bda	80 	. 
	add a,b			;5bdb	80 	. 
	add a,b			;5bdc	80 	. 
	add a,b			;5bdd	80 	. 
	add a,b			;5bde	80 	. 
	ld e,080h		;5bdf	1e 80 	. . 
	add a,b			;5be1	80 	. 
	add a,b			;5be2	80 	. 
	add a,b			;5be3	80 	. 
l5be4h:
	inc d			;5be4	14 	. 
	add a,h			;5be5	84 	. 
	ld a,h			;5be6	7c 	| 
	rst 38h			;5be7	ff 	. 
	cp 041h		;5be8	fe 41 	. A 
	rla			;5bea	17 	. 
	adc a,b			;5beb	88 	. 
	inc e			;5bec	1c 	. 
	adc a,b			;5bed	88 	. 
	adc a,b			;5bee	88 	. 
	adc a,b			;5bef	88 	. 
	adc a,b			;5bf0	88 	. 
	adc a,b			;5bf1	88 	. 
	rra			;5bf2	1f 	. 
	adc a,b			;5bf3	88 	. 
l5bf4h:
	adc a,b			;5bf4	88 	. 
	adc a,b			;5bf5	88 	. 
	adc a,b			;5bf6	88 	. 
	dec d			;5bf7	15 	. 
	ld a,h			;5bf8	7c 	| 
	add a,h			;5bf9	84 	. 
	rst 38h			;5bfa	ff 	. 
	cp 001h		;5bfb	fe 01 	. . 
	ld sp,hl			;5bfd	f9 	. 
	cp 041h		;5bfe	fe 41 	. A 
l5c00h:
	add a,b			;5c00	80 	. 
	adc a,c			;5c01	89 	. 
	nop			;5c02	00 	. 
	ld (bc),a			;5c03	02 	. 
	inc b			;5c04	04 	. 
	ld b,010h		;5c05	06 10 	. . 
	ld (08080h),hl		;5c07	22 80 80 	" . . 
	add a,b			;5c0a	80 	. 
	add a,b			;5c0b	80 	. 
	add a,(hl)			;5c0c	86 	. 
	add a,h			;5c0d	84 	. 
	ld a,h			;5c0e	7c 	| 
	rst 38h			;5c0f	ff 	. 
	cp 001h		;5c10	fe 01 	. . 
	ld sp,hl			;5c12	f9 	. 
	cp 041h		;5c13	fe 41 	. A 
	add a,b			;5c15	80 	. 
	adc a,c			;5c16	89 	. 
	ld bc,00503h		;5c17	01 03 05 	. . . 
	rlca			;5c1a	07 	. 
	ld de,08022h		;5c1b	11 22 80 	. " . 
	add a,b			;5c1e	80 	. 
	add a,b			;5c1f	80 	. 
	add a,b			;5c20	80 	. 
	add a,(hl)			;5c21	86 	. 
	ld a,h			;5c22	7c 	| 
	add a,h			;5c23	84 	. 
	rst 38h			;5c24	ff 	. 
	cp 001h		;5c25	fe 01 	. . 
	ld sp,hl			;5c27	f9 	. 
	cp 041h		;5c28	fe 41 	. A 
	add a,b			;5c2a	80 	. 
	adc a,c			;5c2b	89 	. 
	ex af,af'			;5c2c	08 	. 
	ld a,(bc)			;5c2d	0a 	. 
	inc c			;5c2e	0c 	. 
	ld c,012h		;5c2f	0e 12 	. . 
	ld (08080h),hl		;5c31	22 80 80 	" . . 
	add a,b			;5c34	80 	. 
	add a,b			;5c35	80 	. 
	add a,(hl)			;5c36	86 	. 
	add a,h			;5c37	84 	. 
	ld a,h			;5c38	7c 	| 
	rst 38h			;5c39	ff 	. 
	cp 001h		;5c3a	fe 01 	. . 
	ld sp,hl			;5c3c	f9 	. 
	cp 041h		;5c3d	fe 41 	. A 
	add a,b			;5c3f	80 	. 
	adc a,c			;5c40	89 	. 
	add hl,bc			;5c41	09 	. 
	dec bc			;5c42	0b 	. 
	dec c			;5c43	0d 	. 
	rrca			;5c44	0f 	. 
	inc de			;5c45	13 	. 
	ld (08080h),hl		;5c46	22 80 80 	" . . 
	add a,b			;5c49	80 	. 
	add a,b			;5c4a	80 	. 
	add a,(hl)			;5c4b	86 	. 
	ld a,h			;5c4c	7c 	| 
	add a,h			;5c4d	84 	. 
	rst 38h			;5c4e	ff 	. 
	cp 041h		;5c4f	fe 41 	. A 
	ld a,(de)			;5c51	1a 	. 
	inc hl			;5c52	23 	# 
	dec e			;5c53	1d 	. 
	inc hl			;5c54	23 	# 
	inc hl			;5c55	23 	# 
	inc hl			;5c56	23 	# 
	inc hl			;5c57	23 	# 
	inc hl			;5c58	23 	# 
	jr nz,$+37		;5c59	20 23 	  # 
	inc hl			;5c5b	23 	# 
	inc hl			;5c5c	23 	# 
	inc hl			;5c5d	23 	# 
	jr l5be4h		;5c5e	18 84 	. . 
	ld a,h			;5c60	7c 	| 
	rst 38h			;5c61	ff 	. 
	cp 041h		;5c62	fe 41 	. A 
	dec de			;5c64	1b 	. 
	add a,b			;5c65	80 	. 
	add a,b			;5c66	80 	. 
	add a,b			;5c67	80 	. 
	add a,b			;5c68	80 	. 
	add a,b			;5c69	80 	. 
	add a,b			;5c6a	80 	. 
	add a,b			;5c6b	80 	. 
	ld hl,08080h		;5c6c	21 80 80 	! . . 
	add a,b			;5c6f	80 	. 
	add a,b			;5c70	80 	. 
	add hl,de			;5c71	19 	. 
	ld a,h			;5c72	7c 	| 
	add a,h			;5c73	84 	. 
	rst 38h			;5c74	ff 	. 
	cp 0fdh		;5c75	fe fd 	. . 
	add hl,sp			;5c77	39 	9 
	ld e,e			;5c78	5b 	[ 
	cp 001h		;5c79	fe 01 	. . 
	ret m			;5c7b	f8 	. 
	jp m,0fefch		;5c7c	fa fc fe 	. . . 
	ld b,c			;5c7f	41 	A 
	ld a,h			;5c80	7c 	| 
	add a,h			;5c81	84 	. 
	rst 38h			;5c82	ff 	. 
	cp 0fdh		;5c83	fe fd 	. . 
	ld e,e			;5c85	5b 	[ 
	ld e,e			;5c86	5b 	[ 
	ei			;5c87	fb 	. 
	defb 0fdh,0feh,041h	;illegal sequence		;5c88	fd fe 41 	. . A 
	ld a,e			;5c8b	7b 	{ 
	ld a,h			;5c8c	7c 	| 
	rst 38h			;5c8d	ff 	. 
l5c8eh:
	xor b			;5c8e	a8 	. 
	ld e,h			;5c8f	5c 	\ 
	jp nz,0dd5ch		;5c90	c2 5c dd 	. \ . 
	ld e,h			;5c93	5c 	\ 
	di			;5c94	f3 	. 
	ld e,h			;5c95	5c 	\ 
	ex af,af'			;5c96	08 	. 
	ld e,l			;5c97	5d 	] 
	jr nz,l5cf7h		;5c98	20 5d 	  ] 
	inc sp			;5c9a	33 	3 
	ld e,l			;5c9b	5d 	] 
	inc a			;5c9c	3c 	< 
	ld e,l			;5c9d	5d 	] 
	ld a,(bc)			;5c9e	0a 	. 
	ld e,(hl)			;5c9f	5e 	^ 
	bit 3,e		;5ca0	cb 5b 	. [ 
	pop bc			;5ca2	c1 	. 
	ld e,e			;5ca3	5b 	[ 
	bit 3,e		;5ca4	cb 5b 	. [ 
	pop bc			;5ca6	c1 	. 
	ld e,e			;5ca7	5b 	[ 
	cp 003h		;5ca8	fe 03 	. . 
	rst 28h			;5caa	ef 	. 
	cp 009h		;5cab	fe 09 	. . 
	nop			;5cad	00 	. 
	nop			;5cae	00 	. 
	nop			;5caf	00 	. 
	nop			;5cb0	00 	. 
	cp 092h		;5cb1	fe 92 	. . 
	ld a,(03e3ch)		;5cb3	3a 3c 3e 	: < > 
	adc a,(hl)			;5cb6	8e 	. 
	cp 009h		;5cb7	fe 09 	. . 
	cp 0fdh		;5cb9	fe fd 	. . 
	ld d,h			;5cbb	54 	T 
	ld e,e			;5cbc	5b 	[ 
	call z,001feh		;5cbd	cc fe 01 	. . . 
	defb 0edh;next byte illegal after ed		;5cc0	ed 	. 
	rst 38h			;5cc1	ff 	. 
	cp 009h		;5cc2	fe 09 	. . 
	cp 0fdh		;5cc4	fe fd 	. . 
	ld d,l			;5cc6	55 	U 
	ld e,e			;5cc7	5b 	[ 
	cp 092h		;5cc8	fe 92 	. . 
	dec sp			;5cca	3b 	; 
	dec a			;5ccb	3d 	= 
	ld b,(hl)			;5ccc	46 	F 
	ld b,h			;5ccd	44 	D 
	ld b,(hl)			;5cce	46 	F 
	cp 009h		;5ccf	fe 09 	. . 
	nop			;5cd1	00 	. 
	nop			;5cd2	00 	. 
	nop			;5cd3	00 	. 
	nop			;5cd4	00 	. 
	cp 092h		;5cd5	fe 92 	. . 
	ld c,c			;5cd7	49 	I 
	cp 093h		;5cd8	fe 93 	. . 
	ld c,e			;5cda	4b 	K 
	ld c,l			;5cdb	4d 	M 
	rst 38h			;5cdc	ff 	. 
	cp 041h		;5cdd	fe 41 	. A 
	dec d			;5cdf	15 	. 
	rla			;5ce0	17 	. 
	adc a,b			;5ce1	88 	. 
	adc a,b			;5ce2	88 	. 
	adc a,b			;5ce3	88 	. 
	adc a,b			;5ce4	88 	. 
	cp 093h		;5ce5	fe 93 	. . 
	ccf			;5ce7	3f 	? 
	ld b,b			;5ce8	40 	@ 
	ld b,d			;5ce9	42 	B 
	ld b,a			;5cea	47 	G 
	ld b,l			;5ceb	45 	E 
	ld c,b			;5cec	48 	H 
	ld c,d			;5ced	4a 	J 
	ld c,h			;5cee	4c 	L 
	ld c,(hl)			;5cef	4e 	N 
	ld e,h			;5cf0	5c 	\ 
	ld e,(hl)			;5cf1	5e 	^ 
	rst 38h			;5cf2	ff 	. 
	cp 001h		;5cf3	fe 01 	. . 
	ld b,0f9h		;5cf5	06 f9 	. . 
l5cf7h:
	cp 0fdh		;5cf7	fe fd 	. . 
	ld d,l			;5cf9	55 	U 
	ld e,e			;5cfa	5b 	[ 
	cp 093h		;5cfb	fe 93 	. . 
	ld b,c			;5cfd	41 	A 
	ld b,e			;5cfe	43 	C 
	ld d,d			;5cff	52 	R 
	ld d,h			;5d00	54 	T 
	ld d,(hl)			;5d01	56 	V 
	ld e,b			;5d02	58 	X 
	ld e,d			;5d03	5a 	Z 
	add a,(hl)			;5d04	86 	. 
	ld e,l			;5d05	5d 	] 
	ld e,a			;5d06	5f 	_ 
	rst 38h			;5d07	ff 	. 
	cp 001h		;5d08	fe 01 	. . 
	ld b,0f9h		;5d0a	06 f9 	. . 
	cp 0fdh		;5d0c	fe fd 	. . 
	ld d,h			;5d0e	54 	T 
	ld e,e			;5d0f	5b 	[ 
	cp 093h		;5d10	fe 93 	. . 
	ld d,c			;5d12	51 	Q 
	ld d,e			;5d13	53 	S 
	ld d,l			;5d14	55 	U 
	ld d,a			;5d15	57 	W 
	ld e,c			;5d16	59 	Y 
	ld e,e			;5d17	5b 	[ 
	cp 001h		;5d18	fe 01 	. . 
	ld b,0feh		;5d1a	06 fe 	. . 
	sub e			;5d1c	93 	. 
	ld h,e			;5d1d	63 	c 
	ld e,a			;5d1e	5f 	_ 
	rst 38h			;5d1f	ff 	. 
	cp 0fdh		;5d20	fe fd 	. . 
	ld c,a			;5d22	4f 	O 
	ld e,e			;5d23	5b 	[ 
	cp 093h		;5d24	fe 93 	. . 
	ld c,a			;5d26	4f 	O 
	ld d,b			;5d27	50 	P 
	cp 013h		;5d28	fe 13 	. . 
	nop			;5d2a	00 	. 
	nop			;5d2b	00 	. 
	nop			;5d2c	00 	. 
	ld b,0feh		;5d2d	06 fe 	. . 
	sub e			;5d2f	93 	. 
	ld h,e			;5d30	63 	c 
	ld e,a			;5d31	5f 	_ 
	rst 38h			;5d32	ff 	. 
	cp 0fdh		;5d33	fe fd 	. . 
	dec hl			;5d35	2b 	+ 
	ld e,e			;5d36	5b 	[ 
	cp 093h		;5d37	fe 93 	. . 
	ld h,e			;5d39	63 	c 
	ld e,a			;5d3a	5f 	_ 
	rst 38h			;5d3b	ff 	. 
	cp 008h		;5d3c	fe 08 	. . 
	xor 0feh		;5d3e	ee fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;5d40	fd 2e 5b 	. . [ 
	cp 093h		;5d43	fe 93 	. . 
	ld h,b			;5d45	60 	` 
	ld h,d			;5d46	62 	b 
	rst 38h			;5d47	ff 	. 
l5d48h:
	ld h,d			;5d48	62 	b 
	ld e,l			;5d49	5d 	] 
	ld a,l			;5d4a	7d 	} 
	ld e,l			;5d4b	5d 	] 
	sbc a,b			;5d4c	98 	. 
	ld e,l			;5d4d	5d 	] 
	or d			;5d4e	b2 	. 
	ld e,l			;5d4f	5d 	] 
	jp z,0d65dh		;5d50	ca 5d d6 	. ] . 
	ld e,l			;5d53	5d 	] 
	jp po,0f75dh		;5d54	e2 5d f7 	. ] . 
	ld e,l			;5d57	5d 	] 
	ld a,(bc)			;5d58	0a 	. 
	ld e,(hl)			;5d59	5e 	^ 
	bit 3,e		;5d5a	cb 5b 	. [ 
	pop bc			;5d5c	c1 	. 
	ld e,e			;5d5d	5b 	[ 
	bit 3,e		;5d5e	cb 5b 	. [ 
	pop bc			;5d60	c1 	. 
	ld e,e			;5d61	5b 	[ 
	cp 003h		;5d62	fe 03 	. . 
	rst 28h			;5d64	ef 	. 
	cp 009h		;5d65	fe 09 	. . 
	nop			;5d67	00 	. 
	nop			;5d68	00 	. 
	nop			;5d69	00 	. 
	nop			;5d6a	00 	. 
	cp 092h		;5d6b	fe 92 	. . 
	add a,a			;5d6d	87 	. 
	adc a,d			;5d6e	8a 	. 
	adc a,h			;5d6f	8c 	. 
	adc a,(hl)			;5d70	8e 	. 
	cp 009h		;5d71	fe 09 	. . 
	cp 0fdh		;5d73	fe fd 	. . 
	ld d,l			;5d75	55 	U 
	ld e,e			;5d76	5b 	[ 
	nop			;5d77	00 	. 
	call z,001feh		;5d78	cc fe 01 	. . . 
	defb 0edh;next byte illegal after ed		;5d7b	ed 	. 
	rst 38h			;5d7c	ff 	. 
	cp 009h		;5d7d	fe 09 	. . 
	cp 0fdh		;5d7f	fe fd 	. . 
	ld d,l			;5d81	55 	U 
	ld e,e			;5d82	5b 	[ 
	cp 092h		;5d83	fe 92 	. . 
	adc a,b			;5d85	88 	. 
	adc a,e			;5d86	8b 	. 
	adc a,l			;5d87	8d 	. 
	adc a,a			;5d88	8f 	. 
	sub d			;5d89	92 	. 
	cp 009h		;5d8a	fe 09 	. . 
	nop			;5d8c	00 	. 
	nop			;5d8d	00 	. 
	nop			;5d8e	00 	. 
	nop			;5d8f	00 	. 
	call 001feh		;5d90	cd fe 01 	. . . 
	defb 0edh;next byte illegal after ed		;5d93	ed 	. 
	cp 092h		;5d94	fe 92 	. . 
	ld (hl),h			;5d96	74 	t 
	rst 38h			;5d97	ff 	. 
	cp 041h		;5d98	fe 41 	. A 
	dec d			;5d9a	15 	. 
	rla			;5d9b	17 	. 
	adc a,b			;5d9c	88 	. 
	adc a,b			;5d9d	88 	. 
	adc a,b			;5d9e	88 	. 
	adc a,b			;5d9f	88 	. 
	adc a,b			;5da0	88 	. 
	cp 093h		;5da1	fe 93 	. . 
	adc a,c			;5da3	89 	. 
	sub b			;5da4	90 	. 
	sub e			;5da5	93 	. 
	ld h,l			;5da6	65 	e 
	cp 041h		;5da7	fe 41 	. A 
	adc a,b			;5da9	88 	. 
	adc a,b			;5daa	88 	. 
	adc a,b			;5dab	88 	. 
	dec d			;5dac	15 	. 
	cp 093h		;5dad	fe 93 	. . 
	ld (hl),e			;5daf	73 	s 
	ld (hl),l			;5db0	75 	u 
	rst 38h			;5db1	ff 	. 
	cp 001h		;5db2	fe 01 	. . 
	ld b,0f9h		;5db4	06 f9 	. . 
	cp 0fdh		;5db6	fe fd 	. . 
	ld d,h			;5db8	54 	T 
	ld e,e			;5db9	5b 	[ 
	cp 093h		;5dba	fe 93 	. . 
	sub c			;5dbc	91 	. 
	ld h,h			;5dbd	64 	d 
	cp 041h		;5dbe	fe 41 	. A 
	add a,b			;5dc0	80 	. 
	add a,b			;5dc1	80 	. 
	add a,b			;5dc2	80 	. 
	add a,b			;5dc3	80 	. 
	cp 093h		;5dc4	fe 93 	. . 
	ld l,(hl)			;5dc6	6e 	n 
	ld (hl),b			;5dc7	70 	p 
	ld (hl),d			;5dc8	72 	r 
	rst 38h			;5dc9	ff 	. 
	cp 0fdh		;5dca	fe fd 	. . 
	ld (hl),05bh		;5dcc	36 5b 	6 [ 
	add a,b			;5dce	80 	. 
	cp 093h		;5dcf	fe 93 	. . 
	ld l,l			;5dd1	6d 	m 
	ld l,a			;5dd2	6f 	o 
	ld (hl),c			;5dd3	71 	q 
	ld e,a			;5dd4	5f 	_ 
	rst 38h			;5dd5	ff 	. 
	cp 0fdh		;5dd6	fe fd 	. . 
	ld (hl),05bh		;5dd8	36 5b 	6 [ 
	cp 093h		;5dda	fe 93 	. . 
	ld l,b			;5ddc	68 	h 
	ld l,d			;5ddd	6a 	j 
	ld l,h			;5dde	6c 	l 
	ld h,e			;5ddf	63 	c 
	ld e,a			;5de0	5f 	_ 
	rst 38h			;5de1	ff 	. 
	cp 0fdh		;5de2	fe fd 	. . 
	ld c,a			;5de4	4f 	O 
	ld e,e			;5de5	5b 	[ 
	cp 041h		;5de6	fe 41 	. A 
	ld (0fe80h),hl		;5de8	22 80 fe 	" . . 
	sub e			;5deb	93 	. 
	ld h,(hl)			;5dec	66 	f 
	ld l,c			;5ded	69 	i 
	ld l,e			;5dee	6b 	k 
	cp 013h		;5def	fe 13 	. . 
	ld (bc),a			;5df1	02 	. 
	cp 093h		;5df2	fe 93 	. . 
	ld h,e			;5df4	63 	c 
	ld e,a			;5df5	5f 	_ 
	rst 38h			;5df6	ff 	. 
	cp 008h		;5df7	fe 08 	. . 
	xor 0feh		;5df9	ee fe 	. . 
	add iy,sp		;5dfb	fd 39 	. 9 
	ld e,e			;5dfd	5b 	[ 
	cp 093h		;5dfe	fe 93 	. . 
	ld h,a			;5e00	67 	g 
	cp 041h		;5e01	fe 41 	. A 
	add a,b			;5e03	80 	. 
	add a,(hl)			;5e04	86 	. 
	cp 093h		;5e05	fe 93 	. . 
	ld h,b			;5e07	60 	` 
	ld h,d			;5e08	62 	b 
	rst 38h			;5e09	ff 	. 
	cp 008h		;5e0a	fe 08 	. . 
	rst 28h			;5e0c	ef 	. 
	cp 0fdh		;5e0d	fe fd 	. . 
	ld l,05bh		;5e0f	2e 5b 	. [ 
	cp 093h		;5e11	fe 93 	. . 
	ld h,c			;5e13	61 	a 
	cp 041h		;5e14	fe 41 	. A 
	add a,h			;5e16	84 	. 
	rst 38h			;5e17	ff 	. 
l5e18h:
	ld (04c5eh),a		;5e18	32 5e 4c 	2 ^ L 
	ld e,(hl)			;5e1b	5e 	^ 
	ld (hl),h			;5e1c	74 	t 
	ld e,(hl)			;5e1d	5e 	^ 
	ld a,l			;5e1e	7d 	} 
	ld e,(hl)			;5e1f	5e 	^ 
	ld a,l			;5e20	7d 	} 
	ld e,(hl)			;5e21	5e 	^ 
	ld a,l			;5e22	7d 	} 
	ld e,(hl)			;5e23	5e 	^ 
	add a,(hl)			;5e24	86 	. 
	ld e,(hl)			;5e25	5e 	^ 
	adc a,a			;5e26	8f 	. 
	ld e,(hl)			;5e27	5e 	^ 
	sbc a,e			;5e28	9b 	. 
	ld e,(hl)			;5e29	5e 	^ 
	bit 3,e		;5e2a	cb 5b 	. [ 
	pop bc			;5e2c	c1 	. 
	ld e,e			;5e2d	5b 	[ 
	bit 3,e		;5e2e	cb 5b 	. [ 
	pop bc			;5e30	c1 	. 
	ld e,e			;5e31	5b 	[ 
	cp 003h		;5e32	fe 03 	. . 
	rst 28h			;5e34	ef 	. 
	cp 009h		;5e35	fe 09 	. . 
	nop			;5e37	00 	. 
	nop			;5e38	00 	. 
	nop			;5e39	00 	. 
	nop			;5e3a	00 	. 
	cp 092h		;5e3b	fe 92 	. . 
	halt			;5e3d	76 	v 
	inc a			;5e3e	3c 	< 
	ld a,c			;5e3f	79 	y 
	cp 009h		;5e40	fe 09 	. . 
	cp 0fdh		;5e42	fe fd 	. . 
	ld d,h			;5e44	54 	T 
	ld e,e			;5e45	5b 	[ 
	nop			;5e46	00 	. 
	call z,001feh		;5e47	cc fe 01 	. . . 
	defb 0edh;next byte illegal after ed		;5e4a	ed 	. 
	rst 38h			;5e4b	ff 	. 
	cp 009h		;5e4c	fe 09 	. . 
	cp 0fdh		;5e4e	fe fd 	. . 
	ld d,l			;5e50	55 	U 
	ld e,e			;5e51	5b 	[ 
	cp 092h		;5e52	fe 92 	. . 
	ld (hl),a			;5e54	77 	w 
	ld a,b			;5e55	78 	x 
	cp 009h		;5e56	fe 09 	. . 
	cp 0fdh		;5e58	fe fd 	. . 
	ld d,e			;5e5a	53 	S 
	ld e,e			;5e5b	5b 	[ 
	call 092feh		;5e5c	cd fe 92 	. . . 
	ld a,d			;5e5f	7a 	z 
	ld a,h			;5e60	7c 	| 
	rst 38h			;5e61	ff 	. 
	cp 041h		;5e62	fe 41 	. A 
	dec d			;5e64	15 	. 
	rla			;5e65	17 	. 
	adc a,b			;5e66	88 	. 
	adc a,b			;5e67	88 	. 
	adc a,b			;5e68	88 	. 
	adc a,b			;5e69	88 	. 
	adc a,b			;5e6a	88 	. 
	adc a,b			;5e6b	88 	. 
	adc a,b			;5e6c	88 	. 
	rra			;5e6d	1f 	. 
	adc a,b			;5e6e	88 	. 
	adc a,b			;5e6f	88 	. 
	adc a,b			;5e70	88 	. 
	adc a,b			;5e71	88 	. 
	dec d			;5e72	15 	. 
	rst 38h			;5e73	ff 	. 
	cp 0fdh		;5e74	fe fd 	. . 
	ld h,d			;5e76	62 	b 
	ld e,(hl)			;5e77	5e 	^ 
	cp 092h		;5e78	fe 92 	. . 
	ld a,e			;5e7a	7b 	{ 
	inc (hl)			;5e7b	34 	4 
	rst 38h			;5e7c	ff 	. 
	cp 0fdh		;5e7d	fe fd 	. . 
	dec hl			;5e7f	2b 	+ 
	ld e,e			;5e80	5b 	[ 
	cp 091h		;5e81	fe 91 	. . 
	ld (0ff34h),a		;5e83	32 34 ff 	2 4 . 
	cp 0fdh		;5e86	fe fd 	. . 
	dec hl			;5e88	2b 	+ 
	ld e,e			;5e89	5b 	[ 
	cp 091h		;5e8a	fe 91 	. . 
	add a,b			;5e8c	80 	. 
	add a,d			;5e8d	82 	. 
	rst 38h			;5e8e	ff 	. 
	cp 008h		;5e8f	fe 08 	. . 
	xor 0feh		;5e91	ee fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;5e93	fd 2e 5b 	. . [ 
	cp 091h		;5e96	fe 91 	. . 
	add a,c			;5e98	81 	. 
	add a,e			;5e99	83 	. 
	rst 38h			;5e9a	ff 	. 
	cp 008h		;5e9b	fe 08 	. . 
	rst 28h			;5e9d	ef 	. 
	cp 0fdh		;5e9e	fe fd 	. . 
	ld l,05bh		;5ea0	2e 5b 	. [ 
	cp 091h		;5ea2	fe 91 	. . 
	ld a,a			;5ea4	7f 	 
	cp 041h		;5ea5	fe 41 	. A 
	add a,h			;5ea7	84 	. 
	rst 38h			;5ea8	ff 	. 
l5ea9h:
	rst 8			;5ea9	cf 	. 
	ld e,(hl)			;5eaa	5e 	^ 
	jp po,0f45eh		;5eab	e2 5e f4 	. ^ . 
	ld e,(hl)			;5eae	5e 	^ 
	inc c			;5eaf	0c 	. 
	ld e,a			;5eb0	5f 	_ 
	ld hl,0395fh		;5eb1	21 5f 39 	! _ 9 
	ld e,a			;5eb4	5f 	_ 
	ld d,e			;5eb5	53 	S 
	ld e,a			;5eb6	5f 	_ 
	ld l,l			;5eb7	6d 	m 
	ld e,a			;5eb8	5f 	_ 
	adc a,e			;5eb9	8b 	. 
	ld e,a			;5eba	5f 	_ 
	and a			;5ebb	a7 	. 
	ld e,a			;5ebc	5f 	_ 
	jp 0df5fh		;5ebd	c3 5f df 	. _ . 
	ld e,a			;5ec0	5f 	_ 
	defb 0fdh,05fh,018h	;illegal sequence		;5ec1	fd 5f 18 	. _ . 
	ld h,b			;5ec4	60 	` 
	dec hl			;5ec5	2b 	+ 
	ld h,b			;5ec6	60 	` 
	ld b,a			;5ec7	47 	G 
	ld h,b			;5ec8	60 	` 
	ld h,l			;5ec9	65 	e 
	ld h,b			;5eca	60 	` 
	add a,e			;5ecb	83 	. 
	ld h,b			;5ecc	60 	` 
	sbc a,e			;5ecd	9b 	. 
	ld h,b			;5ece	60 	` 
	cp 003h		;5ecf	fe 03 	. . 
	rst 28h			;5ed1	ef 	. 
	cp 009h		;5ed2	fe 09 	. . 
	nop			;5ed4	00 	. 
	nop			;5ed5	00 	. 
	nop			;5ed6	00 	. 
	call nz,0c8c6h		;5ed7	c4 c6 c8 	. . . 
	ret z			;5eda	c8 	. 
	ret z			;5edb	c8 	. 
	ret			;5edc	c9 	. 
	rlc b		;5edd	cb 00 	. . 
	nop			;5edf	00 	. 
	nop			;5ee0	00 	. 
	rst 38h			;5ee1	ff 	. 
	cp 009h		;5ee2	fe 09 	. . 
	nop			;5ee4	00 	. 
	nop			;5ee5	00 	. 
	nop			;5ee6	00 	. 
	nop			;5ee7	00 	. 
	push bc			;5ee8	c5 	. 
	rst 0			;5ee9	c7 	. 
	rst 0			;5eea	c7 	. 
	rst 0			;5eeb	c7 	. 
	rst 0			;5eec	c7 	. 
	jp z,00000h		;5eed	ca 00 00 	. . . 
	nop			;5ef0	00 	. 
	nop			;5ef1	00 	. 
	call 0feffh		;5ef2	cd ff fe 	. . . 
	add hl,bc			;5ef5	09 	. 
	jp 041feh		;5ef6	c3 fe 41 	. . A 
	rla			;5ef9	17 	. 
	adc a,b			;5efa	88 	. 
	adc a,b			;5efb	88 	. 
	adc a,b			;5efc	88 	. 
	adc a,b			;5efd	88 	. 
	adc a,b			;5efe	88 	. 
	adc a,b			;5eff	88 	. 
	adc a,b			;5f00	88 	. 
	rra			;5f01	1f 	. 
	adc a,b			;5f02	88 	. 
	adc a,b			;5f03	88 	. 
	adc a,b			;5f04	88 	. 
	adc a,b			;5f05	88 	. 
	dec d			;5f06	15 	. 
	cp 007h		;5f07	fe 07 	. . 
	add a,b			;5f09	80 	. 
	add a,d			;5f0a	82 	. 
	rst 38h			;5f0b	ff 	. 
	cp 006h		;5f0c	fe 06 	. . 
	and a			;5f0e	a7 	. 
	xor b			;5f0f	a8 	. 
	cp 0fdh		;5f10	fe fd 	. . 
	ld d,e			;5f12	53 	S 
	ld e,e			;5f13	5b 	[ 
	cp 041h		;5f14	fe 41 	. A 
	ld (08080h),hl		;5f16	22 80 80 	" . . 
	add a,b			;5f19	80 	. 
	add a,b			;5f1a	80 	. 
	add a,(hl)			;5f1b	86 	. 
	cp 007h		;5f1c	fe 07 	. . 
	add a,c			;5f1e	81 	. 
	add a,e			;5f1f	83 	. 
	rst 38h			;5f20	ff 	. 
	cp 045h		;5f21	fe 45 	. E 
	adc a,d			;5f23	8a 	. 
	cp 006h		;5f24	fe 06 	. . 
	inc b			;5f26	04 	. 
	xor c			;5f27	a9 	. 
	xor d			;5f28	aa 	. 
	xor e			;5f29	ab 	. 
	xor e			;5f2a	ab 	. 
	xor e			;5f2b	ab 	. 
	xor e			;5f2c	ab 	. 
	xor e			;5f2d	ab 	. 
	cp l			;5f2e	bd 	. 
	xor e			;5f2f	ab 	. 
	xor e			;5f30	ab 	. 
	xor e			;5f31	ab 	. 
	xor e			;5f32	ab 	. 
	ret nz			;5f33	c0 	. 
	cp 00ah		;5f34	fe 0a 	. . 
	sub 0d4h		;5f36	d6 d4 	. . 
	rst 38h			;5f38	ff 	. 
	cp 006h		;5f39	fe 06 	. . 
	and c			;5f3b	a1 	. 
	and d			;5f3c	a2 	. 
	cp 005h		;5f3d	fe 05 	. . 
	adc a,h			;5f3f	8c 	. 
	cp 006h		;5f40	fe 06 	. . 
	xor h			;5f42	ac 	. 
	xor l			;5f43	ad 	. 
	xor (hl)			;5f44	ae 	. 
	xor (hl)			;5f45	ae 	. 
	xor (hl)			;5f46	ae 	. 
	xor (hl)			;5f47	ae 	. 
	cp (hl)			;5f48	be 	. 
	xor (hl)			;5f49	ae 	. 
	xor (hl)			;5f4a	ae 	. 
	xor (hl)			;5f4b	ae 	. 
	xor (hl)			;5f4c	ae 	. 
	pop bc			;5f4d	c1 	. 
	cp 04ah		;5f4e	fe 4a 	. J 
	ld a,l			;5f50	7d 	} 
	ld a,(hl)			;5f51	7e 	~ 
	rst 38h			;5f52	ff 	. 
	cp 006h		;5f53	fe 06 	. . 
	sbc a,(hl)			;5f55	9e 	. 
	and e			;5f56	a3 	. 
	and (hl)			;5f57	a6 	. 
	cp 005h		;5f58	fe 05 	. . 
	adc a,a			;5f5a	8f 	. 
	cp 006h		;5f5b	fe 06 	. . 
	inc b			;5f5d	04 	. 
	xor a			;5f5e	af 	. 
	or b			;5f5f	b0 	. 
	or c			;5f60	b1 	. 
	or c			;5f61	b1 	. 
	cp a			;5f62	bf 	. 
	or c			;5f63	b1 	. 
	or c			;5f64	b1 	. 
	or c			;5f65	b1 	. 
	or c			;5f66	b1 	. 
	jp nz,04afeh		;5f67	c2 fe 4a 	. . J 
	ld a,a			;5f6a	7f 	 
	add a,e			;5f6b	83 	. 
	rst 38h			;5f6c	ff 	. 
	cp 008h		;5f6d	fe 08 	. . 
	call pe,006feh		;5f6f	ec fe 06 	. . . 
	and h			;5f72	a4 	. 
	sub h			;5f73	94 	. 
	sub (hl)			;5f74	96 	. 
	sbc a,c			;5f75	99 	. 
	cp 005h		;5f76	fe 05 	. . 
	adc a,h			;5f78	8c 	. 
	cp 006h		;5f79	fe 06 	. . 
	or d			;5f7b	b2 	. 
	or e			;5f7c	b3 	. 
	nop			;5f7d	00 	. 
	cp 041h		;5f7e	fe 41 	. A 
	ld (08080h),hl		;5f80	22 80 80 	" . . 
l5f83h:
	add a,b			;5f83	80 	. 
	cp 004h		;5f84	fe 04 	. . 
	add a,h			;5f86	84 	. 
	add a,(hl)			;5f87	86 	. 
	adc a,b			;5f88	88 	. 
	adc a,d			;5f89	8a 	. 
	rst 38h			;5f8a	ff 	. 
	cp 008h		;5f8b	fe 08 	. . 
	rst 28h			;5f8d	ef 	. 
	cp 006h		;5f8e	fe 06 	. . 
	and l			;5f90	a5 	. 
	sub l			;5f91	95 	. 
	sub a			;5f92	97 	. 
	sbc a,d			;5f93	9a 	. 
	sub e			;5f94	93 	. 
	cp 005h		;5f95	fe 05 	. . 
	adc a,(hl)			;5f97	8e 	. 
	cp 006h		;5f98	fe 06 	. . 
	inc b			;5f9a	04 	. 
	or h			;5f9b	b4 	. 
	or l			;5f9c	b5 	. 
	nop			;5f9d	00 	. 
	nop			;5f9e	00 	. 
	nop			;5f9f	00 	. 
	cp 004h		;5fa0	fe 04 	. . 
	add a,l			;5fa2	85 	. 
	add a,a			;5fa3	87 	. 
	adc a,c			;5fa4	89 	. 
	adc a,e			;5fa5	8b 	. 
	rst 38h			;5fa6	ff 	. 
	cp 001h		;5fa7	fe 01 	. . 
	ld b,0f9h		;5fa9	06 f9 	. . 
	nop			;5fab	00 	. 
	cp 006h		;5fac	fe 06 	. . 
	sbc a,b			;5fae	98 	. 
	sbc a,e			;5faf	9b 	. 
	sub h			;5fb0	94 	. 
	sub (hl)			;5fb1	96 	. 
	sbc a,c			;5fb2	99 	. 
	cp 005h		;5fb3	fe 05 	. . 
	adc a,h			;5fb5	8c 	. 
	cp 006h		;5fb6	fe 06 	. . 
	or (hl)			;5fb8	b6 	. 
	or a			;5fb9	b7 	. 
	xor e			;5fba	ab 	. 
	xor e			;5fbb	ab 	. 
	xor e			;5fbc	ab 	. 
	ret nz			;5fbd	c0 	. 
	cp 00ah		;5fbe	fe 0a 	. . 
	call nc,0ffd6h		;5fc0	d4 d6 ff 	. . . 
	cp 001h		;5fc3	fe 01 	. . 
	ld b,0f9h		;5fc5	06 f9 	. . 
	nop			;5fc7	00 	. 
	nop			;5fc8	00 	. 
	cp 006h		;5fc9	fe 06 	. . 
	sbc a,h			;5fcb	9c 	. 
	sub l			;5fcc	95 	. 
	sub a			;5fcd	97 	. 
	sbc a,d			;5fce	9a 	. 
	sub e			;5fcf	93 	. 
	cp 005h		;5fd0	fe 05 	. . 
	adc a,(hl)			;5fd2	8e 	. 
	cp 006h		;5fd3	fe 06 	. . 
	inc b			;5fd5	04 	. 
	cp b			;5fd6	b8 	. 
	cp c			;5fd7	b9 	. 
	xor (hl)			;5fd8	ae 	. 
	pop bc			;5fd9	c1 	. 
	cp 00ah		;5fda	fe 0a 	. . 
	push de			;5fdc	d5 	. 
	rst 10h			;5fdd	d7 	. 
	rst 38h			;5fde	ff 	. 
	cp 001h		;5fdf	fe 01 	. . 
	ld b,0f9h		;5fe1	06 f9 	. . 
	nop			;5fe3	00 	. 
	nop			;5fe4	00 	. 
	nop			;5fe5	00 	. 
	nop			;5fe6	00 	. 
	cp 006h		;5fe7	fe 06 	. . 
	sbc a,b			;5fe9	98 	. 
	sbc a,e			;5fea	9b 	. 
	sub h			;5feb	94 	. 
	sbc a,l			;5fec	9d 	. 
	and b			;5fed	a0 	. 
	cp 005h		;5fee	fe 05 	. . 
	adc a,h			;5ff0	8c 	. 
	cp 006h		;5ff1	fe 06 	. . 
	cp d			;5ff3	ba 	. 
	cp e			;5ff4	bb 	. 
	jp nz,00afeh		;5ff5	c2 fe 0a 	. . . 
	ret c			;5ff8	d8 	. 
	cp 041h		;5ff9	fe 41 	. A 
	ld a,h			;5ffb	7c 	| 
	rst 38h			;5ffc	ff 	. 
	cp 001h		;5ffd	fe 01 	. . 
	ld b,0f9h		;5fff	06 f9 	. . 
	cp 0fdh		;6001	fe fd 	. . 
	ld d,l			;6003	55 	U 
	ld e,e			;6004	5b 	[ 
	cp 006h		;6005	fe 06 	. . 
	sbc a,h			;6007	9c 	. 
	sub l			;6008	95 	. 
	sbc a,(hl)			;6009	9e 	. 
	sbc a,d			;600a	9a 	. 
	sub e			;600b	93 	. 
	cp 005h		;600c	fe 05 	. . 
	adc a,(hl)			;600e	8e 	. 
	cp 006h		;600f	fe 06 	. . 
	inc b			;6011	04 	. 
	cp h			;6012	bc 	. 
	cp 00ah		;6013	fe 0a 	. . 
	out (003h),a		;6015	d3 03 	. . 
	rst 38h			;6017	ff 	. 
	cp 0fdh		;6018	fe fd 	. . 
	ld c,a			;601a	4f 	O 
	ld e,e			;601b	5b 	[ 
	cp 006h		;601c	fe 06 	. . 
	sbc a,a			;601e	9f 	. 
	sbc a,e			;601f	9b 	. 
	sub h			;6020	94 	. 
	sub (hl)			;6021	96 	. 
	sbc a,c			;6022	99 	. 
	cp 005h		;6023	fe 05 	. . 
	adc a,h			;6025	8c 	. 
	cp 00ah		;6026	fe 0a 	. . 
	pop de			;6028	d1 	. 
	jp nc,0feffh		;6029	d2 ff fe 	. . . 
	ld bc,0f906h		;602c	01 06 f9 	. . . 
	cp 00bh		;602f	fe 0b 	. . 
	exx			;6031	d9 	. 
	call c,0dcdch		;6032	dc dc dc 	. . . 
	call c,0fedeh		;6035	dc de fe 	. . . 
	ld b,c			;6038	41 	A 
	add a,b			;6039	80 	. 
	ld (006feh),hl		;603a	22 fe 06 	" . . 
	sbc a,h			;603d	9c 	. 
	sub l			;603e	95 	. 
	sub a			;603f	97 	. 
	sbc a,d			;6040	9a 	. 
	sub b			;6041	90 	. 
	cp 005h		;6042	fe 05 	. . 
	adc a,l			;6044	8d 	. 
	rlca			;6045	07 	. 
	rst 38h			;6046	ff 	. 
	cp 008h		;6047	fe 08 	. . 
	xor 0feh		;6049	ee fe 	. . 
	ld bc,0fef9h		;604b	01 f9 fe 	. . . 
	dec bc			;604e	0b 	. 
	jp c,0db07h		;604f	da 07 db 	. . . 
	defb 0ddh,0dfh,0e9h	;illegal sequence		;6052	dd df e9 	. . . 
	cp 041h		;6055	fe 41 	. A 
	add a,b			;6057	80 	. 
	ld (08080h),hl		;6058	22 80 80 	" . . 
	cp 006h		;605b	fe 06 	. . 
	sbc a,b			;605d	98 	. 
	sbc a,e			;605e	9b 	. 
	sub c			;605f	91 	. 
	cp 00ah		;6060	fe 0a 	. . 
	rst 8			;6062	cf 	. 
	ret nc			;6063	d0 	. 
	rst 38h			;6064	ff 	. 
	cp 008h		;6065	fe 08 	. . 
	rst 28h			;6067	ef 	. 
	cp 001h		;6068	fe 01 	. . 
	ld sp,hl			;606a	f9 	. 
	cp 00bh		;606b	fe 0b 	. . 
	jp c,0e2e0h		;606d	da e0 e2 	. . . 
	call po,0e9e6h		;6070	e4 e6 e9 	. . . 
	cp 041h		;6073	fe 41 	. A 
	add a,b			;6075	80 	. 
	ld (08080h),hl		;6076	22 80 80 	" . . 
	add a,b			;6079	80 	. 
	cp 006h		;607a	fe 06 	. . 
	sbc a,h			;607c	9c 	. 
	sub d			;607d	92 	. 
	cp 00ah		;607e	fe 0a 	. . 
	adc a,003h		;6080	ce 03 	. . 
	rst 38h			;6082	ff 	. 
	cp 001h		;6083	fe 01 	. . 
	ld b,0f9h		;6085	06 f9 	. . 
	cp 00bh		;6087	fe 0b 	. . 
	jp c,0e3e1h		;6089	da e1 e3 	. . . 
	push hl			;608c	e5 	. 
	rst 20h			;608d	e7 	. 
	jp (hl)			;608e	e9 	. 
	cp 041h		;608f	fe 41 	. A 
	add a,b			;6091	80 	. 
	ld (08080h),hl		;6092	22 80 80 	" . . 
	add a,b			;6095	80 	. 
	add a,b			;6096	80 	. 
	add a,(hl)			;6097	86 	. 
	add a,h			;6098	84 	. 
	ld a,h			;6099	7c 	| 
	rst 38h			;609a	ff 	. 
	cp 001h		;609b	fe 01 	. . 
	ld b,0f9h		;609d	06 f9 	. . 
	cp 00bh		;609f	fe 0b 	. . 
	ex de,hl			;60a1	eb 	. 
	ret pe			;60a2	e8 	. 
	ret pe			;60a3	e8 	. 
	ret pe			;60a4	e8 	. 
	ret pe			;60a5	e8 	. 
	jp pe,041feh		;60a6	ea fe 41 	. . A 
	add a,b			;60a9	80 	. 
	ld (08080h),hl		;60aa	22 80 80 	" . . 
	add a,b			;60ad	80 	. 
	add a,b			;60ae	80 	. 
	add a,(hl)			;60af	86 	. 
	ld a,h			;60b0	7c 	| 
	add a,h			;60b1	84 	. 
	rst 38h			;60b2	ff 	. 
l60b3h:
	dec d			;60b3	15 	. 
	ld h,c			;60b4	61 	a 
	add hl,bc			;60b5	09 	. 
	ld h,c			;60b6	61 	a 
	ld (bc),a			;60b7	02 	. 
	ld h,c			;60b8	61 	a 
	or 060h		;60b9	f6 60 	. ` 
	push hl			;60bb	e5 	. 
	ld h,b			;60bc	60 	` 
	exx			;60bd	d9 	. 
	ld h,b			;60be	60 	` 
	scf			;60bf	37 	7 
	ld h,e			;60c0	63 	c 
	add a,l			;60c1	85 	. 
	ld h,e			;60c2	63 	c 
	sub b			;60c3	90 	. 
	ld h,e			;60c4	63 	c 
	jr nc,l612ah		;60c5	30 63 	0 c 
	scf			;60c7	37 	7 
	ld h,e			;60c8	63 	c 
	jr nc,l612eh		;60c9	30 63 	0 c 
	scf			;60cb	37 	7 
	ld h,e			;60cc	63 	c 
	jr nc,l6132h		;60cd	30 63 	0 c 
	scf			;60cf	37 	7 
	ld h,e			;60d0	63 	c 
	add a,l			;60d1	85 	. 
	ld h,e			;60d2	63 	c 
	sub b			;60d3	90 	. 
	ld h,e			;60d4	63 	c 
	jr nc,l613ah		;60d5	30 63 	0 c 
	scf			;60d7	37 	7 
	ld h,e			;60d8	63 	c 
	cp 0fdh		;60d9	fe fd 	. . 
	ld (hl),05bh		;60db	36 5b 	6 [ 
	add a,b			;60dd	80 	. 
	add a,b			;60de	80 	. 
	cp 096h		;60df	fe 96 	. . 
	or h			;60e1	b4 	. 
	or (hl)			;60e2	b6 	. 
	or l			;60e3	b5 	. 
	rst 38h			;60e4	ff 	. 
	cp 0fdh		;60e5	fe fd 	. . 
	ld c,a			;60e7	4f 	O 
	ld e,e			;60e8	5b 	[ 
	cp 041h		;60e9	fe 41 	. A 
	ld (0fe80h),hl		;60eb	22 80 fe 	" . . 
	sub (hl)			;60ee	96 	. 
	or a			;60ef	b7 	. 
	xor e			;60f0	ab 	. 
	xor l			;60f1	ad 	. 
	xor a			;60f2	af 	. 
	or c			;60f3	b1 	. 
	or e			;60f4	b3 	. 
l60f5h:
	rst 38h			;60f5	ff 	. 
	cp 0fdh		;60f6	fe fd 	. . 
	ld (hl),05bh		;60f8	36 5b 	6 [ 
	cp 096h		;60fa	fe 96 	. . 
	xor d			;60fc	aa 	. 
sub_60fdh:
	xor h			;60fd	ac 	. 
	xor (hl)			;60fe	ae 	. 
	or b			;60ff	b0 	. 
	or d			;6100	b2 	. 
	rst 38h			;6101	ff 	. 
	cp 0fdh		;6102	fe fd 	. . 
	ld h,d			;6104	62 	b 
	ld e,(hl)			;6105	5e 	^ 
	add a,h			;6106	84 	. 
	add a,h			;6107	84 	. 
	rst 38h			;6108	ff 	. 
	cp 0fdh		;6109	fe fd 	. . 
	ld b,l			;610b	45 	E 
	ld e,e			;610c	5b 	[ 
	cp 092h		;610d	fe 92 	. . 
	ld c,c			;610f	49 	I 
	cp 001h		;6110	fe 01 	. . 
	defb 0edh;next byte illegal after ed		;6112	ed 	. 
	inc b			;6113	04 	. 
	rst 38h			;6114	ff 	. 
	cp 003h		;6115	fe 03 	. . 
	rst 28h			;6117	ef 	. 
	cp 0fdh		;6118	fe fd 	. . 
	ld b,l			;611a	45 	E 
	ld e,e			;611b	5b 	[ 
	call z,001feh		;611c	cc fe 01 	. . . 
	defb 0edh;next byte illegal after ed		;611f	ed 	. 
	rst 38h			;6120	ff 	. 
	dec a			;6121	3d 	= 
	ld h,c			;6122	61 	a 
	ld e,c			;6123	59 	Y 
	ld h,c			;6124	61 	a 
	ld a,e			;6125	7b 	{ 
	ld h,c			;6126	61 	a 
	sbc a,e			;6127	9b 	. 
	ld h,c			;6128	61 	a 
	cp e			;6129	bb 	. 
l612ah:
	ld h,c			;612a	61 	a 
	push de			;612b	d5 	. 
	ld h,c			;612c	61 	a 
	ex de,hl			;612d	eb 	. 
l612eh:
	ld h,c			;612e	61 	a 
	inc bc			;612f	03 	. 
	ld h,d			;6130	62 	b 
	dec de			;6131	1b 	. 
l6132h:
	ld h,d			;6132	62 	b 
	scf			;6133	37 	7 
	ld h,d			;6134	62 	b 
	ld d,e			;6135	53 	S 
	ld h,d			;6136	62 	b 
	ld l,c			;6137	69 	i 
	ld h,d			;6138	62 	b 
	ld a,l			;6139	7d 	} 
l613ah:
	ld h,d			;613a	62 	b 
	sub c			;613b	91 	. 
	ld h,d			;613c	62 	b 
	cp 008h		;613d	fe 08 	. . 
	xor 0feh		;613f	ee fe 	. . 
	ld bc,0fef9h		;6141	01 f9 fe 	. . . 
	dec bc			;6144	0b 	. 
	exx			;6145	d9 	. 
	call c,0dcdch		;6146	dc dc dc 	. . . 
	call c,004deh		;6149	dc de 04 	. . . 
	cp 041h		;614c	fe 41 	. A 
	ld (08080h),hl		;614e	22 80 80 	" . . 
	add a,b			;6151	80 	. 
	add a,b			;6152	80 	. 
	add a,(hl)			;6153	86 	. 
	cp 04ah		;6154	fe 4a 	. J 
	ld c,(hl)			;6156	4e 	N 
	add a,c			;6157	81 	. 
	rst 38h			;6158	ff 	. 
	cp 008h		;6159	fe 08 	. . 
	rst 28h			;615b	ef 	. 
	cp 001h		;615c	fe 01 	. . 
	ld sp,hl			;615e	f9 	. 
	cp 00bh		;615f	fe 0b 	. . 
	jp c,l4bfeh		;6161	da fe 4b 	. . K 
	add a,a			;6164	87 	. 
	adc a,l			;6165	8d 	. 
	sub b			;6166	90 	. 
	cp 00bh		;6167	fe 0b 	. . 
	rlca			;6169	07 	. 
	jp (hl)			;616a	e9 	. 
	inc b			;616b	04 	. 
	cp 041h		;616c	fe 41 	. A 
	ld (08080h),hl		;616e	22 80 80 	" . . 
	add a,b			;6171	80 	. 
	add a,b			;6172	80 	. 
	cp 046h		;6173	fe 46 	. F 
l6175h:
	ld c,e			;6175	4b 	K 
l6176h:
	cp 04ch		;6176	fe 4c 	. L 
	sbc a,e			;6178	9b 	. 
	xor c			;6179	a9 	. 
	rst 38h			;617a	ff 	. 
	cp 001h		;617b	fe 01 	. . 
	ld b,0f9h		;617d	06 f9 	. . 
	cp 00bh		;617f	fe 0b 	. . 
	jp c,l4bfeh		;6181	da fe 4b 	. . K 
	add a,a			;6184	87 	. 
	adc a,(hl)			;6185	8e 	. 
	sub c			;6186	91 	. 
	cp 00bh		;6187	fe 0b 	. . 
	rlca			;6189	07 	. 
	jp (hl)			;618a	e9 	. 
	inc b			;618b	04 	. 
	cp 041h		;618c	fe 41 	. A 
	ld (08080h),hl		;618e	22 80 80 	" . . 
	cp 046h		;6191	fe 46 	. F 
	ld c,h			;6193	4c 	L 
	cp 04ch		;6194	fe 4c 	. L 
	add a,e			;6196	83 	. 
	sbc a,a			;6197	9f 	. 
	and a			;6198	a7 	. 
	add a,a			;6199	87 	. 
	rst 38h			;619a	ff 	. 
	cp 001h		;619b	fe 01 	. . 
	ld b,0f9h		;619d	06 f9 	. . 
	cp 00bh		;619f	fe 0b 	. . 
	jp c,l4bfeh		;61a1	da fe 4b 	. . K 
	adc a,h			;61a4	8c 	. 
	adc a,a			;61a5	8f 	. 
	sub d			;61a6	92 	. 
	cp 00bh		;61a7	fe 0b 	. . 
	rlca			;61a9	07 	. 
	jp (hl)			;61aa	e9 	. 
	inc b			;61ab	04 	. 
	cp 041h		;61ac	fe 41 	. A 
	ld (0fe80h),hl		;61ae	22 80 fe 	" . . 
	ld b,(hl)			;61b1	46 	F 
	ld c,e			;61b2	4b 	K 
	cp 04ch		;61b3	fe 4c 	. L 
	sbc a,e			;61b5	9b 	. 
	sbc a,h			;61b6	9c 	. 
	ld c,c			;61b7	49 	I 
	xor b			;61b8	a8 	. 
	add a,a			;61b9	87 	. 
	rst 38h			;61ba	ff 	. 
	cp 001h		;61bb	fe 01 	. . 
	ld b,0f9h		;61bd	06 f9 	. . 
	cp 00bh		;61bf	fe 0b 	. . 
	ex de,hl			;61c1	eb 	. 
	ret pe			;61c2	e8 	. 
	ret pe			;61c3	e8 	. 
	ret pe			;61c4	e8 	. 
	ret pe			;61c5	e8 	. 
	jp pe,0fe04h		;61c6	ea 04 fe 	. . . 
	ld b,(hl)			;61c9	46 	F 
	ld c,l			;61ca	4d 	M 
l61cbh:
	cp 04ch		;61cb	fe 4c 	. L 
	add a,e			;61cd	83 	. 
	sbc a,a			;61ce	9f 	. 
	and b			;61cf	a0 	. 
	and c			;61d0	a1 	. 
	add a,l			;61d1	85 	. 
	add a,a			;61d2	87 	. 
	add a,a			;61d3	87 	. 
	rst 38h			;61d4	ff 	. 
	cp 001h		;61d5	fe 01 	. . 
	ld b,0f9h		;61d7	06 f9 	. . 
	cp 0fdh		;61d9	fe fd 	. . 
	ld d,h			;61db	54 	T 
	ld e,e			;61dc	5b 	[ 
	cp 046h		;61dd	fe 46 	. F 
	ld c,e			;61df	4b 	K 
	cp 04ch		;61e0	fe 4c 	. L 
	sbc a,e			;61e2	9b 	. 
	and l			;61e3	a5 	. 
	and (hl)			;61e4	a6 	. 
	sbc a,d			;61e5	9a 	. 
	sbc a,d			;61e6	9a 	. 
l61e7h:
	ld b,d			;61e7	42 	B 
	ld b,e			;61e8	43 	C 
	ld b,h			;61e9	44 	D 
	rst 38h			;61ea	ff 	. 
	cp 001h		;61eb	fe 01 	. . 
	ld b,0f9h		;61ed	06 f9 	. . 
	nop			;61ef	00 	. 
	nop			;61f0	00 	. 
	nop			;61f1	00 	. 
	nop			;61f2	00 	. 
	cp 046h		;61f3	fe 46 	. F 
	ld c,h			;61f5	4c 	L 
	cp 04ch		;61f6	fe 4c 	. L 
	add a,e			;61f8	83 	. 
	sbc a,a			;61f9	9f 	. 
	and e			;61fa	a3 	. 
	and h			;61fb	a4 	. 
	ld a,03eh		;61fc	3e 3e 	> > 
	ld a,045h		;61fe	3e 45 	> E 
	ld c,b			;6200	48 	H 
	add a,a			;6201	87 	. 
	rst 38h			;6202	ff 	. 
	cp 001h		;6203	fe 01 	. . 
	ld b,0f9h		;6205	06 f9 	. . 
	nop			;6207	00 	. 
	nop			;6208	00 	. 
	nop			;6209	00 	. 
	cp 046h		;620a	fe 46 	. F 
	ld c,e			;620c	4b 	K 
	cp 04ch		;620d	fe 4c 	. L 
	sbc a,e			;620f	9b 	. 
	sbc a,h			;6210	9c 	. 
	and d			;6211	a2 	. 
	ld b,b			;6212	40 	@ 
	dec a			;6213	3d 	= 
	dec a			;6214	3d 	= 
	dec a			;6215	3d 	= 
	dec a			;6216	3d 	= 
	ld b,(hl)			;6217	46 	F 
	ld b,a			;6218	47 	G 
	add a,a			;6219	87 	. 
	rst 38h			;621a	ff 	. 
	cp 008h		;621b	fe 08 	. . 
	xor 0feh		;621d	ee fe 	. . 
	ld bc,000f9h		;621f	01 f9 00 	. . . 
	cp 046h		;6222	fe 46 	. F 
	ld c,h			;6224	4c 	L 
	cp 04ch		;6225	fe 4c 	. L 
	add a,e			;6227	83 	. 
	sbc a,a			;6228	9f 	. 
	and b			;6229	a0 	. 
	and c			;622a	a1 	. 
	add a,b			;622b	80 	. 
	cp 041h		;622c	fe 41 	. A 
	ld (08080h),hl		;622e	22 80 80 	" . . 
	add a,b			;6231	80 	. 
	add a,b			;6232	80 	. 
	add a,(hl)			;6233	86 	. 
	add a,h			;6234	84 	. 
	add a,h			;6235	84 	. 
	rst 38h			;6236	ff 	. 
	cp 008h		;6237	fe 08 	. . 
	rst 28h			;6239	ef 	. 
	cp 001h		;623a	fe 01 	. . 
	ld sp,hl			;623c	f9 	. 
	cp 046h		;623d	fe 46 	. F 
	ld c,e			;623f	4b 	K 
	cp 04ch		;6240	fe 4c 	. L 
	sbc a,e			;6242	9b 	. 
	sbc a,h			;6243	9c 	. 
	sbc a,l			;6244	9d 	. 
	sbc a,(hl)			;6245	9e 	. 
	add a,b			;6246	80 	. 
	add a,b			;6247	80 	. 
	cp 041h		;6248	fe 41 	. A 
	ld (08080h),hl		;624a	22 80 80 	" . . 
	add a,b			;624d	80 	. 
	add a,b			;624e	80 	. 
	add a,(hl)			;624f	86 	. 
	add a,h			;6250	84 	. 
	add a,h			;6251	84 	. 
	rst 38h			;6252	ff 	. 
	cp 046h		;6253	fe 46 	. F 
	ld c,d			;6255	4a 	J 
	cp 04ch		;6256	fe 4c 	. L 
	add a,e			;6258	83 	. 
	sbc a,b			;6259	98 	. 
	sbc a,c			;625a	99 	. 
	sbc a,d			;625b	9a 	. 
	sbc a,d			;625c	9a 	. 
	sbc a,d			;625d	9a 	. 
	sbc a,d			;625e	9a 	. 
	sbc a,d			;625f	9a 	. 
	ld b,c			;6260	41 	A 
	sbc a,d			;6261	9a 	. 
	sbc a,d			;6262	9a 	. 
	sbc a,d			;6263	9a 	. 
	sbc a,d			;6264	9a 	. 
	ld b,d			;6265	42 	B 
	ld b,e			;6266	43 	C 
	ld b,h			;6267	44 	D 
	rst 38h			;6268	ff 	. 
	cp 04ch		;6269	fe 4c 	. L 
	sbc a,e			;626b	9b 	. 
	sub l			;626c	95 	. 
	sub (hl)			;626d	96 	. 
	sub a			;626e	97 	. 
	ld a,03eh		;626f	3e 3e 	> > 
	ld a,03eh		;6271	3e 3e 	> > 
	ld a,03fh		;6273	3e 3f 	> ? 
	ld a,03eh		;6275	3e 3e 	> > 
	ld a,03eh		;6277	3e 3e 	> > 
	ld b,l			;6279	45 	E 
	ld c,b			;627a	48 	H 
	add a,a			;627b	87 	. 
	rst 38h			;627c	ff 	. 
	cp 04ch		;627d	fe 4c 	. L 
	sub e			;627f	93 	. 
	sub h			;6280	94 	. 
	dec a			;6281	3d 	= 
	dec a			;6282	3d 	= 
	dec a			;6283	3d 	= 
	dec a			;6284	3d 	= 
	dec a			;6285	3d 	= 
	dec a			;6286	3d 	= 
	dec a			;6287	3d 	= 
	ld b,b			;6288	40 	@ 
	dec a			;6289	3d 	= 
	dec a			;628a	3d 	= 
	dec a			;628b	3d 	= 
	dec a			;628c	3d 	= 
	ld b,(hl)			;628d	46 	F 
	ld b,a			;628e	47 	G 
	add a,a			;628f	87 	. 
	rst 38h			;6290	ff 	. 
	cp 04ch		;6291	fe 4c 	. L 
	inc a			;6293	3c 	< 
	cp 0fdh		;6294	fe fd 	. . 
	ld l,05bh		;6296	2e 5b 	. [ 
	add a,h			;6298	84 	. 
	add a,h			;6299	84 	. 
	rst 38h			;629a	ff 	. 
	jr nc,$+101		;629b	30 63 	0 c 
	scf			;629d	37 	7 
	ld h,e			;629e	63 	c 
	jr nc,l6304h		;629f	30 63 	0 c 
	xor a			;62a1	af 	. 
	ld h,d			;62a2	62 	b 
	cp b			;62a3	b8 	. 
	ld h,d			;62a4	62 	b 
	call nz,0d062h		;62a5	c4 62 d0 	. b . 
	ld h,d			;62a8	62 	b 
	push hl			;62a9	e5 	. 
	ld h,d			;62aa	62 	b 
	or 062h		;62ab	f6 62 	. b 
	add hl,bc			;62ad	09 	. 
	ld h,e			;62ae	63 	c 
	cp 0fdh		;62af	fe fd 	. . 
	dec hl			;62b1	2b 	+ 
	ld e,e			;62b2	5b 	[ 
	ld a,h			;62b3	7c 	| 
	cp 091h		;62b4	fe 91 	. . 
	inc e			;62b6	1c 	. 
	rst 38h			;62b7	ff 	. 
	cp 008h		;62b8	fe 08 	. . 
	xor 0feh		;62ba	ee fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;62bc	fd 2e 5b 	. . [ 
	cp 091h		;62bf	fe 91 	. . 
	jr $+32		;62c1	18 1e 	. . 
	rst 38h			;62c3	ff 	. 
	cp 008h		;62c4	fe 08 	. . 
	rst 28h			;62c6	ef 	. 
	cp 0fdh		;62c7	fe fd 	. . 
	ld l,05bh		;62c9	2e 5b 	. [ 
	cp 091h		;62cb	fe 91 	. . 
	inc d			;62cd	14 	. 
	ld d,0ffh		;62ce	16 ff 	. . 
	cp 0fdh		;62d0	fe fd 	. . 
	ld c,a			;62d2	4f 	O 
	ld e,e			;62d3	5b 	[ 
	cp 041h		;62d4	fe 41 	. A 
	ld (0fe80h),hl		;62d6	22 80 fe 	" . . 
	sub c			;62d9	91 	. 
	ld a,(de)			;62da	1a 	. 
	cp 041h		;62db	fe 41 	. A 
	add a,b			;62dd	80 	. 
	add a,b			;62de	80 	. 
	add a,(hl)			;62df	86 	. 
	cp 091h		;62e0	fe 91 	. . 
	inc d			;62e2	14 	. 
	ld d,0ffh		;62e3	16 ff 	. . 
	cp 0fdh		;62e5	fe fd 	. . 
	ld c,a			;62e7	4f 	O 
	ld e,e			;62e8	5b 	[ 
	cp 041h		;62e9	fe 41 	. A 
	ld (091feh),hl		;62eb	22 fe 91 	" . . 
	add hl,de			;62ee	19 	. 
	dec de			;62ef	1b 	. 
	dec e			;62f0	1d 	. 
	djnz $+20		;62f1	10 12 	. . 
	inc d			;62f3	14 	. 
	ld d,0ffh		;62f4	16 ff 	. . 
	cp 0fdh		;62f6	fe fd 	. . 
l62f8h:
	ld c,a			;62f8	4f 	O 
	ld e,e			;62f9	5b 	[ 
	cp 091h		;62fa	fe 91 	. . 
	ex af,af'			;62fc	08 	. 
	ld a,(bc)			;62fd	0a 	. 
	inc c			;62fe	0c 	. 
	cp 011h		;62ff	fe 11 	. . 
	inc bc			;6301	03 	. 
	cp 091h		;6302	fe 91 	. . 
l6304h:
	ld de,01513h		;6304	11 13 15 	. . . 
	rla			;6307	17 	. 
	rst 38h			;6308	ff 	. 
	cp 0fdh		;6309	fe fd 	. . 
	ld c,a			;630b	4f 	O 
	ld e,e			;630c	5b 	[ 
	cp 091h		;630d	fe 91 	. . 
	add hl,bc			;630f	09 	. 
	dec bc			;6310	0b 	. 
	dec c			;6311	0d 	. 
	rrca			;6312	0f 	. 
	cp 011h		;6313	fe 11 	. . 
	inc bc			;6315	03 	. 
	inc bc			;6316	03 	. 
	cp 091h		;6317	fe 91 	. . 
	rlca			;6319	07 	. 
	ld c,0ffh		;631a	0e ff 	. . 
	jr nc,l6381h		;631c	30 63 	0 c 
	scf			;631e	37 	7 
	ld h,e			;631f	63 	c 
	jr nc,l6385h		;6320	30 63 	0 c 
	ld a,063h		;6322	3e 63 	> c 
	ld b,a			;6324	47 	G 
	ld h,e			;6325	63 	c 
	ld d,e			;6326	53 	S 
	ld h,e			;6327	63 	c 
	ld e,a			;6328	5f 	_ 
	ld h,e			;6329	63 	c 
	ld e,a			;632a	5f 	_ 
	ld h,e			;632b	63 	c 
	ld e,a			;632c	5f 	_ 
	ld h,e			;632d	63 	c 
	ld l,b			;632e	68 	h 
	ld h,e			;632f	63 	c 
	cp 0fdh		;6330	fe fd 	. . 
	dec hl			;6332	2b 	+ 
	ld e,e			;6333	5b 	[ 
	add a,h			;6334	84 	. 
	ld a,h			;6335	7c 	| 
	rst 38h			;6336	ff 	. 
	cp 0fdh		;6337	fe fd 	. . 
	dec hl			;6339	2b 	+ 
	ld e,e			;633a	5b 	[ 
	ld a,h			;633b	7c 	| 
	add a,h			;633c	84 	. 
	rst 38h			;633d	ff 	. 
	cp 0fdh		;633e	fe fd 	. . 
	dec hl			;6340	2b 	+ 
	ld e,e			;6341	5b 	[ 
	ld a,h			;6342	7c 	| 
	cp 091h		;6343	fe 91 	. . 
	jr c,$+1		;6345	38 ff 	8 . 
	cp 008h		;6347	fe 08 	. . 
	xor 0feh		;6349	ee fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;634b	fd 2e 5b 	. . [ 
	cp 091h		;634e	fe 91 	. . 
	ld (hl),039h		;6350	36 39 	6 9 
	rst 38h			;6352	ff 	. 
	cp 008h		;6353	fe 08 	. . 
	rst 28h			;6355	ef 	. 
	cp 0fdh		;6356	fe fd 	. . 
	ld l,05bh		;6358	2e 5b 	. [ 
	cp 091h		;635a	fe 91 	. . 
	scf			;635c	37 	7 
	inc (hl)			;635d	34 	4 
	rst 38h			;635e	ff 	. 
	cp 0fdh		;635f	fe fd 	. . 
	dec hl			;6361	2b 	+ 
	ld e,e			;6362	5b 	[ 
	cp 091h		;6363	fe 91 	. . 
	ld (0ff34h),a		;6365	32 34 ff 	2 4 . 
	cp 0fdh		;6368	fe fd 	. . 
	dec hl			;636a	2b 	+ 
	ld e,e			;636b	5b 	[ 
	cp 091h		;636c	fe 91 	. . 
	inc sp			;636e	33 	3 
	dec (hl)			;636f	35 	5 
	rst 38h			;6370	ff 	. 
	jr nc,l63d6h		;6371	30 63 	0 c 
	scf			;6373	37 	7 
	ld h,e			;6374	63 	c 
	jr nc,l63dah		;6375	30 63 	0 c 
	scf			;6377	37 	7 
	ld h,e			;6378	63 	c 
	add a,l			;6379	85 	. 
	ld h,e			;637a	63 	c 
	sub b			;637b	90 	. 
	ld h,e			;637c	63 	c 
	jr nc,l63e2h		;637d	30 63 	0 c 
	scf			;637f	37 	7 
	ld h,e			;6380	63 	c 
l6381h:
	jr nc,l63e6h		;6381	30 63 	0 c 
	scf			;6383	37 	7 
	ld h,e			;6384	63 	c 
l6385h:
	cp 008h		;6385	fe 08 	. . 
	xor 0feh		;6387	ee fe 	. . 
	defb 0fdh,02eh,05bh	;illegal sequence		;6389	fd 2e 5b 	. . [ 
	cp 0fch		;638c	fe fc 	. . 
	inc (hl)			;638e	34 	4 
	ld h,e			;638f	63 	c 
	cp 008h		;6390	fe 08 	. . 
	rst 28h			;6392	ef 	. 
	cp 0fdh		;6393	fe fd 	. . 
	ld l,05bh		;6395	2e 5b 	. [ 
	cp 0fch		;6397	fe fc 	. . 
	dec sp			;6399	3b 	; 
	ld h,e			;639a	63 	c 
	and a			;639b	a7 	. 
	ld h,e			;639c	63 	c 
	or b			;639d	b0 	. 
	ld h,e			;639e	63 	c 
	cp c			;639f	b9 	. 
	ld h,e			;63a0	63 	c 
	jp nz,0cf63h		;63a1	c2 63 cf 	. c . 
	ld h,e			;63a4	63 	c 
	jp (hl)			;63a5	e9 	. 
	ld h,e			;63a6	63 	c 
l63a7h:
	cp 05ch		;63a7	fe 5c 	. \ 
	ld l,c			;63a9	69 	i 
	ld l,e			;63aa	6b 	k 
	ld l,l			;63ab	6d 	m 
	cp 05eh		;63ac	fe 5e 	. ^ 
	adc a,e			;63ae	8b 	. 
	rst 38h			;63af	ff 	. 
	cp 05ch		;63b0	fe 5c 	. \ 
	ld (hl),b			;63b2	70 	p 
	ld (hl),d			;63b3	72 	r 
	cp 05eh		;63b4	fe 5e 	. ^ 
	ld a,b			;63b6	78 	x 
	add a,h			;63b7	84 	. 
	rst 38h			;63b8	ff 	. 
	cp 05ch		;63b9	fe 5c 	. \ 
	ld (hl),c			;63bb	71 	q 
	ld (hl),e			;63bc	73 	s 
	cp 05eh		;63bd	fe 5e 	. ^ 
	ld a,c			;63bf	79 	y 
	add a,h			;63c0	84 	. 
	rst 38h			;63c1	ff 	. 
	cp 05ch		;63c2	fe 5c 	. \ 
	ld (hl),h			;63c4	74 	t 
	halt			;63c5	76 	v 
	cp 05dh		;63c6	fe 5d 	. ] 
	ld c,a			;63c8	4f 	O 
	add a,a			;63c9	87 	. 
	add a,a			;63ca	87 	. 
	cp 0fch		;63cb	fe fc 	. . 
	ret c			;63cd	d8 	. 
	ld h,e			;63ce	63 	c 
	cp 05ch		;63cf	fe 5c 	. \ 
	ld (hl),l			;63d1	75 	u 
	ld (hl),a			;63d2	77 	w 
	cp 05dh		;63d3	fe 5d 	. ] 
	ld d,b			;63d5	50 	P 
l63d6h:
	cp 05fh		;63d6	fe 5f 	. _ 
	add a,a			;63d8	87 	. 
	add a,a			;63d9	87 	. 
l63dah:
	add a,a			;63da	87 	. 
	add a,a			;63db	87 	. 
	add a,a			;63dc	87 	. 
	add a,a			;63dd	87 	. 
	add a,a			;63de	87 	. 
	add a,a			;63df	87 	. 
	add a,a			;63e0	87 	. 
	add a,a			;63e1	87 	. 
l63e2h:
	add a,a			;63e2	87 	. 
	add a,a			;63e3	87 	. 
	add a,a			;63e4	87 	. 
	add a,a			;63e5	87 	. 
l63e6h:
	add a,a			;63e6	87 	. 
	add a,a			;63e7	87 	. 
	rst 38h			;63e8	ff 	. 
	cp 05ch		;63e9	fe 5c 	. \ 
	ld l,a			;63eb	6f 	o 
	ld a,d			;63ec	7a 	z 
	cp 05dh		;63ed	fe 5d 	. ] 
	ld d,c			;63ef	51 	Q 
	cp 05fh		;63f0	fe 5f 	. _ 
	add a,a			;63f2	87 	. 
	add a,a			;63f3	87 	. 
	add a,a			;63f4	87 	. 
	add a,a			;63f5	87 	. 
	add a,a			;63f6	87 	. 
	scf			;63f7	37 	7 
	jr c,$+59		;63f8	38 39 	8 9 
	add hl,sp			;63fa	39 	9 
	ld a,(0873bh)		;63fb	3a 3b 87 	: ; . 
	add a,a			;63fe	87 	. 
	add a,a			;63ff	87 	. 
	add a,a			;6400	87 	. 
	rst 38h			;6401	ff 	. 
l6402h:
	ld b,d			;6402	42 	B 
	ld h,h			;6403	64 	d 
	ld c,(hl)			;6404	4e 	N 
	ld h,h			;6405	64 	d 
	ld e,l			;6406	5d 	] 
	ld h,h			;6407	64 	d 
	cp h			;6408	bc 	. 
	ld h,h			;6409	64 	d 
	ret nz			;640a	c0 	. 
	ld h,h			;640b	64 	d 
	ld h,h			;640c	64 	d 
	ld h,h			;640d	64 	d 
	ld l,b			;640e	68 	h 
	ld h,h			;640f	64 	d 
	ret c			;6410	d8 	. 
	ld h,h			;6411	64 	d 
	ret pe			;6412	e8 	. 
	ld h,h			;6413	64 	d 
	ld (hl),h			;6414	74 	t 
	ld h,h			;6415	64 	d 
	ld l,h			;6416	6c 	l 
	ld h,h			;6417	64 	d 
	ld (hl),b			;6418	70 	p 
	ld h,h			;6419	64 	d 
	ret c			;641a	d8 	. 
	ld h,h			;641b	64 	d 
	ret pe			;641c	e8 	. 
	ld h,h			;641d	64 	d 
	ret c			;641e	d8 	. 
	ld h,h			;641f	64 	d 
	ret pe			;6420	e8 	. 
	ld h,h			;6421	64 	d 
	ret c			;6422	d8 	. 
	ld h,h			;6423	64 	d 
	call c,0e064h		;6424	dc 64 e0 	. d . 
	ld h,h			;6427	64 	d 
	call po,0e864h		;6428	e4 64 e8 	. d . 
	ld h,h			;642b	64 	d 
	ret c			;642c	d8 	. 
	ld h,h			;642d	64 	d 
	call c,0e064h		;642e	dc 64 e0 	. d . 
	ld h,h			;6431	64 	d 
	call po,0e864h		;6432	e4 64 e8 	. d . 
	ld h,h			;6435	64 	d 
	ret c			;6436	d8 	. 
	ld h,h			;6437	64 	d 
	ret pe			;6438	e8 	. 
	ld h,h			;6439	64 	d 
	ret z			;643a	c8 	. 
	ld h,h			;643b	64 	d 
	call z,0d064h		;643c	cc 64 d0 	. d . 
	ld h,h			;643f	64 	d 
	call nc,0fe64h		;6440	d4 64 fe 	. d . 
	ld c,l			;6443	4d 	M 
	jp m,0fefch		;6444	fa fc fe 	. . . 
	ld (hl),b			;6447	70 	p 
	xor a			;6448	af 	. 
	or c			;6449	b1 	. 
	or e			;644a	b3 	. 
	or l			;644b	b5 	. 
	or a			;644c	b7 	. 
	rst 38h			;644d	ff 	. 
	cp 04dh		;644e	fe 4d 	. M 
	defb 0fdh,0feh,08dh	;illegal sequence		;6450	fd fe 8d 	. . . 
	add a,l			;6453	85 	. 
	cp 08eh		;6454	fe 8e 	. . 
	add a,h			;6456	84 	. 
	cp 050h		;6457	fe 50 	. P 
	or d			;6459	b2 	. 
	or h			;645a	b4 	. 
	or (hl)			;645b	b6 	. 
	rst 38h			;645c	ff 	. 
	cp 08eh		;645d	fe 8e 	. . 
	nop			;645f	00 	. 
	ld bc,00302h		;6460	01 02 03 	. . . 
	rst 38h			;6463	ff 	. 
	call p,0d8f6h		;6464	f4 f6 d8 	. . . 
	rst 38h			;6467	ff 	. 
	push af			;6468	f5 	. 
	rst 30h			;6469	f7 	. 
	add a,b			;646a	80 	. 
	rst 38h			;646b	ff 	. 
	ret p			;646c	f0 	. 
	jp p,0ffd8h		;646d	f2 d8 ff 	. . . 
	pop af			;6470	f1 	. 
	di			;6471	f3 	. 
	add a,b			;6472	80 	. 
	rst 38h			;6473	ff 	. 
	ret m			;6474	f8 	. 
	push de			;6475	d5 	. 
	rst 10h			;6476	d7 	. 
	rst 38h			;6477	ff 	. 
	ret c			;6478	d8 	. 
	ld h,h			;6479	64 	d 
	ret pe			;647a	e8 	. 
	ld h,h			;647b	64 	d 
	cp b			;647c	b8 	. 
	ld h,h			;647d	64 	d 
	cp h			;647e	bc 	. 
	ld h,h			;647f	64 	d 
	ret nz			;6480	c0 	. 
	ld h,h			;6481	64 	d 
	call nz,0d864h		;6482	c4 64 d8 	. d . 
	ld h,h			;6485	64 	d 
	ret pe			;6486	e8 	. 
	ld h,h			;6487	64 	d 
	ret z			;6488	c8 	. 
	ld h,h			;6489	64 	d 
	call z,0d064h		;648a	cc 64 d0 	. d . 
	ld h,h			;648d	64 	d 
	call nc,0d864h		;648e	d4 64 d8 	. d . 
	ld h,h			;6491	64 	d 
	ret pe			;6492	e8 	. 
	ld h,h			;6493	64 	d 
	ret c			;6494	d8 	. 
	ld h,h			;6495	64 	d 
	ret pe			;6496	e8 	. 
	ld h,h			;6497	64 	d 
	ret c			;6498	d8 	. 
	ld h,h			;6499	64 	d 
	ret pe			;649a	e8 	. 
	ld h,h			;649b	64 	d 
	ret c			;649c	d8 	. 
	ld h,h			;649d	64 	d 
	call c,0e064h		;649e	dc 64 e0 	. d . 
	ld h,h			;64a1	64 	d 
	call po,0e864h		;64a2	e4 64 e8 	. d . 
	ld h,h			;64a5	64 	d 
	ret c			;64a6	d8 	. 
	ld h,h			;64a7	64 	d 
	call c,0e064h		;64a8	dc 64 e0 	. d . 
	ld h,h			;64ab	64 	d 
	call po,0e864h		;64ac	e4 64 e8 	. d . 
	ld h,h			;64af	64 	d 
	call pe,0f264h		;64b0	ec 64 f2 	. d . 
	ld h,h			;64b3	64 	d 
	ld sp,hl			;64b4	f9 	. 
	ld h,h			;64b5	64 	d 
	ld (bc),a			;64b6	02 	. 
	ld h,l			;64b7	65 	e 
	add a,0c2h		;64b8	c6 c2 	. . 
	add a,b			;64ba	80 	. 
	rst 38h			;64bb	ff 	. 
	rst 0			;64bc	c7 	. 
	jp nz,0ff80h		;64bd	c2 80 ff 	. . . 
	adc a,0d5h		;64c0	ce d5 	. . 
	rst 10h			;64c2	d7 	. 
	rst 38h			;64c3	ff 	. 
	rst 8			;64c4	cf 	. 
	sub 0d8h		;64c5	d6 d8 	. . 
	rst 38h			;64c7	ff 	. 
	ret z			;64c8	c8 	. 
	jp z,0ff80h		;64c9	ca 80 ff 	. . . 
	ret			;64cc	c9 	. 
	set 1,l		;64cd	cb cd 	. . 
	rst 38h			;64cf	ff 	. 
	ret nc			;64d0	d0 	. 
	jp nc,0ffd4h		;64d1	d2 d4 ff 	. . . 
	pop de			;64d4	d1 	. 
	out (080h),a		;64d5	d3 80 	. . 
	rst 38h			;64d7	ff 	. 
	xor d			;64d8	aa 	. 
	jp nz,0ff80h		;64d9	c2 80 ff 	. . . 
	cp b			;64dc	b8 	. 
	jp nz,0ffc4h		;64dd	c2 c4 ff 	. . . 
	pop bc			;64e0	c1 	. 
	jp 0ffc5h		;64e1	c3 c5 ff 	. . . 
	xor d			;64e4	aa 	. 
	ret nz			;64e5	c0 	. 
	call z,0b8ffh		;64e6	cc ff b8 	. . . 
	jp nz,0ff80h		;64e9	c2 80 ff 	. . . 
	cp d			;64ec	ba 	. 
	cp h			;64ed	bc 	. 
	cp 050h		;64ee	fe 50 	. P 
	cp (hl)			;64f0	be 	. 
	rst 38h			;64f1	ff 	. 
	cp 050h		;64f2	fe 50 	. P 
	cp c			;64f4	b9 	. 
	cp e			;64f5	bb 	. 
	cp l			;64f6	bd 	. 
	cp a			;64f7	bf 	. 
	rst 38h			;64f8	ff 	. 
	cp 050h		;64f9	fe 50 	. P 
	xor h			;64fb	ac 	. 
	xor (hl)			;64fc	ae 	. 
	or b			;64fd	b0 	. 
	or d			;64fe	b2 	. 
	or h			;64ff	b4 	. 
	or (hl)			;6500	b6 	. 
	rst 38h			;6501	ff 	. 
	cp 050h		;6502	fe 50 	. P 
	xor e			;6504	ab 	. 
	xor l			;6505	ad 	. 
	xor a			;6506	af 	. 
	or c			;6507	b1 	. 
	or e			;6508	b3 	. 
	or l			;6509	b5 	. 
	or a			;650a	b7 	. 
	rst 38h			;650b	ff 	. 
l650ch:
	ld c,h			;650c	4c 	L 
	ld h,l			;650d	65 	e 
	ret c			;650e	d8 	. 
	ld h,h			;650f	64 	d 
	ret pe			;6510	e8 	. 
	ld h,h			;6511	64 	d 
	ld d,b			;6512	50 	P 
	ld h,l			;6513	65 	e 
	ret po			;6514	e0 	. 
	ld h,h			;6515	64 	d 
	call po,0e864h		;6516	e4 64 e8 	. d . 
	ld h,h			;6519	64 	d 
	ret c			;651a	d8 	. 
	ld h,h			;651b	64 	d 
	call c,0e064h		;651c	dc 64 e0 	. d . 
	ld h,h			;651f	64 	d 
	call po,0e864h		;6520	e4 64 e8 	. d . 
	ld h,h			;6523	64 	d 
	ret c			;6524	d8 	. 
	ld h,h			;6525	64 	d 
	ret pe			;6526	e8 	. 
	ld h,h			;6527	64 	d 
	ret c			;6528	d8 	. 
	ld h,h			;6529	64 	d 
	ret pe			;652a	e8 	. 
	ld h,h			;652b	64 	d 
	ret c			;652c	d8 	. 
	ld h,h			;652d	64 	d 
	call c,0e064h		;652e	dc 64 e0 	. d . 
	ld h,h			;6531	64 	d 
	call po,0e864h		;6532	e4 64 e8 	. d . 
	ld h,h			;6535	64 	d 
	ret c			;6536	d8 	. 
	ld h,h			;6537	64 	d 
	call c,0e064h		;6538	dc 64 e0 	. d . 
	ld h,h			;653b	64 	d 
	call po,0e864h		;653c	e4 64 e8 	. d . 
	ld h,h			;653f	64 	d 
	ret c			;6540	d8 	. 
	ld h,h			;6541	64 	d 
	ret pe			;6542	e8 	. 
	ld h,h			;6543	64 	d 
	ret z			;6544	c8 	. 
	ld h,h			;6545	64 	d 
	call z,0d064h		;6546	cc 64 d0 	. d . 
	ld h,h			;6549	64 	d 
	call nc,0e364h		;654a	d4 64 e3 	. d . 
	push hl			;654d	e5 	. 
	add a,b			;654e	80 	. 
	rst 38h			;654f	ff 	. 
	call po,0c4e6h		;6550	e4 e6 c4 	. . . 
	rst 38h			;6553	ff 	. 
l6554h:
	ld b,(hl)			;6554	46 	F 
	ld e,(hl)			;6555	5e 	^ 
	ld e,b			;6556	58 	X 
	ld h,l			;6557	65 	e 
	cp 001h		;6558	fe 01 	. . 
	defb 0edh;next byte illegal after ed		;655a	ed 	. 
	cp 041h		;655b	fe 41 	. A 
	ld a,h			;655d	7c 	| 
	rst 38h			;655e	ff 	. 
	ld h,a			;655f	67 	g 
	ld h,l			;6560	65 	e 
	ld l,l			;6561	6d 	m 
	ld h,l			;6562	65 	e 
	halt			;6563	76 	v 
	ld h,l			;6564	65 	e 
	add a,c			;6565	81 	. 
	ld h,l			;6566	65 	e 
	cp 042h		;6567	fe 42 	. B 
	inc h			;6569	24 	$ 
	ld h,030h		;656a	26 30 	& 0 
	rst 38h			;656c	ff 	. 
	cp 05dh		;656d	fe 5d 	. ] 
	add a,a			;656f	87 	. 
	cp 042h		;6570	fe 42 	. B 
	ld hl,(02e2ch)		;6572	2a 2c 2e 	* , . 
	rst 38h			;6575	ff 	. 
	cp 05fh		;6576	fe 5f 	. _ 
	add a,a			;6578	87 	. 
l6579h:
	add a,a			;6579	87 	. 
	dec (hl)			;657a	35 	5 
	cp 042h		;657b	fe 42 	. B 
	dec hl			;657d	2b 	+ 
	dec l			;657e	2d 	- 
	cpl			;657f	2f 	/ 
	rst 38h			;6580	ff 	. 
	cp 05fh		;6581	fe 5f 	. _ 
	add a,a			;6583	87 	. 
	add a,a			;6584	87 	. 
	ld (hl),0feh		;6585	36 fe 	6 . 
	ld b,d			;6587	42 	B 
	ld sp,03332h		;6588	31 32 33 	1 2 3 
	inc (hl)			;658b	34 	4 
	rst 38h			;658c	ff 	. 
l658dh:
	dec b			;658d	05 	. 
	ld bc,00b07h		;658e	01 07 0b 	. . . 
	cp 006h		;6591	fe 06 	. . 
	dec b			;6593	05 	. 
	ld (bc),a			;6594	02 	. 
	add hl,bc			;6595	09 	. 
	dec bc			;6596	0b 	. 
	defb 0fdh,008h,005h	;illegal sequence		;6597	fd 08 05 	. . . 
	ld bc,00b0ch		;659a	01 0c 0b 	. . . 
	cp 00bh		;659d	fe 0b 	. . 
	dec b			;659f	05 	. 
	ld (bc),a			;65a0	02 	. 
	ld c,00bh		;65a1	0e 0b 	. . 
	defb 0fdh,00dh,0b7h	;illegal sequence		;65a3	fd 0d b7 	. . . 
	ld h,l			;65a6	65 	e 
	or a			;65a7	b7 	. 
	ld h,l			;65a8	65 	e 
l65a9h:
	push de			;65a9	d5 	. 
	ld h,l			;65aa	65 	e 
	ret po			;65ab	e0 	. 
	ld h,l			;65ac	65 	e 
l65adh:
	ex de,hl			;65ad	eb 	. 
	ld h,l			;65ae	65 	e 
	pop af			;65af	f1 	. 
	ld h,l			;65b0	65 	e 
	nop			;65b1	00 	. 
	nop			;65b2	00 	. 
	rst 30h			;65b3	f7 	. 
	ld h,l			;65b4	65 	e 
	ei			;65b5	fb 	. 
	ld h,l			;65b6	65 	e 
l65b7h:
	ld (bc),a			;65b7	02 	. 
	nop			;65b8	00 	. 
	nop			;65b9	00 	. 
	ld (bc),a			;65ba	02 	. 
	nop			;65bb	00 	. 
	inc bc			;65bc	03 	. 
	dec b			;65bd	05 	. 
	add hl,de			;65be	19 	. 
	ld bc,0b305h		;65bf	01 05 b3 	. . . 
	nop			;65c2	00 	. 
	dec b			;65c3	05 	. 
	nop			;65c4	00 	. 
	nop			;65c5	00 	. 
	dec b			;65c6	05 	. 
	ld c,l			;65c7	4d 	M 
	rst 38h			;65c8	ff 	. 
	dec b			;65c9	05 	. 
	rst 20h			;65ca	e7 	. 
	cp 002h		;65cb	fe 02 	. . 
	nop			;65cd	00 	. 
	defb 0fdh,002h,000h	;illegal sequence		;65ce	fd 02 00 	. . . 
	nop			;65d1	00 	. 
	rst 38h			;65d2	ff 	. 
	nop			;65d3	00 	. 
	nop			;65d4	00 	. 
	inc b			;65d5	04 	. 
	djnz l65deh		;65d6	10 06 	. . 
	ld (de),a			;65d8	12 	. 
	djnz $-107		;65d9	10 93 	. . 
	ld b,014h		;65db	06 14 	. . 
	inc b			;65dd	04 	. 
l65deh:
	djnz l65e0h		;65de	10 00 	. . 
l65e0h:
	inc b			;65e0	04 	. 
	ld de,01206h		;65e1	11 06 12 	. . . 
	djnz l6579h		;65e4	10 93 	. . 
	ld b,014h		;65e6	06 14 	. . 
	inc b			;65e8	04 	. 
	djnz l65ebh		;65e9	10 00 	. . 
l65ebh:
	dec b			;65eb	05 	. 
	ld d,l			;65ec	55 	U 
	ld bc,00088h		;65ed	01 88 00 	. . . 
	nop			;65f0	00 	. 
	dec b			;65f1	05 	. 
	ld d,(hl)			;65f2	56 	V 
	ld bc,00088h		;65f3	01 88 00 	. . . 
	nop			;65f6	00 	. 
	dec b			;65f7	05 	. 
	cp b			;65f8	b8 	. 
	nop			;65f9	00 	. 
	nop			;65fa	00 	. 
	dec b			;65fb	05 	. 
	cp c			;65fc	b9 	. 
	nop			;65fd	00 	. 
	nop			;65fe	00 	. 
l65ffh:
	sbc a,e			;65ff	9b 	. 
	ld h,(hl)			;6600	66 	f 
	cp a			;6601	bf 	. 
	ld h,(hl)			;6602	66 	f 
	exx			;6603	d9 	. 
	ld h,(hl)			;6604	66 	f 
	ld h,(iy+01dh)		;6605	fd 66 1d 	. f . 
	ld h,a			;6608	67 	g 
	ld b,l			;6609	45 	E 
	ld h,a			;660a	67 	g 
	sub e			;660b	93 	. 
	ld l,b			;660c	68 	h 
	cp l			;660d	bd 	. 
	ld l,b			;660e	68 	h 
	ld b,a			;660f	47 	G 
	ld l,b			;6610	68 	h 
	ld l,e			;6611	6b 	k 
	ld l,b			;6612	68 	h 
	rra			;6613	1f 	. 
	ld l,b			;6614	68 	h 
	ld (hl),a			;6615	77 	w 
	ld l,c			;6616	69 	i 
	and c			;6617	a1 	. 
	ld l,c			;6618	69 	i 
	dec hl			;6619	2b 	+ 
	ld l,c			;661a	69 	i 
	ld c,a			;661b	4f 	O 
	ld l,c			;661c	69 	i 
	inc bc			;661d	03 	. 
	ld l,c			;661e	69 	i 
	sbc a,a			;661f	9f 	. 
	ld h,a			;6620	67 	g 
	ret			;6621	c9 	. 
	ld l,c			;6622	69 	i 
	cp c			;6623	b9 	. 
	ld h,a			;6624	67 	g 
	exx			;6625	d9 	. 
	ld h,a			;6626	67 	g 
	rst 38h			;6627	ff 	. 
	ld h,a			;6628	67 	g 
	ld l,e			;6629	6b 	k 
	ld l,b			;662a	68 	h 
	ld l,e			;662b	6b 	k 
	ld l,b			;662c	68 	h 
	ld l,e			;662d	6b 	k 
	ld l,b			;662e	68 	h 
	push hl			;662f	e5 	. 
	ld l,b			;6630	68 	h 
	push hl			;6631	e5 	. 
	ld l,b			;6632	68 	h 
	nop			;6633	00 	. 
	nop			;6634	00 	. 
	nop			;6635	00 	. 
	nop			;6636	00 	. 
	ld h,e			;6637	63 	c 
	ld h,a			;6638	67 	g 
	ld (hl),h			;6639	74 	t 
	ld h,a			;663a	67 	g 
	add a,c			;663b	81 	. 
	ld h,a			;663c	67 	g 
	sub d			;663d	92 	. 
	ld h,a			;663e	67 	g 
	di			;663f	f3 	. 
	ld l,c			;6640	69 	i 
	rlca			;6641	07 	. 
	ld l,d			;6642	6a 	j 
	daa			;6643	27 	' 
	ld l,d			;6644	6a 	j 
	inc a			;6645	3c 	< 
	ld l,d			;6646	6a 	j 
	ld d,c			;6647	51 	Q 
	ld l,d			;6648	6a 	j 
	ld h,(hl)			;6649	66 	f 
	ld l,d			;664a	6a 	j 
	ld h,(hl)			;664b	66 	f 
	ld (hl),h			;664c	74 	t 
	xor h			;664d	ac 	. 
	ld h,(hl)			;664e	66 	f 
	call z,0ea66h		;664f	cc 66 ea 	. f . 
	ld h,(hl)			;6652	66 	f 
	ld a,(bc)			;6653	0a 	. 
	ld h,a			;6654	67 	g 
	ld (05667h),a		;6655	32 67 56 	2 g V 
	ld h,a			;6658	67 	g 
	and h			;6659	a4 	. 
	ld l,b			;665a	68 	h 
l665bh:
	jp nc,05868h		;665b	d2 68 58 	. h X 
	ld l,b			;665e	68 	h 
	add a,b			;665f	80 	. 
	ld l,b			;6660	68 	h 
	inc (hl)			;6661	34 	4 
	ld l,b			;6662	68 	h 
	adc a,b			;6663	88 	. 
	ld l,c			;6664	69 	i 
	or (hl)			;6665	b6 	. 
	ld l,c			;6666	69 	i 
	inc a			;6667	3c 	< 
	ld l,c			;6668	69 	i 
	ld h,h			;6669	64 	d 
	ld l,c			;666a	69 	i 
	jr l66d6h		;666b	18 69 	. i 
	xor h			;666d	ac 	. 
	ld h,a			;666e	67 	g 
	jp c,0c669h		;666f	da 69 c6 	. i . 
	ld h,a			;6672	67 	g 
	and 067h		;6673	e6 67 	. g 
	inc c			;6675	0c 	. 
	ld l,b			;6676	68 	h 
	add a,b			;6677	80 	. 
	ld l,b			;6678	68 	h 
	add a,b			;6679	80 	. 
	ld l,b			;667a	68 	h 
	add a,b			;667b	80 	. 
	ld l,b			;667c	68 	h 
	or 068h		;667d	f6 68 	. h 
	or 068h		;667f	f6 68 	. h 
	nop			;6681	00 	. 
	nop			;6682	00 	. 
	nop			;6683	00 	. 
	nop			;6684	00 	. 
	cp (hl)			;6685	be 	. 
	ld h,(hl)			;6686	66 	f 
	cp (hl)			;6687	be 	. 
	ld h,(hl)			;6688	66 	f 
	cp (hl)			;6689	be 	. 
	ld h,(hl)			;668a	66 	f 
	cp (hl)			;668b	be 	. 
	ld h,(hl)			;668c	66 	f 
	nop			;668d	00 	. 
	ld l,d			;668e	6a 	j 
	inc d			;668f	14 	. 
	ld l,d			;6690	6a 	j 
	cp (hl)			;6691	be 	. 
	ld h,(hl)			;6692	66 	f 
	cp (hl)			;6693	be 	. 
	ld h,(hl)			;6694	66 	f 
	cp (hl)			;6695	be 	. 
	ld h,(hl)			;6696	66 	f 
	cp (hl)			;6697	be 	. 
	ld h,(hl)			;6698	66 	f 
l6699h:
	cp (hl)			;6699	be 	. 
	ld h,(hl)			;669a	66 	f 
l669bh:
	daa			;669b	27 	' 
	djnz l66a0h		;669c	10 02 	. . 
	add a,b			;669e	80 	. 
	dec l			;669f	2d 	- 
l66a0h:
	djnz l66a4h		;66a0	10 02 	. . 
	add a,d			;66a2	82 	. 
	inc hl			;66a3	23 	# 
l66a4h:
	inc l			;66a4	2c 	, 
	nop			;66a5	00 	. 
	add a,h			;66a6	84 	. 
	jr z,l66d9h		;66a7	28 30 	( 0 
	ld bc,0ff02h		;66a9	01 02 ff 	. . . 
	dec a			;66ac	3d 	= 
	ld c,d			;66ad	4a 	J 
	and b			;66ae	a0 	. 
	rst 38h			;66af	ff 	. 
	jr nz,$+1		;66b0	20 ff 	  . 
	rrca			;66b2	0f 	. 
	ccf			;66b3	3f 	? 
	ld b,b			;66b4	40 	@ 
	nop			;66b5	00 	. 
	ld b,b			;66b6	40 	@ 
	rst 38h			;66b7	ff 	. 
	rrca			;66b8	0f 	. 
	jr c,l665bh		;66b9	38 a0 	8 . 
	nop			;66bb	00 	. 
	nop			;66bc	00 	. 
	nop			;66bd	00 	. 
	rst 38h			;66be	ff 	. 
	add hl,hl			;66bf	29 	) 
	djnz $+4		;66c0	10 02 	. . 
	add a,(hl)			;66c2	86 	. 
	jr z,l66f5h		;66c3	28 30 	( 0 
	ld bc,02803h		;66c5	01 03 28 	. . ( 
	ld b,b			;66c8	40 	@ 
	nop			;66c9	00 	. 
	inc b			;66ca	04 	. 
	rst 38h			;66cb	ff 	. 
	ld b,d			;66cc	42 	B 
	ld c,e			;66cd	4b 	K 
	ret nz			;66ce	c0 	. 
	rst 38h			;66cf	ff 	. 
	ld b,b			;66d0	40 	@ 
	rst 38h			;66d1	ff 	. 
	rrca			;66d2	0f 	. 
	ld b,d			;66d3	42 	B 
	ld h,b			;66d4	60 	` 
	nop			;66d5	00 	. 
l66d6h:
	ld h,b			;66d6	60 	` 
	rst 38h			;66d7	ff 	. 
	rst 38h			;66d8	ff 	. 
l66d9h:
	ld h,010h		;66d9	26 10 	& . 
	ld (bc),a			;66db	02 	. 
	adc a,(hl)			;66dc	8e 	. 
	dec l			;66dd	2d 	- 
	djnz $+4		;66de	10 02 	. . 
	sub b			;66e0	90 	. 
	ld (0002ch),hl		;66e1	22 2c 00 	" , . 
	sub d			;66e4	92 	. 
	jr z,l6716h		;66e5	28 2f 	( / 
	ld bc,0ff0bh		;66e7	01 0b ff 	. . . 
	jr nc,l6735h		;66ea	30 49 	0 I 
	ret nz			;66ec	c0 	. 
	rst 38h			;66ed	ff 	. 
	ld b,b			;66ee	40 	@ 
	rst 38h			;66ef	ff 	. 
	rrca			;66f0	0f 	. 
	ld a,0a0h		;66f1	3e a0 	> . 
	nop			;66f3	00 	. 
	ret nz			;66f4	c0 	. 
l66f5h:
	rst 38h			;66f5	ff 	. 
	rrca			;66f6	0f 	. 
	jr z,l66f9h		;66f7	28 00 	( . 
l66f9h:
	nop			;66f9	00 	. 
	nop			;66fa	00 	. 
	rst 38h			;66fb	ff 	. 
	rst 38h			;66fc	ff 	. 
	daa			;66fd	27 	' 
	ccf			;66fe	3f 	? 
	nop			;66ff	00 	. 
	inc b			;6700	04 	. 
	jr z,l6713h		;6701	28 10 	( . 
	ld (bc),a			;6703	02 	. 
	sub h			;6704	94 	. 
	jr z,l6737h		;6705	28 30 	( 0 
	ld bc,0ff0dh		;6707	01 0d ff 	. . . 
	ld b,b			;670a	40 	@ 
	ld c,e			;670b	4b 	K 
	ret nz			;670c	c0 	. 
	rst 38h			;670d	ff 	. 
	jr nz,$+1		;670e	20 ff 	  . 
	rrca			;6710	0f 	. 
	ld b,c			;6711	41 	A 
	ld b,b			;6712	40 	@ 
l6713h:
	nop			;6713	00 	. 
	ld h,b			;6714	60 	` 
	rst 38h			;6715	ff 	. 
l6716h:
	rrca			;6716	0f 	. 
	inc e			;6717	1c 	. 
	and b			;6718	a0 	. 
	nop			;6719	00 	. 
	nop			;671a	00 	. 
	nop			;671b	00 	. 
	rst 38h			;671c	ff 	. 
	ld hl,(0003bh)		;671d	2a 3b 00 	* ; . 
	ld hl,(01022h)		;6720	2a 22 10 	* " . 
	ld (bc),a			;6723	02 	. 
	adc a,b			;6724	88 	. 
	ld hl,(00210h)		;6725	2a 10 02 	* . . 
	adc a,d			;6728	8a 	. 
	ld (00130h),hl		;6729	22 30 01 	" 0 . 
	dec b			;672c	05 	. 
	add hl,hl			;672d	29 	) 
	dec l			;672e	2d 	- 
	ld bc,0ff06h		;672f	01 06 ff 	. . . 
	rrca			;6732	0f 	. 
	ld b,l			;6733	45 	E 
	ld b,b			;6734	40 	@ 
l6735h:
	nop			;6735	00 	. 
	ret po			;6736	e0 	. 
l6737h:
	rst 38h			;6737	ff 	. 
	rrca			;6738	0f 	. 
	ld a,(000e0h)		;6739	3a e0 00 	: . . 
	and b			;673c	a0 	. 
	rst 38h			;673d	ff 	. 
	rrca			;673e	0f 	. 
	ld h,000h		;673f	26 00 	& . 
	nop			;6741	00 	. 
	ld b,b			;6742	40 	@ 
	rst 38h			;6743	ff 	. 
	rst 38h			;6744	ff 	. 
	dec h			;6745	25 	% 
	djnz $+4		;6746	10 02 	. . 
	adc a,h			;6748	8c 	. 
	ld l,010h		;6749	2e 10 	. . 
	ld (bc),a			;674b	02 	. 
	ex af,af'			;674c	08 	. 
	jr z,l676fh		;674d	28 20 	(   
	ld bc,02709h		;674f	01 09 27 	. . ' 
	dec l			;6752	2d 	- 
	nop			;6753	00 	. 
	ld a,(bc)			;6754	0a 	. 
	rst 38h			;6755	ff 	. 
	rrca			;6756	0f 	. 
	dec (hl)			;6757	35 	5 
	and b			;6758	a0 	. 
	rst 38h			;6759	ff 	. 
	jr nz,$+1		;675a	20 ff 	  . 
	rrca			;675c	0f 	. 
	inc l			;675d	2c 	, 
	add a,b			;675e	80 	. 
	nop			;675f	00 	. 
	and b			;6760	a0 	. 
	rst 38h			;6761	ff 	. 
	rst 38h			;6762	ff 	. 
	rra			;6763	1f 	. 
	dec e			;6764	1d 	. 
	ld (bc),a			;6765	02 	. 
	sbc a,d			;6766	9a 	. 
	inc h			;6767	24 	$ 
	ld (de),a			;6768	12 	. 
	ld (bc),a			;6769	02 	. 
	sbc a,h			;676a	9c 	. 
	dec h			;676b	25 	% 
	ld (01701h),a		;676c	32 01 17 	2 . . 
l676fh:
	dec h			;676f	25 	% 
	ld b,d			;6770	42 	B 
	nop			;6771	00 	. 
	ld d,0ffh		;6772	16 ff 	. . 
	ld hl,(00210h)		;6774	2a 10 02 	* . . 
	sbc a,(hl)			;6777	9e 	. 
	ld hl,(00130h)		;6778	2a 30 01 	* 0 . 
	add hl,de			;677b	19 	. 
	jr z,$+66		;677c	28 40 	( @ 
	nop			;677e	00 	. 
	inc e			;677f	1c 	. 
	rst 38h			;6780	ff 	. 
	jr nz,$+31		;6781	20 1d 	  . 
	ld (bc),a			;6783	02 	. 
	and b			;6784	a0 	. 
	dec h			;6785	25 	% 
	ld (de),a			;6786	12 	. 
	ld (bc),a			;6787	02 	. 
	and d			;6788	a2 	. 
	dec h			;6789	25 	% 
	ld (01b01h),a		;678a	32 01 1b 	2 . . 
	inc h			;678d	24 	$ 
	ld b,d			;678e	42 	B 
	nop			;678f	00 	. 
	ld a,(de)			;6790	1a 	. 
	rst 38h			;6791	ff 	. 
	ld hl,(00210h)		;6792	2a 10 02 	* . . 
	and h			;6795	a4 	. 
	ld hl,(00130h)		;6796	2a 30 01 	* 0 . 
	dec e			;6799	1d 	. 
	jr z,l67dch		;679a	28 40 	( @ 
	nop			;679c	00 	. 
	inc e			;679d	1c 	. 
	rst 38h			;679e	ff 	. 
	ld hl,(0003ch)		;679f	2a 3c 00 	* < . 
	ld hl,01028h		;67a2	21 28 10 	! ( . 
	ld (bc),a			;67a5	02 	. 
	and (hl)			;67a6	a6 	. 
	jr z,l67d7h		;67a7	28 2e 	( . 
	ld bc,0ff1fh		;67a9	01 1f ff 	. . . 
	rrca			;67ac	0f 	. 
	ld b,(hl)			;67ad	46 	F 
	nop			;67ae	00 	. 
	nop			;67af	00 	. 
	add a,b			;67b0	80 	. 
	rst 38h			;67b1	ff 	. 
	rrca			;67b2	0f 	. 
	scf			;67b3	37 	7 
	and b			;67b4	a0 	. 
	nop			;67b5	00 	. 
	nop			;67b6	00 	. 
	nop			;67b7	00 	. 
	rst 38h			;67b8	ff 	. 
	add hl,hl			;67b9	29 	) 
	ld c,c			;67ba	49 	I 
	nop			;67bb	00 	. 
	ld hl,01028h		;67bc	21 28 10 	! ( . 
	ld (bc),a			;67bf	02 	. 
	xor b			;67c0	a8 	. 
	jr z,l67eeh		;67c1	28 2b 	( + 
	ld bc,0ffaah		;67c3	01 aa ff 	. . . 
	ld b,(hl)			;67c6	46 	F 
	ld d,b			;67c7	50 	P 
	ret po			;67c8	e0 	. 
	rst 38h			;67c9	ff 	. 
	ld h,b			;67ca	60 	` 
	rst 38h			;67cb	ff 	. 
	add hl,sp			;67cc	39 	9 
	ld b,(hl)			;67cd	46 	F 
	ld h,b			;67ce	60 	` 
	nop			;67cf	00 	. 
	and b			;67d0	a0 	. 
	rst 38h			;67d1	ff 	. 
	inc d			;67d2	14 	. 
	add hl,sp			;67d3	39 	9 
	ld h,b			;67d4	60 	` 
	nop			;67d5	00 	. 
	ret nz			;67d6	c0 	. 
l67d7h:
	rst 38h			;67d7	ff 	. 
	rst 38h			;67d8	ff 	. 
	jr z,l67f2h		;67d9	28 17 	( . 
	ld (bc),a			;67db	02 	. 
l67dch:
	xor h			;67dc	ac 	. 
	add hl,hl			;67dd	29 	) 
	ld sp,02201h		;67de	31 01 22 	1 . " 
	jr z,$+67		;67e1	28 41 	( A 
	nop			;67e3	00 	. 
	ld hl,036ffh		;67e4	21 ff 36 	! . 6 
	ld c,d			;67e7	4a 	J 
	ret nz			;67e8	c0 	. 
	rst 38h			;67e9	ff 	. 
	ld b,b			;67ea	40 	@ 
	rst 38h			;67eb	ff 	. 
	dec hl			;67ec	2b 	+ 
	ccf			;67ed	3f 	? 
l67eeh:
	ret nz			;67ee	c0 	. 
	nop			;67ef	00 	. 
	ret po			;67f0	e0 	. 
	rst 38h			;67f1	ff 	. 
l67f2h:
	ld e,02ch		;67f2	1e 2c 	. , 
	jr nz,l67f6h		;67f4	20 00 	  . 
l67f6h:
	ld b,b			;67f6	40 	@ 
	rst 38h			;67f7	ff 	. 
	ld a,(de)			;67f8	1a 	. 
	ld e,040h		;67f9	1e 40 	. @ 
	nop			;67fb	00 	. 
	nop			;67fc	00 	. 
sub_67fdh:
	nop			;67fd	00 	. 
	rst 38h			;67fe	ff 	. 
	jr z,l684ah		;67ff	28 49 	( I 
	nop			;6801	00 	. 
	ld hl,01028h		;6802	21 28 10 	! ( . 
	ld (bc),a			;6805	02 	. 
	xor b			;6806	a8 	. 
	add hl,hl			;6807	29 	) 
	dec hl			;6808	2b 	+ 
	ld bc,0ffaeh		;6809	01 ae ff 	. . . 
	ld c,b			;680c	48 	H 
	ld d,e			;680d	53 	S 
	ret nz			;680e	c0 	. 
	rst 38h			;680f	ff 	. 
	ld b,b			;6810	40 	@ 
	rst 38h			;6811	ff 	. 
	cpl			;6812	2f 	/ 
	ld c,b			;6813	48 	H 
	ld h,b			;6814	60 	` 
	nop			;6815	00 	. 
	and b			;6816	a0 	. 
	rst 38h			;6817	ff 	. 
	inc d			;6818	14 	. 
	cpl			;6819	2f 	/ 
	ld b,b			;681a	40 	@ 
	nop			;681b	00 	. 
	ret nz			;681c	c0 	. 
	rst 38h			;681d	ff 	. 
	rst 38h			;681e	ff 	. 
	dec h			;681f	25 	% 
	djnz $+4		;6820	10 02 	. . 
	or b			;6822	b0 	. 
	ld hl,(00210h)		;6823	2a 10 02 	* . . 
	or d			;6826	b2 	. 
	inc e			;6827	1c 	. 
	jr c,l682bh		;6828	38 01 	8 . 
	inc h			;682a	24 	$ 
l682bh:
	ld hl,(00130h)		;682b	2a 30 01 	* 0 . 
	dec h			;682e	25 	% 
	inc l			;682f	2c 	, 
	ld b,b			;6830	40 	@ 
	nop			;6831	00 	. 
	ld h,0ffh		;6832	26 ff 	& . 
	rrca			;6834	0f 	. 
	ld c,e			;6835	4b 	K 
	ld b,b			;6836	40 	@ 
	ld bc,0ffc0h		;6837	01 c0 ff 	. . . 
	rrca			;683a	0f 	. 
	add hl,hl			;683b	29 	) 
	add a,b			;683c	80 	. 
	ld bc,0ff00h		;683d	01 00 ff 	. . . 
	rrca			;6840	0f 	. 
	cpl			;6841	2f 	/ 
	add a,b			;6842	80 	. 
	ld bc,0ffa0h		;6843	01 a0 ff 	. . . 
	rst 38h			;6846	ff 	. 
	dec h			;6847	25 	% 
	djnz $+4		;6848	10 02 	. . 
l684ah:
	or b			;684a	b0 	. 
	ld hl,(00210h)		;684b	2a 10 02 	* . . 
	or d			;684e	b2 	. 
	add hl,hl			;684f	29 	) 
	jr nc,$+3		;6850	30 01 	0 . 
	jr z,l687dh		;6852	28 29 	( ) 
	ld b,b			;6854	40 	@ 
	nop			;6855	00 	. 
	daa			;6856	27 	' 
	rst 38h			;6857	ff 	. 
	rrca			;6858	0f 	. 
	ld c,e			;6859	4b 	K 
	ld b,b			;685a	40 	@ 
	nop			;685b	00 	. 
	ret nz			;685c	c0 	. 
	rst 38h			;685d	ff 	. 
	rrca			;685e	0f 	. 
	ld hl,(00080h)		;685f	2a 80 00 	* . . 
	nop			;6862	00 	. 
	rst 38h			;6863	ff 	. 
	ld (0a040h),a		;6864	32 40 a0 	2 @ . 
	nop			;6867	00 	. 
	jr nz,l686ah		;6868	20 00 	  . 
l686ah:
	rst 38h			;686a	ff 	. 
	dec h			;686b	25 	% 
	djnz $+4		;686c	10 02 	. . 
	or b			;686e	b0 	. 
	ld hl,(00210h)		;686f	2a 10 02 	* . . 
	or d			;6872	b2 	. 
	inc e			;6873	1c 	. 
	jr c,l6877h		;6874	38 01 	8 . 
	add hl,hl			;6876	29 	) 
l6877h:
	jr z,l68a9h		;6877	28 30 	( 0 
	ld bc,0282bh		;6879	01 2b 28 	. + ( 
	ld b,b			;687c	40 	@ 
l687dh:
	nop			;687d	00 	. 
	ld hl,(00fffh)		;687e	2a ff 0f 	* . . 
	ld c,d			;6881	4a 	J 
	ld b,b			;6882	40 	@ 
	nop			;6883	00 	. 
	and b			;6884	a0 	. 
	rst 38h			;6885	ff 	. 
	rrca			;6886	0f 	. 
	add hl,hl			;6887	29 	) 
	add a,b			;6888	80 	. 
	nop			;6889	00 	. 
	nop			;688a	00 	. 
	rst 38h			;688b	ff 	. 
	add hl,hl			;688c	29 	) 
	ccf			;688d	3f 	? 
	add a,b			;688e	80 	. 
	nop			;688f	00 	. 
	ret nz			;6890	c0 	. 
	rst 38h			;6891	ff 	. 
	rst 38h			;6892	ff 	. 
	dec e			;6893	1d 	. 
	inc h			;6894	24 	$ 
	ld (bc),a			;6895	02 	. 
	or h			;6896	b4 	. 
	dec l			;6897	2d 	- 
	djnz l689ch		;6898	10 02 	. . 
	cp b			;689a	b8 	. 
	dec l			;689b	2d 	- 
l689ch:
	jr nc,l689fh		;689c	30 01 	0 . 
	or (hl)			;689e	b6 	. 
l689fh:
	dec l			;689f	2d 	- 
	ld b,b			;68a0	40 	@ 
	nop			;68a1	00 	. 
	inc l			;68a2	2c 	, 
	rst 38h			;68a3	ff 	. 
	daa			;68a4	27 	' 
	ld c,e			;68a5	4b 	K 
	add a,b			;68a6	80 	. 
	nop			;68a7	00 	. 
	nop			;68a8	00 	. 
l68a9h:
	nop			;68a9	00 	. 
	rrca			;68aa	0f 	. 
	daa			;68ab	27 	' 
	ret nz			;68ac	c0 	. 
	nop			;68ad	00 	. 
	ld b,b			;68ae	40 	@ 
	nop			;68af	00 	. 
	jr nc,$+65		;68b0	30 3f 	0 ? 
	ret po			;68b2	e0 	. 
	nop			;68b3	00 	. 
	and b			;68b4	a0 	. 
	nop			;68b5	00 	. 
	cpl			;68b6	2f 	/ 
	scf			;68b7	37 	7 
	nop			;68b8	00 	. 
	nop			;68b9	00 	. 
	ld b,b			;68ba	40 	@ 
	rst 38h			;68bb	ff 	. 
	rst 38h			;68bc	ff 	. 
	ld c,038h		;68bd	0e 38 	. 8 
	ld (bc),a			;68bf	02 	. 
	dec l			;68c0	2d 	- 
	ld e,030h		;68c1	1e 30 	. 0 
	ld (bc),a			;68c3	02 	. 
	ld (01028h),a		;68c4	32 28 10 	2 ( . 
	ld (bc),a			;68c7	02 	. 
	call nz,0302eh		;68c8	c4 2e 30 	. . 0 
	ld bc,02e34h		;68cb	01 34 2e 	. 4 . 
	ld b,b			;68ce	40 	@ 
	nop			;68cf	00 	. 
	inc sp			;68d0	33 	3 
	rst 38h			;68d1	ff 	. 
	scf			;68d2	37 	7 
	ld c,d			;68d3	4a 	J 
	and b			;68d4	a0 	. 
	nop			;68d5	00 	. 
	jr nz,l68d8h		;68d6	20 00 	  . 
l68d8h:
	dec (hl)			;68d8	35 	5 
	ccf			;68d9	3f 	? 
	jr nz,$+3		;68da	20 01 	  . 
	jr nz,$+1		;68dc	20 ff 	  . 
	inc de			;68de	13 	. 
	jr c,$+66		;68df	38 40 	8 @ 
	nop			;68e1	00 	. 
	and b			;68e2	a0 	. 
	rst 38h			;68e3	ff 	. 
	rst 38h			;68e4	ff 	. 
	daa			;68e5	27 	' 
	ld b,(hl)			;68e6	46 	F 
	nop			;68e7	00 	. 
	daa			;68e8	27 	' 
	jr z,l68fbh		;68e9	28 10 	( . 
	ld (bc),a			;68eb	02 	. 
	add a,028h		;68ec	c6 28 	. ( 
	jr z,$+3		;68ee	28 01 	( . 
	jp z,03718h		;68f0	ca 18 37 	. . 7 
	ld (bc),a			;68f3	02 	. 
	ret z			;68f4	c8 	. 
	rst 38h			;68f5	ff 	. 
	inc de			;68f6	13 	. 
	ld d,c			;68f7	51 	Q 
	nop			;68f8	00 	. 
	nop			;68f9	00 	. 
	add a,b			;68fa	80 	. 
l68fbh:
	rst 38h			;68fb	ff 	. 
	ld sp,08047h		;68fc	31 47 80 	1 G . 
	nop			;68ff	00 	. 
	nop			;6900	00 	. 
	nop			;6901	00 	. 
	rst 38h			;6902	ff 	. 
	dec h			;6903	25 	% 
	djnz l6908h		;6904	10 02 	. . 
	sub (hl)			;6906	96 	. 
	dec (hl)			;6907	35 	5 
l6908h:
	djnz $+4		;6908	10 02 	. . 
	sbc a,b			;690a	98 	. 
l690bh:
	ld e,028h		;690b	1e 28 	. ( 
	ld bc,02e11h		;690d	01 11 2e 	. . . 
	inc hl			;6910	23 	# 
	ld bc,02d0fh		;6911	01 0f 2d 	. . - 
	inc sp			;6914	33 	3 
	nop			;6915	00 	. 
	ld c,0ffh		;6916	0e ff 	. . 
	rrca			;6918	0f 	. 
	ld a,(00060h)		;6919	3a 60 00 	: ` . 
	ret po			;691c	e0 	. 
	rst 38h			;691d	ff 	. 
	rrca			;691e	0f 	. 
	ld sp,000c0h		;691f	31 c0 00 	1 . . 
	nop			;6922	00 	. 
	nop			;6923	00 	. 
	rrca			;6924	0f 	. 
	ld (00040h),hl		;6925	22 40 00 	" @ . 
	jr nz,$+1		;6928	20 ff 	  . 
	rst 38h			;692a	ff 	. 
	dec h			;692b	25 	% 
	djnz l6930h		;692c	10 02 	. . 
	sub (hl)			;692e	96 	. 
	dec (hl)			;692f	35 	5 
l6930h:
	djnz $+4		;6930	10 02 	. . 
	sbc a,b			;6932	98 	. 
	ld hl,(00123h)		;6933	2a 23 01 	* # . 
	inc de			;6936	13 	. 
	ld hl,(00033h)		;6937	2a 33 00 	* 3 . 
	ld (de),a			;693a	12 	. 
	rst 38h			;693b	ff 	. 
	rrca			;693c	0f 	. 
	ld a,(00060h)		;693d	3a 60 00 	: ` . 
	ret po			;6940	e0 	. 
	rst 38h			;6941	ff 	. 
	rrca			;6942	0f 	. 
	ld (000c0h),a		;6943	32 c0 00 	2 . . 
	jr nz,l6948h		;6946	20 00 	  . 
l6948h:
	rrca			;6948	0f 	. 
	ld (00020h),hl		;6949	22 20 00 	"   . 
	jr nz,$+1		;694c	20 ff 	  . 
	rst 38h			;694e	ff 	. 
	dec h			;694f	25 	% 
	djnz l6954h		;6950	10 02 	. . 
	sub (hl)			;6952	96 	. 
	dec (hl)			;6953	35 	5 
l6954h:
	djnz l6958h		;6954	10 02 	. . 
	sbc a,b			;6956	98 	. 
	rra			;6957	1f 	. 
l6958h:
	jr z,$+3		;6958	28 01 	( . 
	djnz $+42		;695a	10 28 	. ( 
	inc hl			;695c	23 	# 
	ld bc,02815h		;695d	01 15 28 	. . ( 
	inc sp			;6960	33 	3 
	nop			;6961	00 	. 
	inc d			;6962	14 	. 
	rst 38h			;6963	ff 	. 
	rrca			;6964	0f 	. 
	ld a,(00040h)		;6965	3a 40 00 	: @ . 
	ret nz			;6968	c0 	. 
	rst 38h			;6969	ff 	. 
	rrca			;696a	0f 	. 
	jr nc,$-62		;696b	30 c0 	0 . 
	nop			;696d	00 	. 
	ret po			;696e	e0 	. 
	rst 38h			;696f	ff 	. 
	rrca			;6970	0f 	. 
	ld (0ffe0h),hl		;6971	22 e0 ff 	" . . 
	nop			;6974	00 	. 
	rst 38h			;6975	ff 	. 
	rst 38h			;6976	ff 	. 
	jr nz,l6989h		;6977	20 10 	  . 
	ld (bc),a			;6979	02 	. 
	call z,02028h		;697a	cc 28 20 	. (   
	nop			;697d	00 	. 
	adc a,030h		;697e	ce 30 	. 0 
	djnz $+4		;6980	10 02 	. . 
	scf			;6982	37 	7 
	jr nc,l69a5h		;6983	30 20 	0   
	ld bc,0ff36h		;6985	01 36 ff 	. 6 . 
	dec e			;6988	1d 	. 
l6989h:
	jr c,l690bh		;6989	38 80 	8 . 
	nop			;698b	00 	. 
	nop			;698c	00 	. 
	nop			;698d	00 	. 
	rrca			;698e	0f 	. 
l698fh:
	inc l			;698f	2c 	, 
	ld b,b			;6990	40 	@ 
	ld bc,000a0h		;6991	01 a0 00 	. . . 
	rra			;6994	1f 	. 
	dec hl			;6995	2b 	+ 
	nop			;6996	00 	. 
	nop			;6997	00 	. 
	ld b,b			;6998	40 	@ 
	rst 38h			;6999	ff 	. 
	rrca			;699a	0f 	. 
	rra			;699b	1f 	. 
	ld b,b			;699c	40 	@ 
	rst 38h			;699d	ff 	. 
	ret nz			;699e	c0 	. 
	cp 0ffh		;699f	fe ff 	. . 
	rrca			;69a1	0f 	. 
	djnz l69a6h		;69a2	10 02 	. . 
	dec sp			;69a4	3b 	; 
l69a5h:
	rra			;69a5	1f 	. 
l69a6h:
	djnz $+4		;69a6	10 02 	. . 
	call nc,01a26h		;69a8	d4 26 1a 	. & . 
	nop			;69ab	00 	. 
	ret c			;69ac	d8 	. 
	jr nc,l69bfh		;69ad	30 10 	0 . 
	ld (bc),a			;69af	02 	. 
	sub 02dh		;69b0	d6 2d 	. - 
	inc hl			;69b2	23 	# 
	ld bc,0ff3ch		;69b3	01 3c ff 	. < . 
	ld a,(de)			;69b6	1a 	. 
	jr c,$+34		;69b7	38 20 	8   
	nop			;69b9	00 	. 
	and b			;69ba	a0 	. 
	rst 38h			;69bb	ff 	. 
	add hl,de			;69bc	19 	. 
	dec l			;69bd	2d 	- 
	nop			;69be	00 	. 
l69bfh:
	ld bc,0fee0h		;69bf	01 e0 fe 	. . . 
	rrca			;69c2	0f 	. 
	rra			;69c3	1f 	. 
	ret nz			;69c4	c0 	. 
	ld bc,000e0h		;69c5	01 e0 00 	. . . 
	rst 38h			;69c8	ff 	. 
	jr l6a04h		;69c9	18 39 	. 9 
	nop			;69cb	00 	. 
	ld hl,01b12h		;69cc	21 12 1b 	! . . 
	ld (bc),a			;69cf	02 	. 
	ld l,022h		;69d0	2e 22 	. " 
	djnz $+4		;69d2	10 02 	. . 
	jp nz,02b1bh		;69d4	c2 1b 2b 	. . + 
	ld bc,0ff31h		;69d7	01 31 ff 	. 1 . 
	add hl,sp			;69da	39 	9 
	ld b,d			;69db	42 	B 
	ret nz			;69dc	c0 	. 
	defb 0fdh,040h,0fdh	;illegal sequence		;69dd	fd 40 fd 	. @ . 
	ld hl,(0a039h)		;69e0	2a 39 a0 	* 9 . 
	cp 0c0h		;69e3	fe c0 	. . 
	defb 0fdh,01fh,02fh	;illegal sequence		;69e5	fd 1f 2f 	. . / 
	ld b,b			;69e8	40 	@ 
	rst 38h			;69e9	ff 	. 
	ld b,b			;69ea	40 	@ 
	cp 00fh		;69eb	fe 0f 	. . 
	jr nz,l698fh		;69ed	20 a0 	  . 
	rst 38h			;69ef	ff 	. 
	nop			;69f0	00 	. 
	rst 38h			;69f1	ff 	. 
	rst 38h			;69f2	ff 	. 
	add hl,hl			;69f3	29 	) 
	ld b,b			;69f4	40 	@ 
	nop			;69f5	00 	. 
	ld a,029h		;69f6	3e 29 	> ) 
	jr nc,l69fbh		;69f8	30 01 	0 . 
	ccf			;69fa	3f 	? 
l69fbh:
	add hl,hl			;69fb	29 	) 
	djnz l6a00h		;69fc	10 02 	. . 
	ld b,d			;69fe	42 	B 
	rst 38h			;69ff	ff 	. 
l6a00h:
	rrca			;6a00	0f 	. 
	ld c,e			;6a01	4b 	K 
	jr nz,l6a04h		;6a02	20 00 	  . 
l6a04h:
	and b			;6a04	a0 	. 
	rst 38h			;6a05	ff 	. 
	rst 38h			;6a06	ff 	. 
	dec h			;6a07	25 	% 
	ccf			;6a08	3f 	? 
l6a09h:
	nop			;6a09	00 	. 
	rlca			;6a0a	07 	. 
	dec hl			;6a0b	2b 	+ 
	cpl			;6a0c	2f 	/ 
	ld bc,02c35h		;6a0d	01 35 2c 	. 5 , 
	djnz l6a14h		;6a10	10 02 	. . 
	ld b,h			;6a12	44 	D 
	rst 38h			;6a13	ff 	. 
l6a14h:
	ld b,b			;6a14	40 	@ 
	ld c,b			;6a15	48 	H 
	and b			;6a16	a0 	. 
	rst 38h			;6a17	ff 	. 
	jr nz,$+1		;6a18	20 ff 	  . 
	inc (hl)			;6a1a	34 	4 
	ccf			;6a1b	3f 	? 
	ld h,b			;6a1c	60 	` 
	nop			;6a1d	00 	. 
	ret nz			;6a1e	c0 	. 
	rst 38h			;6a1f	ff 	. 
	rrca			;6a20	0f 	. 
	ld a,(000c0h)		;6a21	3a c0 00 	: . . 
	jr nz,l6a26h		;6a24	20 00 	  . 
l6a26h:
	rst 38h			;6a26	ff 	. 
	ld hl,(00040h)		;6a27	2a 40 00 	* @ . 
	dec a			;6a2a	3d 	= 
	jr nz,l6a5dh		;6a2b	20 30 	  0 
	ld b,c			;6a2d	41 	A 
	dec hl			;6a2e	2b 	+ 
	jr nc,l6a61h		;6a2f	30 30 	0 0 
	ld b,c			;6a31	41 	A 
	ld a,020h		;6a32	3e 20 	>   
	djnz $+4		;6a34	10 02 	. . 
	ld b,(hl)			;6a36	46 	F 
	jr nc,l6a49h		;6a37	30 10 	0 . 
	ld (bc),a			;6a39	02 	. 
	ld c,b			;6a3a	48 	H 
	rst 38h			;6a3b	ff 	. 
	ld h,033h		;6a3c	26 33 	& 3 
	ld b,c			;6a3e	41 	A 
	ccf			;6a3f	3f 	? 
	ld (hl),031h		;6a40	36 31 	6 1 
	add a,b			;6a42	80 	. 
	jp pe,0141ch		;6a43	ea 1c 14 	. . . 
	ld (bc),a			;6a46	02 	. 
	ld c,d			;6a47	4a 	J 
	inc l			;6a48	2c 	, 
l6a49h:
	inc de			;6a49	13 	. 
	ld (bc),a			;6a4a	02 	. 
	ld c,h			;6a4b	4c 	L 
	inc a			;6a4c	3c 	< 
	add hl,de			;6a4d	19 	. 
	nop			;6a4e	00 	. 
	ld c,(hl)			;6a4f	4e 	N 
	rst 38h			;6a50	ff 	. 
	ld l,040h		;6a51	2e 40 	. @ 
	add a,b			;6a53	80 	. 
	ex de,hl			;6a54	eb 	. 
	ld e,030h		;6a55	1e 30 	. 0 
	add a,c			;6a57	81 	. 
	call pe,0302eh		;6a58	ec 2e 30 	. . 0 
	add a,c			;6a5b	81 	. 
	defb 0edh;next byte illegal after ed		;6a5c	ed 	. 
l6a5dh:
	ld e,010h		;6a5d	1e 10 	. . 
	ld (bc),a			;6a5f	02 	. 
	ld d,b			;6a60	50 	P 
l6a61h:
	ld l,010h		;6a61	2e 10 	. . 
	ld (bc),a			;6a63	02 	. 
	ld d,d			;6a64	52 	R 
	rst 38h			;6a65	ff 	. 
	daa			;6a66	27 	' 
	ld (hl),081h		;6a67	36 81 	6 . 
	xor 037h		;6a69	ee 37 	. 7 
	inc l			;6a6b	2c 	, 
	add a,b			;6a6c	80 	. 
	rst 28h			;6a6d	ef 	. 
	rla			;6a6e	17 	. 
	djnz l6a73h		;6a6f	10 02 	. . 
	ld d,h			;6a71	54 	T 
	daa			;6a72	27 	' 
l6a73h:
	ld d,001h		;6a73	16 01 	. . 
	ld d,(hl)			;6a75	56 	V 
	scf			;6a76	37 	7 
	djnz l6a7ah		;6a77	10 01 	. . 
	ld e,b			;6a79	58 	X 
l6a7ah:
	rst 38h			;6a7a	ff 	. 
	sub a			;6a7b	97 	. 
	ld l,d			;6a7c	6a 	j 
	and h			;6a7d	a4 	. 
	ld l,d			;6a7e	6a 	j 
	or c			;6a7f	b1 	. 
	ld l,d			;6a80	6a 	j 
	and h			;6a81	a4 	. 
	ld l,d			;6a82	6a 	j 
	ret c			;6a83	d8 	. 
	ld l,d			;6a84	6a 	j 
	bit 5,d		;6a85	cb 6a 	. j 
	cp (hl)			;6a87	be 	. 
	ld l,d			;6a88	6a 	j 
	push hl			;6a89	e5 	. 
	ld l,d			;6a8a	6a 	j 
	jp p,0ff6ah		;6a8b	f2 6a ff 	. j . 
	ld l,d			;6a8e	6a 	j 
	ld (0196bh),hl		;6a8f	22 6b 19 	" k . 
	ld l,e			;6a92	6b 	k 
	inc c			;6a93	0c 	. 
	ld l,e			;6a94	6b 	k 
	add hl,de			;6a95	19 	. 
	ld l,e			;6a96	6b 	k 
	dec l			;6a97	2d 	- 
	ld b,b			;6a98	40 	@ 
	ld b,l			;6a99	45 	E 
	nop			;6a9a	00 	. 
l6a9bh:
	daa			;6a9b	27 	' 
	djnz $+70		;6a9c	10 44 	. D 
	add a,b			;6a9e	80 	. 
	dec l			;6a9f	2d 	- 
	djnz l6ae6h		;6aa0	10 44 	. D 
	ld b,b			;6aa2	40 	@ 
	rst 38h			;6aa3	ff 	. 
	dec l			;6aa4	2d 	- 
	ld b,b			;6aa5	40 	@ 
	ld b,l			;6aa6	45 	E 
	nop			;6aa7	00 	. 
	add hl,hl			;6aa8	29 	) 
	jr nc,l6aefh		;6aa9	30 44 	0 D 
	ld bc,01029h		;6aab	01 29 10 	. ) . 
	ld b,h			;6aae	44 	D 
	ld b,d			;6aaf	42 	B 
	rst 38h			;6ab0	ff 	. 
	dec l			;6ab1	2d 	- 
	ld b,b			;6ab2	40 	@ 
	ld b,l			;6ab3	45 	E 
	nop			;6ab4	00 	. 
	jr z,l6ac7h		;6ab5	28 10 	( . 
	ld b,h			;6ab7	44 	D 
	add a,h			;6ab8	84 	. 
	ld sp,04410h		;6ab9	31 10 44 	1 . D 
	ld b,h			;6abc	44 	D 
	rst 38h			;6abd	ff 	. 
	daa			;6abe	27 	' 
	inc a			;6abf	3c 	< 
	ld b,l			;6ac0	45 	E 
	ld (bc),a			;6ac1	02 	. 
	ld hl,l4420h		;6ac2	21 20 44 	!   D 
	ld b,(hl)			;6ac5	46 	F 
	inc l			;6ac6	2c 	, 
l6ac7h:
	djnz l6b0dh		;6ac7	10 44 	. D 
	ld c,b			;6ac9	48 	H 
	rst 38h			;6aca	ff 	. 
	inc h			;6acb	24 	$ 
	jr z,l6b12h		;6acc	28 44 	( D 
	ld c,d			;6ace	4a 	J 
	jr z,l6afch		;6acf	28 2b 	( + 
	ld b,l			;6ad1	45 	E 
	ld c,h			;6ad2	4c 	L 
	jr z,l6ae5h		;6ad3	28 10 	( . 
	ld b,h			;6ad5	44 	D 
	ld c,(hl)			;6ad6	4e 	N 
	rst 38h			;6ad7	ff 	. 
	inc l			;6ad8	2c 	, 
	inc c			;6ad9	0c 	. 
	ld b,l			;6ada	45 	E 
	sbc a,b			;6adb	98 	. 
	dec h			;6adc	25 	% 
	jr nz,l6b23h		;6add	20 44 	  D 
	ld d,(hl)			;6adf	56 	V 
	dec h			;6ae0	25 	% 
	djnz $+70		;6ae1	10 44 	. D 
	inc b			;6ae3	04 	. 
	rst 38h			;6ae4	ff 	. 
l6ae5h:
	add hl,de			;6ae5	19 	. 
l6ae6h:
	dec c			;6ae6	0d 	. 
	ld b,l			;6ae7	45 	E 
	adc a,b			;6ae8	88 	. 
l6ae9h:
	rra			;6ae9	1f 	. 
	ld a,(de)			;6aea	1a 	. 
	ld b,h			;6aeb	44 	D 
	ld d,b			;6aec	50 	P 
	cpl			;6aed	2f 	/ 
	dec c			;6aee	0d 	. 
l6aefh:
	ld b,h			;6aef	44 	D 
	adc a,h			;6af0	8c 	. 
	rst 38h			;6af1	ff 	. 
	inc e			;6af2	1c 	. 
	dec c			;6af3	0d 	. 
	ld b,l			;6af4	45 	E 
	sub b			;6af5	90 	. 
l6af6h:
	inc l			;6af6	2c 	, 
	rla			;6af7	17 	. 
	ld b,h			;6af8	44 	D 
	ld d,d			;6af9	52 	R 
	dec (hl)			;6afa	35 	5 
	dec c			;6afb	0d 	. 
l6afch:
	ld b,h			;6afc	44 	D 
	ld d,h			;6afd	54 	T 
	rst 38h			;6afe	ff 	. 
l6affh:
	jr z,l6b40h		;6aff	28 3f 	( ? 
	ld b,l			;6b01	45 	E 
	nop			;6b02	00 	. 
l6b03h:
	ld h,010h		;6b03	26 10 	& . 
	ld b,h			;6b05	44 	D 
	sub h			;6b06	94 	. 
	ld (hl),030h		;6b07	36 30 	6 0 
	ld b,h			;6b09	44 	D 
	inc bc			;6b0a	03 	. 
	rst 38h			;6b0b	ff 	. 
	add hl,hl			;6b0c	29 	) 
l6b0dh:
	ld b,b			;6b0d	40 	@ 
	add a,l			;6b0e	85 	. 
	nop			;6b0f	00 	. 
	ld h,010h		;6b10	26 10 	& . 
l6b12h:
	ld b,h			;6b12	44 	D 
	or 036h		;6b13	f6 36 	. 6 
	djnz l6a9bh		;6b15	10 84 	. . 
	jp c,02affh		;6b17	da ff 2a 	. . * 
	ld b,b			;6b1a	40 	@ 
	add a,l			;6b1b	85 	. 
	nop			;6b1c	00 	. 
	ld hl,(04410h)		;6b1d	2a 10 44 	* . D 
	call m,02affh		;6b20	fc ff 2a 	. . * 
l6b23h:
	ld b,b			;6b23	40 	@ 
	add a,l			;6b24	85 	. 
	nop			;6b25	00 	. 
	ld h,010h		;6b26	26 10 	& . 
	ld b,h			;6b28	44 	D 
	jp m,01036h		;6b29	fa 36 10 	. 6 . 
	call nz,0fff2h		;6b2c	c4 f2 ff 	. . . 
	ld d,c			;6b2f	51 	Q 
	ld l,e			;6b30	6b 	k 
	ld e,(hl)			;6b31	5e 	^ 
	ld l,e			;6b32	6b 	k 
	ld l,e			;6b33	6b 	k 
	ld l,e			;6b34	6b 	k 
	ld e,(hl)			;6b35	5e 	^ 
	ld l,e			;6b36	6b 	k 
	add a,l			;6b37	85 	. 
	ld l,e			;6b38	6b 	k 
	ld a,b			;6b39	78 	x 
	ld l,e			;6b3a	6b 	k 
	nop			;6b3b	00 	. 
	nop			;6b3c	00 	. 
l6b3dh:
	sub d			;6b3d	92 	. 
	ld l,e			;6b3e	6b 	k 
	sbc a,e			;6b3f	9b 	. 
l6b40h:
	ld l,e			;6b40	6b 	k 
	and h			;6b41	a4 	. 
	ld l,e			;6b42	6b 	k 
	or c			;6b43	b1 	. 
	ld l,e			;6b44	6b 	k 
	or c			;6b45	b1 	. 
	ld l,e			;6b46	6b 	k 
	cp d			;6b47	ba 	. 
	ld l,e			;6b48	6b 	k 
	jp 0cc6bh		;6b49	c3 6b cc 	. k . 
	ld l,e			;6b4c	6b 	k 
	push de			;6b4d	d5 	. 
	ld l,e			;6b4e	6b 	k 
	sbc a,06bh		;6b4f	de 6b 	. k 
	jr z,l6b83h		;6b51	28 30 	( 0 
	sub c			;6b53	91 	. 
	djnz l6b7eh		;6b54	10 28 	. ( 
	jr nz,l6ae9h		;6b56	20 91 	  . 
	ld de,01028h		;6b58	11 28 10 	. ( . 
	sub d			;6b5b	92 	. 
	add a,d			;6b5c	82 	. 
	rst 38h			;6b5d	ff 	. 
	jr z,l6b90h		;6b5e	28 30 	( 0 
	sub c			;6b60	91 	. 
	djnz l6b8bh		;6b61	10 28 	. ( 
	jr nz,l6af6h		;6b63	20 91 	  . 
	ld (de),a			;6b65	12 	. 
	jr z,l6b78h		;6b66	28 10 	( . 
	sub d			;6b68	92 	. 
	add a,h			;6b69	84 	. 
	rst 38h			;6b6a	ff 	. 
	daa			;6b6b	27 	' 
	jr nc,l6affh		;6b6c	30 91 	0 . 
	djnz $+42		;6b6e	10 28 	. ( 
	jr nz,l6b03h		;6b70	20 91 	  . 
l6b72h:
	inc de			;6b72	13 	. 
	jr z,l6b85h		;6b73	28 10 	( . 
	sub d			;6b75	92 	. 
	add a,(hl)			;6b76	86 	. 
	rst 38h			;6b77	ff 	. 
l6b78h:
	jr z,l6b9ah		;6b78	28 20 	(   
	sub c			;6b7a	91 	. 
	adc a,b			;6b7b	88 	. 
	jr z,l6b8eh		;6b7c	28 10 	( . 
l6b7eh:
	sub d			;6b7e	92 	. 
	adc a,d			;6b7f	8a 	. 
	dec hl			;6b80	2b 	+ 
	ld l,047h		;6b81	2e 47 	. G 
l6b83h:
	inc c			;6b83	0c 	. 
	rst 38h			;6b84	ff 	. 
l6b85h:
	jr z,l6ba7h		;6b85	28 20 	(   
	sub c			;6b87	91 	. 
	sub d			;6b88	92 	. 
	jr z,l6b9bh		;6b89	28 10 	( . 
l6b8bh:
	sub d			;6b8b	92 	. 
	sub h			;6b8c	94 	. 
	inc l			;6b8d	2c 	, 
l6b8eh:
	inc c			;6b8e	0c 	. 
	ld b,a			;6b8f	47 	G 
l6b90h:
	inc c			;6b90	0c 	. 
	rst 38h			;6b91	ff 	. 
	ld (09118h),hl		;6b92	22 18 91 	" . . 
	sub (hl)			;6b95	96 	. 
	dec l			;6b96	2d 	- 
	djnz $-108		;6b97	10 92 	. . 
	sbc a,b			;6b99	98 	. 
l6b9ah:
	rst 38h			;6b9a	ff 	. 
l6b9bh:
	ld e,012h		;6b9b	1e 12 	. . 
	sub c			;6b9d	91 	. 
	adc a,h			;6b9e	8c 	. 
	ld l,012h		;6b9f	2e 12 	. . 
	sub d			;6ba1	92 	. 
	adc a,(hl)			;6ba2	8e 	. 
	rst 38h			;6ba3	ff 	. 
	daa			;6ba4	27 	' 
	dec l			;6ba5	2d 	- 
	sub c			;6ba6	91 	. 
l6ba7h:
	djnz $+43		;6ba7	10 29 	. ) 
	djnz l6b3dh		;6ba9	10 92 	. . 
	sub b			;6bab	90 	. 
	inc l			;6bac	2c 	, 
	jr nz,l6b40h		;6bad	20 91 	  . 
	inc d			;6baf	14 	. 
	rst 38h			;6bb0	ff 	. 
	ld hl,(0d118h)		;6bb1	2a 18 d1 	* . . 
	call p,0102ah		;6bb4	f4 2a 10 	. * . 
	jp nc,0fff6h		;6bb7	d2 f6 ff 	. . . 
	inc l			;6bba	2c 	, 
	ld e,0d1h		;6bbb	1e d1 	. . 
	ret m			;6bbd	f8 	. 
	ld hl,(0d20ah)		;6bbe	2a 0a d2 	* . . 
	jp m,029ffh		;6bc1	fa ff 29 	. . ) 
	dec c			;6bc4	0d 	. 
	pop de			;6bc5	d1 	. 
	call m,01226h		;6bc6	fc 26 12 	. & . 
	sub d			;6bc9	92 	. 
	ei			;6bca	fb 	. 
	rst 38h			;6bcb	ff 	. 
	daa			;6bcc	27 	' 
	dec c			;6bcd	0d 	. 
	pop de			;6bce	d1 	. 
	cp 020h		;6bcf	fe 20 	.   
	ld d,092h		;6bd1	16 92 	. . 
	call m,027ffh		;6bd3	fc ff 27 	. . ' 
	dec c			;6bd6	0d 	. 
	pop de			;6bd7	d1 	. 
	call m,01824h		;6bd8	fc 24 18 	. $ . 
	sub d			;6bdb	92 	. 
	ei			;6bdc	fb 	. 
	rst 38h			;6bdd	ff 	. 
	jr z,l6beah		;6bde	28 0a 	( . 
	pop de			;6be0	d1 	. 
	cp 021h		;6be1	fe 21 	. ! 
	ld de,0fc92h		;6be3	11 92 fc 	. . . 
	rst 38h			;6be6	ff 	. 
	ld bc,00e6ch		;6be7	01 6c 0e 	. l . 
l6beah:
	ld l,h			;6bea	6c 	l 
	rla			;6beb	17 	. 
	ld l,h			;6bec	6c 	l 
	ld c,06ch		;6bed	0e 6c 	. l 
	dec l			;6bef	2d 	- 
	ld l,h			;6bf0	6c 	l 
	ld a,(0246ch)		;6bf1	3a 6c 24 	: l $ 
	ld l,h			;6bf4	6c 	l 
	ld b,a			;6bf5	47 	G 
	ld l,h			;6bf6	6c 	l 
	ld d,h			;6bf7	54 	T 
	ld l,h			;6bf8	6c 	l 
	ld (hl),a			;6bf9	77 	w 
	ld l,h			;6bfa	6c 	l 
	add a,h			;6bfb	84 	. 
	ld l,h			;6bfc	6c 	l 
	ld h,c			;6bfd	61 	a 
	ld l,h			;6bfe	6c 	l 
	ld l,d			;6bff	6a 	j 
	ld l,h			;6c00	6c 	l 
	dec h			;6c01	25 	% 
	jr nc,$+8		;6c02	30 06 	0 . 
	cp (hl)			;6c04	be 	. 
	dec h			;6c05	25 	% 
	djnz l6c0eh		;6c06	10 06 	. . 
l6c08h:
	ret nz			;6c08	c0 	. 
	ld hl,(l4610h)		;6c09	2a 10 46 	* . F 
	ld e,b			;6c0c	58 	X 
	rst 38h			;6c0d	ff 	. 
l6c0eh:
	dec h			;6c0e	25 	% 
	jr nc,l6c17h		;6c0f	30 06 	0 . 
	cp d			;6c11	ba 	. 
	dec h			;6c12	25 	% 
	djnz l6c1bh		;6c13	10 06 	. . 
	cp h			;6c15	bc 	. 
	rst 38h			;6c16	ff 	. 
l6c17h:
	dec h			;6c17	25 	% 
	jr nc,$+8		;6c18	30 06 	0 . 
	ret nc			;6c1a	d0 	. 
l6c1bh:
	dec h			;6c1b	25 	% 
	djnz l6c24h		;6c1c	10 06 	. . 
	jp nc,0102bh		;6c1e	d2 2b 10 	. + . 
	ld b,(hl)			;6c21	46 	F 
	ld e,d			;6c22	5a 	Z 
	rst 38h			;6c23	ff 	. 
l6c24h:
	daa			;6c24	27 	' 
	djnz l6c6dh		;6c25	10 46 	. F 
	and b			;6c27	a0 	. 
	dec l			;6c28	2d 	- 
	ld a,047h		;6c29	3e 47 	> G 
	dec b			;6c2b	05 	. 
	rst 38h			;6c2c	ff 	. 
	jr nz,l6c58h		;6c2d	20 29 	  ) 
	ld b,(hl)			;6c2f	46 	F 
	ld b,026h		;6c30	06 26 	. & 
	inc c			;6c32	0c 	. 
	ld b,(hl)			;6c33	46 	F 
	xor h			;6c34	ac 	. 
	jr nc,$+14		;6c35	30 0c 	0 . 
	ld b,a			;6c37	47 	G 
	rlca			;6c38	07 	. 
	rst 38h			;6c39	ff 	. 
	jr nz,l6c4ch		;6c3a	20 10 	  . 
	ld b,(hl)			;6c3c	46 	F 
	ret nc			;6c3d	d0 	. 
	ld hl,(0472dh)		;6c3e	2a 2d 47 	* - G 
	inc c			;6c41	0c 	. 
	jr nc,l6c54h		;6c42	30 10 	0 . 
	ld b,(hl)			;6c44	46 	F 
	call nc,017ffh		;6c45	d4 ff 17 	. . . 
	dec h			;6c48	25 	% 
	ld b,(hl)			;6c49	46 	F 
	ld e,h			;6c4a	5c 	\ 
	daa			;6c4b	27 	' 
l6c4ch:
	ld c,046h		;6c4c	0e 46 	. F 
	or b			;6c4e	b0 	. 
	scf			;6c4f	37 	7 
	djnz l6c98h		;6c50	10 46 	. F 
	ld e,(hl)			;6c52	5e 	^ 
	rst 38h			;6c53	ff 	. 
l6c54h:
	rla			;6c54	17 	. 
	ld a,(bc)			;6c55	0a 	. 
	ld b,(hl)			;6c56	46 	F 
	or h			;6c57	b4 	. 
l6c58h:
	daa			;6c58	27 	' 
	ld a,(bc)			;6c59	0a 	. 
	ld b,(hl)			;6c5a	46 	F 
	cp b			;6c5b	b8 	. 
	scf			;6c5c	37 	7 
	ld a,(bc)			;6c5d	0a 	. 
	ld b,(hl)			;6c5e	46 	F 
	ld h,b			;6c5f	60 	` 
	rst 38h			;6c60	ff 	. 
	daa			;6c61	27 	' 
	djnz l6caah		;6c62	10 46 	. F 
	cp h			;6c64	bc 	. 
	daa			;6c65	27 	' 
	ld c,b			;6c66	48 	H 
	ld b,a			;6c67	47 	G 
	ex af,af'			;6c68	08 	. 
	rst 38h			;6c69	ff 	. 
l6c6ah:
	ld h,010h		;6c6a	26 10 	& . 
	ld b,(hl)			;6c6c	46 	F 
l6c6dh:
	ret nz			;6c6d	c0 	. 
	ld (hl),037h		;6c6e	36 37 	6 7 
	ld b,(hl)			;6c70	46 	F 
	add hl,bc			;6c71	09 	. 
	ld (hl),010h		;6c72	36 10 	6 . 
	ld b,(hl)			;6c74	46 	F 
	ld a,(bc)			;6c75	0a 	. 
	rst 38h			;6c76	ff 	. 
	rla			;6c77	17 	. 
	jr nc,$+72		;6c78	30 46 	0 F 
	dec bc			;6c7a	0b 	. 
	rla			;6c7b	17 	. 
	djnz l6cc4h		;6c7c	10 46 	. F 
	ld h,d			;6c7e	62 	b 
	daa			;6c7f	27 	' 
	djnz l6cc8h		;6c80	10 46 	. F 
	call nz,01fffh		;6c82	c4 ff 1f 	. . . 
	djnz l6ccdh		;6c85	10 46 	. F 
	ret z			;6c87	c8 	. 
	cpl			;6c88	2f 	/ 
	djnz l6cd1h		;6c89	10 46 	. F 
	call z,0c5ffh		;6c8b	cc ff c5 	. . . 
	ld l,h			;6c8e	6c 	l 
	sub 06ch		;6c8f	d6 6c 	. l 
	rst 20h			;6c91	e7 	. 
	ld l,h			;6c92	6c 	l 
	sub 06ch		;6c93	d6 6c 	. l 
	ld h,06dh		;6c95	26 6d 	& m 
	ld d,b			;6c97	50 	P 
l6c98h:
	ld l,l			;6c98	6d 	m 
	sub e			;6c99	93 	. 
	ld l,l			;6c9a	6d 	m 
	ld d,b			;6c9b	50 	P 
	ld l,l			;6c9c	6d 	m 
	ld h,06dh		;6c9d	26 6d 	& m 
	dec c			;6c9f	0d 	. 
	ld l,l			;6ca0	6d 	m 
	dec sp			;6ca1	3b 	; 
	ld l,l			;6ca2	6d 	m 
	ld a,(hl)			;6ca3	7e 	~ 
	ld l,l			;6ca4	6d 	m 
	dec sp			;6ca5	3b 	; 
	ld l,l			;6ca6	6d 	m 
	dec c			;6ca7	0d 	. 
	ld l,l			;6ca8	6d 	m 
	ret m			;6ca9	f8 	. 
l6caah:
	ld l,h			;6caa	6c 	l 
	dec sp			;6cab	3b 	; 
	ld l,l			;6cac	6d 	m 
	ld h,l			;6cad	65 	e 
	ld l,l			;6cae	6d 	m 
	dec sp			;6caf	3b 	; 
	ld l,l			;6cb0	6d 	m 
	ret m			;6cb1	f8 	. 
	ld l,h			;6cb2	6c 	l 
	jp c,0c56dh		;6cb3	da 6d c5 	. m . 
	ld l,l			;6cb6	6d 	m 
	xor h			;6cb7	ac 	. 
	ld l,l			;6cb8	6d 	m 
	inc c			;6cb9	0c 	. 
	ld l,(hl)			;6cba	6e 	n 
	di			;6cbb	f3 	. 
	ld l,l			;6cbc	6d 	m 
	dec h			;6cbd	25 	% 
	ld l,(hl)			;6cbe	6e 	n 
	ld (hl),06eh		;6cbf	36 6e 	6 n 
	ld b,e			;6cc1	43 	C 
	ld l,(hl)			;6cc2	6e 	n 
	ld e,b			;6cc3	58 	X 
l6cc4h:
	ld l,(hl)			;6cc4	6e 	n 
	jr nz,$+18		;6cc5	20 10 	  . 
	ld c,b			;6cc7	48 	H 
l6cc8h:
	ld h,h			;6cc8	64 	d 
	jr nc,l6cdbh		;6cc9	30 10 	0 . 
	ld c,c			;6ccb	49 	I 
	ld h,(hl)			;6ccc	66 	f 
l6ccdh:
	inc h			;6ccd	24 	$ 
	jr nc,l6d19h		;6cce	30 49 	0 I 
	ld l,b			;6cd0	68 	h 
l6cd1h:
	inc (hl)			;6cd1	34 	4 
	jr nc,l6d1dh		;6cd2	30 49 	0 I 
	dec c			;6cd4	0d 	. 
	rst 38h			;6cd5	ff 	. 
	ld h,010h		;6cd6	26 10 	& . 
	ld c,b			;6cd8	48 	H 
	ld c,026h		;6cd9	0e 26 	. & 
l6cdbh:
	jr nz,l6d26h		;6cdb	20 49 	  I 
	ld l,d			;6cdd	6a 	j 
	ld h,040h		;6cde	26 40 	& @ 
	ld c,c			;6ce0	49 	I 
	rrca			;6ce1	0f 	. 
	ld (hl),028h		;6ce2	36 28 	6 ( 
	ld c,c			;6ce4	49 	I 
	djnz $+1		;6ce5	10 ff 	. . 
	jr nz,$+18		;6ce7	20 10 	  . 
	ld c,c			;6ce9	49 	I 
	ld l,h			;6cea	6c 	l 
	daa			;6ceb	27 	' 
	jr nc,$+75		;6cec	30 49 	0 I 
	ld l,(hl)			;6cee	6e 	n 
	jr nc,$+18		;6cef	30 10 	0 . 
	ld c,b			;6cf1	48 	H 
	ld (hl),b			;6cf2	70 	p 
	jr c,$+43		;6cf3	38 29 	8 ) 
	ld c,c			;6cf5	49 	I 
	djnz $+1		;6cf6	10 ff 	. . 
	ld hl,l4810h		;6cf8	21 10 48 	! . H 
	ld (hl),d			;6cfb	72 	r 
	ld sp,l4810h		;6cfc	31 10 48 	1 . H 
	ld (hl),h			;6cff	74 	t 
	jr l6d2fh		;6d00	18 2d 	. - 
	ld c,c			;6d02	49 	I 
	halt			;6d03	76 	v 
	jr z,l6d26h		;6d04	28 20 	(   
	ld c,c			;6d06	49 	I 
	ret c			;6d07	d8 	. 
	jr $+78		;6d08	18 4c 	. L 
	ld c,b			;6d0a	48 	H 
	ld de,025ffh		;6d0b	11 ff 25 	. . % 
	ld b,b			;6d0e	40 	@ 
	ld c,c			;6d0f	49 	I 
	rrca			;6d10	0f 	. 
	ex af,af'			;6d11	08 	. 
	jr nc,l6d5dh		;6d12	30 49 	0 I 
	ld a,b			;6d14	78 	x 
	jr $+56		;6d15	18 36 	. 6 
	ld c,c			;6d17	49 	I 
	ld (de),a			;6d18	12 	. 
l6d19h:
	ld hl,l4810h		;6d19	21 10 48 	! . H 
	ld (hl),d			;6d1c	72 	r 
l6d1dh:
	jr nc,l6d2fh		;6d1d	30 10 	0 . 
	ld c,b			;6d1f	48 	H 
	ld (hl),h			;6d20	74 	t 
	jr z,$+45		;6d21	28 2b 	( + 
	ld c,c			;6d23	49 	I 
	ld a,d			;6d24	7a 	z 
	rst 38h			;6d25	ff 	. 
l6d26h:
	jr nz,$+18		;6d26	20 10 	  . 
	ld c,b			;6d28	48 	H 
	dec h			;6d29	25 	% 
	jr nc,l6d3ch		;6d2a	30 10 	0 . 
	ld c,c			;6d2c	49 	I 
	ld h,014h		;6d2d	26 14 	& . 
l6d2fh:
	jr z,l6d3ah		;6d2f	28 09 	( . 
	call m,0201ah		;6d31	fc 1a 20 	. .   
	ld c,c			;6d34	49 	I 
	daa			;6d35	27 	' 
	ld hl,(l4920h)		;6d36	2a 20 49 	*   I 
	ld a,h			;6d39	7c 	| 
l6d3ah:
	rst 38h			;6d3a	ff 	. 
	add hl,hl			;6d3b	29 	) 
l6d3ch:
	inc a			;6d3c	3c 	< 
	ld c,c			;6d3d	49 	I 
	rrca			;6d3e	0f 	. 
	dec e			;6d3f	1d 	. 
	djnz $+74		;6d40	10 48 	. H 
	ld a,(hl)			;6d42	7e 	~ 
	dec l			;6d43	2d 	- 
	djnz $+10		;6d44	10 08 	. . 
	jp c,0401dh		;6d46	da 1d 40 	. . @ 
	ld c,c			;6d49	49 	I 
	inc de			;6d4a	13 	. 
	dec h			;6d4b	25 	% 
	ld hl,(0dc09h)		;6d4c	2a 09 dc 	* . . 
	rst 38h			;6d4f	ff 	. 
	dec hl			;6d50	2b 	+ 
	dec hl			;6d51	2b 	+ 
	ld c,c			;6d52	49 	I 
	rrca			;6d53	0f 	. 
	inc e			;6d54	1c 	. 
	djnz l6d9fh		;6d55	10 48 	. H 
	inc d			;6d57	14 	. 
	inc l			;6d58	2c 	, 
	djnz $+75		;6d59	10 49 	. I 
	dec d			;6d5b	15 	. 
	inc e			;6d5c	1c 	. 
l6d5dh:
	inc l			;6d5d	2c 	, 
	ld c,c			;6d5e	49 	I 
	ld d,028h		;6d5f	16 28 	. ( 
	jr nz,l6d6ch		;6d61	20 09 	  . 
	sbc a,0ffh		;6d63	de ff 	. . 
	daa			;6d65	27 	' 
	ld b,b			;6d66	40 	@ 
	ld c,c			;6d67	49 	I 
	rrca			;6d68	0f 	. 
	inc hl			;6d69	23 	# 
	djnz l6d74h		;6d6a	10 08 	. . 
l6d6ch:
	ret po			;6d6c	e0 	. 
	inc sp			;6d6d	33 	3 
	djnz l6d79h		;6d6e	10 09 	. . 
	jp po,03025h		;6d70	e2 25 30 	. % 0 
	add hl,bc			;6d73	09 	. 
l6d74h:
	call po,03835h		;6d74	e4 35 38 	. 5 8 
	ld c,c			;6d77	49 	I 
	rla			;6d78	17 	. 
l6d79h:
	ld b,l			;6d79	45 	E 
	jr c,l6dc5h		;6d7a	38 49 	8 I 
	jr $+1		;6d7c	18 ff 	. . 
	inc e			;6d7e	1c 	. 
	ex af,af'			;6d7f	08 	. 
	ex af,af'			;6d80	08 	. 
	and 01ch		;6d81	e6 1c 	. . 
	jr z,$+75		;6d83	28 49 	( I 
	add hl,de			;6d85	19 	. 
	inc l			;6d86	2c 	, 
	djnz $+75		;6d87	10 49 	. I 
	call c,0303ch		;6d89	dc 3c 30 	. < 0 
	ld c,c			;6d8c	49 	I 
	ld a,(de)			;6d8d	1a 	. 
	ld c,e			;6d8e	4b 	K 
	jr nc,l6ddah		;6d8f	30 49 	0 I 
	dec de			;6d91	1b 	. 
	rst 38h			;6d92	ff 	. 
	ld hl,(0492bh)		;6d93	2a 2b 49 	* + I 
	rrca			;6d96	0f 	. 
	rra			;6d97	1f 	. 
	djnz l6de2h		;6d98	10 48 	. H 
	inc e			;6d9a	1c 	. 
	cpl			;6d9b	2f 	/ 
	djnz $+11		;6d9c	10 09 	. . 
	ret pe			;6d9e	e8 	. 
l6d9fh:
	ld h,020h		;6d9f	26 20 	&   
	ld c,c			;6da1	49 	I 
	dec e			;6da2	1d 	. 
	ld a,020h		;6da3	3e 20 	>   
	ld c,c			;6da5	49 	I 
	ld e,04eh		;6da6	1e 4e 	. N 
	jr nz,l6df3h		;6da8	20 49 	  I 
	rra			;6daa	1f 	. 
	rst 38h			;6dab	ff 	. 
	jr l6de6h		;6dac	18 38 	. 8 
	add hl,bc			;6dae	09 	. 
	jp pe,03018h		;6daf	ea 18 30 	. . 0 
	ld c,b			;6db2	48 	H 
	jr nz,l6ddah		;6db3	20 25 	  % 
	djnz l6dbfh		;6db5	10 08 	. . 
	call pe,02828h		;6db7	ec 28 28 	. ( ( 
	add hl,bc			;6dba	09 	. 
	xor 028h		;6dbb	ee 28 	. ( 
	ld c,b			;6dbd	48 	H 
	ld c,c			;6dbe	49 	I 
l6dbfh:
	ld hl,03c2bh		;6dbf	21 2b 3c 	! + < 
	ld b,a			;6dc2	47 	G 
	inc c			;6dc3	0c 	. 
	rst 38h			;6dc4	ff 	. 
l6dc5h:
	rrca			;6dc5	0f 	. 
	ld c,b			;6dc6	48 	H 
	add hl,bc			;6dc7	09 	. 
	ret p			;6dc8	f0 	. 
	rla			;6dc9	17 	. 
	jr c,l6e15h		;6dca	38 49 	8 I 
	ld (01027h),hl		;6dcc	22 27 10 	" ' . 
	ex af,af'			;6dcf	08 	. 
	jp p,02e27h		;6dd0	f2 27 2e 	. ' . 
	add hl,bc			;6dd3	09 	. 
	call p,02b2dh		;6dd4	f4 2d 2b 	. - + 
	ld b,a			;6dd7	47 	G 
	rlca			;6dd8	07 	. 
	rst 38h			;6dd9	ff 	. 
l6ddah:
	ld (de),a			;6dda	12 	. 
	ccf			;6ddb	3f 	? 
	add hl,bc			;6ddc	09 	. 
	or 016h		;6ddd	f6 16 	. . 
	jr c,$+75		;6ddf	38 49 	8 I 
	inc hl			;6de1	23 	# 
l6de2h:
	ld h,030h		;6de2	26 30 	& 0 
	add hl,bc			;6de4	09 	. 
	ret m			;6de5	f8 	. 
l6de6h:
	jr z,l6e10h		;6de6	28 28 	( ( 
	ld c,c			;6de8	49 	I 
	inc h			;6de9	24 	$ 
	dec h			;6dea	25 	% 
	djnz l6df5h		;6deb	10 08 	. . 
	jp m,00e2ch		;6ded	fa 2c 0e 	. , . 
	ld b,a			;6df0	47 	G 
	inc c			;6df1	0c 	. 
	rst 38h			;6df2	ff 	. 
l6df3h:
	jr nz,l6e05h		;6df3	20 10 	  . 
l6df5h:
	ld c,b			;6df5	48 	H 
	dec h			;6df6	25 	% 
	jr nc,l6e09h		;6df7	30 10 	0 . 
	ld c,c			;6df9	49 	I 
	ld h,014h		;6dfa	26 14 	& . 
	jr z,$+11		;6dfc	28 09 	( . 
	call m,0201ah		;6dfe	fc 1a 20 	. .   
	ld c,c			;6e01	49 	I 
	daa			;6e02	27 	' 
	jr z,l6e25h		;6e03	28 20 	(   
l6e05h:
	add hl,bc			;6e05	09 	. 
	cp 02dh		;6e06	fe 2d 	. - 
	dec hl			;6e08	2b 	+ 
l6e09h:
	ld b,a			;6e09	47 	G 
	inc c			;6e0a	0c 	. 
	rst 38h			;6e0b	ff 	. 
	jr nz,$+18		;6e0c	20 10 	  . 
	ld c,b			;6e0e	48 	H 
	dec h			;6e0f	25 	% 
l6e10h:
	jr nc,l6e22h		;6e10	30 10 	0 . 
	ld c,c			;6e12	49 	I 
l6e13h:
	ld h,014h		;6e13	26 14 	& . 
l6e15h:
	jr z,l6e20h		;6e15	28 09 	( . 
	call m,0201ah		;6e17	fc 1a 20 	. .   
	ld c,c			;6e1a	49 	I 
	daa			;6e1b	27 	' 
	ld hl,(00920h)		;6e1c	2a 20 09 	*   . 
	ld h,b			;6e1f	60 	` 
l6e20h:
	inc sp			;6e20	33 	3 
	dec c			;6e21	0d 	. 
l6e22h:
	ld b,a			;6e22	47 	G 
	inc c			;6e23	0c 	. 
	rst 38h			;6e24	ff 	. 
l6e25h:
	ld h,010h		;6e25	26 10 	& . 
	add hl,bc			;6e27	09 	. 
	ld h,d			;6e28	62 	b 
l6e29h:
	jr nc,$+26		;6e29	30 18 	0 . 
	add hl,bc			;6e2b	09 	. 
	ld h,h			;6e2c	64 	d 
	jr nz,l6e5fh		;6e2d	20 30 	  0 
	ex af,af'			;6e2f	08 	. 
	ld h,(hl)			;6e30	66 	f 
	inc l			;6e31	2c 	, 
	jr c,l6e3dh		;6e32	38 09 	8 . 
	ld l,b			;6e34	68 	h 
	rst 38h			;6e35	ff 	. 
	rla			;6e36	17 	. 
	jr z,$+11		;6e37	28 09 	( . 
	ld l,d			;6e39	6a 	j 
	rra			;6e3a	1f 	. 
	jr $+75		;6e3b	18 49 	. I 
l6e3dh:
	ret po			;6e3d	e0 	. 
	cpl			;6e3e	2f 	/ 
	djnz $+75		;6e3f	10 49 	. I 
	call po,020ffh		;6e41	e4 ff 20 	. .   
	ld de,l6c08h		;6e44	11 08 6c 	. . l 
	rra			;6e47	1f 	. 
	ld sp,02849h		;6e48	31 49 28 	1 I ( 
	ld (04941h),hl		;6e4b	22 41 49 	" A I 
	add hl,hl			;6e4e	29 	) 
	cpl			;6e4f	2f 	/ 
	dec d			;6e50	15 	. 
	add hl,bc			;6e51	09 	. 
l6e52h:
	ld l,(hl)			;6e52	6e 	n 
	cpl			;6e53	2f 	/ 
	dec (hl)			;6e54	35 	5 
	ld c,c			;6e55	49 	I 
l6e56h:
	ld hl,(017ffh)		;6e56	2a ff 17 	* . . 
	ld (l6a09h),hl		;6e59	22 09 6a 	" . j 
	rra			;6e5c	1f 	. 
	ld (de),a			;6e5d	12 	. 
	ld c,c			;6e5e	49 	I 
l6e5fh:
	ret po			;6e5f	e0 	. 
	cpl			;6e60	2f 	/ 
	ld a,(bc)			;6e61	0a 	. 
l6e62h:
	ld c,c			;6e62	49 	I 
	call po,sub_7dffh		;6e63	e4 ff 7d 	. . } 
	ld l,(hl)			;6e66	6e 	n 
	sub d			;6e67	92 	. 
	ld l,(hl)			;6e68	6e 	n 
	and e			;6e69	a3 	. 
	ld l,(hl)			;6e6a	6e 	n 
	sub d			;6e6b	92 	. 
	ld l,(hl)			;6e6c	6e 	n 
	cp b			;6e6d	b8 	. 
	ld l,(hl)			;6e6e	6e 	n 
l6e6fh:
	call 07d6eh		;6e6f	cd 6e 7d 	. n } 
	ld l,(hl)			;6e72	6e 	n 
l6e73h:
	jp pe,0ff6eh		;6e73	ea 6e ff 	. n . 
	ld l,(hl)			;6e76	6e 	n 
l6e77h:
	ld a,l			;6e77	7d 	} 
	ld l,(hl)			;6e78	6e 	n 
	jr l6eeah		;6e79	18 6f 	. o 
	ld sp,0286fh		;6e7b	31 6f 28 	1 o ( 
	ld c,b			;6e7e	48 	H 
l6e7fh:
	adc a,(hl)			;6e7f	8e 	. 
	jr nz,l6eabh		;6e80	20 29 	  ) 
	jr nc,l6e13h		;6e82	30 8f 	0 . 
l6e84h:
	ld (0382bh),hl		;6e84	22 2b 38 	" + 8 
	adc a,(hl)			;6e87	8e 	. 
l6e88h:
	ld bc,01021h		;6e88	01 21 10 	. ! . 
	adc a,a			;6e8b	8f 	. 
l6e8ch:
	inc h			;6e8c	24 	$ 
	ld sp,08f10h		;6e8d	31 10 8f 	1 . . 
	ld h,0ffh		;6e90	26 ff 	& . 
	jr z,l6edch		;6e92	28 48 	( H 
l6e94h:
	adc a,(hl)			;6e94	8e 	. 
	jr z,l6ebfh		;6e95	28 28 	( ( 
	jr nc,l6e29h		;6e97	30 90 	0 . 
	ld hl,(01028h)		;6e99	2a 28 10 	* ( . 
	adc a,a			;6e9c	8f 	. 
l6e9dh:
	inc l			;6e9d	2c 	, 
	jr $+18		;6e9e	18 10 	. . 
	adc a,a			;6ea0	8f 	. 
l6ea1h:
	ld (bc),a			;6ea1	02 	. 
	rst 38h			;6ea2	ff 	. 
	jr z,l6eedh		;6ea3	28 48 	( H 
	adc a,(hl)			;6ea5	8e 	. 
	ld l,028h		;6ea6	2e 28 	. ( 
	jr c,$-112		;6ea8	38 8e 	8 . 
	inc bc			;6eaa	03 	. 
l6eabh:
	dec hl			;6eab	2b 	+ 
	jr nc,l6e3dh		;6eac	30 8f 	0 . 
	inc b			;6eae	04 	. 
	ld hl,08f10h		;6eaf	21 10 8f 	! . . 
	jr nc,$+51		;6eb2	30 31 	0 1 
	djnz $-111		;6eb4	10 8f 	. . 
	ld (02cffh),a		;6eb6	32 ff 2c 	2 . , 
	ld b,b			;6eb9	40 	@ 
	adc a,(hl)			;6eba	8e 	. 
	inc (hl)			;6ebb	34 	4 
	ld h,030h		;6ebc	26 30 	& 0 
	adc a,(hl)			;6ebe	8e 	. 
l6ebfh:
	ld (hl),028h		;6ebf	36 28 	6 ( 
	jr nc,l6e52h		;6ec1	30 8f 	0 . 
	dec b			;6ec3	05 	. 
	dec e			;6ec4	1d 	. 
	djnz l6e56h		;6ec5	10 8f 	. . 
	jr c,l6ef6h		;6ec7	38 2d 	8 - 
	djnz $-111		;6ec9	10 8f 	. . 
	ld a,(02bffh)		;6ecb	3a ff 2b 	: . + 
	ld d,b			;6ece	50 	P 
	adc a,(hl)			;6ecf	8e 	. 
	ld b,023h		;6ed0	06 23 	. # 
	jr nc,l6e62h		;6ed2	30 8e 	0 . 
	inc a			;6ed4	3c 	< 
	ld (08e40h),a		;6ed5	32 40 8e 	2 @ . 
	rlca			;6ed8	07 	. 
	ccf			;6ed9	3f 	? 
	ld b,b			;6eda	40 	@ 
	adc a,(hl)			;6edb	8e 	. 
l6edch:
	ex af,af'			;6edc	08 	. 
	add hl,hl			;6edd	29 	) 
	jr nc,l6e6fh		;6ede	30 8f 	0 . 
	ld a,(bc)			;6ee0	0a 	. 
	dec de			;6ee1	1b 	. 
	djnz l6e73h		;6ee2	10 8f 	. . 
	ld a,02bh		;6ee4	3e 2b 	> + 
	djnz l6e77h		;6ee6	10 8f 	. . 
	ld b,b			;6ee8	40 	@ 
	rst 38h			;6ee9	ff 	. 
l6eeah:
	add hl,hl			;6eea	29 	) 
	ld b,b			;6eeb	40 	@ 
	adc a,(hl)			;6eec	8e 	. 
l6eedh:
	ld b,d			;6eed	42 	B 
	inc h			;6eee	24 	$ 
	jr nc,l6e7fh		;6eef	30 8e 	0 . 
	ld b,h			;6ef1	44 	D 
	daa			;6ef2	27 	' 
	jr nc,l6e84h		;6ef3	30 8f 	0 . 
	add hl,bc			;6ef5	09 	. 
l6ef6h:
	inc e			;6ef6	1c 	. 
	djnz l6e88h		;6ef7	10 8f 	. . 
	ld b,(hl)			;6ef9	46 	F 
	inc l			;6efa	2c 	, 
	djnz l6e8ch		;6efb	10 8f 	. . 
	ld c,b			;6efd	48 	H 
	rst 38h			;6efe	ff 	. 
	add hl,hl			;6eff	29 	) 
	ld b,b			;6f00	40 	@ 
	adc a,(hl)			;6f01	8e 	. 
	ld c,d			;6f02	4a 	J 
	inc hl			;6f03	23 	# 
	jr nc,l6e94h		;6f04	30 8e 	0 . 
	ld c,h			;6f06	4c 	L 
	ld hl,08f10h		;6f07	21 10 8f 	! . . 
	ld c,(hl)			;6f0a	4e 	N 
	add hl,hl			;6f0b	29 	) 
	jr nz,l6e9dh		;6f0c	20 8f 	  . 
	ld d,b			;6f0e	50 	P 
	add hl,sp			;6f0f	39 	9 
	jr nc,l6ea1h		;6f10	30 8f 	0 . 
	dec bc			;6f12	0b 	. 
	ld c,c			;6f13	49 	I 
	ld sp,00c8fh		;6f14	31 8f 0c 	1 . . 
	rst 38h			;6f17	ff 	. 
	dec hl			;6f18	2b 	+ 
	ld b,l			;6f19	45 	E 
	adc a,(hl)			;6f1a	8e 	. 
l6f1bh:
	ld d,d			;6f1b	52 	R 
	inc hl			;6f1c	23 	# 
	inc sp			;6f1d	33 	3 
	sub b			;6f1e	90 	. 
l6f1fh:
	ld d,h			;6f1f	54 	T 
	inc l			;6f20	2c 	, 
	ld l,090h		;6f21	2e 90 	. . 
	ld d,(hl)			;6f23	56 	V 
l6f24h:
	dec h			;6f24	25 	% 
	dec l			;6f25	2d 	- 
	adc a,a			;6f26	8f 	. 
	dec c			;6f27	0d 	. 
	inc l			;6f28	2c 	, 
	ld c,08fh		;6f29	0e 8f 	. . 
	ld e,b			;6f2b	58 	X 
	inc a			;6f2c	3c 	< 
	dec d			;6f2d	15 	. 
	adc a,a			;6f2e	8f 	. 
	ld e,d			;6f2f	5a 	Z 
	rst 38h			;6f30	ff 	. 
	dec hl			;6f31	2b 	+ 
	inc a			;6f32	3c 	< 
	adc a,(hl)			;6f33	8e 	. 
	ld e,h			;6f34	5c 	\ 
	add hl,hl			;6f35	29 	) 
	dec e			;6f36	1d 	. 
	adc a,a			;6f37	8f 	. 
	ld e,(hl)			;6f38	5e 	^ 
	dec de			;6f39	1b 	. 
	inc e			;6f3a	1c 	. 
	ld c,(hl)			;6f3b	4e 	N 
	and (hl)			;6f3c	a6 	. 
	add hl,sp			;6f3d	39 	9 
	inc c			;6f3e	0c 	. 
	ld c,a			;6f3f	4f 	O 
	xor d			;6f40	aa 	. 
	ld b,a			;6f41	47 	G 
	inc e			;6f42	1c 	. 
	adc a,a			;6f43	8f 	. 
	add a,b			;6f44	80 	. 
l6f45h:
	dec hl			;6f45	2b 	+ 
l6f46h:
	ld c,h			;6f46	4c 	L 
	adc a,a			;6f47	8f 	. 
	rrca			;6f48	0f 	. 
	add hl,hl			;6f49	29 	) 
	dec l			;6f4a	2d 	- 
	adc a,(hl)			;6f4b	8e 	. 
	ld c,0ffh		;6f4c	0e ff 	. . 
l6f4eh:
	ld l,b			;6f4e	68 	h 
	ld l,a			;6f4f	6f 	o 
	ld a,l			;6f50	7d 	} 
	ld l,a			;6f51	6f 	o 
l6f52h:
	sub d			;6f52	92 	. 
	ld l,a			;6f53	6f 	o 
	ld a,l			;6f54	7d 	} 
	ld l,a			;6f55	6f 	o 
	ei			;6f56	fb 	. 
	ld l,a			;6f57	6f 	o 
	inc c			;6f58	0c 	. 
	ld (hl),b			;6f59	70 	p 
	xor 06fh		;6f5a	ee 6f 	. o 
	dec e			;6f5c	1d 	. 
	ld (hl),b			;6f5d	70 	p 
	ld (0c070h),a		;6f5e	32 70 c0 	2 p . 
	ld l,a			;6f61	6f 	o 
	exx			;6f62	d9 	. 
	ld l,a			;6f63	6f 	o 
	sub d			;6f64	92 	. 
	ld l,a			;6f65	6f 	o 
	xor e			;6f66	ab 	. 
l6f67h:
	ld l,a			;6f67	6f 	o 
	dec e			;6f68	1d 	. 
	ld c,b			;6f69	48 	H 
	add a,e			;6f6a	83 	. 
l6f6bh:
	ret pe			;6f6b	e8 	. 
	jr z,l6faeh		;6f6c	28 40 	( @ 
	add a,a			;6f6e	87 	. 
	dec d			;6f6f	15 	. 
	ld hl,05310h		;6f70	21 10 53 	! . S 
l6f73h:
	sbc a,h			;6f73	9c 	. 
	ld sp,09320h		;6f74	31 20 93 	1   . 
l6f77h:
	sbc a,d			;6f77	9a 	. 
	ld sp,09410h		;6f78	31 10 94 	1 . . 
	sbc a,h			;6f7b	9c 	. 
l6f7ch:
	rst 38h			;6f7c	ff 	. 
	dec e			;6f7d	1d 	. 
	ld c,b			;6f7e	48 	H 
	add a,e			;6f7f	83 	. 
l6f80h:
	ret pe			;6f80	e8 	. 
	jr z,l6fc3h		;6f81	28 40 	( @ 
	add a,a			;6f83	87 	. 
	dec d			;6f84	15 	. 
	rra			;6f85	1f 	. 
	jr nc,l6f1bh		;6f86	30 93 	0 . 
	sbc a,(hl)			;6f88	9e 	. 
	cpl			;6f89	2f 	/ 
	jr nz,l6f1fh		;6f8a	20 93 	  . 
	and b			;6f8c	a0 	. 
	daa			;6f8d	27 	' 
	djnz l6f24h		;6f8e	10 94 	. . 
	and d			;6f90	a2 	. 
	rst 38h			;6f91	ff 	. 
	dec e			;6f92	1d 	. 
	ld c,b			;6f93	48 	H 
	add a,e			;6f94	83 	. 
	ret pe			;6f95	e8 	. 
	jr z,l6fd8h		;6f96	28 40 	( @ 
	add a,a			;6f98	87 	. 
	dec d			;6f99	15 	. 
	ld hl,09330h		;6f9a	21 30 93 	! 0 . 
	and h			;6f9d	a4 	. 
	ld sp,09320h		;6f9e	31 20 93 	1   . 
	and (hl)			;6fa1	a6 	. 
	ld h,010h		;6fa2	26 10 	& . 
	sub h			;6fa4	94 	. 
	xor b			;6fa5	a8 	. 
	ld (hl),010h		;6fa6	36 10 	6 . 
	sub h			;6fa8	94 	. 
	ld d,0ffh		;6fa9	16 ff 	. . 
	add hl,hl			;6fab	29 	) 
	ccf			;6fac	3f 	? 
	add a,a			;6fad	87 	. 
l6faeh:
	dec d			;6fae	15 	. 
	inc h			;6faf	24 	$ 
	jr nc,l6f45h		;6fb0	30 93 	0 . 
	jr $+53		;6fb2	18 33 	. 3 
	ld sp,01793h		;6fb4	31 93 17 	1 . . 
	inc h			;6fb7	24 	$ 
	djnz l6f4eh		;6fb8	10 94 	. . 
	xor d			;6fba	aa 	. 
	inc (hl)			;6fbb	34 	4 
	djnz l6f52h		;6fbc	10 94 	. . 
	xor h			;6fbe	ac 	. 
	rst 38h			;6fbf	ff 	. 
	inc de			;6fc0	13 	. 
	jr z,l6f46h		;6fc1	28 83 	( . 
l6fc3h:
	jp (hl)			;6fc3	e9 	. 
l6fc4h:
	ld hl,(08737h)		;6fc4	2a 37 87 	* 7 . 
	dec d			;6fc7	15 	. 
	jr nz,$+43		;6fc8	20 29 	  ) 
	sub e			;6fca	93 	. 
	add hl,de			;6fcb	19 	. 
	jr nc,$+27		;6fcc	30 19 	0 . 
	sub e			;6fce	93 	. 
	xor (hl)			;6fcf	ae 	. 
	dec h			;6fd0	25 	% 
	djnz l6f67h		;6fd1	10 94 	. . 
	or b			;6fd3	b0 	. 
	dec (hl)			;6fd4	35 	5 
	djnz l6f6bh		;6fd5	10 94 	. . 
	ld a,(de)			;6fd7	1a 	. 
l6fd8h:
	rst 38h			;6fd8	ff 	. 
l6fd9h:
	ld hl,(08737h)		;6fd9	2a 37 87 	* 7 . 
	dec d			;6fdc	15 	. 
	inc h			;6fdd	24 	$ 
	jr z,l6f73h		;6fde	28 93 	( . 
	dec de			;6fe0	1b 	. 
	inc (hl)			;6fe1	34 	4 
	jr l6f77h		;6fe2	18 93 	. . 
	or d			;6fe4	b2 	. 
	inc hl			;6fe5	23 	# 
	djnz l6f7ch		;6fe6	10 94 	. . 
	or h			;6fe8	b4 	. 
	inc sp			;6fe9	33 	3 
	djnz l6f80h		;6fea	10 94 	. . 
	or (hl)			;6fec	b6 	. 
	rst 38h			;6fed	ff 	. 
	jr z,l701bh		;6fee	28 2b 	( + 
	sub e			;6ff0	93 	. 
	cp b			;6ff1	b8 	. 
	jr z,$+42		;6ff2	28 28 	( ( 
	sub e			;6ff4	93 	. 
	inc e			;6ff5	1c 	. 
	jr z,$+18		;6ff6	28 10 	( . 
	sub h			;6ff8	94 	. 
	cp d			;6ff9	ba 	. 
	rst 38h			;6ffa	ff 	. 
	jr z,$+64		;6ffb	28 3e 	( > 
	add a,a			;6ffd	87 	. 
	dec e			;6ffe	1d 	. 
	inc h			;6fff	24 	$ 
	ld e,093h		;7000	1e 93 	. . 
	cp h			;7002	bc 	. 
	jr z,$+18		;7003	28 10 	( . 
	sub h			;7005	94 	. 
	cp (hl)			;7006	be 	. 
	ld sp,0930bh		;7007	31 0b 93 	1 . . 
	ld e,0ffh		;700a	1e ff 	. . 
	dec hl			;700c	2b 	+ 
	dec sp			;700d	3b 	; 
	add a,a			;700e	87 	. 
	rra			;700f	1f 	. 
	ld hl,09328h		;7010	21 28 93 	! ( . 
	ret nz			;7013	c0 	. 
	ld sp,0932bh		;7014	31 2b 93 	1 + . 
	jp nz,01024h		;7017	c2 24 10 	. $ . 
	sub h			;701a	94 	. 
l701bh:
	call nz,026ffh		;701b	c4 ff 26 	. . & 
	dec (hl)			;701e	35 	5 
	add a,a			;701f	87 	. 
	ret po			;7020	e0 	. 
	jr nz,l703ch		;7021	20 19 	  . 
	sub e			;7023	93 	. 
	add a,030h		;7024	c6 30 	. 0 
	add hl,hl			;7026	29 	) 
	sub e			;7027	93 	. 
	pop hl			;7028	e1 	. 
	dec hl			;7029	2b 	+ 
	inc de			;702a	13 	. 
	sub h			;702b	94 	. 
	ret z			;702c	c8 	. 
	dec sp			;702d	3b 	; 
	djnz l6fc4h		;702e	10 94 	. . 
	jp z,018ffh		;7030	ca ff 18 	. . . 
	ld hl,(0e287h)		;7033	2a 87 e2 	* . . 
	jr nz,l704ch		;7036	20 14 	  . 
	sub e			;7038	93 	. 
	call z,0312ch		;7039	cc 2c 31 	. , 1 
l703ch:
	sub e			;703c	93 	. 
	adc a,02ch		;703d	ce 2c 	. , 
	inc de			;703f	13 	. 
	sub h			;7040	94 	. 
	ret nc			;7041	d0 	. 
	inc a			;7042	3c 	< 
	djnz l6fd9h		;7043	10 94 	. . 
	jp nc,0bbffh		;7045	d2 ff bb 	. . . 
	ld (hl),b			;7048	70 	p 
	xor d			;7049	aa 	. 
	ld (hl),b			;704a	70 	p 
	sub l			;704b	95 	. 
l704ch:
	ld (hl),b			;704c	70 	p 
	xor d			;704d	aa 	. 
	ld (hl),b			;704e	70 	p 
	ret nc			;704f	d0 	. 
	ld (hl),b			;7050	70 	p 
	jp (hl)			;7051	e9 	. 
	ld (hl),b			;7052	70 	p 
	ld (bc),a			;7053	02 	. 
	ld (hl),c			;7054	71 	q 
	dec de			;7055	1b 	. 
	ld (hl),c			;7056	71 	q 
	cp e			;7057	bb 	. 
	ld (hl),c			;7058	71 	q 
	ret nc			;7059	d0 	. 
	ld (hl),c			;705a	71 	q 
	push hl			;705b	e5 	. 
	ld (hl),c			;705c	71 	q 
	adc a,e			;705d	8b 	. 
	ld (hl),c			;705e	71 	q 
	ld (hl),b			;705f	70 	p 
	ld (hl),c			;7060	71 	q 
	ld a,c			;7061	79 	y 
	ld (hl),c			;7062	71 	q 
	add a,d			;7063	82 	. 
	ld (hl),c			;7064	71 	q 
	dec c			;7065	0d 	. 
	ld (hl),l			;7066	75 	u 
	ld (de),a			;7067	12 	. 
	ld (hl),l			;7068	75 	u 
	dec de			;7069	1b 	. 
	ld (hl),l			;706a	75 	u 
	dec l			;706b	2d 	- 
	ld (hl),l			;706c	75 	u 
	add a,d			;706d	82 	. 
	ld (hl),c			;706e	71 	q 
	ld a,c			;706f	79 	y 
	ld (hl),c			;7070	71 	q 
	ld (hl),b			;7071	70 	p 
	ld (hl),c			;7072	71 	q 
	adc a,e			;7073	8b 	. 
	ld (hl),c			;7074	71 	q 
	sub h			;7075	94 	. 
	ld (hl),c			;7076	71 	q 
l7077h:
	and c			;7077	a1 	. 
	ld (hl),c			;7078	71 	q 
	xor (hl)			;7079	ae 	. 
	ld (hl),c			;707a	71 	q 
	inc (hl)			;707b	34 	4 
	ld (hl),c			;707c	71 	q 
	ld c,c			;707d	49 	I 
	ld (hl),c			;707e	71 	q 
	ld d,(hl)			;707f	56 	V 
	ld (hl),c			;7080	71 	q 
	ld h,e			;7081	63 	c 
	ld (hl),c			;7082	71 	q 
	dec c			;7083	0d 	. 
	ld (hl),l			;7084	75 	u 
	ld (de),a			;7085	12 	. 
	ld (hl),l			;7086	75 	u 
	dec de			;7087	1b 	. 
l7088h:
	ld (hl),l			;7088	75 	u 
	dec l			;7089	2d 	- 
	ld (hl),l			;708a	75 	u 
	ld h,e			;708b	63 	c 
l708ch:
	ld (hl),c			;708c	71 	q 
	ld d,(hl)			;708d	56 	V 
	ld (hl),c			;708e	71 	q 
l708fh:
	ld c,c			;708f	49 	I 
	ld (hl),c			;7090	71 	q 
	inc (hl)			;7091	34 	4 
	ld (hl),c			;7092	71 	q 
	cp (hl)			;7093	be 	. 
l7094h:
	ld h,(hl)			;7094	66 	f 
	ld h,038h		;7095	26 38 	& 8 
	sub 000h		;7097	d6 00 	. . 
	ld e,020h		;7099	1e 20 	.   
	rst 10h			;709b	d7 	. 
	jr nz,$+48		;709c	20 2e 	  . 
	jr nz,l7077h		;709e	20 d7 	  . 
	ld (0101eh),hl		;70a0	22 1e 10 	" . . 
	sub 002h		;70a3	d6 02 	. . 
	ld l,010h		;70a5	2e 10 	. . 
	sub 003h		;70a7	d6 03 	. . 
l70a9h:
	rst 38h			;70a9	ff 	. 
	ld h,038h		;70aa	26 38 	& 8 
	sub 000h		;70ac	d6 00 	. . 
l70aeh:
	dec e			;70ae	1d 	. 
	jr nz,l7088h		;70af	20 d7 	  . 
l70b1h:
	inc h			;70b1	24 	$ 
	dec l			;70b2	2d 	- 
	jr nz,l708ch		;70b3	20 d7 	  . 
l70b5h:
	ld h,021h		;70b5	26 21 	& ! 
	djnz l708fh		;70b7	10 d6 	. . 
l70b9h:
	ld bc,026ffh		;70b9	01 ff 26 	. . & 
	jr c,l7094h		;70bc	38 d6 	8 . 
	nop			;70be	00 	. 
	ld e,020h		;70bf	1e 20 	.   
	rst 10h			;70c1	d7 	. 
	jr nz,l70f2h		;70c2	20 2e 	  . 
	jr nz,$-39		;70c4	20 d7 	  . 
	ld (0101eh),hl		;70c6	22 1e 10 	" . . 
	sub 028h		;70c9	d6 28 	. ( 
l70cbh:
	ld l,010h		;70cb	2e 10 	. . 
	sub 02ah		;70cd	d6 2a 	. * 
	rst 38h			;70cf	ff 	. 
	inc l			;70d0	2c 	, 
	jr c,l70a9h		;70d1	38 d6 	8 . 
	nop			;70d3	00 	. 
	inc h			;70d4	24 	$ 
	jr nz,l70aeh		;70d5	20 d7 	  . 
	inc l			;70d7	2c 	, 
	dec hl			;70d8	2b 	+ 
	jr nc,l70b1h		;70d9	30 d6 	0 . 
	ld l,034h		;70db	2e 34 	. 4 
	jr nz,l70b5h		;70dd	20 d6 	  . 
	dec b			;70df	05 	. 
l70e0h:
	inc e			;70e0	1c 	. 
	djnz l70b9h		;70e1	10 d6 	. . 
	ld a,(bc)			;70e3	0a 	. 
l70e4h:
	inc l			;70e4	2c 	, 
	djnz $-40		;70e5	10 d6 	. . 
l70e7h:
	rlca			;70e7	07 	. 
	rst 38h			;70e8	ff 	. 
	ld l,038h		;70e9	2e 38 	. 8 
l70ebh:
	sub 000h		;70eb	d6 00 	. . 
	inc hl			;70ed	23 	# 
	jr nz,$-39		;70ee	20 d7 	  . 
	jr nc,$+49		;70f0	30 2f 	0 / 
l70f2h:
	jr nz,l70cbh		;70f2	20 d7 	  . 
	ld (0303fh),a		;70f4	32 3f 30 	2 ? 0 
	sub 009h		;70f7	d6 09 	. . 
l70f9h:
	inc e			;70f9	1c 	. 
	djnz $-40		;70fa	10 d6 	. . 
	ld a,(bc)			;70fc	0a 	. 
l70fdh:
	inc l			;70fd	2c 	, 
	djnz $-40		;70fe	10 d6 	. . 
l7100h:
	rlca			;7100	07 	. 
	rst 38h			;7101	ff 	. 
	ld l,038h		;7102	2e 38 	. 8 
l7104h:
	sub 000h		;7104	d6 00 	. . 
	inc hl			;7106	23 	# 
	jr nz,l70e0h		;7107	20 d7 	  . 
	jr nc,$+49		;7109	30 2f 	0 / 
	jr nz,l70e4h		;710b	20 d7 	  . 
	inc (hl)			;710d	34 	4 
	ccf			;710e	3f 	? 
	jr z,l70e7h		;710f	28 d6 	( . 
	add hl,bc			;7111	09 	. 
	inc e			;7112	1c 	. 
	djnz l70ebh		;7113	10 d6 	. . 
	ld a,(bc)			;7115	0a 	. 
	inc l			;7116	2c 	, 
	djnz $-40		;7117	10 d6 	. . 
	rlca			;7119	07 	. 
	rst 38h			;711a	ff 	. 
	ld l,038h		;711b	2e 38 	. 8 
	sub 000h		;711d	d6 00 	. . 
	inc hl			;711f	23 	# 
	jr nz,l70f9h		;7120	20 d7 	  . 
	jr nc,$+49		;7122	30 2f 	0 / 
	jr nz,l70fdh		;7124	20 d7 	  . 
	ld (hl),03fh		;7126	36 3f 	6 ? 
	jr nz,l7100h		;7128	20 d6 	  . 
	inc c			;712a	0c 	. 
	inc e			;712b	1c 	. 
l712ch:
	djnz l7104h		;712c	10 d6 	. . 
	ld a,(bc)			;712e	0a 	. 
	inc l			;712f	2c 	, 
	djnz $-40		;7130	10 d6 	. . 
	rlca			;7132	07 	. 
	rst 38h			;7133	ff 	. 
	jr z,l716eh		;7134	28 38 	( 8 
	sub 000h		;7136	d6 00 	. . 
	ld (0d720h),hl		;7138	22 20 d7 	"   . 
	jr c,l716bh		;713b	38 2e 	8 . 
	ld (014d6h),a		;713d	32 d6 14 	2 . . 
	ld l,022h		;7140	2e 22 	. " 
	rst 10h			;7142	d7 	. 
	dec d			;7143	15 	. 
	ld h,010h		;7144	26 10 	& . 
l7146h:
	sub 013h		;7146	d6 13 	. . 
	rst 38h			;7148	ff 	. 
	ld e,028h		;7149	1e 28 	. ( 
	ret c			;714b	d8 	. 
	ld a,(0282eh)		;714c	3a 2e 28 	: . ( 
l714fh:
	ret c			;714f	d8 	. 
	inc a			;7150	3c 	< 
	inc h			;7151	24 	$ 
	djnz l712ch		;7152	10 d8 	. . 
	ld a,0ffh		;7154	3e ff 	> . 
	ld e,028h		;7156	1e 28 	. ( 
	ret c			;7158	d8 	. 
	ld b,b			;7159	40 	@ 
	ld l,028h		;715a	2e 28 	. ( 
	ret c			;715c	d8 	. 
	ld b,d			;715d	42 	B 
	inc h			;715e	24 	$ 
	djnz $-38		;715f	10 d8 	. . 
l7161h:
	ld b,h			;7161	44 	D 
	rst 38h			;7162	ff 	. 
	ld e,028h		;7163	1e 28 	. ( 
	ret c			;7165	d8 	. 
	ld b,(hl)			;7166	46 	F 
	ld l,028h		;7167	2e 28 	. ( 
	ret c			;7169	d8 	. 
	ld c,b			;716a	48 	H 
l716bh:
	inc h			;716b	24 	$ 
	djnz l7146h		;716c	10 d8 	. . 
l716eh:
	ld c,d			;716e	4a 	J 
	rst 38h			;716f	ff 	. 
	ld (0d830h),hl		;7170	22 30 d8 	" 0 . 
	ld d,022h		;7173	16 22 	. " 
	djnz l714fh		;7175	10 d8 	. . 
	ld c,h			;7177	4c 	L 
	rst 38h			;7178	ff 	. 
	ld (0d830h),hl		;7179	22 30 d8 	" 0 . 
	rla			;717c	17 	. 
	ld (0d810h),hl		;717d	22 10 d8 	" . . 
	ld c,(hl)			;7180	4e 	N 
	rst 38h			;7181	ff 	. 
	ld (0d830h),hl		;7182	22 30 d8 	" 0 . 
	jr l71a9h		;7185	18 22 	. " 
	djnz l7161h		;7187	10 d8 	. . 
	ld d,b			;7189	50 	P 
	rst 38h			;718a	ff 	. 
	ld (0d720h),hl		;718b	22 20 d7 	"   . 
	ld d,d			;718e	52 	R 
	ld (0d610h),hl		;718f	22 10 d6 	" . . 
	add hl,de			;7192	19 	. 
	rst 38h			;7193	ff 	. 
l7194h:
	dec h			;7194	25 	% 
	ld sp,01ad6h		;7195	31 d6 1a 	1 . . 
	ld (0d720h),hl		;7198	22 20 d7 	"   . 
	ld d,d			;719b	52 	R 
	ld (0d610h),hl		;719c	22 10 d6 	" . . 
	add hl,de			;719f	19 	. 
l71a0h:
	rst 38h			;71a0	ff 	. 
	daa			;71a1	27 	' 
	inc (hl)			;71a2	34 	4 
	sub 000h		;71a3	d6 00 	. . 
	ld (0d720h),hl		;71a5	22 20 d7 	"   . 
	ld d,d			;71a8	52 	R 
l71a9h:
	ld (0d610h),hl		;71a9	22 10 d6 	" . . 
	add hl,de			;71ac	19 	. 
	rst 38h			;71ad	ff 	. 
l71aeh:
	jr z,$+58		;71ae	28 38 	( 8 
	sub 000h		;71b0	d6 00 	. . 
	ld (0d720h),hl		;71b2	22 20 d7 	"   . 
l71b5h:
	ld d,d			;71b5	52 	R 
	ld (0d610h),hl		;71b6	22 10 d6 	" . . 
l71b9h:
	add hl,de			;71b9	19 	. 
	rst 38h			;71ba	ff 	. 
	daa			;71bb	27 	' 
	jr c,l7194h		;71bc	38 d6 	8 . 
	dec de			;71be	1b 	. 
	inc hl			;71bf	23 	# 
	jr nz,$-39		;71c0	20 d7 	  . 
	ld d,h			;71c2	54 	T 
	inc sp			;71c3	33 	3 
	jr nz,$-39		;71c4	20 d7 	  . 
	inc e			;71c6	1c 	. 
	add hl,hl			;71c7	29 	) 
	djnz l71a0h		;71c8	10 d6 	. . 
	dec e			;71ca	1d 	. 
	ld hl,(0d827h)		;71cb	2a 27 d8 	* ' . 
	ld e,0ffh		;71ce	1e ff 	. . 
	inc hl			;71d0	23 	# 
	jr nc,l71a9h		;71d1	30 d6 	0 . 
	rra			;71d3	1f 	. 
	inc e			;71d4	1c 	. 
	jr l71aeh		;71d5	18 d7 	. . 
	ld d,(hl)			;71d7	56 	V 
	add hl,hl			;71d8	29 	) 
	dec d			;71d9	15 	. 
	rst 10h			;71da	d7 	. 
	ld e,b			;71db	58 	X 
	add hl,sp			;71dc	39 	9 
	djnz l71b5h		;71dd	10 d6 	. . 
	ld e,d			;71df	5a 	Z 
	add hl,sp			;71e0	39 	9 
	jr z,l71b9h		;71e1	28 d6 	( . 
	ld h,b			;71e3	60 	` 
	rst 38h			;71e4	ff 	. 
	ld e,027h		;71e5	1e 27 	. ' 
	sub 061h		;71e7	d6 61 	. a 
	jr nz,l7201h		;71e9	20 16 	  . 
	rst 10h			;71eb	d7 	. 
	ld e,h			;71ec	5c 	\ 
	jr nc,l7202h		;71ed	30 13 	0 . 
	rst 10h			;71ef	d7 	. 
	ld e,(hl)			;71f0	5e 	^ 
	ld a,010h		;71f1	3e 10 	> . 
	sub 080h		;71f3	d6 80 	. . 
	ld l,030h		;71f5	2e 30 	. 0 
	sub 062h		;71f7	d6 62 	. b 
	rst 38h			;71f9	ff 	. 
	jr c,l726eh		;71fa	38 72 	8 r 
	ld c,l			;71fc	4d 	M 
	ld (hl),d			;71fd	72 	r 
	ld e,d			;71fe	5a 	Z 
	ld (hl),d			;71ff	72 	r 
	ld c,l			;7200	4d 	M 
l7201h:
	ld (hl),d			;7201	72 	r 
l7202h:
	ld l,e			;7202	6b 	k 
	ld (hl),d			;7203	72 	r 
	add a,b			;7204	80 	. 
	ld (hl),d			;7205	72 	r 
	ld l,e			;7206	6b 	k 
	ld (hl),d			;7207	72 	r 
	jp 0d872h		;7208	c3 72 d8 	. r . 
	ld (hl),d			;720b	72 	r 
	jp l6b72h		;720c	c3 72 6b 	. r k 
	ld (hl),d			;720f	72 	r 
	ld l,e			;7210	6b 	k 
	ld (hl),d			;7211	72 	r 
	sub l			;7212	95 	. 
	ld (hl),d			;7213	72 	r 
	xor d			;7214	aa 	. 
	ld (hl),d			;7215	72 	r 
	sub l			;7216	95 	. 
	ld (hl),d			;7217	72 	r 
l7218h:
	ld l,e			;7218	6b 	k 
	ld (hl),d			;7219	72 	r 
	sbc hl,sp		;721a	ed 72 	. r 
	cp 072h		;721c	fe 72 	. r 
	inc de			;721e	13 	. 
	ld (hl),e			;721f	73 	s 
	cp 072h		;7220	fe 72 	. r 
	sbc hl,sp		;7222	ed 72 	. r 
	ld b,(hl)			;7224	46 	F 
l7225h:
	ld (hl),e			;7225	73 	s 
	ld d,a			;7226	57 	W 
	ld (hl),e			;7227	73 	s 
	inc l			;7228	2c 	, 
	ld (hl),e			;7229	73 	s 
	add hl,sp			;722a	39 	9 
	ld (hl),e			;722b	73 	s 
	adc a,d			;722c	8a 	. 
	ld (hl),e			;722d	73 	s 
	ld l,b			;722e	68 	h 
	ld (hl),e			;722f	73 	s 
	ld (hl),l			;7230	75 	u 
	ld (hl),e			;7231	73 	s 
	sbc a,e			;7232	9b 	. 
	ld (hl),e			;7233	73 	s 
	xor h			;7234	ac 	. 
	ld (hl),e			;7235	73 	s 
	cp l			;7236	bd 	. 
	ld (hl),e			;7237	73 	s 
	ld h,047h		;7238	26 47 	& G 
	exx			;723a	d9 	. 
	ld l,b			;723b	68 	h 
	inc h			;723c	24 	$ 
	jr nc,l7218h		;723d	30 d9 	0 . 
l723fh:
	add a,d			;723f	82 	. 
	inc l			;7240	2c 	, 
	daa			;7241	27 	' 
	exx			;7242	d9 	. 
l7243h:
	ld l,c			;7243	69 	i 
	jr nz,$+18		;7244	20 10 	  . 
	jp c,03084h		;7246	da 84 30 	. . 0 
	djnz l7225h		;7249	10 da 	. . 
	add a,(hl)			;724b	86 	. 
	rst 38h			;724c	ff 	. 
	ld h,048h		;724d	26 48 	& H 
l724fh:
	exx			;724f	d9 	. 
	inc b			;7250	04 	. 
	ld h,028h		;7251	26 28 	& ( 
	exx			;7253	d9 	. 
	adc a,b			;7254	88 	. 
	ld h,010h		;7255	26 10 	& . 
	jp c,0ff8ah		;7257	da 8a ff 	. . . 
	ld h,047h		;725a	26 47 	& G 
	exx			;725c	d9 	. 
	inc b			;725d	04 	. 
	ld h,027h		;725e	26 27 	& ' 
l7260h:
	exx			;7260	d9 	. 
	adc a,h			;7261	8c 	. 
	dec e			;7262	1d 	. 
	djnz l723fh		;7263	10 da 	. . 
l7265h:
	adc a,(hl)			;7265	8e 	. 
	dec l			;7266	2d 	- 
	djnz l7243h		;7267	10 da 	. . 
l7269h:
	sub b			;7269	90 	. 
	rst 38h			;726a	ff 	. 
l726bh:
	dec h			;726b	25 	% 
	ld b,l			;726c	45 	E 
	exx			;726d	d9 	. 
l726eh:
	ld b,024h		;726e	06 24 	. $ 
	ld h,0d9h		;7270	26 d9 	& . 
	sub d			;7272	92 	. 
	inc (hl)			;7273	34 	4 
	jr nc,l724fh		;7274	30 d9 	0 . 
	sub h			;7276	94 	. 
	ld hl,0da10h		;7277	21 10 da 	! . . 
	sub (hl)			;727a	96 	. 
	ld sp,0da10h		;727b	31 10 da 	1 . . 
l727eh:
	sbc a,b			;727e	98 	. 
	rst 38h			;727f	ff 	. 
	dec h			;7280	25 	% 
	ld b,a			;7281	47 	G 
	exx			;7282	d9 	. 
	ld b,024h		;7283	06 24 	. $ 
	jr z,l7260h		;7285	28 d9 	( . 
	sbc a,d			;7287	9a 	. 
	inc h			;7288	24 	$ 
	djnz l7265h		;7289	10 da 	. . 
	sbc a,(hl)			;728b	9e 	. 
	inc (hl)			;728c	34 	4 
	djnz l7269h		;728d	10 da 	. . 
	dec bc			;728f	0b 	. 
	inc (hl)			;7290	34 	4 
	ld a,(09cd9h)		;7291	3a d9 9c 	: . . 
	rst 38h			;7294	ff 	. 
	inc hl			;7295	23 	# 
	ld b,a			;7296	47 	G 
	exx			;7297	d9 	. 
	inc b			;7298	04 	. 
	ld (0d927h),hl		;7299	22 27 d9 	" ' . 
	and b			;729c	a0 	. 
	ld (0d936h),a		;729d	32 36 d9 	2 6 . 
	ld h,a			;72a0	67 	g 
	inc e			;72a1	1c 	. 
	djnz l727eh		;72a2	10 da 	. . 
	and d			;72a4	a2 	. 
	inc l			;72a5	2c 	, 
	ld e,0dah		;72a6	1e da 	. . 
	and h			;72a8	a4 	. 
	rst 38h			;72a9	ff 	. 
	dec e			;72aa	1d 	. 
	ld c,b			;72ab	48 	H 
l72ach:
	exx			;72ac	d9 	. 
	ld b,01ch		;72ad	06 1c 	. . 
	jr z,$-37		;72af	28 d9 	( . 
	and (hl)			;72b1	a6 	. 
	inc l			;72b2	2c 	, 
	jr z,$-37		;72b3	28 d9 	( . 
	xor b			;72b5	a8 	. 
	ld a,(0da3ch)		;72b6	3a 3c da 	: < . 
	ld l,d			;72b9	6a 	j 
	ld c,d			;72ba	4a 	J 
	inc a			;72bb	3c 	< 
	jp c,01f6bh		;72bc	da 6b 1f 	. k . 
	djnz $-36		;72bf	10 da 	. . 
	xor d			;72c1	aa 	. 
	rst 38h			;72c2	ff 	. 
	dec h			;72c3	25 	% 
	ld b,(hl)			;72c4	46 	F 
	exx			;72c5	d9 	. 
	inc b			;72c6	04 	. 
	inc h			;72c7	24 	$ 
	ld h,0d9h		;72c8	26 d9 	& . 
	xor h			;72ca	ac 	. 
	inc (hl)			;72cb	34 	4 
	jr c,$-37		;72cc	38 d9 	8 . 
	ld l,h			;72ce	6c 	l 
	dec h			;72cf	25 	% 
	djnz l72ach		;72d0	10 da 	. . 
l72d2h:
	xor (hl)			;72d2	ae 	. 
	dec (hl)			;72d3	35 	5 
	djnz $-36		;72d4	10 da 	. . 
l72d6h:
	ld l,l			;72d6	6d 	m 
	rst 38h			;72d7	ff 	. 
	jr z,$+73		;72d8	28 47 	( G 
	exx			;72da	d9 	. 
	inc b			;72db	04 	. 
	ld h,027h		;72dc	26 27 	& ' 
	exx			;72de	d9 	. 
	or b			;72df	b0 	. 
	ld (hl),038h		;72e0	36 38 	6 8 
	exx			;72e2	d9 	. 
	ld l,(hl)			;72e3	6e 	n 
	ld hl,0da10h		;72e4	21 10 da 	! . . 
l72e7h:
	or d			;72e7	b2 	. 
	ld sp,0da10h		;72e8	31 10 da 	1 . . 
l72ebh:
	or h			;72eb	b4 	. 
	rst 38h			;72ec	ff 	. 
	inc e			;72ed	1c 	. 
	jr nz,$-37		;72ee	20 d9 	  . 
	or (hl)			;72f0	b6 	. 
	inc l			;72f1	2c 	, 
	jr nz,$-37		;72f2	20 d9 	  . 
	cp b			;72f4	b8 	. 
	inc e			;72f5	1c 	. 
	djnz l72d2h		;72f6	10 da 	. . 
	ld l,a			;72f8	6f 	o 
	inc l			;72f9	2c 	, 
	djnz l72d6h		;72fa	10 da 	. . 
l72fch:
	ld (hl),b			;72fc	70 	p 
	rst 38h			;72fd	ff 	. 
	ld hl,(0d930h)		;72fe	2a 30 d9 	* 0 . 
	ld (hl),c			;7301	71 	q 
	jr nz,l7320h		;7302	20 1c 	  . 
l7304h:
	exx			;7304	d9 	. 
	cp d			;7305	ba 	. 
	jr nc,l7322h		;7306	30 1a 	0 . 
	exx			;7308	d9 	. 
	cp h			;7309	bc 	. 
	rra			;730a	1f 	. 
	djnz l72e7h		;730b	10 da 	. . 
	ld (hl),d			;730d	72 	r 
	inc sp			;730e	33 	3 
	djnz l72ebh		;730f	10 da 	. . 
	ld (hl),e			;7311	73 	s 
	rst 38h			;7312	ff 	. 
	dec h			;7313	25 	% 
	inc l			;7314	2c 	, 
	exx			;7315	d9 	. 
	ld (hl),h			;7316	74 	t 
	rra			;7317	1f 	. 
	djnz $-37		;7318	10 d9 	. . 
	cp (hl)			;731a	be 	. 
	cpl			;731b	2f 	/ 
	djnz $-37		;731c	10 d9 	. . 
	ret nz			;731e	c0 	. 
	dec e			;731f	1d 	. 
l7320h:
	djnz l72fch		;7320	10 da 	. . 
l7322h:
	ld (hl),l			;7322	75 	u 
	dec a			;7323	3d 	= 
	djnz $-36		;7324	10 da 	. . 
	halt			;7326	76 	v 
	ld c,l			;7327	4d 	M 
	djnz l7304h		;7328	10 da 	. . 
	ld l,l			;732a	6d 	m 
	rst 38h			;732b	ff 	. 
	add hl,hl			;732c	29 	) 
	ld d,b			;732d	50 	P 
	exx			;732e	d9 	. 
l732fh:
	ld l,b			;732f	68 	h 
	dec h			;7330	25 	% 
	jr nc,$-37		;7331	30 d9 	0 . 
	jp nz,01025h		;7333	c2 25 10 	. % . 
	jp c,0ffc4h		;7336	da c4 ff 	. . . 
	jr z,$+70		;7339	28 44 	( D 
	exx			;733b	d9 	. 
l733ch:
	ld (hl),a			;733c	77 	w 
	ld (0d924h),hl		;733d	22 24 d9 	" $ . 
l7340h:
	add a,024h		;7340	c6 24 	. $ 
	inc d			;7342	14 	. 
	jp c,0ffc8h		;7343	da c8 ff 	. . . 
	ld h,030h		;7346	26 30 	& 0 
	exx			;7348	d9 	. 
	jp z,0332dh		;7349	ca 2d 33 	. - 3 
	exx			;734c	d9 	. 
	call z,0101fh		;734d	cc 1f 10 	. . . 
	jp c,02fceh		;7350	da ce 2f 	. . / 
	djnz l732fh		;7353	10 da 	. . 
	ret nc			;7355	d0 	. 
	rst 38h			;7356	ff 	. 
	ld h,031h		;7357	26 31 	& 1 
	exx			;7359	d9 	. 
l735ah:
	jp nc,02825h		;735a	d2 25 28 	. % ( 
	exx			;735d	d9 	. 
l735eh:
	ld a,b			;735e	78 	x 
	dec e			;735f	1d 	. 
	djnz l733ch		;7360	10 da 	. . 
	ld a,c			;7362	79 	y 
	daa			;7363	27 	' 
	djnz l7340h		;7364	10 da 	. . 
l7366h:
	call nc,029ffh		;7366	d4 ff 29 	. . ) 
	jr nc,$-37		;7369	30 d9 	0 . 
	sub 019h		;736b	d6 19 	. . 
	daa			;736d	27 	' 
	exx			;736e	d9 	. 
	ret c			;736f	d8 	. 
	ld h,010h		;7370	26 10 	& . 
	jp c,0ffdah		;7372	da da ff 	. . . 
	inc hl			;7375	23 	# 
	inc sp			;7376	33 	3 
	exx			;7377	d9 	. 
	call c,02323h		;7378	dc 23 23 	. # # 
	exx			;737b	d9 	. 
	ld a,d			;737c	7a 	z 
	daa			;737d	27 	' 
	djnz l735ah		;737e	10 da 	. . 
	sbc a,037h		;7380	de 37 	. 7 
	djnz l735eh		;7382	10 da 	. . 
l7384h:
	ld a,h			;7384	7c 	| 
	inc sp			;7385	33 	3 
	ld a,0dah		;7386	3e da 	> . 
	ld a,e			;7388	7b 	{ 
	rst 38h			;7389	ff 	. 
	dec hl			;738a	2b 	+ 
	jr nc,l7366h		;738b	30 d9 	0 . 
	ret po			;738d	e0 	. 
	jr nz,$+42		;738e	20 28 	  ( 
	exx			;7390	d9 	. 
	jp po,01025h		;7391	e2 25 10 	. % . 
	jp c,031e4h		;7394	da e4 31 	. . 1 
	inc c			;7397	0c 	. 
	jp c,0ff7dh		;7398	da 7d ff 	. } . 
	jr z,$+43		;739b	28 29 	( ) 
	exx			;739d	d9 	. 
	and 023h		;739e	e6 23 	. # 
	inc hl			;73a0	23 	# 
	exx			;73a1	d9 	. 
	ret pe			;73a2	e8 	. 
	ld l,010h		;73a3	2e 10 	. . 
	jp c,03eeah		;73a5	da ea 3e 	. . > 
	djnz l7384h		;73a8	10 da 	. . 
	ld a,(hl)			;73aa	7e 	~ 
	rst 38h			;73ab	ff 	. 
	dec e			;73ac	1d 	. 
	dec de			;73ad	1b 	. 
	exx			;73ae	d9 	. 
	call pe,01018h		;73af	ec 18 10 	. . . 
	exx			;73b2	d9 	. 
	ld a,a			;73b3	7f 	 
	jr z,$+18		;73b4	28 10 	( . 
	exx			;73b6	d9 	. 
	xor 038h		;73b7	ee 38 	. 8 
	ld de,0f0dah		;73b9	11 da f0 	. . . 
	rst 38h			;73bc	ff 	. 
	inc h			;73bd	24 	$ 
	ld a,(l6699h)		;73be	3a 99 66 	: . f 
l73c1h:
	ld (09928h),hl		;73c1	22 28 99 	" ( . 
	ld l,b			;73c4	68 	h 
	ld h,00fh		;73c5	26 0f 	& . 
	sbc a,d			;73c7	9a 	. 
	ld l,d			;73c8	6a 	j 
	ld (09a2fh),a		;73c9	32 2f 9a 	2 / . 
	ld l,(hl)			;73cc	6e 	n 
	ld b,d			;73cd	42 	B 
	cpl			;73ce	2f 	/ 
	sbc a,d			;73cf	9a 	. 
	ld (hl),b			;73d0	70 	p 
	rst 38h			;73d1	ff 	. 
	call c,0e173h		;73d2	dc 73 e1 	. s . 
	ld (hl),e			;73d5	73 	s 
	and 073h		;73d6	e6 73 	. s 
	ex de,hl			;73d8	eb 	. 
	ld (hl),e			;73d9	73 	s 
	call c,02873h		;73da	dc 73 28 	. s ( 
	djnz $-40		;73dd	10 d6 	. . 
	ld h,e			;73df	63 	c 
	rst 38h			;73e0	ff 	. 
	jr z,l73f3h		;73e1	28 10 	( . 
	sub 064h		;73e3	d6 64 	. d 
	rst 38h			;73e5	ff 	. 
	jr z,l73f8h		;73e6	28 10 	( . 
	sub 065h		;73e8	d6 65 	. e 
	rst 38h			;73ea	ff 	. 
	jr z,l73fdh		;73eb	28 10 	( . 
	sub 066h		;73ed	d6 66 	. f 
	rst 38h			;73ef	ff 	. 
l73f0h:
	nop			;73f0	00 	. 
	ld (hl),h			;73f1	74 	t 
	dec c			;73f2	0d 	. 
l73f3h:
	ld (hl),h			;73f3	74 	t 
	ld a,(de)			;73f4	1a 	. 
	ld (hl),h			;73f5	74 	t 
	dec c			;73f6	0d 	. 
	ld (hl),h			;73f7	74 	t 
l73f8h:
	daa			;73f8	27 	' 
	ld (hl),h			;73f9	74 	t 
l73fah:
	jr c,$+118		;73fa	38 74 	8 t 
	ld c,l			;73fc	4d 	M 
l73fdh:
	ld (hl),h			;73fd	74 	t 
	ld a,a			;73fe	7f 	 
l73ffh:
	ld (hl),h			;73ff	74 	t 
	jr z,l743dh		;7400	28 3b 	( ; 
	dec de			;7402	1b 	. 
	add hl,sp			;7403	39 	9 
	daa			;7404	27 	' 
	dec hl			;7405	2b 	+ 
	inc e			;7406	1c 	. 
	ld a,(01028h)		;7407	3a 28 10 	: ( . 
	sbc a,h			;740a	9c 	. 
	ld h,b			;740b	60 	` 
	rst 38h			;740c	ff 	. 
l740dh:
	jr z,l744bh		;740d	28 3c 	( < 
	dec de			;740f	1b 	. 
	add hl,sp			;7410	39 	9 
	jr z,l743fh		;7411	28 2c 	( , 
	sbc a,h			;7413	9c 	. 
	jp m,01028h		;7414	fa 28 10 	. ( . 
	sbc a,h			;7417	9c 	. 
	ld h,d			;7418	62 	b 
	rst 38h			;7419	ff 	. 
	jr z,l7458h		;741a	28 3c 	( < 
	sbc a,e			;741c	9b 	. 
	add iy,iy		;741d	fd 29 	. ) 
	inc l			;741f	2c 	, 
	sbc a,h			;7420	9c 	. 
	cp 027h		;7421	fe 27 	. ' 
	djnz l73c1h		;7423	10 9c 	. . 
	ld h,h			;7425	64 	d 
	rst 38h			;7426	ff 	. 
	rra			;7427	1f 	. 
	ld (02f1bh),a		;7428	32 1b 2f 	2 . / 
	ld e,01ah		;742b	1e 1a 	. . 
	inc e			;742d	1c 	. 
	ld e,(hl)			;742e	5e 	^ 
	dec h			;742f	25 	% 
	ld c,09ch		;7430	0e 9c 	. . 
	call c,0261eh		;7432	dc 1e 26 	. . & 
	dec e			;7435	1d 	. 
	jr nz,$+1		;7436	20 ff 	  . 
	inc hl			;7438	23 	# 
	ld (0381bh),a		;7439	32 1b 38 	2 . 8 
	rra			;743c	1f 	. 
l743dh:
	ld a,(de)			;743d	1a 	. 
	sbc a,h			;743e	9c 	. 
l743fh:
	sbc a,025h		;743f	de 25 	. % 
	ld c,01ch		;7441	0e 1c 	. . 
	ld e,d			;7443	5a 	Z 
	inc hl			;7444	23 	# 
	ld l,09dh		;7445	2e 9d 	. . 
	ld sp,hl			;7447	f9 	. 
	inc e			;7448	1c 	. 
	inc hl			;7449	23 	# 
	dec e			;744a	1d 	. 
l744bh:
	ld e,0ffh		;744b	1e ff 	. . 
	inc hl			;744d	23 	# 
	ld (0381bh),a		;744e	32 1b 38 	2 . 8 
	rra			;7451	1f 	. 
	ld a,(de)			;7452	1a 	. 
	sbc a,h			;7453	9c 	. 
	sbc a,025h		;7454	de 25 	. % 
	ld c,01ch		;7456	0e 1c 	. . 
l7458h:
	ld e,d			;7458	5a 	Z 
	rla			;7459	17 	. 
	jr nz,l7479h		;745a	20 1d 	  . 
	inc c			;745c	0c 	. 
	daa			;745d	27 	' 
	jr nz,l747dh		;745e	20 1d 	  . 
	jr l748bh		;7460	18 29 	. ) 
	dec hl			;7462	2b 	+ 
	sbc a,l			;7463	9d 	. 
	rst 38h			;7464	ff 	. 
	rst 38h			;7465	ff 	. 
	inc hl			;7466	23 	# 
	jr c,l7484h		;7467	38 1b 	8 . 
	inc hl			;7469	23 	# 
	dec h			;746a	25 	% 
	jr nc,l7489h		;746b	30 1c 	0 . 
	jr nc,l748dh		;746d	30 1e 	0 . 
	djnz l740dh		;746f	10 9c 	. . 
	ld (hl),h			;7471	74 	t 
	dec h			;7472	25 	% 
	ld b,b			;7473	40 	@ 
	add a,b			;7474	80 	. 
	halt			;7475	76 	v 
	dec h			;7476	25 	% 
	jr nc,l73fah		;7477	30 81 	0 . 
l7479h:
	ld a,b			;7479	78 	x 
	dec hl			;747a	2b 	+ 
	djnz l73ffh		;747b	10 82 	. . 
l747dh:
	ld a,d			;747d	7a 	z 
	rst 38h			;747e	ff 	. 
	jr z,l7485h		;747f	28 04 	( . 
	sbc a,l			;7481	9d 	. 
	ld l,h			;7482	6c 	l 
	rst 38h			;7483	ff 	. 
l7484h:
	dec hl			;7484	2b 	+ 
l7485h:
	ld a,(bc)			;7485	0a 	. 
	ld b,a			;7486	47 	G 
	inc c			;7487	0c 	. 
	rst 38h			;7488	ff 	. 
l7489h:
	dec hl			;7489	2b 	+ 
	ld a,(bc)			;748a	0a 	. 
l748bh:
	ld c,e			;748b	4b 	K 
	inc c			;748c	0c 	. 
l748dh:
	rst 38h			;748d	ff 	. 
	call z,0d174h		;748e	cc 74 d1 	. t . 
	ld (hl),h			;7491	74 	t 
	sub 074h		;7492	d6 74 	. t 
	in a,(074h)		;7494	db 74 	. t 
	call z,0e074h		;7496	cc 74 e0 	. t . 
	ld (hl),h			;7499	74 	t 
	jp (hl)			;749a	e9 	. 
	ld (hl),h			;749b	74 	t 
	jp p,0ff74h		;749c	f2 74 ff 	. t . 
	ld (hl),h			;749f	74 	t 
	inc b			;74a0	04 	. 
	ld (hl),l			;74a1	75 	u 
	ld h,c			;74a2	61 	a 
	ld (hl),l			;74a3	75 	u 
	ld l,d			;74a4	6a 	j 
	ld (hl),l			;74a5	75 	u 
	ld (hl),e			;74a6	73 	s 
	ld (hl),l			;74a7	75 	u 
	dec c			;74a8	0d 	. 
	ld (hl),l			;74a9	75 	u 
	ld (de),a			;74aa	12 	. 
	ld (hl),l			;74ab	75 	u 
	dec de			;74ac	1b 	. 
	ld (hl),l			;74ad	75 	u 
	jr nz,$+119		;74ae	20 75 	  u 
	ld b,e			;74b0	43 	C 
	ld (hl),l			;74b1	75 	u 
	ld c,h			;74b2	4c 	L 
	ld (hl),l			;74b3	75 	u 
	ld b,e			;74b4	43 	C 
	ld (hl),l			;74b5	75 	u 
	ld a,b			;74b6	78 	x 
	ld (hl),l			;74b7	75 	u 
	ld a,l			;74b8	7d 	} 
	ld (hl),l			;74b9	75 	u 
	ld (02075h),a		;74ba	32 75 20 	2 u   
	ld (hl),l			;74bd	75 	u 
	dec l			;74be	2d 	- 
	ld (hl),l			;74bf	75 	u 
	add a,d			;74c0	82 	. 
	ld (hl),l			;74c1	75 	u 
	add a,a			;74c2	87 	. 
	ld (hl),l			;74c3	75 	u 
	adc a,h			;74c4	8c 	. 
	ld (hl),l			;74c5	75 	u 
	sub c			;74c6	91 	. 
	ld (hl),l			;74c7	75 	u 
	sub (hl)			;74c8	96 	. 
	ld (hl),l			;74c9	75 	u 
	sbc a,e			;74ca	9b 	. 
	ld (hl),l			;74cb	75 	u 
	jr z,l74deh		;74cc	28 10 	( . 
	ld a,(bc)			;74ce	0a 	. 
	ld (hl),b			;74cf	70 	p 
	rst 38h			;74d0	ff 	. 
	jr z,l74e3h		;74d1	28 10 	( . 
	ld c,l			;74d3	4d 	M 
	dec (hl)			;74d4	35 	5 
	rst 38h			;74d5	ff 	. 
	jr z,l74e8h		;74d6	28 10 	( . 
	ld c,e			;74d8	4b 	K 
	ld a,(028ffh)		;74d9	3a ff 28 	: . ( 
	djnz $+77		;74dc	10 4b 	. K 
l74deh:
	inc a			;74de	3c 	< 
	rst 38h			;74df	ff 	. 
	jr nz,l74f2h		;74e0	20 10 	  . 
	ld c,d			;74e2	4a 	J 
l74e3h:
	inc l			;74e3	2c 	, 
	jr nc,$+18		;74e4	30 10 	0 . 
	ld c,d			;74e6	4a 	J 
	dec l			;74e7	2d 	- 
l74e8h:
	rst 38h			;74e8	ff 	. 
	jr nz,l74fbh		;74e9	20 10 	  . 
	ld c,d			;74eb	4a 	J 
	ld l,030h		;74ec	2e 30 	. 0 
	djnz l753ah		;74ee	10 4a 	. J 
	cpl			;74f0	2f 	/ 
	rst 38h			;74f1	ff 	. 
l74f2h:
	jr z,$+18		;74f2	28 10 	( . 
	ld c,e			;74f4	4b 	K 
	ld (01020h),a		;74f5	32 20 10 	2   . 
	ld c,d			;74f8	4a 	J 
	jr nc,l752bh		;74f9	30 30 	0 0 
l74fbh:
	djnz l7547h		;74fb	10 4a 	. J 
	ld sp,028ffh		;74fd	31 ff 28 	1 . ( 
	djnz $+77		;7500	10 4b 	. K 
	ld (021ffh),a		;7502	32 ff 21 	2 . ! 
	djnz l7552h		;7505	10 4b 	. K 
	inc sp			;7507	33 	3 
	ld sp,04b10h		;7508	31 10 4b 	1 . K 
	inc (hl)			;750b	34 	4 
	rst 38h			;750c	ff 	. 
	jr z,$+18		;750d	28 10 	( . 
	inc c			;750f	0c 	. 
	ld (hl),d			;7510	72 	r 
	rst 38h			;7511	ff 	. 
	jr z,l7524h		;7512	28 10 	( . 
	inc c			;7514	0c 	. 
	ld (hl),h			;7515	74 	t 
	jr z,$+50		;7516	28 30 	( 0 
	ld c,h			;7518	4c 	L 
	ld (hl),0ffh		;7519	36 ff 	6 . 
	jr z,l752dh		;751b	28 10 	( . 
	ld c,h			;751d	4c 	L 
	call pe,026ffh		;751e	ec ff 26 	. . & 
	rla			;7521	17 	. 
	ld c,h			;7522	4c 	L 
	ret p			;7523	f0 	. 
l7524h:
	ld (hl),02fh		;7524	36 2f 	6 / 
	inc c			;7526	0c 	. 
	halt			;7527	76 	v 
	jr z,l7539h		;7528	28 0f 	( . 
	ld c,h			;752a	4c 	L 
l752bh:
	ret pe			;752b	e8 	. 
	rst 38h			;752c	ff 	. 
l752dh:
	jr z,l753eh		;752d	28 0f 	( . 
	ld c,h			;752f	4c 	L 
	ret pe			;7530	e8 	. 
	rst 38h			;7531	ff 	. 
	ld h,017h		;7532	26 17 	& . 
	ld c,h			;7534	4c 	L 
	ret p			;7535	f0 	. 
	ld (hl),02fh		;7536	36 2f 	6 / 
	inc c			;7538	0c 	. 
l7539h:
	halt			;7539	76 	v 
l753ah:
	ld hl,00c35h		;753a	21 35 0c 	! 5 . 
	ld a,b			;753d	78 	x 
l753eh:
	ld sp,00c35h		;753e	31 35 0c 	1 5 . 
l7541h:
	ld a,d			;7541	7a 	z 
	rst 38h			;7542	ff 	. 
	ld h,017h		;7543	26 17 	& . 
	ld c,h			;7545	4c 	L 
	ret p			;7546	f0 	. 
l7547h:
	ld (hl),02fh		;7547	36 2f 	6 / 
	inc c			;7549	0c 	. 
	halt			;754a	76 	v 
	rst 38h			;754b	ff 	. 
	ld h,017h		;754c	26 17 	& . 
	ld c,h			;754e	4c 	L 
	ret p			;754f	f0 	. 
	ld (hl),02fh		;7550	36 2f 	6 / 
l7552h:
	inc c			;7552	0c 	. 
	halt			;7553	76 	v 
	jr c,$+65		;7554	38 3f 	8 ? 
	ld c,h			;7556	4c 	L 
	scf			;7557	37 	7 
	ld c,b			;7558	48 	H 
	ccf			;7559	3f 	? 
	ld c,h			;755a	4c 	L 
	jr c,l75b5h		;755b	38 58 	8 X 
	ccf			;755d	3f 	? 
	ld c,h			;755e	4c 	L 
	add hl,sp			;755f	39 	9 
	rst 38h			;7560	ff 	. 
	jr nz,$+10		;7561	20 08 	  . 
	inc c			;7563	0c 	. 
	ld a,b			;7564	78 	x 
	jr nc,$+10		;7565	30 08 	0 . 
	inc c			;7567	0c 	. 
	ld a,d			;7568	7a 	z 
	rst 38h			;7569	ff 	. 
	jr nz,$+10		;756a	20 08 	  . 
	inc c			;756c	0c 	. 
	ld a,h			;756d	7c 	| 
	jr nc,l7578h		;756e	30 08 	0 . 
	inc c			;7570	0c 	. 
l7571h:
	ld a,(hl)			;7571	7e 	~ 
	rst 38h			;7572	ff 	. 
	jr z,l757dh		;7573	28 08 	( . 
	inc c			;7575	0c 	. 
l7576h:
	ld b,b			;7576	40 	@ 
	rst 38h			;7577	ff 	. 
l7578h:
	dec hl			;7578	2b 	+ 
	dec c			;7579	0d 	. 
	ld c,e			;757a	4b 	K 
	dec sp			;757b	3b 	; 
	rst 38h			;757c	ff 	. 
l757dh:
	dec hl			;757d	2b 	+ 
	dec c			;757e	0d 	. 
	ld c,e			;757f	4b 	K 
	dec a			;7580	3d 	= 
	rst 38h			;7581	ff 	. 
	inc l			;7582	2c 	, 
	ld c,0d8h		;7583	0e d8 	. . 
	dec c			;7585	0d 	. 
	rst 38h			;7586	ff 	. 
	inc l			;7587	2c 	, 
	ld c,0d8h		;7588	0e d8 	. . 
	ld c,0ffh		;758a	0e ff 	. . 
	inc l			;758c	2c 	, 
	dec c			;758d	0d 	. 
	ret c			;758e	d8 	. 
	rrca			;758f	0f 	. 
	rst 38h			;7590	ff 	. 
	inc l			;7591	2c 	, 
	dec c			;7592	0d 	. 
	ret c			;7593	d8 	. 
	djnz $+1		;7594	10 ff 	. . 
	jr z,l75a8h		;7596	28 10 	( . 
	ret c			;7598	d8 	. 
	ld de,028ffh		;7599	11 ff 28 	. . ( 
	djnz l7576h		;759c	10 d8 	. . 
	ld (de),a			;759e	12 	. 
	rst 38h			;759f	ff 	. 
	inc h			;75a0	24 	$ 
	add hl,bc			;75a1	09 	. 
	ld bc,0ff01h		;75a2	01 01 ff 	. . . 
	or c			;75a5	b1 	. 
	ld (hl),l			;75a6	75 	u 
	or (hl)			;75a7	b6 	. 
l75a8h:
	ld (hl),l			;75a8	75 	u 
	cp e			;75a9	bb 	. 
l75aah:
	ld (hl),l			;75aa	75 	u 
	or (hl)			;75ab	b6 	. 
	ld (hl),l			;75ac	75 	u 
	or c			;75ad	b1 	. 
	ld (hl),l			;75ae	75 	u 
l75afh:
	cp e			;75af	bb 	. 
	ld (hl),l			;75b0	75 	u 
	jr z,l75c3h		;75b1	28 10 	( . 
	add a,e			;75b3	83 	. 
	ex (sp),hl			;75b4	e3 	. 
l75b5h:
	rst 38h			;75b5	ff 	. 
	jr z,l75c8h		;75b6	28 10 	( . 
	add a,e			;75b8	83 	. 
l75b9h:
	call po,028ffh		;75b9	e4 ff 28 	. . ( 
	djnz l7541h		;75bc	10 83 	. . 
	push hl			;75be	e5 	. 
	rst 38h			;75bf	ff 	. 
	call nc,0d975h		;75c0	d4 75 d9 	. u . 
l75c3h:
	ld (hl),l			;75c3	75 	u 
	sbc a,075h		;75c4	de 75 	. u 
	ex (sp),hl			;75c6	e3 	. 
	ld (hl),l			;75c7	75 	u 
l75c8h:
	ret pe			;75c8	e8 	. 
	ld (hl),l			;75c9	75 	u 
	defb 0edh;next byte illegal after ed		;75ca	ed 	. 
	ld (hl),l			;75cb	75 	u 
l75cch:
	jp p,l6175h		;75cc	f2 75 61 	. u a 
	ld (hl),l			;75cf	75 	u 
	ld l,d			;75d0	6a 	j 
	ld (hl),l			;75d1	75 	u 
	ld (hl),e			;75d2	73 	s 
	ld (hl),l			;75d3	75 	u 
	jr z,l75e6h		;75d4	28 10 	( . 
	sub l			;75d6	95 	. 
	call nc,028ffh		;75d7	d4 ff 28 	. . ( 
	djnz l7571h		;75da	10 95 	. . 
	and 0ffh		;75dc	e6 ff 	. . 
l75deh:
	jr z,l75f0h		;75de	28 10 	( . 
	sub l			;75e0	95 	. 
	sub 0ffh		;75e1	d6 ff 	. . 
	jr z,l75f5h		;75e3	28 10 	( . 
	sub l			;75e5	95 	. 
l75e6h:
	ret c			;75e6	d8 	. 
	rst 38h			;75e7	ff 	. 
	jr z,l75edh		;75e8	28 03 	( . 
	sub l			;75ea	95 	. 
l75ebh:
	sub 0ffh		;75eb	d6 ff 	. . 
l75edh:
	jr z,l75f2h		;75ed	28 03 	( . 
	sub l			;75ef	95 	. 
l75f0h:
	ret c			;75f0	d8 	. 
	rst 38h			;75f1	ff 	. 
l75f2h:
	jr z,l7604h		;75f2	28 10 	( . 
	sub l			;75f4	95 	. 
l75f5h:
	rst 20h			;75f5	e7 	. 
	rst 38h			;75f6	ff 	. 
	ld de,01676h		;75f7	11 76 16 	. v . 
	halt			;75fa	76 	v 
	dec de			;75fb	1b 	. 
	halt			;75fc	76 	v 
	jr nz,$+120		;75fd	20 76 	  v 
	dec h			;75ff	25 	% 
	halt			;7600	76 	v 
	ld hl,(02f76h)		;7601	2a 76 2f 	* v / 
l7604h:
	halt			;7604	76 	v 
	inc (hl)			;7605	34 	4 
	halt			;7606	76 	v 
	dec a			;7607	3d 	= 
	halt			;7608	76 	v 
	ld b,(hl)			;7609	46 	F 
	halt			;760a	76 	v 
	ld c,a			;760b	4f 	O 
	halt			;760c	76 	v 
	ld e,b			;760d	58 	X 
	halt			;760e	76 	v 
	ld h,c			;760f	61 	a 
	halt			;7610	76 	v 
	jr z,l7623h		;7611	28 10 	( . 
	adc a,h			;7613	8c 	. 
	ret p			;7614	f0 	. 
	rst 38h			;7615	ff 	. 
	jr z,l7628h		;7616	28 10 	( . 
	adc a,h			;7618	8c 	. 
	pop af			;7619	f1 	. 
	rst 38h			;761a	ff 	. 
	daa			;761b	27 	' 
	djnz l75aah		;761c	10 8c 	. . 
	jp p,028ffh		;761e	f2 ff 28 	. . ( 
	djnz l75afh		;7621	10 8c 	. . 
l7623h:
	di			;7623	f3 	. 
	rst 38h			;7624	ff 	. 
	jr z,l7637h		;7625	28 10 	( . 
	adc a,h			;7627	8c 	. 
l7628h:
	call p,028ffh		;7628	f4 ff 28 	. . ( 
	djnz l75b9h		;762b	10 8c 	. . 
	push af			;762d	f5 	. 
	rst 38h			;762e	ff 	. 
	jr z,l7641h		;762f	28 10 	( . 
	adc a,h			;7631	8c 	. 
	or 0ffh		;7632	f6 ff 	. . 
	inc h			;7634	24 	$ 
	djnz l75c3h		;7635	10 8c 	. . 
l7637h:
	ret m			;7637	f8 	. 
	ld hl,(08c10h)		;7638	2a 10 8c 	* . . 
	rst 30h			;763b	f7 	. 
	rst 38h			;763c	ff 	. 
	dec h			;763d	25 	% 
	djnz l75cch		;763e	10 8c 	. . 
	ret p			;7640	f0 	. 
l7641h:
	ld hl,(08c10h)		;7641	2a 10 8c 	* . . 
	rst 30h			;7644	f7 	. 
	rst 38h			;7645	ff 	. 
	dec h			;7646	25 	% 
	djnz $-114		;7647	10 8c 	. . 
	pop af			;7649	f1 	. 
	ld hl,(08c10h)		;764a	2a 10 8c 	* . . 
	rst 30h			;764d	f7 	. 
	rst 38h			;764e	ff 	. 
	dec h			;764f	25 	% 
	djnz l75deh		;7650	10 8c 	. . 
	di			;7652	f3 	. 
	ld hl,(08c10h)		;7653	2a 10 8c 	* . . 
	rst 30h			;7656	f7 	. 
	rst 38h			;7657	ff 	. 
	ld hl,08c10h		;7658	21 10 8c 	! . . 
	ret m			;765b	f8 	. 
	inc l			;765c	2c 	, 
	djnz l75ebh		;765d	10 8c 	. . 
	rst 30h			;765f	f7 	. 
	rst 38h			;7660	ff 	. 
	jr z,l7673h		;7661	28 10 	( . 
	adc a,h			;7663	8c 	. 
	ret m			;7664	f8 	. 
	rst 38h			;7665	ff 	. 
	ld a,0ffh		;7666	3e ff 	> . 
	ld (0e000h),a		;7668	32 00 e0 	2 . . 
	ei			;766b	fb 	. 
	call sub_570dh		;766c	cd 0d 57 	. . W 
	call 01157h		;766f	cd 57 11 	. W . 
	di			;7672	f3 	. 
l7673h:
	ld ix,00000h		;7673	dd 21 00 00 	. ! . . 
	ld b,000h		;7677	06 00 	. . 
	ld a,000h		;7679	3e 00 	> . 
l767bh:
	ld e,a			;767b	5f 	_ 
	ld d,00dh		;767c	16 0d 	. . 
	ld c,010h		;767e	0e 10 	. . 
	ld hl,0e000h		;7680	21 00 e0 	! . . 
l7683h:
	ld (hl),a			;7683	77 	w 
	inc hl			;7684	23 	# 
	inc a			;7685	3c 	< 
	dec d			;7686	15 	. 
	jr nz,l768ch		;7687	20 03 	  . 
	ld d,00dh		;7689	16 0d 	. . 
	inc a			;768b	3c 	< 
l768ch:
	djnz l7683h		;768c	10 f5 	. . 
	dec c			;768e	0d 	. 
	jr nz,l7683h		;768f	20 f2 	  . 
	ld a,e			;7691	7b 	{ 
	ld hl,0e000h		;7692	21 00 e0 	! . . 
	ld d,00dh		;7695	16 0d 	. . 
	ld c,010h		;7697	0e 10 	. . 
l7699h:
	cp (hl)			;7699	be 	. 
	jp nz,l77f6h		;769a	c2 f6 77 	. . w 
l769dh:
	inc hl			;769d	23 	# 
	inc a			;769e	3c 	< 
	dec d			;769f	15 	. 
	jr nz,l76a5h		;76a0	20 03 	  . 
	ld d,00dh		;76a2	16 0d 	. . 
	inc a			;76a4	3c 	< 
l76a5h:
	djnz l7699h		;76a5	10 f2 	. . 
	dec c			;76a7	0d 	. 
	jr nz,l7699h		;76a8	20 ef 	  . 
	ld a,e			;76aa	7b 	{ 
	inc a			;76ab	3c 	< 
	cp 014h		;76ac	fe 14 	. . 
	jr nz,l767bh		;76ae	20 cb 	  . 
	ld a,000h		;76b0	3e 00 	> . 
l76b2h:
	ld e,a			;76b2	5f 	_ 
	ld d,00dh		;76b3	16 0d 	. . 
	ld c,010h		;76b5	0e 10 	. . 
	ld hl,0d000h		;76b7	21 00 d0 	! . . 
l76bah:
	ld (hl),a			;76ba	77 	w 
	inc hl			;76bb	23 	# 
	inc a			;76bc	3c 	< 
	dec d			;76bd	15 	. 
	jr nz,l76c3h		;76be	20 03 	  . 
	ld d,00dh		;76c0	16 0d 	. . 
	inc a			;76c2	3c 	< 
l76c3h:
	djnz l76bah		;76c3	10 f5 	. . 
	dec c			;76c5	0d 	. 
	jr nz,l76bah		;76c6	20 f2 	  . 
	ld a,e			;76c8	7b 	{ 
	ld hl,0d000h		;76c9	21 00 d0 	! . . 
	ld d,00dh		;76cc	16 0d 	. . 
	ld c,010h		;76ce	0e 10 	. . 
l76d0h:
	cp (hl)			;76d0	be 	. 
	jp nz,l77bdh		;76d1	c2 bd 77 	. . w 
l76d4h:
	inc hl			;76d4	23 	# 
	inc a			;76d5	3c 	< 
	dec d			;76d6	15 	. 
	jr nz,l76dch		;76d7	20 03 	  . 
	ld d,00dh		;76d9	16 0d 	. . 
	inc a			;76db	3c 	< 
l76dch:
	djnz l76d0h		;76dc	10 f2 	. . 
	dec c			;76de	0d 	. 
	jr nz,l76d0h		;76df	20 ef 	  . 
	ld a,e			;76e1	7b 	{ 
	inc a			;76e2	3c 	< 
	cp 014h		;76e3	fe 14 	. . 
	jr nz,l76b2h		;76e5	20 cb 	  . 
l76e7h:
	call 01157h		;76e7	cd 57 11 	. W . 
	ld hl,0e000h		;76ea	21 00 e0 	! . . 
	ld de,0e001h		;76ed	11 01 e0 	. . . 
	ld bc,00fffh		;76f0	01 ff 0f 	. . . 
	ld (hl),000h		;76f3	36 00 	6 . 
	ldir		;76f5	ed b0 	. . 
	ld hl,0eb25h		;76f7	21 25 eb 	! % . 
	ld (0eb03h),hl		;76fa	22 03 eb 	" . . 
	ld a,0ffh		;76fd	3e ff 	> . 
	ld (0e000h),a		;76ff	32 00 e0 	2 . . 
	ld de,00000h		;7702	11 00 00 	. . . 
	call sub_7c10h		;7705	cd 10 7c 	. . | 
	ld bc,(0006ah)		;7708	ed 4b 6a 00 	. K j . 
	xor a			;770c	af 	. 
	sbc hl,bc		;770d	ed 42 	. B 
	jr z,l7712h		;770f	28 01 	( . 
	inc a			;7711	3c 	< 
l7712h:
	call sub_7c10h		;7712	cd 10 7c 	. . | 
	ld bc,(0006ch)		;7715	ed 4b 6c 00 	. K l . 
	sbc hl,bc		;7719	ed 42 	. B 
	jr z,l771fh		;771b	28 02 	( . 
	set 1,a		;771d	cb cf 	. . 
l771fh:
	push af			;771f	f5 	. 
	ld b,a			;7720	47 	G 
	ld c,014h		;7721	0e 14 	. . 
	ld de,0d1d5h		;7723	11 d5 d1 	. . . 
	ld a,031h		;7726	3e 31 	> 1 
	call sub_7bf7h		;7728	cd f7 7b 	. . { 
	ld de,0d255h		;772b	11 55 d2 	. U . 
	ld a,032h		;772e	3e 32 	> 2 
	call sub_7bf7h		;7730	cd f7 7b 	. . { 
	push ix		;7733	dd e5 	. . 
	pop hl			;7735	e1 	. 
	ld a,l			;7736	7d 	} 
	or h			;7737	b4 	. 
	ld de,0d155h		;7738	11 55 d1 	. U . 
	ld hl,l7889h		;773b	21 89 78 	! . x 
	jr nz,l7743h		;773e	20 03 	  . 
	ld hl,l7891h		;7740	21 91 78 	! . x 
l7743h:
	call 0111ch		;7743	cd 1c 11 	. . . 
	ei			;7746	fb 	. 
	ld a,070h		;7747	3e 70 	> p 
	call sub_570fh		;7749	cd 0f 57 	. . W 
	ld a,b			;774c	78 	x 
	and a			;774d	a7 	. 
	call nz,sub_7be8h		;774e	c4 e8 7b 	. . { 
l7751h:
	call 01157h		;7751	cd 57 11 	. W . 
	ld hl,l7cf7h		;7754	21 f7 7c 	! . | 
	call 0111ch		;7757	cd 1c 11 	. . . 
	xor a			;775a	af 	. 
	ld (0e882h),a		;775b	32 82 e8 	2 . . 
	ld a,(0e81dh)		;775e	3a 1d e8 	: . . 
l7761h:
	ld (0e81dh),a		;7761	32 1d e8 	2 . . 
	ld c,000h		;7764	0e 00 	. . 
	call sub_7bd7h		;7766	cd d7 7b 	. . { 
l7769h:
	ld a,(0e906h)		;7769	3a 06 e9 	: . . 
	and 003h		;776c	e6 03 	. . 
	ld hl,0e882h		;776e	21 82 e8 	! . . 
	jr z,l7798h		;7771	28 25 	( % 
	ld b,a			;7773	47 	G 
	ld a,(hl)			;7774	7e 	~ 
	and a			;7775	a7 	. 
	jr nz,l779ah		;7776	20 22 	  " 
	ld (hl),010h		;7778	36 10 	6 . 
	ld c,014h		;777a	0e 14 	. . 
	ld a,(0e81dh)		;777c	3a 1d e8 	: . . 
	push af			;777f	f5 	. 
	call sub_7bd7h		;7780	cd d7 7b 	. . { 
	pop af			;7783	f1 	. 
	bit 1,b		;7784	cb 48 	. H 
	jr nz,l7790h		;7786	20 08 	  . 
	dec a			;7788	3d 	= 
	jp p,l7761h		;7789	f2 61 77 	. a w 
	ld a,005h		;778c	3e 05 	> . 
	jr l7761h		;778e	18 d1 	. . 
l7790h:
	inc a			;7790	3c 	< 
	cp 006h		;7791	fe 06 	. . 
	jr c,l7761h		;7793	38 cc 	8 . 
	xor a			;7795	af 	. 
	jr l7761h		;7796	18 c9 	. . 
l7798h:
	ld (hl),000h		;7798	36 00 	6 . 
l779ah:
	ld a,(0e904h)		;779a	3a 04 e9 	: . . 
	bit 0,a		;779d	cb 47 	. G 
	jr z,l7769h		;779f	28 c8 	( . 
	call 01157h		;77a1	cd 57 11 	. W . 
	ld hl,l7751h		;77a4	21 51 77 	! Q w 
	push hl			;77a7	e5 	. 
	ld a,(0e81dh)		;77a8	3a 1d e8 	: . . 
	ld hl,l77b1h		;77ab	21 b1 77 	! . w 
	jp 01f26h		;77ae	c3 26 1f 	. & . 
l77b1h:
	sbc a,c			;77b1	99 	. 
	ld a,b			;77b2	78 	x 
	ld a,079h		;77b3	3e 79 	> y 
	cp d			;77b5	ba 	. 
	ld a,c			;77b6	79 	y 
	adc a,e			;77b7	8b 	. 
	ld a,d			;77b8	7a 	z 
	djnz $+125		;77b9	10 7b 	. { 
	ld a,b			;77bb	78 	x 
	ld a,e			;77bc	7b 	{ 
l77bdh:
	ex af,af'			;77bd	08 	. 
	exx			;77be	d9 	. 
	ld de,0e000h		;77bf	11 00 e0 	. . . 
	ld hl,0d155h		;77c2	21 55 d1 	! U . 
	ld bc,00020h		;77c5	01 20 00 	.   . 
	ldir		;77c8	ed b0 	. . 
	ld de,0e020h		;77ca	11 20 e0 	.   . 
	ld hl,0d955h		;77cd	21 55 d9 	! U . 
	ld bc,00020h		;77d0	01 20 00 	.   . 
	ldir		;77d3	ed b0 	. . 
	ld ix,l77dbh		;77d5	dd 21 db 77 	. ! . w 
	jr l77fch		;77d9	18 21 	. ! 
l77dbh:
	exx			;77db	d9 	. 
	ld hl,0e000h		;77dc	21 00 e0 	! . . 
	ld de,0d155h		;77df	11 55 d1 	. U . 
	ld bc,00020h		;77e2	01 20 00 	.   . 
	ldir		;77e5	ed b0 	. . 
	ld hl,0e020h		;77e7	21 20 e0 	!   . 
	ld de,0d955h		;77ea	11 55 d9 	. U . 
	ld bc,00020h		;77ed	01 20 00 	.   . 
	ldir		;77f0	ed b0 	. . 
	exx			;77f2	d9 	. 
	jp l76d4h		;77f3	c3 d4 76 	. . v 
l77f6h:
	ld ix,l769dh		;77f6	dd 21 9d 76 	. ! . v 
	ex af,af'			;77fa	08 	. 
	exx			;77fb	d9 	. 
l77fch:
	ld hl,0d155h		;77fc	21 55 d1 	! U . 
	ld de,l7889h		;77ff	11 89 78 	. . x 
	ld b,007h		;7802	06 07 	. . 
l7804h:
	ld a,(de)			;7804	1a 	. 
	inc de			;7805	13 	. 
	ld iy,l780ch		;7806	fd 21 0c 78 	. ! . x 
	jr l787fh		;780a	18 73 	. s 
l780ch:
	djnz l7804h		;780c	10 f6 	. . 
	ld a,03ah		;780e	3e 3a 	> : 
	ld iy,l7816h		;7810	fd 21 16 78 	. ! . x 
	jr l787fh		;7814	18 69 	. i 
l7816h:
	exx			;7816	d9 	. 
	ld a,h			;7817	7c 	| 
	exx			;7818	d9 	. 
	ld iy,l781fh		;7819	fd 21 1f 78 	. ! . x 
	jr l7861h		;781d	18 42 	. B 
l781fh:
	exx			;781f	d9 	. 
	ld a,l			;7820	7d 	} 
	exx			;7821	d9 	. 
	ld iy,l7828h		;7822	fd 21 28 78 	. ! ( x 
	jr l7861h		;7826	18 39 	. 9 
l7828h:
	ld a,03ah		;7828	3e 3a 	> : 
	ld iy,l7830h		;782a	fd 21 30 78 	. ! 0 x 
	jr l787fh		;782e	18 4f 	. O 
l7830h:
	ex af,af'			;7830	08 	. 
	ld e,a			;7831	5f 	_ 
	ex af,af'			;7832	08 	. 
	ld a,e			;7833	7b 	{ 
	ld iy,l783ah		;7834	fd 21 3a 78 	. ! : x 
	jr l7861h		;7838	18 27 	. ' 
l783ah:
	inc hl			;783a	23 	# 
	exx			;783b	d9 	. 
	ld a,(hl)			;783c	7e 	~ 
	exx			;783d	d9 	. 
	ld iy,l7844h		;783e	fd 21 44 78 	. ! D x 
	jr l7861h		;7842	18 1d 	. . 
l7844h:
	in a,(000h)		;7844	db 00 	. . 
	bit 0,a		;7846	cb 47 	. G 
	jp z,l76e7h		;7848	ca e7 76 	. . v 
	bit 1,a		;784b	cb 4f 	. O 
	jr nz,l7844h		;784d	20 f5 	  . 
	ld bc,01000h		;784f	01 00 10 	. . . 
l7852h:
	dec bc			;7852	0b 	. 
	ld a,c			;7853	79 	y 
	or b			;7854	b0 	. 
	jr nz,l7852h		;7855	20 fb 	  . 
l7857h:
	in a,(000h)		;7857	db 00 	. . 
	bit 1,a		;7859	cb 4f 	. O 
	jr z,l7857h		;785b	28 fa 	( . 
	exx			;785d	d9 	. 
	ex af,af'			;785e	08 	. 
	jp (ix)		;785f	dd e9 	. . 
l7861h:
	ld e,a			;7861	5f 	_ 
	rrca			;7862	0f 	. 
	rrca			;7863	0f 	. 
	rrca			;7864	0f 	. 
	rrca			;7865	0f 	. 
	and 00fh		;7866	e6 0f 	. . 
	add a,090h		;7868	c6 90 	. . 
	daa			;786a	27 	' 
	adc a,040h		;786b	ce 40 	. @ 
	daa			;786d	27 	' 
	ld (hl),a			;786e	77 	w 
	set 3,h		;786f	cb dc 	. . 
	ld (hl),014h		;7871	36 14 	6 . 
	res 3,h		;7873	cb 9c 	. . 
	inc hl			;7875	23 	# 
	ld a,e			;7876	7b 	{ 
	and 00fh		;7877	e6 0f 	. . 
	add a,090h		;7879	c6 90 	. . 
	daa			;787b	27 	' 
	adc a,040h		;787c	ce 40 	. @ 
	daa			;787e	27 	' 
l787fh:
	ld (hl),a			;787f	77 	w 
	set 3,h		;7880	cb dc 	. . 
	ld (hl),014h		;7882	36 14 	6 . 
	res 3,h		;7884	cb 9c 	. . 
	inc hl			;7886	23 	# 
	jp (iy)		;7887	fd e9 	. . 
l7889h:
	ld d,d			;7889	52 	R 
	ld b,c			;788a	41 	A 
	ld c,l			;788b	4d 	M 
	jr nz,$+34		;788c	20 20 	    
	ld c,(hl)			;788e	4e 	N 
	ld b,a			;788f	47 	G 
	rst 38h			;7890	ff 	. 
l7891h:
	ld d,d			;7891	52 	R 
	ld b,c			;7892	41 	A 
	ld c,l			;7893	4d 	M 
	jr nz,$+34		;7894	20 20 	    
	ld c,a			;7896	4f 	O 
	ld c,e			;7897	4b 	K 
	rst 38h			;7898	ff 	. 
	ld hl,l7c30h		;7899	21 30 7c 	! 0 | 
	call 0111ch		;789c	cd 1c 11 	. . . 
	call sub_7bc1h		;789f	cd c1 7b 	. . { 
	call 0111ch		;78a2	cd 1c 11 	. . . 
l78a5h:
	ld de,0d199h		;78a5	11 99 d1 	. . . 
	in a,(003h)		;78a8	db 03 	. . 
	call sub_7bb2h		;78aa	cd b2 7b 	. . { 
	ld de,0d1d9h		;78ad	11 d9 d1 	. . . 
	in a,(004h)		;78b0	db 04 	. . 
	call sub_7bb2h		;78b2	cd b2 7b 	. . { 
	in a,(004h)		;78b5	db 04 	. . 
	bit 1,a		;78b7	cb 4f 	. O 
	ld hl,l7c96h		;78b9	21 96 7c 	! . | 
	jr nz,l78c1h		;78bc	20 03 	  . 
	ld hl,l7c9eh		;78be	21 9e 7c 	! . | 
l78c1h:
	ld de,0d35dh		;78c1	11 5d d3 	. ] . 
	call 0111ch		;78c4	cd 1c 11 	. . . 
	in a,(003h)		;78c7	db 03 	. . 
	and 001h		;78c9	e6 01 	. . 
	ld hl,l7ca6h		;78cb	21 a6 7c 	! . | 
	jr nz,l78d3h		;78ce	20 03 	  . 
	ld hl,l7cb0h		;78d0	21 b0 7c 	! . | 
l78d3h:
	ld de,0d39eh		;78d3	11 9e d3 	. . . 
	call 0111ch		;78d6	cd 1c 11 	. . . 
	in a,(003h)		;78d9	db 03 	. . 
	and 002h		;78db	e6 02 	. . 
	ld hl,l7cbah		;78dd	21 ba 7c 	! . | 
	jr nz,l78e5h		;78e0	20 03 	  . 
	ld hl,l7cbfh		;78e2	21 bf 7c 	! . | 
l78e5h:
	ld de,0d3deh		;78e5	11 de d3 	. . . 
	call 0111ch		;78e8	cd 1c 11 	. . . 
	call 0056fh		;78eb	cd 6f 05 	. o . 
	ld de,0d41fh		;78ee	11 1f d4 	. . . 
	call 01108h		;78f1	cd 08 11 	. . . 
	call 0058fh		;78f4	cd 8f 05 	. . . 
	ld b,c			;78f7	41 	A 
	ld de,0d29ah		;78f8	11 9a d2 	. . . 
	ld hl,(0e90ah)		;78fb	2a 0a e9 	* . . 
	ld a,l			;78fe	7d 	} 
	and a			;78ff	a7 	. 
	jr z,l792ah		;7900	28 28 	( ( 
	cp h			;7902	bc 	. 
	push af			;7903	f5 	. 
	ld a,020h		;7904	3e 20 	>   
	jr z,l790ah		;7906	28 02 	( . 
	ld a,041h		;7908	3e 41 	> A 
l790ah:
	call 01110h		;790a	cd 10 11 	. . . 
	call sub_49f7h		;790d	cd f7 49 	. . I 
	pop af			;7910	f1 	. 
	ld de,0d2d0h		;7911	11 d0 d2 	. . . 
	jr z,l7933h		;7914	28 1d 	( . 
	push hl			;7916	e5 	. 
	ld hl,l7c8ch		;7917	21 8c 7c 	! . | 
	call 0111ch		;791a	cd 1c 11 	. . . 
	inc de			;791d	13 	. 
	ld a,042h		;791e	3e 42 	> B 
	call 01110h		;7920	cd 10 11 	. . . 
	pop hl			;7923	e1 	. 
	ld l,h			;7924	6c 	l 
	call sub_49f7h		;7925	cd f7 49 	. . I 
	jr l7936h		;7928	18 0c 	. . 
l792ah:
	ld hl,l7cc4h		;792a	21 c4 7c 	! . | 
	call 0111ch		;792d	cd 1c 11 	. . . 
	ld de,0d2d0h		;7930	11 d0 d2 	. . . 
l7933h:
	call sub_571ah		;7933	cd 1a 57 	. . W 
l7936h:
	in a,(000h)		;7936	db 00 	. . 
	bit 1,a		;7938	cb 4f 	. O 
	jp nz,l78a5h		;793a	c2 a5 78 	. . x 
	ret			;793d	c9 	. 
	ld bc,00314h		;793e	01 14 03 	. . . 
	ld de,0d455h		;7941	11 55 d4 	. U . 
l7944h:
	push bc			;7944	c5 	. 
	ld hl,l7cd8h		;7945	21 d8 7c 	! . | 
	call 0111ch		;7948	cd 1c 11 	. . . 
	push hl			;794b	e5 	. 
	inc de			;794c	13 	. 
	ld a,b			;794d	78 	x 
	call 01108h		;794e	cd 08 11 	. . . 
	call sub_7bc1h		;7951	cd c1 7b 	. . { 
	ld hl,0002ch		;7954	21 2c 00 	! , . 
	add hl,de			;7957	19 	. 
	ex de,hl			;7958	eb 	. 
	pop hl			;7959	e1 	. 
	call 0111ch		;795a	cd 1c 11 	. . . 
	ld hl,0feb6h		;795d	21 b6 fe 	! . . 
	add hl,de			;7960	19 	. 
	ex de,hl			;7961	eb 	. 
	pop bc			;7962	c1 	. 
	djnz l7944h		;7963	10 df 	. . 
	ld hl,l7cech		;7965	21 ec 7c 	! . | 
	call 0111ch		;7968	cd 1c 11 	. . . 
	ld hl,09999h		;796b	21 99 99 	! . . 
	ld (0e003h),hl		;796e	22 03 e0 	" . . 
l7971h:
	ld a,038h		;7971	3e 38 	> 8 
	ld (0e882h),a		;7973	32 82 e8 	2 . . 
	ld hl,0e003h		;7976	21 03 e0 	! . . 
	ld a,(hl)			;7979	7e 	~ 
	add a,001h		;797a	c6 01 	. . 
	daa			;797c	27 	' 
	ld (hl),a			;797d	77 	w 
	inc hl			;797e	23 	# 
	ld a,(hl)			;797f	7e 	~ 
	adc a,000h		;7980	ce 00 	. . 
	daa			;7982	27 	' 
	ld (hl),a			;7983	77 	w 
	ld de,0d562h		;7984	11 62 d5 	. b . 
	call 010fdh		;7987	cd fd 10 	. . . 
	call 010fdh		;798a	cd fd 10 	. . . 
l798dh:
	in a,(000h)		;798d	db 00 	. . 
	ld de,0d2a2h		;798f	11 a2 d2 	. . . 
	call sub_7bb2h		;7992	cd b2 7b 	. . { 
	in a,(001h)		;7995	db 01 	. . 
	ld de,0d3a2h		;7997	11 a2 d3 	. . . 
	call sub_7bb2h		;799a	cd b2 7b 	. . { 
	in a,(002h)		;799d	db 02 	. . 
	ld de,0d4a2h		;799f	11 a2 d4 	. . . 
	call sub_7bb2h		;79a2	cd b2 7b 	. . { 
	ld a,(0e882h)		;79a5	3a 82 e8 	: . . 
	and a			;79a8	a7 	. 
	jr z,l7971h		;79a9	28 c6 	( . 
	ld a,(0e904h)		;79ab	3a 04 e9 	: . . 
	bit 1,a		;79ae	cb 4f 	. O 
	jr z,l798dh		;79b0	28 db 	( . 
	ld a,(0e906h)		;79b2	3a 06 e9 	: . . 
	bit 1,a		;79b5	cb 4f 	. O 
	jr z,l798dh		;79b7	28 d4 	( . 
	ret			;79b9	c9 	. 
	xor a			;79ba	af 	. 
	ld (0e882h),a		;79bb	32 82 e8 	2 . . 
l79beh:
	push af			;79be	f5 	. 
	ld hl,l7a61h		;79bf	21 61 7a 	! a z 
	ld e,a			;79c2	5f 	_ 
	ld d,000h		;79c3	16 00 	. . 
	add hl,de			;79c5	19 	. 
	add hl,de			;79c6	19 	. 
l79c7h:
	ld a,(0e904h)		;79c7	3a 04 e9 	: . . 
	bit 0,a		;79ca	cb 47 	. G 
	jr nz,l79c7h		;79cc	20 f9 	  . 
	ld a,(hl)			;79ce	7e 	~ 
	ld (0e883h),a		;79cf	32 83 e8 	2 . . 
	ld (0e81fh),a		;79d2	32 1f e8 	2 . . 
	inc hl			;79d5	23 	# 
	ld a,000h		;79d6	3e 00 	> . 
	call 00dfeh		;79d8	cd fe 0d 	. . . 
	ld a,(hl)			;79db	7e 	~ 
	call 00dfeh		;79dc	cd fe 0d 	. . . 
	ld hl,l7d56h		;79df	21 56 7d 	! V } 
	call 0111ch		;79e2	cd 1c 11 	. . . 
	pop af			;79e5	f1 	. 
l79e6h:
	ld (0e81eh),a		;79e6	32 1e e8 	2 . . 
	ld c,000h		;79e9	0e 00 	. . 
	call sub_7bceh		;79eb	cd ce 7b 	. . { 
l79eeh:
	ld a,(0e906h)		;79ee	3a 06 e9 	: . . 
	and 003h		;79f1	e6 03 	. . 
	ld hl,0e882h		;79f3	21 82 e8 	! . . 
	jr z,l7a26h		;79f6	28 2e 	( . 
	ld b,a			;79f8	47 	G 
	ld a,(hl)			;79f9	7e 	~ 
	and a			;79fa	a7 	. 
	jr nz,l79eeh		;79fb	20 f1 	  . 
	ld a,000h		;79fd	3e 00 	> . 
	call 00dfeh		;79ff	cd fe 0d 	. . . 
	xor a			;7a02	af 	. 
	ld (0e81fh),a		;7a03	32 1f e8 	2 . . 
	ld (hl),010h		;7a06	36 10 	6 . 
	ld c,014h		;7a08	0e 14 	. . 
	ld a,(0e81eh)		;7a0a	3a 1e e8 	: . . 
	push af			;7a0d	f5 	. 
	call sub_7bceh		;7a0e	cd ce 7b 	. . { 
	pop af			;7a11	f1 	. 
	bit 1,b		;7a12	cb 48 	. H 
	jr nz,l7a1eh		;7a14	20 08 	  . 
	dec a			;7a16	3d 	= 
	jp p,l79e6h		;7a17	f2 e6 79 	. . y 
	ld a,014h		;7a1a	3e 14 	> . 
	jr l79e6h		;7a1c	18 c8 	. . 
l7a1eh:
	inc a			;7a1e	3c 	< 
	cp 015h		;7a1f	fe 15 	. . 
	jr c,l79e6h		;7a21	38 c3 	8 . 
	xor a			;7a23	af 	. 
	jr l79e6h		;7a24	18 c0 	. . 
l7a26h:
	ld (hl),000h		;7a26	36 00 	6 . 
	ld a,(0e81fh)		;7a28	3a 1f e8 	: . . 
	and a			;7a2b	a7 	. 
	jr z,l7a40h		;7a2c	28 12 	( . 
	ld b,a			;7a2e	47 	G 
	ld a,(0e883h)		;7a2f	3a 83 e8 	: . . 
	and a			;7a32	a7 	. 
	jr z,l7a46h		;7a33	28 11 	( . 
	ld a,(0e904h)		;7a35	3a 04 e9 	: . . 
	and 003h		;7a38	e6 03 	. . 
	jr z,l79eeh		;7a3a	28 b2 	( . 
	bit 1,a		;7a3c	cb 4f 	. O 
	jr nz,l7a5bh		;7a3e	20 1b 	  . 
l7a40h:
	ld a,(0e81eh)		;7a40	3a 1e e8 	: . . 
l7a43h:
	jp l79beh		;7a43	c3 be 79 	. . y 
l7a46h:
	ld a,b			;7a46	78 	x 
	cp 0bah		;7a47	fe ba 	. . 
	ld (0e883h),a		;7a49	32 83 e8 	2 . . 
	ld a,001h		;7a4c	3e 01 	> . 
	ld (0e81fh),a		;7a4e	32 1f e8 	2 . . 
	jr nc,l79eeh		;7a51	30 9b 	0 . 
	ld a,(0e81eh)		;7a53	3a 1e e8 	: . . 
	inc a			;7a56	3c 	< 
	cp 015h		;7a57	fe 15 	. . 
l7a59h:
	jr c,l7a43h		;7a59	38 e8 	8 . 
l7a5bh:
	ld a,000h		;7a5b	3e 00 	> . 
	call 00dfeh		;7a5d	cd fe 0d 	. . . 
	ret			;7a60	c9 	. 
l7a61h:
	dec l			;7a61	2d 	- 
	ld bc,0022dh		;7a62	01 2d 02 	. - . 
	dec l			;7a65	2d 	- 
	inc bc			;7a66	03 	. 
	or h			;7a67	b4 	. 
	dec b			;7a68	05 	. 
	sbc a,(hl)			;7a69	9e 	. 
	inc b			;7a6a	04 	. 
	dec l			;7a6b	2d 	- 
	ld b,02dh		;7a6c	06 2d 	. - 
	rlca			;7a6e	07 	. 
	dec l			;7a6f	2d 	- 
	djnz $+47		;7a70	10 2d 	. - 
	ld de,0122dh		;7a72	11 2d 12 	. - . 
	dec l			;7a75	2d 	- 
	inc de			;7a76	13 	. 
	dec l			;7a77	2d 	- 
	inc d			;7a78	14 	. 
	dec l			;7a79	2d 	- 
	dec d			;7a7a	15 	. 
	dec l			;7a7b	2d 	- 
	ld d,0bah		;7a7c	16 ba 	. . 
	jr nz,$+1		;7a7e	20 ff 	  . 
	inc h			;7a80	24 	$ 
	cp d			;7a81	ba 	. 
	ld (023ffh),hl		;7a82	22 ff 23 	" . # 
	cp d			;7a85	ba 	. 
	ld hl,0172dh		;7a86	21 2d 17 	! - . 
	dec l			;7a89	2d 	- 
	jr l7a59h		;7a8a	18 cd 	. . 
	ld d,e			;7a8c	53 	S 
	ld de,00021h		;7a8d	11 21 00 	. ! . 
	ret po			;7a90	e0 	. 
	ld (hl),0feh		;7a91	36 fe 	6 . 
l7a93h:
	ld a,(0e906h)		;7a93	3a 06 e9 	: . . 
	and 003h		;7a96	e6 03 	. . 
	jr z,l7aa4h		;7a98	28 0a 	( . 
	bit 1,a		;7a9a	cb 4f 	. O 
	jr z,l7aa2h		;7a9c	28 04 	( . 
	ld (hl),0fdh		;7a9e	36 fd 	6 . 
	jr l7aa4h		;7aa0	18 02 	. . 
l7aa2h:
	ld (hl),0feh		;7aa2	36 fe 	6 . 
l7aa4h:
	ld a,(0e904h)		;7aa4	3a 04 e9 	: . . 
	bit 1,a		;7aa7	cb 4f 	. O 
	jr z,l7a93h		;7aa9	28 e8 	( . 
	ld (hl),0ffh		;7aab	36 ff 	6 . 
	ret			;7aad	c9 	. 
	ld c,000h		;7aae	0e 00 	. . 
	inc a			;7ab0	3c 	< 
	jr nz,l7ae5h		;7ab1	20 32 	  2 
	ld hl,00110h		;7ab3	21 10 01 	! . . 
	ld de,000e0h		;7ab6	11 e0 00 	. . . 
	ld a,000h		;7ab9	3e 00 	> . 
	call sub_7adch		;7abb	cd dc 7a 	. . z 
	ld hl,00110h		;7abe	21 10 01 	! . . 
	ld de,00120h		;7ac1	11 20 01 	.   . 
	ld a,040h		;7ac4	3e 40 	> @ 
	call sub_7adch		;7ac6	cd dc 7a 	. . z 
	ld hl,000d0h		;7ac9	21 d0 00 	! . . 
	ld de,000e0h		;7acc	11 e0 00 	. . . 
	ld a,080h		;7acf	3e 80 	> . 
	call sub_7adch		;7ad1	cd dc 7a 	. . z 
	ld hl,000d0h		;7ad4	21 d0 00 	! . . 
	ld de,00120h		;7ad7	11 20 01 	.   . 
	ld a,0c0h		;7ada	3e c0 	> . 
sub_7adch:
	ld (0e807h),hl		;7adc	22 07 e8 	" . . 
	ld hl,l75deh		;7adf	21 de 75 	! . u 
	jp 00e20h		;7ae2	c3 20 0e 	.   . 
l7ae5h:
	ld hl,000c0h		;7ae5	21 c0 00 	! . . 
	ld (0e807h),hl		;7ae8	22 07 e8 	" . . 
	ld de,000d0h		;7aeb	11 d0 00 	. . . 
	ld hl,l669bh		;7aee	21 9b 66 	! . f 
	call sub_7b0ch		;7af1	cd 0c 7b 	. . { 
	ld de,000f0h		;7af4	11 f0 00 	. . . 
	ld hl,l6c6ah		;7af7	21 6a 6c 	! j l 
	call sub_7b0ch		;7afa	cd 0c 7b 	. . { 
	ld de,00110h		;7afd	11 10 01 	. . . 
	ld hl,06e7dh		;7b00	21 7d 6e 	! } n 
	call sub_7b0ch		;7b03	cd 0c 7b 	. . { 
	ld de,00130h		;7b06	11 30 01 	. 0 . 
	ld hl,l726bh		;7b09	21 6b 72 	! k r 
sub_7b0ch:
	xor a			;7b0c	af 	. 
	jp 00e20h		;7b0d	c3 20 0e 	.   . 
	ld de,0d1d0h		;7b10	11 d0 d1 	. . . 
	ld c,014h		;7b13	0e 14 	. . 
	ld a,041h		;7b15	3e 41 	> A 
	ld b,01ah		;7b17	06 1a 	. . 
	call sub_7bc7h		;7b19	cd c7 7b 	. . { 
	ld de,0d210h		;7b1c	11 10 d2 	. . . 
	ld a,030h		;7b1f	3e 30 	> 0 
	ld b,00ah		;7b21	06 0a 	. . 
	call sub_7bc7h		;7b23	cd c7 7b 	. . { 
	call sub_7be8h		;7b26	cd e8 7b 	. . { 
	ld a,004h		;7b29	3e 04 	> . 
	ld de,00004h		;7b2b	11 04 00 	. . . 
	call 0115bh		;7b2e	cd 5b 11 	. [ . 
	call sub_7be8h		;7b31	cd e8 7b 	. . { 
	ld e,001h		;7b34	1e 01 	. . 
	call 0115bh		;7b36	cd 5b 11 	. [ . 
	call sub_7be8h		;7b39	cd e8 7b 	. . { 
	ld e,002h		;7b3c	1e 02 	. . 
	call 0115bh		;7b3e	cd 5b 11 	. [ . 
	call sub_7be8h		;7b41	cd e8 7b 	. . { 
	ld bc,00200h		;7b44	01 00 02 	. . . 
	ld e,006h		;7b47	1e 06 	. . 
	call 0115eh		;7b49	cd 5e 11 	. ^ . 
	ld bc,00400h		;7b4c	01 00 04 	. . . 
	ld e,000h		;7b4f	1e 00 	. . 
	call 01165h		;7b51	cd 65 11 	. e . 
	ld bc,00200h		;7b54	01 00 02 	. . . 
	ld e,007h		;7b57	1e 07 	. . 
	call 01165h		;7b59	cd 65 11 	. e . 
	ld hl,0d410h		;7b5c	21 10 d4 	! . . 
	ld c,008h		;7b5f	0e 08 	. . 
l7b61h:
	ld a,000h		;7b61	3e 00 	> . 
l7b63h:
	ld b,004h		;7b63	06 04 	. . 
l7b65h:
	ld (hl),a			;7b65	77 	w 
	inc hl			;7b66	23 	# 
	djnz l7b65h		;7b67	10 fc 	. . 
	inc a			;7b69	3c 	< 
	and 007h		;7b6a	e6 07 	. . 
	jr nz,l7b63h		;7b6c	20 f5 	  . 
	ld de,00020h		;7b6e	11 20 00 	.   . 
	add hl,de			;7b71	19 	. 
	dec c			;7b72	0d 	. 
	jr nz,l7b61h		;7b73	20 ec 	  . 
	jp sub_7be8h		;7b75	c3 e8 7b 	. . { 
	ld c,000h		;7b78	0e 00 	. . 
	ld de,0d010h		;7b7a	11 10 d0 	. . . 
	ld a,00bh		;7b7d	3e 0b 	> . 
	ld l,020h		;7b7f	2e 20 	.   
l7b81h:
	push hl			;7b81	e5 	. 
	ld b,010h		;7b82	06 10 	. . 
l7b84h:
	call 01110h		;7b84	cd 10 11 	. . . 
	dec a			;7b87	3d 	= 
	call 01110h		;7b88	cd 10 11 	. . . 
	inc a			;7b8b	3c 	< 
	djnz l7b84h		;7b8c	10 f6 	. . 
	ld hl,00020h		;7b8e	21 20 00 	!   . 
	add hl,de			;7b91	19 	. 
	ex de,hl			;7b92	eb 	. 
	cp 00bh		;7b93	fe 0b 	. . 
	ld a,00bh		;7b95	3e 0b 	> . 
	jr nz,l7b9bh		;7b97	20 02 	  . 
	ld a,009h		;7b99	3e 09 	> . 
l7b9bh:
	pop hl			;7b9b	e1 	. 
	dec l			;7b9c	2d 	- 
	jr nz,l7b81h		;7b9d	20 e2 	  . 
	ld hl,0d3dfh		;7b9f	21 df d3 	! . . 
	ld (hl),00ch		;7ba2	36 0c 	6 . 
	inc hl			;7ba4	23 	# 
	ld (hl),00dh		;7ba5	36 0d 	6 . 
	ld hl,0d41fh		;7ba7	21 1f d4 	! . . 
	ld (hl),00eh		;7baa	36 0e 	6 . 
	inc hl			;7bac	23 	# 
	ld (hl),00fh		;7bad	36 0f 	6 . 
	jp sub_7be8h		;7baf	c3 e8 7b 	. . { 
sub_7bb2h:
	cpl			;7bb2	2f 	/ 
	ld l,a			;7bb3	6f 	o 
	ld b,008h		;7bb4	06 08 	. . 
l7bb6h:
	xor a			;7bb6	af 	. 
	rrc l		;7bb7	cb 0d 	. . 
	rl a		;7bb9	cb 17 	. . 
	call 01108h		;7bbb	cd 08 11 	. . . 
	djnz l7bb6h		;7bbe	10 f6 	. . 
	ret			;7bc0	c9 	. 
sub_7bc1h:
	inc de			;7bc1	13 	. 
	inc de			;7bc2	13 	. 
	ld a,031h		;7bc3	3e 31 	> 1 
	ld b,008h		;7bc5	06 08 	. . 
sub_7bc7h:
	call 01110h		;7bc7	cd 10 11 	. . . 
	inc a			;7bca	3c 	< 
	djnz sub_7bc7h		;7bcb	10 fa 	. . 
	ret			;7bcd	c9 	. 
sub_7bceh:
	cp 006h		;7bce	fe 06 	. . 
	jr c,l7bd3h		;7bd0	38 01 	8 . 
	inc a			;7bd2	3c 	< 
l7bd3h:
	and a			;7bd3	a7 	. 
	jr z,sub_7bd7h		;7bd4	28 01 	( . 
	inc a			;7bd6	3c 	< 
sub_7bd7h:
	ld l,a			;7bd7	6f 	o 
	ld h,000h		;7bd8	26 00 	& . 
	add hl,hl			;7bda	29 	) 
	add hl,hl			;7bdb	29 	) 
	add hl,hl			;7bdc	29 	) 
	add hl,hl			;7bdd	29 	) 
	add hl,hl			;7bde	29 	) 
	add hl,hl			;7bdf	29 	) 
	ld de,0d950h		;7be0	11 50 d9 	. P . 
	add hl,de			;7be3	19 	. 
	ld (hl),c			;7be4	71 	q 
	inc hl			;7be5	23 	# 
	ld (hl),c			;7be6	71 	q 
	ret			;7be7	c9 	. 
sub_7be8h:
	ld a,(0e904h)		;7be8	3a 04 e9 	: . . 
	bit 1,a		;7beb	cb 4f 	. O 
	jr z,sub_7be8h		;7bed	28 f9 	( . 
l7befh:
	ld a,(0e904h)		;7bef	3a 04 e9 	: . . 
	bit 1,a		;7bf2	cb 4f 	. O 
	jr nz,l7befh		;7bf4	20 f9 	  . 
	ret			;7bf6	c9 	. 
sub_7bf7h:
	push af			;7bf7	f5 	. 
	ld hl,l7c2ch		;7bf8	21 2c 7c 	! , | 
	call 0111ch		;7bfb	cd 1c 11 	. . . 
	pop af			;7bfe	f1 	. 
	call 01110h		;7bff	cd 10 11 	. . . 
	inc de			;7c02	13 	. 
	ld hl,l7c29h		;7c03	21 29 7c 	! ) | 
	rrc b		;7c06	cb 08 	. . 
	jr c,l7c0dh		;7c08	38 03 	8 . 
	ld hl,l7c26h		;7c0a	21 26 7c 	! & | 
l7c0dh:
	jp 0111ch		;7c0d	c3 1c 11 	. . . 
sub_7c10h:
	push af			;7c10	f5 	. 
	ld bc,l4000h		;7c11	01 00 40 	. . @ 
	ld hl,00000h		;7c14	21 00 00 	! . . 
l7c17h:
	ld a,(de)			;7c17	1a 	. 
	add a,l			;7c18	85 	. 
	ld l,a			;7c19	6f 	o 
	ld a,000h		;7c1a	3e 00 	> . 
	adc a,h			;7c1c	8c 	. 
	ld h,a			;7c1d	67 	g 
	inc de			;7c1e	13 	. 
	dec bc			;7c1f	0b 	. 
	ld a,c			;7c20	79 	y 
	or b			;7c21	b0 	. 
	jr nz,l7c17h		;7c22	20 f3 	  . 
	pop af			;7c24	f1 	. 
	ret			;7c25	c9 	. 
l7c26h:
	ld c,a			;7c26	4f 	O 
	ld c,e			;7c27	4b 	K 
	rst 38h			;7c28	ff 	. 
l7c29h:
	ld c,(hl)			;7c29	4e 	N 
	ld b,a			;7c2a	47 	G 
	rst 38h			;7c2b	ff 	. 
l7c2ch:
	ld d,d			;7c2c	52 	R 
	ld c,a			;7c2d	4f 	O 
	ld c,l			;7c2e	4d 	M 
	rst 38h			;7c2f	ff 	. 
l7c30h:
	cp 014h		;7c30	fe 14 	. . 
	defb 0fdh,050h,0d1h	;illegal sequence		;7c32	fd 50 d1 	. P . 
	ld b,h			;7c35	44 	D 
	ld c,c			;7c36	49 	I 
	ld d,b			;7c37	50 	P 
	jr nz,l7c8dh		;7c38	20 53 	  S 
	ld d,a			;7c3a	57 	W 
	jr nz,$+1		;7c3b	20 ff 	  . 
	defb 0fdh,094h,0d1h	;illegal sequence		;7c3d	fd 94 d1 	. . . 
	ld b,h			;7c40	44 	D 
	ld d,e			;7c41	53 	S 
	ld d,a			;7c42	57 	W 
	ld sp,0d4fdh		;7c43	31 fd d4 	1 . . 
	pop de			;7c46	d1 	. 
	ld b,h			;7c47	44 	D 
	ld d,e			;7c48	53 	S 
	ld d,a			;7c49	57 	W 
	ld (0a3fdh),a		;7c4a	32 fd a3 	2 . . 
	pop de			;7c4d	d1 	. 
	ld sp,l4f2eh		;7c4e	31 2e 4f 	1 . O 
	ld c,(hl)			;7c51	4e 	N 
	ex (sp),iy		;7c52	fd e3 	. . 
	pop de			;7c54	d1 	. 
	jr nc,l7c85h		;7c55	30 2e 	0 . 
	ld c,a			;7c57	4f 	O 
	ld b,(hl)			;7c58	46 	F 
	ld b,(hl)			;7c59	46 	F 
	defb 0fdh,050h,0d3h	;illegal sequence		;7c5a	fd 50 d3 	. P . 
	ld b,d			;7c5d	42 	B 
	ld c,a			;7c5e	4f 	O 
	ld b,h			;7c5f	44 	D 
	ld e,c			;7c60	59 	Y 
	jr nz,l7cb7h		;7c61	20 54 	  T 
	ld e,c			;7c63	59 	Y 
	ld d,b			;7c64	50 	P 
	ld b,l			;7c65	45 	E 
	defb 0fdh,090h,0d3h	;illegal sequence		;7c66	fd 90 d3 	. . . 
	ld b,h			;7c69	44 	D 
	ld c,c			;7c6a	49 	I 
	ld b,(hl)			;7c6b	46 	F 
	ld b,(hl)			;7c6c	46 	F 
	ld c,c			;7c6d	49 	I 
	ld b,e			;7c6e	43 	C 
	ld d,l			;7c6f	55 	U 
	ld c,h			;7c70	4c 	L 
	ld d,h			;7c71	54 	T 
	ld e,c			;7c72	59 	Y 
	defb 0fdh,0d0h,0d3h	;illegal sequence		;7c73	fd d0 d3 	. . . 
	ld b,h			;7c76	44 	D 
	ld b,l			;7c77	45 	E 
	ld b,e			;7c78	43 	C 
	ld d,d			;7c79	52 	R 
	ld b,l			;7c7a	45 	E 
	ld b,c			;7c7b	41 	A 
	ld d,e			;7c7c	53 	S 
	ld b,l			;7c7d	45 	E 
	defb 0fdh,010h,0d4h	;illegal sequence		;7c7e	fd 10 d4 	. . . 
	ld b,(hl)			;7c81	46 	F 
	ld c,c			;7c82	49 	I 
	ld b,a			;7c83	47 	G 
	ld c,b			;7c84	48 	H 
l7c85h:
	ld d,h			;7c85	54 	T 
	ld b,l			;7c86	45 	E 
	ld d,d			;7c87	52 	R 
	ld d,e			;7c88	53 	S 
	defb 0fdh,090h,0d2h	;illegal sequence		;7c89	fd 90 d2 	. . . 
l7c8ch:
	ld b,e			;7c8c	43 	C 
l7c8dh:
	ld c,a			;7c8d	4f 	O 
	ld c,c			;7c8e	49 	I 
	ld c,(hl)			;7c8f	4e 	N 
	jr nz,l7cdfh		;7c90	20 4d 	  M 
	ld c,a			;7c92	4f 	O 
	ld b,h			;7c93	44 	D 
	ld b,l			;7c94	45 	E 
	rst 38h			;7c95	ff 	. 
l7c96h:
	ld d,h			;7c96	54 	T 
	ld b,c			;7c97	41 	A 
	ld b,d			;7c98	42 	B 
	ld c,h			;7c99	4c 	L 
	ld b,l			;7c9a	45 	E 
	jr nz,l7cbdh		;7c9b	20 20 	    
	rst 38h			;7c9d	ff 	. 
l7c9eh:
	ld d,l			;7c9e	55 	U 
	ld d,b			;7c9f	50 	P 
	ld d,d			;7ca0	52 	R 
	ld c,c			;7ca1	49 	I 
	ld b,a			;7ca2	47 	G 
	ld c,b			;7ca3	48 	H 
	ld d,h			;7ca4	54 	T 
	rst 38h			;7ca5	ff 	. 
l7ca6h:
	ld b,l			;7ca6	45 	E 
	ld b,c			;7ca7	41 	A 
	ld d,e			;7ca8	53 	S 
	ld e,c			;7ca9	59 	Y 
	jr nz,l7ccch		;7caa	20 20 	    
	jr nz,$+34		;7cac	20 20 	    
	jr nz,$+1		;7cae	20 ff 	  . 
l7cb0h:
	ld b,h			;7cb0	44 	D 
	ld c,c			;7cb1	49 	I 
	ld b,(hl)			;7cb2	46 	F 
	ld b,(hl)			;7cb3	46 	F 
	ld c,c			;7cb4	49 	I 
	ld b,e			;7cb5	43 	C 
	ld d,l			;7cb6	55 	U 
l7cb7h:
	ld c,h			;7cb7	4c 	L 
	ld d,h			;7cb8	54 	T 
	rst 38h			;7cb9	ff 	. 
l7cbah:
	ld d,e			;7cba	53 	S 
	ld c,h			;7cbb	4c 	L 
	ld c,a			;7cbc	4f 	O 
l7cbdh:
	ld d,a			;7cbd	57 	W 
	rst 38h			;7cbe	ff 	. 
l7cbfh:
	ld b,(hl)			;7cbf	46 	F 
	ld b,c			;7cc0	41 	A 
	ld d,e			;7cc1	53 	S 
	ld d,h			;7cc2	54 	T 
	rst 38h			;7cc3	ff 	. 
l7cc4h:
	jr nz,l7ce6h		;7cc4	20 20 	    
	jr nz,l7ce8h		;7cc6	20 20 	    
	jr nz,l7d10h		;7cc8	20 46 	  F 
	ld d,d			;7cca	52 	R 
	ld b,l			;7ccb	45 	E 
l7ccch:
	ld b,l			;7ccc	45 	E 
	jr nz,l7cefh		;7ccd	20 20 	    
	jr nz,l7d21h		;7ccf	20 50 	  P 
	ld c,h			;7cd1	4c 	L 
	ld b,c			;7cd2	41 	A 
	ld e,c			;7cd3	59 	Y 
l7cd4h:
	jr nz,l7cf6h		;7cd4	20 20 	    
	jr nz,$+1		;7cd6	20 ff 	  . 
l7cd8h:
	ld c,c			;7cd8	49 	I 
	ld c,(hl)			;7cd9	4e 	N 
	ld d,h			;7cda	54 	T 
	ld b,l			;7cdb	45 	E 
	ld d,d			;7cdc	52 	R 
	ld b,(hl)			;7cdd	46 	F 
	ld b,c			;7cde	41 	A 
l7cdfh:
	ld b,e			;7cdf	43 	C 
	ld b,l			;7ce0	45 	E 
	rst 38h			;7ce1	ff 	. 
	ld d,d			;7ce2	52 	R 
	ld b,l			;7ce3	45 	E 
	ld b,c			;7ce4	41 	A 
	ld b,h			;7ce5	44 	D 
l7ce6h:
	jr nz,l7d2ch		;7ce6	20 44 	  D 
l7ce8h:
	ld b,c			;7ce8	41 	A 
	ld d,h			;7ce9	54 	T 
	ld b,c			;7cea	41 	A 
	rst 38h			;7ceb	ff 	. 
l7cech:
	defb 0fdh,057h,0d5h	;illegal sequence		;7cec	fd 57 d5 	. W . 
l7cefh:
	ld d,h			;7cef	54 	T 
	ld c,c			;7cf0	49 	I 
	ld c,l			;7cf1	4d 	M 
	ld c,l			;7cf2	4d 	M 
	ld c,c			;7cf3	49 	I 
	ld c,(hl)			;7cf4	4e 	N 
	ld b,a			;7cf5	47 	G 
l7cf6h:
	rst 38h			;7cf6	ff 	. 
l7cf7h:
	cp 014h		;7cf7	fe 14 	. . 
	defb 0fdh,050h,0d1h	;illegal sequence		;7cf9	fd 50 d1 	. P . 
	jr nc,l7d2fh		;7cfc	30 31 	0 1 
	jr nz,l7d44h		;7cfe	20 44 	  D 
	ld c,c			;7d00	49 	I 
	ld d,b			;7d01	50 	P 
	jr nz,$+85		;7d02	20 53 	  S 
	ld d,a			;7d04	57 	W 
	ld c,c			;7d05	49 	I 
	ld d,h			;7d06	54 	T 
	ld b,e			;7d07	43 	C 
	ld c,b			;7d08	48 	H 
	defb 0fdh,090h,0d1h	;illegal sequence		;7d09	fd 90 d1 	. . . 
	jr nc,$+52		;7d0c	30 32 	0 2 
	jr nz,$+75		;7d0e	20 49 	  I 
l7d10h:
	cpl			;7d10	2f 	/ 
	ld c,a			;7d11	4f 	O 
	jr nz,$+82		;7d12	20 50 	  P 
	ld c,a			;7d14	4f 	O 
	ld d,d			;7d15	52 	R 
	ld d,h			;7d16	54 	T 
	defb 0fdh,0d0h,0d1h	;illegal sequence		;7d17	fd d0 d1 	. . . 
	jr nc,l7d4fh		;7d1a	30 33 	0 3 
	jr nz,l7d71h		;7d1c	20 53 	  S 
	ld c,a			;7d1e	4f 	O 
	ld d,l			;7d1f	55 	U 
	ld c,(hl)			;7d20	4e 	N 
l7d21h:
	ld b,h			;7d21	44 	D 
	defb 0fdh,010h,0d2h	;illegal sequence		;7d22	fd 10 d2 	. . . 
	jr nc,l7d5bh		;7d25	30 34 	0 4 
	jr nz,l7d6ch		;7d27	20 43 	  C 
	ld c,b			;7d29	48 	H 
	ld b,c			;7d2a	41 	A 
	ld d,d			;7d2b	52 	R 
l7d2ch:
	ld b,c			;7d2c	41 	A 
	ld b,e			;7d2d	43 	C 
	ld d,h			;7d2e	54 	T 
l7d2fh:
	ld b,l			;7d2f	45 	E 
	ld d,d			;7d30	52 	R 
	defb 0fdh,050h,0d2h	;illegal sequence		;7d31	fd 50 d2 	. P . 
	jr nc,$+55		;7d34	30 35 	0 5 
	jr nz,l7d7bh		;7d36	20 43 	  C 
	ld c,a			;7d38	4f 	O 
	ld c,h			;7d39	4c 	L 
	ld c,a			;7d3a	4f 	O 
	ld d,d			;7d3b	52 	R 
	defb 0fdh,090h,0d2h	;illegal sequence		;7d3c	fd 90 d2 	. . . 
	jr nc,l7d77h		;7d3f	30 36 	0 6 
	jr nz,l7d86h		;7d41	20 43 	  C 
	ld d,d			;7d43	52 	R 
l7d44h:
	ld c,a			;7d44	4f 	O 
	ld d,e			;7d45	53 	S 
	ld d,e			;7d46	53 	S 
	jr nz,$+74		;7d47	20 48 	  H 
	ld b,c			;7d49	41 	A 
	ld d,h			;7d4a	54 	T 
	ld b,e			;7d4b	43 	C 
	ld c,b			;7d4c	48 	H 
	jr nz,l7d9fh		;7d4d	20 50 	  P 
l7d4fh:
	ld b,c			;7d4f	41 	A 
	ld d,h			;7d50	54 	T 
	ld d,h			;7d51	54 	T 
	ld b,l			;7d52	45 	E 
	ld d,d			;7d53	52 	R 
	ld c,(hl)			;7d54	4e 	N 
	rst 38h			;7d55	ff 	. 
l7d56h:
	cp 014h		;7d56	fe 14 	. . 
	defb 0fdh,015h,0d1h	;illegal sequence		;7d58	fd 15 d1 	. . . 
l7d5bh:
	ld d,e			;7d5b	53 	S 
	ld c,a			;7d5c	4f 	O 
	ld d,l			;7d5d	55 	U 
	ld c,(hl)			;7d5e	4e 	N 
	ld b,h			;7d5f	44 	D 
	defb 0fdh,050h,0d1h	;illegal sequence		;7d60	fd 50 d1 	. P . 
	jr nc,l7d96h		;7d63	30 31 	0 1 
	jr nz,l7dc0h		;7d65	20 59 	  Y 
	ld b,l			;7d67	45 	E 
	ld c,h			;7d68	4c 	L 
	ld c,h			;7d69	4c 	L 
	jr nz,$+81		;7d6a	20 4f 	  O 
l7d6ch:
	ld b,(hl)			;7d6c	46 	F 
	jr nz,$+82		;7d6d	20 50 	  P 
	ld c,h			;7d6f	4c 	L 
	ld b,c			;7d70	41 	A 
l7d71h:
	ld e,c			;7d71	59 	Y 
	ld b,l			;7d72	45 	E 
	ld d,d			;7d73	52 	R 
	jr z,l7dc0h		;7d74	28 4a 	( J 
	ld d,l			;7d76	55 	U 
l7d77h:
	ld c,l			;7d77	4d 	M 
	ld d,b			;7d78	50 	P 
	dec l			;7d79	2d 	- 
	ld c,e			;7d7a	4b 	K 
l7d7bh:
	ld c,c			;7d7b	49 	I 
	ld b,e			;7d7c	43 	C 
	ld c,e			;7d7d	4b 	K 
	ld d,e			;7d7e	53 	S 
	add hl,hl			;7d7f	29 	) 
	defb 0fdh,093h,0d1h	;illegal sequence		;7d80	fd 93 d1 	. . . 
	ld b,e			;7d83	43 	C 
	ld d,d			;7d84	52 	R 
	ld b,l			;7d85	45 	E 
l7d86h:
	ld b,h			;7d86	44 	D 
	ld c,c			;7d87	49 	I 
	ld d,h			;7d88	54 	T 
	jr nz,l7dcch		;7d89	20 41 	  A 
	ld b,h			;7d8b	44 	D 
	ld b,h			;7d8c	44 	D 
	ld c,c			;7d8d	49 	I 
	ld c,(hl)			;7d8e	4e 	N 
	ld b,a			;7d8f	47 	G 
	jr nz,l7de5h		;7d90	20 53 	  S 
	ld c,a			;7d92	4f 	O 
	ld d,l			;7d93	55 	U 
	ld c,(hl)			;7d94	4e 	N 
	ld b,h			;7d95	44 	D 
l7d96h:
	defb 0fdh,0d0h,0d1h	;illegal sequence		;7d96	fd d0 d1 	. . . 
	jr nc,l7dcdh		;7d99	30 32 	0 2 
	jr nz,l7df6h		;7d9b	20 59 	  Y 
	ld b,l			;7d9d	45 	E 
	ld c,h			;7d9e	4c 	L 
l7d9fh:
	ld c,h			;7d9f	4c 	L 
	jr nz,l7df1h		;7da0	20 4f 	  O 
	ld b,(hl)			;7da2	46 	F 
	jr nz,l7df5h		;7da3	20 50 	  P 
	ld c,h			;7da5	4c 	L 
	ld b,c			;7da6	41 	A 
	ld e,c			;7da7	59 	Y 
	ld b,l			;7da8	45 	E 
	ld d,d			;7da9	52 	R 
	jr z,$+82		;7daa	28 50 	( P 
	ld d,l			;7dac	55 	U 
	ld c,(hl)			;7dad	4e 	N 
	ld b,e			;7dae	43 	C 
	ld c,b			;7daf	48 	H 
	ld b,l			;7db0	45 	E 
	ld d,e			;7db1	53 	S 
	inc l			;7db2	2c 	, 
	ld c,e			;7db3	4b 	K 
	ld c,c			;7db4	49 	I 
	ld b,e			;7db5	43 	C 
	ld c,e			;7db6	4b 	K 
	ld d,e			;7db7	53 	S 
	add hl,hl			;7db8	29 	) 
	defb 0fdh,010h,0d2h	;illegal sequence		;7db9	fd 10 d2 	. . . 
	jr nc,l7df1h		;7dbc	30 33 	0 3 
	jr nz,$+73		;7dbe	20 47 	  G 
l7dc0h:
	ld d,d			;7dc0	52 	R 
	ld c,a			;7dc1	4f 	O 
	ld b,c			;7dc2	41 	A 
	ld c,(hl)			;7dc3	4e 	N 
	jr nz,l7e15h		;7dc4	20 4f 	  O 
	ld b,(hl)			;7dc6	46 	F 
	jr nz,$+82		;7dc7	20 50 	  P 
	ld c,h			;7dc9	4c 	L 
	ld b,c			;7dca	41 	A 
	ld e,c			;7dcb	59 	Y 
l7dcch:
	ld b,l			;7dcc	45 	E 
l7dcdh:
	ld d,d			;7dcd	52 	R 
	jr nz,$+81		;7dce	20 4f 	  O 
	ld d,d			;7dd0	52 	R 
	jr nz,l7e18h		;7dd1	20 45 	  E 
	ld c,(hl)			;7dd3	4e 	N 
	ld b,l			;7dd4	45 	E 
	ld c,l			;7dd5	4d 	M 
	ld e,c			;7dd6	59 	Y 
	defb 0fdh,050h,0d2h	;illegal sequence		;7dd7	fd 50 d2 	. P . 
	jr nc,$+54		;7dda	30 34 	0 4 
	jr nz,l7e2ah		;7ddc	20 4c 	  L 
	ld b,c			;7dde	41 	A 
	ld d,l			;7ddf	55 	U 
	ld b,a			;7de0	47 	G 
	ld c,b			;7de1	48 	H 
	ld c,c			;7de2	49 	I 
	ld c,(hl)			;7de3	4e 	N 
	ld b,a			;7de4	47 	G 
l7de5h:
	jr nz,l7e3dh		;7de5	20 56 	  V 
	ld c,a			;7de7	4f 	O 
	ld c,c			;7de8	49 	I 
	ld b,e			;7de9	43 	C 
	ld b,l			;7dea	45 	E 
	jr nz,l7e3ch		;7deb	20 4f 	  O 
	ld b,(hl)			;7ded	46 	F 
	jr nz,l7e35h		;7dee	20 45 	  E 
	ld c,(hl)			;7df0	4e 	N 
l7df1h:
	ld b,l			;7df1	45 	E 
	ld c,l			;7df2	4d 	M 
	ld c,c			;7df3	49 	I 
	ld b,l			;7df4	45 	E 
l7df5h:
	ld d,e			;7df5	53 	S 
l7df6h:
	dec l			;7df6	2d 	- 
	ld sp,090fdh		;7df7	31 fd 90 	1 . . 
	jp nc,03530h		;7dfa	d2 30 35 	. 0 5 
	jr nz,l7e4bh		;7dfd	20 4c 	  L 
sub_7dffh:
	ld b,c			;7dff	41 	A 
	ld d,l			;7e00	55 	U 
	ld b,a			;7e01	47 	G 
	ld c,b			;7e02	48 	H 
	ld c,c			;7e03	49 	I 
	ld c,(hl)			;7e04	4e 	N 
	ld b,a			;7e05	47 	G 
	jr nz,l7e5eh		;7e06	20 56 	  V 
	ld c,a			;7e08	4f 	O 
	ld c,c			;7e09	49 	I 
	ld b,e			;7e0a	43 	C 
	ld b,l			;7e0b	45 	E 
	jr nz,$+81		;7e0c	20 4f 	  O 
	ld b,(hl)			;7e0e	46 	F 
	jr nz,$+71		;7e0f	20 45 	  E 
	ld c,(hl)			;7e11	4e 	N 
	ld b,l			;7e12	45 	E 
	ld c,l			;7e13	4d 	M 
	ld c,c			;7e14	49 	I 
l7e15h:
	ld b,l			;7e15	45 	E 
	ld d,e			;7e16	53 	S 
	dec l			;7e17	2d 	- 
l7e18h:
	ld (0d0fdh),a		;7e18	32 fd d0 	2 . . 
	jp nc,03630h		;7e1b	d2 30 36 	. 0 6 
	jr nz,l7e62h		;7e1e	20 42 	  B 
	ld d,l			;7e20	55 	U 
	ld d,d			;7e21	52 	R 
	ld d,e			;7e22	53 	S 
	ld d,h			;7e23	54 	T 
	ld c,c			;7e24	49 	I 
	ld c,(hl)			;7e25	4e 	N 
	ld b,a			;7e26	47 	G 
	jr nz,l7e78h		;7e27	20 4f 	  O 
	ld b,(hl)			;7e29	46 	F 
l7e2ah:
	jr nz,$+82		;7e2a	20 50 	  P 
	ld b,c			;7e2c	41 	A 
	ld d,b			;7e2d	50 	P 
	ld b,l			;7e2e	45 	E 
	ld d,d			;7e2f	52 	R 
	jr nz,l7e74h		;7e30	20 42 	  B 
	ld b,c			;7e32	41 	A 
	ld c,h			;7e33	4c 	L 
	ld c,h			;7e34	4c 	L 
l7e35h:
	defb 0fdh,013h,0d3h	;illegal sequence		;7e35	fd 13 d3 	. . . 
	ld b,d			;7e38	42 	B 
	ld d,l			;7e39	55 	U 
	ld d,d			;7e3a	52 	R 
	ld d,e			;7e3b	53 	S 
l7e3ch:
	ld d,h			;7e3c	54 	T 
l7e3dh:
	ld c,c			;7e3d	49 	I 
	ld c,(hl)			;7e3e	4e 	N 
	ld b,a			;7e3f	47 	G 
	jr nz,$+81		;7e40	20 4f 	  O 
	ld b,(hl)			;7e42	46 	F 
	jr nz,l7e89h		;7e43	20 44 	  D 
	ld d,d			;7e45	52 	R 
	ld b,c			;7e46	41 	A 
	ld b,a			;7e47	47 	G 
	ld c,a			;7e48	4f 	O 
	ld c,(hl)			;7e49	4e 	N 
	daa			;7e4a	27 	' 
l7e4bh:
	ld d,e			;7e4b	53 	S 
	jr nz,l7e93h		;7e4c	20 45 	  E 
	ld b,a			;7e4e	47 	G 
	ld b,a			;7e4f	47 	G 
	defb 0fdh,050h,0d3h	;illegal sequence		;7e50	fd 50 d3 	. P . 
	jr nc,l7e8ch		;7e53	30 37 	0 7 
	jr nz,l7eaah		;7e55	20 53 	  S 
	ld c,b			;7e57	48 	H 
	ld d,d			;7e58	52 	R 
	ld c,c			;7e59	49 	I 
	ld b,l			;7e5a	45 	E 
	ld c,e			;7e5b	4b 	K 
	jr nz,l7eadh		;7e5c	20 4f 	  O 
l7e5eh:
	ld b,(hl)			;7e5e	46 	F 
	jr nz,l7eb1h		;7e5f	20 50 	  P 
	ld c,h			;7e61	4c 	L 
l7e62h:
	ld b,c			;7e62	41 	A 
	ld e,c			;7e63	59 	Y 
	ld b,l			;7e64	45 	E 
	ld d,d			;7e65	52 	R 
	defb 0fdh,090h,0d3h	;illegal sequence		;7e66	fd 90 d3 	. . . 
	jr nc,$+58		;7e69	30 38 	0 8 
	jr nz,$+82		;7e6b	20 50 	  P 
	ld c,h			;7e6d	4c 	L 
	ld b,c			;7e6e	41 	A 
	ld e,c			;7e6f	59 	Y 
	ld b,l			;7e70	45 	E 
	ld d,d			;7e71	52 	R 
	jr nz,l7ec6h		;7e72	20 52 	  R 
l7e74h:
	ld d,l			;7e74	55 	U 
	ld c,(hl)			;7e75	4e 	N 
	ld c,(hl)			;7e76	4e 	N 
	ld c,c			;7e77	49 	I 
l7e78h:
	ld c,(hl)			;7e78	4e 	N 
	ld b,a			;7e79	47 	G 
	defb 0fdh,0d0h,0d3h	;illegal sequence		;7e7a	fd d0 d3 	. . . 
	jr nc,l7eb8h		;7e7d	30 39 	0 9 
	jr nz,$+74		;7e7f	20 48 	  H 
	ld c,c			;7e81	49 	I 
	ld d,h			;7e82	54 	T 
	ld d,h			;7e83	54 	T 
	ld c,c			;7e84	49 	I 
	ld c,(hl)			;7e85	4e 	N 
	ld b,a			;7e86	47 	G 
	jr nz,l7edch		;7e87	20 53 	  S 
l7e89h:
	ld c,a			;7e89	4f 	O 
	ld d,l			;7e8a	55 	U 
	ld c,(hl)			;7e8b	4e 	N 
l7e8ch:
	ld b,h			;7e8c	44 	D 
	defb 0fdh,010h,0d4h	;illegal sequence		;7e8d	fd 10 d4 	. . . 
	ld sp,02030h		;7e90	31 30 20 	1 0   
l7e93h:
	ld d,e			;7e93	53 	S 
	ld d,a			;7e94	57 	W 
	ld c,c			;7e95	49 	I 
	ld d,e			;7e96	53 	S 
	ld c,b			;7e97	48 	H 
	ld c,c			;7e98	49 	I 
	ld c,(hl)			;7e99	4e 	N 
	ld b,a			;7e9a	47 	G 
	jr nz,$+85		;7e9b	20 53 	  S 
	ld c,a			;7e9d	4f 	O 
	ld d,l			;7e9e	55 	U 
	ld c,(hl)			;7e9f	4e 	N 
	ld b,h			;7ea0	44 	D 
	defb 0fdh,050h,0d4h	;illegal sequence		;7ea1	fd 50 d4 	. P . 
	ld sp,02031h		;7ea4	31 31 20 	1 1   
	ld b,d			;7ea7	42 	B 
	ld d,l			;7ea8	55 	U 
	ld d,d			;7ea9	52 	R 
l7eaah:
	ld d,e			;7eaa	53 	S 
	ld d,h			;7eab	54 	T 
	ld c,c			;7eac	49 	I 
l7eadh:
	ld c,(hl)			;7ead	4e 	N 
	ld b,a			;7eae	47 	G 
	jr nz,l7f00h		;7eaf	20 4f 	  O 
l7eb1h:
	ld b,(hl)			;7eb1	46 	F 
	jr nz,$+85		;7eb2	20 53 	  S 
	ld c,(hl)			;7eb4	4e 	N 
	ld b,c			;7eb5	41 	A 
	ld c,e			;7eb6	4b 	K 
	ld b,l			;7eb7	45 	E 
l7eb8h:
	jr nz,l7f0ah		;7eb8	20 50 	  P 
	ld c,a			;7eba	4f 	O 
	ld d,h			;7ebb	54 	T 
	defb 0fdh,090h,0d4h	;illegal sequence		;7ebc	fd 90 d4 	. . . 
	ld sp,02032h		;7ebf	31 32 20 	1 2   
	ld b,d			;7ec2	42 	B 
	ld c,c			;7ec3	49 	I 
	ld d,h			;7ec4	54 	T 
	ld c,c			;7ec5	49 	I 
l7ec6h:
	ld c,(hl)			;7ec6	4e 	N 
	ld b,a			;7ec7	47 	G 
	jr nz,$+85		;7ec8	20 53 	  S 
	ld c,a			;7eca	4f 	O 
	ld d,l			;7ecb	55 	U 
	ld c,(hl)			;7ecc	4e 	N 
	ld b,h			;7ecd	44 	D 
	defb 0fdh,0d0h,0d4h	;illegal sequence		;7ece	fd d0 d4 	. . . 
	ld sp,02033h		;7ed1	31 33 20 	1 3   
	ld d,e			;7ed4	53 	S 
	ld c,a			;7ed5	4f 	O 
	ld d,l			;7ed6	55 	U 
	ld c,(hl)			;7ed7	4e 	N 
	ld b,h			;7ed8	44 	D 
	jr nz,l7f2ah		;7ed9	20 4f 	  O 
	ld b,(hl)			;7edb	46 	F 
l7edch:
	jr nz,l7f29h		;7edc	20 4b 	  K 
	ld c,(hl)			;7ede	4e 	N 
	ld c,c			;7edf	49 	I 
	ld d,(hl)			;7ee0	56 	V 
	ld b,l			;7ee1	45 	E 
	ld d,e			;7ee2	53 	S 
	inc l			;7ee3	2c 	, 
	ld b,d			;7ee4	42 	B 
	ld c,a			;7ee5	4f 	O 
	ld c,a			;7ee6	4f 	O 
	ld c,l			;7ee7	4d 	M 
	ld b,l			;7ee8	45 	E 
	ld d,d			;7ee9	52 	R 
	ld b,c			;7eea	41 	A 
	ld c,(hl)			;7eeb	4e 	N 
	ld b,a			;7eec	47 	G 
	ld d,e			;7eed	53 	S 
	defb 0fdh,010h,0d5h	;illegal sequence		;7eee	fd 10 d5 	. . . 
	ld sp,02034h		;7ef1	31 34 20 	1 4   
	ld b,e			;7ef4	43 	C 
	ld c,a			;7ef5	4f 	O 
	ld d,l			;7ef6	55 	U 
	ld c,(hl)			;7ef7	4e 	N 
	ld d,h			;7ef8	54 	T 
	ld c,c			;7ef9	49 	I 
	ld c,(hl)			;7efa	4e 	N 
	ld b,a			;7efb	47 	G 
	jr nz,l7f4eh		;7efc	20 50 	  P 
	ld c,a			;7efe	4f 	O 
	ld c,c			;7eff	49 	I 
l7f00h:
	ld c,(hl)			;7f00	4e 	N 
sub_7f01h:
	ld d,h			;7f01	54 	T 
	ld d,e			;7f02	53 	S 
	defb 0fdh,050h,0d5h	;illegal sequence		;7f03	fd 50 d5 	. P . 
	ld sp,02035h		;7f06	31 35 20 	1 5   
	ld b,a			;7f09	47 	G 
l7f0ah:
	ld b,c			;7f0a	41 	A 
	ld c,l			;7f0b	4d 	M 
	ld b,l			;7f0c	45 	E 
	jr nz,l7f62h		;7f0d	20 53 	  S 
	ld d,h			;7f0f	54 	T 
	ld b,c			;7f10	41 	A 
	ld d,d			;7f11	52 	R 
	ld d,h			;7f12	54 	T 
	defb 0fdh,090h,0d5h	;illegal sequence		;7f13	fd 90 d5 	. . . 
	ld sp,02036h		;7f16	31 36 20 	1 6   
	ld b,d			;7f19	42 	B 
	ld b,a			;7f1a	47 	G 
	ld c,l			;7f1b	4d 	M 
	defb 0fdh,0d0h,0d5h	;illegal sequence		;7f1c	fd d0 d5 	. . . 
	ld sp,02037h		;7f1f	31 37 20 	1 7   
	ld b,e			;7f22	43 	C 
	ld c,a			;7f23	4f 	O 
	ld c,l			;7f24	4d 	M 
	ld d,b			;7f25	50 	P 
	ld c,h			;7f26	4c 	L 
	ld b,l			;7f27	45 	E 
	ld d,h			;7f28	54 	T 
l7f29h:
	ld c,c			;7f29	49 	I 
l7f2ah:
	ld c,a			;7f2a	4f 	O 
	ld c,(hl)			;7f2b	4e 	N 
	jr nz,$+81		;7f2c	20 4f 	  O 
	ld b,(hl)			;7f2e	46 	F 
	jr nz,l7f76h		;7f2f	20 45 	  E 
	ld b,c			;7f31	41 	A 
	ld b,e			;7f32	43 	C 
	ld c,b			;7f33	48 	H 
	jr nz,l7f86h		;7f34	20 50 	  P 
	ld b,c			;7f36	41 	A 
	ld d,h			;7f37	54 	T 
	ld d,h			;7f38	54 	T 
	ld b,l			;7f39	45 	E 
	ld d,d			;7f3a	52 	R 
	ld c,(hl)			;7f3b	4e 	N 
	defb 0fdh,010h,0d6h	;illegal sequence		;7f3c	fd 10 d6 	. . . 
	ld sp,02038h		;7f3f	31 38 20 	1 8   
	ld b,e			;7f42	43 	C 
	ld c,a			;7f43	4f 	O 
	ld c,l			;7f44	4d 	M 
	ld d,b			;7f45	50 	P 
	ld c,h			;7f46	4c 	L 
	ld b,l			;7f47	45 	E 
	ld d,h			;7f48	54 	T 
	ld c,c			;7f49	49 	I 
	ld c,a			;7f4a	4f 	O 
	ld c,(hl)			;7f4b	4e 	N 
	jr nz,l7f9dh		;7f4c	20 4f 	  O 
l7f4eh:
	ld b,(hl)			;7f4e	46 	F 
	jr nz,l7f98h		;7f4f	20 47 	  G 
	ld b,c			;7f51	41 	A 
	ld c,l			;7f52	4d 	M 
	ld b,l			;7f53	45 	E 
	defb 0fdh,050h,0d6h	;illegal sequence		;7f54	fd 50 d6 	. P . 
	ld sp,02039h		;7f57	31 39 20 	1 9   
	ld b,a			;7f5a	47 	G 
	ld b,c			;7f5b	41 	A 
	ld c,l			;7f5c	4d 	M 
	ld b,l			;7f5d	45 	E 
	jr nz,l7fafh		;7f5e	20 4f 	  O 
	ld d,(hl)			;7f60	56 	V 
	ld b,l			;7f61	45 	E 
l7f62h:
	ld d,d			;7f62	52 	R 
	defb 0fdh,090h,0d6h	;illegal sequence		;7f63	fd 90 d6 	. . . 
	ld (02030h),a		;7f66	32 30 20 	2 0   
	ld d,h			;7f69	54 	T 
	ld c,c			;7f6a	49 	I 
	ld c,l			;7f6b	4d 	M 
	ld b,l			;7f6c	45 	E 
	jr nz,l7fc4h		;7f6d	20 55 	  U 
	ld d,b			;7f6f	50 	P 
	jr nz,l7fc9h		;7f70	20 57 	  W 
	ld b,c			;7f72	41 	A 
	ld d,d			;7f73	52 	R 
	ld c,(hl)			;7f74	4e 	N 
	ld c,c			;7f75	49 	I 
l7f76h:
	ld c,(hl)			;7f76	4e 	N 
	ld b,a			;7f77	47 	G 
	defb 0fdh,0d0h,0d6h	;illegal sequence		;7f78	fd d0 d6 	. . . 
	ld (02031h),a		;7f7b	32 31 20 	2 1   
	ld b,c			;7f7e	41 	A 
	ld b,h			;7f7f	44 	D 
	ld b,h			;7f80	44 	D 
	ld c,c			;7f81	49 	I 
	ld d,h			;7f82	54 	T 
	ld c,c			;7f83	49 	I 
	ld c,a			;7f84	4f 	O 
	ld c,(hl)			;7f85	4e 	N 
l7f86h:
	ld b,c			;7f86	41 	A 
	ld c,h			;7f87	4c 	L 
	jr nz,l7fd0h		;7f88	20 46 	  F 
	ld c,c			;7f8a	49 	I 
	ld b,a			;7f8b	47 	G 
	ld c,b			;7f8c	48 	H 
	ld d,h			;7f8d	54 	T 
	ld b,l			;7f8e	45 	E 
	ld d,d			;7f8f	52 	R 
	defb 0fdh,016h,0d7h	;illegal sequence		;7f90	fd 16 d7 	. . . 
	ld c,l			;7f93	4d 	M 
	ld d,l			;7f94	55 	U 
	ld d,e			;7f95	53 	S 
	ld c,c			;7f96	49 	I 
	ld b,e			;7f97	43 	C 
l7f98h:
	jr nz,l7fdfh		;7f98	20 45 	  E 
	ld c,(hl)			;7f9a	4e 	N 
	ld b,h			;7f9b	44 	D 
	rst 38h			;7f9c	ff 	. 
l7f9dh:
	rst 0			;7f9d	c7 	. 
	rst 0			;7f9e	c7 	. 
	rst 0			;7f9f	c7 	. 
	rst 0			;7fa0	c7 	. 
	rst 0			;7fa1	c7 	. 
	rst 0			;7fa2	c7 	. 
	rst 0			;7fa3	c7 	. 
	rst 0			;7fa4	c7 	. 
	rst 0			;7fa5	c7 	. 
	rst 0			;7fa6	c7 	. 
	rst 0			;7fa7	c7 	. 
	rst 0			;7fa8	c7 	. 
	rst 0			;7fa9	c7 	. 
	rst 0			;7faa	c7 	. 
	rst 0			;7fab	c7 	. 
	rst 0			;7fac	c7 	. 
	rst 0			;7fad	c7 	. 
	rst 0			;7fae	c7 	. 
l7fafh:
	rst 0			;7faf	c7 	. 
	rst 0			;7fb0	c7 	. 
	rst 0			;7fb1	c7 	. 
	rst 0			;7fb2	c7 	. 
	rst 0			;7fb3	c7 	. 
	rst 0			;7fb4	c7 	. 
	rst 0			;7fb5	c7 	. 
	rst 0			;7fb6	c7 	. 
	rst 0			;7fb7	c7 	. 
	rst 0			;7fb8	c7 	. 
	rst 0			;7fb9	c7 	. 
	rst 0			;7fba	c7 	. 
	rst 0			;7fbb	c7 	. 
	rst 0			;7fbc	c7 	. 
	rst 0			;7fbd	c7 	. 
	rst 0			;7fbe	c7 	. 
	rst 0			;7fbf	c7 	. 
	rst 0			;7fc0	c7 	. 
	rst 0			;7fc1	c7 	. 
	rst 0			;7fc2	c7 	. 
	rst 0			;7fc3	c7 	. 
l7fc4h:
	rst 0			;7fc4	c7 	. 
	rst 0			;7fc5	c7 	. 
	rst 0			;7fc6	c7 	. 
	rst 0			;7fc7	c7 	. 
	rst 0			;7fc8	c7 	. 
l7fc9h:
	rst 0			;7fc9	c7 	. 
	rst 0			;7fca	c7 	. 
	rst 0			;7fcb	c7 	. 
	rst 0			;7fcc	c7 	. 
	rst 0			;7fcd	c7 	. 
	rst 0			;7fce	c7 	. 
	rst 0			;7fcf	c7 	. 
l7fd0h:
	rst 0			;7fd0	c7 	. 
	rst 0			;7fd1	c7 	. 
	rst 0			;7fd2	c7 	. 
	rst 0			;7fd3	c7 	. 
	rst 0			;7fd4	c7 	. 
	rst 0			;7fd5	c7 	. 
	rst 0			;7fd6	c7 	. 
	rst 0			;7fd7	c7 	. 
	rst 0			;7fd8	c7 	. 
	rst 0			;7fd9	c7 	. 
	rst 0			;7fda	c7 	. 
	rst 0			;7fdb	c7 	. 
	rst 0			;7fdc	c7 	. 
	rst 0			;7fdd	c7 	. 
	rst 0			;7fde	c7 	. 
l7fdfh:
	rst 0			;7fdf	c7 	. 
	rst 0			;7fe0	c7 	. 
	rst 0			;7fe1	c7 	. 
	rst 0			;7fe2	c7 	. 
	rst 0			;7fe3	c7 	. 
	rst 0			;7fe4	c7 	. 
	rst 0			;7fe5	c7 	. 
	rst 0			;7fe6	c7 	. 
	rst 0			;7fe7	c7 	. 
	rst 0			;7fe8	c7 	. 
	rst 0			;7fe9	c7 	. 
	rst 0			;7fea	c7 	. 
	rst 0			;7feb	c7 	. 
	rst 0			;7fec	c7 	. 
	rst 0			;7fed	c7 	. 
	rst 0			;7fee	c7 	. 
	rst 0			;7fef	c7 	. 
	rst 0			;7ff0	c7 	. 
	rst 0			;7ff1	c7 	. 
	rst 0			;7ff2	c7 	. 
	rst 0			;7ff3	c7 	. 
	rst 0			;7ff4	c7 	. 
	rst 0			;7ff5	c7 	. 
	rst 0			;7ff6	c7 	. 
	rst 0			;7ff7	c7 	. 
	rst 0			;7ff8	c7 	. 
	rst 0			;7ff9	c7 	. 
	rst 0			;7ffa	c7 	. 
	rst 0			;7ffb	c7 	. 
	rst 0			;7ffc	c7 	. 
	rst 0			;7ffd	c7 	. 
	rst 0			;7ffe	c7 	. 
	rst 0			;7fff	c7 	. 
