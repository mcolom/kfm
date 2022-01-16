; z80dasm 1.1.4
; command line: z80dasm -g0 -l -t roms/a-4e-c.bin

; Check:
; $ z80asm dis/joint.asm && shasum a.bin
; d1d0db9da8c251c482821ce6fd4f4824e0b72d55  a.bin

; The resolution if 32x32 tiles, each one of 8x8 pixels.
; The 6 first rows are not affected by the scroll settings
; Actually M62 stores 32 rows and 64 columns of which 32 are
; visible according to the vertical scroll setting.


; BUG
; Conditions:
; - 4th floor
; - the magician is blocked against the stairs
; - its replica appears on the left
; - Thomas is in the middle of both
; - Thomas can reach both of two with the punch
; - Thomas kills the replica on the left quickly
; Then Thomas can't move right.

; Examples of macros
makelabel: macro name
	label_name:
endm

callf: macro slot address
	rst 0x30 db slot dw address
endm

; ************************ I/O ports ************************

; Irem audio on port 0
InSystem: macro
	in a,(000h)
endm
;
OutIremAudio: macro
	out (000h),a
endm

; P1 joystick, flipscreen, and coin counters on port 1
InP1Controls: macro
	in a,(001h)
endm
;
OutP1Flipscreen: macro
	out (001h),a
endm

; P2 joystick on port 2
InP2Controls: macro
	in a,(002h)
endm

; DIP switches.
; For their meaning look in ./src/mame/drivers/m62.cpp, in
; "static INPUT_PORTS_START( common )" and in
; "static INPUT_PORTS_START( kungfum )".
; In MAME's code the notation "SW2:i" the index i goes from 1 to 8, so
; the actual bit is i-1 starting from zero.

; DSW1 on port 3
InDSW1: macro
	in a,(003h)
endm

; DSW2 on port 4
InDSW2: macro
	in a,(004h)
endm

; Screen is character-based and memory-mapped
SCREEN_ADDR: EQU 0xD010

M62_HSCROLL_LOW_W: EQU 0xA000
M62_HSCROLL_HIGH_W: EQU 0xB000

HSCROLL_LOW_W: EQU 0xE902
HSCROLL_HIGH_W: EQU HSCROLL_LOW_W + 1

M62_SPRITERAM: EQU 0xC000

M62_TILERAM: EQU 0xD000
M62_TILERAM_COLORS: EQU M62_TILERAM + 32*2*32

; Avoids showing the text about the player number, floor, and "READY".
AVOID_SHOWING_FLOOR_INTRO_TEXT: EQU 0xE81C

; A counter which is updated by the Z80's periodic interrupt
INT_COUNTER: EQU 0xE880

EXT_RANDOM: EQU 0xE010
EXT_TICKS: EQU 0xE020

; Pointer to the current position in the fake input table
DEMO_FAKE_INPUT_ADDR: EQU 0xE023

; The game cycles the demo level shown, between level 1 and 2.
; 0: level 2 shown
; 9: level 1 shown
; This variable is used to set the value of DEMO_FAKE_INPUT_ADDR
DEMO_LEVEL: EQU 0xE025

LIVES: EQU 0xE084
DRAGONS_LEVEL: EQU 0xE080 ; 00 DDD LLL, where D is the number of dragons, and L the level - 1.

; This controls at which stage of the floor Thomas is.
; The stage changes at the middle of the floor, and it can have falling
; magical elements, butterflies, or normal enemies. 
;
; 0: normal enemies
; 3, 4: falling magical elements of level 2
; 11, 12: butterflies, 
FLOOR_STAGE: EQU 0xE100




; This variable controls if it should avoid giving an extra life because
; it was already given (bit #0) and to skip the letter scene (bit #1).
SKIP_LETTER_SKIP_EXTRA_LIFE: EQU 0xE085


ENERGY: EQU 0xE709
ENERGY_DISP: EQU 0xE81A ; Displayed energy. Use to animate the bar when energy changes


; 1, knife, dragon, 3: snake, bursting ball
ORIGIN_OF_DAMAGE: EQU 0xE720

ENERGY_TO_SUBTRACT: EQU 0xE721

HEIGHT_OF_DAMAGE_TO_THOMAS: EQU 0xE722

; Bit 0: receiving damage (it changes the displayed frame)
; Bit 1: dying (all energy lost or time over)
THOMAS_DAMAGE_STATUS: EQU 0xE71F

ENEMY_ENERGY_DISP: EQU 0xE819 ; Displayed enemy's energy. Use to animate the bar when energy changes

POINTS: EQU 0xE081 ; Points, E081... E083
POINTS_P2: EQU 0xE091 ; Points, E091... E093
POINTS_TOP: EQU 0xE980 ; Points, E080... E082

; The points are visible until this counter reaches zero
POINTS_VISIBLE_COUNTER: EQU 0xE64C

STEP_COUNTER: EQU 0xE883

NUM_GRIPPING: EQU 0xE71A
ACTIVE_GRIPPERS_LEFT: EQU 0xE71B
ACTIVE_GRIPPERS_RIGHT: EQU 0xE71D

; Grippers, knifers, and tom-toms
include 'guys.asm'

; The boomerangs thrown by the boss at level #2
include 'boomerang.asm'

; Bosses and other enemies
include 'enemies.asm'

; Magical elements, mainly at the beginning of level #2
include 'magical_elements.asm'

; The moths at level #4
include 'moths.asm'


; The head of the magician. Creepy!
TBL_HEAD: EQU 0xE31B

; This is related to the boss at level #3, but not understood yet.
; Bit 7 read at 1333, wrote at 137E
; Length 35
TBL_E10A: EQU 0xE10A

; Length 29
TBL_E19C: EQU 0xE19C

; 1 word
VAR_E1B9: EQU 0xE1B9

; Seems related to the moths at 4th floor
TBL_E521_LEN: EQU 0xE520
TBL_E521: EQU 0xE521



TABLE_WIDTH_41_LEN: EQU 0xE549
TABLE_WIDTH_41: EQU 0xE54A

TBL_E562: EQU 0xE562






DISTANCE_TO_LEFT: EQU 0xE802

; 10: Silvia look left and moves right when kidnapped
; 50: the opposite
SILVIA_LEFT_OR_RIGHT: EQU 0xE340

; This activates during just before interlude and when Silvia get untied
; Values: 0 (clean up), 0x10, 0x40
SILVIA_STATE: EQU 0xE34C



; Absolute position of Thomas ìn the complete floor
THOMAS_POSITION: EQU 0xE712 ; Left end is 0
THOMAS_POSITION_H: EQU THOMAS_POSITION + 1

PLAYER_CONTROLS: EQU 0xE907 ; It seems this contains everything in a single byte
PLAYER_BUTTONS_AND_UP:  EQU 0xE908

; This is the effective movement.
; The difference between PLAYER_MOVE and PLAYER_INPUT is that
; PLAYER_INPUT is very low-level and PLAYER_MOVE is computed.
; Thus, during the demo PLAYER_MOVE will be written.
PLAYER_MOVE: EQU 0xE909


; Call 7be8 to figure out the values

PLAYER_INPUT_COINS_P1P2_BUTTONS: EQU 0xE904
; bit #0: P1 pressed
; bit #1: P2 pressed
; bit #3: coin A inserted
; bit #4: coin B inserted


; Player input (joystick, kick/punch buttons bitmask).
; This variable is updated continuosly, even when not playing.
;
; Bit #0: joystick pushing right
; Bit #1: joystick pushing left
; Bit #2: joystick pushing down
; Bit #3: joystick pushing up
; Bit #4: unused
; Bit #5: punch button pressed
; Bit #6: unused
; Bit #7: kick button pressed
PLAYER_INPUT: EQU 0xE906

KNIFE_STATUS: EQU 0xE807
KNIFE_DIST: EQU 0xE32E
NUM_KNIVES: EQU 0xE32B


; Bit #0 controls if the screen show be flipped.
; The code checks this variable and performs the actual flip by
; calling OutP1Flipscreen @ 0d89.
FLIP_SCREEN: EQU 0xE910

; Its value is related to the detection of the coin sensor
; It activates for both the A and B counters
COIN_SENSOR: EQU 0xE911

; Number of coins inserted so far before granting a credit.
; It becomes 0 when a credit is given
COINS_INSERTED_BEFORE_CREDIT: EQU 0xE912

; 0: it forces 2 coins
; 1..7: number of coins needed add one credit
; 8: no credits added regardless the number of introduced coins 
; 9: one coin to add one credit
; A: 1 coin gives 2 credits
; B: 1 coin gives 3 credits
; 0x11: 1 coin gives 9 credits
; 0x18: 1 coin gives 10 credits
; 0x20: 1 coin gives 18 credits
; 0x25: 1 coin gives 23 credits
; 0x13: 1 coin gives 12 credits
; ...
COINS_PER_CREDITS_A: EQU 0xE90A
;COINS_PER_CREDITS_B: EQU COINS_PER_CREDITS_A + 1 ;0e90bh

; These activate with value 1 when a coin in inserted, counters A or B.
COIN_INSERTED_A: EQU 0xE90C
COIN_INSERTED_B: EQU 0xE90E





; State of the floor's hatch
; 0: starting to close
; 1: middle closed
; 2: open, normal gaming
HATCH_STATE: EQU 0xE915

; Audio channel, 1.. 15
AUDIO_CHANNEL: EQU 0xE917

; Sound codes at each of the 15 channels
SOUNDS_IN_CHANNELS_LIST: EQU AUDIO_CHANNEL + 1






COINS: EQU 0xE913



; Tip: in the intro screen, set 0xE000 (GAME_STATE) to 2, and
; change THOMAS_FRAME to see the sprite parts.
; Interesting: 11, 20, 21, 24, 25, 27, 2F, 47, 4E, 54, 59
THOMAS_FRAME: EQU 0xE706
;
THOMAS_FRAME_NORMAL: EQU 0
THOMAS_FRAME_STANDING: EQU 3
THOMAS_FRAME_READY: EQU 4
THOMAS_FRAME_DOWN: EQU 5
THOMAS_FRAME_KICK: EQU 6
THOMAS_FRAME_START_KICK_DOWN: EQU 0xB
THOMAS_FRAME_JUMP_IMPULSE: EQU 0x10
THOMAS_FRAME_JUMP_KICK: EQU 0x1C
THOMAS_FRAME_START_JUMP: EQU 0x1F
THOMAS_FRAME_JUMP_PAIN: EQU 0x20
THOMAS_FRAME_WITH_SILVIA: EQU 0x26


; Thomas' properties bitmask.
;
; Bit #0: Thomas is frozen. Used by the magician at level 4.
; Bit #1: Thomas is not playing. For example: going upstairs or falling down dead
; Bit #2: (unused)
; Bit #3: (unused)
; Bit #4: Related to the activity of the boss
; Bit #5: 0=Thomas looking to the left. 1=Thomas looking to the right.
; Bit #6: Make the knifer in presence of the boomerang boss send his dagger to the right.
;         This is probably because the the boss configures sending boomerangs and daggers to the left, but
;         for this particular knifer we need that he sends to the right instead. Tricky. It seems like a workaround.
; Bit #7: (unused)
THOMAS_PROPS: EQU 0xE700

; Thomas' state
; 0: idle
; 1: walking
; 2, 3: duck down
; 4: frontal kick
; 5: frontal punch
; 6: down kick
; 7: down punch
; 8: jumping
; 9: jump ahead
; A: <unknown>
; B: receiving damage (i.e. from a knife)
; C: falling dead
; D: receiving damage while jumping
THOMAS_STATE: EQU 0xE702
;
THOMAS_STATE_IDLE: EQU 0
THOMAS_STATE_WALKING: EQU 1
THOMAS_STATE_DUCKING_1: EQU 2
THOMAS_STATE_DUCKING_2: EQU 3
THOMAS_STATE_FRONTAL_KICK: EQU 4
THOMAS_STATE_FRONTAL_PUNCH: EQU 5
THOMAS_STATE_DOWN_KICK: EQU 6
THOMAS_STATE_DOWN_PUNCH: EQU 7
THOMAS_STATE_JUMPING: EQU 8
THOMAS_STATE_JUMPING_AHEAD: EQU 9
THOMAS_STATE_UNKNOWN: EQU 10 ; Probably unused
THOMAS_STATE_DAMAGED: EQU 11
THOMAS_STATE_DEAD: EQU 12
THOMAS_STATE_DAMAGE_JUMPING: EQU 13



; This is used to count the ticks Thomas is jumping or going upstairs
THOMAS_HEIGHT_COUNTER: EQU 0xE704



; Global game state
; 0: stop
; 1: screen clears (goes black)
; 2: Thomas moves when starting a level
; 3: Thomas goes upstairs, or rescues Silvia
; 4: normal play
; 5: initial scene with Silvia
; 6: demo
; 7: screen with tied Silvia, "LET'S TRY NEXT FLOOR"
; 8: game ending, with hearts
; 9: reset
; B: Thomas has lost one life
; C: level ending music sounds. Energy and time decrease to gain points.
; Bit 7 active: shows characters: Thomas, knife-thrower, giant, Mr. X
GAME_STATE: EQU 0xE000

; This controls if the user is playing (1) or not yet (0).
; When a coin is inserted and the user is not playing, it'll jump to the 1/2 player selection screen.
; However, it won't jump to that screen when playing, of course.
IN_PLAY: EQU 0xE001

GAME_STATE_STOP: EQU 0
GAME_STATE_CLEAR: EQU 1
GAME_STATE_WALK_LEVEL_STARTS: EQU 2
GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED: EQU 3
GAME_STATE_PLAY: EQU 4
GAME_STATE_INTRO: EQU 5
GAME_STATE_DEMO: EQU 6
GAME_STATE_INTERLUDE: EQU 7
GAME_STATE_GAME_ENDS: EQU 8
GAME_STATE_LIFE_LOST: EQU 0xB
GAME_STATE_LEVEL_ENDS: EQU 0xC
GAME_STATE_SERVICE_MODE: EQU 0xFF

; Controls how players will make turns in the game
; Two bits:
; 00: only one player
; 10: it's player #1 turn
; 11: it's player #2 turn
PLAYER_TURN: EQU 0xE002

TIME: EQU 0xE003 ; Time, encoded in BCD in 0xE003 and 0xE004
IN_FREEZE_CHEAT: EQU 0xE005

; Controls if we're allowed to add one more non-priority sound to the
; audio channels.
ALLOWED_TO_ADD_SOUND: EQU 0xE006

; The buffer of the sprites shown, and a pointer to that address
SPRITE_BUFFER: EQU 0xEB25
SPRITE_BUFFER_PTR: EQU 0xEB03



; ************************ ROM start ************************
	org	00000h

	; Disable interrupts
	; Interrupt mode 1: interrupt handler at address 038h
	di
	im 1

	; Stack at 0f00h
	ld sp,0f000h		;0003

    ; Clear game variables
	ld hl,GAME_STATE
	ld de,GAME_STATE + 1
	ld bc, 4095
	ld (hl), 0
	ldir

	;0013
	ld hl,SPRITE_BUFFER
	ld (SPRITE_BUFFER_PTR),hl
	
	; Check DSW2 and jump to service mode if needed
	InDSW2
	bit 7,a ; Service mode: bit 7 of DSW2. Active LOW.
	jp z,SERVICE_MODE

	call GET_COINS_PER_CREDITS_FROM_DSWs	;0020	cd 8f 05
l0023h:
	ld hl,l05cch		;0023	21 cc 05 	! . . 
	ld de,0ea06h		;0026	11 06 ea 	. . . 
l0029h:
	ld bc,0x78		;0029	01 78 00 	. x . 
	ldir		;002c	ed b0 	. . 

	ld hl,(TOP_SCORE_IN_TABLE)
	ld a,l			;0031	7d
	ld l,h			;0032	6c
	ld h,a			;0033	67
	jr l0082h		;0034	18 4c
l0036h:
	defb 0xc7, 0xc7

    ; Z80 periodic interrupt handler
	ex af,af'			;0038	08 	. 
l0039h:
	exx			;0039	d9 	. 
	ld hl,(SPRITE_BUFFER_PTR)		;003a	2a 03 eb 	* . .  SEGUIR
	ld de,M62_SPRITERAM + 0x20	;003d	11 20 c0 	.   . 
l0040h:
	ld bc, 192	;0040	01 c0 00 	. . . 
	ldir		;0043	ed b0 	. . 
    
    ; Read progra's scroll position, and update M62's config to actually do it
	ld a,(HSCROLL_LOW_W)		;0045	3a 02 e9
	ld (M62_HSCROLL_LOW_W),a	;0048	32 00 a0
	ld a,(HSCROLL_HIGH_W)		;004b	3a 03 e9
	ld (M62_HSCROLL_HIGH_W),a	;004e	32 00 b0
	push iy		                ;0051	fd e5
	push ix		                ;0053	dd e5
	jp l008dh		;0055	c3 8d 00
    
    ; Probaby unused
    ; Question: just a placeholder to add more code?
    defb 0xc7, 0xc7, 0xc7, 0xc7, 0xc7, 0xc7, 0xc7, 0xc7
    defb 0xc7, 0xc7, 0xc7, 0xc7, 0xc7, 0xc7
    defb 0xed, 0x45, 0x63, 0xad, 0x9c, 0x52, 0x72, 0xcf
	defb 0x87, 0x41, 0x54, 0x37, 0xa7, 0x43, 0x91, 0x51
    defb 0xa7, 0x43, 0x91, 0x51, 0x9f, 0xb8, 0xe5, 0xd6
    defb 0x85, 0x56, 0x35, 0x23

l0082h:
        ld (POINTS_TOP),hl          ;0082   22 80 e9        " . . 

        ld hl,AUDIO_CHANNEL            ;0085   21 17 e9        ! . . 
        inc (hl)                        ;0088   34      4 
        ei                      ;0089   fb      . 
        jp l487eh               ;008a   c3 7e 48        . ~ H 

l008dh:
	ld a,(GAME_STATE)		;008d	3a 00 e0 	: . . 
	and a			;0090	a7 	. 
	jp m,l01f8h		;0091	fa f8 01 	. . . 
	InDSW2		;0094	db 04 	. . 
	bit 4,a		;0096	cb 67 Check bit 4 of DSW2: freeze trick
	jr nz,l00b7h		;0098	20 1d 	  . 
	ld hl,IN_FREEZE_CHEAT		;009a	21 05 e0 	! . . 
	bit 7,(hl)		;009d	cb 7e 	. ~ 
	jr nz,l00b7h		;009f	20 16 	  . 
	bit 0,(hl)		;00a1	cb 46 	. F 
	InSystem		;00a3	db 00 	. . 
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
	InDSW2		;00b7	db 04
	bit 3,a		;00b9	cb 5f Check bit 3 of DSW2: slow motion mode cheat
	jr nz,l00cdh		;00bb	20 10 Jump if slow motion OFF
    ; slow motion ON
	ld hl,PLAYER_INPUT_COINS_P1P2_BUTTONS	;00bd	21 04 e9
	bit 1,(hl)		;00c0	cb 4e Bit #1: P2 button pressed
	jr z,l00cdh		;00c2	28 09 P2 not pressed
    ; P2 pressed
	ld hl,0e80eh		;00c4	21 0e e8 Number of credits coin 2?
	dec (hl)			;00c7	35 	5 
	jp p,l01f0h		;00c8	f2 f0 01 	. . . 
	ld (hl),008h		;00cb	36 08 	6 . 
l00cdh:
	ld a,(GAME_STATE)		;00cd	3a 00 e0
	cp GAME_STATE_DEMO		;00d0	fe 06
	ld a,047h		;00d2	3e 47
	jr z,l00d8h		;00d4	28 02
    ; If NOT in demo, set A to a "random" number. Set A=0x47 in demo mode
	ld a,r		    ;00d6	ed 5f
l00d8h:
    ; Store two random bytes
	ld hl,EXT_RANDOM		;00d8	21 10 e0
	add a,(hl)			;00db	86

	ld (hl),a			;00dc	77 	w 
	inc hl			;00dd	23 	# 

	add a,(hl)			;00de	86 	. 
	ld (hl),a			;00df	77 	w 
l00e0h:
	ld hl,0e014h		;00e0	21 14 e0 	! . . 
	inc (hl)			;00e3	34 	4 
	ld a,(hl)			;00e4	7e 	~ 
	and 003h		;00e5	e6 03 	. . 
	ld d,000h		;00e7	16 00 	. . 
	ld e,a			;00e9	5f 	_ 
	ld a,(GAME_STATE)		;00ea	3a 00 e0 	: . . 
	ld hl,0x7E		;00ed	21 7e 00 	! ~ . 
	cp GAME_STATE_DEMO	;00f0	fe 06
	jr z,l0107h		;00f2	28 13 	( . 
	ld hl,0x6E		;00f4	21 6e 00

    ; Set 3 dragons if more than 3.
	ld a,(DRAGONS_LEVEL)	;00f7	3a 80 e0
	and 038h		        ;00fa	e6 38 Get dragons
	cp 020h		            ;00fc	fe 20 More than 3 dragons?
	jr c,l0102h		        ;00fe	38 02
    ; Yes, more than 3 dragons. Thus, set 3 dragons
	ld a,018h		        ;0100	3e 18

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
	call CHECK_FLIPSCREEN_AND_READ_PLAYER_CONTROLS		;0114	cd 05 0d 	. . . 
	call CHECK_UPDATE_COINS		;0117	cd 48 0d 	. H . 
	call UPDATE_PLAYER_MOVE		;011a	cd 2f 48 	. / H 
	call SEND_NEXT_SOUND_TO_IREM_AUDIO		;011d	cd e5 0d 	. . . 
l0120h:
	ld a,(IN_PLAY)	;0120	3a 01 e0
	and a			;0123	a7
	jr nz,l012dh	;0124	20 07 Jump if we're already playing (say, 1 or 2 players button pressed)
    
    ; We're not playing yet. Check inserted coins
	ld a,(COINS)	;0126	3a 13 e9
	and a			;0129	a7
	jp nz,l0217h	;012a	c2 17 02 Jump if coins inserted

l012dh:
	call UPDATE_INTERNAL_COUNTER		;012d	cd f8 03 	. . . 
	ld a,(GAME_STATE)		;0130	3a 00 e0 	: . . 
	cp GAME_STATE_LIFE_LOST		;0133	fe 0b
	jp nc,l01ddh		;0135	d2 dd 01 	. . . 
	ld a,018h		;0138	3e 18 	> . 
	ld (0eb00h),a		;013a	32 00 eb 	2 . . 
	ld hl,SPRITE_BUFFER		;013d	21 25 eb 	! % . 
l0140h:
	ld (SPRITE_BUFFER_PTR),hl		;0140	22 03 eb 	" . . 
l0143h:
	ld (0eb01h),hl		;0143	22 01 eb 	" . . 
	ld a,(GAME_STATE)		;0146	3a 00 e0 	: . . 
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
	call sub_413fh  		;0168	cd 3f 41 	. ? A 
	call sub_402ch  		;016b	cd 2c 40 	. , @ 

	ld a,(DRAGONS_LEVEL)	;016e	3a 80 e0
	and 007h		        ;0171	e6 07 Get level
	cp 004h		            ;0173	fe 04 Check if it's the last level
	jr z,l017fh		        ;0175	28 08
	call sub_40e5h	        ;0177	cd e5 40
	call sub_1cb3h		    ;017a	cd b3 1c
	jr l0185h		        ;017d	18 06
l017fh:
	call sub_1cb3h		;017f	cd b3 1c 	. . . 
	call sub_40e5h		;0182	cd e5 40 	. . @ 
l0185h:
	call sub_47b6h		;0185	cd b6 47 	. . G 
	ld a,(FLOOR_STAGE)		;0188	3a 00 e1 	: . . 
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
	call PROCESS_ALL_MOTHS		;01a9	cd c0 39 	. . 9 
	call sub_2d72h		;01ac	cd 72 2d 	. r - 
	call sub_2f06h		;01af	cd 06 2f 	. . / 
	jr l01c4h		;01b2	18 10 	. . 
	call sub_4d24h		;01b4	cd 24 4d 	. $ M 
	jr l01c4h		;01b7	18 0b 	. . 
	call sub_5436h		;01b9	cd 36 54 	. 6 T 
	jr l01c4h		;01bc	18 06 	. . 
l01beh:
	call sub_4000h		;01be	cd 00 40 	. . @ 
	call sub_40e5h		;01c1	cd e5 40 	. . @ 
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
	ld a,(GAME_STATE)		;01dd	3a 00 e0 	: . . 
l01e0h:
	cp GAME_STATE_DEMO		;01e0	fe 06
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
; End of Z80 periodic interrupt



l01f8h:
	push af			;01f8	f5 	. 
	ld a,018h		;01f9	3e 18 	> . 
	ld (0eb00h),a		;01fb	32 00 eb 	2 . . 
	ld hl,SPRITE_BUFFER		;01fe	21 25 eb 	! % . 
	ld (SPRITE_BUFFER_PTR),hl		;0201	22 03 eb 	" . . 
	ld (0eb01h),hl		;0204	22 01 eb 	" . . 
	pop af			;0207	f1 	. 
	inc a			;0208	3c 	< 
	call nz, sub_7aaeh		;0209	c4 ae 7a 	. . z 
	call UPDATE_INTERNAL_COUNTER		;020c	cd f8 03 	. . . 
	call CHECK_FLIPSCREEN_AND_READ_PLAYER_CONTROLS		;020f	cd 05 0d 	. . . 
	call SEND_NEXT_SOUND_TO_IREM_AUDIO		;0212	cd e5 0d 	. . . 
	jr l01c4h		;0215	18 ad 	. . 
l0217h:
	ld sp,0f000h	;0217	31 00 f0
    
    ; Set we're actually playing now
	ld a,001h		;021a	3e 01
	ld (IN_PLAY),a	;021c	32 01 e0

	xor a			;021f	af 	. 
l0220h:
	ld (GAME_STATE),a		;0220	32 00 e0 	2 . . 
	ei			;0223	fb 	. 
	call CHOOSE_1_OR_2_PLAYERS		;0224	cd 78 51 	. x Q 
    
    ; Set we're allowed to add sounds to the available channels
	ld a,0ffh		;0227	3e ff 	> . 
	ld (ALLOWED_TO_ADD_SOUND),a		;0229	32 06 e0 	2 . . 

    ; Reset all game variables
	ld hl,DRAGONS_LEVEL		;022c	21 80 e0
	ld de,DRAGONS_LEVEL+1	;022f	11 81 e0
	ld bc, 31		        ;0232	01 1f 00
	ld (hl), 0  		    ;0235	36 00
	ldir		            ;0237	ed b0

	InDSW1		 ;0239	db 03
	and 001h	 ;023b	e6 01 Check difficulty
	jr nz,l0247h ;023d	20 08

    ; Set 1 dragon, level 1
	ld a,008h		        ;023f	3e 08
	ld (DRAGONS_LEVEL),a	;0241	32 80 e0

	ld (0e090h),a		;0244	32 90 e0 	2 . . 
l0247h:
	call GET_LIVES_FROM_DSW1		;0247	cd 6f 05 	. o . 
	ld (LIVES),a		;024a	32 84 e0 	2 . . 
	ld (0e094h),a		;024d	32 94 e0 	2 . . 

sub_0250h:
    ; Deactivate freeze cheat
	ld hl,IN_FREEZE_CHEAT	;0250	21 05 e0
	res 7,(hl)		        ;0253	cb be
    
    ; Set GAME_STATE to STOP (0)
	xor a			    ;0255	af
	ld (GAME_STATE),a	;0256	32 00 e0

	InDSW2		    ;0259	db 04
	and 002h		;025b	e6 02 Check bit 1: upright (0) / cocktail (1) config

	ld hl,FLIP_SCREEN	;025d	21 10 e9
	jr z,l026dh		;0260	28 0b Jump if upright
    ; cocktail

	ld a,(PLAYER_TURN)	;0262	3a 02 e0
	and 001h		    ;0265	e6 01
	jr z,l026dh		    ;0267	28 04 Jump if it's player #1
    ; It's player #2
	set 0,(hl)		    ;0269	cb c6 Set bit #0 of FLIP_SCREEN to 1: flip the screen
	jr l026fh		    ;026b	18 02
l026dh:
    ; upright or player 1
    ; We don't flip the screen if we're upright, but
    ; neither if it's cocktail and it's the turn of player 1.
	res 0,(hl)		;026d	cb 86 Set bit #0 of FLIP_SCREEN to 0: don't flip the screen
l026fh:
	ld hl,SKIP_LETTER_SKIP_EXTRA_LIFE	;026f	21 85 e0
	bit 1,(hl)		;0272	cb 4e Bit #1 of SKIP_LETTER_SKIP_EXTRA_LIFE: skip letter scene
	jr nz,l0285h	;0274	20 0f Skip
    
    ; Show the letter scene
	set 1,(hl)		;0276	cb ce 	. . 
	call DRAW_LETTER_SCREEN		;0278	cd 0d 52 	. . R 
	ld a,0e1h		;027b	3e e1 	> . 
	call DELAY_A		;027d	cd 0f 57 	. . W 
	ld a,070h		;0280	3e 70 	> p 
	call DELAY_A		;0282	cd 0f 57 	. . W 
l0285h:
	call CLEAR_TILEMAP		;0285	cd 57 11 	. W . 
	xor a			;0288	af 	. 
	ld (0e007h),a		;0289	32 07 e0 	2 . . 
	ld (0e008h),a		;028c	32 08 e0 	2 . . 
	call ANIMATION_THOMAS_STARTS_LEVEL		;028f	cd 49 04 	. I . 
	ld a, GAME_STATE_PLAY		;0292	3e 04
	ld (GAME_STATE),a		;0294	32 00 e0 	2 . . 
	ld a,024h		;0297	3e 24 	> $ 
	call PLAY_SOUND		;0299	cd fe 0d 	. . . 
    
; It stays in this loop while GAME_STATE != GAME_STATE_LIFE_LOST.
LEVEL_PLAY_LOOP:
	InDSW2		;029c	db 04
	bit 4,a		;029e	cb 67 Check bit 4: freeze cheat
l02a0h:
    ; Check level selection cheat
	jr z,l02aeh		    ;02a0	28 0c
	bit 5,a		        ;02a2	cb 6f Check bit 5: level selection mode cheat
	jr nz,l02aeh		;02a4	20 08
	ld hl,PLAYER_INPUT_COINS_P1P2_BUTTONS		;02a6	21 04 e9
	bit 0,(hl)		                            ;02a9	cb 46 Bit #0: P1 pressed
	jp nz,l039ch		                        ;02ab	c2 9c 03 Jump if not pressed
    ; P1 pressed
l02aeh:
	ld a,(GAME_STATE)		;02ae	3a 00 e0 	: . . 
	cp GAME_STATE_LIFE_LOST		;02b1	fe 0b
	jp z,l033ah		;02b3	ca 3a 03 	. : . 
	cp 0xC		;02b6	fe 0c 	0xC: level ending music sounds. Energy and time decrease to gain points.
	jp z,l02c0h		;02b8	ca c0 02 	. . . 
	call DECREASE_TIME_UPDATE_PANEL		;02bb	cd b8 0f 	. . . 
	jr LEVEL_PLAY_LOOP		;02be	18 dc 	. . 

l02c0h:
    ; Clear audio
	ld a,000h		    ;02c0	3e 00
	call PLAY_SOUND		;02c2	cd fe 0d
    
    ; Play level completed music
	ld a,022h		;02c5	3e 22
	call PLAY_SOUND	;02c7	cd fe 0d

    ; Update the panel
	ld a,0e1h		;02ca	3e e1
	call DRAW_PANEL_ELEMENTS_WITH_PAUSES	;02cc	cd 82 05
	ld a,038h		                        ;02cf	3e 38
	call DRAW_PANEL_ELEMENTS_WITH_PAUSES	;02d1	cd 82 05

; Decrease energy and give points. Make points sounds.
l02d4h:
    ; We make the following CALL to update the points and energy bars
	ld a,001h		;02d4	3e 01 	> . 
	call DRAW_PANEL_ELEMENTS_WITH_PAUSES	;02d6	cd 82 05
    
	ld hl,ENERGY	;02d9	21 09 e7
	ld a,(hl)		;02dc	7e
	and a			;02dd	a7
	jp m,l02eah		;02de	fa ea 02
	dec (hl)		;02e1	35 	5 
    ; Increment 100 points and make points sound
	call INCREMENT_100_POINTS	;02e2	cd 97 2f
	call MAKE_POINTS_SOUND		;02e5	cd 5f 05
	jr l02d4h		;02e8	18 ea
l02eah:
	ld de,0			;02ea	11 00 00 	. . . 
	push de			;02ed	d5 	. 
l02eeh:
	ld a,003h		;02ee	3e 03 	> . 
	call DRAW_PANEL_ELEMENTS_WITH_PAUSES		;02f0	cd 82 05 	. . . 
	pop de			;02f3	d1 	. 

    ; Here it decrements time after completing a level
	ld hl,(TIME)	;02f4	2a 03 e0
	ld a,l			;02f7	7d
	or h			;02f8	b4
	jr z,time_decrement_done		;02f9	28 22    Finished if HL == 0
	ld a,e			;02fb	7b       E is the time decrement applied to the time
	add a,001h		;02fc	c6 01    Increase time decrement
	daa			    ;02fe	27
	ld e,a			;02ff	5f       Store updated time decrement
l0300h:
	sbc hl,de		;0300	ed 52
	add hl,de		;0302	19
	jr nc,l0307h	;0303	30 02
	ld e,l			;0305	5d
	ld d,h			;0306	54
l0307h:
	ld a,l			;0307	7d Get time low BCD
	sub e			;0308	93 Decrement time low BCD by E
	daa			    ;0309	27
	ld l,a			;030a	6f Store decrement low BCD

	ld a,h			;030b	7c Get time high BCD
	sbc a,d			;030c	9a Decrement
	daa			    ;030d	27
	ld h,a			;030e	67 Store high BCD

	ld (TIME),hl	;030f	22 03 e0 Store decremented time

	push de			;0312	d5 	. 
	call INCREMENT_DE_POINTS		;0313	cd 9a 2f 	. . / 
	ld a,016h		;0316	3e 16 	> . 
	call PLAY_SOUND		;0318	cd fe 0d 	. . . 
	jr l02eeh		;031b	18 d1 	. . 
    
time_decrement_done:
	ld a,038h		;031d	3e 38 	> 8 
	call DRAW_PANEL_ELEMENTS_WITH_PAUSES		;031f	cd 82 05 	. . . 

    ; Call the interlude if the level is odd (1=level 2, 3=level 4)
	ld a,(DRAGONS_LEVEL)    ;0322	3a 80 e0
	and 001h		        ;0325	e6 01
	call nz, INTERLUDE		;0327	c4 c2 53

	ld a,(DRAGONS_LEVEL)	;032a	3a 80 e0
	and 007h		        ;032d	e6 07 Get level
	cp 004h		            ;032f	fe 04
	call z,04fe9h		    ;0331	cc e9 4f Call only if in last level
	call INCREMENT_LEVEL		;0334	cd 32 04 	. 2 . 
	call sub_0250h		;0337	cd 50 02 	. P . 
l033ah:
	ld a,02dh		;033a	3e 2d 	> - 
	call DELAY_A		;033c	cd 0f 57 	. . W 
	ld hl,(TIME)		;033f	2a 03 e0 	* . . 
	ld a,l			;0342	7d 	} 
	or h			;0343	b4 	. 
	call z,DRAW_TIME_OVER_AND_DELAY		;0344	cc b5 56 	. . V 
	ld hl,LIVES		;0347	21 84 e0 	! . . 
	dec (hl)			;034a	35 	5 
	jr z,l035dh		;034b	28 10 	( . 
	ld a,(0e007h)		;034d	3a 07 e0 	: . . 
	and a			;0350	a7 	. 
	jr z,l0360h		;0351	28 0d 	( . 
	call PLAY_SOUND		;0353	cd fe 0d 	. . . 
	ld a,0a9h		;0356	3e a9 	> . 
	call DELAY_A		;0358	cd 0f 57 	. . W 
	jr l0360h		;035b	18 03 	. . 
l035dh:
	call sub_54f4h		;035d	cd f4 54 	. . T 
l0360h:
	ld hl,PLAYER_TURN	;0360	21 02 e0
	bit 1,(hl)		    ;0363	cb 4e
	jr z,l0382h		;0365	28 1b Jump if only one players
    ; Two players
	ld a,(0e094h)		;0367	3a 94 e0 	: . . 
	and a			;036a	a7 	. 
	jr z,l0382h		;036b	28 15 	( . 
	ld a,(hl)			;036d	7e 	~ 
	xor 001h		;036e	ee 01 	. . 
	ld (hl),a			;0370	77 	w 
l0371h:
	ld b,010h		;0371	06 10 	. . 
	ld hl,DRAGONS_LEVEL		;0373	21 80 e0 	! . . 
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
	ld a,(LIVES)		;0382	3a 84 e0 	: . . 
	and a			;0385	a7 	. 
	jp nz,sub_0250h		;0386	c2 50 02 	. P . 
    
    ; Don't flip the screen
	ld hl,FLIP_SCREEN		;0389	21 10 e9 	! . . 
	res 0,(hl)		;038c	cb 86 	. . 

    ; We can't add sound to the audio channels
	xor a			            ;038e	af
	ld (ALLOWED_TO_ADD_SOUND),a	;038f	32 06 e0
    
	ld a,(COINS)		;0392	3a 13 e9 	: . . 
	and a			;0395	a7 	. 
	jp nz,l0217h		;0396	c2 17 02 	. . . 
	jp 0487eh		;0399	c3 7e 48 	. ~ H 
l039ch:
	ld hl,IN_FREEZE_CHEAT		;039c	21 05 e0 	! . . 
	set 7,(hl)		;039f	cb fe 	. . 
	ld a,000h		;03a1	3e 00 	> . 
	call PLAY_SOUND		;03a3	cd fe 0d 	. . . 
	xor a			;03a6	af 	. 
	ld (GAME_STATE),a		;03a7	32 00 e0 	2 . . 
	call CLEAR_TILEMAP		;03aa	cd 57 11 	. W . 
	ld hl,0				;03ad	21 00 00 	! . . 
	ld (HSCROLL_LOW_W),hl		;03b0	22 02 e9 	" . . 
	call DELAY_1		;03b3	cd 0d 57 	. . W 
	ld hl, SELECT_GAME_FLOOR_STR		;03b6	21 5b 59
	call WRITE_TEXT		;03b9	cd 1c 11 	. . .

l03bch:
	ld c,014h		;03bc	0e 14 	. . 
	ld de,0d3a7h		;03be	11 a7 d3 	. . . 

	ld a,(DRAGONS_LEVEL)	;03c1	3a 80 e0
    ; Consider only dragons
	and 0f8h		        ;03c4	e6 f8
	rrca			;03c6	0f 	. 
	rrca			;03c7	0f 	. 
	rrca			;03c8	0f 	. 
    ; A = number of dragons
	call PRINT_A_PLUS_1		;03c9	cd 5b 05 	. [ . 
	ld de,0d427h		;03cc	11 27 d4 	. ' . 
	call PRINT_LEVEL		;03cf	cd 56 05 	. V . 

; Level selection code

; Wait until kick and punch buttons are released
l03d2h:
	ld a,(PLAYER_INPUT)		;03d2	3a 06 e9
	and 0a0h		        ;03d5	e6 a0 Check bits 7 (kick) and 5 (punch)
	jr nz,l03d2h		    ;03d7	20 f9 Wait until both buttons released

; Wait until a button is pressed, to decrement or increment the level
l03d9h:
	ld hl,PLAYER_INPUT_COINS_P1P2_BUTTONS	;03d9	21 04 e9
	bit 1,(hl)		        ;03dc	cb 4e Bit #1: P2 pressed
	jp nz,sub_0250h		    ;03de	c2 50 02 Only call if P2 not pressed
	ld hl,PLAYER_INPUT		;03e1	21 06 e9
	bit 7,(hl)		        ;03e4	cb 7e Check bit 7 (kick)
	jr nz,l03eeh		    ;03e6	20 06 Jump to decrement level if pressed
	bit 5,(hl)		        ;03e8	cb 6e Check bit 5 (punch)
	jr nz,l03f3h		    ;03ea	20 07 Jump to increment level if pressed
	jr l03d9h		        ;03ec	18 eb Repeat until a button is pressed

l03eeh:
	call DECREMENT_LEVEL	;03ee	cd 1b 04
	jr l03bch		        ;03f1	18 c9
l03f3h:
	call INCREMENT_LEVEL	;03f3	cd 32 04
	jr l03bch		        ;03f6	18 c4

; Updates the internal counter (6 bytes long! from 0xE880 to 0xE885) with the
; Z80 periodic interrupt
UPDATE_INTERNAL_COUNTER:
	ld hl,INT_COUNTER		;03f8	21 80 e8 	! . . 
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

DECREMENT_LEVEL:
	ld hl,DRAGONS_LEVEL	;041b	21 80 e0
	dec (hl)			;041e	35 Decrement current level
	ld a,(hl)			;041f	7e
	and 007h		    ;0420	e6 07 A = level
	cp 007h		        ;0422	fe 07
	ret nz			    ;0424	c0 Exit if we have not overflown with level-1 = 7

	ld a,(hl)			;0425	7e
	and 0f8h		    ;0426	e6 f8 A = dragons << 3
	cp 0f8h		        ;0428	fe f8
	jr nz,l042eh		;042a	20 02
    ; Here we have dragons << 3 == 0xF8 = (11) 111 000, dragons overflow
	ld a,028h		    ;042c	3e 28 Set A = (00) 101 000 = 5 dragons
l042eh:
	or 004h		        ;042e	f6 04 Set last level
	ld (hl),a			;0430	77
	ret			        ;0431	c9

; Increment current level, and dragons if less than 6.
INCREMENT_LEVEL:
	ld hl,DRAGONS_LEVEL	;0432	21 80 e0
	inc (hl)			;0435	34 Increment current level
	ld a,(hl)			;0436	7e
	and 007h		    ;0437	e6 07 A = level
	cp 005h		        ;0439	fe 05 Last level?
	ret nz			    ;043b	c0 Exit if not last level
    ; We're in the last level
	ld a,(hl)			;043c
	and 0f8h		    ;043d	e6 f8 A = dragons << 3
	add a, 8		    ;043f	c6 08 Increment dragons
	cp 030h		        ;0441	fe 30 0x30 = (00)110 000 = 6 dragons, first level
	jr nz,l0447h		;0443	20 02 Exit if not 6 dragons, level 0
	ld a,028h		    ;0445	3e 28  A = 0x28 = (00)101 000 = 5 dragons, first level
l0447h:
	ld (hl),a			;0447	77
	ret			        ;0448	c9

ANIMATION_THOMAS_STARTS_LEVEL:
	ld (AVOID_SHOWING_FLOOR_INTRO_TEXT),a		;0449	32 1c e8 	2 . . 
	ld a, GAME_STATE_CLEAR		;044c	3e 01
	ld (GAME_STATE),a		;044e	32 00 e0 	2 . . 
	call sub_0644h		    ;0451	cd 44 06 	. D . 
	ld a,(DRAGONS_LEVEL)	;0454	3a 80 e0 	: . . 
	and 1		            ;0457	e6 01 Check if it's level 1
	ld hl,0x0021		;0459	21 21 00 	! ! . 
	jr nz,l0461h		;045c	20 03 	  . 
	ld hl,0xbfe0		;045e	21 e0 bf 	! . . 
l0461h:
	push hl			;0461	e5 	. 
	ld (0e817h),hl		;0462	22 17 e8 	" . . 
	call RESET_PANEL		;0465	cd 9b 0e 	. . . 
	xor a			;0468	af 	. 
	ld (HATCH_STATE),a		;0469	32 15 e9 0: starting to close

	call DRAW_SCENARIO		;046c	cd 56 57 	. V W 
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;046f	3a 1c e8 	: . . 
	and a			;0472	a7 	. 
	call z,PRINT_PLAYER_FLOOR_TEXT		;0473	cc e5 04 	. . . 
	ld a, GAME_STATE_WALK_LEVEL_STARTS		;0476	3e 02
	ld (GAME_STATE),a		;0478	32 00 e0 	2 . . 
	ld a,027h		;047b	3e 27 	> ' 
	call DELAY_A		;047d	cd 0f 57 	. . W 
	ld hl,0006h+1		;0480	21 07 00 	! . . 
	ld (0e817h),hl		;0483	22 17 e8 	" . . 
    
	ld hl,HATCH_STATE	;0486	21 15 e9
	inc (hl)			;0489	34 	4 

	ld hl,05aa1h		;048a	21 a1 5a 	! . Z 
	call DRAW_FLOOR_HATCH		;048d	cd bf 04 	. . . 
	ld a,00bh		;0490	3e 0b 	> . 
	call DELAY_A		;0492	cd 0f 57 	. . W 

	ld hl,HATCH_STATE	;0495	21 15 e9
	inc (hl)			;0498	34 	4 

	ld hl,05af0h		;0499	21 f0 5a 	! . Z 
	call DRAW_FLOOR_HATCH		;049c	cd bf 04 	. . . 
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;049f	3a 1c e8 	: . . 
	and a			;04a2	a7 	. 
    ld hl, READY_STR ; z80dasm wrote this as defb 021h, 03fh, 005h (bug z80dasm?)
	
	call z,WRITE_TEXT		;04a6	cc 1c 11 	. . . 
	ld a,054h		;04a9	3e 54 	> T 
	call DELAY_A		;04ab	cd 0f 57 	. . W 
	pop hl			;04ae	e1 	. 
	ld (0e817h),hl		;04af	22 17 e8 	" . . 
	call DRAW_SCENARIO		;04b2	cd 56 57 	. V W 
	ld hl,0		;04b5	21 00 00 	! . . 
	ld (0e014h),hl		;04b8	22 14 e0 	" . . 
	ld (0e016h),hl		;04bb	22 16 e0 	" . . 
	ret			;04be	c9 	. 

; Draws one step of the floor hatch closing
DRAW_FLOOR_HATCH:
	ld a,(DRAGONS_LEVEL)	;04bf	3a 80 e0
	and 007h		        ;04c2	e6 07 Get level
	ret z			        ;04c4	c8 Exit if it's the first level
	and 1   		        ;04c5	e6 01 Write text if it's 2, 4: levels 3, and 5.
	jp z,WRITE_TEXT		    ;04c7	ca 1c 11
	call DRAW_SCENARIO		;04ca	cd 56 57

	ld a,(HATCH_STATE)		;04cd	3a 15 e9
	cp 2		            ;04d0	fe 02 2: hatch completly closed
	ret nz			        ;04d2	c0

    ; Draw the hatch's corner
	ld hl,HATCH_CORNER		;04d3	21 d9 04
	jp WRITE_TEXT		    ;04d6	c3 1c 11

HATCH_CORNER:
    defb 0fdh,067h,0d6h, 0xfe, 0x92, 0x81, 0x7f
    defb 0fdh, 0a7h, 0d6h, 0x83, 0xff

; Print the "1-PLAYER 1-FLOOR" text which appears when starting a level
PRINT_PLAYER_FLOOR_TEXT:
	ld hl,PLAYER_FLOOR_TEXT_STR		;04e5	21 fd 04
	call WRITE_TEXT		;04e8	cd 1c 11
	ld a,(PLAYER_TURN)	;04eb	3a 02 e0
	and 001h		    ;04ee	e6 01 Check number of players
	inc a			    ;04f0	3c Increment so A = number of players
	call PRINT_DIGIT		;04f1	cd 08 11
	call WRITE_TEXT		;04f4	cd 1c 11
	call PRINT_LEVEL		;04f7	cd 56 05
	jp WRITE_TEXT		;04fa	c3 1c 11

PLAYER_FLOOR_TEXT_STR:
	defb 0fdh,067h,0d3h
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

READY_STR:
	defb 0feh,0dbh
	defb 0fdh,02ch,0d4h
	defb " READY ", 0fdh ; 0544h
	defb 06ch, 0d4h
	defb "       ", 0ffh

PRINT_LEVEL:
	ld a,(DRAGONS_LEVEL)	;0556	3a 80 e0
	and 007h		        ;0559	e6 07 Get level

; Prints number A+1
PRINT_A_PLUS_1:
	inc a			;055b	3c 	< 
	jp PRINT_DIGIT		;055c	c3 08 11 	. . . 

; Makes the energy/time decrease and give points sound
MAKE_POINTS_SOUND:
    ; Avoid overlapping the sounds
	ld a,(STEP_COUNTER)		;055f	3a 83 e8
	and a			        ;0562	a7
	ret nz			        ;0563	c0
    
	ld a, 3		            ;0564	3e 03 Delay
	ld (STEP_COUNTER),a		;0566	32 83 e8

	ld a,016h		        ;0569	3e 16 Points sound
	call PLAY_SOUND		    ;056b	cd fe 0d
	ret			            ;056e

; Read DSW1 and obtain the configured number of lives
GET_LIVES_FROM_DSW1:
	InDSW1		;056f	db 03    
	cpl			;0571	2f The bits are inverted in the DSWs
    
    ; Check SW1:3,4: lives
	and 00ch	;0572	e6 0c and 0000.1100
    rrca			;0574	0f  
	rrca			;0575	0f
	add a, 2		;0576	c6 02

	cp 4		    ;0578	fe 04
	ret nc			;057a	d0 4 or 5 lives
    
	inc a			;057b	3c
	cp 3		    ;057c	fe 03 3 lives
	ret z			;057e	c8
    
	ld a,2		    ;057f	3e 02 2 lives
	ret			    ;0581	c9

; Calls DRAW_PANEL_ELEMENTS only if (INT_COUNTER + 2) == 0, to
; update slowly in the scene.
; A: pause
DRAW_PANEL_ELEMENTS_WITH_PAUSES:
	ld (INT_COUNTER + 2),a		;0582	32 82 e8
l0585h:
	call DRAW_PANEL_ELEMENTS	;0585	cd e3 0f
	ld a,(INT_COUNTER + 2)		;0588	3a 82 e8
	and a			            ;058b	a7
	jr nz,l0585h		        ;058c	20 f7
	ret			                ;058e	c9

; Read the DSWs to get COINS_PER_CREDITS_A and COINS_PER_CREDITS_B
GET_COINS_PER_CREDITS_FROM_DSWs:
	; Get coinage (ex: 1 Coin/2 Credits, etc.) in B
    InDSW1		;058f	db 03
	cpl			;0591	2f
	rra			;0592	1f
	rra			;0593	1f
	rra			;0594	1f
	rra			;0595	1f
	ld b,a		;0596	47
    
	ld hl,COINS_PER_CREDITS_A	;0597	21 0a e9

	InDSW2		;059a	db 04 	. . 
	bit 2,a		;059c	cb 57  Check bit 2: coin mode

	jr nz,l05b1h	;059e	20 11
	ld a,b			;05a0	78
	inc a		    ;05a1	3c
	and 003h	    ;05a2	e6
	ld (hl),a	    ;05a4	77
	inc hl		    ;05a5	23 HL = COINS_PER_CREDITS_B
	ld a,b		    ;05a6	78
	rra			    ;05a7	1f
	rra			    ;05a8	1f
	and 003h	    ;05a9	e6 03
	cp 002h		    ;05ab	fe 02
	sbc a,0f5h	    ;05ad	de f5
	ld (hl),a	    ;05af	77
	ret			    ;05b0	c9

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

TOP_SCORE_IN_TABLE:
	defb 048h, 052h ;063f
	defb "N.A"

sub_0644h:
	ld hl,0x80		;0644	21 80 00 	! . . 
	ld (HSCROLL_LOW_W),hl		;0647	22 02 e9 	" . . 
sub_064a:
    ; Clear SPRITE_BUFFER
	ld hl,SPRITE_BUFFER		;064a	21 25 eb
	ld de,SPRITE_BUFFER + 1	;064d	11 26 eb
	ld bc, 191      		;0650	01 bf 00
	ld (hl),000h		    ;0653	36 00
	ldir		            ;0655	ed b0
    
	call sub_074dh		;0657	cd 4d 07 	. M . 
	call sub_06beh		;065a	cd be 06 	. . . 
	ld hl,0e380h		;065d	21 80 e3 	! . .  ToDo: what is 0e380h? Why not NUM_MAGICAL_ELEMENTS?
	ld de,NUM_MAGICAL_ELEMENTS		;0660	11 81 e3 	. . . 
	ld bc,00131h		;0663	01 31 01 	. 1 . 
	ld (hl),000h		;0666	36 00 	6 . 
	ldir		;0668	ed b0 	. . 

	call GET_ROUND_IN_BC		;066a	cd 66 08 	. f . 
	ld hl,TBL_FLOOR_STAGE_FROM_ROUND		;066d	21 8a 08 	! . . 
	add hl,bc			;0670	09 	. 
	ld a,(hl)			;0671	7e 	~ 
	ld (FLOOR_STAGE),a		;0672	32 00 e1 	2 . . 
	and a			;0675	a7 	. 
	jr z,l0689h		;0676	28 11 	( . 

	ld hl, INDICES_DATA_MAGICAL_ELEMENTS		;0678	21 b0 08 	! . . 
	ld de, MAGICAL_ELEMENTS_CONFIG		;067b	11 60 e3 	. ` . 
	ld bc, 24	        ;067e	01 18 00
	call LDIR_WITH_INDEXED_HL		;05	cd b2 06 	. . . 

	ld a,001h		;0684	3e 01 	> . 
	ld (0e380h),a		;0686	32 80 e3 	2 . . 
l0689h:
	
    ; Set to zero 324 bytes in TBL_E521_LEN
    ld hl,TBL_E521_LEN		;0689	21 20 e5
	ld de,TBL_E521_LEN+1	;068c	11 21 e5
	ld bc, 323  		;068f	01 43 01
	ld (hl),000h		;0692	36 00
	ldir		        ;0694	ed b0
    
	call GET_ROUND_IN_BC		;0696	cd 66 08 	. f . 
	ld hl,TBL_FLOOR_STAGE_FROM_ROUND_2		;0699	21 9e 08 	! . . 
	add hl,bc			;069c	09 	. 
	ld a,(hl)			;069d	7e 	~ 
	and a			;069e	a7 	. 
	ret z			;069f	c8 	. 

	ld (FLOOR_STAGE),a		;06a0	32 00 e1 	2 . . 

	ld hl, INDICES_DATA_MOTHS		;06a3	21 20 09
	ld de, DATA_MOTHS_CONFIG            		;06a6	11 00 e5
	ld bc, 17   		            ;06a9	01 11 00
    ;
    ; Do LDIR with HL=0x93C, DE=0xE500, BC=0x11
	call LDIR_WITH_INDEXED_HL		;06ac	cd b2 06 	. . . 
	jp l3d53h		;06af	c3 53 3d 	. S =

; Perform LDIR from HL to DE
; It recomputes HL from the input HL0 as
;    H = [HL0 + 2*A0 + 1]
;    L = [HL0 + 2*A0]
LDIR_WITH_INDEXED_HL:
	add a,a			;06b2	87 A = 2 * A0
	push bc			;06b3	c5 
	ld c,a			;06b4	4f C = 2 * A0
    
    ; This is called always with B = 0
	add hl,bc		;06b5	09 HL = HL0 + 2 * A0
	pop bc			;06b6	c1
    
	ld a,(hl)		;06b7	7e A = [HL0 + 2 * A0]
	inc hl			;06b8	23
	ld h,(hl)		;06b9	66 H = [HL0 + 2 * A0 + 1]
	ld l,a			;06ba	6f L = [HL0 + 2 * A0]
    
    
    ; Perform LDIR from HL to DE
    ; H, L = [HL0 + 2*A0 + 1], [HL0 + 2*A0]
	ldir		    ;06bb	ed b0
	ret			    ;06bd	c9

sub_06beh:
    ; Clear 35 bytes from THOMAS_PROPS
	ld hl,THOMAS_PROPS		;06be	21 00 e7
	ld de,THOMAS_PROPS + 1	;06c1	11 01 e7
	ld bc, 35		                ;06c4	01 23 00
	ld (hl), 0		                ;06c7	36 00
	ldir		                    ;06c9	ed b0

	ld a,(DRAGONS_LEVEL)	;06cb	3a 80 e0
	and 007h		        ;06ce	e6 07 A = level
	add a,a			        ;06d0	87 A = 2*level
	ld c,a			        ;06d1	4f BC = 2*level
	ld hl,TIME_BY_LEVEL_TABLE		    ;06d2	21 80 08
	add hl,bc			    ;06d5	09 HL = TIME_BY_LEVEL_TABLE + 2*level
    
	ld a,(hl)			    ;06d6	A = [TIME_BY_LEVEL_TABLE + 2*level]
	inc hl			        ;06d7
	ld h,(hl)			    ;06d8	H = [TIME_BY_LEVEL_TABLE + 2*level + 1]
	ld l,a			        ;06d9	L = [TIME_BY_LEVEL_TABLE + 2*level]
	ld (TIME),hl		;06da	22 03 e0 	" . . 

	ld a,03fh		;06dd	3e 3f 	> ? 
	ld (ENERGY),a		;06df	32 09 e7 	2 . . 

	ld hl,05000h		;06e2	21 00 50 	! . P 
	ld (0e710h),hl		;06e5	22 10 e7 	" . . 

	ld a,(DRAGONS_LEVEL)		;06e8	3a 80 e0 	: . . 
	and 001h		;06eb	e6 01 	. . 
	ld (0e101h),a		;06ed	32 01 e1 	2 . . 

	jr z,l071dh		;06f0	28 2b 	( + 

	ld hl,THOMAS_PROPS		;06f2	21 00 e7 	! . . 
	ld (hl),020h		;06f5	36 20 Thomas looking to the right

	inc hl			    ;06f7	23 	# 
	ld (hl),040h		;06f8	36 40 	6 @ 

	ld hl,0ce40h		;06fa	21 40 ce 	! @ . 
	ld (0e102h),hl		;06fd	22 02 e1 	" . . 

	ld hl,00900h		;0700	21 00 09 	! . . 
	ld (THOMAS_POSITION),hl		;0703	22 12 e7 	" . . 

	ld hl,0x1000		;0706	21 00 10 	! . . 
	ld (0e707h),hl		;0709	22 07 e7 	" . . 

	ld hl,0cd00h		;070c	21 00 cd 	! . . 
	ld (0e106h),hl		;070f	22 06 e1 	" . . 

	ld hl,l02c0h		;0712	21 c0 02 	! . . 
	ld (0e104h),hl		;0715	22 04 e1 	" . . 

	ld a,001h		;0718	3e 01 	> . 
	jp l0749h		;071a	c3 49 07 	. I . 
l071dh:
	ld a,(DRAGONS_LEVEL)		;071d	3a 80 e0 	: . . 
	and 007h		;0720	e6 07 	. . 
	ld hl,010e0h		;0722	21 e0 10 	! . . 
	cp 004h		;0725	fe 04 	. . 
	jr nz,l072ch		;0727	20 03 	  . 
	ld hl,0x1000		;0729	21 00 10 	! . . 
l072ch:
	ld (0e102h),hl		;072c	22 02 e1 	" . . 
	ld hl,0d560h		;072f	21 60 d5 	! ` . 
	ld (THOMAS_POSITION),hl		;0732	22 12 e7 	" . . 
	ld hl,M62_TILERAM		;0735	21 00 d0 	! . . 
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
	ld a,(DRAGONS_LEVEL)		;075a	3a 80 e0 	: . . 
	and 007h		;075d	e6 07 	. . 
	cp 004h		;075f	fe 04 	. . 
    
    ; Bad decompiled by z80dasm?
	;defb 020h, 02eh
	;defb 021h, 000h, 006h
    ;
    jr nz, l0791h
    ld hl, 0x0600
    
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
	ld (SILVIA_STATE),a		;0784	32 4c e3 	2 L . 
	ld a,050h		;0787	3e 50 	> P 
	ld (SILVIA_LEFT_OR_RIGHT),a		;0789	32 40 e3 	2 @ . 
	ld a,005h		;078c	3e 05 	> . 
	ld (0e347h),a		;078e	32 47 e3 	2 G . 
l0791h:
	ld ix,TBL_ENEMIES		;0791	dd 21 d8 e2 	. ! . . 
	ld (ix + ENEMY_ENERGY_IDX), 63	;0795	dd 36 0a 3f
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;0799	dd 36 07 07
	ld hl,05000h		;079d	21 00 50 	! . P 
	ld (0e2dch),hl		;07a0	22 dc e2 	" . . 
	ld a,(DRAGONS_LEVEL)		;07a3	3a 80 e0 	: . . 
	and 001h		;07a6	e6 01 	. . 
	ld hl,l1500h		;07a8	21 00 15 	! . . 
	ld de,03100h		;07ab	11 00 31 	. . 1 
	jr z,l07b6h		;07ae	28 06 	( . 
	ld hl,0cc00h		;07b0	21 00 cc 	! . . 
	ld de,M62_HSCROLL_HIGH_W		;07b3	11 00 b0 	. . . 
l07b6h:
	ld (ENEMY_POS),hl		;07b6	22 da e2
	ld (0e2d3h),de		    ;07b9	ed 53 d3 e2
	call GET_ROUND_IN_BC	;07bd	cd 66 08
	push bc			        ;07c0	c5
	sla c		            ;07c1	cb 21   BC = 2 * ROUND. max = 2 * 22 = 44.
	push bc			;07c3	c5 	. 
	push bc			;07c4	c5 	. 

	ld hl,TBL_FLOOR_STAGE_FROM_ROUND_3	;07c5	21 b0 09
	add hl,bc			                ;07c8	09      HL = TBL_FLOOR_STAGE_FROM_ROUND_3 + 2*ROUND
	ld a,(hl)			;07c9	7e 	~ 
	inc hl			;07ca	23 	# 
	ld h,(hl)			;07cb	66 	f 
	ld l,a			;07cc	6f 	o 
	ld de, TBL_E19C		;07cd	11 9c e1 	. . . 
	ld bc, 29		;07d0	01 1d 00 	. . . 
	ldir		;07d3	ed b0 	. . 

	ld hl, INDICES_980		;07d5	21 80 09 	! . . 
	pop bc			;07d8	c1 	. 
	add hl,bc			;07d9	09 	. 
	ld a,(hl)			;07da	7e 	~ 
	inc hl			;07db	23 	# 
	ld h,(hl)			;07dc	66 	f 
	ld l,a			;07dd	6f 	o 
	or h			;07de	b4 	. 
	jr z,l07e6h		;07df	28 05 	( . 
	ld bc, 8		;07e1	01 08 00 	. . . 
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
	ld ix,TBL_E10A		;0819	dd 21 0a e1 	. ! . . 
	ld de,l0c1ch		;081d	11 1c 0c 	. . . 
	ld b,023h		;0820	06 23 	. # 
l0822h:
	call sub_0845h		;0822	cd 45 08 	. E . 
	inc iy		;0825	fd 23 	. # 
	djnz l0822h		;0827	10 f9 	. . 
	ld hl,0e1ffh		;0829	21 ff e1 	! . . 
	ld (0e108h),hl		;082c	22 08 e1 	" . . 
	call GET_ROUND_IN_BC		;082f	cd 66 08 	. f . 
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
	ld (ix + 0),a		;0859	dd 77 00 	. w . 
	inc hl			;085c	23 	# 
	ld a,(hl)			;085d	7e 	~ 
	ld (ix + 1),a		;085e	dd 77 01 	. w . 
	inc ix		;0861	dd 23 	. # 
	inc ix		;0863	dd 23 	. # 
	ret			;0865	c9 	. 


; Computes the effective round, computed as 5*DRAGONS + LEVEL.
; Output: BC
;
; We assume the maximum is: 3 dragons and last level = 3*5 + 4 = 19.
; Actually if we force DRAGONS_LEVEL == 0xFF, it'll return 3*5 + 7 = 22
;
; Adding a RET at the beginning of this function makes the ME not to
; appear at level 2, and neither the moths at level 4. Instead, you
; have normal grippers.
;
GET_ROUND_IN_BC:
	ld a,(DRAGONS_LEVEL)	;0866	3a 80 e0
	ld l,a			        ;0869	6f      L = DRAGONS_LEVEL
	and 007h		        ;086a	e6 07   A = LEVEL
	ld h,a			        ;086c	67      H = LEVEL
	ld a,l			        ;086d	7d      A = DRAGONS_LEVEL
	and 038h		        ;086e	e6 38   A = 00DDD000
	cp 020h		            ;0870	fe 20 	    00100000: compare DRAGONS with 4
	jr c,l0876h		        ;0872	38 02 	Jump if DRAGONS < 4
    
    ; Dragons >= 4
	ld a,018h		        ;0874	3e 18 Set A = 3 dragons, first level (00.011.000)
l0876h:
    ; A = 00DDD000
	rrca			;0876	0f 	A = 000DDD00 = 4*DRAGONS
	ld l,a			;0877	6f 	L = A = 4*DRAGONS
	rrca			;0878	0f 	A = 2*DRAGONS
	rrca			;0879	0f 	A = 1*DRAGONS
	add a,l			;087a	85 	A = DRAGONS + 4*DRAGONS = 5*DRAGONS    
	add a,h			;087b	84 	A = 5*DRAGONS + LEVEL
	ld c,a			;087c	4f
	ld b,000h		;087d	06 00 BC = 5*DRAGONS + LEVEL
	ret			    ;087f	c9


; Starting time according to the level.
; It's set to the same for all levels, 2000.
TIME_BY_LEVEL_TABLE:
    defw 0x2000
    defw 0x2000
    defw 0x2000
    defw 0x2000
    defw 0x2000

; Table to obtain FLOOR_STAGE from GET_ROUND_IN_BC.
; 20 entries
TBL_FLOOR_STAGE_FROM_ROUND: ; 88a
    defb 0, 1, 0, 2, 0, 0, 3, 0
    defb 2, 0, 0, 4, 0, 2, 0, 0
	defb 5, 0, 2, 0

; Another table to obtain FLOOR_STAGE from GET_ROUND_IN_BC.
; 18 entries
TBL_FLOOR_STAGE_FROM_ROUND_2: ;089e
    defb 0, 0, 0, 10, 0, 0, 0, 0
    defb 11, 0, 0, 0, 0, 12, 0, 0
    defb 0, 0
    
INDICES_DATA_MAGICAL_ELEMENTS: ;08b0
; each indexed entry is 24 bytes
; It uses TBL_FLOOR_STAGE_FROM_ROUND (max 5 ==> 6 entries) to get the index.
    dw 0x000d
    dw MAGICAL_ELEMENTS_DATA_ENTRY_1
    dw MAGICAL_ELEMENTS_DATA_ENTRY_5
    dw MAGICAL_ELEMENTS_DATA_ENTRY_2
    dw MAGICAL_ELEMENTS_DATA_ENTRY_3
    dw MAGICAL_ELEMENTS_DATA_ENTRY_4
    
MAGICAL_ELEMENTS_DATA_ENTRY_1: ; 0x8BC + 0*24
    db 0x00, 0x00, 0x70, 0x00, 0x0d, 0x54, 0xa8, 0x43
    db 0x5a, 0x70, 0x66, 0xcc, 0x00, 0x00, 0x36, 0x00
    db 0x16, 0xa9, 0xb6, 0x01, 0x4b, 0x01, 0x7c, 0x00

MAGICAL_ELEMENTS_DATA_ENTRY_2: ; 0x8BC + 1*24
    db 0x00, 0x00, 0x70, 0x00, 0x0d, 0x54, 0xa8, 0x2d
    db 0x43, 0x5a, 0x66, 0xcc, 0x00, 0x00, 0x36, 0x00
    db 0x16, 0xa9, 0xb6, 0x01, 0x4b, 0x01, 0x7c, 0x00
    
MAGICAL_ELEMENTS_DATA_ENTRY_3: ; 0x8BC + 2*24
    db 0x00, 0x00, 0x70, 0x00, 0x0d, 0x54, 0xa8, 0x1c
    db 0x38, 0x43, 0x66, 0xcc, 0x00, 0x00, 0x36, 0x00
    db 0x16, 0xa9, 0xb6, 0x01, 0x4b, 0x01, 0x7c, 0x00

MAGICAL_ELEMENTS_DATA_ENTRY_4: ; 0x8BC + 3*24
    db 0x00, 0x00, 0x70, 0x00, 0x0d, 0x54, 0xa8, 0x1c
    db 0x2d, 0x38, 0x66, 0xcc, 0x00, 0x00, 0x36, 0x00
    db 0x16, 0xa9, 0xb6, 0x01, 0x4b, 0x01, 0x7c, 0x00

MAGICAL_ELEMENTS_DATA_ENTRY_5: ; 0x8BC + 4*24
    db 0x00, 0x00, 0x00, 0x36

    
INDICES_DATA_MOTHS: ; 0920
; It uses TBL_FLOOR_STAGE_FROM_ROUND_2 (max 12 ==> 13 entries) to get the index.
; We have 14 entries. Is the last one unused?
;
; 17 bytes per indexed entry
    defw 0x3000
    defw 0x0049
    defw 0x0000
    defw 0x0061
    defw 0x00A4
    defw 0x0036
    defw 0x0016
    defw 0x0052    
    defw 0x0049
    defw 0x002d
    defw TBL_INIT_MOTHS_1 ; 0x093c
    defw TBL_INIT_MOTHS_2 ; 0x094d
    defw TBL_INIT_MOTHS_3 ; 0x095e
    defw TBL_INIT_MOTHS_4;  0x096f
    
; Tables with init data for the moths
TBL_INIT_MOTHS_1: ; 0x093c
    db 0x20, 0x0, 0x32, 0x0, 0x28, 0x0, 0x33, 0x0
    db 0x23, 0x0, 0x6b, 0x7, 0x7f, 0x3f, 0x3f, 0x38
    db 0x70
	
TBL_INIT_MOTHS_2: ; 0x094d
    db 0x32, 0x00, 0x3b, 0x00, 0x3f, 0x00, 0x50, 0x00
    db 0x38, 0x00, 0x6b, 0x07, 0xb2, 0x3f, 0x66, 0x38
	db 0x70

TBL_INIT_MOTHS_3: ; 0x095e
	db 0x32, 0x00, 0x3b, 0x00, 0x3f, 0x00, 0x50, 0x00
	db 0x38, 0x00, 0x38, 0x04, 0x7f, 0x66, 0x66, 0x1c
    db 0x38
    
TBL_INIT_MOTHS_4: ; 0x096f
    db 0x3b, 0x00, 0x44, 0x00, 0x4a, 0x00, 0x5f, 0x00
    db 0x44, 0x00, 0x38, 0x04, 0xb2, 0x66, 0x7f, 0x1c
    db 0x38
    
INDICES_980: ;0981
    dw 0x0000
    dw 0x09a8
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x09a8
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x09a8
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0x09a8
    dw 0x0000
    dw 0x0000
    dw 0x0000
    dw 0xffb3
    dw 0x0007
    dw 0x002e
    dw 0x00d7

TBL_FLOOR_STAGE_FROM_ROUND_3:
	ret c			;09b0	d8 	. 
	add hl,bc			;09b1	09 	. 
	pop hl			;09b2	e1 	. 
	add hl,bc			;09b3	09 	. 
	rst 28h			;09b4	ef 	. 
	add hl,bc			;09b5	09 	. 
	add iy,bc		;09b6	fd 09 	. . 
	dec bc			;09b8	0b 	. 
	ld a,(bc)			;09b9	0a 	. 
	jr z,0x9c6		;09ba	28 0a 	( . 
	defb 031h, 00ah, 03fh
	ld a,(bc)			;09bf	0a 	. 
	ld c,l			;09c0	4d 	M 
	ld a,(bc)			;09c1	0a 	. 
	ld e,e			;09c2	5b 	[ 
	ld a,(bc)			;09c3	0a 	. 
	ld a,b			;09c4	78 	x 
	ld a,(bc)			;09c5	0a 	. 
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
	jr c,0x9bc		;09ee	38 cc 	8 . 
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
	ld (0x3000),hl		;0c7c	22 00 30 	" . 0 
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

; This routine reads the I/O ports of the player controls and
; store the info in a proper format in
; PLAYER_INPUT_COINS_P1P2_BUTTONS and PLAYER_INPUT.
CHECK_FLIPSCREEN_AND_READ_PLAYER_CONTROLS:
	ld a,(FLIP_SCREEN)	;0d05	3a 10 e9
	and 001h		    ;0d08	e6 01
	InP1Controls	    ;0d0a	db 01
    ; Here we have A = input of player 1
    ; DEBUG, A = 0xFD
    
    ; If the screen is not flipped, it means always it's  player 1
	jr z,l0d10h		    ;0d0c	28 02 It's player 1, all done
    
    ; The screen is flipped, so it's player 2 for sure
    ; Read the input of player 2
	InP2Controls		    ;0d0e	db 02
l0d10h:
    ; In A we have the read the player controls (P1 or P2)

	ld hl,(PLAYER_INPUT)  ;0d10	2a 06 e9
    ; DEBUG, HL = 0x0000
    
	call FORMAT_PLAYER_INPUT		    ;0d13	cd 3b 0d
	ld (PLAYER_INPUT),hl	;0d16	22 06 e9

	ld hl,PLAYER_BUTTONS_AND_UP		;0d19	21 08 e9
    ; RL: 9-bit rotation to the left. the register's bits are shifted left.
    ; The carry value is put into 0th bit of the register, and the leaving 7th bit is put into the carry.
    ;
    ;     7654.3210
    ; A = hgfe.dcba
    ; Extract bit #7
	rla			;0d1c	17      A = gfed.cba?, C=h
	rl (hl)		;0d1d	cb      (HL) = ????.???h
    ; Extract bit #5
	rla			;0d1f	17      A = fedc.ba??, C=g
	rla			;0d20	17      A = edcb.a???, C=f
	rl (hl)		;0d21	cb 16 	(HL) = ????.??hf
    ; ; Extract bit #3
	rla			;0d23	17      A = dcba.????, C=e
	rla			;0d24	17      A = cba?.????, C=d
	rl (hl)		;0d25	cb 16   (HL) = ????.?hfd

	InSystem		;0d27	db 00
	and 00fh		;0d29	e6 0f Read buttons (also service and coin sensor)
	ld b,a			;0d2b	47 	B = buttons = 0CCCC
    
	InP2Controls		;0d2c	db 02
	and 010h		    ;0d2e	e6 10 I don't get this. Why not and 0xF?
	or b			    ;0d30	b0 A = ?0000 | controls = ?CCCC
	ld hl,(PLAYER_INPUT_COINS_P1P2_BUTTONS)		;0d31	2a 04 e9 	* . . 
	call FORMAT_PLAYER_INPUT		;0d34	cd 3b 0d 	. ; . 
	ld (PLAYER_INPUT_COINS_P1P2_BUTTONS),hl		;0d37	22 04 e9 	" . . 
	ret			;0d3a	c9 	. 

; This formats the player input according to A, B, and C.
; The exact meaning of this transformation remains unknown yet.
; Input HL: either (PLAYER_INPUT) or (PLAYER_INPUT_COINS_P1P2_BUTTONS)
FORMAT_PLAYER_INPUT:
    ; A: player controls
    ; HL: (PLAYER_INPUT_x)
    
    ; DEBUG, A = 0xFD
    
	cpl			    ;0d3b	2f 	A = ~I
    ; DEBUG, A = 0x02
    
	ld b,a			;0d3c	47 	B = ~I
    ; DEBUG, B = 0x02
    
	xor h			;0d3d	ac 	A = ~I xor H0
    ; DEBUG, A = 0x02
        
	ld c,a			;0d3e	4f 	C = ~I xor H0
    ; DEBUG, C = 0x02
    
	and l			;0d3f	a5 	A = (~I xor H0) & L0
    ; DEBUG, A = 0x00
    
	ld l,a			;0d40	6f 	L = (~I xor H0) & L0
    ; DEBUG, L = 0x00
    
	ld a,c			;0d41	79 	A = ~I xor H0
    ; DEBUG, A = 0x02
    
	cpl			    ;0d42	2f 	A = ~(~I xor H0)
    ; DEBUG, A = 0xFD
    
	and h			;0d43	a4 	A = ~(~I xor H0) & H0
    ; DEBUG, A = 0x00

	or l			;0d44	b5 	A =  (~(~I xor H0) & H0) | L0
    ; DEBUG, A = 0x00
    
	ld l,a			;0d45	6f 	L = (~(~I xor H0) & H0) | L0
    ; DEBUG, L = 0x00
    
	ld h,b			;0d46	60 	H = ~I
    ; DEBUG, H = 0x02    
	ret			    ;0d47	c9

; Update the counter of inserted coins
CHECK_UPDATE_COINS:
	rrca			;0d48	0f 	. 
	rrca			;0d49	0f 	. 
	rrca			;0d4a	0f 	. 
	ld b,a			;0d4b	47 	G 
	ld a,(COIN_SENSOR)		;0d4c	3a 11 e9 	: . . 
	rla			;0d4f	17 	. 
	ld c,a			;0d50	4f 	O 
	and 049h		;0d51	e6 49 	. I 
	cp 049h		;0d53	fe 49 	. I 
	jr nz,l0d61h		;0d55	20 0a 	  . 
	ld hl,0e914h		;0d57	21 14 e9 Is 0e914h unused?
	inc (hl)			;0d5a	34 	4 
	ld a,(hl)			;0d5b	7e 	~ 
	and 00fh		;0d5c	e6 0f 	. . 
	call z,ADD_ONE_CREDIT		;0d5e	cc d6 0d 	. . . 
l0d61h:
	ld hl,COIN_INSERTED_A		            ;0d61	21 0c e9
	ld de,COINS_PER_CREDITS_A		        ;0d64	11 0a e9
	call INCREMENT_CREDITS_WITH_COIN_MODE	;0d67	cd b1 0d

	ld hl,COIN_INSERTED_B	                ;0d6a	21 0e e9
	inc de			                        ;0d6d	13 	Now DE = COINS_PER_CREDITS_B
	call INCREMENT_CREDITS_WITH_COIN_MODE	;0d6e	cd b1 0d

	ld hl,COIN_SENSOR		;0d71	21 11 e9 	! . . 
	ld (hl),c			;0d74	71 	q 

	dec hl			    ;0d75	2b HL = FLIP_SCREEN
	ld c,(hl)			;0d76	4e

	dec hl			;0d77	2b HL = FLIP_SCREEN
	ld b,004h		;0d78	06 04 	. . 
	call sub_0da2h		;0d7a	cd a2 0d 	. . . 
	ld hl,0e90dh		;0d7d	21 0d e9 	! . . 
	ld b,002h		;0d80	06 02 	. . 
	call sub_0da2h		;0d82	cd a2 0d 	. . . 
	ld a,c			;0d85	79 	y 
	ld (FLIP_SCREEN),a		;0d86	32 10 e9 	2 . . 
	OutP1Flipscreen		;0d89	d3 01 	. . 
	InDSW2		;0d8b	db 04 	. . 
	cpl			;0d8d	2f 	/ 
	xor c			;0d8e	a9 	. 
	and 001h		;0d8f	e6 01 	. . 
	jr z,l0d94h		;0d91	28 01 	( . 
	inc a			;0d93	3c 	< 
l0d94h:
	ld (0e916h),a		;0d94	32 16 e9 	2 . . 
	ld a,(COINS_PER_CREDITS_A)		;0d97	3a 0a e9 	: . . 
	and a			;0d9a	a7 	. 
	ret nz			;0d9b	c0 	. 
    ; Free play
	ld a,002h		;0d9c	3e 02 	> . 
	ld (COINS),a		;0d9e	32 13 e9 	2 . . 
	ret			;0da1	c9 	. 

; SEGUIR
; (HL) seems to be some kind of downcounter 12 ... 0.
; Input C
sub_0da2h:
    ; Q K

	dec (hl)		;0da2	35      We call K this first byte
	ret p			;0da3	f0      Exit when K < 0.
    
	ld (hl), 12		;0da4	36 0c   Start over with K = 12.
    
    ; Go to the other byte at HL-1. We call it Q
	dec hl			;0da6	2b
    
	; Exit if Q = 0
    ld a,(hl)		;0da7	7e
	and a			;0da8	a7
	ret z			;0da9	c8
    
	ld a,b			;0daa	78  A = Q
	xor c			;0dab	a9  A = Q xor C
	ld c,a			;0dac	4f  C = Q xor C
	and b			;0dad	a0  A = (Q xor C) & B
	ret nz			;0dae	c0  Exit if (Q xor C) & B != 0
    
	dec (hl)		;0daf	35  Decrement Q
	ret			;0db0	c9 	. 

; Updates COINS according to the coinage policy
; Input:
; A: from COIN_SENSOR
; HL: COIN_INSERTED_A or COIN_INSERTED_B
; DE: COINS_PER_CREDITS_A or COINS_PER_CREDITS_B
INCREMENT_CREDITS_WITH_COIN_MODE:
    ; Increment coin counter
	rrc b		;0db1	cb 08
	rl c		;0db3	cb 11
	ld a,c		;0db5	79
	and 049h	;0db6	e6 49
	cp 001h		;0db8	fe 01
	ret nz		;0dba	c0
	inc (hl)	;0dbb	34

    ; Sound when inserting a coin.
    ; Somehow inverted logic with ALLOWED_TO_ADD_SOUND here!
	ld a,(ALLOWED_TO_ADD_SOUND)	;0dbc	3a 06 e0
	and a			            ;0dbf	a7
	ld a,001h		            ;0dc0	3e 01
	call z,PLAY_SOUND		    ;0dc2	cc fe 0d
	
    ld a,(de)			                ;0dc5	1a
	cp 1		                        ;0dc6	fe 01
	jr z,l0ddah		                    ;0dc8	28 10 Give a credit if just one coin/credit is needed

    ; Ignore asking the player to put more than 7 coins/credit.
    ; The maximum is 7.
	cp 8		        ;0dca	fe 08
	jr nc,l0dd8h		;0dcc	30 0a

    ; Check if we have inserted the required number of coins.
    ; Give one crete if so, and exit otherwise.
	ld hl,COINS_INSERTED_BEFORE_CREDIT	;0dce	21 12 e9
	inc (hl)			                ;0dd1	34
	cp (hl)			                    ;0dd2	be
	ret nz			                    ;0dd3	c0
	ld (hl),000h		                ;0dd4	36 00

; Adds one more credit
ADD_ONE_CREDIT:
	ld a, 9		;0dd6	3e 09
l0dd8h:
	sub 8		;0dd8	d6 08
l0ddah:
	ld hl,COINS		;0dda	21 13 e9 	! . . 
	add a,(hl)			;0ddd	86 	. 
	daa			;0dde	27
    ; See here for a good description of DAA: https://ehaskins.com/2018-01-30%20Z80%20DAA/
	jr nc,l0de3h	;0ddf	30 02 If we have more than 99 coins, limit to 99
	ld a,099h		;0de1	3e 99 Ignore if we add more than 99 coins
l0de3h:
	ld (hl),a		;0de3	77
	ret			    ;0de4	c9

; Sends the next sound in SOUNDS_IN_CHANNELS_LIST to the
; Irem Audio hardware.
SEND_NEXT_SOUND_TO_IREM_AUDIO:
    ; A = AUDIO_CHANNEL
	ld hl,AUDIO_CHANNEL		;0de5	21 17 e9
	ld a,(hl)			    ;0de8	7e
	and a			        ;0de9	a7
	ret z			        ;0dea	c8 Exit if no channels playing
    
	dec (hl)			    ;0deb	35 AUDIO_CHANNEL = AUDIO_CHANNEL - 1
    
	inc hl			        ;0dec	23 HL = SOUNDS_IN_CHANNELS_LIST
	ld a,(hl)			    ;0ded	7e Load sound code
    
    ; Ask the Irem Audio hardware to play the sound
	OutIremAudio		    ;0dee	d3 00
	or 080h		            ;0df0	f6 80
	OutIremAudio		    ;0df2	d3 00
    
    ; Move the sound codes in the list one position to the left, so
    ; next time the following sound will be played.
	inc hl			;0df4	23 	# 
	ld de,SOUNDS_IN_CHANNELS_LIST	;0df5	11 18 e9
	ld bc, 15		                ;0df8	01 0f 00
	ldir		;0dfb	ed b0 	. . 
	ret			;0dfd	c9 	. 

PLAY_SOUND: ; 0dfe
    ; A = sound to play
	push hl			;0dfe	e5
	push de			;0dff	d5
	ld d,a			;0e00	57 D = sound to play
	bit 7,d		    ;0e01	cb 7a D >= 0x80?
	jr z,l0e0dh		;0e03	28 08 No, it's high priority, so play the sound without checking ALLOWED_TO_ADD_SOUND
    
    ; D >= 0x80: normal priority ==> check ALLOWED_TO_ADD_SOUND.
	ld a,(ALLOWED_TO_ADD_SOUND)	        ;0e05	3a 06 e0
	and a			        ;0e08	a7 Check ALLOWED_TO_ADD_SOUND
	jr z,exit_play_sound	;0e09	28 12 Exit if ALLOWED_TO_ADD_SOUND = 0
	res 7,d		            ;0e0b	cb ba D = D - 0x80. Get back to sound code.
    ; [ALLOWED_TO_ADD_SOUND] != 0
l0e0dh:
	ld hl,AUDIO_CHANNEL	    ;0e0d	21 17 e9
	ld a,(hl)		        ;0e10	7e
	cp 16		            ;0e11	fe 10
	jr nc,exit_play_sound	;0e13	30 08 Exit if AUDIO_CHANNEL > 15: 
	inc (hl)		        ;0e15	34 Increment AUDIO_CHANNEL

	inc hl			;0e16	23 HL = SOUNDS_IN_CHANNELS_LIST
    
    ; DE = A = [AUDIO_CHANNEL]
    ; A = D = sound to play
	ld e,a			;0e17	5f 
	ld a,d			;0e18	7a
	ld d,000h		;0e19	16 00
	add hl,de		;0e1b	19 HL = SOUNDS_IN_CHANNELS_LIST + AUDIO_CHANNEL
	ld (hl),a		;0e1c	77 [SOUNDS_IN_CHANNELS_LIST + AUDIO_CHANNEL] <-- sound to play
exit_play_sound:
	pop de			;0e1d	d1
	pop hl			;0e1e	e1
	ret			    ;0e1f	c9
    
; In 0xE917: 1 24
; In 0xE917: 2 0 24
; <channel>, ..., <sound #>


l0e20h:
	push hl			;0e20	e5 	. 
	ld c,a			;0e21	4f 	O 
	ld a,(0eb00h)		;0e22	3a 00 eb 	: . . 
	ld b,a			;0e25	47 	G 
	ld iy,(0eb01h)		;0e26	fd 2a 01 eb 	. * . . 
	bit 6,c		;0e2a	cb 71 	. q 
	ld hl,0x0020		;0e2c	21 20 00 	!   . 
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
	ld a,(KNIFE_STATUS)		;0e66	3a 07 e8 	: . . 
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
	ld de, 8		;0e8a	11 08 00 	. . . 
	add iy,de		;0e8d	fd 19 	. . 
	inc hl			;0e8f	23 	# 
	djnz l0e3ch		;0e90	10 aa 	. . 
l0e92h:
	ld (0eb01h),iy		;0e92	fd 22 01 eb 	. " . . 
	ld a,b			;0e96	78 	x 
	ld (0eb00h),a		;0e97	32 00 eb 	2 . . 
	ret			;0e9a	c9 	. 

; Draw the panel after resetting its values.
; To draw the actual elements contained, the DRAW_PANEL_ELEMENTS routine is used.
RESET_PANEL:
	ld hl,PANEL_TEXT_STR	;0e9b	21 a7 59
	call WRITE_TEXT		    ;0e9e	cd 1c 11
	call PRINT_POINTS_P1	;0ea1	cd a5 10
	call PRINT_POINTS_P2	;0ea4	cd ab 10
	call PRINT_TOP_SCORE	;0ea7	cd cf 10
	call PRINT_TIME		    ;0eaa	cd d9 10
	call DRAW_LIVES		    ;0ead	cd e6 10
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;0eb0	3a 1c e8
	and a			        ;0eb3	a7
	call z,DRAW_DRAGONS		;0eb4	cc 1a 0f
	ld a,3		            ;0eb7	3e 03 	> . 
	ld (INT_COUNTER + 1),a		;0eb9	32 81 e8 	2 . . 
	ld a,(ENERGY)		;0ebc	3a 09 e7 	: . . 
	ld (ENERGY_DISP),a		;0ebf	32 1a e8 	2 . . 
	ld a,(ENEMY_ENERGY)		;0ec2	3a e2 e2 	: . . 
	ld (ENEMY_ENERGY_DISP),a		;0ec5	32 19 e8 	2 . . 
    
    ; Draw player's energy
	call DRAW_PLAYER_ENERGY		;0ec8	cd 78 0f
    
    ; Draw enemy's energy
	call DRAW_BOSS_ENERGY		;0ecb	cd 6b 0f 	. k . 

    
    ; Draw the 1F, ..., 5F text
	ld de,0d0a0h		;0ece	11 a0 d0 	. . . 
	ld bc,0x0594		;0ed1	01 94 05 B = 4 floors
	ld a,0a1h		;0ed4	3e a1 	> . 
l0ed6h:
	call WRITE_CHAR_AT_SCREEN_DE		;0ed6	cd 10 11 	. . . 
	inc a			;0ed9	3c 	< 
	inc de			;0eda	13 	. 
	djnz l0ed6h		;0edb	10 f9 	. . 
	ld a,(DRAGONS_LEVEL)		;0edd	3a 80 e0 	: . . 
    
    ; Draw the upper part of the floor indicators in the panel
	and 007h		;0ee0	e6 07 	. . 
	inc a			;0ee2	3c 	< 
	ld h,a			;0ee3	67 	g 
	ld a,0a6h		;0ee4	3e a6 	> . 
	ld de,0d0e0h		;0ee6	11 e0 d0 	. . . 
	call PRINT_FLOOR_INDICATORS		;0ee9	cd 0a 0f 	. . . 

    ; Draw the lower part of the floor indicators in the panel
	inc a			;0eec	3c
	ld de,0d120h		;0eed	11 20 d1 	.   . 
	call PRINT_FLOOR_INDICATORS		;0ef0	cd 0a 0f

	; Draw the upper part of the arrows
    ld de,0d0e1h		;0ef3	11 e1 d0 	. . . 
	ld c,094h		;0ef6	0e 94 	. . 
	ld a,0a8h		;0ef8	3e a8 	> . 
	call PRINT_FLOOR_INDICATOR_ARROWS		;0efa	cd 01 0f 	. . . 
    
    ; And the lower part of the arrows, now with a loop
	ld de,0d121h	;0efd	11 21 d1
	inc a		    ;0f00	3c
PRINT_FLOOR_INDICATOR_ARROWS:
	ld b, 4		    ;0f01	06 04 We have 4 arrows
l0f03h:
	call WRITE_CHAR_AT_SCREEN_DE		;0f03	cd 10 11 	. . . 
	inc de			;0f06	13 	. 
	djnz l0f03h		;0f07	10 fa 	. . 
	ret			;0f09	c9 	. 

PRINT_FLOOR_INDICATORS:
	ld l,h			;0f0a	6c 	l 
	ld b,005h		;0f0b	06 05 	. . 
	ld c,094h		;0f0d	0e 94 	. . 
l0f0fh:
	call WRITE_CHAR_AT_SCREEN_DE		;0f0f	cd 10 11 	. . . 
	inc de			;0f12	13 	. 
	dec l			;0f13	2d 	- 
	jr nz,l0f17h		;0f14	20 01 	  . 
	inc c			;0f16	0c 	. 
l0f17h:
	djnz l0f0fh		;0f17	10 f6 	. . 
	ret			;0f19	c9 	. 

; Draw the dragons in the panel
DRAW_DRAGONS:
	ld a,(DRAGONS_LEVEL)	;0f1a	3a 80 e0
	and 0f8h		        ;0f1d	e6 f8 Check dragons
	rrca			;0f1f	0f
	rrca			;0f20	0f
	rrca			;0f21	0f A = dragons
	ld b,a			;0f22	47 B = dragons

	InDSW1		    ;0f23	db 03
	and 001h		;0f25	e6 01  Check bit 0: difficulty
	jr nz,l0f2ah	;0f27	20 01 Jump if 1 (easy)
    ; It's hard
	dec b			;0f29	05 B = dragons-1
l0f2ah:
	ld a,b			;0f2a	78 A = dragons or dragons-1 depending on the difficulty
	and a			;0f2b	a7
	ret z			;0f2c	c8 Exit if no dragons

	cp 3		    ;0f2d	fe 03 More than 4 dragons?
	jr c,l0f33h		;0f2f	38 02   No, go on normally
	ld a,003h		;0f31	3e 03   Yes, set a maximum of 3 dragons
    
    ; It'll print now the dragons, with A = number of dragons
l0f33h:
	ld b,a			;0f33	47      B = dragons, uses in the loop
	ld c,080h		;0f34	0e 80   Color
	ld de,0d129h	;0f36	11 29 d1
l0f39h:
	call DRAW_ONE_DRAGON	;0f39	cd 3f 0f
	djnz l0f39h		;0f3c	10 fb
	ret			    ;0f3e	c9

; Writes one dragon (4 chars)
DRAW_ONE_DRAGON:
	ld a,0b8h		            ;0f3f	3e b8
    ; Upper part
	call WRITE_CHAR_AND_NEXT	;0f41	cd 4f 0f
	push de			            ;0f44	d5
	ld hl,0003eh		        ;0f45	21 3e 00
	add hl,de			        ;0f48	19
	ex de,hl			        ;0f49	eb
    ; Lower part
	call WRITE_CHAR_AND_NEXT	;0f4a	cd 4f 0f
	pop de			            ;0f4d	d1
	ret			                ;0f4e	c9
    
; Write A and char A+1.
; A: initial character
; C: color
; DE: position in the screen
WRITE_CHAR_AND_NEXT:
	call WRITE_CHAR_AT_SCREEN_DE		;0f4f	cd 10 11
	inc a			                    ;0f52	3c
	call WRITE_CHAR_AT_SCREEN_DE		;0f53	cd 10 11
	inc a			                    ;0f56	3c
	ret			                        ;0f57	c9

; Erase the dragons from the panel.
; Use to make them blink from DRAW_PANEL_ELEMENTS.
ERASE_DRAGONS:
	ld de,0d129h		;0f58	11 29 d1 	. ) . 
	xor a			;0f5b	af 	. 
	ld c,a			;0f5c	4f 	O 
	call WRITE_6_CHARS		;0f5d	cd 63 0f 	. c . 
	ld de,0d169h		;0f60	11 69 d1 	. i . 
WRITE_6_CHARS:
	ld b,006h		;0f63	06 06 	. . 
l0f65h:
	call WRITE_CHAR_AT_SCREEN_DE		;0f65	cd 10 11 	. . . 
	djnz l0f65h		;0f68	10 fb 	. . 
	ret			;0f6a	c9 	. 

; Draw the energy bar of the boss or the player.
DRAW_BOSS_ENERGY:
	ld de,0d116h		;0f6b	11 16 d1 	. . . 
	ld hl,ENEMY_ENERGY_DISP		;0f6e	21 19 e8 	! . . 
	ld a,(ENEMY_ENERGY)		;0f71	3a e2 e2 	: . . 
	ld c,015h		;0f74	0e 15 	. . 
	jr l0f83h		;0f76	18 0b 	. . 
DRAW_PLAYER_ENERGY:
	ld de,0d096h		;0f78	11 96 d0 	. . . 
	ld hl,ENERGY_DISP		;0f7b	21 1a e8 	! . . 
	ld a,(ENERGY)		;0f7e	3a 09 e7 	: . . 
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
	call WRITE_CHAR_AT_SCREEN_DE		;0fb1	cd 10 11 	. . . 
	ld a,l			;0fb4	7d 	} 
	djnz l0f99h		;0fb5	10 e2 	. . 
	ret			;0fb7	c9 	. 

; Decreases the time, plays the time decrease sound, and updates the panel
DECREASE_TIME_UPDATE_PANEL:
	ld a,(GAME_STATE)		;0fb8	3a 00 e0 	: . . 
	cp GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED		;0fbb	fe 03
	jr z,DRAW_PANEL_ELEMENTS		;0fbd	28 24 	( $ 
	ld hl,(TIME)		;0fbf	2a 03 e0 	* . . 
	ld de, -819 		;0fc2	11 cd fc
	add hl,de			;0fc5	19 	. 
	jr c,DRAW_PANEL_ELEMENTS		;0fc6	38 1b 	8 . 
	ld hl,0e008h		;0fc8	21 08 e0 	! . . 
	ld a,(hl)			;0fcb	7e 	~ 
	and a			;0fcc	a7 	. 
	jr nz,l0fd5h		;0fcd	20 06 	  . 
	ld a,000h		;0fcf	3e 00 	> . 
	call PLAY_SOUND		;0fd1	cd fe 0d 	. . . 
	inc (hl)			;0fd4	34 	4 
l0fd5h:
	ld hl,INT_COUNTER + 5		;0fd5	21 85 e8 	! . . 
	ld a,(hl)			;0fd8	7e 	~ 
	and a			;0fd9	a7 	. 
	jr nz,DRAW_PANEL_ELEMENTS		;0fda	20 07 	  . 
	ld (hl),038h		;0fdc	36 38 	6 8 
	ld a,097h		;0fde	3e 97 	> . 
	call PLAY_SOUND		;0fe0	cd fe 0d 	. . . 

; Draw the player and boss energy bars, scores, time, lives.
; It checks to grant the extra life too.
DRAW_PANEL_ELEMENTS:
	ld hl,0e81bh		;0fe3	21 1b e8 	! . . 
	ld a,(INT_COUNTER)		;0fe6	3a 80 e8 	: . . 
	cp (hl)			;0fe9	be 	. 
	jr z,l103ah		;0fea	28 4e 	( N 
	ld (hl),a			;0fec	77 	w 
	call DRAW_PLAYER_ENERGY		;0fed	cd 78 0f 	. x . 
	call DRAW_BOSS_ENERGY		;0ff0	cd 6b 0f 	. k . 
	ld hl,0d0e0h		;0ff3	21 e0 d0 	! . . 
	ld a,(DRAGONS_LEVEL)		;0ff6	3a 80 e0 	: . . 
	and 007h		;0ff9	e6 07 	. . 
	add a,a			;0ffb	87 	. 
	ld e,a			;0ffc	5f 	_ 
	ld d,000h		;0ffd	16 00 	. . 
	add hl,de			;0fff	19 	. 
	ld a,(INT_COUNTER)		;1000	3a 80 e8 	: . . 
	set 3,h		;1003	cb dc 	. . 
	ld a,(INT_COUNTER)		;1005	3a 80 e8 	: . . 
	and 018h		;1008	e6 18 	. . 
	ld a,095h		;100a	3e 95 	> . 
	jr z,l100fh		;100c	28 01 	( . 
	dec a			;100e	3d 	= 
l100fh:
	ld (hl),a			;100f	77 	w 
	ld de,l0040h		;1010	11 40 00 	. @ . 
	add hl,de			;1013	19 	. 
	ld (hl),a			;1014	77 	w 
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;1015	3a 1c e8 	: . . 
	and a			;1018	a7 	. 
	jr nz,l105ah		;1019	20 3f 	  ? 
	ld b,a			;101b	47 	G 

	InDSW1		    ;101c	db 03 	. . 
	and 001h		;101e	e6 01 Check bit 0: difficulty

	ld a,(DRAGONS_LEVEL)		;1020	3a 80 e0 	: . . 
	jr nz,l1027h		;1023	20 02 	  . 
	sub 008h		;1025	d6 08 	. . 
l1027h:
	cp 020h		;1027	fe 20 	.   
	jr c,l103ah		;1029	38 0f 	8 . 

    ; Dragon blinking
	ld a,(INT_COUNTER)		;102b	3a 80 e8 	: . . 
	and 018h		;102e	e6 18 	. . 
	jr z,l1037h		;1030	28 05 	( . 
	call DRAW_DRAGONS		;1032	cd 1a 0f 	. . . 
	jr l103ah		;1035	18 03 	. . 
l1037h:
	call ERASE_DRAGONS		;1037	cd 58 0f 	. X . 
l103ah:
    ; Check if we've already given the extra life
	ld a,(SKIP_LETTER_SKIP_EXTRA_LIFE)	;103a	3a 85 e0
	and 001h		;103d	e6 01 Bit #0 of SKIP_LETTER_SKIP_EXTRA_LIFE: extra live already given
	jr nz,l105ah	;103f	20 19 Yes, we've already given it, don't check any more
    
    ; We haven't given the extra life: check if the score is over 20480 points
	ld hl,(POINTS)		;1041	2a 81 e0
	ld de, 0x5000		;1044	11 00 50 50,000 points
	sbc hl,de		    ;1047	ed 52
	jr c,l105ah		    ;1049	38 0f POINTS < 50,000
    ; POINTS >= 20480
	
    ; Set bit #0 of SKIP_LETTER_SKIP_EXTRA_LIFE: extra life has been already given
    ld hl,SKIP_LETTER_SKIP_EXTRA_LIFE	;104b	21 85 e0
	set 0,(hl)		;104e	cb c6
    
	dec hl			;1050	2b
    ; Now HL = 0xE084 = @LIVES
    ; Increment lives
	inc (hl)			;1051	34 	4 
    
	ld a,098h		;1052	3e 98 	> . 
	call PLAY_SOUND		;1054	cd fe 0d 	. . . 
	call DRAW_LIVES		;1057	cd e6 10 	. . . 
l105ah:
	ld a,(GAME_STATE)		;105a	3a 00 e0 	: . . 
	cp GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED		;105d	fe 03
	jr z,l1080h		;105f	28 1f 	( . 
	cp 00ch		;1061	fe 0c 	. . 
	jr z,l1080h		;1063	28 1b 	( . 
	ld hl,INT_COUNTER + 1		;1065	21 81 e8 	! . . 
	ld a,(hl)			;1068	7e 	~ 
	and a			;1069	a7 	. 
	jr nz,l1080h		;106a	20 14 	  . 
	ld (hl),003h		;106c	36 03 	6 . 
	ld hl,(TIME)		;106e	2a 03 e0 	* . . 
	ld a,l			;1071	7d 	} 
	sub 001h		;1072	d6 01 	. . 
	daa			;1074	27 	' 
	ld l,a			;1075	6f 	o 
	ld a,h			;1076	7c 	| 
	sbc a,000h		;1077	de 00 	. . 
	daa			;1079	27 	' 
	ld h,a			;107a	67 	g 
	jr c,l1080h		;107b	38 03 	8 . 
	ld (TIME),hl		;107d	22 03 e0 	" . . 
l1080h:
	call PRINT_TIME		;1080	cd d9 10 	. . . 
	ld a,(POINTS + 2)		;1083	3a 83 e0 	: . . 
	ld c,a			;1086	4f 	O 
	ld de,(POINTS)		;1087	ed 5b 81 e0 	. [ . . 
	ld a,(POINTS_TOP + 2)		;108b	3a 82 e9 	: . . 
	ld hl,(POINTS_TOP)		;108e	2a 80 e9 	* . . 
	sub c			;1091	91 	. 
	jr c,l109ah		;1092	38 06 	8 . 
	jr nz,PRINT_POINTS_P1		;1094	20 0f 	  . 
	sbc hl,de		;1096	ed 52 	. R 
	jr nc,PRINT_POINTS_P1		;1098	30 0b 	0 . 
l109ah:
    ; Update top score
	ld a,c			        ;109a	79
	ld (POINTS_TOP + 2),a	;109b	32 82 e9
	ld (POINTS_TOP),de		;109e	ed 53 80 e9
	call PRINT_TOP_SCORE	;10a2	cd cf 10

PRINT_POINTS_P1:
	xor a			;10a5	af 	. 
	ld de,POINTS + 2		;10a6	11 83 e0 	. . . 
	jr l10b0h		;10a9	18 05 	. . 

PRINT_POINTS_P2:
	ld a,001h		;10ab	3e 01 	> . 
	ld de,POINTS_P2 + 2	;10ad	11 93 e0 	. . . 
l10b0h:
	ld hl,PLAYER_TURN		;10b0	21 02 e0 	! . . 
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
	call PRINT_DIGIT		;10c3	cd 08 11 	. . . 
	call PRINT_TWO_DIGITS_DEC_HL		;10c6	cd fd 10 	. . . 
	call PRINT_TWO_DIGITS_DEC_HL		;10c9	cd fd 10 	. . . 
    ; Print a zero
	xor a			;10cc	af 	. 
	jr PRINT_DIGIT		;10cd	18 39 	. 9 

PRINT_TOP_SCORE:
	ld hl,0e982h		;10cf	21 82 e9 	! . . 
	ld de,0d01fh		;10d2	11 1f d0 	. . . 
	ld c,000h		;10d5	0e 00 	. . 
	jr l10c1h		;10d7	18 e8 	. . 

PRINT_TIME:
	ld c,014h		;10d9	0e 14
	ld hl, TIME + 1	;10db	21 04 e0
	ld de,0d0eah		;10de	11 ea d0 	. . . 
	call PRINT_TWO_DIGITS_DEC_HL		;10e1	cd fd 10 	. . . 
	jr PRINT_TWO_DIGITS_DEC_HL		;10e4	18 17 	. . 

DRAW_LIVES:
	ld a,(LIVES)		;10e6	3a 84 e0 	: . . 
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
	call WRITE_CHAR_AT_SCREEN_DE		;10f7	cd 10 11 	. . . 
	djnz l10f3h		;10fa	10 f7 	. . 
	ret			;10fc	c9 	. 

; Prints two digits encoded in the 4 MSB and 4 LSB of A.
; It moves the HL pointer one position back
; A: the two numbers (NNNN.MMMM)
; C: color
; DE: position in the screen
PRINT_TWO_DIGITS_DEC_HL:
	ld a,(hl)		;10fd	Read number
	dec hl			;10fe	Move pointer to the previous digit

PRINT_TWO_DIGITS:
	push af			;10ff	f5
    ; Rotate num 4 times to the right
    ; This is to move the MSB to the LSB
	rrca			;1100	0f
	rrca			;1101	0f
	rrca			;1102	0f
	rrca			;1103	0f
    ; Now it'll print the number which was at NNNNxxxx.
	call PRINT_DIGIT	;1104	cd 08 11
	pop af			    ;1107	f1
    
    ; With the POP it's recoved the original A, so now it'll print the
    ; number at the LSB: xxxxMMMM.

; Write a digit on the screen
; A: number (the 4 LSB)
; C: color
; DE: position in the screen
PRINT_DIGIT:
	and 00fh		;1108	e6 0f Consider only the 4 LSB
	add a,090h		;110a	c6 90 	. . 
	daa			;110c	27 	' 
	adc a,040h		;110d	ce 40 	. @ 
	daa			;110f	27 	' 

; Write a character on the screen
; A: character
; C: color
; DE: position in the screen
WRITE_CHAR_AT_SCREEN_DE:
	ex de,hl			;1110	eb 	. 
	ld (hl),a			;1111	77 A: character
	set 3,h		        ;1112	cb dc Activating bit 3 in H is actually adding 0x800 to HL and
                        ;             thus pointing to the color part of the M62 tileram.
	ld (hl),c			;1114	71 C: color
	res 3,h		;1115	cb 9c 	. . 
	inc hl			;1117	23 	# 
	ex de,hl			;1118	eb 	. 
	ret			;1119	c9 	. 

l111ah:
	ld c,(hl)			;111a	4e 	N 
l111bh:
	inc hl			;111b	23 	#
;
WRITE_TEXT:
	ld a,(hl)			;111c	7e 	~ 
	inc hl			;111d	23 	# 
	inc a			;111e	3c 	< 
	ret z			;111f	c8 	. 
	inc a			;1120	3c 	< 
	jr z,l111ah		;1121	28 f7 	( . 
	inc a			;1123	3c 	< 
	jr z,l112dh		;1124	28 07 	( . 
	sub 003h		;1126	d6 03 	. . 
	call WRITE_CHAR_AT_SCREEN_DE		;1128	cd 10 11 	. . . 
	jr WRITE_TEXT		;112b	18 ef 	. . 
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
	call WRITE_CHAR_AT_SCREEN_DE		;1140	cd 10 11 	. . . 
	cp 020h		;1143	fe 20 	.   
	jr nz,l1134h		;1145	20 ed 	  . 
	ld a,00bh		;1147	3e 0b 	> . 
	call DELAY_A		;1149	cd 0f 57 	. . W 
	jr l1134h		;114c	18 e6 	. . 
l114eh:
	ld e,(hl)			;114e	5e 	^ 
	inc hl			;114f	23 	# 
	ld d,(hl)			;1150	56 	V 
	jr l1133h		;1151	18 e0 	. . 

CLS_CYAN:
	ld d,001h		;1153	16 01 	. . 
	jr l1159h		;1155	18 02


; Clears the tilemap visibles on the screen.
; It sets tile 0x20 (blank space) and color 0xDB.
CLEAR_TILEMAP:
    ; D is the color
	ld d,0dbh		    ;1157	16 db
l1159h:
    ; E is the character
	ld e, ' '       	;1159	1e 20
CLEAR_TILEMAP_WITH_DE:
	ld bc,32*2*32	    ;115b	01 00 08
CLEAR_TILEMAP_WITH_DE_BC:
	ld hl,M62_TILERAM		;115e	21 00 d0
	ld iy,M62_TILERAM_COLORS ;1161	fd 21 00 d8
l1165h:
	ld (hl),e			;1165	73 Set tile to blank (0x20)
	ld (iy+000h),d		;1166	fd 72 00 Set color
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
	ld a,(THOMAS_FRAME)		;1184	3a 06 e7 	: . . 
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
	ld hl,(THOMAS_POSITION)		;11be	2a 12 e7 	* . . 
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
	ld hl,(THOMAS_POSITION)		;11e2	2a 12 e7 	* . . 
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

; Return Z if in demo or vulnerable (without vulnerability cheat)
; Z = demo || vulnerable
; This is used to avoid applying the invulnerability cheat in the demo.
CHECK_DEMO_OR_VULNERABLE:
    ; Return Z if in demo
	ld a,(GAME_STATE)		;1208	3a 00 e0
	cp GAME_STATE_DEMO		;120b	fe 06
	ret z			        ;120d	c8
    ;
	InDSW2		            ;120e	db 04
	cpl			            ;1210	2f
    ; Return NZ if invulnerability cheat = return Z if vulnerable
	bit 6,a		            ;1211	cb 77
	ret			            ;1213	c9

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
	ld a,(THOMAS_FRAME)		;1223	3a 06 e7 	: . . 
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
	ld hl,(THOMAS_POSITION)		;124a	2a 12 e7 	* . . 
	ld a,(0e701h)		;124d	3a 01 e7 	: . . 
	and 040h		;1250	e6 40 	. @ 
	jr z,l1257h		;1252	28 03 	( . 
	add hl,de			;1254	19 	. 
	jr l1259h		;1255	18 02 	. . 
l1257h:
	sbc hl,de		;1257	ed 52 	. R 
l1259h:
	ld e,(ix + ENEMY_POS_L_IDX)		;1259	dd 5e 02
	ld d,(ix + ENEMY_POS_H_IDX)		;125c	dd 56 03
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
	ld bc,0x0101		;1283	01 01 01 	. . . 
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
	ld hl,THOMAS_PROPS		;12ac	21 00 e7 	! . . 
	bit 1,(hl)		    ;12af	cb 4e ; Check if Thomas is actually fighting
	jr nz,l12c5h		;12b1	20 12 ; Skip all this if he's not fighting
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
	ld hl,TBL_E10A		;12d7	21 0a e1 	! . . 
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
	ld bc,0x0101		;12f2	01 01 01 	. . . 
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
    ; Check Thomas' moving direction and add/subtract 28 to his position
	ld a,(0e701h)	;12fe	3a 01 e7
	and 080h		;1301	e6 80
	ld c, -28		;1303	0e e4
	jr z,l1309h		;1305	28 02
	ld c, 28		;1307	0e 1c
l1309h:
	ld a,(THOMAS_POSITION_H)		;1309	3a 13 e7 	: . . 
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
	ld ix,TBL_E10A		;132b	dd 21 0a e1 	. ! . . 
	add ix,bc		;132f	dd 09 	. . 
	add ix,bc		;1331	dd 09 	. . 
	bit 7,(ix + 0)		;1333	dd cb 00 7e 	. . . ~ 
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
	ld a,(ix + 0)		;136d	dd 7e 00 	. ~ . 
	ld (hl),a			;1370	77 	w 
	ld a,(ix + 1)		;1371	dd 7e 01 	. ~ . 
	ld hl,(0e108h)		;1374	2a 08 e1 	* . . 
	inc hl			;1377	23 	# 
	ld (hl),a			;1378	77 	w 
	inc hl			;1379	23 	# 
	ld (hl),c			;137a	71 	q 
	ld (0e108h),hl		;137b	22 08 e1 	" . . 
	set 7,(ix + 0)		;137e	dd cb 00 fe 	. . . . 
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
	ld bc,(THOMAS_POSITION)		;13b5	ed 4b 12 e7 	. K . . 
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
	ld bc,(THOMAS_POSITION)		;1415	ed 4b 12 e7 	. K . . 
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
	ld a,(NEW_GUY_SIDE)		;143f	3a 60 e2 	: ` . 
	ld b,a			;1442	47 	G 
	xor 028h		;1443	ee 28 	. ( 
	ret z			;1445	c8 	. 
	ld a,(TBL_ENEMIES)		;1446	3a d8 e2 	: . . 
	and 010h		;1449	e6 10 	. . 
	ld a,(0e196h)		;144b	3a 96 e1 	: . . 
	jr z,l1453h		;144e	28 03 	( . 
	ld a,(0e197h)		;1450	3a 97 e1 	: . . 
l1453h:
	and a			;1453	a7 	. 
	jr z,l145ch		;1454	28 06 	( . 
	ld c,a			;1456	4f 	O 
	ld a,(TBL_GUYS_LEN)		;1457	3a 61 e2 	: a . 
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
	ld hl,(THOMAS_POSITION)		;147d	2a 12 e7 	* . . 
	ld de,l1200h		;1480	11 00 12 	. . . 
	sbc hl,de		;1483	ed 52 	. R 
	ld de,0be00h		;1485	11 00 be 	. . . 
	sbc hl,de		;1488	ed 52 	. R 
	jr nc,l148eh		;148a	30 02 	0 . 
	add hl,de			;148c	19 	. 
	ex de,hl			;148d	eb 	. 
l148eh:
	ld a,(TBL_ENEMIES)		;148e	3a d8 e2 	: . . 
	ld l,a			;1491	6f 	o 
	bit 4,l		;1492	cb 65 	. e 
	jr z,l14b1h		;1494	28 1b 	( . 
	ld a,(0e197h)		;1496	3a 97 e1 	: . . 
	and a			;1499	a7 	. 
	jr z,l14a7h		;149a	28 0b 	( . 
	bit 6,l		;149c	cb 75 	. u 
	jr z,l14b1h		;149e	28 11 	( . 
	ld hl,(ENEMY_POS)		;14a0	2a da e2 	* . . 
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
	ld hl,NEW_GUY_SIDE		;14b1	21 60 e2 	! ` . 
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
	ld hl,(THOMAS_POSITION)		;14c3	2a 12 e7 	* . . 
	ld de,l1200h		;14c6	11 00 12 	. . . 
	add hl,de			;14c9	19 	. 
	ld de,l2200h		;14ca	11 00 22 	. . " 
	sbc hl,de		;14cd	ed 52 	. R 
	jr c,l14d3h		;14cf	38 02 	8 . 
	add hl,de			;14d1	19 	. 
	ex de,hl			;14d2	eb 	. 
l14d3h:
	ld a,(TBL_ENEMIES)		;14d3	3a d8 e2 	: . . 
	ld l,a			;14d6	6f 	o 
	bit ENEMY_IS_ALIVE_BIT, l		;14d7	cb 65 	. e 
	jr z,l14f1h		;14d9	28 16 	( . 
	ld a,(0e197h)		;14db	3a 97 e1 	: . . 
	and a			;14de	a7 	. 
	jr z,l14ech		;14df	28 0b 	( . 
	bit ENEMY_MOVE_RIGHT_BIT, l		;14e1	cb 75 	. u 
	jr nz,l14f1h		;14e3	20 0c 	  . 
	ld hl,(ENEMY_POS)		;14e5	2a da e2 	* . . 
	sbc hl,de		;14e8	ed 52 	. R 
	jr nc,l14f1h		;14ea	30 05 	0 . 
l14ech:
	ld hl,0e215h		;14ec	21 15 e2 	! . . 
	jr l14aah		;14ef	18 b9 	. . 
l14f1h:
	ld hl,NEW_GUY_SIDE		;14f1	21 60 e2 	! ` . 
	set 5,(hl)		;14f4	cb ee 	. . 
l14f6h:
	ld hl,TBL_GUYS_LEN	;14f6	21 61 e2
	inc (hl)			;14f9	34 Add one more guy
	inc hl			    ;14fa	23 Now HL points to TBL_GUYS
	ld bc, 16		    ;14fb	16=number of entries in TBL_GUYS

; Look for an empty guy entry. Is value at index 0 needs to be zero.
; Keep looping until we find him.
l14feh:
	ld a,(hl)		;14fe	7e
	and a			;14ff	a7
l1500h:
	jr z,l1505h		;1500	28 03
	add hl,bc		;1502	09
	jr l14feh		;1503	18 f9 Keep searching if not found...
; Guy empty entry found
l1505h:
	pop af			;1505	f1 	. 
	ld (hl),a		;1506	77 	    Field #0
	xor a			;1507	af 	. 
	inc hl			;1508	23 	
	ld (hl),000h	;1509	36 00
	inc hl			;150b	23
	ld (hl),e		;150c
	inc hl			;150d	23
	ld (hl),d		;150e	72
	inc hl			;150f	23
	ld (hl),000h	;1510	36 00
	inc hl			;1512	23
	ld (hl),050h	;1513	36 50
	inc hl			;1515	23
	ld (hl),a		;1516	77
	inc hl			;1517	23
	ld (hl),007h	;1518	36 07
	inc hl			;151a	23
	ld (hl),a		;151b	77
	inc hl			;151c	23
	ld (hl),a		;151d	77
	inc hl			;151e	23
	ld (hl),002h	;151f	36 02
	inc hl			;1521	23
	ld (hl),a		;1522	77
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
	ld hl,0x0101		;1547	21 01 01 	! . . 
	ld (ACTIVE_GRIPPERS_LEFT),hl		;154a	22 1b e7 	" . . 
	ld (ACTIVE_GRIPPERS_RIGHT),hl		;154d	22 1d e7 	" . . 
	ld ix,TBL_GUYS		;1550	dd 21 62 e2 	. ! b . 
	ld b,005h		;1554	06 05 	. . 
l1556h:
	push bc			;1556	c5 	. 
	ld hl,l1534h	;1557	21 34 15 	! 4 . 
	push hl			;155a	e5

    ; Guy is alive?
	ld c,(ix + ENEMY_PROPS_IDX)	;155b	dd 4e 00
	bit ENEMY_IS_ALIVE_BIT,c		    ;155e	cb 61
	ret z			;1560	c8 Guy is falling, get out

	bit 5,c		        ;1561	cb 69 Can we add more guys behind, on the right?
	call nz,CHECK_RESET_NEW_ENEMY_ON_THE_RIGHT	;1563	c4 26 1c Check, if we can't

	bit 3,c		        ;1566	cb 59 Can we add more guys behind, on the left?
	call nz,CHECK_RESET_NEW_ENEMY_ON_THE_LEFT	;1568	c4 3d 1c Check, if we can't

	bit 0,c		        ;156b	cb 41 Is it a gripper (0) of a knifer (1)?
	ld a,(ix + ENEMY_STATE_IDX)		;156d	dd 7e 01
	jp nz,l186eh		;1570	c2 6e 18 Jump if he's a knifer

    ; He's a gripper or a kid
	bit 2,c		        ;1573	Is he a kid?
	jp nz,l168ah		;1575	Jump if he's a kind
    ; He's a gripper
	ld hl,l162fh		;1578	21 2f 16
	push hl			;157b	e5 	. 
	ld hl,THOMAS_PROPS	;157c	21 00 e7
	bit 1,(hl)		            ;157f	cb 4e Check if Thomas is fighting
	jp nz,l1be2h		        ;1581	c2 e2 1b Get out if he's not fighting
    ; Thomas is fighting
	cp 001h		    ;1584	fe 01 Here A comes from ld a,(ix + ENEMY_STATE_IDX) @ 156d
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
	call REMOVE_ENEMY		;159a	cd 7a 1b 	. z . 
	ld a,c			;159d	79 	y 
	and 028h		;159e	e6 28 	. ( 
	cpl			;15a0	2f 	/ 
	ld hl,NEW_GUY_SIDE		;15a1	21 60 e2 	! ` . 
	and (hl)			;15a4	a6 	. 
	ld (hl),a			;15a5	77 	w 
	pop hl			;15a6	e1 	. 
	ret			;15a7	c9 	. 
l15a8h:
	call sub_1be7h		;15a8	cd e7 1b 	. . . 
	ld a,(ix + ENEMY_FRAME_IDX)		;15ab	dd 7e 06 	. ~ . 
	cp 00ah		;15ae	fe 0a 	. . 
	jr nc,l15b6h		;15b0	30 04 	0 . 
	ld (ix + ENEMY_FRAME_IDX),00dh		;15b2	dd 36 06 0d 	. 6 . . 
l15b6h:
	call sub_163eh		;15b6	cd 3e 16 	. > . 
	ret c			;15b9	d8 	. 
	ld de,0ff00h		;15ba	11 00 ff 	. . . 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;15bd	2a 0c e8 	* . . 
	add hl,de			;15c0	19 	. 
	jp nc,l1b20h		;15c1	d2 20 1b 	.   . 
	ret			;15c4	c9 	. 
l15c5h:
	ld a,00ah		;15c5	3e 0a 	> . 
	add a,(ix + ENEMY_FRAME_IDX)		;15c7	dd 86 06 	. . . 
	ld (ix + ENEMY_FRAME_IDX),a		;15ca	dd 77 06 	. w . 
	ld (ix + ENEMY_STATE_IDX),00ah	;15cd	dd 36 01 0a Guy hand raised
	ret			;15d1	c9 	. 

l15d2h:
	call sub_1be7h		;15d2	cd e7 1b 	. . . 
	ld de,0f800h		;15d5	11 00 f8 	. . . 
	add hl,de			;15d8	19 	. 
	jp nc,l15c5h		;15d9	d2 c5 15 	. . . 
	ret			;15dc	c9 	. 
l15ddh:
	call sub_1b54h		;15dd	cd 54 1b 	. T . 
	call GET_EFFECTIVE_PLAYER_MOVE		;15e0	cd 61 1c 	. a . 
    
    ; Is Thomas shaking trying to release from a gripper?
    ; That is, is Thomas' movement different?
	cp (ix + THOMAS_LAST_SHAKE_MOVE)	;15e3	dd be 0f
	jr z,l15f2h		                    ;15e6	28 0a Jump if it's the same
    
    ; The movement is different, Thomas is shaking.
    ; Decrement the counter the gripper stays attached when Thomas
    ; shakes to get released
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;15e8	dd 35 0b
	jr z,l1626h		                        ;15eb	28 39 Released: kill that gripper
    
    ; The gripper hasn't released yet.
    ; Update the last movement Thomas tried to get released.
	ld (ix + THOMAS_LAST_SHAKE_MOVE),a		;15ed	dd 77 0f
	jr l15fbh		;15f0	18 09 	. . 
l15f2h:
    ; Thomas is being gripped, so we need to decrease the energy.
    ; But it's done slowly, only when ENEMY_ATTACK_STEP_IDX == 0.
    ; We can think of it as some kind of gripper "attack".

	dec (ix + ENEMY_ATTACK_STEP_IDX)		;15f2	dd 35 0e
	jr nz,l15ffh		                    ;15f5	20 08
    
    ; Set to 6 the number of steps needed for Thomas to get released from
    ; a gripper.
	ld (ix + ENEMY_STEADY_COUNTER_IDX), 6	;15f7	dd 36 0b 06
l15fbh:
    ; Reset the energy decrease step
	ld (ix + ENEMY_ATTACK_STEP_IDX), 5		;15fb	dd 36 0e 05
l15ffh:
    ; Now we have a second check (counter) to decide if we decrease the
    ; energy now. It's related to the configuration of DSW1 (energy loss
    ; slow/fast). I guess this was added afterwards, since it's weird to
    ; have two variables for this.
	dec (ix + GRIPPING_ENERGY_DECREASE_DSW_STEP) ;15ff	dd 35 07
	ret nz			                            ;1602	c0
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;1603	3a 1c e8
	and a			                            ;1606	a7
	ld a,002h		                            ;1607	3e 02
	jr nz,l1615h		                        ;1609	20 0a

	InDSW1		    ;160b	db 03
	and 002h		;160d	e6 02 Bit 1: energy loss speed

	ld a,004h		;160f	3e 04
	jr nz,l1615h	;1611	20 02
	ld a,003h		;1613	3e 03
l1615h:
	ld (ix + GRIPPING_ENERGY_DECREASE_DSW_STEP),a	;1615	dd 77 07
	ld hl,ENERGY	                                ;1618	21 09 e7
	ld a,(hl)			                            ;161b	7e
	and a			                                ;161c	a7
	ret m			                                ;161d	f8
    ; Do decrease the energy due to gripping here
	dec (hl)			                            ;161e	35
	ret p			                                ;161f	f0
    ; Set Thomas must die :-O Too much gripping :/
	ld hl,THOMAS_DAMAGE_STATUS		                ;1620	21 1f e7
	set 1,(hl)		                                ;1623	cb ce
	ret			                                    ;1625	c9


l1626h:
	ld hl,NUM_GRIPPING		;1626	21 1a e7 	! . . 
	dec (hl)			;1629	35 	5 
	ld a,009h		;162a	3e 09 	> . 
	jp APPLY_FRAMESEQ_TABLE1		;162c	c3 90 1b 	. . . 
l162fh:
	ld hl,06a7bh		;162f	21 7b 6a 	! { j 
l1632h:
	ld a,(ix + ENEMY_STATE_IDX)		;1632	dd 7e 01 	. ~ . 
	cp 5		    ;1635	fe 05 	5: the enemy turns back and leaves
	jp nz,l1a7dh	;1637	c2 7d 1a 	. } . 
	ld a,c			;163a	79 	y 
	jp l1a80h		;163b	c3 80 1a 	. . . 
sub_163eh:
	ld de,l1680h		;163e	11 80 16 	. . . 
	call sub_1ad2h		;1641	cd d2 1a 	. . . 
	ret nc			;1644	d0 	. 
	push af			;1645	f5 	. 
	ld a,091h		;1646	3e 91 	> . 
	call PLAY_SOUND		;1648	cd fe 0d 	. . . 
	pop af			;164b	f1 	. 
	jp m,l1653h		;164c	fa 53 16 	. S . 
	ld a,080h		;164f	3e 80 	> . 
	jr l1677h		;1651	18 24 	. $ 
l1653h:
	ld hl,0e2d2h		;1653	21 d2 e2 	! . . 
	inc (hl)			;1656	34 	4 
	call CHECK_THOMAS_IS_JUMPING		;1657	cd c9 1a 	. . . 
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
	ld hl,0x00d2	;1677	21 d2 00 	! . . 
l167ah:
	ex de,hl			;167a	eb 	. 
	call ADD_POINTS		;167b	cd 60 2f 	. ` / 
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
	ld hl,THOMAS_PROPS	;168e	21 00 e7
	bit 1,(hl)		;1691	cb 4e Check if Thomas is fighting
	jp nz,l1be2h	;1693	c2 e2 1b Skip if he's not fighting
	cp 009h		;1696	fe 09 	. . 
	jp z,l15ddh		;1698	ca dd 15 	. . . 
	jp nc,l170bh		;169b	d2 0b 17 	. . . 
	cp 001h		;169e	fe 01 	. . 
	jp z,l1baah		;16a0	ca aa 1b 	. . . 
	jp nc,l1592h		;16a3	d2 92 15 	. . . 
	call sub_1be7h		;16a6	cd e7 1b 	. . . 
	call sub_1828h		;16a9	cd 28 18 	. ( . 
	ret c			;16ac	d8 	. 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;16ad	2a 0c e8 	* . . 
	ld de,FLOOR_STAGE		;16b0	11 00 e1 	. . . 
	add hl,de			;16b3	19 	. 
	jp c,REMOVE_ENEMY		;16b4	da 7a 1b 	. z . 
	bit 0,(ix + 11)		;16b7	dd cb 0b 46 	. . . F 
	jr nz,l16e3h		;16bb	20 26 	  & 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;16bd	2a 0c e8 	* . . 
	ld de,0fa00h		;16c0	11 00 fa 	. . . 
	add hl,de			;16c3	19 	. 
	jr c,l16e3h		;16c4	38 1d 	8 . 
	set 0,(ix + 11)		;16c6	dd cb 0b c6 	. . . . 

	ld a,(THOMAS_STATE)		;16ca	3a 02 e7 	: . . 
	cp THOMAS_STATE_DUCKING_2	;16cd	fe 03 	. . 
	jr z,l16d9h		;16cf	28 08 	( . 
	cp THOMAS_STATE_DOWN_KICK		;16d1	fe 06 	. . 
	jr z,l16d9h		;16d3	28 04 	( . 
	cp THOMAS_STATE_DOWN_PUNCH		;16d5	fe 07 	. . 
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
	ld de,0x00c0		;16ee	11 c0 00 	. . . 
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
	ld (ix + ENEMY_STATE_IDX), 0		    ;16fe	dd 36 01 00
	ld (ix + ENEMY_FRAME_IDX), 0	        ;1702	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX),7 	;1706	dd 36 07 07
	ret			;170a	c9 	. 
l170bh:
	ld e,(ix + ENEMY_ATTACK_STEP_IDX)		;170b	dd 5e 0e
	ld d,(ix + ENEMY_BOOMERANG_TYPE_IDX)	;170e	dd 56 0f
	ld a,(ix + ENEMY_FRAME_IDX)		        ;1711	dd 7e 06
	cp 00ah		;1714	fe 0a
	push af			;1716	f5 	. 
	call nz,ENEMY_ADVANCE_POSITION		;1717	c4 70 1c 	. p . 
	call l1be2h		;171a	cd e2 1b 	. . . 
	pop af			;171d	f1 	. 
	jr z,l173dh		;171e	28 1d 	( . 
	ld de,0ffd6h		;1720	11 d6 ff 	. . . 
	call GET_ENEMY_FRAMESEQ_PTR_IN_HL		;1723	cd ac 1c 	. . . 
	add hl,de			;1726	19 	. 
	call SET_ENEMY_FRAMESEQ_PTR_FROM_HL		;1727	cd a5 1c 	. . . 
	ex de,hl			;172a	eb 	. 
	call GET_ENEMY_HEIGHT_IN_HL		;172b	cd 9e 1c 	. . . 
	add hl,de			;172e	19 	. 
	ld de,05000h		;172f	11 00 50 	. . P 
	sbc hl,de		;1732	ed 52 	. R 
	add hl,de			;1734	19 	. 
	jr nc,l1738h		;1735	30 01 	0 . 
	ex de,hl			;1737	eb 	. 
l1738h:
	call SET_ENEMY_HEIGHT_FROM_HL		;1738	cd 97 1c 	. . . 
	jr c,l16feh		;173b	38 c1 	8 . 
l173dh:
	bit 1,(ix + ENEMY_STEADY_COUNTER_IDX)		;173d	dd cb 0b 4e 	. . . N 
	jr nz,l175fh		;1741	20 1c 	  . 
	call GET_ENEMY_POS_IN_HL		;1743	cd 8a 1c 	. . . 
	ld de,0ff60h		;1746	11 60 ff 	. ` . 
	add hl,de			;1749	19 	. 
	ld (0e80fh),hl		;174a	22 0f e8 	" . . 
	ld de,l0140h		;174d	11 40 01 	. @ . 
	add hl,de			;1750	19 	. 
	ld (0e811h),hl		;1751	22 11 e8 	" . . 
	call GET_ENEMY_HEIGHT_IN_HL		;1754	cd 9e 1c 	. . . 
	ld de,0013h+1		;1757	11 14 00 	. . . 
	call sub_1172h		;175a	cd 72 11 	. r . 
	jr c,l1787h		;175d	38 28 	8 ( 
l175fh:
	dec (ix + FRAME_COUNTER_IDX)		;175f	dd 35 07 	. 5 . 
	jr nz,l177ch		;1762	20 18 	  . 
	ld a,(ix + ENEMY_ENERGY_IDX)		;1764	dd 7e 0a 	. ~ . 
	inc a			;1767	3c 	< 
l1768h:
	ld (ix + ENEMY_ENERGY_IDX),a		;1768	dd 77 0a 	. w . 
	add a,a			;176b	87 	. 
	ld e,a			;176c	5f 	_ 
	ld d,000h		;176d	16 00 	. . 
	ld hl,l17fch		;176f	21 fc 17 	! . . 
	add hl,de			;1772	19 	. 
	ld a,(hl)			;1773	7e 	~ 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;1774	dd 77 07
	inc hl			;1777	23 	# 
	ld a,(hl)			;1778	7e 	~ 
	ld (ix + ENEMY_FRAME_IDX),a		;1779	dd 77 06 	. w . 
l177ch:
	ld a,(ix + ENEMY_FRAME_IDX)		;177c	dd 7e 06 	. ~ . 
	cp 00fh		;177f	fe 0f 	. . 
	ret c			;1781	d8 	. 
	ld a,c			;1782	79 	y 
	xor 0c0h		;1783	ee c0 	. . 
	ld c,a			;1785	4f 	O 
	ret			;1786	c9 	. 
l1787h:
	ld a,(THOMAS_STATE)		;1787	3a 02 e7 	: . . 
	cp THOMAS_STATE_DUCKING_2		;178a	fe 03 	. . 
	jr z,l1796h		;178c	28 08 	( . 
	cp THOMAS_STATE_DOWN_KICK		;178e	fe 06 	. . 
	jr z,l1796h		;1790	28 04 	( . 
	cp THOMAS_STATE_DOWN_PUNCH		;1792	fe 07 	. . 
	jr nz,l17bah		;1794	20 24 	  $ 
l1796h:
	call GET_ENEMY_HEIGHT_IN_HL		;1796	cd 9e 1c 	. . . 
	ld de,l010ch		;1799	11 0c 01 	. . . 
	ld a,091h		;179c	3e 91 	> . 
	call PLAY_SOUND		;179e	cd fe 0d 	. . . 
	call STORE_DAMAGE_ORIGIN_AND_AMOUNT		;17a1	cd e2 2e 	. . . 
	ld a,007h		;17a4	3e 07 	> . 
	push af			;17a6	f5 	. 
	call GET_ENEMY_FRAMESEQ_PTR_IN_HL		;17a7	cd ac 1c 	. . . 
	ex de,hl			;17aa	eb 	. 
	ld hl,0		;17ab	21 00 00 	! . . 
	sbc hl,de		;17ae	ed 52 	. R 
	call SET_ENEMY_FRAMESEQ_PTR_FROM_HL		    ;17b0	cd a5 1c
	set 1,(ix + ENEMY_STEADY_COUNTER_IDX)	;17b3	dd cb 0b ce
	pop af			;17b7	f1 	. 
	jr l1768h		;17b8	18 ae 	. . 
l17bah:
	ld (ix + CURRENT_FRAME_IDX),9	;17ba	dd 36 06 09
	call GET_ENEMY_HEIGHT_IN_HL		    ;17be	cd 9e 1c
	ld de,l0a00h		;17c1	11 00 0a 	. . . 
	add hl,de			;17c4	19 	. 
	xor a			;17c5	af 	. 
	add hl,hl			;17c6	29 	) 
	rlca			;17c7	07 	. 
	ld l,h			;17c8	6c 	l 
	ld h,a			;17c9	67 	g 
	ex de,hl			;17ca	eb 	. 
	call GET_ENEMY_POS_IN_HL		;17cb	cd 8a 1c 	. . . 
	call CHECK_THOMAS_IS_JUMPING		;17ce	cd c9 1a 	. . . 
	ld a,080h		;17d1	3e 80 	> . 
	jr nz,l17d7h		;17d3	20 02 	  . 
	ld a,082h		;17d5	3e 82 	> . 
l17d7h:
	call ADD_POINTS		;17d7	cd 60 2f 	. ` / 
	ld a,091h		;17da	3e 91 	> . 
	call PLAY_SOUND		;17dc	cd fe 0d 	. . . 
sub_17df:
	ld hl,ENEMY_FRAMESEQ_TABLE2		;17df	21 5b 1c 	! [ . 
	jp APPLY_FRAMESEQ_FROM_HL		;17e2	c3 96 1b 	. . . 
l17e5h:
	ld (ix + ENEMY_STATE_IDX),00ah		;17e5	dd 36 01 0a
	ld hl,003a0h		                ;17e9	21 a0 03
	call SET_ENEMY_FRAMESEQ_PTR_FROM_HL		;17ec	cd a5 1c
	ld hl,00028h		;17ef	21 28 00 	! ( . 
	ld (ix + ENEMY_ATTACK_STEP_IDX),l		;17f2	dd 75 0e 	. u . 
	ld (ix + ENEMY_BOOMERANG_TYPE_IDX),h		;17f5	dd 74 0f 	. t . 
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
	ld (ix + 0),c		;183b	dd 71 00 	. q . 
	ld a,091h		;183e	3e 91 	> . 
	call PLAY_SOUND		;1840	cd fe 0d 	. . . 
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
	ld hl,THOMAS_PROPS	;1872	21 00 e7 Check if Thomas is fighting
	bit 1,(hl)		;1875	cb 4e
	jr nz,l18a3h	;1877	20 2a Skip if he's not
	ld l,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;1879	dd 6e 08
	ld h,(ix + ENEMY_MOVE_COUNTER_H_IDX)		;187c	dd 66 09
	dec hl			;187f	2b 	+ 
	bit 7,h		;1880	cb 7c 	. | 
	jr nz,l188ah		;1882	20 06 	  . 
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX),l		;1884	dd 75 08
	ld (ix + ENEMY_MOVE_COUNTER_H_IDX),h		;1887	dd 74 09
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
	dec (ix + ENEMY_ENERGY_IDX)	;18b6	dd 35 0a 	. 5 . 
	push af			;18b9	f5 	. 
	ld a,091h		;18ba	3e 91 	> . 
	call PLAY_SOUND		;18bc	cd fe 0d 	. . . 
	pop af			;18bf	f1 	. 
	jr z,l18c6h		;18c0	28 04 	( . 
	inc (ix + ENEMY_STATE_IDX)		;18c2	dd 34 01
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
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;18d9	2a 0c e8 	* . . 
	add hl,de			;18dc	19 	. 
	jr c,l18eah		;18dd	38 0b 	8 . 
	ld a,005h		;18df	3e 05 	> . 
	ld hl,0x5a		;18e1	21 5a 00 	! Z . 
	ld (ix + ENEMY_FRAME_IDX),002h		;18e4	dd 36 06 02 	. 6 . . 
	jr l194fh		;18e8	18 65 	. e 
l18eah:
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;18ea	dd 7e 08 	. ~ . 
	and a			;18ed	a7 	. 
	jp z,l19fdh		;18ee	ca fd 19 	. . . 
	ld a,(ix + ENEMY_FRAME_IDX)		;18f1	dd 7e 06 	. ~ . 
	cp 002h		;18f4	fe 02 	. . 
	jr z,l195dh		;18f6	28 65 	( e 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;18f8	dd 35 07 	. 5 . 
	ret nz			;18fb	c0 	. 
	ld a,(ix + ENEMY_ATTACK_STEP_IDX)		;18fc	dd 7e 0e 	. ~ . 
l18ffh:
	and a			;18ff	a7 	. 
	jp nz,l1942h		;1900	c2 42 19 	. B . 
	ld hl,NUM_KNIVES		;1903	21 2b e3 	! + . 
	ld a,(hl)			;1906	7e 	~ 
	cp 003h		;1907	fe 03 	. . 
	inc (ix + ENEMY_FRAME_COUNTER_IDX)		;1909	dd 34 07 	. 4 . 
	ret nc			;190c	d0 	. 
	add a,a			;190d	87 	. 
	add a,(hl)			;190e	86 	. 
	inc (hl)			;190f	34 	4 
	inc hl			;1910	23 	# 
	ld d,000h		;1911	16 00 	. . 
	ld e,a			;1913	5f 	_ 
	add hl,de			;1914	19 	. 
	push hl			;1915	e5 	. 
	call GET_ENEMY_POS_IN_HL		;1916	cd 8a 1c 	. . . 
	ld de,0x00c0		;1919	11 c0 00 	. . . 
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
	ld a,(ix + ENEMY_FRAME_IDX)		;1929	dd 7e 06 	. ~ . 
	sub 009h		;192c	d6 09 	. . 
	or b			;192e	b0 	. 
	ld (hl),a			;192f	77 	w 
	inc hl			;1930	23 	# 

sub_1931h:
	ld (hl),e			;1931	73 	s 
	inc hl			;1932	23 	# 
	ld (hl),d			;1933	72 	r 
	call PLAY_KNIFE_THOWING_SOUND		;1934	cd bf 1d 	. . . 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;1937	dd 35 0e 	. 5 . 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),010h		;193a	dd 36 07 10 	. 6 . . 
	inc (ix + ENEMY_FRAME_IDX)		;193e	dd 34 06 	. 4 . 
	ret			;1941	c9 	. 

l1942h:
	ld (ix + ENEMY_FRAME_IDX), 2		    ;1942	dd 36 06 02
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;1946	dd 35 
	ret nz			;1949	c0 	. 
	ld hl,(0e1f5h)		;194a	2a f5 e1 	* . . 
	ld a,003h		;194d	3e 03 	> . 
l194fh:
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX),l		;194f	dd 75 08
	ld (ix + ENEMY_MOVE_COUNTER_H_IDX),h		;1952	dd 74 09
    ;
	ld (ix + ENEMY_STATE_IDX),a		            ;1955	dd 77 01
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 2	    ;1958	dd 36 07 02
	ret			                                ;195c	c9
l195dh:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;195d	2a 0c e8 	* . . 
	ld de,0f5a0h		;1960	11 a0 f5 	. . . 
	add hl,de			;1963	19 	. 
	ld hl,0x5a		;1964	21 5a 00 	! Z . 
	ld a,000h		;1967	3e 00 	> . 
	jr c,l194fh		;1969	38 e4 	8 . 
	ret			;196b	c9 	. 
	call l1be2h		;196c	cd e2 1b 	. . . 
	ld a,002h		;196f	3e 02 	> . 
	cp (ix + ENEMY_FRAME_IDX)		        ;1971	dd be
	jr z,l1982h		                        ;1974	28 0c
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;1976	dd 35 07
	ret nz			                        ;1979	c0
	ld (ix + ENEMY_FRAME_IDX),a		        ;197a	dd 77 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 3	;197d	dd 36 07 03
	ret			;1981	c9 	. 
l1982h:
	call sub_1a49h		;1982	cd 49 1a 	. I . 
	jp c,l18b6h		;1985	da b6 18 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;1988	dd 35 07 	. 5 . 
	ret nz			;198b	c0 	. 
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX), 4		;198c	dd 36 08 04
	ld (ix + ENEMY_MOVE_COUNTER_H_IDX), 0		;1990	dd 36 09 00
	ld (ix + ENEMY_STATE_IDX), 3		        ;1994	dd 36 01 03
	ret			;1998	c9 	. 

    ; Unused/unreacheable code here?
	call sub_1befh		;1999	cd ef 1b 	. . . 
	call sub_1a49h		;199c	cd 49 1a 	. I . 
	jp c,l18b6h		;199f	da b6 18 	. . . 
	ld a,(ix + 8)		;19a2	dd 7e 08 	. ~ . 
	and a			;19a5	a7 	. 
	jr nz,l19aeh		;19a6	20 06 	  . 
	ld a,(ix + 9)		;19a8	dd 7e 09 	. ~ . 
	and a			;19ab	a7 	. 
	jr z,l19f3h		;19ac	28 45 	( E 
l19aeh:
	ld de,0f600h		;19ae	11 00 f6 	. . . 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;19b1	2a 0c e8 	* . . 
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
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;19cb	dd 7e 08
	and a			;19ce	a7 	. 
	jr nz,l19d7h		;19cf	20 06 	  . 
	ld a,(ix + ENEMY_MOVE_COUNTER_H_IDX)		;19d1	dd 7e 09
	and a			;19d4	a7 	. 
	jr z,l19f3h		;19d5	28 1c 	( . 
l19d7h:
	ld de,0f700h		;19d7	11 00 f7 	. . . 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;19da	2a 0c e8 	* . . 
	add hl,de			;19dd	19 	. 
	jr nc,l19eah		;19de	30 0a 	0 . 
	ld de,0fe00h		;19e0	11 00 fe 	. . . 
	add hl,de			;19e3	19 	. 
	ret nc			;19e4	d0 	. 
	ld (ix + ENEMY_STATE_IDX),0	;19e5	dd 36 01 00
	ret			;19e9	c9 	. 
l19eah:
	call sub_1ab8h		;19ea	cd b8 1a 	. . . 
	ret c			;19ed	d8 	. 
	ld (ix + ENEMY_STATE_IDX), 5		;19ee	dd 36 01 05 5=enemy turns back and leaves
	ret			;19f2	c9 	. 

l19f3h:
	ld (ix + ENEMY_STATE_IDX), 4	;19f3	dd 36 01 04 4=guy moves back, without turning back
	ld a,(0e1f0h)		;19f7	3a f0 e1 	: . . 
	ld (ix + ENEMY_STEADY_COUNTER_IDX),a	;19fa	dd 77 0b
l19fdh:
	ld hl,0e1f1h		;19fd	21 f1 e1 	! . . 
	ld a,(EXT_RANDOM)		;1a00	3a 10 e0 	: . . 
	cp (hl)			;1a03	be 	. 
	ld a,009h		;1a04	3e 09 	> . 
	jr c,l1a0ah		;1a06	38 02 	8 . 
	ld a,00bh		;1a08	3e 0b 	> . 
l1a0ah:
	ld (ix + ENEMY_FRAME_IDX),a		;1a0a	dd 77 06 	. w . 
	inc hl			;1a0d	23 	# 
	ld a,(EXT_RANDOM + 1)		;1a0e	3a 11 e0 	: . . 
	cp 055h		;1a11	fe 55 	. U 
	jr c,l1a1bh		;1a13	38 06 	8 . 
	inc hl			;1a15	23 	# 
	cp 0aah		;1a16	fe aa 	. . 
	jr c,l1a1bh		;1a18	38 01 	8 . 
	inc hl			;1a1a	23 	# 
l1a1bh:
	ld a,(hl)			                    ;1a1b	7e
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX),a	;1a1c	dd 77 08
	ld (ix + ENEMY_ATTACK_STEP_IDX), 0		;1a1f	dd 36 0e 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX),00bh	;1a23	dd 36 07 0b
	ret			                            ;1a27	c9

    ; Mystery: how can one arrive here?
    ; I've checked that code at PC=1A30 was indeed executed.
	call sub_1be7h		;1a28	cd e7 1b 	. . . 
	ld de,0f600h		;1a2b	11 00 f6 	. . . 
	add hl,de			;1a2e	19 	. 
	ret c			;1a2f	d8 	. 
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;1a30	dd 7e 08
	and a			                            ;1a33	a7
	jr nz,l1a3ch		                        ;1a34	20 06
	ld a,(ix + ENEMY_MOVE_COUNTER_H_IDX)		;1a36	dd 7e 09
	and a			                            ;1a39	a7
	jr z,l19f3h		                            ;1a3a	28 b7
l1a3ch:
	ld (ix + ENEMY_STATE_IDX), 3	        ;1a3c	dd 36 01 03 3=unknown!
	ld (ix + ENEMY_FRAME_IDX), 2	        ;1a40	dd 36 06 02
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 2	;1a44	dd 36 07 02
	ret			;1a48	c9 	. 
sub_1a49h:
	ld a,(0e701h)		;1a49	3a 01 e7 	: . . 
	and 003h		;1a4c	e6 03 	. . 
	jr nz,l1a54h		;1a4e	20 04 	  . 
	res ENEMY_IS_A_KID_BIT, (ix + ENEMY_PROPS_IDX)		;1a50	dd cb 00 96
l1a54h:
	bit ENEMY_IS_A_KID_BIT, (ix + ENEMY_PROPS_IDX)		;1a54	dd cb 00 56
	ret nz			;1a58	c0 	. 
	ld de,l1680h		;1a59	11 80 16 	. . . 
	call sub_1ad2h		;1a5c	cd d2 1a 	. . . 
	ret nc			;1a5f	d0 	. 
	set ENEMY_IS_A_KID_BIT, (ix + ENEMY_PROPS_IDX)		;1a60	dd cb 00 d6 	. . . . 
	ld a,085h		;1a64	3e 85 	> . 
	ret p			;1a66	f0 	. 
	call CHECK_THOMAS_IS_JUMPING		;1a67	cd c9 1a 	. . . 
	ld a,083h		;1a6a	3e 83 	> . 
	jr nz,l1a70h		;1a6c	20 02 	  . 
	ld a,087h		;1a6e	3e 87 	> . 
l1a70h:
	scf			;1a70	37 	7 
	ret			;1a71	c9 	. 
l1a72h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;1a72	2a 0c e8 	* . . 
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
    ; Bit 4: enemy is alive
	bit ENEMY_IS_ALIVE_BIT,(ix + ENEMY_PROPS_IDX)	;1a82	dd cb 00 66
	ret z			;1a86	c8 	. 
	ex de,hl			;1a87	eb 	. 
	call GET_ENEMY_HEIGHT_IN_HL		;1a88	cd 9e 1c
	add hl,hl			;1a8b	29 	) 
	ld l,h			;1a8c	6c 	l 
	ld h,000h		;1a8d	26 00 	& . 
	rl h		;1a8f	cb 14 	. . 
	ld (KNIFE_STATUS),hl		;1a91	22 07 e8 	" . . 
	ld hl,(0e80ah)		;1a94	2a 0a e8 	* . . 
	ld c,(ix + ENEMY_FRAME_IDX)		;1a97	dd 4e 06
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
	call GET_ENEMY_POS_IN_DE		;1ab8	cd 91 1c 	. . . 
	ld hl,(0e106h)		;1abb	2a 06 e1 	* . . 
	bit 6,c		;1abe	cb 71 	. q 
	jr z,l1ac6h		;1ac0	28 04 	( . 
	ld hl,(0e104h)		;1ac2	2a 04 e1 	* . . 
	ex de,hl			;1ac5	eb 	. 
l1ac6h:
	sbc hl,de		;1ac6	ed 52 	. R 
	ret			;1ac8	c9 	. 

; Checks if Thomas is jumping.
; It sets Z if jumping.
CHECK_THOMAS_IS_JUMPING:
	ld a,(THOMAS_STATE)		;1ac9	3a 02 e7 	: . . 
	cp THOMAS_STATE_JUMPING		;1acc	fe 08 	. . 
	ret z			;1ace	c8 	. 
	cp THOMAS_STATE_JUMPING_AHEAD		;1acf	fe 09 	. . 
	ret			;1ad1	c9 	. 

sub_1ad2h:
	push de			;1ad2	d5 	. 
	call sub_1ae7h		;1ad3	cd e7 1a 	. . . 
	pop hl			;1ad6	e1 	. 
	ret nc			;1ad7	d0 	. 
	call CHECK_VAL_HL_PLUS_B_0XFF		;1ad8	cd 18 1b 	. . . 
	ret nc			;1adb	d0 	. 
	push af			;1adc	f5 	. 
	and 00fh		;1add	e6 0f 	. . 
	call APPLY_FRAMESEQ_TABLE1_FRAME_A_PLUS_4		;1adf	cd 8e 1b 	. . . 
	call GET_ENEMY_POS_IN_DE		;1ae2	cd 91 1c 	. . . 
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
	ld a,(THOMAS_STATE)		;1b09	3a 02 e7 	: . . 
	cp THOMAS_STATE_DOWN_KICK		;1b0c	fe 06 	. . 
	ret c			;1b0e	d8 	. 
	inc b			;1b0f	04 	. 
	sub 008h		;1b10	d6 08 	. . 
	ret c			;1b12	d8 	. 
	inc b			;1b13	04 	. 
	add a,b			;1b14	80 	. 
	ld b,a			;1b15	47 	G 
	scf			;1b16	37 	7 
	ret			;1b17	c9 	. 

CHECK_VAL_HL_PLUS_B_0XFF:
	ld e,b		;1b18	58
	ld d,000h	;1b19	16 00
	add hl,de	;1b1b	19
	ld a,(hl)	;1b1c	7e A = HL[B]
	cp 0ffh		;1b1d	fe ff Check if HL[B] != 0xFF
	ret			;1b1f	c9

l1b20h:
	call CHECK_DEMO_OR_VULNERABLE	;1b20	cd 08 12
    ; If invulnerable, simply remove the enemy
	jr nz,REMOVE_ENEMY		        ;1b23	20 55
	ld a,(AVOID_SHOWING_FLOOR_INTRO_TEXT)		;1b25	3a 1c e8 	: . . 
	and a			;1b28	a7 	. 
	ld a,002h		;1b29	3e 02 	> . 
	jr nz,l1b37h		;1b2b	20 0a 	  . 

	InDSW1		    ;1b2d	db 03
	and 002h		;1b2f	e6 02 Bit 1: energy loss speed
    
	ld a,004h		;1b31	3e 04 	> . 
	jr nz,l1b37h		;1b33	20 02 	  . 
	ld a,003h		;1b35	3e 03 	> . 
l1b37h:
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;1b37	dd 77 07
	ld (ix + ENEMY_FRAME_IDX), 9	        ;1b3a	dd 36 06 09

    ; Set guy is gripping
	ld (ix + ENEMY_STATE_IDX), 9    ;1b3e	dd 36 01 09

    ; Increment number of gripping guys
	ld hl,NUM_GRIPPING	;1b42	21 1a e7
	inc (hl)			;1b45	34 	4 

	call GET_EFFECTIVE_PLAYER_MOVE		;1b46	cd 61 1c
	ld (ix + THOMAS_LAST_SHAKE_MOVE),a	;1b49	dd 77 0f

    ; Steps the gripper needs that Thomas shake before releasing him
	ld (ix + ENEMY_STEADY_COUNTER_IDX), 6	;1b4c	dd 36 0b 06
	ld (ix + ENEMY_ATTACK_STEP_IDX), 5	    ;1b50	dd 36 0e 05

sub_1b54h:
	bit ENEMY_IS_A_KID_BIT, (ix + ENEMY_PROPS_IDX)    ;1b54	dd cb 00 56 Check if the guy is a kid
	ld hl,ACTIVE_GRIPPERS_LEFT		;1b58	21 1b e7
	jr z,l1b5fh		                ;1b5b	28 02 Jump if he's not a kind
	inc hl			;1b5d	23
	inc hl			;1b5e	23 Now HL = ACTIVE_GRIPPERS_RIGHT
l1b5fh:
    ; HL = ACTIVE_GRIPPERS (left or right)
	bit ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;1b5f	dd cb 00 76 Check the moving direction
	ld de, -128		    ;1b63	11 80 ff
	jr nz,l1b6ch		;1b66	20 04 Jump if moving to the left
	inc hl			    ;1b68	23
	ld de, +128		    ;1b69	11 80 00
l1b6ch:
	inc (hl)			;1b6c	34 	4
	ld b,(hl)			;1b6d	46 	F 
	ld hl,(THOMAS_POSITION)		;1b6e	2a 12 e7 	* . . 
l1b71h:
	add hl,de			;1b71	19 	. 
	djnz l1b71h		;1b72	10 fd 	. . 
	call SET_ENEMY_POS_FROM_HL		;1b74	cd 83 1c 	. . . 
	jp l1be2h		;1b77	c3 e2 1b 	. . . 

REMOVE_ENEMY:
	bit ENEMY_IS_A_BOSS_BIT, (ix + ENEMY_PROPS_IDX)		;1b7a	dd cb 00 4e Is enemy a boss?
	jr nz,l1b89h		;1b7e	20 09 If so, mark it as inactive, but don't remove it from TBL_GUYS.
	ld (ix + ENEMY_PROPS_IDX), 0  	;1b80	dd 36 00 00 Guy is no longer active
	ld hl,TBL_GUYS_LEN	;1b84	21 61 e2 Decrease length of table
	dec (hl)			;1b87	35
	ret			        ;1b88	c9
l1b89h:
    ; Mark the guy as inactive, but don't remove from TBL_GUYS
	res ENEMY_IS_ALIVE_BIT, (ix + ENEMY_PROPS_IDX)		;1b89	dd cb 00 a6
	ret			        ;1b8d	c9


APPLY_FRAMESEQ_TABLE1_FRAME_A_PLUS_4:
	add a,004h		;1b8e	c6 04 	. . 
APPLY_FRAMESEQ_TABLE1:
	ld (ix + ENEMY_FRAME_IDX),a		;1b90	dd 77 06 	. w . 
	ld hl,ENEMY_FRAMESEQ_TABLE1		;1b93	21 55 1c 	! U . 
APPLY_FRAMESEQ_FROM_HL:
	ld (ix + ENEMY_STATE_IDX), 1 ;1b96	dd 36 01 01 1=enemy disappears
	ld a,(hl)			;1b9a	7e 	~ 
	inc hl			;1b9b	23 	# 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;1b9c	dd 77 07 level 1
	call SET_ENEMY_FRAMESEQ_PTR_FROM_HL		    ;1b9f	cd a5 1c
	xor a			;1ba2	af 	. 
	ld (ix + ENEMY_ATTACK_STEP_IDX),a		;1ba3	dd 77 0e level 1
	ld (ix + THOMAS_LAST_SHAKE_MOVE),a	;1ba6	dd 77 0f level 1
	ret			;1ba9	c9 	. 

l1baah:
	dec (ix + ENEMY_FRAME_COUNTER_IDX)	;1baa	dd 35 07 level 1
	jp nz,l1bc4h		                ;1bad	c2 c4 1b
	call GET_ENEMY_FRAMESEQ_PTR_IN_HL		    ;1bb0	cd ac 1c
	ld a,(hl)			;1bb3	7e 	~ 
	and a			;1bb4	a7 	. 
	jp m,REMOVE_ENEMY		;1bb5	fa 7a 1b 	. z . 
	inc hl			;1bb8	23 	# 
	ld (ix + ENEMY_FRAME_IDX),a		;1bb9	dd 77 06
	ld a,(hl)			;1bbc
	inc hl			;1bbd	23
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;1bbe	dd 77 07 level 1
	call SET_ENEMY_FRAMESEQ_PTR_FROM_HL		    ;1bc1	cd a5 1c
l1bc4h:
    ; Question:
    ; Why are we mising ENEMY_ATTACK_STEP_IDX and THOMAS_LAST_SHAKE_MOVE and adding 16h?
    ; What is the meaning of this?
    ; Do these variables have a different meaning here?
	ld e,(ix + ENEMY_ATTACK_STEP_IDX)		;1bc4	dd 5e 0e level 1
	ld d,(ix + THOMAS_LAST_SHAKE_MOVE)	;1bc7	dd 56 0f level 1
	ld hl,0016h		;1bca	21 16 00 	! . . 
	add hl,de			;1bcd	19 	. 
	ld (ix + ENEMY_ATTACK_STEP_IDX),l		;1bce	dd 75 0e level 1
	ld (ix + THOMAS_LAST_SHAKE_MOVE),h	;1bd1	dd 74 0f level 1
	call GET_ENEMY_HEIGHT_IN_HL		;1bd4	cd 9e 1c 	. . . 
	sbc hl,de		;1bd7	ed 52 	. R 
	call SET_ENEMY_HEIGHT_FROM_HL		;1bd9	cd 97 1c 	. . . 
	ld de,l0039h		;1bdc	11 39 00 	. 9 . 
	call ENEMY_GO_BACK_POSITION		;1bdf	cd 7a 1c 	. z . 
l1be2h:
	call GET_ENEMY_POS_IN_HL		;1be2	cd 8a 1c 	. . . 
	jr l1c08h		;1be5	18 21 	. ! 
sub_1be7h:
	ld de,l0036h		;1be7	11 36 00 	. 6 . 
l1beah:
	call ENEMY_ADVANCE_POSITION		;1bea	cd 70 1c 	. p . 
	jr l1bf5h		;1bed	18 06 	. . 
sub_1befh:
	ld de,l0036h		;1bef	11 36 00 	. 6 . 
l1bf2h:
	call ENEMY_GO_BACK_POSITION		;1bf2	cd 7a 1c 	. z . 
l1bf5h:
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;1bf5	dd 35 07 ; level 1.
	jr nz,l1c08h		;1bf8	20 0e 	  . 
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;1bfa	dd 36 07 07
	dec (ix + ENEMY_FRAME_IDX)	;1bfe	dd 35 06
	jp p,l1c08h		                ;1c01	f2 08 1c
	ld (ix + ENEMY_FRAME_IDX), 3	;1c04	dd 36 06 03
l1c08h:
	ld de,(THOMAS_POSITION)		;1c08	ed 5b 12 e7 	. [ . . 
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
	ld (ME_INITIAL_FALL_SPEED_COPY),hl		;1c21	22 0c e8 	" . . 
	and a			;1c24	a7 	. 
	ret			;1c25	c9 	. 

; Check if we can add a new enemy of the right.
; We can add a new one if the distance |ENEMY_POSITION - THOMAS_POSITION| >=  0x1000
CHECK_RESET_NEW_ENEMY_ON_THE_RIGHT:
	ld hl,(THOMAS_POSITION)		;1c26
	ld de,0x1000		        ;1c29	11 00 10
	add hl,de			        ;1c2c	19          HL = THOMAS_POSITION + 0x1000

	call GET_ENEMY_POS_IN_DE	;1c2d	cd 91 1c    DE = ENEMY_POSITION
	sbc hl,de		            ;1c30	ed 52       HL = THOMAS_POSITION + 0x1000 - ENEMY_POSITION
    
    ; Check carry
    ; Carry if
    ;       ENEMY_POSITION >= THOMAS_POSITION + 0x1000
    ;       ENEMY_POSITION - THOMAS_POSITION >=  0x1000
	ret c			            ;1c32	d8
    
    ;ENEMY_POSITION - THOMAS_POSITION <  0x1000
    
    ; we can add guys on the right
	res TRAILING_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)	;1c33	dd cb 00 ae

    ; Reset bit #5 (new enemy on the right) of NEW_GUY_SIDE ==> We can add
	ld hl, NEW_GUY_SIDE	;1c37	21 60 e2
	res TRAILING_RIGHT_BIT,(hl)		    ;1c3a	cb ae
	ret			        ;1c3c	c9

; Check if we can add a new enemy of the left.
; We can add a new one if the distance |THOMAS_POSITION - ENEMY_POSITION| >=  0x1000
CHECK_RESET_NEW_ENEMY_ON_THE_LEFT:
	call GET_ENEMY_POS_IN_HL	;1c3d	cd 8a 1c    HL = ENEMY_POSITION
	ld de,0x1000		        ;1c40	11 00 10    DE = 0x1000
	add hl,de			        ;1c43	19          HL = ENEMY_POSITION + 0x1000

	ld de,(THOMAS_POSITION)		;1c44	ed 5b 12 e7 DE = THOMAS_POSITION
	sbc hl,de		            ;1c48	ed 52       HL = ENEMY_POSITION + 0x1000 - THOMAS_POSITION
    
    ; Check carry
    ; Carry if
    ;       THOMAS_POSITION >= ENEMY_POSITION + 0x1000
    ;       THOMAS_POSITION - ENEMY_POSITION >=  0x1000
    
	ret c			            ;1c4a	d8
    
    ; we can add guys on the left
	res TRAILING_LEFT_BIT, (ix + ENEMY_PROPS_IDX)		;1c4b	dd cb 00 9e

    ; Reset bit #3 (new enemy on the left) of NEW_GUY_SIDE  ==> We can add
	ld hl, NEW_GUY_SIDE		            ;1c4f	21 60 e2
	res TRAILING_LEFT_BIT, (hl)		                    ;1c52	cb 9e
	ret			                        ;1c54	c9

; Tables of ENEMY_FRAME_COUNTER values, terminated with 0ffh.
; We shall refer to these sequences of frames as "FRAMESEQS".
ENEMY_FRAMESEQ_TABLE1: ; 1c55
    defb 5, 7, 7, 8, 011h, 0ffh

ENEMY_FRAMESEQ_TABLE2: ; 1c5b
    defb 5, 7, 0xa, 8, 0x17, 0xff


; Get the effective player move
; If in demo, use PLAYER_MOVE, PLAYER_CONTROLS (direct input) otherwise
GET_EFFECTIVE_PLAYER_MOVE:
	ld a,(GAME_STATE)		;1c61	3a 00 e0
	cp GAME_STATE_DEMO		;1c64	fe 06
	ld a,(PLAYER_MOVE)		;1c66	3a 09 e9
	ret z			        ;1c69	c8
	ld a,(PLAYER_CONTROLS)	;1c6a	3a 07 e9
	and 00fh		        ;1c6d	e6 0f Consider only joystick directions, not buttons
	ret			            ;1c6f	c9

; Make an enemy (gripper, knifer, tom-tom, or boss) advance his position.
; It can be a position or negative amount whether the enemy is on the right or
; the left of Thomas.
;
; Increment or decrement ENEMY_POS.
; ENEMY_POS = ENEMY_POS + DE if ENEMY_POS >= 64 else ENEMY_POS - DE.
;
; Input DE: offset to add or subtract.
ENEMY_ADVANCE_POSITION:
	call GET_ENEMY_POS_IN_HL	;1c70	cd 8a 1c    HL = ENEMY_POS
	bit 6,c		                ;1c73	cb 71       2**6 = 64
	jr z,l1c81h		            ;1c75	28 0a       Jump if ENEMY_POS < 64
    ; It'll do sbc hl,de ==> HL = ENEMY_POS - DE and then set ENEMY_POS
    
    ; ENEMY_POS >= 64
    ; It'll do ENEMY_POS += DE
l1c77h:
	add hl,de			        ;1c77	19          ENEMY_POS += DE
	jr SET_ENEMY_POS_FROM_HL		;1c78	18 09 	. . 
    
; Make an enemy (gripper, knifer, tom-tom, or boss) move back his position.
; It's used for example when a knifer turns back, or when a boss goes back.
;
; Increment or decrement ENEMY_POS.
; ENEMY_POS = ENEMY_POS - DE if ENEMY_POS >= 64 else ENEMY_POS + DE.
;
; Input DE: offset to add of subtract.

ENEMY_GO_BACK_POSITION:
	call GET_ENEMY_POS_IN_HL		;1c7a	cd 8a 1c 	. . . 
	bit 6,c		;1c7d	cb 71 	. q 
	jr z,l1c77h		;1c7f	28 f6 	( . 
l1c81h:
	sbc hl,de		;1c81	ed 52 	. R

SET_ENEMY_POS_FROM_HL:
	ld (ix + ENEMY_POS_L_IDX),l		;1c83	dd 75 02
	ld (ix + ENEMY_POS_H_IDX),h		;1c86	dd 74 03
	ret			                    ;1c89	c9

GET_ENEMY_POS_IN_HL:
	ld l,(ix + ENEMY_POS_L_IDX)		;1c8a	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)     ;1c8d	dd 66 03
	ret			                    ;1c90	c9

GET_ENEMY_POS_IN_DE:
	ex de,hl			            ;1c91	eb 	. 
	call GET_ENEMY_POS_IN_HL		;1c92	cd 8a 1c
	ex de,hl			            ;1c95	eb
	ret			                    ;1c96	c9

SET_ENEMY_HEIGHT_FROM_HL:
	ld (ix + ENEMY_HEIGHT_L_IDX),l		;1c97	dd 75 04
	ld (ix + ENEMY_HEIGHT_H_IDX),h		;1c9a	dd 74 05
	ret			;1c9d	c9 	. 

GET_ENEMY_HEIGHT_IN_HL:
	ld l,(ix + ENEMY_HEIGHT_L_IDX)		;1c9e	dd 6e 04
	ld h,(ix + ENEMY_HEIGHT_H_IDX)		;1ca1	dd 66 05
	ret			;1ca4	c9 	. 

SET_ENEMY_FRAMESEQ_PTR_FROM_HL:
	ld (ix + ENEMY_FRAMESEQ_PTR_L_IDX),l		;1ca5	dd 75 0c
	ld (ix + ENEMY_FRAMESEQ_PTR_H_IDX),h	;1ca8	dd 74 0d
	ret			;1cab	c9 	. 

GET_ENEMY_FRAMESEQ_PTR_IN_HL:
	ld l,(ix + ENEMY_FRAMESEQ_PTR_L_IDX)		;1cac	dd 6e 0c
	ld h,(ix + ENEMY_FRAMESEQ_PTR_H_IDX)	;1caf	dd 66 0d
	ret			;1cb2	c9 	. 

sub_1cb3h:
	call sub_1e4ah		;1cb3	cd 4a 1e 	. J . 
	call UPDATE_FALLING_HEAD		;1cb6	cd fd 1d 	. . . 
	ld ix, TBL_BOOMERANG_1		;1cb9	dd 21 fb e2 	. ! . . 
	call sub_1cc4h		;1cbd	cd c4 1c 	. . . 
	ld ix, TBL_BOOMERANG_2	;1cc0	dd 21 0b e3

sub_1cc4h:
    ; IX = TBL_BOOMERANG_1
	ld a,(ix + BOOMERANG_PROPS_IDX)		;1cc4	dd 7e 00
	ld c,a			;1cc7	4f
    and 1 << BOOMERANG_ACTIVE1_BIT ;1cc8
	ret z			;1cca	c8 	. 
	ld a,(THOMAS_PROPS)	;1ccb	3a 00 e7 	: . . 
	and 002h		;1cce	e6 02 Check if Thomas is fighting
	jp nz,l1da7h	;1cd0	c2 a7 1d Skip if he's not
	ld a,(ix + BOOMERANG_DIRECTION)		;1cd3	dd 7e 01
	cp BOOMERANG_DIRECTION_TURNING		;1cd6	fe 01
	jp c,l1d4bh		;1cd8	da 4b 1d 	. K . 
	jr z,l1d03h		;1cdb	28 26 	( & 
	call sub_1de9h		;1cdd	cd e9 1d 	. . . 
	ld a,(ENEMY_STATE)		;1ce0	3a d9 e2 	: . . 
	cp 001h		;1ce3	fe 01 	. . 
	jr z,l1ceeh		;1ce5	28 07 	( . 
	ld a,(TBL_ENEMIES)		;1ce7	3a d8 e2 	: . . 
	and 010h		;1cea	e6 10 	. . 
	jr nz,l1d5bh		;1cec	20 6d 	  m 
l1ceeh:
	ld de,(THOMAS_POSITION)		;1cee	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;1cf2	ed 52 	. R 
	jp c,l1d5bh		;1cf4	da 5b 1d 	. [ . 
	ld de,0ec00h		;1cf7	11 00 ec 	. . . 
	add hl,de			;1cfa	19 	. 
	jr nc,l1d5bh		;1cfb	30 5e 	0 ^ 
	ld (ix + 0),000h		;1cfd	dd 36 00 00 	. 6 . . 
	jr l1d5bh		;1d01	18 58 	. X 
l1d03h:
	ld a,(ix + 11)		;1d03	dd 7e 0b 	. ~ . 
	ld l,(ix + 4)		;1d06	dd 6e 04 	. n . 
	ld h,(ix + 5)		;1d09	dd 66 05 	. f . 
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
	ld (ix + 4),l		;1d21	dd 75 04 	. u . 
	ld (ix + 5),h		;1d24	dd 74 05 	. t . 
	ld l,(ix + 12)		;1d27	dd 6e 0c 	. n . 
	ld h,(ix + 13)		;1d2a	dd 66 0d 	. f . 
	ld de,(0e1bbh)		;1d2d	ed 5b bb e1 	. [ . . 
	add hl,de			;1d31	19 	. 
	ld (ix + 12),l		;1d32	dd 75 0c 	. u . 
	ld (ix + 13),h		;1d35	dd 74 0d 	. t . 
	call sub_1defh		;1d38	cd ef 1d 	. . . 
	ld e,(ix + 14)		;1d3b	dd 5e 0e 	. ^ . 
	ld d,(ix + 15)		;1d3e	dd 56 0f 	. V . 
	sbc hl,de		;1d41	ed 52 	. R 
	jr c,l1d5bh		;1d43	38 16 	8 . 
	res 5,(ix + 0)		;1d45	dd cb 00 ae 	. . . . 
	jr l1d58h		;1d49	18 0d 	. . 
l1d4bh:
	call sub_1de9h		;1d4b	cd e9 1d 	. . . 
	ld e,(ix + 14)		;1d4e	dd 5e 0e 	. ^ . 
	ld d,(ix + 15)		;1d51	dd 56 0f 	. V . 
	sbc hl,de		;1d54	ed 52 	. R 
	jr nc,l1d5bh		;1d56	30 03 	0 . 
l1d58h:
	inc (ix + 1)		;1d58	dd 34 01 	. 4 . 
l1d5bh:
	bit 5,(ix + 0)		;1d5b	dd cb 00 6e 	. . . n 
	jr nz,l1d8fh		;1d5f	20 2e 	  . 
	ld l,(ix + 2)		;1d61	dd 6e 02 	. n . 
	ld h,(ix + 3)		;1d64	dd 66 03 	. f . 
	ld de,0ff40h		;1d67	11 40 ff 	. @ . 
	add hl,de			;1d6a	19 	. 
	ld (0e80fh),hl		;1d6b	22 0f e8 	" . . 
	ld de,l017fh+1		;1d6e	11 80 01 	. . . 
	add hl,de			;1d71	19 	. 
	ld (0e811h),hl		;1d72	22 11 e8 	" . . 
	ld l,(ix + 4)		;1d75	dd 6e 04 	. n . 
	ld h,(ix + 5)		;1d78	dd 66 05 	. f . 
	ld de,0006h+2		;1d7b	11 08 00 	. . . 
	push hl			;1d7e	e5 	. 
	call sub_1172h		;1d7f	cd 72 11 	. r . 
	pop hl			;1d82	e1 	. 
	jr nc,l1d8fh		;1d83	30 0a 	0 . 
	ld de,00118h		;1d85	11 18 01 	. . . 
	call sub_2c9ah		;1d88	cd 9a 2c 	. . , 
	set 5,(ix + 0)		;1d8b	dd cb 00 ee 	. . . . 
l1d8fh:
	dec (ix + 7)		;1d8f	dd 35 07 	. 5 . 
	jr nz,l1da7h		;1d92	20 13 	  . 
	ld (ix + 7),002h		;1d94	dd 36 07 02 	. 6 . . 
	ld a,(ix + 6)		;1d98	dd 7e 06 	. ~ . 
	inc a			;1d9b	3c 	< 
	cp 006h		;1d9c	fe 06 	. . 
	jr c,l1da4h		;1d9e	38 04 	8 . 
	call PLAY_KNIFE_THOWING_SOUND		;1da0	cd bf 1d 	. . . 
	xor a			;1da3	af 	. 
l1da4h:
	ld (ix + 6),a		;1da4	dd 77 06 	. w . 
l1da7h:
	call l1be2h		;1da7	cd e2 1b 	. . . 
	ld de,0e800h		;1daa	11 00 e8 	. . . 
	add hl,de			;1dad	19 	. 
	ret c			;1dae	d8 	. 
	ld a,(ix + 6)		;1daf	dd 7e 06 	. ~ . 
	cp 003h		;1db2	fe 03 	. . 
	ld a,040h		;1db4	3e 40 	> @ 
	jr c,l1db9h		;1db6	38 01 	8 . 
	xor a			;1db8	af 	. 
l1db9h:
	ld hl,075a5h		;1db9	21 a5 75 	! . u 
	jp l1a7eh		;1dbc	c3 7e 1a 	. ~ . 

; Play the knife-throwing sound
PLAY_KNIFE_THOWING_SOUND:
	push hl			;1dbf	e5 	. 
	push de			;1dc0	d5 	. 
	ld hl,(TIME)	;1dc1	2a 03 e0
	ld de, -819		;1dc4	11 cd fc
	add hl,de		;1dc7	19
    
    ; Knife throwing sound
	ld a,095h		;1dc8	3e 95
	jr c,l1dceh		;1dca	38 02
	ld a,099h		;1dcc	3e 99
l1dceh:
	call PLAY_SOUND		;1dce	cd fe 0d 	. . . 
	pop de			;1dd1	d1 	. 
	pop hl			;1dd2	e1 	. 
	ret			;1dd3	c9 	. 

; Play the stick sound (boss at level #1) or kicks/punches (boss at level #3)
PLAY_WHISTLE_SOUND:
	push hl			;1dd4	e5 	. 
	push de			;1dd5	d5 	. 
	ld hl,(TIME)		;1dd6	2a 03 e0 	* . . 
	ld de, -819		;1dd9	11 cd fc 	. . . 
	add hl,de		;1ddc	19 	HL = TIME - -819
	ld a,092h		;1ddd	3e 92 	> . 
	jr c,l1de3h		;1ddf	38 02 	8 . 
	ld a,09ah		;1de1	3e 9a 	> . 
l1de3h:
	call PLAY_SOUND		;1de3	cd fe 0d 	. . . 
	pop de			;1de6	d1 	. 
	pop hl			;1de7	e1 	. 
	ret			;1de8	c9 	. 

; SEGUIR
; Boss at level 2, IX=E2FB
; E302 (ix + 7): boomerang frame
sub_1de9h:
	ld l,(ix + 12)		;1de9	dd 6e 0c 	. n . 
	ld h,(ix + 13)		;1dec	dd 66 0d 	. f . 
sub_1defh:
	ld e,(ix + 2)		;1def	dd 5e 02 	. ^ . 
	ld d,(ix + 3)		;1df2	dd 56 03 	. V . 
	add hl,de			;1df5	19 	. 
	ld (ix + 2),l		;1df6	dd 75 02 	. u . 
	ld (ix + 3),h		;1df9	dd 74 03 	. t . 
	ret			;1dfc	c9 	. 

; Update the frame, position, frameseq, and height of the
; falling head of boss at level 4.
UPDATE_FALLING_HEAD:
    ; Exit if the falling head is not active.
	ld ix,TBL_HEAD		        ;1dfd	dd 21 1b e3
	ld c,(ix + ENEMY_PROPS_IDX)	;1e01	dd 4e 00
	bit ENEMY_IS_ALIVE_BIT, c	;1e04	cb 61
	ret z			            ;1e06	c8

    ; Update frame if needed
	dec (ix + ENEMY_FRAME_COUNTER_IDX)	 ;1e07	dd 35 07
	jr nz,l1e20h		                 ;1e0a	20 14
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 5 ;1e0c	dd 36 07 05
	inc (ix + ENEMY_FRAME_IDX)		     ;1e10	dd 34 06
	ld a,(TBL_HEAD + ENEMY_FRAME_IDX)	 ;1e13	3a 21 e3
	cp 4		                         ;1e16	fe 04
	jr c,l1e20h		                     ;1e18	38 06
	jr nz,l1e45h		                 ;1e1a	20 29
	
    ; bit 7 doesn't seem to be used.
    ; It's only set here and only reset at l1e45h just below.
    set 7,  (ix + 0)		            ;1e1c	dd cb 00 fe
l1e20h:
    ; Update position of the head, frameseq, and height.
	ld de,0x72		                ;1e20	11 72 00
	call ENEMY_GO_BACK_POSITION		;1e23	cd 7a 1c
	call l1be2h		                ;1e26	cd e2 1b
	ld hl,(TBL_HEAD + ENEMY_FRAMESEQ_PTR_L_IDX)	;1e29	2a 27 e3
	ld de,001bh		                            ;1e2c	11 1b 00
	add hl,de			                        ;1e2f	19
	ld (TBL_HEAD + ENEMY_FRAMESEQ_PTR_L_IDX),hl	;1e30	22 27 e3
	ex de,hl			                        ;1e33	eb
	ld hl,(TBL_HEAD + ENEMY_HEIGHT_L_IDX)		;1e34	2a 1f e3
	sbc hl,de		                            ;1e37	ed 52
	ld (TBL_HEAD + ENEMY_HEIGHT_L_IDX),hl		;1e39	22 1f e3
	ld hl,073d2h		                        ;1e3c	21 d2 73
	ld a,(TBL_HEAD)		                        ;1e3f	3a 1b e3
	jp l1a7eh		                            ;1e42	c3 7e 1a
l1e45h:
	ld (ix + 0), 0 		                        ;1e45	dd 36 00 00
	ret			                                ;1e49	c9

sub_1e4ah:
	ld a,(TBL_ENEMIES)		;1e4a	3a d8 e2 	: . . 
	ld c,a			;1e4d	4f 	O 
	and a			;1e4e	a7 	. 
	jr z,$+63		;1e4f	28 3d 	( = 
	and 010h		;1e51	e6 10 	. . 
	ret z			;1e53	c8 	. 
    
    ; Here it's using the ENEMY_MOVE_COUNTER as a 16-bit word only to
    ; look for an overflow when decrementing. Actually ENEMY_MOVE_COUNTER is
    ; used always as a byte.
	ld hl,(ENEMY_MOVE_COUNTER)		;1e54	2a e0 e2
	dec hl			                ;1e57	2b
	bit 7,h		                    ;1e58	cb 7c Overflow?
	jr nz,l1e5fh		            ;1e5a	20 03 Jump if ENEMY_MOVE_COUNTER < 0
	ld (ENEMY_MOVE_COUNTER),hl		;1e5c	22 e0 e2
l1e5fh:
	ld ix,TBL_ENEMIES		;1e5f	dd 21 d8 e2 	. ! . . 
	ld a,(ENEMY_ENERGY)		;1e63	3a e2 e2 	: . . 
	ld hl,0e2fah		;1e66	21 fa e2 	! . . 
	and a			;1e69	a7 	. 
	jp m,l1e77h		;1e6a	fa 77 1e 	. w . 
	cp 03fh		;1e6d	fe 3f 	. ? 
	jr z,l1e77h		;1e6f	28 06 	( . 
	dec (hl)			;1e71	35 	5 
	jr nz,l1e79h		;1e72	20 05 	  . 

    ; Increment enemy's energy
	inc (ix + ENEMY_ENERGY_IDX)		;1e74	dd 34 0a
l1e77h:
	ld (hl),070h		;1e77	36 70 	6 p 
l1e79h:
	ld a,(DRAGONS_LEVEL)		;1e79	3a 80 e0 	: . . 
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
	ld de,(THOMAS_POSITION)		;1e96	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;1e9a	ed 52 	. R 
	bit 0,a		;1e9c	cb 47 	. G 
	jr z,l1ea1h		;1e9e	28 01 	( . 
	ccf			;1ea0	3f 	? 
l1ea1h:
	ret c			;1ea1	d8 	. 
	cp 003h		;1ea2	fe 03 	. . 
	jr nz,l1each		;1ea4	20 06 	  . 
	ld hl, 847		;1ea6	21 4f 03 	! O . 
	ld (REPLICA_APPEAR_COUNTER),hl		;1ea9	22 f8 e2 	" . . 
l1each:
	bit 0,a		;1eac	cb 47 	. G 
	ld c,a			;1eae	4f 	O 
	ld a,012h		;1eaf	3e 12 	> . 
	jr nz,l1eb5h		;1eb1	20 02 	  . 
	ld a,052h		;1eb3	3e 52 	> R 
l1eb5h:
	ld (TBL_ENEMIES),a		;1eb5	32 d8 e2 	2 . . 
	ld a,070h		;1eb8	3e 70 	> p 
	ld (0e2fah),a		;1eba	32 fa e2 	2 . . 
	ld a,(TBL_GUYS_LEN)		;1ebd	3a 61 e2 	: a . 
	ld hl,0e197h		;1ec0	21 97 e1 	! . . 
	sub (hl)			;1ec3	96 	. 
	ret c			;1ec4	d8 	. 
	ret z			;1ec5	c8 	. 
	ld b,005h		;1ec6	06 05 	. . 
	ld ix,TBL_GUYS		;1ec8	dd 21 62 e2 	. ! b . 
l1ecch:
	bit 0,(ix + 0)		;1ecc	dd cb 00 46 Check if it's a gripper (0) of a knifer (1)
	jr nz,l1f03h		;1ed0	20 31 Jump if it's a knifer
    ; It's a gripper
	ld hl,(THOMAS_POSITION)		;1ed2	2a 12 e7
	ld e,(ix + ENEMY_POS_L_IDX)		;1ed5	dd 5e 02
	ld d,(ix + ENEMY_POS_H_IDX)		;1ed8	dd 56 03
	bit 0,c		        ;1edb	cb 41
	jr z,l1eebh		    ;1edd	28 0c
	bit 6,(ix + 0)		;1edf	dd cb 00 76 Check moving direction (0: to the right, 1: to the left)
	jr z,l1f03h		    ;1ee3	28 1e Jump if he moves to the right
	sbc hl,de		    ;1ee5	ed 52
l1ee7h:
	jr c,l1f03h		    ;1ee7	38 1a
	jr l1ef5h		    ;1ee9	18 0a
l1eebh:
	bit 6,(ix + 0)		;1eeb	dd cb 00 76 Check moving direction (0: to the right, 1: to the left)
	jr nz,l1f03h		;1eef	20 12 	  . 
	sbc hl,de		;1ef1	ed 52 	. R 
	jr nc,l1f03h		;1ef3	30 0e 	0 . 
l1ef5h:
	ld l,a			;1ef5	6f 	o 
	ld a,(ix + ENEMY_STATE_IDX)		;1ef6	dd 7e 01 	. ~ . 
	and a			;1ef9	a7 	. 
	ld a,l			;1efa	7d 	} 
	jr nz,l1f03h		;1efb	20 06 	  . 
	ld (ix + ENEMY_STATE_IDX), 5	;1efd	dd 36 01 05
	dec a			                ;1f01	3d
	ret z			                ;1f02	c8
l1f03h:
	ld de,0010h		;1f03	11 10 00 	. . . 
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
	ld a,(ix + ENEMY_STATE_IDX)		;1f23	dd 7e 01
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
	ld de,M62_SPRITERAM		;1f3a	11 00 c0 	. . . 
	ld hl,(ENEMY_POS)		;1f3d	2a da e2 	* . . 
	add hl,de			;1f40	19 	. 
	jp c,l1f50h		;1f41	da 50 1f 	. P . 
	ret			;1f44	c9 	. 
	call l1be2h		;1f45	cd e2 1b 	. . . 
	ld de,0fa00h		;1f48	11 00 fa 	. . . 
	add hl,de			;1f4b	19 	. 
	jp nc,l1fcfh		;1f4c	d2 cf 1f 	. . . 
	ret			;1f4f	c9 	. 
l1f50h:
	ld (ix + ENEMY_STATE_IDX), 3    ;1f50	dd 36 01 03
	ld (ix + ENEMY_FRAME_IDX),0	    ;1f54	dd 36 06 00
	ret			;1f58	c9 	. 
	call l1be2h		;1f59	cd e2 1b 	. . . 
	call sub_20e3h		;1f5c	cd e3 20 	. .   
	jp c,l2036h		;1f5f	da 36 20 	. 6   
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;1f62	dd 35 07 level 1
	ret nz			;1f65	c0 	. 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;1f66	dd 35 0e level 1
	jp m,l2085h		;1f69	fa 85 20 	. .   
	jr z,l1fc2h		;1f6c	28 54 	( T 
	inc (ix + ENEMY_FRAME_IDX)		        ;1f6e	dd 34 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 5	;1f71	dd 36 07 05
	ld a,(ENEMY_ATTACK_STEP)		        ;1f75	3a e6 e2
	cp 002h		;1f78	fe 02 	. . 
	ret nz			;1f7a	c0 	. 
	call PLAY_WHISTLE_SOUND		;1f7b	cd d4 1d 	. . . 
	ld de,(ME_INITIAL_FALL_SPEED_COPY)		;1f7e	ed 5b 0c e8 	. [ . . 
	ld hl,0fa60h		;1f82	21 60 fa 	! ` . 
	add hl,de			;1f85	19 	. 
	ret c			;1f86	d8 	. 
	ld hl,0fe00h		;1f87	21 00 fe 	! . . 
	add hl,de			;1f8a	19 	. 
	ret nc			;1f8b	d0 	. 
	ld hl,(ENEMY_POS)		;1f8c	2a da e2 	* . . 
	ld de,00200h		;1f8f	11 00 02 	. . . 
	add hl,de			;1f92	19 	. 
	ld (0e80fh),hl		;1f93	22 0f e8 	" . . 
	ld de,l02c0h		;1f96	11 c0 02 	. . . 
	add hl,de			;1f99	19 	. 
	ld (0e811h),hl		;1f9a	22 11 e8 	" . . 
	ld a,(ENEMY_FRAME)		;1f9d	3a de e2 	: . . 
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
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;1fc2	dd 35 0b level 1
	jr nz,l1fd2h		;1fc5	20 0b 	  . 
	inc (ix + ENEMY_FRAME_IDX)	            ;1fc7	dd 34 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX) ,5	;1fca	dd 36 07 05 level 1
	ret			;1fce	c9 	. 
l1fcfh:
	call sub_2ce8h		;1fcf	cd e8 2c 	. . , 
l1fd2h:
	ld a,(EXT_RANDOM + 1)		;1fd2	3a 11 e0 	: . . 
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
	ld (ix + ENEMY_FRAME_IDX),b	;1fe5	dd 70 06
	ld (ix + ENEMY_ATTACK_STEP_IDX),4	;1fe8	dd 36 0e 04 level 1
	ld a,(0e012h)		;1fec	3a 12 e0 	: . . 
	ld hl,0e1a0h		;1fef	21 a0 e1 	! . . 
	call sub_1214h		;1ff2	cd 14 12 	. . . 
	ld (ENEMY_FRAME_COUNTER),a		;1ff5	32 df e2 	2 . . 
	ret			;1ff8	c9 	. 
l1ff9h:
	call l1baah		;1ff9	cd aa 1b
	bit 4,(ix + 0)	;1ffc	dd cb 00 66
	ret nz			;2000	c0
	pop hl			;2001	e1
    ; Resets bit "enemy is alive" of magician and...
	ld hl,TBL_ENEMIES		;2002	21 d8 e2
	res ENEMY_IS_ALIVE_BIT,(hl)		        ;2005	cb a6
    ; ...its replica.
	ld hl,TBL_REPLICA + ENEMY_PROPS_IDX    ;2007	21 e8 e2
	res ENEMY_IS_ALIVE_BIT,(hl)		;200a	cb a6 	. . 
	ret			;200c	c9 	. 
l200dh:
	ld (ix + ENEMY_STATE_IDX),002h		;200d	dd 36 01 02 	. 6 . . 
l2011h:
	call l1be2h		                    ;2011	cd e2 1b
	dec (ix + ENEMY_FRAME_COUNTER_IDX)	;2014	dd 35 07
	jp z,l1fcfh		                    ;2017	ca cf 1f
	ret			                        ;201a	c9

    ; Question: unused code here?
	ld de,(0e104h)		;201b	ed 5b 04 e1 	. [ . . 
	ld l,(ix + 2)		;201f	dd 6e 02 	. n . 
	ld h,(ix + 3)		;2022	dd 66 03 	. f . 
	sbc hl,de		;2025	ed 52 	. R 
	jr c,l200dh		;2027	38 e4 	8 . 
	ld de,0x55		;2029	11 55 00 	. U . 
	call ENEMY_GO_BACK_POSITION		;202c	cd 7a 1c 	. z . 
	jr l2011h		;202f	18 e0 	. . 
l2031h:
	ld (ix + ENEMY_STATE_IDX),006h		;2031	dd 36 01 06 	. 6 . . 
	ret			;2035	c9 	. 
l2036h:
	add a,013h		;2036	c6 13 	. . 
	ld (ENEMY_FRAME),a		;2038	32 de e2 	2 . . 
	cp 016h		;203b	fe 16 	. . 
	ld hl,ENEMY_FRAMESEQ_TABLE4		;203d	21 26 21 	! & ! 
	jr c,l2045h		;2040	38 03 	8 . 
	ld hl,ENEMY_FRAMESEQ_TABLE3		;2042	21 2c 21 	! , ! 
l2045h:
	call APPLY_FRAMESEQ_FROM_HL		;2045	cd 96 1b 	. . . 
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_UNKNOWN_TABLE		;2048	21 67 2d 	! g - 
	ld de,l00d8h		;204b	11 d8 00 	. . . 
	call DECREASE_ENEMY_ENERGY_UPKICK		;204e	cd 19 2d 	. . - 
	ld a,008h		;2051	3e 08 	> . 
	jp c,l247ah		;2053	da 7a 24 	. z $ 
	ld a,(ix-002h)		;2056	dd 7e fe 	. ~ . 
	ld (ix-002h),01ch		;2059	dd 36 fe 1c 	. 6 . . 
	and a			;205d	a7 	. 
	jr nz,l2031h		;205e	20 d1 	  . 
	inc (ix + ENEMY_STATE_IDX)	;2060	dd 34 01
	ret			;2063	c9 	. 
	call sub_2d13h		;2064	cd 13 2d 	. . - 
	call sub_20e3h		;2067	cd e3 20 	. .   
	jp c,l2036h		;206a	da 36 20 	. 6   
l206dh:
	ld de,(0e104h)		;206d	ed 5b 04 e1 	. [ . . 
l2071h:
	ld l,(ix + ENEMY_POS_L_IDX)		;2071	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;2074	dd 66 03
	sbc hl,de		;2077	ed 52 	. R 
	jr c,l2080h		;2079	38 05 	8 . 
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;207b	dd 7e 08 level 1
	and a			;207e	a7 	. 
	ret nz			;207f	c0 	. 
l2080h:
	ld (ix + ENEMY_STATE_IDX), 0 ;2080	dd 36 01 00
	ret			;2084	c9 	. 
l2085h:
	ld (ix + CURRENT_FRAME_IDX), 0	        ;2085	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;2089	dd 36 07 07 level 1
	ld (ix + ENEMY_STATE_IDX), 5            ;208d	dd 36 01 05
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX), 37  ;2091	dd 36 08 25 level 1
	ret			                            ;2095	c9
l2096h:
	call sub_2cb9h		;2096	cd b9 2c 	. . , 
	call sub_2c78h		;2099	cd 78 2c 	. x , 
	ld hl,06c8dh		;209c	21 8d 6c 	! . l 
l209fh:
	ld de,0fea0h		;209f	11 a0 fe 	. . . 
sub_20a2h:
	ld a,(0e701h)		;20a2	3a 01 e7 	: . . 
	and 003h		;20a5	e6 03 	. . 
	jr nz,l20adh		;20a7	20 04
	res TRAILING_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)	;20a9	dd cb 00 ae
l20adh:
	push hl			;20ad	e5 	. 
	ld a,(ix + ENEMY_STATE_IDX)		;20ae	dd 7e 01
	cp 1		                    ;20b1	fe 01
	jr z,l20d2h		;20b3	28 1d 	( . 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)	;20b5	2a 0c e8
	add hl,de			                ;20b8	19
	ld hl,0e701h		                ;20b9	21 01 e7

	bit ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;20bc	dd cb 00 76
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
	ld a,(ix + ENEMY_PROPS_IDX)	;20dd	dd 7e 00
	jp l1a7eh		;20e0	c3 7e 1a 	. ~ . 

; SEGUIR
sub_20e3h:
	call sub_2109h		;20e3	cd 09 21 	. . ! 
	ret nc			;20e6	d0 	. 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;20e7	2a 0c e8 	* . . 
	ld de,0fe60h		;20ea	11 60 fe 	. ` . 
	add hl,de			;20ed	19 	. 
	ret nc			;20ee	d0 	. 
	ld a,(ENEMY_FRAME)		;20ef	3a de e2 	: . . 
	cp 004h		;20f2	fe 04 	. . 
	jr c,l20fdh		;20f4	38 07 	8 . 
	cp 009h		;20f6	fe 09 	. . 
	ld hl,l2112h		;20f8	21 12 21 	! . ! 
	jr c,l2100h		;20fb	38 03 	8 . 
l20fdh:
	ld hl,l211ch		;20fd	21 1c 21 	! . ! 
l2100h:
	call CHECK_VAL_HL_PLUS_B_0XFF		;2100	cd 18 1b
	ret nc			                    ;2103	d0
	set TRAILING_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;2104	dd cb 00 ee
	ret			                        ;2108	c9

sub_2109h:
	ld a,(ix + ENEMY_PROPS_IDX)		;2109	dd 7e 00
    ;        7654 3219 
    ; 0x20 = 0010 0000
    ; Bit 5: set when eneny is being attacked
	and 1 << TRAILING_RIGHT_BIT		;210c	e6 20
	ret nz			;210e	c0
	jp sub_1ae7h		;210f	c3 e7 1a 	. . . 

; ToDo: this looks like a (frameseq?) table:
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

ENEMY_FRAMESEQ_TABLE4: ; 2126
    defb 0x06, 0x18, 0x08, 0x19, 0x11, 0xff
    
ENEMY_FRAMESEQ_TABLE3: ; 212c
    defb 6, 0x1a, 0x8, 0x1b, 0x11, 0xff

    ; Unused data/code here?
    ld c, b             ;2132   48
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
	ld de,M62_SPRITERAM		;2152	11 00 c0 	. . . 
	ld hl,(ENEMY_POS)		;2155	2a da e2 	* . . 
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
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2170	dd 35 07 level 3
	ret nz			;2173	c0 	. 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;2174	dd 35 0e level 3
	jr z,l21d4h		;2177	28 5b 	( [ 
	inc (ix + ENEMY_FRAME_IDX)		        ;2179	dd 34 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;217c	dd 36 07 0b level 3
	ld a,(ENEMY_ATTACK_STEP)		        ;2180	3a e6 e2
	cp 2		                            ;2183	fe 02
	ret nz			;2185	c0 	. 
	call PLAY_WHISTLE_SOUND		;2186	cd d4 1d 	. . . 
	ld hl,(ENEMY_POS)		;2189	2a da e2 	* . . 
	ld a,(ENEMY_FRAME)		;218c	3a de e2 	: . . 
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
	ld a,(ENEMY_FRAME)		;21c1	3a de e2 	: . . 
	cp 007h		;21c4	fe 07 	. . 
	ld hl,06c80h		;21c6	21 80 6c 	! . l 
	jr c,l21ceh		;21c9	38 03 	8 . 
	ld hl,06080h		;21cb	21 80 60 	! . ` 
l21ceh:
	ld de,0016h+2		;21ce	11 18 00 	. . . 
	jp l2c95h		;21d1	c3 95 2c 	. . , 
l21d4h:
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;21d4	dd 35 0b level 3
	jr nz,l21dfh		;21d7	20 06 	  . 
	jp l2220h		;21d9	c3 20 22 	.   " 
l21dch:
	call sub_2ce8h		;21dc	cd e8 2c 	. . , 
l21dfh:
	ld a,(EXT_RANDOM + 1)		;21df	3a 11 e0 	: . . 
	ld hl,0e19eh		;21e2	21 9e e1 	! . . 
	ld b,004h		;21e5	06 04 	. . 
	cp (hl)			;21e7	be 	. 
	jr c,l21ech		;21e8	38 02 	8 . 
	ld b,007h		;21ea	06 07 	. . 
l21ech:
	ld (ix + ENEMY_FRAME_IDX),b		;21ec	dd 70 06
	ld a,(0e012h)		;21ef	3a 12 e0 	: . . 
	ld hl,0e1a5h		;21f2	21 a5 e1 	! . . 
	call sub_1214h		;21f5	cd 14 12 	. . . 
	ld (ENEMY_FRAME_COUNTER),a		;21f8	32 df e2 	2 . . 
	ld (ix + ENEMY_ATTACK_STEP_IDX), 3  	;21fb	dd 36 0e 03 level 3
	ret			;21ff	c9 	. 
l2200h:
	call l1be2h		                        ;2200	cd e2 1b
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2203	dd 35 07 level 3
	jp z,l1f50h		                        ;2206	ca 50 1f
	ret			                            ;2209	c9
l220ah:
	ld (ix + ENEMY_FRAME_IDX), 0		    ;220a	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;220e	dd 36 07 0b level 3
	ld (ix + ENEMY_STATE_IDX), 2            ;2212	dd 36 01 02
	ret			                            ;2216	c9
l2217h:
	call sub_2d13h		;2217	cd 13 2d 	. . - 
	call sub_224bh		;221a	cd 4b 22 	. K " 
	jp l206dh		;221d	c3 6d 20 	. m   
l2220h:
	ld (ix + ENEMY_FRAME_IDX), 0	        ;2220	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;2224	dd 36 07 07 level 3
	ld (ix + ENEMY_STATE_IDX), 5	        ;2228	dd 36 01 05
	ld a,(0e013h)		;222c	3a 13 e0 	: . . 
	ld hl,0e1a0h		;222f	21 a0 e1 	! . . 
	call sub_1214h		;2232	cd 14 12 	. . . 
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX),a	;2235	dd 77 08 level 2
	ret			;2238	c9 	. 
l2239h:
	call sub_2cb9h		;2239	cd b9 2c 	. . , 
	call sub_2c78h		;223c	cd 78 2c 	. x , 
	ld hl,06e65h		;223f	21 65 6e 	! e n 
	ld de,0fe20h		;2242	11 20 fe 	.   . 
	call sub_20a2h		;2245	cd a2 20 	. .   
	jp l2e70h		;2248	c3 70 2e 	. p . 
sub_224bh:
	ld a,(TBL_ENEMIES)		;224b	3a d8 e2 	: . . 
	and 020h		;224e	e6 20 	.   
	ret nz			;2250	c0 	. 
	ld hl,l00e0h		;2251	21 e0 00 	! . . 
	call sub_1220h		;2254	cd 20 12 	.   . 
	ret nc			;2257	d0 	. 
	set 5,(ix + 0)		;2258	dd cb 00 ee 	. . . . 
	push de			;225c	d5 	. 
	ld hl,5		;225d	21 05 00 	! . . 
	call sub_2e5ch		;2260	cd 5c 2e 	. \ . 
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_BOSSES_1_5_TABLE		;2263	21 6a 2d 	! j - 
	call DECREASE_ENEMY_ENERGY_UPKICK		;2266	cd 19 2d 	. . - 
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
	ld (ix + ENEMY_FRAME_IDX), 0	;227a	dd 36 06 00
	ld hl,ENEMY_FRAMESEQ_TABLE5		;227e	21 84 22 	! . " 
	jp APPLY_FRAMESEQ_FROM_HL		;2281	c3 96 1b 	. . . 

ENEMY_FRAMESEQ_TABLE5:
    defb 0x06, 0x0a, 0x08, 0x0b, 0x13, 0xff

l228ah: ; Acceded from 1b2b: jr nz,l1b37h ;	20 0a 	  . 
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
	ld hl,(ENEMY_POS)		;22b2	2a da e2 	* . . 
	add hl,de			;22b5	19 	. 
	jp nc,l1f50h		;22b6	d2 50 1f 	. P . 
	ret			;22b9	c9 	. 
l22bah:
	ld (ix + 1),000h		;22ba	dd 36 01 00 	. 6 . . 
	ld (ix + 6),000h		;22be	dd 36 06 00 	. 6 . . 
	ld (ix + 7),002h		;22c2	dd 36 07 02 	. 6 . . 
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
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;22db	dd 35 07 level 2
	ret nz			;22de	c0 	. 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;22df	dd 35 0e level 2
	jr z,l2344h		;22e2	28 60 	( ` 
	jp m,l23b4h		;22e4	fa b4 23 	. . # 
	inc (ix + ENEMY_FRAME_IDX)		;22e7	dd 34 06

	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11		;22ea	dd 36 07 0b level 2
	ld iy,TBL_BOOMERANG_1		;22ee	fd 21 fb e2 	. ! . . 
	bit BOOMERANG_ACTIVE1_BIT, (iy + BOOMERANG_PROPS_IDX)	;22f2	fd cb 00 66
	jr z,l22fch		;22f6	28 04 	( . 
	ld iy, TBL_BOOMERANG_2		;22f8	fd 21 0b e3
l22fch:
	ld a,(ENEMY_BOOMERANG_TYPE)		;22fc	3a e7 e2 	: . . 
	cp 002h		;22ff	fe 02 	. . 
	ld hl,06900h		;2301	21 00 69 	! . i 
	jr c,l2309h		;2304	38 03 	8 . 
	ld hl,05680h		;2306	21 80 56 	! . V 
l2309h:
	ld (iy+004h),l		;2309	fd 75 04 	. u . 
	ld (iy+005h),h		;230c	fd 74 05 	. t . 
	ld (iy+00bh),a		;230f	fd 77 0b 	. w . 
	ld hl,(ENEMY_POS)		;2312	2a da e2 	* . . 
	ld de,0ff00h		;2315	11 00 ff 	. . . 
	add hl,de			;2318	19 	. 
	ld (iy+002h),l		;2319	fd 75 02 	. u . 
	ld (iy+003h),h		;231c	fd 74 03 	. t . 
	ld de,0ed00h		;231f	11 00 ed 	. . . 
	add hl,de			;2322	19 	. 
	ld (iy+00eh),l		;2323	fd 75 0e 	. u . 
	ld (iy+00fh),h		;2326	fd 74 0f 	. t . 
	ld hl,(VAR_E1B9)		;2329	2a b9 e1 	* . . 
	ld (iy+00ch),l		;232c	fd 75 0c 	. u . 
	ld (iy+00dh),h		;232f	fd 74 0d 	. t . 
	ld a,050h		;2332	3e 50 	> P 
	ld (iy + BOOMERANG_PROPS_IDX),a		;2334	fd 77 00
	xor a			;2337	af 	. 
	ld (iy + BOOMERANG_DIRECTION),a		;2338	fd 77 01
	ld (iy+006h),a		;233b	fd 77 06 	. w . 
	ld a,002h		;233e	3e 02 	> . 
	ld (iy+007h),a		;2340	fd 77 07 	. w . 
	ret			;2343	c9 	. 
l2344h:
	inc (ix + ENEMY_ATTACK_STEP_IDX)		;2344	dd 34 0e level 2
	inc (ix + ENEMY_FRAME_COUNTER_IDX)		;2347	dd 34 07 level 2
	ld iy,TBL_BOOMERANG_1		;234a	fd 21 fb e2 	. ! . . 
	bit BOOMERANG_ACTIVE1_BIT, (iy + BOOMERANG_PROPS_IDX)   	;234e	fd cb 00 66
	jr z,l2368h		;2352	28 14 	( . 
	bit 7,(iy+00dh)		;2354	fd cb 0d 7e 	. . . ~ 
	ret nz			;2358	c0 	. 
	bit 0,(ix-001h)		;2359	dd cb ff 46 	. . . F 
	jr z,l2371h		;235d	28 12 	( . 
	bit 4,(iy+010h)		;235f	fd cb 10 66 	. . . f 
	jr nz,l2371h		;2363	20 0c 	  . 
	jp l23d3h		;2365	c3 d3 23 	. . # 
l2368h:
	ld iy, TBL_BOOMERANG_2		;2368	fd 21 0b e3
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
	ld (ix + ENEMY_FRAME_IDX),a		;2381	dd 77 06
	ld hl,(ENEMY_POS)		;2384	2a da e2 	* . . 
	ld de,0fec0h		;2387	11 c0 fe 	. . . 
	add hl,de			;238a	19 	. 
	ld e,(iy+002h)		;238b	fd 5e 02 	. ^ . 
	ld d,(iy+003h)		;238e	fd 56 03 	. V . 
	sbc hl,de		;2391	ed 52 	. R 
	ret nc			;2393	d0 	. 
	ld (iy + 0), 0	;2394	fd 36 00 00
	dec (ix + ENEMY_FRAME_IDX)		;2398	dd 35 06
	ld a,(TBL_BOOMERANG_2)		;239b	3a 0b e3
	and 1 << BOOMERANG_ACTIVE1_BIT		;239e	e6 10 	. . 
	ld a,00bh		;23a0	3e 0b 	> . 
	jr nz,l23b0h		;23a2	20 0c 	  . 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;23a4	dd 35 0e level 2
	ld a,(EXT_RANDOM + 1)		;23a7	3a 11 e0 	: . . 
	ld hl,0e1a5h		;23aa	21 a5 e1 	! . . 
	call sub_1214h		;23ad	cd 14 12 	. . . 
l23b0h:
	ld (ENEMY_FRAME_COUNTER),a		;23b0	32 df e2 	2 . . 
	ret			;23b3	c9 	. 
l23b4h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;23b4	2a 0c e8 	* . . 
	ld de,0f500h		;23b7	11 00 f5 	. . . 
	add hl,de			;23ba	19 	. 
	jp c,l22bah		;23bb	da ba 22 	. . " 
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;23be	dd 35 0b level 2
	jr nz,l23cch		;23c1	20 09 	  . 
	jp l2220h		;23c3	c3 20 22 	.   " 
l23c6h:
	ld a,(0e19fh)		;23c6	3a 9f e1 	: . . 
	ld (ENEMY_STEADY_COUNTER),a		;23c9	32 e3 e2 	2 . . 
l23cch:
	ld a,r		;23cc	ed 5f 	. _ 
	and 001h		;23ce	e6 01 	. . 
	ld (ix-001h),a		;23d0	dd 77 ff 	. w . 
l23d3h:
	ld (ix + ENEMY_STATE_IDX), 4 ;23d3	dd 36 01 04
	ld a,(EXT_RANDOM)		;23d7	3a 10 e0 	: . . 
	ld hl, TBL_E19C		;23da	21 9c e1 	! . . 
	ld b,0  		;23dd	06 00 	. . 
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
	ld (ix + ENEMY_BOOMERANG_TYPE_IDX),b	;23ed	dd 70 0f level 2
	ld a,b			;23f0	78 	x 
	ld b,009h		;23f1	06 09 	. . 
	cp 002h		;23f3	fe 02 	. . 
	jr nc,l23f9h		;23f5	30 02 	0 . 
	ld b,00bh		;23f7	06 0b 	. . 
l23f9h:
	ld (ix + ENEMY_FRAME_IDX),b		;23f9	dd 70 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;23fc	dd 36 07 0b level 2
	ld (ix + ENEMY_ATTACK_STEP_IDX), 2      ;2400	dd 36 0e 02 level 2
	ret			;2404	c9 	. 
l2405h:
	ld (ix + ENEMY_STATE_IDX), 2          		;2405	dd 36 01 02
l2409h:
	call l1be2h		;2409	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;240c	dd 35 07 level 2
	ret nz			;240f	c0 	. 
	inc (ix + ENEMY_FRAME_COUNTER_IDX)		;2410	dd 34 07
	ld a,(TBL_BOOMERANG_2)		;2413	3a 0b e3
	and 1 << BOOMERANG_ACTIVE1_BIT		;2416	e6 10
	jr nz,l2427h		;2418	20 0d 	  . 
	ld a,(TBL_BOOMERANG_1)		;241a	3a fb e2 	: . . 
	and 1 << BOOMERANG_ACTIVE1_BIT		;241d	e6 10
	jr z,l23c6h		;241f	28 a5 	( . 
	bit 0,(ix-001h)		;2421	dd cb ff 46 	. . . F 
	jr nz,l23d3h		;2425	20 ac 	  . 
l2427h:
	ld a,(ENEMY_FRAMESEQ_PTR)		;2427	3a e4 e2 	: . . 
	ld (ENEMY_FRAME),a		;242a	32 de e2 	2 . . 
	ld (ix + ENEMY_STATE_IDX),004h		;242d	dd 36 01 04
	ret			;2431	c9 	. 
    
    ; Unused code?
	ld de,(0e106h)		;2432	ed 5b 06 e1 	. [ . . 
	ld l,(ix + 2)		;2436	dd 6e 02 	. n . 
	ld h,(ix + 3)		;2439	dd 66 03 	. f . 
	sbc hl,de		;243c	ed 52 	. R 
	jr nc,l2405h		;243e	30 c5 	0 . 
	ld de,0x55		;2440	11 55 00 	. U . 
	call ENEMY_GO_BACK_POSITION		;2443	cd 7a 1c 	. z . 
	jr l2409h		;2446	18 c1 	. . 
l2448h:
	ld b,(ix + ENEMY_FRAME_IDX)	;2448	dd 46 06
	add a, 4                		;244b	c6 04
	ld (ENEMY_FRAME),a		;244d	32 de e2 	2 . . 
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_BOSS_3_TABLE		;2450	21 6d 2d 	! m - 
	call DECREASE_ENEMY_ENERGY_UPKICK		;2453	cd 19 2d 	. . - 
	jr c,l246fh		;2456	38 17 	8 . 
	ld (ix + ENEMY_FRAMESEQ_PTR_L_IDX),b		    ;2458	dd 70 0c
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 6	;245b	dd 36 07 06 level 2
	ld a,(ix-002h)		;245f	dd 7e fe 	. ~ . 
	ld (ix-002h),01ch		;2462	dd 36 fe 1c 	. 6 . . 
	and a			;2466	a7 	. 
	jp nz,l2031h		;2467	c2 31 20 	. 1   
	ld (ix + ENEMY_STATE_IDX), 2    ;246a	dd 36 01 02
	ret			;246e	c9 	. 
l246fh:
	ld hl,ENEMY_FRAMESEQ_TABLE6		;246f	21 cc 24 	! . $ 
	call APPLY_FRAMESEQ_FROM_HL		;2472	cd 96 1b 	. . . 
	ld de,0xdc		;2475	11 dc 00 	. . . 
	ld a,009h		;2478	3e 09 	> . 
l247ah:
	ld hl,(ENEMY_POS)		;247a	2a da e2 	* . . 
	jp ADD_POINTS		;247d	c3 60 2f 	. ` / 
	call sub_2d13h		;2480	cd 13 2d 	. . - 
	call sub_24b0h		;2483	cd b0 24 	. . $ 
	jr c,l2448h		;2486	38 c0 	8 . 
l2488h:
	ld de,(0e106h)		;2488	ed 5b 06 e1 	. [ . . 
	ld l,(ix + ENEMY_POS_L_IDX)		;248c	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;248f	dd 66 03
	sbc hl,de		;2492	ed 52 	. R 
	jp nc,l2080h		;2494	d2 80 20 	. .   
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)	;2497	dd 7e 08 level 2
	and a			;249a	a7 	. 
	jp z,l2080h		;249b	ca 80 20 	. .   
	ret			;249e	c9 	. 
l249fh:
	ld hl,THOMAS_PROPS		;249f	21 00 e7 	! . . 
	set 6,(hl)		;24a2	cb f6 Knifer in level 2 will send his dagger to the right
	call sub_2cb9h		;24a4	cd b9 2c 	. . , 
	call sub_2c78h		;24a7	cd 78 2c 	. x , 
	ld hl,06f4eh		;24aa	21 4e 6f 	! N o 
	jp l209fh		;24ad	c3 9f 20 	. .   
sub_24b0h:
	call sub_2109h		;24b0	cd 09 21 	. . ! 
	ret nc			;24b3	d0 	. 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;24b4	2a 0c e8 	* . . 
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

ENEMY_FRAMESEQ_TABLE6:
    defb 0x06, 0x07, 0x08, 0x08, 0x11, 0xff
    
    ; Unused data/code here?
    ;jr $+39     ; 24d2
    jr l24f9h     ; 24d2    18 25
    
    ld sp,hl	 ;24d4	f9 	.     
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

    defb 0x22       ;24f8
l24f9h:
	defb 0xf8, 0xe2		;24f9	f8 e2
l24fbh:
	ld hl,0e2d6h		;24fb	21 d6 e2 	! . . 
	ld a,(hl)			;24fe	7e 	~ 
	and a			;24ff	a7 	. 
	jr z,l2503h		;2500	28 01 	( . 
	dec (hl)			;2502	35 	5 
l2503h:
	call sub_250fh		;2503	cd 0f 25 	. . % 
	ld ix,TBL_REPLICA		    ;2506	dd 21 e8 e2

	bit ENEMY_IS_ALIVE_BIT, (ix + ENEMY_PROPS_IDX)	;250a	dd cb 00 66
	ret z			;250e	c8 Return if enemy is dead
sub_250fh:
	ld hl,024d2h		;250f	21 d2 24 	! . $ 
	call l1f23h		;2512	cd 23 1f 	. # . 
	jp l2893h		;2515	c3 93 28 	. . ( 
	call sub_2d0dh		;2518	cd 0d 2d 	. . - 
	ld de,0f800h		;251b	11 00 f8 	. . . 
	add hl,de			;251e	19 	. 
	jp nc,l2589h		;251f	d2 89 25

	bit ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;2522	dd cb 00 76
	ret nz			;2526	c0 Return if looking right

	ld de,05f00h		;2527	11 00 5f 	. . _ 
	ld l,(ix + ENEMY_POS_L_IDX)		;252a	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;252d	dd 66 03
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
	ld a,(ix + ENEMY_ATTACK_STEP_IDX)		;2549	dd 7e 0e
	and a			;254c	a7 	. 
	call m,sub_25afh		;254d	fc af 25 	. . % 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2550	dd 35 07 level 4
	ret nz			;2553	c0 	. 
	and a			;2554	a7 	. 
	jr z,l256ch		;2555	28 15 	( . 
	jp m,l258ch		;2557	fa 8c 25 	. . % 
	add a,(ix + CURRENT_FRAME_IDX)		;255a	dd 86 06
	ld (ix + ENEMY_FRAME_IDX),a		    ;255d	dd 77 06
	call sub_34ddh		;2560	cd dd 34 	. . 4 
l2563h:
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;2563	dd 36 07 0b level 4
	ld (ix + ENEMY_ATTACK_STEP_IDX), 0		;2567	dd 36 0e 00
	ret			;256b	c9 	. 
l256ch:
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;256c	dd 35 0b level 4
	jp z,l2220h		;256f	ca 20 22 	.   " 
	call sub_25afh		;2572	cd af 25 	. . % 
l2575h:
	ld (ix + ENEMY_FRAME_IDX),0	;2575	dd 36 06 00
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;2579	dd 35 0e
	ld a,(EXT_RANDOM + 1)		;257c	3a 11 e0 	: . . 
	ld hl,0e1a5h		;257f	21 a5 e1 	! . . 
	call sub_1214h		;2582	cd 14 12 	. . . 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;2585	dd 77 07 level 4
	ret			;2588	c9 	. 
l2589h:
	call sub_2ce8h		;2589	cd e8 2c 	. . , 
l258ch:
	call CAN_REPLICA_APPEAR		;258c	cd d4 2c 	. . , 
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
	ld (ix + ENEMY_ATTACK_STEP_IDX),b       ;25a3	dd 70 0e
	ld (ix + ENEMY_FRAME_IDX), 4	        ;25a6	dd 36 06 04
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;25aa	dd 36 07 0b level 4
	ret			                            ;25ae	c9

sub_25afh:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;25af	2a 0c e8 	* . . 
	ld de,0f380h		;25b2	11 80 f3 	. . . 
	add hl,de			;25b5	19 	. 
	ret nc			;25b6	d0 	. 
	pop af			;25b7	f1 	. 
	ld (ix + ENEMY_FRAME_IDX), 0		    ;25b8	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7    ;25bc	dd 36 07 07 level 4
	jp l2080h		;25c0	c3 80 20 	. .   
	call l1be2h		;25c3	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;25c6	dd 35 07 level 4
	ret nz			;25c9	c0 	. 
	ld a,(0e2d7h)		;25ca	3a d7 e2 	: . . 
	and a			;25cd	a7 	. 
	jp z,l1f50h		;25ce	ca 50 1f 	. P . 
	ld (ix + ENEMY_STATE_IDX),00dh		;25d1	dd 36 01 0d 	. 6 . . 
	ld (ix + CURRENT_FRAME_IDX), 26	;25d5	dd 36 06 1a
	ld (ix + FRAME_COUNTER_IDX), 8	;25d9	dd 36 07 08
    ; Set Thomas is frozen
	ld hl,THOMAS_PROPS		            ;25dd	21 00 e7
	set 0,(hl)		                ;25e0	cb c6
	ret			                    ;25e2	c9
	call l1be2h		;25e3	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)		;25e6	dd 35 07
	ret nz			                    ;25e9	c0
	ld (ix + FRAME_COUNTER_IDX),8		;25ea	dd 36 07 08
	inc (ix + CURRENT_FRAME_IDX)		;25ee	dd 34 06
	ld a,(ix + CURRENT_FRAME_IDX)		;25f1	dd 7e 06
	cp 34		                        ;25f4	fe 22
	ret nz			;25f6	c0 	. 
	inc (ix + ENEMY_STATE_IDX)		;25f7	dd 34 01 	. 4 . 
	ld (ix + CURRENT_FRAME_IDX),30	;25fa	dd 36 06 1e
	ld l,(ix + ENEMY_POS_L_IDX)		;25fe	dd 6e 02 	. n . 
	ld h,(ix + ENEMY_POS_H_IDX)		;2601	dd 66 03 	. f . 
	bit 6,(ix + 0)		;2604	dd cb 00 76 	. . . v 
	jr z,l2618h		;2608	28 0e 	( . 
	ld de,0a100h		;260a	11 00 a1 	. . . 
	sbc hl,de		;260d	ed 52 	. R 
	add hl,de			;260f	19 	. 
	jr c,l2626h		;2610	38 14 	8 . 
	ld de,0fd80h		;2612	11 80 fd 	. . . 
	add hl,de			;2615	19 	. 
	jr l2626h		;2616	18 0e 	. . 
l2618h:
	ld de,0x0280		;2618	11 80 02 	. . . 
	add hl,de			;261b	19 	. 
	ld de,(0e106h)		;261c	ed 5b 06 e1 	. [ . . 
	sbc hl,de		;2620	ed 52 	. R 
	add hl,de			;2622	19 	. 
	jr c,l2626h		;2623	38 01 	8 . 
	ex de,hl			;2625	eb 	. 
l2626h:
	ld (ix + ENEMY_POS_L_IDX),l		;2626	dd 75 02 	. u . 
	ld (ix + ENEMY_POS_H_IDX),h		;2629	dd 74 03 	. t . 
	jp l1be2h		;262c	c3 e2 1b 	. . . 
	call l1be2h		;262f	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)		;2632	dd 35 07
	ret nz			;2635	c0 	. 
	ld (ix + FRAME_COUNTER_IDX), 8		;2636	dd 36 07 08
	inc (ix + CURRENT_FRAME_IDX)		;263a	dd 34 06
	ld a,(ix + CURRENT_FRAME_IDX)		;263d	dd 7e 06
	cp 38		    ;2640	fe 26
	ret nz			;2642	c0
    ; Set Thomas is not frozen
	ld hl,THOMAS_PROPS	;2643	21 00 e7
	res 0,(hl)		;2646	cb 86
	jp l1f50h		;2648	c3 50
l264bh:
	and a			;264b	a7 	. 
	jr z,l2698h		;264c	28 4a 	( J 
	ld (ix + ENEMY_FRAME_IDX), 8	;264e	dd 36 06 08
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_BOSS_2_TABLE		;2652	21 70 2d 	! p - 
	call DECREASE_ENEMY_ENERGY_UPKICK		;2655	cd 19 2d 	. . - 
	ld hl,l28d6h		;2658	21 d6 28 	! . ( 
	jr c,l266eh		;265b	38 11 	8 . 
	ld a,(hl)			;265d	7e 	~ 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;265e	dd 77 07 level 4
	ld (ix + ENEMY_STATE_IDX), 2    ;2661	dd 36 01 02
	ld hl,0e2d6h		;2665	21 d6 e2 	! . . 
	ld a,(hl)			;2668	7e 	~ 
	ld (hl),01ch		;2669	36 1c 	6 . 
	inc hl			;266b	23 	# 
	ld (hl),a			;266c	77 	w 
	ret			;266d	c9 	. 
l266eh:
	call APPLY_FRAMESEQ_FROM_HL		;266e	cd 96 1b 	. . . 
	ld l,(ix + ENEMY_POS_L_IDX)		;2671	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;2674	dd 66 03
	ld de,000d7h		;2677	11 d7 00 	. . . 
	ld a,00ah		;267a	3e 0a 	> . 
	jp ADD_POINTS		;267c	c3 60 2f 	. ` / 
	call l1be2h		;267f	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)		;2682	dd 35 07
	ret nz			;2685	c0 	. 
	ld a,(ix + ENEMY_FRAME_IDX)		;2686	dd 7e 06
	inc a			;2689	3c
	cp 19		    ;268a	fe 13
	jr c,l26ceh		;268c	38 40
	jr nz,l26edh	;268e	20 5d 	  ] 
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 28		;2690	dd 36 07 1c
	ld a, 38		;2694	3e 26
	jr l26d2h		;2696	18 3a 	. : 
l2698h:
	ld a,091h		;2698	3e 91 	> . 
	call PLAY_SOUND		;269a	cd fe 0d 	. . . 
	ld l,(ix + ENEMY_POS_L_IDX)		;269d	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;26a0	dd 66 03
	ld (0e31dh),hl		;26a3	22 1d e3 	" . . 
	ld a,(ix + ENEMY_PROPS_IDX)	;26a6	dd 7e 00
    ;        7654 3210
    ; 0x50 = 0101 0000
    ; Look right, not being attacked, enemy is alive
    ; This seems an initializacion for the enemy.
	and (1 << ENEMY_IS_ALIVE_BIT) | (1 << 6); 0x50		      ;26a9	e6 50
	ld (TBL_HEAD),a		  ;26ab	32 1b e3

	ld hl,06500h		  ;26ae	21 00 65
	ld (TBL_HEAD + 4),hl  ;26b1	22 1f e3

	ld hl,0x5b		      ;26b4	21 5b 00
	ld (TBL_HEAD + 12),hl ;26b7	22 27 e3

	ld a,005h		      ;26ba	3e 05
	ld (TBL_HEAD + 7),a	  ;26bc	32 22 e3

	xor a			      ;26bf	af
	ld (TBL_HEAD + 6),a	;26c0	32 21 e3

    ; Set Thomas is frozen
	ld hl,THOMAS_PROPS		;26c3	21 00 e7
	set 0,(hl)		    ;26c6	cb c6

	ld (ix + ENEMY_STATE_IDX), 6    ;26c8	dd 36 01 06
	ld a, 11		;26cc	3e 0b
l26ceh:
	ld (ix + FRAME_COUNTER_IDX), 8		;26ce	dd 36 07 08
l26d2h:
	ld (ix + ENEMY_FRAME_IDX),a		;26d2	dd 77 06
	ret			;26d5	c9 	. 
	call l1be2h		;26d6	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;26d9	dd 35 07 level 4
	ret nz			;26dc	c0 	. 
	ld a,(ix + ENEMY_FRAME_IDX)		;26dd	dd 7e 06
	inc a			;26e0	3c 	< 
	cp 26   		;26e1	fe 1a
	jr c,l26ceh		;26e3	38 e9 	8 . 
    ; Set Thomas is not frozen
	ld hl,THOMAS_PROPS	;26e5	21 00 e7
	res 0,(hl)		;26e8	cb 86
	jp l2589h		;26ea	c3 89 25
l26edh:
	inc (ix + ENEMY_STATE_IDX)		;26ed	dd 34 01
	ld l,(ix + ENEMY_POS_L_IDX)		;26f0	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;26f3	dd 66 03
	ld de,0x0280		;26f6	11 80 02 	. . . 

	bit ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;26f9	dd cb 00 76
	jr nz,l270ch		;26fd	20 0d

    ; Looking left
	add hl,de			;26ff	19 	. 
	ex de,hl			;2700	eb 	. 
	ld hl,(0e106h)		;2701	2a 06 e1 	* . . 
	sbc hl,de		;2704	ed 52 	. R 
	add hl,de			;2706	19 	. 
	jr c,l270eh		;2707	38 05 	8 . 
	ex de,hl			;2709	eb 	. 
	jr l270eh		;270a	18 02 	. . 
l270ch:
    ; Do this if looking right
	sbc hl,de		;270c	ed 52
l270eh:
	ld (ix + ENEMY_POS_L_IDX),l		;270e	dd 75 02
	ld (ix + ENEMY_POS_H_IDX),h		;2711	dd 74 03
	call l1be2h		;2714	cd e2 1b 	. . . 
	ld a,00fh		;2717	3e 0f 	> . 
	jr l26ceh		;2719	18 b3 	. . 
	call sub_2d13h		;271b	cd 13 2d 	. . - 
	call sub_28bah		;271e	cd ba 28 	. . ( 
	jp c,l264bh		;2721	da 4b 26 	. K & 
	call CAN_REPLICA_APPEAR		;2724	cd d4 2c 	. . , 
	jp z,l2080h		;2727	ca 80 20

	bit ENEMY_MOVE_RIGHT_BIT,(ix + ENEMY_PROPS_IDX)		;272a	dd cb 00 76 	. . . v 
	jp z,l2488h		;272e	ca 88 24 	. . $ 

	ld de,0a100h		;2731	11 00 a1 	. . . 
	jp l2071h		;2734	c3 71 20

l2737h:
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2737	dd 35 07 level 4
	jr nz,l2752h		;273a	20 16 	  . 
	inc (ix + ENEMY_FRAME_COUNTER_IDX)		;273c	dd 34 07
	call IS_THOMAS_MOVING		;273f	cd 87 28 	. . ( 
	jr nz,l27b0h		;2742	20 6c 	  l 
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;2744	dd 36 07 07 level 4
	dec (ix + ENEMY_FRAME_IDX)		;2748	dd 35 06
	jp p,l2752h		;274b	f2 52 27 	. R ' 
	ld (ix + ENEMY_FRAME_IDX), 3	;274e	dd 36 06 03
l2752h:
	ld hl,(THOMAS_POSITION)		;2752	2a 12 e7 	* . . 
	ld e,(ix + ENEMY_FRAMESEQ_PTR_L_IDX)		;2755	dd 5e 0c
	ld d,(ix + ENEMY_FRAMESEQ_PTR_H_IDX)	;2758	dd 56 0d
	sbc hl,de		;275b	ed 52 	. R 
	ex de,hl			;275d	eb

	bit ENEMY_MOVE_RIGHT_BIT,(ix + ENEMY_PROPS_IDX)		;275e	dd cb 00 76 	. . . v 
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
	ld (ix + ENEMY_POS_L_IDX),e		;277b	dd 73 02
	ld (ix + ENEMY_POS_H_IDX),d		;277e	dd 72 03
	jp l1be2h		;2781	c3 e2 1b 	. . . 
	call l1be2h		;2784	cd e2 1b 	. . . 
	call IS_THOMAS_MOVING		;2787	cd 87 28 	. . ( 
	jr z,l27a3h		;278a	28 17 	( . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)	;278c	dd 35 07 level 4
	ret nz			;278f	c0 	. 
	ld a,(ix + ENEMY_ATTACK_STEP_IDX)		;2790	dd 7e 0e level 4
	and a			;2793	a7 	. 
	jp z,l2575h		;2794	ca 75 25 	. u % 
	jp m,l2592h		;2797	fa 92 25 	. . % 
	add a,(ix + ENEMY_FRAME_IDX)		;279a	dd 86 06
	ld (ix + ENEMY_FRAME_IDX),a	    	;279d	dd 77 06
	jp l2563h		;27a0	c3 63 25 	. c % 
l27a3h:
	ld (ix + ENEMY_FRAME_IDX), 0	;27a3	dd 36 06 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 2	;27a7	dd 36 07 02 level 4
	ld (ix + ENEMY_STATE_IDX),  11	;27ab	dd 36 01 0b
	ret			;27af	c9 	. 
l27b0h:
	ld (ix + ENEMY_STATE_IDX), 12	;27b0	dd 36 01 0c
	call l2592h		;27b4	cd 92 25 	. . % 
	jp l1be2h		;27b7	c3 e2 1b 	. . . 
	call l1be2h		;27ba	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;27bd	dd 35 07
	ret nz			                        ;27c0	c0
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 8	;27c1	dd 36 07 08
	inc (ix + ENEMY_FRAME_IDX)		;27c5	dd 34 06 	. 4 . 
	ld a,(ix + ENEMY_FRAME_IDX)		;27c8	dd 7e 06 	. ~ . 
	cp 022h		;27cb	fe 22 	. " 
	ret nz			;27cd	c0 	. 
	ld hl, 395		;27ce	21 8b 01 	! . . 
	ld (REPLICA_APPEAR_COUNTER),hl		;27d1	22 f8 e2
    ; Set enemy is dead
	ld (ix + ENEMY_PROPS_IDX), 0	;27d4	dd 36 00 00
	ld hl,0e701h		            ;27d8	21 01 e7
	res ENEMY_IS_ALIVE_BIT, (hl)		                ;27db	cb a6 Set enemy is not alive
	jr l283dh		                ;27dd	18 5e
l27dfh:
    ; Set Thomas is frozen
	ld hl,THOMAS_PROPS	;27df	21 00 e7
	set 0,(hl)		;27e2	cb c6
	ld a,(TBL_REPLICA + ENEMY_PROPS_IDX)		;27e4	3a e8 e2 	: . . 
    ; Check bit ENEMY_IS_ALIVE_BIT: enemy is alive
	and 1 << ENEMY_IS_ALIVE_BIT		;27e7	e6 10
	jr z,l284fh		;27e9	28 64 Get out if enemy is dead
	push ix		;27eb	dd e5 	. . 
	ld ix,TBL_ENEMIES		;27ed	dd 21 d8 e2 	. ! . . 
	call MAGICIAN_REPLICA_APPEARS_OR_DISAPPEARS_STATE		;27f1	cd 7e 28 	. ~ ( 
	ld (ix + FRAME_COUNTER_IDX + 16), 8	            ;27f4	dd 36 17 08
	ld (ix + CURRENT_FRAME_IDX + 16), 26	        ;27f8	dd 36 16 1a
	ld (ix + ENEMY_STATE_IDX + 16), 10    ;27fc	dd 36 11 0a
l2800h:
	pop ix		;2800	dd e1 	. . 
	ret			;2802	c9 	. 
	call l1be2h		;2803	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2806	dd 35 07
	ret nz			                            ;2809	c0
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 8		;280a	dd 36 07 08
	inc (ix + ENEMY_FRAME_IDX)		    ;280e	dd 34 06
	ld a,(ix + ENEMY_FRAME_IDX)		    ;2811	dd 7e 06
	cp 38		                                ;2814	fe 26
	ret nz			;2816	c0 	. 
	ld hl, 282		;2817	21 1a 01 	! . . 
	ld (REPLICA_APPEAR_COUNTER),hl		;281a	22 f8 e2 	" . . 
	call l27a3h		;281d	cd a3 27 	. . ' 
	call l283dh		;2820	cd 3d 28 	. = ( 
	ld a,r		;2823	ed 5f 	. _ 
	and 001h		;2825	e6 01 	. . 
	ret z			;2827	c8 	. 
	ld (ix + ENEMY_STATE_IDX - 16), 11		;2828	dd 36 f1 0b Magician and...
	ld (ix + ENEMY_STATE_IDX), 0	;282c	dd 36 01 00 Replica!
	ld hl,0		;2830	21 00 00 	! . . 
	ld de,(0e2f4h)		;2833	ed 5b f4 e2 	. [ . . 
	sbc hl,de		;2837	ed 52 	. R 
	ld (ENEMY_FRAMESEQ_PTR),hl		;2839	22 e4 e2 	" . . 
	ret			;283c	c9 	. 
l283dh:
    ; Weird negative addressing here.
    ; It sets the base address to TBL_REPLICA and uses negative indices to
    ; access TBL_ENEMIES.
    ;
    ; Probably because IX is addressing the replica and it wants to
    ; access the true magician.
	ld (ix + ENEMY_FRAME_IDX - 16), 0		    ;283d	dd 36 f6 00
	ld (ix + ENEMY_FRAME_COUNTER_IDX - 16), 2	;2841	dd 36 f7 02
	ld (ix + ENEMY_STATE_IDX - 16), 0		    ;2845	dd 36 f1 00
    ; Set Thomas is not frozen
	ld hl,THOMAS_PROPS	;2849	21 00 e7
	res 0,(hl)		;284c	cb 86
	ret			;284e	c9 	. 
l284fh:
	ld de,(0e80ah)		;284f	ed 5b 0a e8 	. [ . . 
	ld hl,0fd60h		;2853	21 60 fd 	! ` . 
	add hl,de			;2856	19 	. 
	jr c,l285ch		;2857	38 03 	8 . 
	ld de,l02a0h		;2859	11 a0 02 	. . . 
l285ch:
	ld hl,(THOMAS_POSITION)		;285c	2a 12 e7
	ld (0e2f4h),de		;285f	ed 53 f4 e2
	sbc hl,de		    ;2863	ed 52
    ; It arrives here only when the replica appears
    
    ; The programmer preferred to index ENEMY_POS_L_IDX this way instead of
    ; ld (ix + ENEMY_POS_L_IDX  + 16).
	ld (TBL_REPLICA + ENEMY_POS_L_IDX),hl		;2865	22 ea e2
	ld hl,05000h		;2868	21 00 50
	ld (0e2ech),hl		;286b	22 ec e2
    ; 0x50 = enemy looks right and he's alive
	ld (ix + ENEMY_PROPS_IDX  + 16), (1 << ENEMY_IS_ALIVE_BIT) | (1 << 6)	;286e	dd 36 10 Replica appears
	ld (ix + FRAME_COUNTER_IDX + 16), 8		;2872	dd 36 17 08 	. 6 . . 
	ld (ix + CURRENT_FRAME_IDX + 16), 30	;2876	dd 36 16 1e 	. 6 . . 
	ld (ix + ENEMY_STATE_IDX + 16), 9		;287a	dd 36 11 09 	. 6 . .

; Update state and frame of replica (only at level 4) when the
; replica appears.
MAGICIAN_REPLICA_APPEARS_OR_DISAPPEARS_STATE:
	ld (ix + ENEMY_STATE_IDX), 8	;287e	dd 36 01 08     8: enemy stops and replica appears/disappears
	ld (ix + ENEMY_FRAME_IDX), 26	;2882	dd 36 06 1a
	ret			;2886	c9 	. 

; Sets Z if Thomas is moving (or in THOMAS_STATE_UNKNOWN).
IS_THOMAS_MOVING:
	ld a,(THOMAS_STATE)		;2887	3a 02 e7 	: . . 
	cp THOMAS_STATE_WALKING		;288a	fe 01 	. . 
	ret z			;288c	c8 	. 
	cp THOMAS_STATE_JUMPING_AHEAD		;288d	fe 09 	. . 
	ret z			;288f	c8 	. 
	cp THOMAS_STATE_UNKNOWN		;2890	fe 0a 	. . 
	ret			;2892	c9 	. 

l2893h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2893	2a 0c e8 	* . . 
	ld de,0e800h		;2896	11 00 e8 	. . . 
	add hl,de			;2899	19 	. 
	ld hl,0e197h		;289a	21 97 e1 	! . . 
	ld de,0e198h		;289d	11 98 e1 	. . . 
	jr nc,l28aah		;28a0	30 08
	ld a,(TBL_REPLICA + ENEMY_PROPS_IDX)	;28a2	3a e8 e2
    ; Check if enemy is alive
	and 1 << ENEMY_IS_ALIVE_BIT		;28a5	e6 10 	. . 
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
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;28be	2a 0c e8 	* . . 
	ld de,0fe60h		;28c1	11 60 fe 	. ` . 
	add hl,de			;28c4	19 	. 
	ret nc			;28c5	d0 	. 
	ld hl,l28cch		;28c6	21 cc 28 	! . ( 
	jp CHECK_VAL_HL_PLUS_B_0XFF		;28c9	c3 18 1b 	. . . 
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
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7	;2907	dd 36 07 07
	ld (ix + ENEMY_STATE_IDX), 0		    ;290b	dd 36 01 00
	ld (ix + ENEMY_FRAME_IDX), 0		    ;290f	dd 36 06 00
	ret			                            ;2913	c9
l2914h:
	call CHECK_AND_UPDATE_MR_X_FRAME		;2914	cd 3c 29 	. < ) 
	call ENEMY_ADVANCE_POSITION		;2917	cd 70 1c 	. p . 
	call l1be2h		;291a	cd e2 1b 	. . . 
	ld de,0f760h		;291d	11 60 f7 	. ` . 
	add hl,de			;2920	19 	. 
	jr c,l2907h		;2921	38 e4 	8 . 
l2923h:
	ld de,M62_SPRITERAM		;2923	11 00 c0 	. . . 
	ld hl,(ENEMY_POS)		;2926	2a da e2 	* . . 
	add hl,de			;2929	19 	. 
	jp c,l1f50h		;292a	da 50 1f 	. P . 
	jr l2965h		;292d	18 36 	. 6 
l292fh:
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 9 ;292f	dd 36 07 09 level 5
	ld (ix + ENEMY_FRAME_IDX), 4		 ;2933	dd 36 06 04
l2937h:
	ld (ix + ENEMY_STATE_IDX), 6	;2937	dd 36 01 06
	ret			;293b	c9 	. 

; Check and update Mr. X frame at level 5
CHECK_AND_UPDATE_MR_X_FRAME:
    ; Check if it's time to update the frame of Mr. X
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;293c	dd 35 07
	jr nz,l2952h		                    ;293f	20 11 Exit if no frame update needed.
    
    ; We need to update the frame
    
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 9	;2941	dd 36 07 09 Reset frame counter

	ld a,(ix + ENEMY_FRAME_IDX)		;2945	dd 7e 06
	inc a		                    ;2948	3c

    ; A = ENEMY_FRAME_IDX + 1;
    ; if A == 5:
    ;     ENEMY_FRAME_IDX = 5
    ; else:
    ;     ENEMY_FRAME_IDX = 4
    
	cp 5		                    ;2949	fe 05
	jr z,l294fh		                ;294b	28 02
	ld a, 4		                    ;294d	3e 04
l294fh:
	ld (ix + ENEMY_FRAME_IDX),a		;294f	dd 77 06
l2952h:
	ld de, 18  		                ;2952	11 12 00
	ret			                    ;2955	c9

    ; Unused code?
	call l1be2h		;2956	cd e2 1b 	. . . 
	ld de,0f760h		;2959	11 60 f7 	. ` . 
	add hl,de			;295c	19 	. 
	ld a,004h		;295d	3e 04 	> . 
	jr nc,l2962h		;295f	30 01 	0 . 
	xor a			;2961	af 	. 
l2962h:
	ld (ix + ENEMY_FRAME_IDX),a		;2962	dd 77 06 	. w . 
l2965h:
	call sub_2ba0h		;2965	cd a0 2b 	. . + 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2968	2a 0c e8
	ld de,0fb80h		;296b	11 80 fb 	. . . 
	add hl,de			;296e	19 	. 
	ret c			;296f	d8 	. 
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)	;2970	dd 7e 08 level 5
	and a			;2973	a7 	. 
	jp nz,l2ae9h		;2974	c2 e9 2a 	. . * 
l2977h:
	ld (ix + ENEMY_FRAME_IDX), 4		;2977	dd 36 06 04
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)	;297b	2a 0c e8
	ld de,0fd00h		;297e	11 00 fd 	. . . 
	add hl,de			;2981	19 	. 
	jr nc,l29a0h		;2982	30 1c 	0 . 
	ld a,(0e1aah)		;2984	3a aa e1 	: . . 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a	;2987	dd 77 07 level 5
	ld (ix + ENEMY_STATE_IDX), 7    ;298a	dd 36 01 07
	ret			;298e	c9 	. 
	ld de,(0e1abh)		;298f	ed 5b ab e1 	. [ . . 
	call ENEMY_ADVANCE_POSITION		;2993	cd 70 1c 	. p . 
	call l1be2h		;2996	cd e2 1b 	. . . 
	call sub_2ba0h		;2999	cd a0 2b 	. . + 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;299c	dd 35 07 level 5
	ret nz			;299f	c0
l29a0h:
	call sub_2ce8h		;29a0	cd e8 2c 	. . , 
l29a3h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;29a3	2a 0c e8 	* . . 
	ld de,0fc80h		;29a6	11 80 fc 	. . . 
	add hl,de			;29a9	19 	. 
	jp c,l2a55h		;29aa	da 55 2a 	. U * 
	ld a,(EXT_RANDOM + 1)		;29ad	3a 11 e0 	: . . 
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
	ld (ix + ENEMY_FRAME_IDX),b		;29c0	dd 70 06
	ld (ix + ENEMY_FRAME_COUNTER_IDX),5		;29c3	dd 36 07 05 level 5
	ld (ix + ENEMY_ATTACK_STEP_IDX), 5		;29c7	dd 36 0e 05 level 5
	ret			;29cb	c9 	. 
	call l1be2h		;29cc	cd e2 1b 	. . . 
	call sub_2ba0h		;29cf	cd a0 2b 	. . + 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;29d2	dd 35 07 level 5
	ret nz			;29d5	c0 	. 
	dec (ix + ENEMY_ATTACK_STEP_IDX)		;29d6	dd 35 0e level 5
	jr z,l2a3dh		;29d9	28 62 	( b 
	jp m,l29a3h		;29db	fa a3 29 	. . ) 
	ld a,(ix + ENEMY_ATTACK_STEP_IDX)		;29de	dd 7e 0e level 5
	cp 3		                            ;29e1	fe 03
	jr nz,l2a2ch		;29e3	20 47 	  G 
	ld a,(ix + ENEMY_FRAME_IDX)	;29e5	dd 7e 06
	cp 12		                ;29e8	fe 0c
	ld hl,l2a73h		;29ea	21 73 2a 	! s * 
	jr c,l29f7h		;29ed	38 08 	8 . 
	ld hl,l2a7ah		;29ef	21 7a 2a 	! z * 
	jr z,l29f7h		;29f2	28 03 	( . 
	ld hl,02a81h		;29f4	21 81 2a 	! . * 
l29f7h:
	ld a,(ix + ENEMY_POS_L_IDX)		;29f7	dd 7e 02
	add a,(hl)			;29fa	86 	. 
	inc hl			;29fb	23 	# 
	ld e,a			;29fc	5f 	_ 
	ld a,(ix + ENEMY_POS_H_IDX)		;29fd	dd 7e 03 	. ~ . 
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
	ld de,0016h+2		;2a26	11 18 00 	. . . 
	call l2c95h		;2a29	cd 95 2c 	. . , 
l2a2ch:
	inc (ix + ENEMY_FRAME_IDX)		  ;2a2c	dd 34 06
	ld e,(ix + ENEMY_ATTACK_STEP_IDX) ;2a2f	dd 5e 0e
	ld d, 0		        ;2a32	16 00
	ld hl,l2a87h		;2a34	21 87 2a 	! . * 
	add hl,de			;2a37	19 	. 
	ld a,(hl)			;2a38	7e 	~ 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;2a39	dd 77 07 level 5
	ret			;2a3c	c9 	. 
l2a3dh:
	dec (ix + ENEMY_STEADY_COUNTER_IDX)		;2a3d	dd 35 0b level 5
	jr z,l2a55h		;2a40	28 13
	ld a,(0e012h)		;2a42	3a 12 e0
	ld hl,0e1a5h		;2a45	21 a5 e1
	call sub_1214h		;2a48	cd 14 12
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;2a4b	dd 77 07 level 5
	ret			        ;2a4e	c9 	. 
l2a4fh:
	ld hl,05000h		;2a4f	21 00 50 	! . P 
	ld (0e2dch),hl		;2a52	22 dc e2 	" . . 
l2a55h:
	ld (ix + ENEMY_FRAME_IDX), 4	;2a55	dd 36 06 04
	ld hl,(ENEMY_POS)		;2a59	2a da e2 	* . . 
	ld de,0fe00h		;2a5c	11 00 fe 	. . . 
	add hl,de			;2a5f	19 	. 
	ld de,(0e104h)		;2a60	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2a64	ed 52 	. R 
	jr c,l2ad9h		;2a66	38 71 	8 q 
	ld (ix + ENEMY_STATE_IDX),8 	;2a68	dd 36 01 08
	ld a,(0e1aah)		;2a6c	3a aa e1 	: . . 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a		;2a6f	dd 77 07 level 5
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
	add hl,hl			;2a8e	29
	call ENEMY_GO_BACK_POSITION		;2a8f	cd 7a 1c
	call sub_2ab6h		;2a92	cd b6 2a
	call sub_2ba0h		;2a95	cd a0 2b
	ld a,(ix + ENEMY_MOVE_COUNTER_L_IDX)		;2a98	dd 7e 08 level 5
	and a			;2a9b	a7
	jp z,l2977h		;2a9c	ca 77 29
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2a9f	2a 0c e8
	ld de,0fb00h		;2aa2	11 00 fb 	. . . 
	add hl,de			;2aa5	19 	. 
	jp c,l2937h		;2aa6	da 37 29 	. 7 ) 
	ld hl,(ENEMY_POS)		;2aa9	2a da e2 	* . . 
	ld de,(0e104h)		;2aac	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2ab0	ed 52 	. R 
	jp c,l2977h		;2ab2	da 77 29 	. w ) 
	ret			;2ab5	c9 	. 
sub_2ab6h:
	ld hl,(ENEMY_POS)		;2ab6	2a da e2 	* . . 
	ld de,(0e104h)		;2ab9	ed 5b 04 e1 	. [ . . 
	sbc hl,de		;2abd	ed 52 	. R 
	jr nc,l2ac5h		;2abf	30 04 	0 . 
	ld (ENEMY_POS),de		;2ac1	ed 53 da e2 	. S . . 
l2ac5h:
	jp l1be2h		;2ac5	c3 e2 1b 	. . . 
	ld de,(0e1abh)		;2ac8	ed 5b ab e1 	. [ . . 
	call ENEMY_GO_BACK_POSITION		;2acc	cd 7a 1c 	. z . 
	call sub_2ab6h		;2acf	cd b6 2a 	. . * 
	call sub_2ba0h		;2ad2	cd a0 2b 	. . + 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2ad5	dd 35 07 level 5
	ret nz			;2ad8	c0 	. 
l2ad9h:
	ld a,(0e012h)		;2ad9	3a 12 e0 	: . . 
	ld hl,0e1a0h		;2adc	21 a0 e1 	! . . 
	call sub_1214h		;2adf	cd 14 12 	. . . 
	ld (ix + ENEMY_MOVE_COUNTER_L_IDX),a	;2ae2	dd 77 08 level 5
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 9	;2ae5	dd 36 07 09 level 5
l2ae9h:
	ld (ix + ENEMY_STATE_IDX), 5    ;2ae9	dd 36 01 05
	ret			;2aed	c9 	. 
    ; Question: unused code here?
	call l1be2h		;2aee	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2af1	dd 35 07 level 5
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
	ld (ix + ENEMY_FRAME_IDX),a	;2b04	dd 77 06
	ld a,b			;2b07	78 
	cp 3		    ;2b08	fe 03
	jr z,l2b10h		;2b0a	28 04
	xor a			;2b0c	af
	ld (0e2d6h),a		;2b0d	32 d6 e2 	2 . . 
l2b10h:
	ld hl,l2c69h		;2b10	21 69 2c 	! i , 
	call APPLY_FRAMESEQ_FROM_HL		;2b13	cd 96 1b 	. . . 
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_UNKNOWN_TABLE		;2b16	21 67 2d 	! g - 
	ld de,0xde		;2b19	11 de 00 	. . . 
	call DECREASE_ENEMY_ENERGY_UPKICK		;2b1c	cd 19 2d 	. . - 
	ld a,00bh		;2b1f	3e 0b 	> . 
	jp c,l247ah		;2b21	da 7a 24 	. z $ 
	inc (ix + ENEMY_STATE_IDX)	;2b24	dd 34 01
	ret			;2b27	c9 	. 
l2b28h:
	call l1be2h		;2b28	cd e2 1b 	. . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2b2b	dd 35 07 level 5
	jp z,l2a55h		;2b2e	ca 55 2a 	. U * 
	ret			;2b31	c9 	. 
	call l1be2h		;2b32	cd e2 1b 	. . . 
	ld hl,0e2d7h		;2b35	21 d7 e2 	! . . 
	ld a,(hl)			;2b38	7e 	~ 
	and a			;2b39	a7 	. 
	jr nz,l2b4eh		;2b3a	20 12 	  . 
	ld a,(ENEMY_FRAME)		;2b3c	3a de e2 	: . . 
	cp 01eh		;2b3f	fe 1e 	. . 
	jr nz,l2b4eh		;2b41	20 0b 	  . 
	ld (hl),001h		;2b43	36 01 	6 . 
	ld hl,06000h		;2b45	21 00 60 	! . ` 
	ld de,0016h+2		;2b48	11 18 00 	. . . 
	call l2c95h		;2b4b	cd 95 2c 	. . , 
l2b4eh:
	ld hl,(ENEMY_FRAMESEQ_PTR)		;2b4e	2a e4 e2 	* . . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;2b51	dd 35 07 level 5
	jr nz,l2b6ah		;2b54	20 14 	  . 
	inc hl			;2b56	23 	# 
	inc hl			;2b57	23 	# 
	ld a,(hl)			;2b58	7e 	~ 
	cp 0ffh		;2b59	fe ff 	. . 
	jp z,l2a4fh		;2b5b	ca 4f 2a 	. O * 
	ld (ix + ENEMY_FRAME_IDX),a	;2b5e	dd 77 06
	inc hl			                ;2b61	23
	ld a,(hl)			            ;2b62	7e
	ld (ix + ENEMY_FRAME_COUNTER_IDX),a	;2b63	dd 77 07
	inc hl			;2b66	23 	# 
	ld (ENEMY_FRAMESEQ_PTR),hl		;2b67	22 e4 e2 	" . . 
l2b6ah:
	ld a,(hl)			;2b6a	7e 	~ 
	add a,(ix + 4)		;2b6b	dd 86 04 	. . . 
	ld (ix + 4),a		;2b6e	dd 77 04 	. w . 
	inc hl			;2b71	23 	# 
	ld a,(hl)			;2b72	7e 	~ 
	adc a,(ix + 5)		;2b73	dd 8e 05 	. . . 
	ld (ix + 5),a		;2b76	dd 77 05 	. w . 
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
	call CHECK_VAL_HL_PLUS_B_0XFF		;2ba7	cd 18 1b 	. . . 
	ret nc			;2baa	d0 	. 
	ld b,a			;2bab	47 	G 
	ld e,(ix + ENEMY_FRAME_IDX)		;2bac	dd 5e 06
	ld d, 0		                    ;2baf	16 00
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
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 5	 ;2be5	dd 36 07 05 level 5
	ld (ix + ENEMY_STATE_IDX), 10    ;2be9	dd 36 01 0a
	ld (ix + ENEMY_FRAME_IDX), 23    ;2bed	dd 36 06 17
	ld a,(DRAGONS_LEVEL)		;2bf1	3a 80 e0 	: . . 
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
	ld (ENEMY_FRAMESEQ_PTR),hl		;2c13	22 e4 e2 	" . . 
	ret			;2c16	c9 	. 
l2c17h:
	ld a,015h		;2c17	3e 15 	> . 
	jr l2c1dh		;2c19	18 02 	. . 
l2c1bh:
	ld a,016h		;2c1b	3e 16 	> . 
l2c1dh:
	ld (ix + ENEMY_FRAME_IDX),a	;2c1d	dd 77 06
	ld (ix + ENEMY_STATE_IDX), 9	;2c20	dd 36 01 09
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 11	;2c24	dd 36 07 0b
	ld a,091h		;2c28	3e 91 	> . 
	call PLAY_SOUND		;2c2a	cd fe 0d 	. . . 
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

; SEGUIR, easy function
sub_2c78h:
	ld a,(DRAGONS_LEVEL)		;2c78	3a 80 e0 	: . . 
	and 0fch		;2c7b	e6 fc 	. . 
	ret nz			;2c7d	c0 	. 

sub_2c7eh:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2c7e	2a 0c e8 	* . . 
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
	call PLAY_SOUND		;2c97	cd fe 0d 	. . . 
sub_2c9ah:
	ld a,(ENERGY)		;2c9a	3a 09 e7 	: . . 
	sub e			;2c9d	93 	. 
	jp p,l2cb6h		;2c9e	f2 b6 2c 	. . , 
	call CHECK_DEMO_OR_VULNERABLE		;2ca1	cd 08 12 	. . . 
	jr nz,l2cb6h		;2ca4	20 10 	  . 
	ld a,(DRAGONS_LEVEL)		;2ca6	3a 80 e0 	: . . 
	and 007h		;2ca9	e6 07 	. . 
	cp 002h		;2cab	fe 02 	. . 
	ld a,004h		;2cad	3e 04 	> . 
	jr nz,l2cb3h		;2caf	20 02 	  . 
	ld a,005h		;2cb1	3e 05 	> . 
l2cb3h:
	ld (0e007h),a		;2cb3	32 07 e0 	2 . . 
l2cb6h:
	jp STORE_DAMAGE_ORIGIN_AND_AMOUNT		;2cb6	c3 e2 2e 	. . . 

; SEGUIR
sub_2cb9h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2cb9	2a 0c e8 	* . . 
	ld de,0f760h		;2cbc	11 60 f7 	. ` . 
	add hl,de			;2cbf	19 	. 
	ld hl,THOMAS_PROPS		;2cc0	21 00 e7 	! . . 
	res 4,(hl)		;2cc3	cb a6 	. . 
	ret c			;2cc5	d8 	. 
	ld a,(ix + ENEMY_STATE_IDX)		;2cc6	dd 7e 01
	cp 001h		;2cc9	fe 01 	. . 
	ret z			;2ccb	c8 	. 
	ld a,(TBL_GUYS_LEN)		;2ccc	3a 61 e2 	: a . 
	and a			;2ccf	a7 	. 
	ret nz			;2cd0	c0 	. 
	set 4,(hl)		;2cd1	cb e6 	. . 
	ret			;2cd3	c9 	. 

; Check if the replica should appear/disappear now.
; The replica basically can appear/disappear when REPLICA_APPEAR_COUNTER != 0 and
; THOMAS_STATE not in (THOMAS_STATE_JUMPING_AHEAD, THOMAS_STATE_UNKNOWN).
;
; Used in level 4 when fighting against the magician.
; Output: Z flag active if the replica can appear now.
CAN_REPLICA_APPEAR:
	ld hl,(REPLICA_APPEAR_COUNTER)	;2cd4	2a f8 e2
	ld a,l			                ;2cd7	7d
	or h			                ;2cd8	b4
	ret nz			                ;2cd9	c0 Get out if REPLICA_APPEAR_COUNTER != 0
    
    
	ld a,(THOMAS_STATE)		        ;2cda	3a 02 e7
	cp THOMAS_STATE_JUMPING_AHEAD	;2cdd	fe 09
	jr z,l2ce6h		                ;2cdf	28 05
	cp THOMAS_STATE_UNKNOWN		    ;2ce1	fe 0a
	jr z,l2ce6h		                ;2ce3	28 01
	ld a,h			                ;2ce5	7c
l2ce6h:
	and a			                ;2ce6	a7
	ret			                    ;2ce7	c9

;SEGUIR
sub_2ce8h:
	ld a,(EXT_RANDOM)		;2ce8	3a 10 e0 	: . . 
	ld hl, TBL_E19C		;2ceb	21 9c e1 	! . . 
	ld b,001h		;2cee	06 01 	. . 
	cp (hl)			;2cf0	be 	. 
	jr c,l2cf9h		;2cf1	38 06 	8 . 
	inc hl			;2cf3	23 	# 
	inc b			;2cf4	04 	. 
	cp (hl)			;2cf5	be 	. 
	jr c,l2cf9h		;2cf6	38 01 	8 . 
	inc b			;2cf8	04 	. 
l2cf9h:
	ld (ix + ENEMY_STEADY_COUNTER_IDX),b	;2cf9	dd 70 0b level 1
	ld (ix + ENEMY_STATE_IDX), 4	        ;2cfc	dd 36 01 04
	ret			;2d00	c9 	. 

; SEGUIR
sub_2d01h:
	push hl			;2d01	e5 	. 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;2d02	2a 0c e8 	* . . 
	ld de,0ee00h		;2d05	11 00 ee 	. . . 
	add hl,de			;2d08	19 	. 
	pop hl			;2d09	e1 	. 
	ret nc			;2d0a	d0 	. 
	pop af			;2d0b	f1 	. 
	ret			;2d0c	c9 	. 

sub_2d0dh:
	ld de,001bh		;2d0d	11 1b 00 	. . . 
	jp l1beah		;2d10	c3 ea 1b 	. . . 
sub_2d13h:
	ld de,001bh		;2d13	11 1b 00 	. . . 
	jp l1bf2h		;2d16	c3 f2 1b 	. . . 

; Decreases the energy of the enemy depending on the attack Thomas
; performed. To determine the attack type, it checks THOMAS_FRAME.
; It also makes the enemy groan.
; ENEMY_ENERGY -= (HL0 + (BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME))
DECREASE_ENEMY_ENERGY_UPKICK:
	; Enemy groans
    ld a,083h		    ;2d19	3e 83
	call PLAY_SOUND		;2d1b	cd fe 0d
    ;
	ld a,091h		    ;2d1e	3e 91
	call PLAY_SOUND		;2d20	cd fe 0d

	push de			        ;2d23	d5 	. 
	ld a,(THOMAS_FRAME)		;2d24	3a 06 e7    A = THOMAS_FRAME

	push hl			        ;2d27	e5
	ld hl,BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE		    ;2d28	21 42 2d    HL = 0x2d42. ToDo: what is this table?
	ld e,a			        ;2d2b	5f
	ld d,000h		        ;2d2c	16 00       DE = THOMAS_FRAME
	add hl,de			    ;2d2e	19          HL = BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME
	ld e,(hl)			    ;2d2f	5e          E = (BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME)
	pop hl			        ;2d30	e1

	add hl,de			    ;2d31	19          HL = HL0 + (BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME) (we assume D=0)
	ld a,(ENEMY_ENERGY)		;2d32	3a e2 e2    A = ENEMY_ENERGY
	sub (hl)			    ;2d35	96          A = ENEMY_ENERGY - (HL0 + (BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME))
	ld (ENEMY_ENERGY),a		;2d36	32 e2 e2 	ENEMY_ENERGY = ENEMY_ENERGY - (HL0 + (BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE + THOMAS_FRAME))
	pop de			        ;2d39	d1
	ret nc			        ;2d3a	d0
    
    ; Enemy yells defeated
	ld a,087h		        ;2d3b	3e 87
	call PLAY_SOUND		    ;2d3d	cd fe 0d
	scf			            ;2d40	37
	ret			            ;2d41	c9

BOSS_ENERGY_UPKICK_DECREASE_BASE_TABLE:
    defb 0, 0, 0, 0, 0, 0, 0
    defb 2, 0, 1, 1, 0, 2, 0
    defb 1, 1, 0, 0, 0, 0, 0
    defb 1, 1, 0, 3, 3
    defb 0, 0, 0, 0, 0, 0, 0
    defb 0, 0, 0, 0

; ToDo: when is this read?
; It didn't activate the breakpoint "wp 2d67,1,r"
BOSS_ENERGY_UPKICK_DECREASE_UNKNOWN_TABLE:
    defb 0, 16, 12

; Upkick, boss 1, 5
BOSS_ENERGY_UPKICK_DECREASE_BOSSES_1_5_TABLE: ; 2d6a
    defb 32, 12, 8

; Upkick, boss 3
BOSS_ENERGY_UPKICK_DECREASE_BOSS_3_TABLE:
    defb 24, 16, 16

; Upkick, boss 2
BOSS_ENERGY_UPKICK_DECREASE_BOSS_2_TABLE:
    defb 32, 16
    
    
; This part was incorrectly disassembled by z80dasm.
; It's normal, since it followed a table.
; Do it manually with
; tail -c +11631 a.bin > dela.bin && z80dasm -g11630 -l -t dela.bin |less
sub_2d72h:
    ld hl,0e32bh            ;2d72   21 2b e3        ! + .
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
	ld de,0x00d2		;2d83	11 d2 00 	. . . 
l2d86h:
	bit 4,c		;2d86	cb 61 	. a 
	jr z,l2d91h		;2d88	28 07 	( . 
	push hl			;2d8a	e5 	. 
	ld hl,0x0018		;2d8b	21 18 00 	! . . 
	add hl,de			;2d8e	19 	. 
	ex de,hl			;2d8f	eb 	. 
	pop hl			;2d90	e1 	. 
l2d91h:
	ld (KNIFE_STATUS),de		;2d91	ed 53 07 e8 	. S . . 
	inc hl			;2d95	23 	# 
	ld e,(hl)			;2d96	5e 	^ 
	push hl			;2d97	e5 	. 
	inc hl			;2d98	23 	# 
	ld d,(hl)			;2d99	56 	V 
	ld a,(THOMAS_PROPS)		;2d9a	3a 00 e7 	: . . 
	ld hl,(0e1f7h)		;2d9d	2a f7 e1 	* . . 
	bit 6,c		;2da0	cb 71 	. q 
	jr z,l2dbeh		;2da2	28 1a 	( . 
	ex de,hl			;2da4	eb 	. 
	bit 1,a		;2da5	cb 4f 	. O 
	jr nz,l2daah		;2da7	20 01 	  . 
	add hl,de			;2da9	19 	. 
l2daah:
	push hl			;2daa	e5 	. 
	ld de,(THOMAS_POSITION)		;2dab	ed 5b 12 e7 	. [ . . 
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
	ld de,(THOMAS_POSITION)		;2dc8	ed 5b 12 e7 	. [ . . 
	sbc hl,de		;2dcc	ed 52 	. R 
	ld (0e80ah),hl		;2dce	22 0a e8 	" . . 
	jr nc,l2ddch		;2dd1	30 09 	0 . 
	ld de,0x1000		;2dd3	11 00 10 	. . . 
	add hl,de			;2dd6	19 	. 
	jr nc,l2e1ah		;2dd7	30 41 	0 A 
l2dd9h:
	ld hl,(0e80ah)		;2dd9	2a 0a e8 	* . . 
l2ddch:
	bit 1,a		;2ddc	cb 4f 	. O 
	jr nz,l2df0h		;2dde	20 10 	  . 
	bit 4,c		;2de0	cb 61 	. a 
	jr nz,l2df0h		;2de2	20 0c 	  . 
	ld de,0x60		;2de4	11 60 00 	. ` . 
	add hl,de			;2de7	19 	. 
	ld de,0x00c0		;2de8	11 c0 00 	. . . 
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
	ld hl,NUM_KNIVES		;2e1a	21 2b e3 	! + . 
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
	ld a,(THOMAS_STATE)		;2e42	3a 02 e7 	: . . 
	cp THOMAS_STATE_DOWN_KICK		;2e45	fe 06 	. . 
	ret z			;2e47	c8 	. 
	cp THOMAS_STATE_DOWN_PUNCH		;2e48	fe 07 	. . 
	ret z			;2e4a	c8 	. 
	ld a,(THOMAS_FRAME)		;2e4b	3a 06 e7 	: . . 
	cp THOMAS_FRAME_DOWN		;2e4e	fe 05
	ret z			;2e50	c8 	. 
	ld hl,06900h		;2e51	21 00 69 	! . i 
l2e54h:
	ld de,00118h		;2e54	11 18 01 	. . . 
	call STORE_DAMAGE_ORIGIN_AND_AMOUNT		;2e57	cd e2 2e 	. . . 
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
	ld (KNIFE_STATUS),hl		;2e7c	22 07 e8 	" . . 
	ld hl,(0e338h)		;2e7f	2a 38 e3 	* 8 . 
	ld de,(0e803h)		;2e82	ed 5b 03 e8 	. [ . . 
	add hl,de			;2e86	19 	. 
	ex de,hl			;2e87	eb 	. 
	xor a			;2e88	af 	. 
	ld hl,07484h		;2e89	21 84 74 	! . t 
	call l0e20h		;2e8c	cd 20 0e 	.   . 
	pop bc			;2e8f	c1 	. 
	ret			;2e90	c9 	. 

sub_2e91:
	ld a,(ORIGIN_OF_DAMAGE)		;2e91	3a 20 e7 	:   . 
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
	ld hl,2		;2ea8	21 02 00 	! . . 
l2eabh:
	ld (0e33dh),hl		;2eab	22 3d e3 	" = . 
	ld hl,(HEIGHT_OF_DAMAGE_TO_THOMAS)		;2eae	2a 22 e7 	* " . 
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
	ld (KNIFE_STATUS),hl		;2ecd	22 07 e8 	" . . 
	ld hl,(0e33dh)		;2ed0	2a 3d e3 	* = . 
	ld de,(0e715h)		;2ed3	ed 5b 15 e7 	. [ . . 
	add hl,de			;2ed7	19 	. 
	ex de,hl			;2ed8	eb 	. 
	xor a			;2ed9	af 	. 
	ld hl,07489h		;2eda	21 89 74 	! . t 
	call l0e20h		;2edd	cd 20 0e 	.   . 
	pop bc			;2ee0	c1 	. 
	ret			;2ee1	c9 	. 

; Store the origin and mount of the damage (i.e. Thomas is hit by a knife).
; Play groan sound.
;
; Input D: origin of damage.
;          1, knife, dragon, 3: snake, bursting ball
; Input E: amount of energy to subtract
; Input HL: height of the attacking element (for example, a knife or a dragon's fire).
;           0x5A00: low knife, 0x6900: high knife, ...
STORE_DAMAGE_ORIGIN_AND_AMOUNT:
	ld a,(THOMAS_DAMAGE_STATUS)	;2ee2	3a 1f e7
	and 1		                ;2ee5	e6 01 	. . 
	jr nz,l2efbh		        ;2ee7	20 12 Jump if Thomas is not receiving damage
    ; Thomas is receiving damage
    
    ; Store height of the attacking element
	ld (HEIGHT_OF_DAMAGE_TO_THOMAS),hl  ;2ee9	22 22 e7

    ; Set Thomas is not receiving damage
	ld hl,THOMAS_DAMAGE_STATUS	;2eec	21 1f e7
	set 0,(hl)		            ;2eef	cb c6

    ; Store origin of damage
	inc hl			            ;2ef1	23      HL = 0xE720 = ORIGIN_OF_DAMAGE
	ld (hl),d			        ;2ef2	72

    ; Set energy to subtract
	inc hl	        ;2ef3	23    HL = 0xE721 = ENERGY_TO_SUBTRACT
	ld (hl),e		;2ef4	73    Write E = amount of energy to subtract. HL = ENERGY_TO_SUBTRACT.

	ld a,083h		;2ef5	3e 83
	call PLAY_SOUND	;2ef7	cd fe 0d
	ret			    ;2efa	c9

l2efbh:
    ; It seems to reach here when Thomas receives two attacks at the same time
    ; For example, a snake and a bursting ball piece.
    
    ; ENERGY = ENERGY - E
	ld a,(ENERGY)	;2efb	3a 09 e7
	sub e			;2efe	93
	jr nc,l2f02h	;2eff	30 01 Set ENERGY = 0 if it becomes negative
	xor a			;2f01	af
l2f02h:
	ld (ENERGY),a	;2f02	32 09 e7
	ret			    ;2f05	c9

sub_2f06h:
	ld hl,POINTS_VISIBLE_COUNTER		;2f06	21 4c e6 	! L . 
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
	ld (KNIFE_STATUS),de		;2f16	ed 53 07 e8 	. S . . 
	inc hl			;2f1a	23 	# 
	ld e,(hl)			;2f1b	5e 	^ 
	inc hl			;2f1c	23 	# 
	ld d,(hl)			;2f1d	56 	V 
	inc hl			;2f1e	23 	# 
	ld c,(hl)			;2f1f	4e 	N 
	inc hl			;2f20	23 	# 
	push hl			;2f21	e5 	. 
	ld hl,(THOMAS_POSITION)		;2f22	2a 12 e7 	* . . 
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

; Add points.
; A gives the position in the table: POINTS_TABLE[A]
ADD_POINTS:
	push bc			;2f60	c5 	. 
	push de			;2f61	d5 	. 
	push hl			;2f62	e5 	. 
	ld de,0e663h		;2f63	11 63 e6 	. c . 
	ld hl,0e65dh		;2f66	21 5d e6 	! ] . 
	ld bc,0011h+1		;2f69	01 12 00 	. . . 
	lddr		;2f6c	ed b8 	. . 
	ld d,a			    ;2f6e	57
	and 07fh		    ;2f6f	e6 7f
	ld e,a			    ;2f71	5f E = 7 LSB of A
	ld (0e651h),a		;2f72	32 51 e6 	2 Q . 
	pop hl			;2f75	e1 	. 
	ld (0e64fh),hl		;2f76	22 4f e6 	" O . 
	pop hl			;2f79	e1 	. 
	ld (0e64dh),hl		;2f7a	22 4d e6 	" M . 

	ld a,0a9h		;2f7d	3e a9 	> . 
	bit 7,d		;2f7f	cb 7a Check if bit 7 of input (A) was active
	jr z,l2f85h		;2f81	28 02
	ld a,00bh		;2f83	3e 0b 	> . 
l2f85h:
	ld (POINTS_VISIBLE_COUNTER),a		;2f85	32 4c e6 	2 L . 
	ld d,000h		;2f88	16 00 	. . 
	ld hl,POINTS_TABLE		;2f8a	21 ad 2f 	! . / 
	add hl,de			;2f8d	19 	. 
	add hl,de			;2f8e	19 	. 
	ld e,(hl)			;2f8f	5e HL = POINTS_TABLE[A]
	inc hl			;2f90	23 	# 
	ld d,(hl)			;2f91	56 	V 
	call INCREMENT_DE_POINTS		;2f92	cd 9a 2f 	. . / 
	pop bc			;2f95	c1 	. 
l2f96h:
	ret			;2f96	c9 	. 

; Increments 100 points.
; This is used after completing each level, to give points according to
; the energy bar.
INCREMENT_100_POINTS:
	ld de,000fh+1		;2f97	11 10 00 	. . . 

; Increment by DE the number of points
INCREMENT_DE_POINTS:
	ld hl,POINTS	;2f9a	21 81 e0
	ld a,(hl)		;2f9d	7e
	add a,e			;2f9e	83
	daa			    ;2f9f	27
	ld (hl),a	    ;2fa0	77
	inc hl		    ;2fa1	23 Next BCD
	ld a,(hl)	    ;2fa2	7e
	adc a,d		    ;2fa3	8a
	daa			    ;2fa4	27
	ld (hl),a	    ;2fa5	77
	inc hl		    ;2fa6	23 Next BCD
	ld a,(hl)	    ;2fa7	7e
	adc a,000h	    ;2fa8	ce 00
	daa			    ;2faa	27
	ld (hl),a	    ;2fab	77
	ret			    ;2fac	c9

POINTS_TABLE:
    defw  0x20,  0x30,  0x40,  0x50,   0x60,   0x80, 0x90
    defw 0x100, 0x200, 0x300, 0x500, 0x1000, 0x0010
    
; SEGUIR
sub_2fc7h:
	ld a,(NUM_MAGICAL_ELEMENTS)	    ;2fc7	3a 81 e3
	and a			;2fca	a7
	ret z			;2fcb	c8
	ld ix,TBL_MAGICAL_ELEMENTS	;2fcc	dd 21 82 e3
    
    ; Iterate 16 elements
	ld b, 16		;2fd0	06 10
l2fd2h:
	push bc			;2fd2	c5 	. 
	ld c,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)	;2fd3	dd 4e 00
l2fd6h:
	bit ENEMY_IS_ALIVE_BIT,c		    ;2fd6	cb 61
	call nz,sub_2fe4h	;2fd8	c4 e4 2f Call if alive
	pop bc			;2fdb	c1 	. 
	ld de, 19		;2fdc	11 13 00 	. . . 
	add ix,de		;2fdf	dd 19 	. . 
	djnz l2fd2h		;2fe1	10 ef 	. . 
	ret			    ;2fe3	c9

sub_2fe4h:
	ld hl,l36e7h		;2fe4	21 e7 36 	! . 6 
	push hl			;2fe7	e5 	. 
	ld hl,l2ff7h		;2fe8	21 f7 2f 	! . / 
	ld e,(ix + MAGICAL_ELEMENT_STATE_IDX)		;2feb	dd 5e 01
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
	;call nc,0c833h		;2fff	d4 33 c8 	. 3 . 
    defb 0xd4
    defb 0x33, 0xc8
    
    
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
	call CHANGE_HEIGHT_WITH_SPEED_AND_ACCELERATION		;301f	cd 1d 37 	. . 7 
	jp c,l30cdh		;3022	da cd 30 	. . 0 
l3025h:
	call sub_3773h		;3025	cd 73 37 	. s 7 
	jp c,l331eh		;3028	da 1e 33 	. . 3 
	call sub_3746h		;302b	cd 46 37 	. F 7 
	ld a,091h		;302e	3e 91 	> . 
	jp c,l3327h		;3030	da 27 33 	. ' 3 
	dec (ix + FRAME_COUNTER_IDX)		;3033	dd 35 07 	. 5 . 
	ret nz			;3036	c0 	. 
	ld (ix + FRAME_COUNTER_IDX),003h		;3037	dd 36 07 03 	. 6 . . 
	ld a,(ix + CURRENT_FRAME_IDX) ;303b	dd 7e 06
	inc a			;303e	3c 	< 
	cp 4		    ;303f	fe 04
	jr nz,l3045h		;3041	20 02 	  . 
	ld a,002h		;3043	3e 02 	> . 
l3045h:
	ld (ix + CURRENT_FRAME_IDX),a ;3045	dd 77 06
	ret			;3048	c9 	. 
l3049h:
	call l1be2h		;3049	cd e2 1b 	. . . 
	dec (ix + FIREBALL_TIMEOUT_IDX)		;304c	dd 35 08
	jp z,l3106h		;304f	ca 06 31 	. . 1 
	ld l,(ix + MAGICAL_ELEMENT_HOR_OFFSET_L_IDX)		;3052	dd 6e 0e
	ld h,(ix + MAGICAL_ELEMENT_HOR_OFFSET_H_IDX)		;3055	dd 66 0f
	ld de,0x0020		;3058	11 20 00 	.   . 
	bit 2,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;305b	dd cb 00 56
	jr z,l306eh		;305f	28 0d 	( . 
	sbc hl,de		;3061	ed 52 	. R 
	jr nc,l307bh		;3063	30 16 	0 . 
	res 2,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3065	dd cb 00 96
	ld hl,0		;3069	21 00 00 	! . . 
	jr l307bh		;306c	18 0d 	. . 
l306eh:
	add hl,de			;306e	19 	. 
	push hl			;306f	e5 	. 
	ld de,0ff80h		;3070	11 80 ff 	. . . 
	add hl,de			;3073	19 	. 
	pop hl			;3074	e1 	. 
	jr nc,l307bh		;3075	30 04 	0 . 
	set 2,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3077	dd cb 00 d6
l307bh:
	ld (ix + MAGICAL_ELEMENT_HOR_OFFSET_L_IDX),l		;307b	dd 75 0e
	ld (ix + MAGICAL_ELEMENT_HOR_OFFSET_H_IDX),h		;307e	dd 74 0f
	ld e,(ix + MAGICAL_ELEMENT_FALL_ACCELERATION_L_IDX)	;3081	dd 5e 0a
	ld d,(ix + MAGICAL_ELEMENT_FALL_ACCELERATION_H_IDX)	;3084	dd 56 0b
	add hl,de			;3087	19 	. 
	ld (ix + MAGICAL_ELEMENT_DISTANCE_L_IDX),l		;3088	dd 75 02
	ld (ix + MAGICAL_ELEMENT_DISTANCE_H_IDX),h		;308b	dd 74 03
	ld l,(ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_L_IDX)	;308e	dd 6e 10
	ld h,(ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_H_IDX)	;3091	dd 66 11
	ld de,00049h		;3094	11 49 00 	. I . 
	bit 0,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3097	dd cb 00 46
	jr z,l30aah		;309b	28 0d 	( . 
	sbc hl,de		;309d	ed 52 	. R 
	jr nc,l30b7h		;309f	30 16 	0 . 
	res 0,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;30a1	dd cb 00 86
	ld hl,0		;30a5	21 00 00 	! . . 
	jr l30b7h		;30a8	18 0d 	. . 
l30aah:
	add hl,de			;30aa	19 	. 
	push hl			;30ab	e5 	. 
	ld de,0fe00h		;30ac	11 00 fe 	. . . 
	add hl,de			;30af	19 	. 
	pop hl			;30b0	e1 	. 
	jr nc,l30b7h		;30b1	30 04 	0 . 
	set 0,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;30b3	dd cb 00 c6
l30b7h:
	ld (ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_L_IDX),l		;30b7	dd 75 10
	ld (ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_H_IDX),h		;30ba	dd 74 11
	ld e,(ix + MAGICAL_ELEMENT_FALL_SPEED_L_IDX)		;30bd	dd 5e 0c
	ld d,(ix + MAGICAL_ELEMENT_FALL_SPEED_H_IDX)		;30c0	dd 56 0d
	add hl,de			;30c3	19 	. 
	ld (ix + MAGICAL_ELEMENT_HEIGHT_L_IDX),l		;30c4	dd 75 04
	ld (ix + MAGICAL_ELEMENT_HEIGHT_H_IDX),h		;30c7	dd 74 05
	jp l3025h		;30ca	c3 25 30 	. % 0 
l30cdh:
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_CONFETTI_FALLS_AND_FLOATS ;30cd	dd 36 01 06
	ld a,(BOUNCING_BALL_EXPLODE_TIMEOUT_INIT)		;30d1	3a 71 e3 	: q . 
	ld (ix + FIREBALL_TIMEOUT_IDX),a	;30d4	dd 77 08
	ld de,l0040h		;30d7	11 40 00 	. @ . 
	ld l,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)		;30da	dd 6e 02
	ld h,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)		;30dd	dd 66 03
	sbc hl,de		;30e0	ed 52 	. R 
	ld (ix + MAGICAL_ELEMENT_FALL_ACCELERATION_L_IDX),l		;30e2	dd 75 0a
	ld (ix + MAGICAL_ELEMENT_FALL_ACCELERATION_H_IDX),h		;30e5	dd 74 0b
	ld (ix + MAGICAL_ELEMENT_HOR_OFFSET_L_IDX),e		;30e8	dd 73 0e
	ld (ix + MAGICAL_ELEMENT_HOR_OFFSET_H_IDX),d		;30eb	dd 72 0f
	ld de,0x0100		;30ee	11 00 01
	ld l,(ix + MAGICAL_ELEMENT_HEIGHT_L_IDX)		;30f1	dd 6e 04
	ld h,(ix + MAGICAL_ELEMENT_HEIGHT_H_IDX)		;30f4	dd 66 05
	sbc hl,de		;30f7	ed 52 	. R 
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_L_IDX),l		;30f9	dd 75 0c
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_H_IDX),h		;30fc	dd 74 0d
	ld (ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_L_IDX),e		;30ff	dd 73 10
	ld (ix + MAGICAL_ELEMENT_HEIGHT_OFFSET_H_IDX),d		;3102	dd 72 11
	ret			;3105	c9 	. 
l3106h:
	call sub_333ah		;3106	cd 3a 33 	. : 3 
	ld a,086h		;3109	3e 86 	> . 
	call PLAY_SOUND		;310b	cd fe 0d 	. . . 
	ld iy,TBL_MAGICAL_ELEMENTS		;310e	fd 21 82 e3 	. ! . . 
	ld b,010h		;3112	06 10 	. . 
	ld c,00ah		;3114	0e 0a 	. . 
	ld l,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)		;3116	dd 6e 02
	ld h,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)		;3119	dd 66 03
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
	ld a,(NUM_MAGICAL_ELEMENTS)		;3140	3a 81 e3 	: . . 
	inc a			;3143	3c 	< 
	ld (NUM_MAGICAL_ELEMENTS),a		;3144	32 81 e3 	2 . . 
	ld a,c			;3147	79 	y 
	inc c			;3148	0c 	. 
	cp 00ch		;3149	fe 0c 	. . 
	ret z			;314b	c8 	. 
l314ch:
	ld de,0013h		;314c	11 13 00 	. . . 
	add iy,de		;314f	fd 19 	. . 
	djnz l311ch		;3151	10 c9 	. . 
	ret			;3153	c9 	.  Why a RET here? Debug?
	ld de,(MAGICAL_ELEMENTS_CONFIG + 22)		;3154	ed 5b 76 e3 	. [ v . 
	call ENEMY_ADVANCE_POSITION		;3158	cd 70 1c 	. p . 
	jr l316dh		;315b	18 10 	. . 
l315dh:
	call l1be2h		;315d	cd e2 1b 	. . . 
	ld de,(MAGICAL_ELEMENTS_CONFIG + 18)		;3160	ed 5b 72 e3 	. [ r . 
	jr l3174h		;3164	18 0e 	. . 
	ld de,(MAGICAL_ELEMENTS_CONFIG + 22)		;3166	ed 5b 76 e3 	. [ v . 
	call ENEMY_GO_BACK_POSITION		;316a	cd 7a 1c 	. z . 
l316dh:
	call l1be2h		;316d	cd e2 1b 	. . . 
	ld de,(MAGICAL_ELEMENTS_CONFIG + 20)		;3170	ed 5b 74 e3 	. [ t . 
l3174h:
	ld hl,05000h		;3174	21 00 50 	! . P 
	call CHANGE_HEIGHT_WITH_SPEED		;3177	cd 32 37 	. 2 7 
	jp c,l3713h		;317a	da 13 37 	. . 7 
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;317d	2a 0c e8 	* . . 
	ld de,l0300h		;3180	11 00 03 	. . . 
	sbc hl,de		;3183	ed 52 	. R 
	jr nc,l31aah		;3185	30 23 	0 # 
	ld e,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)		;3187	dd 5e 02 	. ^ . 
	ld d,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)		;318a	dd 56 03 	. V . 
	ld hl,0ffe0h		;318d	21 e0 ff 	! . . 
	add hl,de			;3190	19 	. 
	ld (0e80fh),hl		;3191	22 0f e8 	" . . 
	ld hl,0x0020		;3194	21 20 00 	!   . 
	add hl,de			;3197	19 	. 
	ld (0e811h),hl		;3198	22 11 e8 	" . . 
	ld l,(ix + 4)		;319b	dd 6e 04 	. n . 
	ld h,(ix + 5)		;319e	dd 66 05 	. f . 
	ld de,0001h		;31a1	11 01 00 	. . . 
	call sub_1172h		;31a4	cd 72 11 	. r . 
	jp c,l31c0h		;31a7	da c0 31 	. . 1 
l31aah:
	dec (ix + FRAME_COUNTER_IDX)    ;31aa	dd 35 07
	ret nz			;31ad	c0 	. 
	ld (ix + FRAME_COUNTER_IDX), 3	;31ae	dd 36 07 03
	ld a,(ix + CURRENT_FRAME_IDX)	;31b2	dd 7e 06
	inc a			;31b5	3c
	cp 22   		;31b6	fe 16
	jr nz,l31bch	;31b8	20 02
	ld a, 20		;31ba	3e 14
l31bch:
	ld (ix + CURRENT_FRAME_IDX),a	;31bc	dd 77 06
	ret			                                    ;31bf	c9 	. 
l31c0h:
	ld l,(ix + 4)		;31c0	dd 6e 04 	. n . 
	ld h,(ix + 5)		;31c3	dd 66 05 	. f . 
	ld de,l0120h		;31c6	11 20 01 	.   . 
	ld a,091h		;31c9	3e 91 	> . 
	call PLAY_SOUND		;31cb	cd fe 0d 	. . . 
	call STORE_DAMAGE_ORIGIN_AND_AMOUNT		;31ce	cd e2 2e 	. . . 
	jp l3713h		;31d1	c3 13 37 	. . 7 
	call l1be2h		;31d4	cd e2 1b 	. . . 
	call sub_3773h		;31d7	cd 73 37 	. s 7 
	jp c,l32edh		;31da	da ed 32 	. . 2 
	call sub_3746h		;31dd	cd 46 37 	. F 7 
	ld a,091h		;31e0	3e 91 	> . 
	jp c,l3327h		;31e2	da 27 33 	. ' 3 
	ld hl,05000h		;31e5	21 00 50 	! . P 
	call CHANGE_HEIGHT_WITH_SPEED_AND_ACCELERATION		;31e8	cd 1d 37 	. . 7 
	jr c,l3213h		;31eb	38 26 	8 & 
	ret			;31ed	c9 	. 
	call l1be2h		;31ee	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)    ;31f1	dd 35 07
	ret nz			;31f4	c0 	. 
	inc (ix + CURRENT_FRAME_IDX)		;31f5	dd 34 06
	ld a,(ix + CURRENT_FRAME_IDX)		;31f8	dd 7e 06
	cp 010h		;31fb	fe 10 	. . 
	jr nz,l3220h		;31fd	20 21 	  ! 
	inc (ix + MAGICAL_ELEMENT_STATE_IDX)		;31ff	dd 34 01
	ld a,(0e80bh)		;3202	3a 0b e8 	: . . 
	bit 7,a		;3205	cb 7f 	.  
	set 6,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3207	dd cb 00 f6
	jr nz,l3220h		;320b	20 13 	  . 
	res 6,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;320d	dd cb 00 b6
	jr l3220h		;3211	18 0d 	. . 
l3213h:
	ld a,086h		;3213	3e 86 	> . 
	call PLAY_SOUND		;3215	cd fe 0d 	. . . 
l3218h:
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_DRAGON_SMOKE_APPEARS ;3218	dd 36 01 07
	ld (ix + CURRENT_FRAME_IDX), 13 ;321c	dd 36 06 0d
l3220h:
	ld (ix + FRAME_COUNTER_IDX), 7	;3220	dd 36 07 07
	ret			;3224	c9 	. 
	call l1be2h		;3225	cd e2 1b 	. . . 
	ld hl,l0140h		;3228	21 40 01 	! @ . 
	call sub_1220h		;322b	cd 20 12 	.   . 
	ld a,(THOMAS_STATE)		;322e	3a 02 e7 	: . . 
	jr nc,l323dh		;3231	30 0a 	0 . 
	cp THOMAS_STATE_FRONTAL_KICK		;3233	fe 04 	. . 
	jp z,l32a8h		;3235	ca a8 32 	. . 2 
	cp THOMAS_STATE_FRONTAL_PUNCH		;3238	fe 05 	. . 
	jp z,l32a8h		;323a	ca a8 32 	. . 2 
l323dh:
	cp THOMAS_STATE_DOWN_KICK		;323d	fe 06 	. . 
	jr z,l3275h		;323f	28 34 	( 4 
	cp THOMAS_STATE_DOWN_PUNCH		;3241	fe 07 	. . 
	jr z,l3275h		;3243	28 30 	( 0 
	ld a,(THOMAS_FRAME)		;3245	3a 06 e7 	: . . 
	cp THOMAS_FRAME_DOWN		;3248	fe 05
	jr z,l3275h		;324a	28 29 	( ) 
	bit 5,c		;324c	cb 69 	. i 
	jr nz,l3275h		;324e	20 25 	  % 
	ld a,(ix + CURRENT_FRAME_IDX)		;3250	dd 7e 06
	cp 012h		;3253	fe 12 	. . 
	jr nz,l3275h		;3255	20 1e 	  . 
	ld hl,(0e80ah)		;3257	2a 0a e8 	* . . 
	ld de,0x0680		;325a	11 80 06 	. . . 
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
	set 5,(ix + 0)		;3271	dd cb 00 ee 	. . . . 
l3275h:
	dec (ix + FRAME_COUNTER_IDX)	;3275	dd 35 07
	ret nz			;3278	c0 	. 
	ld a,(ix + CURRENT_FRAME_IDX)		;3279	dd 7e 06
	cp 19	;327c	fe 13
	jp z,l32a2h		;327e	ca a2 32
	inc (ix + CURRENT_FRAME_IDX)		;3281	dd 34 06
	ld a,(MAGICAL_ELEMENTS_CONFIG + 16)		;3284	3a 70 e3 	: p . 
	ld (ix + FRAME_COUNTER_IDX),a	;3287	dd 77 07
	ret			;328a	c9 	. 
l328bh:
	call l1be2h		;328b	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)	;328e	dd 35 07
	ret nz			;3291	c0 	. 
	ld a,(ix + CURRENT_FRAME_IDX)		;3292	dd 7e 06
	cp 24   ;3295	fe 18
	jp z,l3713h		;3297	ca 13 37 	. . 7 
	inc (ix + CURRENT_FRAME_IDX)		;329a	dd 34 06
	ld (ix + FRAME_COUNTER_IDX), 7 ;329d	dd 36 07 07
	ret			;32a1	c9 	. 
l32a2h:
	ld (ix + CURRENT_FRAME_IDX), 23		;32a2	dd 36 06 17
	jr l32bfh		;32a6	18 17
l32a8h:
	ld a,086h		;32a8	3e 86 	> . 
	call PLAY_SOUND		;32aa	cd fe 0d 	. . . 
	ld l,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)	;32ad	dd 6e 02
	ld h,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)	;32b0	dd 66 03
	ld de,0xdc		;32b3	11 dc 00 	. . . 
	ld a,088h		;32b6	3e 88 	> . 
	call ADD_POINTS		;32b8	cd 60 2f 	. ` / 
	ld (ix + CURRENT_FRAME_IDX), 22	;32bb	dd 36 06 16
l32bfh:
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_DRAGON_DISAPPEARS	;32bf	dd 36 01 09
	ld (ix + FRAME_COUNTER_IDX), 7	;32c3	dd 36 07 07
	ret			;32c7	c9 QUESTION: Why a RET here?
	call l1be2h		;32c8	cd e2 1b 	. . . 
	dec (ix + FRAME_COUNTER_IDX)	;32cb	dd 35 07
	ret nz			;32ce	c0 	. 
	ld a,(ix + CURRENT_FRAME_IDX)		;32cf	dd 7e 06 	. ~ . 
	inc (ix + CURRENT_FRAME_IDX)		;32d2	dd 34 06 	. 4 . 
	ld (ix + FRAME_COUNTER_IDX), 7	;32d5	dd 36 07 07
	cp 00ch		;32d9	fe 0c 	. . 
	ret nz			;32db	c0 	. 
	ld a,(ix + MAGICAL_ELEMENT_HOR_OFFSET_L_IDX)		;32dc	dd 7e 0e 	. ~ . 
	and a			;32df	a7 	. 
	call m,sub_3cbah		;32e0	fc ba 3c 	. . < 
	jp l3713h		;32e3	c3 13 37 	. . 7 
l32e6h:
	ld a,093h		;32e6	3e 93 	> . 
	call PLAY_SOUND		;32e8	cd fe 0d 	. . . 
	jr l32f2h		;32eb	18 05 	. . 
l32edh:
	ld a,086h		;32ed	3e 86 	> . 
	call PLAY_SOUND		;32ef	cd fe 0d 	. . . 
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
	call PLAY_SOUND		;3319	cd fe 0d 	. . . 
	jr l333ch		;331c	18 1e 	. . 
l331eh:
	ld b,087h		;331e	06 87 	. . 
	ld a,086h		;3320	3e 86 	> . 
	call PLAY_SOUND		;3322	cd fe 0d 	. . . 
	jr l333ch		;3325	18 15 	. . 
l3327h:
	call PLAY_SOUND		;3327	cd fe 0d 	. . . 
	ld l,(ix + 4)		;332a	dd 6e 04 	. n . 
	ld h,(ix + 5)		;332d	dd 66 05 	. f . 
	ld de,0x0280		;3330	11 80 02 	. . . 
	add hl,de			;3333	19 	. 
	ld de,l0120h		;3334	11 20 01 	.   . 
	call sub_36cah		;3337	cd ca 36 	. . 6 

; SEGUIR
sub_333ah:
	ld b,000h		;333a	06 00 	. . 
l333ch:
	ld (ix + MAGICAL_ELEMENT_HOR_OFFSET_L_IDX),b		;333c	dd 70 0e 	. p . 
	ld (ix + FRAME_COUNTER_IDX), 7	;333f	dd 36 07 07
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_CONFETTI_EXPLODES    ;3343	dd 36 01 05
	ld (ix + CURRENT_FRAME_IDX), 10	;3347	dd 36 06 0a
	ret			;334b	c9 	. 

l334ch:
	ld a,086h		;334c	3e 86 	> . 
	call PLAY_SOUND		;334e	cd fe 0d 	. . . 
	jr sub_333ah		;3351	18 e7 	. . 

sub_3353h:
	call sub_36f6h		;3353	cd f6 36 	. . 6 
	ld a,(ix + 2)		;3356	dd 7e 02 	. ~ . 
	ld (iy+002h),a		;3359	fd 77 02 	. w . 
	ld a,(ix + 3)		;335c	dd 7e 03 	. ~ . 
	ld (iy+003h),a		;335f	fd 77 03 	. w . 
	ld a,(ix + 4)		;3362	dd 7e 04 	. ~ . 
	ld (iy+004h),a		;3365	fd 77 04 	. w . 
	ld a,(ix + 5)		;3368	dd 7e 05 	. ~ . 
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
	call CHANGE_HEIGHT_WITH_SPEED_AND_ACCELERATION		;3392	cd 1d 37 	. . 7 
	jr c,l33c2h		;3395	38 2b 	8 + 
	ret			;3397	c9 	. 
	call l1be2h		;3398	cd e2 1b 	. . . 
	call sub_3773h		;339b	cd 73 37 	. s 7 
	jp c,l32f2h		;339e	da f2 32 	. . 2 
	dec (ix + FRAME_COUNTER_IDX)		;33a1	dd 35 07
	ret nz			;33a4	c0 	. 
	ld (ix + FRAME_COUNTER_IDX), 5	    ;33a5	dd 36 07 05
	inc (ix + CURRENT_FRAME_IDX)		;33a9	dd 34 06
	ld a,(ix + CURRENT_FRAME_IDX)		;33ac	dd 7e 06
	cp 7		                                        ;33af	fe 07
	jr nz,l3432h		;33b1	20 7f 	   
l33b3h:
	ld a,(0e80bh)		;33b3	3a 0b e8 	: . . 
	bit 7,a		;33b6	cb 7f 	.  
	set 6,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;33b8	dd cb 00 f6
	ret z			;33bc	c8 	. 
	res 6,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;33bd	dd cb 00 b6
	ret			;33c1	c9 	. 
l33c2h:
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_POT_TOUCHES_FLOOR ;33c2	dd 36 01 03
	ld (ix + FRAME_COUNTER_IDX), 5	 ;33c6	dd 36 07 05
	ld (ix + CURRENT_FRAME_IDX),004h ;33ca	dd 36 06 04
	ld a,093h		;33ce	3e 93 	> . 
	call PLAY_SOUND		;33d0	cd fe 0d 	. . . 
	ret			;33d3	c9 	. 
    
    ; Speed of the snakes
	ld de,(MAGICAL_ELEMENTS_CONFIG + 14)		;33d4	ed 5b 6e e3
    
	call ENEMY_GO_BACK_POSITION		;33d8	cd 7a 1c 	. z . 
	call l1be2h		;33db	cd e2 1b 	. . . 
	ld de,0e400h		;33de	11 00 e4 	. . . 
	add hl,de			;33e1	19 	. 
	jp c,l3713h		;33e2	da 13 37 	. . 7 
	bit 5,c		;33e5	cb 69 	. i 
	jr nz,l341ch		;33e7	20 33 	  3 
	ld a,(THOMAS_STATE)		;33e9	3a 02 e7 	: . . 
	cp THOMAS_STATE_DEAD		;33ec	fe 0c 	. . 
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
	call PLAY_SOUND		;3412	cd fe 0d 	. . . 
	call sub_36cah		;3415	cd ca 36 	. . 6 
	set 5,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3418	dd cb 00 ee
l341ch:
	dec (ix + FRAME_COUNTER_IDX)	;341c	dd 35 07
	ret nz			;341f	c0 	. 
	ld (ix + FRAME_COUNTER_IDX), 9	;3420	dd 36 07 09
	ld a,(ix + CURRENT_FRAME_IDX)	;3424	dd 7e 06
	inc a			;3427	3c
	cp 10		    ;3428	fe 0a
	jr nz,l342eh	;342a	20 02
	ld a, 8		    ;342c	3e 08
l342eh:
	ld (ix + CURRENT_FRAME_IDX),a		;342e	dd 77 06
	ret			;3431	c9 	. 
l3432h:
	cp 008h		;3432	fe 08 	. . 
	ret nz			;3434	c0 	. 
l3435h:
	ld (ix + MAGICAL_ELEMENT_STATE_IDX), ME_STATE_SNAKE_WALKING ;3435	dd 36 01 04
	ld (ix + CURRENT_FRAME_IDX), 8	;3439	dd 36 06 08
	ld (ix + FRAME_COUNTER_IDX), 9	;343d	dd 36 07 09
	jp l33b3h		;3441	c3 b3 33 	. . 3 
l3444h:
	ld de,(MAGICAL_ELEMENTS_CONFIG + 18)		;3444	ed 5b 72 e3 	. [ r . 
	call ENEMY_GO_BACK_POSITION		;3448	cd 7a 1c 	. z . 
	call l1be2h		;344b	cd e2 1b 	. . . 
	call sub_37bfh		;344e	cd bf 37 	. . 7 
	jp c,l3315h		;3451	da 15 33 	. . 3 
	call sub_3792h		;3454	cd 92 37 	. . 7 
	ld a,091h		;3457	3e 91 	> . 
	jp c,l3327h		;3459	da 27 33 	. ' 3 
	dec (ix + FIREBALL_TIMEOUT_IDX)		;345c	dd 35 08
	jp z,l356bh		;345f	ca 6b 35 	. k 5 
	dec (ix + FRAME_COUNTER_IDX)		;3462	dd 35 07
	ret z			;3465	c8 	. 
	ld (ix + FRAME_COUNTER_IDX), 11		;3466	dd 36 07 0b
	ld a,(ix + CURRENT_FRAME_IDX)		;346a	dd 7e 06 	. ~ . 
	inc a			;346d	3c 	< 
	cp 01bh		;346e	fe 1b 	. . 
	jr c,l3474h		;3470	38 02 	8 . 
	ld a,019h		;3472	3e 19 	> . 
l3474h:
	ld (ix + CURRENT_FRAME_IDX),a		;3474	dd 77 06 	. w . 
	ret			;3477	c9 	. 
	ld de,(MAGICAL_ELEMENTS_CONFIG + 20)		;3478	ed 5b 74 e3 	. [ t . 
	call ENEMY_GO_BACK_POSITION		;347c	cd 7a 1c 	. z . 
	ld hl,(MAGICAL_ELEMENTS_CONFIG + 10)		;347f	2a 6a e3 	* j . 
	jr l348eh		;3482	18 0a 	. . 
	ld de,(MAGICAL_ELEMENTS_CONFIG + 22)		;3484	ed 5b 76 e3 	. [ v . 
	call ENEMY_GO_BACK_POSITION		;3488	cd 7a 1c 	. z . 
	ld hl,(ME_INITIAL_FALL_SPEED)		;348b	2a 6c e3 	* l . 
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
	call CHANGE_HEIGHT_WITH_SPEED		;34a9	cd 32 37 	. 2 7 
	jr c,l34c4h		;34ac	38 16 	8 . 
	dec (ix + ENEMY_FRAME_COUNTER_IDX)		;34ae	dd 35 07 	. 5 . 
	ret z			;34b1	c8 	. 
	ld (ix + ENEMY_FRAME_COUNTER_IDX),00bh		;34b2	dd 36 07 0b 	. 6 . . 
	ld a,(ix + ENEMY_FRAME_IDX)		;34b6	dd 7e 06
	inc a			;34b9	3c 	< 
	cp 01dh		;34ba	fe 1d 	. . 
	jr c,l34c0h		;34bc	38 02 	8 . 
	ld a,01bh		;34be	3e 1b 	> . 
l34c0h:
	ld (ix + ENEMY_FRAME_IDX),a		;34c0	dd 77 06 	. w . 
	ret			;34c3	c9 	. 
l34c4h:
	ld a,086h		;34c4	3e 86 	> . 
	call PLAY_SOUND		;34c6	cd fe 0d 	. . . 
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
	ld l,(ix + ENEMY_POS_L_IDX)		;34e0	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		;34e3	dd 66 03
	ld de,00200h		;34e6	11 00 02 	. . . 
	ld a,(ix + ENEMY_PROPS_IDX)		;34e9	dd 7e 00
    ; Check bit 6: looking direction
	and 1 << ENEMY_MOVE_RIGHT_BIT	;34ec	e6 40 	. @ 
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
	ld a,(ix + ENEMY_ATTACK_STEP_IDX)		;3500	dd 7e 0e
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
	ld a,(MAGICAL_ELEMENTS_CONFIG + 5)		;3525	3a 65 e3 	: e . 
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
	ld de,(MAGICAL_ELEMENTS_CONFIG + 3)		;3537	ed 5b 63 e3 	. [ c . 
	call ENEMY_GO_BACK_POSITION		;353b	cd 7a 1c 	. z . 
	call l1be2h		;353e	cd e2 1b 	. . . 
	call sub_3773h		;3541	cd 73 37 	. s 7 
	jp c,l3315h		;3544	da 15 33 	. . 3 
	call sub_3746h		;3547	cd 46 37 	. F 7 
	ld a,094h		;354a	3e 94 	> . 
	jp c,l3327h		;354c	da 27 33 	. ' 3 
	dec (ix + FIREBALL_TIMEOUT_IDX)		;354f	dd 35 08
	jp z,l334ch		;3552	ca 4c 33 	. L 3 
	dec (ix + FRAME_COUNTER_IDX)		;3555	dd 35 07
	ret nz			;3558	c0 	. 
	ld (ix + FRAME_COUNTER_IDX), 11	;   3559	dd 36 07 0b
	ld a,(ix + CURRENT_FRAME_IDX)		;355d	dd 7e 06
	inc a			;3560	3c 	< 
	cp 01fh		;3561	fe 1f 	. . 
	jr c,l3567h		;3563	38 02 	8 . 
	ld a,01dh		;3565	3e 1d 	> . 
l3567h:
	ld (ix + CURRENT_FRAME_IDX),a		;3567
	ret			;356a	c9 	. 
l356bh:
	call sub_3353h		;356b	cd 53 33 	. S 3 
	ld a,086h		;356e	3e 86 	> . 
	call PLAY_SOUND		;3570	cd fe 0d 	. . . 
	ld a,r		;3573	ed 5f 	. _ 
	and 001h		;3575	e6 01 	. . 
	jp z,l3713h		;3577	ca 13 37 	. . 7 
	ld a,040h		;357a	3e 40 	> @ 
	xor (ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;357c	dd ae 00 	. . . 
	ld (ix + MAGICAL_ELEMENT_LOOKAT_IDX),a		;357f	dd 77 00 	. w . 
	ld (ix + MAGICAL_ELEMENT_STATE_IDX),010h		;3582	dd 36 01 10 	. 6 . . 
	ld (ix + CURRENT_FRAME_IDX),01dh		;3586	dd 36 06 1d 	. 6 . . 
	ld (ix + FRAME_COUNTER_IDX), 11 ;358a	dd 36 07 0b
	ld a,(MAGICAL_ELEMENTS_CONFIG + 6)		;358e	3a 66 e3 	: f . 
	ld (ix + FIREBALL_TIMEOUT_IDX),a		;3591	dd 77 08
	ret			;3594	c9 	. 

; SEGUIR
sub_3595h:
	ld a,(MAGICAL_ELEMENTS_CONFIG + 0)		;3595	3a 60 e3 	: ` . 
	ld de,(THOMAS_POSITION)		;3598	ed 5b 12 e7 	. [ . . 
	ld hl,(MAGICAL_ELEMENTS_CONFIG + 1)		;359c	2a 61 e3 	* a . 
	sbc hl,de		;359f	ed 52 	. R 
	jr c,l35aeh		;35a1	38 0b 	8 . 
	ld hl,(MAGICAL_ELEMENTS_CONFIG + 3)		;35a3	2a 63 e3 	* c . 
	sbc hl,de		;35a6	ed 52 	. R 
	jr c,l35b5h		;35a8	38 0b 	8 . 
	cp 001h		;35aa	fe 01 	. . 
	jr l35afh		;35ac	18 01 	. . 
l35aeh:
	and a			;35ae	a7 	. 
l35afh:
	ret nz			;35af	c0 	. 
	xor a			;35b0	af 	. 
	ld (FLOOR_STAGE),a		;35b1	32 00 e1 	2 . . 
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
	ld hl,MAGICAL_ELEMENTS_CONFIG + 10		;35c3	21 6a e3 	! j . 
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
	ld a,(THOMAS_STATE)		;360b	3a 02 e7 	: . . 
	cp THOMAS_STATE_WALKING		;360e	fe 01 	. . 
	jr z,l3618h		;3610	28 06 	( . 
	cp THOMAS_STATE_JUMPING_AHEAD		;3612	fe 09 	. . 
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
	ld a,(THOMAS_STATE)		;3628	3a 02 e7 	: . . 
	cp THOMAS_STATE_WALKING		;362b	fe 01 	. . 
	jr z,l3635h		;362d	28 06 	( . 
	cp THOMAS_STATE_JUMPING_AHEAD		;362f	fe 09 	. . 
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
	ld a,(THOMAS_POSITION_H)		;363f	3a 13 e7 	: . . 
	add a,d			;3642	82 	. 
	ld d,a			;3643	57 	W 
	set 0,d		    ;3644	cb c2 	. . 
	ex de,hl		;3646	eb 	. 
	ld ix,TBL_MAGICAL_ELEMENTS - 19	;3647	dd 21 6f e3 	. ! o . 
	ld de, 19		;364b	11 13 00 	. . . 
	ld b,010h		;364e	06 10 	. . 
l3650h:
	add ix,de		;3650	dd 19
	bit ENEMY_IS_ALIVE_BIT,(ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3652	dd cb 00 66
	jr z,l366ch		;3656	28 14 	( . 
	ld a,(ix + MAGICAL_ELEMENT_STATE_IDX)		;3658	dd 7e 01
	cp ME_STATE_POT_TOUCHES_FLOOR		;365b	fe 03
	jr c,l3667h		;365d	38 08
	cp ME_STATE_CONFETTI_FALLS_AND_FLOATS		;365f	fe 06
	jr c,l366ch		;3661	38 09
	cp ME_STATE_DRAGON_DISAPPEARS	;3663	fe 09
	jr nc,l366ch		;3665	30 05
l3667h:
	ld a,(ix + 18)		;3667	dd 7e 12 	. ~ . 
	cp h			;366a	bc 	. 
	ret z			;366b	c8 	. 
l366ch:
	djnz l3650h		;366c	10 e2 	. . 
	ex de,hl			;366e	eb 	. 
	ld a,(0e015h)		;366f	3a 15 e0 	: . . 
	ld hl,MAGICAL_ELEMENTS_CONFIG + 5		;3672	21 65 e3 	! e . 
	call sub_1214h		;3675	cd 14 12 	. . . 
	ld hl,0e380h		;3678	21 80 e3 	! . . 
	ld (hl),a			;367b	77 	w 
	inc hl			;367c	23 	# 
	inc (hl)			;367d	34 	4 
	ld ix,TBL_MAGICAL_ELEMENTS - 19		;367e	dd 21 6f e3 	. ! o . 
	ld bc, 19   		;3682	01 13 00 	. . . 
l3685h:
	add ix,bc		;3685	dd 09
	bit ENEMY_IS_ALIVE_BIT, (ix + MAGICAL_ELEMENT_LOOKAT_IDX)		;3687	dd cb 00 66
	jr nz,l3685h		;368b	20 f8 	  . 
	ld a,r		;368d	ed 5f 	. _ 
	and 040h		;368f	e6 40 	. @ 
	or 010h		;3691	f6 10 	. . 
	ld (ix + MAGICAL_ELEMENT_LOOKAT_IDX),a		;3693	dd 77 00
	ld (ix + MAGICAL_ELEMENT_STATE_IDX),e		;3696	dd 73 01
	ld (ix + CURRENT_FRAME_IDX),e	;3699	dd 73 06
    
    ; ToDo: + 18 (!) figure out why so far
	ld (ix + 18),d		                        ;369c	dd 72 12
	ld (ix + MAGICAL_ELEMENT_DISTANCE_H_IDX),d	;369f	dd 72 03
	ld (ix + MAGICAL_ELEMENT_DISTANCE_L_IDX),0	;36a2	dd 36 02
	ld hl,09000h		;36a6	21 00 90 	! . . 
	ld (ix + MAGICAL_ELEMENT_HEIGHT_L_IDX),l		;36a9	dd 75 04 	. u . 
	ld (ix + MAGICAL_ELEMENT_HEIGHT_H_IDX),h		;36ac	dd 74 05 	. t . 
	ld (ix + FRAME_COUNTER_IDX), 3	;36af	dd 36 07 03
	ld hl,   10		;36b3	21 0a 00
	ld de,  125		;36b6	11 7d 00
	ld (ix + MAGICAL_ELEMENT_FALL_ACCELERATION_L_IDX),l		;36b9	dd 75 0a
	ld (ix + MAGICAL_ELEMENT_FALL_ACCELERATION_H_IDX),h		;36bc	dd 74 0b

	ld hl,(ME_INITIAL_FALL_SPEED)		;36bf	2a 6c e3 	* l . 
	add hl,de			;36c2	19 	. 
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_L_IDX),l		;36c3	dd 75 0c 	. u . 
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_H_IDX),h		;36c6	dd 74 0d 	. t . 
	ret			;36c9	c9 	. 
sub_36cah:
	ld a,(DRAGONS_LEVEL)		;36ca	3a 80 e0 	: . . 
	and 007h		;36cd	e6 07 	. . 
	cp 003h		;36cf	fe 03 	. . 
	jr nz,l36e4h		;36d1	20 11 	  . 
	ld a,(ENERGY)		;36d3	3a 09 e7 	: . . 
	sub e			;36d6	93 	. 
	jp p,l36e4h		;36d7	f2 e4 36 	. . 6 
	call CHECK_DEMO_OR_VULNERABLE		;36da	cd 08 12 	. . . 
	jr nz,l36e4h		;36dd	20 05 	  . 
	ld a,005h		;36df	3e 05 	> . 
	ld (0e007h),a		;36e1	32 07 e0 	2 . . 
l36e4h:
	jp STORE_DAMAGE_ORIGIN_AND_AMOUNT		;36e4	c3 e2 2e 	. . . 
l36e7h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;36e7	2a 0c e8 	* . . 
	ld de,0e400h		;36ea	11 00 e4 	. . . 
	add hl,de			;36ed	19 	. 
	ret c			;36ee	d8 	. 
	ld hl,0748eh		;36ef	21 8e 74 	! . t 
	ld a,c			;36f2	79 	y 
	jp l1a7eh		;36f3	c3 7e 1a 	. ~ . 

; SEGUIR
sub_36f6h:
	ld a,(NUM_MAGICAL_ELEMENTS)		;36f6	3a 81 e3 	: . . 
	cp 010h		;36f9	fe 10 	. . 
	jr nc,l3711h		;36fb	30 14 	0 . 
	inc a			;36fd	3c 	< 
	ld (NUM_MAGICAL_ELEMENTS),a		;36fe	32 81 e3 	2 . . 
	ld iy,TBL_MAGICAL_ELEMENTS - 19	;3701	fd 21 6f e3 	. ! o . 
	ld de, 19		        ;3705	11 13 00 	. . . 
l3708h:
	add iy,de		;3708	fd 19 	. . 
	bit 4,(iy+000h)		;370a	fd cb 00 66 	. . . f 
	jr nz,l3708h		;370e	20 f8 	  . 
	ret			;3710	c9 	. 
l3711h:
	pop af			;3711	f1 	. 
	ret			;3712	c9 	. 

l3713h:
	ld (ix + MAGICAL_ELEMENT_LOOKAT_IDX), 0		;3713	dd 36 00 00
	ld hl,NUM_MAGICAL_ELEMENTS		;3717	21 81 e3 	! . . 
	dec (hl)			;371a	35 	5 
	pop af			;371b	f1 	. 
	ret			;371c	c9 	. 

CHANGE_HEIGHT_WITH_SPEED_AND_ACCELERATION:
    ; SPEED += ACCELERATION
	push hl			;371d	e5 	. 
	ld l,(ix + MAGICAL_ELEMENT_FALL_ACCELERATION_L_IDX)	;371e	dd 6e 0a
	ld h,(ix + MAGICAL_ELEMENT_FALL_ACCELERATION_H_IDX)	;3721	dd 66 0b
	ld e,(ix + MAGICAL_ELEMENT_FALL_SPEED_L_IDX)		;3724	dd 5e 0c
	ld d,(ix + MAGICAL_ELEMENT_FALL_SPEED_H_IDX)		;3727	dd 56 0d
	add hl,de			                                ;372a	19
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_L_IDX),l		;372b	dd 75 0c
	ld (ix + MAGICAL_ELEMENT_FALL_SPEED_H_IDX),h		;372e	dd 74 0d
	pop hl			;3731	e1 	. 
    ;
CHANGE_HEIGHT_WITH_SPEED:
    ; HEIGHT -= DE (SPEED)
	push hl			;3732	e5 	. 
	and a			;3733	a7 	. 
	ld l,(ix + MAGICAL_ELEMENT_HEIGHT_L_IDX)		;3734	dd 6e 04
	ld h,(ix + MAGICAL_ELEMENT_HEIGHT_H_IDX)		;3737	dd 66 05
	sbc hl,de		;373a	ed 52 	. R 
	ld (ix + MAGICAL_ELEMENT_HEIGHT_L_IDX),l		;373c	dd 75 04 	. u . 
	ld (ix + MAGICAL_ELEMENT_HEIGHT_H_IDX),h		;373f	dd 74 05 	. t . 
	pop de			;3742	d1 	. 
	sbc hl,de		;3743	ed 52 	. R 
	ret			;3745	c9

sub_3746h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;3746	2a 0c e8 	* . . 
	ld de,l0300h		;3749	11 00 03 	. . . 
	sbc hl,de		;374c	ed 52 	. R 
	ret nc			;374e	d0 	. 
	ld e,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)		;374f	dd 5e 02
	ld d,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)		;3752	dd 56 03
	ld hl,0ff80h		;3755	21 80 ff 	! . . 
	add hl,de			;3758	19 	. 
	ld (0e80fh),hl		;3759	22 0f e8 	" . . 
	ld hl,0x80		;375c	21 80 00 	! . . 
	add hl,de			;375f	19 	. 
	ld (0e811h),hl		;3760	22 11 e8 	" . . 
l3763h:
	ld l,(ix + 4)		;3763	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3766	dd 66 05 	. f . 
	ld de,0x80		;3769	11 80 00 	. . . 
	add hl,de			;376c	19 	. 
	ld de,0006h+2		;376d	11 08 00 	. . . 
	jp sub_1172h		;3770	c3 72 11 	. r . 

sub_3773h:
	ld hl,l0140h		;3773	21 40 01 	! @ . 
	call sub_1220h		;3776	cd 20 12 	.   . 
	ret nc			;3779	d0 	. 
	and a			;377a	a7 	. 
	ld l,(ix + 4)		;377b	dd 6e 04 	. n . 
	ld h,(ix + 5)		;377e	dd 66 05 	. f . 
	sbc hl,de		;3781	ed 52 	. R 
	ret nc			;3783	d0 	. 
	ld hl,0f800h		;3784	21 00 f8 	! . . 
	add hl,de			;3787	19 	. 
	ld e,(ix + 4)		;3788	dd 5e 04 	. ^ . 
	ld d,(ix + 5)		;378b	dd 56 05 	. V . 
	and a			;378e	a7 	. 
	sbc hl,de		;378f	ed 52 	. R 
	ret			;3791	c9 	. 

sub_3792h:
	ld hl,(ME_INITIAL_FALL_SPEED_COPY)		;3792	2a 0c e8 	* . . 
	ld de,l0300h		;3795	11 00 03 	. . . 
	sbc hl,de		;3798	ed 52 	. R 
	ret nc			;379a	d0 	. 
	ld e,(ix + MAGICAL_ELEMENT_DISTANCE_L_IDX)		;379b	dd 5e 02
	ld d,(ix + MAGICAL_ELEMENT_DISTANCE_H_IDX)		;379e	dd 56 03
	ld hl,0ffc0h		;37a1	21 c0 ff 	! . . 
	add hl,de			;37a4	19 	. 
	ld (0e80fh),hl		;37a5	22 0f e8 	" . . 
	ld hl,l0040h		;37a8	21 40 00 	! @ . 
	add hl,de			;37ab	19 	. 
	ld (0e811h),hl		;37ac	22 11 e8 	" . . 
	ld l,(ix + MAGICAL_ELEMENT_HEIGHT_L_IDX)	;37af	dd 6e 04
	ld h,(ix + MAGICAL_ELEMENT_HEIGHT_H_IDX)	;37b2	dd 66 05
	ld de,0x80		;37b5	11 80 00 	. . . 
	add hl,de			;37b8	19 	. 
	ld de,4				;37b9	11 04 00 	. . . 
	jp sub_1172h		;37bc	c3 72 11 	. r . 

sub_37bfh:
	ld hl,l00e0h		;37bf	21 e0 00 	! . . 
	call sub_1220h		;37c2	cd 20 12 	.   . 
	ret nc			;37c5	d0 	. 
	and a			;37c6	a7 	. 
	ld l,(ix + MAGICAL_ELEMENT_HEIGHT_L_IDX)		;37c7	dd 6e 04
	ld h,(ix + MAGICAL_ELEMENT_HEIGHT_H_IDX)		;37ca	dd 66 05
	sbc hl,de		;37cd	ed 52 	. R 
	ret nc			;37cf	d0 	. 
	ld hl,0fb80h		;37d0	21 80 fb 	! . . 
	add hl,de			;37d3	19 	. 
	ld e,(ix + MAGICAL_ELEMENT_HEIGHT_L_IDX)		;37d4	dd 5e 04
	ld d,(ix + MAGICAL_ELEMENT_HEIGHT_H_IDX)		;37d7	dd 56 05
	and a			;37da	a7 	. 
	sbc hl,de		;37db	ed 52 	. R 
	ret			;37dd	c9 	. 

sub_37deh:
	ld hl,(THOMAS_POSITION)		;37de	2a 12 e7 	* . . 
	ld de,08000h		;37e1	11 00 80 	. . . 
	add hl,de			;37e4	19 	. 
	jr c,clear_floor_stage		;37e5	38 0a 	8 . 
	call sub_37f6h		;37e7	cd f6 37 	. . 7 
	call sub_38ffh		;37ea	cd ff 38 	. . 8 
	call sub_3960h		;37ed	cd 60 39 	. ` 9 
	ret			;37f0	c9 	. 
clear_floor_stage:
	xor a			;37f1	af 	. 
	ld (FLOOR_STAGE),a		;37f2	32 00 e1 	2 . . 
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
	ld a,(DRAGONS_LEVEL)		;3806	3a 80 e0 	: . . 
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
	ld bc,(THOMAS_POSITION)		;381f	ed 4b 12 e7 	. K . . 
	ld hl,0x0f40	;3823	21 40 0f 	! @ . 
	add hl,bc			;3826	09 	. 
	sbc hl,de		;3827	ed 52 	. R 
	jp c,l38d9h		;3829	da d9 38 	. . 8 
	ld hl,0f0c0h		;382c	21 c0 f0 	! . . 
	add hl,bc			;382f	09 	. 
	sbc hl,de		;3830	ed 52 	. R 
	jp nc,l38d9h		;3832	d2 d9 38 	. . 8 
	ld hl,TBL_MOTHS_LEN		;3835	21 76 e5 	! v . 
	ld a,(DATA_MOTHS_CONFIG + MAX_NUM_MOTHS_IDX)		;3838	3a 0b e5
	cp (hl)			;383b	be 	. 
	jp c,l38d9h		;383c	da d9 38 	. . 8 
	inc (hl)			;383f	34 	4 
	ld iy,TBL_E562		;3840	fd 21 62 e5 	. ! b . 
	ld bc,0015h		;3844	01 15 00 	. . . 
l3847h:
	add iy,bc		;3847	fd 09 	. . 
	bit 4,(iy+000h)		;3849	fd cb 00 66 	. . . f 
	jr nz,l3847h		;384d	20 f8 	  . 
	ld (iy+002h),e		;384f	fd 73 02 	. s . 
	ld (iy+003h),d		;3852	fd 72 03 	. r . 
	ld hl,(THOMAS_POSITION)		;3855	2a 12 e7 	* . . 
	ld a,010h		;3858	3e 10 	> . 
	sbc hl,de		;385a	ed 52 	. R 
	jr c,l3860h		;385c	38 02 	8 . 
	ld a,050h		;385e	3e 50 	> P 
l3860h:
	ld (iy+000h),a		;3860	fd 77 00 	. w . 
	call sub_3dc5h		;3863	cd c5 3d 	. . = 
	push de			;3866	d5 	. 
	ld a,(0e012h)		;3867	3a 12 e0 	: . . 
	ld hl, DATA_MOTHS_CONFIG + 13	;386a	21 0d e5 	! . . 
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
	ld hl, DATA_MOTHS_CONFIG + 14	;3882	21 0e e5 	! . . 
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
	ld a,(DATA_MOTHS_CONFIG + 10)		;38d0	3a 0a e5 	: . . 
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
	ld a,(TBL_E521_LEN)		;38ff	3a 20 e5 	:   . 
	and a			;3902	a7 	. 
	ret z			;3903	c8 	. 
	ld b,a			;3904	47 	G 
	ld ix,TBL_E521		;3905	dd 21 21 e5 	. ! ! . 
l3909h:
	ld l,(ix + 0)		;3909	dd 6e 00 	. n . 
	ld h,(ix + 1)		;390c	dd 66 01 	. f . 
l390fh:
	ld de,l0029h		;390f	11 29 00 	. ) . 
	sbc hl,de		;3912	ed 52 	. R 
	ex de,hl			;3914	eb 	. 
	ld hl,0x800		;3915	21 00 08 	! . . 
	sbc hl,de		;3918	ed 52 	. R 
	jr c,l3921h		;391a	38 05 	8 . 
	call sub_3d0eh		;391c	cd 0e 3d 	. . = 
	jr l3945h		;391f	18 24 	. $ 
l3921h:
	ld (ix + 0),e		;3921	dd 73 00 	. s . 
	ld (ix + 1),d		;3924	dd 72 01 	. r . 
	ld hl,(THOMAS_POSITION)		;3927	2a 12 e7 	* . . 
	sbc hl,de		;392a	ed 52 	. R 
	jr c,l3938h		;392c	38 0a 	8 . 
	ld de,0f000h		;392e	11 00 f0 	. . . 
	add hl,de			;3931	19 	. 
	jr c,l3959h		;3932	38 25 	8 % 
	ld c,0ffh		;3934	0e ff 	. . 
	jr l3940h		;3936	18 08 	. . 
l3938h:
	ld de,0x1000		;3938	11 00 10 	. . . 
	add hl,de			;393b	19 	. 
	jr nc,l3959h		;393c	30 1b 	0 . 
	ld c,000h		;393e	0e 00 	. . 
l3940h:
	push bc			;3940	c5 	. 
	call sub_3d55h		;3941	cd 55 3d 	. U = 
	pop bc			;3944	c1 	. 
l3945h:
	ld hl,TBL_E521_LEN		;3945	21 20 e5 	!   . 
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
	ld a,(TABLE_WIDTH_41_LEN)		;3960	3a 49 e5 	: I . 
	and a			;3963	a7 	. 
	ret z			;3964	c8 	. 
	ld b,a			;3965	47 	G 
	ld ix,TABLE_WIDTH_41		;3966	dd 21 4a e5 	. ! J . 
l396ah:
	ld l,(ix + 0)		;396a	dd 6e 00 	. n . 
	ld h,(ix + 1)		;396d	dd 66 01 	. f . 
l3970h:
	ld de, 41		;3970	11 29 00 	. ) . 
	add hl,de			;3973	19 	. 
	ex de,hl			;3974	eb 	. 
	ld hl,08000h		;3975	21 00 80 	! . . 
	sbc hl,de		;3978	ed 52 	. R 
	jr nc,l3981h		;397a	30 05 	0 . 
	call sub_3d09h		;397c	cd 09 3d 	. . = 
	jr l39a5h		;397f	18 24 	. $ 
l3981h:
	ld (ix + 0),e		;3981	dd 73 00 	. s . 
	ld (ix + 1),d		;3984	dd 72 01 	. r . 
	ld hl,(THOMAS_POSITION)		;3987	2a 12 e7 	* . . 
	sbc hl,de		;398a	ed 52 	. R 
	jr c,l3998h		;398c	38 0a 	8 . 
	ld de,0f000h		;398e	11 00 f0 	. . . 
	add hl,de			;3991	19 	. 
	jr c,l39b9h		;3992	38 25 	8 % 
	ld c,0ffh		;3994	0e ff 	. . 
	jr l39a0h		;3996	18 08 	. . 
l3998h:
	ld de,0x1000		;3998	11 00 10 	. . . 
	add hl,de			;399b	19 	. 
	jr nc,l39b9h		;399c	30 1b 	0 . 
	ld c,000h		;399e	0e 00 	. . 
l39a0h:
	push bc			;39a0	c5 	. 
	call sub_3d59h		;39a1	cd 59 3d 	. Y = 
	pop bc			;39a4	c1 	. 
l39a5h:
	ld hl,TABLE_WIDTH_41_LEN		;39a5	21 49 e5 	! I . 
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

; Process the list of moths
; Adding a RET (C9) here avoids that the moths at level #4 appear.
PROCESS_ALL_MOTHS:
    ; Get out if there aren't any active moths
	ld a,(TBL_MOTHS_LEN)	;39c0	3a 76 e5
	and a			        ;39c3	a7
	ret z			        ;39c4	c8

	ld ix,TBL_MOTHS		;39c5	dd 21 77 e5
	ld a,(DATA_MOTHS_CONFIG + MAX_NUM_MOTHS_IDX)		;39c9	3a 0b e5
	ld b,a			;39cc	47 	G 
l39cdh:
	push bc			                ;39cd	c5
	ld c,(ix + ENEMY_PROPS_IDX)		;39ce	dd 4e 00
	bit ENEMY_IS_ALIVE_BIT, c		;39d1	cb 61
    ; Call if the moth is active
	call nz,PROCESS_ONE_MOTH		        ;39d3	c4 df 39
	pop bc			                ;39d6	c1
    
    ; Next moth. Width of each entry: 21 bytes
	ld de, 21		                ;39d7	11 15 00
	add ix,de		                ;39da	dd 19
	djnz l39cdh		                ;39dc	10 ef

    ; All done, exit
	ret			                    ;39de	c9

; Process a moth
PROCESS_ONE_MOTH:
    ; Jump if ENEMY_STATE_IDX < 4
	ld a,(ix + ENEMY_STATE_IDX)		;39df	dd 7e 01
	cp 4		                    ;39e2	fe 04
	jr c,l39f1h		                ;39e4	38 0b

	; Jump if ENEMY_STATE_IDX < 7
    cp 7		                    ;39e6	fe 07
	jp c,l3c3bh		                ;39e8	da 3b 3c
    
    ; Jump if ENEMY_STATE_IDX == 0
	jp z,l3be9h		                ;39eb	ca e9 3b
    
	jp l3b1fh		                ;39ee	c3 1f 3b
;
; ENEMY_STATE_IDX < 4
l39f1h:
	; Update frame counter
    dec (ix + ENEMY_FRAME_COUNTER_IDX)		;39f1	dd 35 07
	jr nz,l3a03h		                    ;39f4	20 0d
	ld (ix + ENEMY_FRAME_COUNTER_IDX), 5    ;39f6	dd 36 07 05
    
    ; Update frame
	dec (ix + ENEMY_FRAME_IDX)		;39fa	dd 35 06
	jr z,l3a03h		                ;39fd	28 04
	ld (ix + ENEMY_FRAME_IDX), 1	;39ff	dd 36 06 01
l3a03h:
	bit 1,(ix + 20)		            ;3a03	dd cb 14 4e
	jr z,l3a26h		                ;3a07	28 1d
	dec (ix + 19)		;3a09	dd 35 13 	. 5 . 
	jr nz,l3a26h		;3a0c	20 18 	  . 
	bit 2,(ix + 20)		;3a0e	dd cb 14 56 	. . . V 
	jr nz,l3a1eh		;3a12	20 0a 	  . 
	set 2,(ix + 20)		;3a14	dd cb 14 d6 	. . . . 
	ld (ix + 19),0a9h		;3a18	dd 36 13 a9 	. 6 . . 
	jr l3a26h		;3a1c	18 08 	. . 
l3a1eh:
	res 2,(ix + 20)		;3a1e	dd cb 14 96 	. . . . 
	res 1,(ix + 20)		;3a22	dd cb 14 8e 	. . . . 
l3a26h:
	bit 0,(ix + 20)		;3a26	dd cb 14 46 	. . . F 
	jr z,l3a32h		;3a2a	28 06 	( . 
	dec (ix + 18)		;3a2c	dd 35 12 	. 5 . 
	jp z,l3b92h		;3a2f	ca 92 3b 	. . ; 
l3a32h:
	ld l,(ix + ENEMY_POS_L_IDX)		    ;3a32	dd 6e 02
	ld h,(ix + ENEMY_POS_H_IDX)		    ;3a35	dd 66 03
	ld e,(ix + MOTH_HOR_SPEED_L_IDX)	;3a38	dd 5e 10
	ld d,(ix + MOTH_HOR_SPEED_H_IDX)	;3a3b	dd 56 11
	bit 2,(ix + 20)		;3a3e	dd cb 14 56 	. . . V 
	jr z,l3a47h		;3a42	28 03 	( . 
	ld de,0		;3a44	11 00 00 	. . . 
l3a47h:
    ; C is probably the moth index
	bit 6,c		;3a47	cb 71 	. q 
	jr nz,l3a5eh		;3a49	20 13 	  . 
	sbc hl,de		;3a4b	ed 52 	. R 
	ex de,hl			;3a4d	eb 	. 
	ld hl,0f400h		;3a4e	21 00 f4 	! . . 
	add hl,de			;3a51	19 	. 
	jr c,l3a70h		;3a52	38 1c 	8 . 
	set ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;3a54	dd cb 00 f6 	. . . . 
	ld hl,l3eabh		;3a58	21 ab 3e 	! . > 
	jp l3baah		;3a5b	c3 aa 3b 	. . ; 
l3a5eh:
	add hl,de			;3a5e	19 	. 
	ex de,hl			;3a5f	eb 	. 
	ld hl,08400h		;3a60	21 00 84 	! . . 
	add hl,de			;3a63	19 	. 
	jr nc,l3a70h		;3a64	30 0a 	0 . 
	res ENEMY_MOVE_RIGHT_BIT, (ix + ENEMY_PROPS_IDX)		;3a66	dd cb 00 b6 	. . . . 
	ld hl,l3e7fh		;3a6a	21 7f 3e 	!  > 
	jp l3baah		;3a6d	c3 aa 3b 	. . ; 
l3a70h:
	ld (ix + ENEMY_POS_L_IDX),e		;3a70	dd 73 02 	. s . 
	ld (ix + ENEMY_POS_H_IDX),d		;3a73	dd 72 03 	. r . 
	push de			;3a76	d5 	. 
	ld hl,(THOMAS_POSITION)		;3a77	2a 12 e7 	* . . 
	sbc hl,de		;3a7a	ed 52 	. R 
	ld de,0x1100		;3a7c	11 00 11 	. . . 
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
	ld l,(ix + ENEMY_FRAMESEQ_PTR_L_IDX)		;3aa0	dd 6e 0c 	. n . 
	ld h,(ix + ENEMY_FRAMESEQ_PTR_H_IDX)		;3aa3	dd 66 0d 	. f . 
	jr z,l3aaeh		;3aa6	28 06 	( . 
	ld de,(DATA_MOTHS_CONFIG + VERT_SPEED_IDX)		;3aa8	ed 5b 04 e5 	. [ . . 
	jr l3ab2h		;3aac	18 04 	. . 
l3aaeh:
	ld de,(DATA_MOTHS_CONFIG + 6)		;3aae	ed 5b 06 e5 	. [ . . 
l3ab2h:
	bit 3,c		;3ab2	cb 59 	. Y 
	jr z,l3ac3h		;3ab4	28 0d 	( . 
	sbc hl,de		;3ab6	ed 52 	. R 
	ex de,hl			;3ab8	eb 	. 
	bit 7,d		;3ab9	cb 7a 	. z 
	jr z,l3adbh		;3abb	28 1e 	( . 
	res 3,(ix + ENEMY_PROPS_IDX)		;3abd	dd cb 00 9e 	. . . . 
	jr l3adbh		;3ac1	18 18 	. . 
l3ac3h:
	add hl,de			;3ac3	19 	. 
	ex de,hl			;3ac4	eb 	. 
	bit 7,d		;3ac5	cb 7a 	. z 
	jr nz,l3adbh		;3ac7	20 12 	  . 
	and a			;3ac9	a7 	. 
	jr z,l3ad1h		;3aca	28 05 	( . 
	ld hl, -5120	;3acc	21 00 ec 	! . . 
	jr l3ad4h		;3acf	18 03 	. . 
l3ad1h:
	ld hl, -4096		;3ad1	21 00 f0 	! . . 
l3ad4h:
	add hl,de			;3ad4	19 	. 
	jr nc,l3adbh		;3ad5	30 04 	0 . 
	set 3,(ix + 0)		;3ad7	dd cb 00 de 	. . . . 
l3adbh:
	ld (ix + MOTH_VERT_POS_L_IDX),e		;3adb	dd 73 0c
	ld (ix + MOTH_VERT_POS_H_IDX),d		;3ade	dd 72 0d
	pop hl			;3ae1	e1 	. 
	add hl,de			;3ae2	19 	. 
	ex de,hl			;3ae3	eb 	. 
l3ae4h:
	ld l,(ix + 8)		;3ae4	dd 6e 08 	. n . 
	ld h,(ix + 9)		;3ae7	dd 66 09 	. f . 
	add hl,de			;3aea	19 	. 
	ld (ix + 4),l		;3aeb	dd 75 04 	. u . 
	ld (ix + 5),h		;3aee	dd 74 05 	. t . 
	jp l3c7ah		;3af1	c3 7a 3c 	. z < 
l3af4h:
	call sub_3d22h		;3af4	cd 22 3d 	. " = 
	push de			;3af7	d5 	. 
	ld de,(DATA_MOTHS_CONFIG + VERT_SPEED_IDX)	;3af8	ed 5b 04 e5
	ld l,(ix + MOTH_VERT_POS_L_IDX)		        ;3afc	dd 6e 0c
	ld h,(ix + MOTH_VERT_POS_H_IDX)		        ;3aff	dd 66 0d
	bit 3,c		;3b02	cb 59 	. Y 
	jr z,l3b0ah		;3b04	28 04 	( . 
	sbc hl,de		;3b06	ed 52 	. R 
	jr l3b0bh		;3b08	18 01 	. . 
l3b0ah:
	add hl,de			;3b0a	19 	. 
l3b0bh:
	jr nc,l3b14h		;3b0b	30 07 	0 . 
	ld (ix + 1),000h		;3b0d	dd 36 01 00 	. 6 . . 
	ld hl,0		;3b11	21 00 00 	! . . 
l3b14h:
	ld (ix + MOTH_VERT_POS_L_IDX),l		;3b14	dd 75 0c 	. u . 
	ld (ix + MOTH_VERT_POS_H_IDX),h		;3b17	dd 74 0d 	. t . 
	pop de			;3b1a	d1 	. 
	add hl,de			;3b1b	19 	. 
	ex de,hl			;3b1c	eb 	. 
	jr l3ae4h		;3b1d	18 c5 	. . 
l3b1fh:
	ld l,(ix + 14)		;3b1f	dd 6e 0e 	. n . 
	ld h,(ix + 15)		;3b22	dd 66 0f 	. f . 
	dec (ix + 7)		;3b25	dd 35 07 	. 5 . 
	jr nz,l3b33h		;3b28	20 09 	  . 
	ld de,5				;3b2a	11 05 00 	. . . 
	add hl,de			;3b2d	19 	. 
	call sub_3bd5h		;3b2e	cd d5 3b 	. . ; 
	jr z,l3b57h		;3b31	28 24 	( $ 
l3b33h:
	ld a,(hl)			;3b33	7e 	~ 
	add a,(ix + 2)		;3b34	dd 86 02 	. . . 
	ld (ix + 2),a		;3b37	dd 77 02 	. w . 
	inc hl			;3b3a	23 	# 
	ld a,(hl)			;3b3b	7e 	~ 
	adc a,(ix + 3)		;3b3c	dd 8e 03 	. . . 
	ld (ix + 3),a		;3b3f	dd 77 03 	. w . 
	inc hl			;3b42	23 	# 
	ld a,(hl)			;3b43	7e 	~ 
	add a,(ix + 4)		;3b44	dd 86 04 	. . . 
	ld (ix + 4),a		;3b47	dd 77 04 	. w . 
	inc hl			;3b4a	23 	# 
	ld a,(hl)			;3b4b	7e 	~ 
	adc a,(ix + 5)		;3b4c	dd 8e 05 	. . . 
	ld (ix + 5),a		;3b4f	dd 77 05 	. w . 
	inc hl			;3b52	23 	# 
	ld c,(hl)			;3b53	4e 	N 
	jp l3c7ah		;3b54	c3 7a 3c 	. z < 
l3b57h:
	ld (ix + 10),000h		;3b57	dd 36 0a 00 	. 6 . . 
	ld (ix + 6),000h		;3b5b	dd 36 06 00 	. 6 . . 
	ld (ix + 7),005h		;3b5f	dd 36 07 05 	. 6 . . 
	ld l,(ix + 4)		;3b63	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3b66	dd 66 05 	. f . 
	ld e,(ix + 8)		;3b69	dd 5e 08 	. ^ . 
	ld d,(ix + 9)		;3b6c	dd 56 09 	. V . 
	sbc hl,de		;3b6f	ed 52 	. R 
	ld (ix + MOTH_VERT_POS_L_IDX),l		;3b71	dd 75 0c 	. u . 
	ld (ix + MOTH_VERT_POS_H_IDX),h		;3b74	dd 74 0d 	. t . 
	ld a,(ix + 1)		;3b77	dd 7e 01 	. ~ . 
	sub 008h		;3b7a	d6 08 	. . 
	jr nz,l3b8ch		;3b7c	20 0e 	  . 
	ld a,003h		;3b7e	3e 03 	> . 
	res 3,(ix + 0)		;3b80	dd cb 00 9e 	. . . . 
	bit 7,h		;3b84	cb 7c 	. | 
	jr nz,l3b8ch		;3b86	20 04 	  . 
	set 3,(ix + 0)		;3b88	dd cb 00 de 	. . . . 
l3b8ch:
	ld (ix + 1),a		;3b8c	dd 77 01 	. w . 
	jp l3c7ah		;3b8f	c3 7a 3c 	. z < 
l3b92h:
	res 0,(ix+014h)		;3b92	dd cb 14 86 	. . . . 
	bit 6,(ix + 0)		;3b96	dd cb 00 76 	. . . v 
	ld hl,l3e7fh		;3b9a	21 7f 3e 	!  > 
	res 6,(ix + 0)		;3b9d	dd cb 00 b6 	. . . . 
	jr nz,l3baah		;3ba1	20 07 	  . 
	set 6,(ix + 0)		;3ba3	dd cb 00 f6 	. . . . 
	ld hl,l3eabh		;3ba7	21 ab 3e 	! . > 
l3baah:
	push hl			;3baa	e5 	. 
	ld l,(ix + 4)		;3bab	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3bae	dd 66 05 	. f . 
	ld de,09800h		;3bb1	11 00 98 	. . . 
	add hl,de			;3bb4	19 	. 
	pop hl			;3bb5	e1 	. 
	jr nc,l3bbch		;3bb6	30 04 	0 . 
	ld de,0016h		;3bb8	11 16 00 	. . . 
	add hl,de			;3bbb	19 	. 
l3bbch:
	call sub_3bd5h		;3bbc	cd d5 3b 	. . ; 
	ld de,4				;3bbf	11 04 00 	. . . 
	add hl,de			;3bc2	19 	. 
	ld c,(hl)			;3bc3	4e 	N 
	ld a,(ix + 1)		;3bc4	dd 7e 01 	. ~ . 
	add a,008h		;3bc7	c6 08 	. . 
	cp 00bh		;3bc9	fe 0b 	. . 
	jr nz,l3bcfh		;3bcb	20 02 	  . 
	ld a,008h		;3bcd	3e 08 	> . 
l3bcfh:
	ld (ix + 1),a		;3bcf	dd 77 01 	. w . 
	jp l3c7ah		;3bd2	c3 7a 3c 	. z < 

sub_3bd5h:
	ld a,(hl)			;3bd5	7e 	~ 
	cp 0ffh		;3bd6	fe ff 	. . 
	ret z			;3bd8	c8 	. 
	ld (ix + 7),a		;3bd9	dd 77 07 	. w . 
	inc hl			;3bdc	23 	# 
	ld a,(hl)			;3bdd	7e 	~ 
	ld (ix + 6),a		;3bde	dd 77 06 	. w . 
	inc hl			;3be1	23 	# 
	ld (ix + 14),l		;3be2	dd 75 0e 	. u . 
	ld (ix + 15),h		;3be5	dd 74 0f 	. t . 
	ret			;3be8	c9 	. 

; ENEMY_STATE_IDX == 0
l3be9h:
	dec (ix + 7)		;3be9	dd 35 07 	. 5 . 
	jp nz,l3ca9h		;3bec	c2 a9 3c 	. . < 
	ld a,(ix + 6)		;3bef	dd 7e 06 	. ~ . 
	cp 009h		;3bf2	fe 09 	. . 
	jr z,l3c00h		;3bf4	28 0a 	( . 
	ld (ix + 7),005h		;3bf6	dd 36 07 05 	. 6 . . 
	inc (ix + 6)		;3bfa	dd 34 06 	. 4 . 
	jp l3ca9h		;3bfd	c3 a9 3c 	. . < 
l3c00h:
	ld a,(ix + 14)		;3c00	dd 7e 0e 	. ~ . 
	and a			;3c03	a7 	. 
	jp z,l3cf2h		;3c04	ca f2 3c 	. . < 
	call sub_3cbah		;3c07	cd ba 3c 	. . < 
	jp l3cf2h		;3c0a	c3 f2 3c 	. . < 
l3c0dh:
	ld a,086h		;3c0d	3e 86 	> . 
	call PLAY_SOUND		;3c0f	cd fe 0d 	. . . 
	ld a,(0e701h)		;3c12	3a 01 e7 	: . . 
	and 001h		;3c15	e6 01 	. . 
	ld a,083h		;3c17	3e 83 	> . 
	jr nz,l3c2ah		;3c19	20 0f 	  . 
	inc a			;3c1b	3c 	< 
	jr l3c2ah		;3c1c	18 0c 	. . 
l3c1eh:
	ld de,00115h		;3c1e	11 15 01 	. . . 
	call STORE_DAMAGE_ORIGIN_AND_AMOUNT		;3c21	cd e2 2e 	. . . 
	ld a,094h		;3c24	3e 94 	> . 
	call PLAY_SOUND		;3c26	cd fe 0d 	. . . 
	xor a			;3c29	af 	. 
l3c2ah:
	ld (ix + 14),a		;3c2a	dd 77 0e 	. w . 
	ld (ix + 7),005h		;3c2d	dd 36 07 05 	. 6 . . 
	ld (ix + 6),007h		;3c31	dd 36 06 07 	. 6 . . 
	ld (ix + 1),007h		;3c35	dd 36 01 07 	. 6 . . 
	jr l3ca9h		;3c39	18 6e 	. n 

; ENEMY_STATE_IDX < 7
l3c3bh:
	dec (ix + 7)		;3c3b	dd 35 07 	. 5 . 
	jr z,l3c66h		;3c3e	28 26 	( & 
	ld a,(0eb00h)		;3c40	3a 00 eb 	: . . 
	push af			;3c43	f5 	. 
	ld a,001h		;3c44	3e 01 	> . 
	ld (0eb00h),a		;3c46	32 00 eb 	2 . . 
	ld hl,(0eb01h)		;3c49	2a 01 eb 	* . . 
	push hl			;3c4c	e5 	. 

	ld hl,(SPRITE_BUFFER_PTR)		;3c4d	2a 03 eb 	* . . 
	ld de, -8		            ;3c50	11 f8 ff
	add hl,de			        ;3c53	19
	ld (0eb01h),hl		        ;3c54	22 01 eb

	ld (SPRITE_BUFFER_PTR),hl		;3c57	22 03 eb 	" . . 
	call l3ca9h		;3c5a	cd a9 3c 	. . < 
	pop hl			;3c5d	e1 	. 
	ld (0eb01h),hl		;3c5e	22 01 eb 	" . . 
	pop af			;3c61	f1 	. 
	ld (0eb00h),a		;3c62	32 00 eb 	2 . . 
	ret			;3c65	c9 	. 
l3c66h:
	ld (ix + 6),000h		;3c66	dd 36 06 00 	. 6 . . 
	ld (ix + 7),005h		;3c6a	dd 36 07 05 	. 6 . . 
	ld a,(ix + 1)		;3c6e	dd 7e 01 	. ~ . 
	sub 004h		;3c71	d6 04 	. . 
	jr nz,l3c77h		;3c73	20 02 	  . 
	ld a,003h		;3c75	3e 03 	> . 
l3c77h:
	ld (ix + 1),a		;3c77	dd 77 01 	. w . 
l3c7ah:
	call sub_3ccfh		;3c7a	cd cf 3c 	. . < 
	jp c,l3c0dh		;3c7d	da 0d 3c 	. . < 
	ld e,(ix + 2)		;3c80	dd 5e 02 	. ^ . 
	ld d,(ix + 3)		;3c83	dd 56 03 	. V . 
	ld hl,0ffc0h		;3c86	21 c0 ff 	! . . 
	add hl,de			;3c89	19 	. 
	ld (0e80fh),hl		;3c8a	22 0f e8 	" . . 
	ld hl,0x80		;3c8d	21 80 00 	! . . 
	add hl,de			;3c90	19 	. 
	ld (0e811h),hl		;3c91	22 11 e8 	" . . 
	ld l,(ix + 4)		;3c94	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3c97	dd 66 05 	. f . 
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

; SEGUIR
sub_3cbah:
	ld l,(ix + 4)		;3cba	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3cbd	dd 66 05 	. f . 
	add hl,hl			;3cc0	29 	) 
	ld d,000h		;3cc1	16 00 	. . 
	rl d		;3cc3	cb 12 	. . 
	ld e,h			;3cc5	5c 	\ 
	ld l,(ix + 2)		;3cc6	dd 6e 02 	. n . 
	ld h,(ix + 3)		;3cc9	dd 66 03 	. f . 
	jp ADD_POINTS		;3ccc	c3 60 2f 	. ` / 

sub_3ccfh:
	ld hl,l0140h		;3ccf	21 40 01 	! @ . 
	call sub_1220h		;3cd2	cd 20 12 	.   . 
	ret nc			;3cd5	d0 	. 
	ld hl,l017fh+1		;3cd6	21 80 01 	! . . 
	add hl,de			;3cd9	19 	. 
	ex de,hl			;3cda	eb 	. 
	ld l,(ix + 4)		;3cdb	dd 6e 04 	. n . 
	ld h,(ix + 5)		;3cde	dd 66 05 	. f . 
	sbc hl,de		;3ce1	ed 52 	. R 
	ret nc			;3ce3	d0 	. 
	ld hl,0f380h		;3ce4	21 80 f3 	! . . 
	add hl,de			;3ce7	19 	. 
	ld e,(ix + 4)		;3ce8	dd 5e 04 	. ^ . 
	ld d,(ix + 5)		;3ceb	dd 56 05 	. V . 
	and a			;3cee	a7 	. 
	sbc hl,de		;3cef	ed 52 	. R 
	ret			;3cf1	c9 	. 

l3cf2h:
	ld hl,TBL_MOTHS_LEN		;3cf2	21 76 e5 	! v . 
	dec (hl)			;3cf5	35 	5 
	ld (ix + 0),000h		;3cf6	dd 36 00 00 	. 6 . . 
	ret			;3cfa	c9 	. 
l3cfbh:
	ld hl,TBL_MOTHS_LEN		;3cfb	21 76 e5 	! v . 
	dec (hl)			;3cfe	35 	5 
	bit 6,(ix + 0)		;3cff	dd cb 00 76 	. . . v 
	ld (ix + 0),000h		;3d03	dd 36 00 00 	. 6 . . 
	jr nz,sub_3d0eh		;3d07	20 05 	  . 

sub_3d09h:
	ld hl,TBL_E521_LEN		;3d09	21 20 e5 	!   . 
	jr l3d11h		;3d0c	18 03 	. . 

sub_3d0eh:
	ld hl,TABLE_WIDTH_41_LEN		;3d0e	21 49 e5 	! I . 
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
	ld l,(ix + 10)		;3d22	dd 6e 0a 	. n . 
	ld h,(ix + 11)		;3d25	dd 66 0b 	. f . 
	ld de,(DATA_MOTHS_CONFIG + 8)		;3d28	ed 5b 08 e5 	. [ . . 
	bit 2,(ix + 0)		;3d2c	dd cb 00 56 	. . . V 
	jr z,l3d40h		;3d30	28 0e 	( . 
	sbc hl,de		;3d32	ed 52 	. R 
	ex de,hl			;3d34	eb 	. 
	jr nc,l3d4ch		;3d35	30 15 	0 . 
	res 2,(ix + 0)		;3d37	dd cb 00 96 	. . . . 
	ld de,0		;3d3b	11 00 00 	. . . 
	jr l3d4ch		;3d3e	18 0c 	. . 
l3d40h:
	add hl,de			;3d40	19 	. 
	ex de,hl			;3d41	eb 	. 
	ld hl,0fc00h		;3d42	21 00 fc 	! . . 
	add hl,de			;3d45	19 	. 
	jr nc,l3d4ch		;3d46	30 04 	0 . 
	set 2,(ix + 0)		;3d48	dd cb 00 d6 	. . . . 
l3d4ch:
	ld (ix + 10),e		    ;3d4c	dd 73 0a
	ld (ix + 11),d    ;3d4f	dd 72 0b
	ret			;3d52	c9 	. 

l3d53h:
	ld c,000h		;3d53	0e 00 	. . 
sub_3d55h:
	ld b,010h		;3d55	06 10 	. . 
	jr l3d5bh		;3d57	18 02 	. . 
sub_3d59h:
	ld b,050h		;3d59	06 50 	. P 
l3d5bh:
	ld hl,TBL_MOTHS_LEN		;3d5b	21 76 e5 	! v . 
	ld a,(DATA_MOTHS_CONFIG + MAX_NUM_MOTHS_IDX)		;3d5e	3a 0b e5
	cp (hl)			;3d61	be 	. 
	ret c			;3d62	d8 	. 
	inc (hl)			;3d63	34 	4 
	ld iy,TBL_E562		;3d64	fd 21 62 e5 	. ! b . 
	ld de,0015h		;3d68	11 15 00 	. . . 
l3d6bh:
	add iy,de		;3d6b	fd 19 	. . 
	bit 4,(iy+000h)		;3d6d	fd cb 00 66 	. . . f 
	jr nz,l3d6bh		;3d71	20 f8 	  . 
	ld a,r		;3d73	ed 5f 	. _ 
	and 00ch		;3d75	e6 0c 	. . 
	or b			;3d77	b0 	. 
	ld (iy+000h),a		;3d78	fd 77 00 	. w . 
	ld hl,(THOMAS_POSITION)		;3d7b	2a 12 e7 	* . . 
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
	ld a,(EXT_RANDOM)		;3db2	3a 10 e0 	: . . 
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
	ld a,(EXT_RANDOM + 1)		;3e09	3a 11 e0 	: . . 
	ld hl,DATA_MOTHS_CONFIG + 12		;3e0c	21 0c e5 	! . . 
	cp (hl)			;3e0f	be 	. 
	ld hl,(DATA_MOTHS_CONFIG + 0)		;3e10	2a 00 e5 	* . . 
	jr c,l3e18h		;3e13	38 03 	8 . 
	ld hl,(DATA_MOTHS_CONFIG + 2)		;3e15	2a 02 e5 	* . . 
l3e18h:
	ld (iy+010h),l		;3e18	fd 75 10 	. u . 
	ld (iy+011h),h		;3e1b	fd 74 11 	. t . 
	ret			;3e1e	c9 	. 

; ToDo
; The following is data, and the labels are used.
l3e1fh:
	ld (bc),a			;3e1f	02 	. 
	nop			;3e20	00 	. 
	ld bc,0x0100		;3e21	01 00 01 	. . . 
	ld (bc),a			;3e24	02 	. 
	nop			;3e25	00 	. 
	nop			;3e26	00 	. 
	nop			;3e27	00 	. 
	nop			;3e28	00 	. 
	ld (bc),a			;3e29	02 	. 
	ld bc,0x0100		;3e2a	01 00 01 	. . . 
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sub_4000h:
	ld hl,(THOMAS_POSITION)
	ld de,(0e707h)
	ld a,(DRAGONS_LEVEL)
	and 001h
	jr z,l400fh
	ex de,hl	
l400fh:
	sbc hl,de
	ld a,001h
	jr nc,l4017h
	ld a,000h
l4017h:
	ld (THOMAS_STATE),a
	jr c,sub_402ch
	ld hl,0e703h
	ld a,(hl)	
	dec (hl)	
	and a	
	jr nz,sub_402ch
	call sub_433fh
	ld a,090h
	call PLAY_SOUND
sub_402ch:
	ld hl,(THOMAS_POSITION)
	ld a,(NUM_GRIPPING)
	and a	
	jp nz,l40adh
	ld a,(GAME_STATE)
	cp GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED
	jr z,l40adh
	ld a,(THOMAS_STATE)
	cp THOMAS_STATE_DAMAGED
	jr z,l40adh
	jr nc,l4080h
	cp THOMAS_STATE_JUMPING_AHEAD
	jr nc,l4055h
	cp THOMAS_STATE_WALKING
	jr nz,l40adh
	ld a,(THOMAS_FRAME)
	cp THOMAS_FRAME_READY
	jr z,l40adh
l4055h:
	ld a,(THOMAS_PROPS)
	bit 5,a ; Check which side Thomas is looking at
	ld a,(0e701h)
	ld de,l0029h
	jr z,l4089h
	and 020h ; Check which side Thomas is looking at
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
	ld a,(THOMAS_PROPS)
	and 020h ; Check if Thomas is fighting
	jr nz,l4098h ; Get out of the loop if he's not
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
	call DRAW_SCENARIO_COL
l40a9h:
	pop hl	
	ld (THOMAS_POSITION),hl
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
	ld de,0x80
	sbc hl,de
	jr c,l40ceh
	add hl,de	
	ld de,0x0680
	sbc hl,de
	jr nc,l40ceh
	add hl,de	
	ld (0e900h),hl
	ld hl,0x0100
	jr l40d6h
l40ceh:
	ld (0e900h),de
	ld de,0x0100
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
	ld (KNIFE_STATUS),hl
	ld a,(THOMAS_FRAME)
	add a,a	
	ld hl,SCENARIO_TILEMAP_ZONE_30
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
	call l0e20h
	ld a,(GAME_STATE)
	cp GAME_STATE_INTRO
	ret z	
	cp 007h
	ret z	
	cp 003h
	ld hl,(0e900h)
	jr nz,l4134h
	ex de,hl	
	ld hl,(HSCROLL_LOW_W)
	ld a,(0e101h)
	ld bc,2
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
	ld (HSCROLL_LOW_W),hl
	ld a,(0e33fh)
	and a	
	call z,sub_2ec1h
	ret

; SEGUIR
sub_413fh:
	call CHECK_DEMO_OR_VULNERABLE
	jr nz,l4150h ; Don't check the time if invulnerable
    ; Check time
	ld hl,(TIME)
	ld a,h	
	or l	
	jr nz,l4150h
    ; Time over: set Thomas must die :-O
	ld hl,THOMAS_DAMAGE_STATUS
	set 1,(hl)
l4150h:
	call sub_4174h
	ld hl,THOMAS_PROPS
	bit 4,(hl)
	jr z,l4168h
	bit 5,(hl) ; Check at which side Thomas is looking at
	jr z,l4163h
	bit 6,(hl) ; Check if the knifer at level 2 should throw his dagger to the right
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
	ld a,(DRAGONS_LEVEL)
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
	ld a,(GAME_STATE)
	cp GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED
	jp z,l46a0h
	call sub_4704h
	ld hl,THOMAS_STATE
	ld a,(hl)	
	cp THOMAS_STATE_DAMAGE_JUMPING
	jp z,l45f6h
	cp THOMAS_STATE_FRONTAL_KICK
	jp c,l4289h
	cp THOMAS_STATE_DAMAGED
	jp z,l44deh
	jp nc,l4502h
	cp THOMAS_STATE_JUMPING
	jp nc,l4406h
    ; Check if Thomas is dying
	ld a,(THOMAS_DAMAGE_STATUS)
	and 1
	jp nz,l4551h ; Jump if Thomas is dying
    ; Thomas is not dying :)
	ld a,(PLAYER_MOVE)
	ld d,a	
	ld a,(hl)	
	cp 006h
	jr nc,l41d6h
	bit 2,d
	jp nz,l4387h
l41d6h:
	bit 3,d
	jp nz,l43b5h
	ld hl,THOMAS_PROPS
	bit 1,d 
	jr z,l41e4h
	res 5,(hl) ; Check at which side Thomas is looking at
l41e4h:
	bit 0,d
	jr z,l41eah
	set 5,(hl) ; Set Thomas looks to the right
l41eah:
	ld hl,0e703h
	dec (hl)	
	jr nz,l4229h
	ld a,(THOMAS_HEIGHT_COUNTER)
	inc a	
	jr z,l4240h
	dec a	
	jr nz,l4212h
	inc a	
	ld (THOMAS_HEIGHT_COUNTER),a
	ld hl,(0e70ah)
	ld a,(hl)	
	ld (0e703h),a
	inc hl	
	ld a,(0e701h)
	and (hl)	
	ld (0e701h),a
	inc hl	
	ld a,(hl)	
	ld (THOMAS_FRAME),a
	ret	
l4212h:
	ld hl,THOMAS_STATE
	ld a,(hl)	
	cp THOMAS_STATE_DOWN_KICK
	ld bc,00400h
	jr c,l4220h
	ld bc,00503h
l4220h:
	ld (hl),c	
	ld a,b	
	ld (THOMAS_FRAME),a
	inc hl	
	ld (hl),005h
	ret	
l4229h:
	ld a,(THOMAS_HEIGHT_COUNTER)
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
	ld (THOMAS_HEIGHT_COUNTER),a
	ld d,a	
	ld a,(THOMAS_STATE)
	sub 004h
	add a,a	
	ld e,a	
	add a,a	
	add a,e	
	ld e,a	
	ld hl,SCENARIO_TILEMAP_ZONE_26
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
	ld (THOMAS_FRAME),a
	inc (hl)	

; SEGUIR
sub_4279h:
	ld a,(INT_COUNTER + 4)
	and a	
	ret nz	
	ld a,00bh
	ld (INT_COUNTER + 4),a
	ld a,082h
	call PLAY_SOUND
	ret	

l4289h:
    ; Check if Thomas is dying
	ld a,(THOMAS_DAMAGE_STATUS)
	bit 1,a
	jp nz,l4636h ; Jump if he's dying

    ; Thomas is not dying    
    ; Check if Thomas is receiving damage
	bit 0,a
	jp nz,l455ah ; Jump if he's receiving damage

    ; Thomas is not receiving damage
	ld a,(0e703h)
	dec a	
	jp m,l42a0h
	ld (0e703h),a
l42a0h:
	ld a,(PLAYER_MOVE)
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
	ld hl,THOMAS_STATE
	ld a,(hl)	
	cp THOMAS_STATE_DUCKING_1
	ld (hl), THOMAS_STATE_IDLE
	jp nc,l4347h
	cp THOMAS_STATE_IDLE
	ld a,(0e705h)
	jr z,l42d3h
	ld a,005h
l42d3h:
	dec a	
	ld (0e705h),a
	ret nz	
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
	ret	
l42dfh:
	ld hl,(THOMAS_POSITION)
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
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
	jr l42bfh
l4307h:
	ld hl,(THOMAS_POSITION)
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
	ld a,(THOMAS_STATE)
	cp THOMAS_STATE_FRONTAL_KICK
	jr nz,l432bh
	ld a,THOMAS_STATE_FRONTAL_PUNCH
	ld (0e703h),a
l432bh:
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
l4331h:
	ld hl,THOMAS_STATE
	ld a,THOMAS_STATE_WALKING
	cp (hl)	
	ld (hl),a	
	jr c,l4347h
	ld a,(0e703h)
	and a	
	ret nz	

; SEGUIR
sub_433fh:
	ld a,(THOMAS_FRAME)
	inc a	
	cp THOMAS_FRAME_READY
	jr c,l4349h
l4347h:
	ld a,THOMAS_FRAME_NORMAL
l4349h:
	ld (THOMAS_FRAME),a
	ld a, THOMAS_FRAME_DOWN
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
	ld hl,(THOMAS_POSITION)
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
	ld (THOMAS_FRAME),a
	ld a,0ffh
	ld (THOMAS_HEIGHT_COUNTER),a
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
	ret	
l4387h:
	ld a,(hl)	
	cp 002h
	jr z,l43a5h
	cp 003h
	ret z	
	ld (hl),002h
	ld hl,(THOMAS_POSITION)
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
	ld a,THOMAS_STATE_DUCKING_2
	ld (THOMAS_STATE),a
	ld a, THOMAS_FRAME_DOWN
	ld (THOMAS_FRAME),a
	ret	
l43b5h:
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
l43bdh:
	ld hl,(THOMAS_POSITION)
	ld de,(0e707h)
	ld a,(THOMAS_PROPS)
	and 020h    ; Check if Thomas is fighting
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
	ld (THOMAS_STATE),a
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
	ld hl,SCENARIO_TILEMAP_ZONE_27
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
	ld (THOMAS_FRAME),a
	ret	
l4406h:
    ; Check if Thomas is receiving damage
	ld hl,THOMAS_DAMAGE_STATUS
	bit 0,(hl)
	jp nz,l464bh ; Jump if Thomas is receiving damage

    ; Thomas is not receiving damage
	ld a,(NUM_GRIPPING)
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
	ld a,(THOMAS_HEIGHT_COUNTER)
	dec a	
	jr nz,l4445h
	inc hl	
	ld a,(hl)	
	and a	
	jr z,l446eh
	inc hl	
	ld (0e70eh),hl
l4445h:
	ld (THOMAS_HEIGHT_COUNTER),a
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
	ld hl,0500h
	ld (THOMAS_STATE),hl ;THOMAS_STATE_IDLE
	ld a, THOMAS_FRAME_READY
	ld (THOMAS_FRAME),a
	ld hl,0x5000
	ld (0e710h),hl
	ld hl,(THOMAS_POSITION)
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
	ld (THOMAS_FRAME),a
	ret	
l44a7h:
	bit 7,c
	jr z,l44a0h
	ld a,(PLAYER_MOVE)
	and 030h
	jr z,l44a0h
	ld b,0f8h
	bit 4,a
	jr nz,l44c1h
	ld b,0fbh
	ld a,081h
	call PLAY_SOUND
	jr l44c4h
l44c1h:
	call sub_4279h
l44c4h:
	ld a,(THOMAS_STATE)
	add a,b	
	add a,a	
	ld d,000h
	ld e,a	
	ld hl,SCENARIO_TILEMAP_ZONE_28
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
    ; Check if Thomas is dying
	ld a,(THOMAS_DAMAGE_STATUS)
	and 001h
	jr nz,l455ah ; Jump if Thomas is dying
	
    ; Thomas is not dying
    ld hl,0e703h
	dec (hl)	
	ret nz	
	ld hl,THOMAS_STATE
	ld a,(THOMAS_FRAME)
	cp THOMAS_FRAME_DOWN
	ld (hl),THOMAS_STATE_DUCKING_2
	ret z	
	ld (hl),THOMAS_STATE_IDLE
	ld a,000h
	ld (THOMAS_FRAME),a
	ld a,THOMAS_FRAME_DOWN
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
	ld (THOMAS_FRAME),a
	inc hl	
	ld a,(hl)	
	inc hl	
	ld (0e703h),a
	ld (0e70ah),hl
    ; Set Thomas is not fighting
	ld hl,THOMAS_PROPS
	set 1,(hl)
l4521h:
	ld de,(0e70eh)
	ld hl,(0e707h)
	add hl,de	
	ld (0e70eh),hl
	ld hl,(0e710h)
	sbc hl,de
	ld (0e710h),hl
	ld hl,(THOMAS_POSITION)
	ld de,(0e70ch)
	ld a,(THOMAS_PROPS)
	and 020h    ; Check if Thomas is fighting
	jr z,l4546h
	sbc hl,de
	jr l4547h
l4546h:
	add hl,de	
l4547h:
	ld (THOMAS_POSITION),hl
	ret	
l454bh:
	ld a, GAME_STATE_LIFE_LOST
	ld (GAME_STATE),a
	ret	
l4551h:
	ld a,(hl)	
	cp 006h
	ld a,005h
	jr nc,l4564h
	jr l4561h
l455ah:
	ld a,(THOMAS_FRAME)
	cp THOMAS_FRAME_DOWN
	jr z,l4567h
l4561h:
	call sub_468eh
l4564h:
	ld (THOMAS_FRAME),a
l4567h:
	call sub_2e91
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
    
    ; Set Thomas is not receiving damage 
	ld hl,THOMAS_DAMAGE_STATUS
	res 0,(hl)

	ld a,008h
	ld (0e703h),a
	ld hl,ENERGY_TO_SUBTRACT
	ld a,(ENERGY)
	and a	
	scf	
	jp m,l4591h
	sub (hl)	
	ld (ENERGY),a
l4591h:
	ld hl,THOMAS_STATE
	ld (hl),THOMAS_STATE_DAMAGED
	ret nc	
	call CHECK_DEMO_OR_VULNERABLE
	ret nz	
	inc (hl)	
	ld a,(ORIGIN_OF_DAMAGE)
l459fh:
	and a	
	push af	
	ld a,000h
	call PLAY_SOUND
	ld a,087h
	call PLAY_SOUND
	pop af	
	ld hl,l45ech
	ld de,000ch
	ld bc,0012h
	jr nz,l45dah
	ld hl,(THOMAS_POSITION)
	ld de,(ENEMY_POS)
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
	ld de,l0039h
	ld bc,001bh
l45dah:
	ld (0e70ah),hl
	ld (0e70ch),de
	ld (0e707h),bc
	ld hl,0
	ld (0e70eh),hl
	ret	
l45ech:
	ld (l2309h+1),hl
	jr $+1
l45f1h:
	inc h	
	ex af,af'	
	dec h	
	ld d,0ffh
l45f6h:
    ; Check if Thomas is receiving damage
	ld hl,THOMAS_DAMAGE_STATUS
	bit 0,(hl)
	jr z,l4609h ; Jump if Thomas is not receiving damage
	
    ; Thomas is receiving damage
    call sub_2e91
	call LOSE_ENERGY_AND_UPDATE_DAMAGE_STATUS
	call sub_468eh
	ld (THOMAS_FRAME),a
l4609h:
	ld de,(0e70eh)
	ld hl,0012h
l4610h:
	add hl,de	
	ld (0e70eh),hl
	ld hl,(0e710h)
	sbc hl,de
	ex de,hl	
	ld hl,M62_HSCROLL_HIGH_W
	add hl,de	
	jr nc,l4625h
	ld (0e710h),de
	ret	
l4625h:
    ; Check if Thomas is dying
	ld hl,0x5000
	ld hl,THOMAS_DAMAGE_STATUS ; Debug? It discards 0x5000 and loads a different value
	bit 1,(hl)
	jr z,l4643h ; Jump if Thomas is not dying
    ; Thomas is dying
    ; Set Thomas is not dying
	res 1,(hl) 
	call CHECK_DEMO_OR_VULNERABLE
	jr nz,l4643h  ;4634  20 0D
l4636h:
	ld a,THOMAS_STATE_DEAD
	ld (THOMAS_STATE),a
	ld a,005h
	ld (0e703h),a
	jp l459fh
l4643h:
	ld hl,THOMAS_STATE
	ld (hl),THOMAS_STATE_IDLE
	jp l4347h
l464bh:
	call sub_2e91
	call LOSE_ENERGY_AND_UPDATE_DAMAGE_STATUS
	call sub_468eh
	jr l4658h
l4656h:
	ld a, THOMAS_FRAME_JUMP_IMPULSE
l4658h:
	ld (THOMAS_FRAME),a

	ld a,THOMAS_STATE_DAMAGE_JUMPING
	ld (THOMAS_STATE),a

	ld hl,0x80
	ld (0e70eh),hl
	ld hl,(THOMAS_POSITION)
	ld (0e707h),hl
	ld a,(0e701h)
	and 0fch
	ld (0e701h),a
	ret

; Perform energy loss and update Thomas' damage status    
LOSE_ENERGY_AND_UPDATE_DAMAGE_STATUS:
	ld hl,ENERGY_TO_SUBTRACT
	ld a,(ENERGY)
	and a	
	jp m,l4684h
	sub (hl) ; A = ENERGY - [ENERGY_TO_SUBTRACT]
	ld c, 0 ; Not receiving damage and not dying
	jr nc,l4686h
l4684h:
    ; Negative energy, set C = 2 (dying)
	ld c, 2
l4686h:
	ld (ENERGY),a ; Update decreased energy
    ; Update damage status
	ld hl,THOMAS_DAMAGE_STATUS
	ld (hl),c	
	ret

sub_468eh:
	ld hl,(0e710h)
	ld de,1800h
	add hl,de	
	ld de,(HEIGHT_OF_DAMAGE_TO_THOMAS)
	sbc hl,de
	ld a,020h
	ret c	
	inc a	
	ret

l46a0h:
	call GET_CURRENT_LEVEL
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
	ld hl,(THOMAS_POSITION)
	ld de,0x0100
	ld a,(0e101h)
	and a	
	jr z,l46c9h
	add hl,de	
	jr l46cbh
l46c9h:
	sbc hl,de
l46cbh:
	ld (THOMAS_POSITION),hl
	ld hl,(0e710h)
	ld de,0600h
	add hl,de	
	ld (0e710h),hl
l46d8h:
	ld a,(THOMAS_FRAME)
	inc a	
	cp THOMAS_FRAME_JUMP_PAIN
	jr nz,l46e2h
	ld a,01ch
l46e2h:
	ld (THOMAS_FRAME),a
	and 001h
	ret nz	
	ld a,090h
	call PLAY_SOUND
	ret	
l46eeh:
	ld a,GAME_STATE_LEVEL_ENDS
	ld (GAME_STATE),a
	ret	
l46f4h:
	ld a,(THOMAS_FRAME)
	cp THOMAS_FRAME_WITH_SILVIA
	ret nz	
	ld a, GAME_STATE_LEVEL_ENDS
	ld (GAME_STATE),a
	xor a	
l4700h:
	ld (SILVIA_LEFT_OR_RIGHT),a
	ret

sub_4704h:
	ld hl,(0e102h)
	ld de,(THOMAS_POSITION)
	call GET_CURRENT_LEVEL
	cp 004h
	jr z,l4784h
	ld a,(0e101h)
	cp 001h
	ld iy,0x5000
	jr c,l4723h
	ret nz	
	ld iy,5200h
	ex de,hl	
l4723h:
	and a	
	sbc hl,de
	ret c	
	push hl	
	ld hl,(0e710h)
	ld de,0x5000
	sbc hl,de
	jr c,l4782h
	add hl,hl	
	ld a,h	
	pop hl	
	ld b,00ch
l4737h:
	sub 00ch
	jr c,l4749h
	ld de,0x0100
	sbc hl,de
	ret c	
	ld de,0600h
	add iy,de
	dec b	
	jr l4737h
l4749h:
	ld (0e710h),iy
	ld a,000h
	call PLAY_SOUND
	ld a, GAME_STATE_GO_UPSTAIRS_OR_SILVIA_RESCUED
	ld (GAME_STATE),a
	ex de,hl	
	ld hl,(THOMAS_POSITION)
	ld a,(0e101h)
	and a	
	jr z,l4766h
	sbc hl,de
	ld de,0x0100
l4766h:
	add hl,de	
	ld (THOMAS_POSITION),hl
    ; Set Thomas is not fighting
	ld hl,THOMAS_PROPS
	set 1,(hl)
	ld a, THOMAS_FRAME_JUMP_KICK
	ld (THOMAS_FRAME),a
	ld a,008h
	ld (0e703h),a
	ld a,001h
	ld (0e705h),a
	ld a,b	
	ld (THOMAS_HEIGHT_COUNTER),a
l4782h:
	pop af	
	ret	
l4784h:
	sbc hl,de
	ret c	

	ld a,(THOMAS_STATE)
	cp THOMAS_STATE_DUCKING_1
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
	ld (GAME_STATE),a
	ld a,000h
	call PLAY_SOUND
	pop af	
	ld a, THOMAS_FRAME_STANDING
	ld (THOMAS_FRAME),a
	ret	

sub_47b6h:
	ld ix,SILVIA_STATE
	bit 4,(ix + 0)
	call nz,sub_4821h
	ld ix,SILVIA_LEFT_OR_RIGHT
	ld c,(ix + 0)
	bit 4,c
	ret z	
	ld a,(ix + 1)
	cp 001h
	jr c,l480bh
	jr z,l47e7h
sub_47d4h:
	ld de,001bh
	call l1beah
	ld de,0ff20h
	add hl,de	
	jr c,sub_4821h
	ld a, THOMAS_FRAME_WITH_SILVIA
	ld (THOMAS_FRAME),a
	jr sub_4821h

l47e7h:
	dec (ix + 7)
	jr nz,sub_4821h
	ld (ix + 7),00bh
	inc (ix + 6)
	ld a,(ix + 6)
	cp 007h
	jr c,sub_4821h
	ld (ix + 7),007h
	inc (ix + 1)
	ld (ix + 6),001h
	set 4,(ix + 12)
	jr sub_4821h
l480bh:
	dec (ix + 7)
	jr nz,sub_4821h
l4810h:
	ld (ix + 7),008h
	ld a,(ix + 6)
	inc a	
	cp 005h
	jr z,l481eh
	ld a,004h
l481eh:
	ld (ix + 6),a
sub_4821h:
	call l1be2h
	ld de,0ee00h
	add hl,de	
	ret c	
	ld hl,SCENARIO_TILEMAP_ZONE_34
	jp l1a7dh

; Update the effective PLAYER_MOVE.
; It takes into account if it's in player mode (fake input) or if
; Thomas is being gripped.
; SEGUIR: give a name
UPDATE_PLAYER_MOVE:
	ld a,(GAME_STATE)
	cp GAME_STATE_DEMO
	jr nz,l484dh
    ; We're in demo mode, so we'll write values to PLAYER_MOVE
    
    ; Control demo timing
	ld hl,0e022h
	dec (hl)	
	ret nz ; Exit to prevent moving too fast
    
	ex de,hl	
	ld hl,(DEMO_FAKE_INPUT_ADDR) ; HL: fake input table
    
    ; Read fake input
	ld a,(hl)	
	cp 0ffh
	jr z,l4878h ; Exit if finished
    
	inc hl	
	ld (de),a ; Save fake input entry #1 in (DE)
    
    ; Read fake input entry #2
	ld a,(hl)	
	inc hl	
	ld (DEMO_FAKE_INPUT_ADDR),hl ; Update current fake input table pointer
	jr l4874h ; Set fake input in A
l484dh:
	ld a,(PLAYER_INPUT)
	and 4 ; Bit 2: joystick pushing down
    ; Check if Thomas is frozen
	ld hl,THOMAS_PROPS
	bit 0,(hl)
	jr nz,l4874h ; If he's frozen, don't read any input
	ld a,(PLAYER_INPUT)
	and 7 ; Bits 0, 1, 2: joystick right, left, or down
	ld c,a	
	ld a,(NUM_GRIPPING)
	and a	
	ld a,c	
	jr nz,l4874h ; Thomas is being gripped, so he can't move: skip update
    ; Skipping the update means he'll be able to kick (but it won't have any effect).
    
    ; Decode PLAYER_BUTTONS_AND_UP into PLAYER_MOVE
	ld a,(PLAYER_BUTTONS_AND_UP)
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
	ld (PLAYER_MOVE),a
	ret
l4878h:
	ld a, GAME_STATE_LIFE_LOST
	ld (GAME_STATE),a
	ret

l487eh:
	di	
	ld sp,0f000h
	xor a	
	ld (IN_PLAY),a
	ld (EXT_TICKS),a
	ld (EXT_TICKS + 1),a
	ld (DRAGONS_LEVEL),a
	ei	
	call CLS_CYAN_AND_PAUSE
	call sub_064a ; Some kind of init
    
    ; Write IREM copyright
	ld hl,IREM_COPYRIGHT_STR
	call WRITE_TEXT

	ld hl,l4f01h
	ld (0e70eh),hl

	ld a,09ch
	ld (0e705h),a

	ld hl,030a0h
	ld (THOMAS_POSITION),hl

	ld hl,SCENARIO_TILEMAP_ZONE_10
	ld (0e710h),hl
	ld (0e344h),hl

	ld hl,034a0h
	ld (0e342h),hl

	ld a,010h
	ld (SILVIA_LEFT_OR_RIGHT),a

	ld a,005h
	ld (0e347h),a

	ld ix,TBL_GUYS
	ld bc, (7 << 8) | (1 << ENEMY_IS_ALIVE_BIT) | (1 << ENEMY_MOVE_RIGHT_BIT);
	ld hl, 3840 ; Position of guy
	ld b, 7 ; 7 guys in the intro. However, the programmer already set B with ld bc,0750h. Question: debug?
iterate_guys_intro:
    ; IX = TBL_GUYS
	ld (ix + ENEMY_HEIGHT_L_IDX), 0
	ld (ix + ENEMY_HEIGHT_H_IDX), 92 ; Distance (from top) of the enemy

	ld (ix + ENEMY_FRAME_COUNTER_IDX), 7
	ld (ix + ENEMY_ATTACK_STEP_IDX), 038h
	ld (ix + THOMAS_LAST_SHAKE_MOVE),b

	ld (ix + ENEMY_PROPS_IDX),c ; 48e5

    ; Set position to HL
	ld (ix + ENEMY_POS_L_IDX),l
	ld (ix + ENEMY_POS_H_IDX),h

	ld a,b ; A = current index, 7, ..., 0.
	cp 7
	jr z,l48fbh
	cp 4
	jr c,l48fbh
	ld (ix + ENEMY_FRAME_IDX), 10
l48fbh:
	cp 5
	jr nc,next_guy_intro
l48ffh:
    ; Change position for guys coming from the right
	ld hl, 12544
    ; Set looking direction.
    ; 0x10: look left, not being attacked, enemy is alive
	ld c, 1 << ENEMY_IS_ALIVE_BIT
next_guy_intro: ; 4902
    ; Next guy in TBL_GUYS
	ld de, 16
	add ix,de
	djnz iterate_guys_intro

;490B
    ; Set game state to INTRO
	ld a, GAME_STATE_INTRO
	ld (GAME_STATE),a
    
    ; The text "A KUNG-FU MASTER, ... UNKNOWN GUYS" appears
    ; Thomas and Silvia walk in
	ld de,0d152h
	ld c,00bh
	ld hl,INTRO_STR
	call l1134h

l491bh:
	ld a,(EXT_TICKS)
	cp 8
l4920h:
	jr nz,l491bh

	call WRITE_TEXT
l4925h:
	ld a,(EXT_TICKS)
	cp 00bh
	jr nz,l4925h
	call ERASE_INTRO_TEXT
	ld hl,4c0eh
	call l1134h
	ld a,0e1h
	call DELAY_A
	call ERASE_INTRO_TEXT
	ld hl,LARGE_KUNG_FU_MASTER_LOGO
	call WRITE_TEXT
l4943h:
	call PRINT_X_COINS_Y_PLAYERS_BLINKING
	ld a,(GAME_STATE)
	cp GAME_STATE_LIFE_LOST
	jr nz,l4943h
	xor a	
	ld hl,0
	ld (POINTS),a
	ld (POINTS + 1),hl
	inc a	
	ld (LIVES),a
	ld (0e022h),a

	ld hl,DEMO_LEVEL
	ld a,(hl)	
	ld (hl), 9 ; Who knows why the programmer used 9 here. Why not :)
	ld de,FAKE_INPUT_LEVEL_1 ; Fake input for demo level #1
	and a	
	jr z,l496fh
	ld de,FAKE_INPUT_LEVEL_2 ; Fake input for demo level #2

	ld (hl),000h
l496fh:
	ld (DRAGONS_LEVEL),a
	ld (DEMO_FAKE_INPUT_ADDR),de
	call CLEAR_TILEMAP
	ld a,001h
	call ANIMATION_THOMAS_STARTS_LEVEL
	di	
	ld a, GAME_STATE_DEMO
	ld (GAME_STATE),a
	ld hl,0
	ld (POINTS),hl
	ld (POINTS + 1),hl
	ld (EXT_RANDOM),hl
	ld (0e012h),hl
	ei	
l4994h:
	call DECREASE_TIME_UPDATE_PANEL
	ld a,(GAME_STATE)
	cp GAME_STATE_LIFE_LOST
	jr nz,l4994h
	ld a,038h
	call DELAY_A
	call PRINT_SCORE_BOARD
	ld a,0e1h
	call DELAY_A
	jp l487eh

; Clears the intro text, line by line
ERASE_INTRO_TEXT:
	ld de,0d150h
	ld b,004h
l49b3h:
	push de	
	call ERASE_LINE
	pop hl	
	ld de,0x80
	add hl,de	
	ex de,hl	
	djnz l49b3h
	ret

; Print the "X COIN(S)  Y PLAYER(S)" text, and control the blinking.
PRINT_X_COINS_Y_PLAYERS_BLINKING:
	ld de,0d316h
	ld bc,0190bh
    
	; This controls the blinking of the text "X COIN(S)  Y PLAYER(S)"
    ld a,(INT_COUNTER)
	and 030h
	jp z,l571fh

	ld hl,(COINS_PER_CREDITS_A)
	ld a,l	
	xor h	
	jr nz,l49e9h
	inc de
    
    ; Print the "X COIN(S)  Y PLAYER(S)" text
	call PRINT_X_COINS_Y_PLAYERS ; 49d6

	bit 3,l
	ret nz	
	ld de,0d397h
	ld a,l	
	add a,a	
	daa	
	call PRINT_NUMBER_AND_WORD ; Print the number in "X COIN(S)"
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
PRINT_X_COINS_Y_PLAYERS:
	bit 3,l
	ld a,001h
	jr nz,l49feh
	ld a,l	
l49feh:
	call PRINT_NUMBER_AND_WORD
	bit 3,l
	ld a,001h
	jr z,l4a0ah
	ld a,l	
	and 007h
l4a0ah:
	push hl	
	ld hl,PLAYER_STR
	jr l4a14h

; Prints a number and a word.
; For example, "3 coins".
; It's used when printing the text "X COIN(S)   Y PLAYER(S)"
PRINT_NUMBER_AND_WORD:
	push hl	
	ld hl,COIN_STR
l4a14h:
	push af	
	push bc	
	ld c,b	
	call PRINT_NUMBER ; Text 
	pop bc	
	inc de	
	call WRITE_TEXT
	pop af

	push de	
	cp 001h
	ld a, 'S' ; Add a "S" to write plural "PLAYERS" (or "COINS") instead of "PLAYER"
	call nz,WRITE_CHAR_AT_SCREEN_DE
	pop de	
	inc de	
	pop hl	
	ret

;SEGUIR
sub_4a2ch:
	call WRITE_CHAR_AT_SCREEN_DE
	ld a, '-'
	jp WRITE_CHAR_AT_SCREEN_DE


COIN_STR: defb "COIN", 0ffh ;4a34
PLAYER_STR: defb "PLAYER", 0ffh ;4a39
SPACES_STR: defb "                    ", 0ffh ;4a40

; These are the fake inputs for Thomas during the demos, for
; levels 1 and 2.
FAKE_INPUT_LEVEL_1: ; 0x4A55
db 0x42, 0x2, 0x1, 0x20, 0x28, 0x2, 0x2, 0x10; 0x4a55 - 0x4a5c
db 0x18, 0x2, 0x3, 0x10, 0x18, 0x2, 0x2, 0x10; 0x4a5d - 0x4a64
db 0x24, 0x2, 0x2, 0x20, 0x38, 0x2, 0x10, 0x4; 0x4a65 - 0x4a6c
db 0x2, 0x20, 0x1e, 0x2, 0x10, 0x8, 0x2, 0x20; 0x4a6d - 0x4a74
db 0x2c, 0x1, 0x4, 0x20, 0x28, 0x2, 0x8, 0x1; 0x4a75 - 0x4a7c
db 0x2, 0x10, 0x28, 0x1, 0x10, 0x8, 0x18, 0x20; 0x4a7d - 0x4a84
db 0x8, 0x1, 0x40, 0x2, 0x8, 0x8, 0x8, 0x20; 0x4a85 - 0x4a8c
db 0x48, 0x2, 0x3, 0x1, 0x3, 0x2, 0x3, 0x1; 0x4a8d - 0x4a94
db 0x3, 0x6, 0x3, 0x5, 0x3, 0x6, 0x3, 0x1; 0x4a95 - 0x4a9c
db 0x3, 0x2, 0x3, 0x1, 0x3, 0x1, 0x3, 0x2; 0x4a9d - 0x4aa4
db 0x3, 0x1, 0x3, 0x6, 0x3, 0x5, 0x3, 0x6; 0x4aa5 - 0x4aac
db 0x3, 0x1, 0x3, 0x2, 0x3, 0x1, 0x3, 0x2; 0x4aad - 0x4ab4
db 0x3, 0x1, 0x3, 0x6, 0x3, 0x5, 0x3, 0x6; 0x4ab5 - 0x4abc
db 0x3, 0x1, 0x18, 0x2, 0x2, 0x8, 0x48, 0x2; 0x4abd - 0x4ac4
db 0x2, 0x10, 0x18, 0x0, 0x2, 0x10, 0x18, 0x0; 0x4ac5 - 0x4acc
db 0xa, 0x1, 0xa, 0x4, 0x2, 0x10, 0x18, 0x4; 0x4acd - 0x4ad4
db 0x2, 0x20, 0x18, 0x4, 0x2, 0x10, 0x10, 0x4; 0x4ad5 - 0x4adc
db 0x28, 0x1, 0x3, 0x20, 0x20, 0x1, 0x3, 0x20; 0x4add - 0x4ae4
db 0x18, 0x1, 0x3, 0x20, 0x8, 0x0, 0x28, 0x2; 0x4ae5 - 0x4aec
db 0x8, 0x4, 0x3, 0x20, 0x10, 0x10, 0x34, 0x2; 0x4aed - 0x4af4
db 0x4, 0x8, 0x10, 0x20, 0x28, 0x2, 0x5, 0x1; 0x4af5 - 0x4afc
db 0x5, 0x2, 0x5, 0x1, 0x5, 0x6, 0x5, 0x5; 0x4afd - 0x4b04
db 0x5, 0x6, 0x80, 0x0, 0xff ; 0x4b09

    
FAKE_INPUT_LEVEL_2: ; 0x4B0A
db 0x1c, 0x1, 0x4, 0x0, 0x1, 0x10, 0x44, 0x1; 0x4b0a - 0x4b11
db 0x10, 0x0, 0x28, 0x1, 0x2, 0x20, 0x10, 0x2; 0x4b12 - 0x4b19
db 0x20, 0x1, 0x2, 0x8, 0x50, 0x1, 0x2, 0x8; 0x4b1a - 0x4b21
db 0x36, 0x1, 0xa, 0x2, 0x30, 0x0, 0x10, 0x10; 0x4b22 - 0x4b29
db 0x20, 0x0, 0x1b, 0x2, 0x2, 0x8, 0x10, 0x10; 0x4b2a - 0x4b31
db 0x48, 0x2, 0x2, 0x8, 0x10, 0x20, 0x28, 0x4; 0x4b32 - 0x4b39
db 0x2, 0x20, 0x20, 0x4, 0x68, 0x1, 0xa, 0x0; 0x4b3a - 0x4b41
db 0x4, 0x20, 0x10, 0x2, 0x10, 0x0, 0x28, 0x1; 0x4b42 - 0x4b49
db 0x1, 0x2, 0x60, 0x4, 0x38, 0x1, 0x2, 0x8; 0x4b4a - 0x4b51
db 0x10, 0x10, 0x30, 0x0, 0x50, 0x1, 0x20, 0x2; 0x4b52 - 0x4b59
db 0x2, 0x8, 0x10, 0x20, 0x20, 0x0, 0x18, 0x2; 0x4b5a - 0x4b61
db 0x10, 0x8, 0x10, 0x20, 0x10, 0x0, 0x40, 0x1; 0x4b62 - 0x4b69
db 0xa0, 0x4, 0xff ; 0x4b6a - 0x4b6c

IREM_COPYRIGHT_STR:
	cp 01dh		;4b6d
	defb 0fdh,0d8h,0d6h
	defb "@ 1984 "
	defb 0feh, 0dah
	defb "IREM CORP.", 0ffh

INTRO_STR: ; 4b86
	defb "A KUNG-FU MASTER,"
	defb 0feh, 01ah
	defb "THOMAS"
	defb 0feh, 00bh
	defb " AND "
	defb 0fdh, 0d2h, 0d1h, 0feh, 01ah
	defb "SILVIA"
	defb 0feh, 00bh
	defb " WERE SUDDENLY ATTACKED "
	defb 0fdh, 052h, 0d2h
	defb "BY SEVERAL UNKNOWN GUYS.", 0ffh
	defb 0fdh,0d0h,0d2h
	defb "("
	defb 0feh, 01ah
	defb "SILVIA"
	defb 0feh, 00bh
	defb " WAS KIDNAPPED BY THEM.)", 0ffh
	defb 0fdh,053h,0d1h
	defb "LATER "
	defb 0feh, 01ah
	defb "THOMAS"
	defb 0feh, 00bh
	defb " FOUND A LETTER "
	defb 0fdh, 0d3h, 0d1h
	defb "FROM "
	defb 0feh, 01ah
	defb "X"
	defb 0feh, 00bh
	defb ". "
	defb 0fdh,053h,0d2h
	defb "HE IS AN INHABITANT OF THE "
	defb 0fdh, 0d3h, 0d2h
	defb "DEVIL'S TEMPLE.", 0ffh

; The large "KUNG-FU MASTER" fancy logo text
LARGE_KUNG_FU_MASTER_LOGO: ; 0x4C71
db 0xfe, 0xda, 0xfd, 0xda, 0xd0, 0x80, 0x81, 0x82; 0x4c71 - 0x4c78
db 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a; 0x4c79 - 0x4c80
db 0xfd, 0x1a, 0xd1, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f; 0x4c81 - 0x4c88
db 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0xfd, 0x57; 0x4c89 - 0x4c90
db 0xd1, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c; 0x4c91 - 0x4c98
db 0x9d, 0x9e, 0x9f, 0xa0, 0xa1, 0xa2, 0xa3, 0xa4; 0x4c99 - 0x4ca0
db 0xa5, 0xa4, 0xa6, 0xfd, 0x96, 0xd1, 0xa7, 0xa8; 0x4ca1 - 0x4ca8
db 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0; 0x4ca9 - 0x4cb0
db 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb3; 0x4cb1 - 0x4cb8
db 0xb8, 0xb9, 0xfd, 0xd6, 0xd1, 0xba, 0xbb, 0xbc; 0x4cb9 - 0x4cc0
db 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4; 0x4cc1 - 0x4cc8
db 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc; 0x4cc9 - 0x4cd0
db 0xcd, 0xfd, 0x15, 0xd2, 0xce, 0xcf, 0xd0, 0xd1; 0x4cd1 - 0x4cd8
db 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9; 0x4cd9 - 0x4ce0
db 0x6, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0xe0; 0x4ce1 - 0x4ce8
db 0xe1, 0xfd, 0x55, 0xd2, 0xe2, 0xe3, 0xe4, 0xe5; 0x4ce9 - 0x4cf0
db 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed; 0x4cf1 - 0x4cf8
db 0x6, 0xee, 0xef, 0xf0, 0xf1, 0x6, 0xf2, 0xf3; 0x4cf9 - 0x4d00
db 0xf4, 0xf5, 0xfd, 0x95, 0xd2, 0xf6, 0xf7, 0xf8; 0x4d01 - 0x4d08
db 0xf9, 0xfa, 0xfb, 0x70, 0x71, 0x72, 0x73, 0x74; 0x4d09 - 0x4d10
db 0x75, 0x6, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b; 0x4d11 - 0x4d18
db 0x7c, 0x7d, 0x7e, 0xff ; 0x4d19 - 0x4d1c

l4d1dh:
	ld a, GAME_STATE_LIFE_LOST
	ld (GAME_STATE),a
	jr l4d54h

sub_4d24h:
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
    
    ; Increment external ticks
	ld hl,EXT_TICKS
	inc (hl)	
l4d43h:
	bit 5,a
	jr z,l4d54h
	push af	
	ld hl,SCENARIO_TILEMAP_ZONE_29
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
	ld (EXT_TICKS + 1),a
	inc de	
	ld a,(de)	
	ld (0e705h),a
	inc de	
	ld a,(de)	
	ld (THOMAS_FRAME),a
	inc de	
	ld (0e70eh),de
l4d7fh:
	ld a,(EXT_TICKS + 1)
	ld hl,l4dbch
	call l1f26h
	ld a,(EXT_TICKS)
	ld ix,SILVIA_LEFT_OR_RIGHT
	ld c,(ix + 0)
	cp 00ah
	jr z,l4da0h
	jr nc,l4da9h
	and a	
	jr nz,l4da6h
	call sub_47d4h
	jr l4da9h
l4da0h:
	ld de,l0036h
	call ENEMY_GO_BACK_POSITION
l4da6h:
	call sub_4821h
l4da9h:
	ld a,(EXT_TICKS)
	ld ix,TBL_GUYS
	ld c,(ix + 0)
	ld hl,04dc2h
	call l1f26h
	jp 02d72h
l4dbch:
	jp m,124dh
	ld c,(hl)	
	jp c,244dh
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
	ld hl,(THOMAS_POSITION)
	ld de,0ffe5h
	ld a,(0e701h)
	and 040h
	jr nz,l4e0dh
	add hl,de	
	jr l4e0fh
l4e0dh:
	sbc hl,de
l4e0fh:
	ld (THOMAS_POSITION),hl
l4e12h:
	ld hl,(THOMAS_POSITION)
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
	call sub_1be7h
	ld hl,(0e264h)
	ld de,THOMAS_PROPS
	add hl,de	
	jr nc,l4e6bh
    ; Increment external ticks
	ld hl,EXT_TICKS
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
	ld hl,NUM_KNIVES
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
	call l1be2h
l4e6bh:
	bit 4,c
	jp nz,l1a72h
	ret	
	call sub_4edfh
	jr l4e6bh
l4e76h:
    ; Increment external ticks
	ld hl,EXT_TICKS
	inc (hl)	
	call sub_17df
	jr l4e68h
	ld hl,TBL_GUYS_ENTRY_4 ;4e7f
	ld de, 16 ; Length of each entry in TBL_GUYS
	ld b,003h
l4e87h:
	set 6,(hl) ; Set moving direction 1 (left)
	add hl,de ; Next entry
	djnz l4e87h

	ld ix,TBL_GUYS_ENTRY_6
	call sub_4ed7h
	ld ix,TBL_GUYS_ENTRY_5
	call sub_4ed7h
	ld ix,TBL_GUYS_ENTRY_4
	call sub_4ed7h
	ld ix,TBL_GUYS_ENTRY_2
	call sub_4eb3h
	ld ix,TBL_GUYS_ENTRY_3
	call sub_4eb3h
	ld ix,TBL_GUYS_ENTRY_1
sub_4eb3h:
	ld c,(ix + 0)
	ld hl,l4ed1h
	push hl	
	ld a,(ix + 1)
	cp 001h
	jr z,sub_4edfh
	call l15a8h
	dec (ix + 14)
	ret nz	
	ld a,(ix + 15)
	ld (ix + 6),a
	jp 17dfh
l4ed1h:
	bit 4,c
	ret z	
	jp l162fh
sub_4ed7h:
	ld c,(ix + 0)
	call sub_1be7h
	jr l4ed1h
sub_4edfh:
	bit 4,c
	jp nz,l1baah
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
	ld bc,INCREMENT_LEVEL
	ld bc,051ch
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
	ld hl,0x0100
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
	ld bc,0608h
	ld bc,0413h
l4f3dh:
	ld b,c	
	ld hl,04104h
	ld c,004h
l4f43h:
	ld bc,0808h
	ld bc,0908h
	ld bc,0802h
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
	ld bc,0b08h
	ld bc,0508h
	ld bc,0d08h
	ld bc,0e08h
	ld bc,0d08h+1
	ld b,c	
	ex af,af'	
	dec b	
	ld bc,DECREMENT_LEVEL+1
	add hl,bc	
	djnz l4f70h
l4f70h:
	djnz $+41
	nop	
	ld b,c	
	pop hl	
	inc bc	
	ld bc,003a9h
	ld bc,0416h
	ld bc,0608h
	ld bc,00708h
	ld bc,0608h
	ld bc,l0408h
	ld bc,0808h
	ld bc,0908h
	ld bc,0808h
	add hl,bc	
	ex af,af'	
	inc b	
	ld bc,0608h
	ld bc,00708h
	ld bc,0608h
	ld bc,l0408h
	ld bc,0508h
	ld bc,0b08h
	ld bc,l0c08h
	ld bc,0b08h
	ld bc,0508h
	ld bc,l0408h
	ld bc,0808h
	ld bc,0908h
	ld bc,0808h
	add hl,bc	
	ex af,af'	
	dec b	
	ld bc,0b08h
	ld bc,l0c08h
	ld bc,0b08h
	ld bc,0508h
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
	ld bc,0608h
	ld bc,00708h
	ld bc,0608h
	ld bc,04a9h
	rst 38h	

;SEGUIR
sub_4fe9h:
	ld a,023h
l4febh:
	call PLAY_SOUND
	xor a	
	ld (THOMAS_STATE),a ; THOMAS_STATE_IDLE
	ld (EXT_TICKS),a
	ld (STEP_COUNTER),a
	ld a, GAME_STATE_GAME_ENDS
	ld (GAME_STATE),a
	call sub_5095h
;l5000h:
    ; Draw a red heart and...
	ld c,0d9h
	ld hl,HEART1_STR
	call WRITE_TEXT
    
    ; ...another...
	ld hl,HEART2_STR
	call WRITE_TEXT
    
    ; ...another...
	ld hl,HEART3_STR
	call WRITE_TEXT
    
    ; ...another...
	ld hl,HEART4_STR
	call WRITE_TEXT
    
    ; ... and another.
	ld hl,HEART5_STR
	call WRITE_TEXT
    
    ; Show the "A KUNG-FU MASTER... LITTLE WHILE." text and make the hearts move.
    ; Play ending music
	ld hl,ENDING_STR
	call ANIMATE_TEXT_MOVE_HEARTS
    
    ; Show the "A KUNG-FU MASTER... LITTLE WHILE." text and make the hearts move.
    ; Play ending music    
	ld a,0f8h
	call MOVE_ENDING_HEARTS
    
    ; Clear text
	call sub_5091h
    
    ; Show the "BUT THEIR HAPPY DAYS DID NOT LAST LONG."
    ; Hearts move.
	ld hl,HAPPY_DAYS_STR
	ld c,0d9h
	call ANIMATE_TEXT_MOVE_HEARTS
    
    ; Here it falls into the routine to move the hearts
    
	ld a,0f8h
MOVE_ENDING_HEARTS:
	push hl	
	push bc	
	push de	
	ld (INT_COUNTER + 2),a
	ld c,0d9h
l5040h:
	ld hl,STEP_COUNTER
	ld a,(hl)	
	and a	
	jr nz,l5061h
	ld (hl),00bh
	ld hl,EXT_TICKS
	dec (hl)	
	dec (hl)	
	jp p,l5053h
	ld (hl),008h
l5053h:
	ld e,(hl)	
	ld d,000h
	ld hl,0x506b
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call WRITE_TEXT
l5061h:
	ld a,(INT_COUNTER + 2)
	and a	
	jr nz,l5040h
	pop de	
	pop bc	
	pop hl	
	ret

; This block seems unused junk
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

; This is part of the look in ANIMATE_TEXT_MOVE_HEARTS
l5075h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl

; Prints the given text piece by piece and moves the hearts
; Used in the ending.
ANIMATE_TEXT_MOVE_HEARTS:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	inc a	
	jr z,l5075h

	sub 003h
	call WRITE_CHAR_AT_SCREEN_DE
	cp 020h
	jr nz,ANIMATE_TEXT_MOVE_HEARTS
	ld a,00bh
	call MOVE_ENDING_HEARTS
	jr ANIMATE_TEXT_MOVE_HEARTS
; SEGUIR
sub_5091h:
	ld b, 8
	jr l5097h
sub_5095h:
	ld b, 25
l5097h:
	ld c, 11
	ld de,0d19fh
l509ch:
	call CLEAR_33_CHARS
	ld hl,0x1f
	add hl,de	
	ex de,hl	
	djnz l509ch
	ret

ENDING_STR:	;50a7
	defb 0fdh,063h,0d2h
	defb "A KUNG-FU MASTER,THOMAS AND "
	defb 0fdh, 0e3h, 0d2h
	defb "SILVIA ENJOYED HAPPINESS "
	defb 0fdh, 063h, 0d3h
	defb "AGAIN FOR A LITTLE WHILE.", 0ffh

HAPPY_DAYS_STR: ; 50ff
	defb 0fdh, 0a6h, 0d2h
	defb "BUT THEIR HAPPY DAYS "
	defb 0fdh, 028h, 0d3h
	defb "DID NOT LAST LONG.", 0ffh	
	defb 0fdh,02eh,0d4h
	defb 0, 0		;5130
HEART1_STR:
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
HEART2_STR:
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
HEART3_STR:
	defb 0fdh,02eh,0d4h	;illegal sequence
	ld h,(hl)	
l515bh:
	ld h,a	
	rst 38h	
	defb 0fdh,06dh,0d4h	;illegal sequence
	nop	
	nop	
HEART4_STR:
	defb 0fdh,06fh,0d4h	;illegal sequence
	ld l,b	
	ld l,c	
	rst 38h	
	defb 0fdh,06fh,0d4h	;illegal sequence
	nop	
	nop	
HEART5_STR:
	defb 0fdh,0b0h,0d4h	;illegal sequence
	ld l,d	
	ld l,e	
	defb 0fdh,0f0h,0d4h	;illegal sequence
	ld l,h	
	ld l,l	
	rst 38h

; Shows the text with "1 OR 2 PLAYERS" and "CREDIT XX" and
; waits until the users chooses 1 or 2 players before starting the game.
CHOOSE_1_OR_2_PLAYERS:
	ld hl,IN_FREEZE_CHEAT
	set 7,(hl)
	call CLEAR_TILEMAP
	call CONFIG_GAME_STOP
l5183h:
	ld de,0d25ah ; Position of the text
	ld c,014h ; Color
	ld a,(INT_COUNTER)
	and 018h
	jr z,l5197h
    ; Write the "PUSH  BUTTON" message
	ld hl,PUSH_BUTTON_STR
	call WRITE_TEXT
	jr l519ah
l5197h:
	call CLEAR_26_CHARS
l519ah:
	ld de,0d319h
	ld a,(COINS)
	push af	
	cp 001h
	ld hl, ONLY_ONE_PLAYER_STR
	jr z,l51abh
	ld hl, ONE_OR_TWO_PLAYERS_STR
l51abh:
    ; Write number of players and the number of credits
	call WRITE_TEXT
	ld hl, CREDIT_STR
	call WRITE_TEXT
	pop af
    
    ; Write number of credits
    ; I really love the optimization he does, jumping in the middle of a
    ; routine and calling it twice the way it does :)
	call PRINT_TWO_DIGITS 
	
    ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	and 003h    ; Check P1 and P2 buttons
	jr z,l5183h ; Jump if neither P1 nor P2 are pressed
	and 2 ; Check P2 pressed
	ld (PLAYER_TURN),a
	ld b, 1 ; Subtract one coin
	jr z,l51c9h ; Z means only one player, so we won't increment B to require 2 coins
	inc b ; Subtract one more coin, since it's two players
l51c9h:
	ld hl,COINS
	ld a,(hl)	
	sub b ; Subtract required number of coins
	jr c,l5183h ; Ignore if there are not enough coins
	daa	
	ld (hl),a ; Updated number of coins after subtracting

    ; Reset IN_FREEZE_CHEAT
	ld hl,IN_FREEZE_CHEAT
	res 7,(hl)
	ret	; 51d7

PUSH_BUTTON_STR: ; 51d8
	defb "PUSH  BUTTON", 0ffh
	
ONLY_ONE_PLAYER_STR:
	defb "ONLY 1 PLAYER", 0ffh

ONE_OR_TWO_PLAYERS_STR:
	defb "1 OR 2 PLAYERS", 0ffh

CREDIT_STR:
	defb 0fdh, 0e1h, 0d5h
	defb "CREDIT ", 0ffh

DRAW_LETTER_SCREEN:
	call CLEAR_TILEMAP		;520d	cd 57 11 	. W . 
	call CONFIG_GAME_STOP		;5210	cd 03 57 	. . W 
	ld a,020h		;5213	3e 20 	>   
	call PLAY_SOUND		;5215	cd fe 0d 	. . . 
    
    ; This draws the yellow background of the letter
	ld c,01bh		    ;5218	0e 1b 	. . 
	ld de,0d153h		;521a	11 53 d1 	. S . 
	ld b, 23    		;521d	06 17 	. . 
l521fh:
	call CLEAR_26_CHARS		;521f	cd 25 57 	. % W 
	ld hl,00026h		;5222	21 26 00 	! & . 
	add hl,de			;5225	19 	. 
	ex de,hl			;5226	eb 	. 
	djnz l521fh		;5227	10 f6 	. . 

	ld hl,HAND_AND_PAPER_DRAWING		;5229	21 32 52 	! 2 R 
	call DRAW_HANDS_AND_PAPER		;522c	cd 39 57 	. 9 W

    ; Write the text of the letter.
    ; Here HL = 0x5306
	jp WRITE_TEXT		;522f	c3 1c 11 	. . . 


HAND_AND_PAPER_DRAWING:
    ; Drawing of the hands holding the letter.
    ; The text of the letter is below.
    db 0xfd, 0x55, 0xd1, 0xcc, 0xfd, 0x60, 0xd1, 0xcc; 0x5232 - 0x5239
    db 0xfd, 0x67, 0xd1, 0xcc, 0xfd, 0x92, 0xd3, 0xe3; 0x523a - 0x5241
    db 0xfd, 0xd1, 0xd3, 0xd9, 0xd8, 0x0, 0xd0, 0xd1; 0x5242 - 0x5249
    db 0xcd, 0xfd, 0x10, 0xd4, 0xe0, 0xdb, 0xda, 0x0; 0x524a - 0x5251
    db 0xd2, 0xd3, 0xcf, 0xfd, 0x50, 0xd4, 0xe2, 0x7; 0x5252 - 0x5259
    db 0xdc, 0xdd, 0xd4, 0xd5, 0xfd, 0x90, 0xd4, 0xe4; 0x525a - 0x5261
    db 0x7, 0xde, 0xdf, 0xd6, 0xd7, 0xfd, 0xd0, 0xd4; 0x5262 - 0x5269
    db 0xe6, 0x7, 0x7, 0x7, 0xe5, 0xfd, 0x10, 0xd5; 0x526a - 0x5271
    db 0xe1, 0x7, 0xe8, 0xe9, 0xe7, 0xfd, 0x50, 0xd5; 0x5272 - 0x5279
    db 0x7, 0x7, 0xea, 0xeb, 0xfd, 0x90, 0xd5, 0x7; 0x527a - 0x5281
    db 0x7, 0xec, 0xed, 0xfd, 0xd0, 0xd5, 0x7, 0xef; 0x5282 - 0x5289
    db 0xee, 0xfd, 0x10, 0xd6, 0x7, 0xf1, 0xfd, 0x50; 0x528a - 0x5291
    db 0xd6, 0xf0, 0xf3, 0xfd, 0x90, 0xd6, 0xf2, 0xfd; 0x5292 - 0x5299
    db 0xd0, 0xd6, 0xf4, 0xfd, 0xd6, 0xd6, 0xce, 0xfd; 0x529a - 0x52a1
    db 0xe4, 0xd6, 0xce, 0xfe, 0xfd, 0xad, 0xd3, 0xe3; 0x52a2 - 0x52a9
    db 0xfd, 0xe9, 0xd3, 0xcd, 0xd1, 0xd0, 0x0, 0xd8; 0x52aa - 0x52b1
    db 0xd9, 0xfd, 0x29, 0xd4, 0xcf, 0xd3, 0xd2, 0x0; 0x52b2 - 0x52b9
    db 0xda, 0xdb, 0xe0, 0xfd, 0x6a, 0xd4, 0xd5, 0xd4; 0x52ba - 0x52c1
    db 0xdd, 0xdc, 0x7, 0xe2, 0xfd, 0xaa, 0xd4, 0xd7; 0x52c2 - 0x52c9
    db 0xd6, 0xdf, 0xde, 0x7, 0xe4, 0xfd, 0xeb, 0xd4; 0x52ca - 0x52d1
    db 0xe5, 0x7, 0x7, 0x7, 0xe6, 0xfd, 0x2b, 0xd5; 0x52d2 - 0x52d9
    db 0xe7, 0xe9, 0xe8, 0x7, 0xe1, 0xfd, 0x6c, 0xd5; 0x52da - 0x52e1
    db 0xeb, 0xea, 0x7, 0x7, 0xfd, 0xac, 0xd5, 0xed; 0x52e2 - 0x52e9
    db 0xec, 0x7, 0x7, 0xfd, 0xed, 0xd5, 0xee, 0xef; 0x52ea - 0x52f1
    db 0x7, 0xfd, 0x2e, 0xd6, 0xf1, 0x7, 0xfd, 0x6e; 0x52f2 - 0x52f9
    db 0xd6, 0xf3, 0xf0, 0xfd, 0xaf, 0xd6, 0xf2, 0xfd; 0x52fa - 0x5301
    db 0xef, 0xd6, 0xf4, 0xff; 0x5302 - 0x5305

    ; Text of the letter
	defb 0xfe, 0x1b, 0fdh,017h,0d2h	;5306
	defb "YOUR LOVE "
	defb 0feh, 01fh
	defb "SILVIA"
	defb 0feh, 01bh, 0fdh, 097h, 0d2h
	defb "IS IN CUSTODY NOW."
	defb 0fdh, 016h, 0d3h
	defb "IF YOU WANT TO SAVE"
	defb 0fdh,097h,0d3h
	defb "YOUR DEAR "
	defb 0feh,01fh
	defb "SILVIA'S"
	defb 0fdh, 019h, 0d4h, 0feh, 01fh
	defb "LIFE"
	defb 0feh,01bh
	defb ", COME TO"
	defb 0fdh,097h,0d4h
	defb "THE DEVIL'S TEMPLE"
	defb 0fdh,017h,0d5h
	defb "AT ONCE."
	defb 0fdh,096h,0d5h
	defb "5 SONS OF THE DEVIL"
	defb 0fdh,017h,0d6h
	defb "WILL ENTERTAIN YOU.", 0ffh

; Interlude scene
INTERLUDE: ; 53c2
	call CLS_CYAN_AND_PAUSE		;53c2	cd 00 57 	. . W 
	ld a,005h		;53c5	3e 05 	> . 
	call PLAY_SOUND		;53c7	cd fe 0d 	. . . 
	ld a,(DRAGONS_LEVEL)		;53ca	3a 80 e0 	: . . 

	push af			;53cd	f5 	. 
	ld a,004h		;53ce	3e 04 	> . 
	ld (DRAGONS_LEVEL),a		;53d0	32 80 e0 	2 . . 

	call sub_064a		;53d3	cd 4a 06 	. J . 
	ld hl,05400h		;53d6	21 00 54 	! . T 9h:
	ld (0e710h),hl
	ld (0e344h),hl

	ld hl,2700h
	ld (THOMAS_POSITION),hl

	ld hl,1a00h
	ld (0e342h),hl
	pop af	

	ld (DRAGONS_LEVEL),a

	ld hl,TEXT_AND_LETS_TRY_NEXT_FLOOR_DRAWING
	call WRITE_TEXT

	ld a, GAME_STATE_INTERLUDE
	ld (GAME_STATE),a

	ld a,070h ; 53fa
	call HELP_ME_THOMAS_BLINKING_TEXT

	ld hl,IM_COMING_RIGHT_AWAY_TEXT
	call WRITE_TEXT

	ld a,005h
	call PLAY_SOUND

	ld a,070h
	call HELP_ME_THOMAS_BLINKING_TEXT

	ld a,005h
	call PLAY_SOUND
	ld a,0c0h

; Writes the "HELP ME, THOMAS", etc. text during the interlude.
; Interestingly, you can call this (PC = 53FC in the debugger) at
; any time, even during the game, and the animation will work.
; It's because the logic of the game goes on at the Z80 interrupt
; handler at address 0x38.
HELP_ME_THOMAS_BLINKING_TEXT: ; 5416
	ld (INT_COUNTER + 2),a
l5419h:
	ld a,(INT_COUNTER)
	ld de,0d295h
	ld c,0d9h
	ld hl, HELP_ME_THOMAS_STR
	and 018h
	jr nz,l542bh
	ld hl,SMALL_ROW_OF_BLACK_CHARS
l542bh:
	call WRITE_TEXT
	ld hl,INT_COUNTER + 2
	ld a,(hl)	
	and a	
	jr nz,l5419h
	ret	

sub_5436h:
	ld hl,0e703h
	ld a,(hl)	
	and a	
	jr z,l543eh
	dec (hl)	
l543eh:
	call l431fh
	call l4e12h
	jp sub_47b6h

TEXT_AND_LETS_TRY_NEXT_FLOOR_DRAWING:
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

	defb "LET'S TRY NEXT FLOOR", 0ffh ; 5470
HELP_ME_THOMAS_STR:
	defb "HELP ME,"
	defb 0fdh,015h,0d3h
	defb "THOMAS!", 0ffh

SMALL_ROW_OF_BLACK_CHARS:
	defb "        "
	defb 0fdh,015h,0d3h
	defb "       ", 0ffh


	; 54abh
IM_COMING_RIGHT_AWAY_TEXT:
	defb 0feh, 0dah
	defb 0fdh,0a3h,0d2h
	defb "I'M COMING"
	defb 0fdh,023h,0d3h
	defb "RIGHT AWAY,"
	defb 0fdh,0a5h,0d3h	;illegal sequence		;54c8	fd a5 d3 	. . . 
	defb "SILVIA!", 0ffh
GAME_OVER_STR:
	defb "            GAME OVER            "

sub_54f4h:
    ld a, 0x21
	call PLAY_SOUND

	ld de,0d340h
	ld c,0dbh
	ld ix,GAME_OVER_STR
	call WRITE_TEXT_IN_BOX

	ld a,0e1h
	call DELAY_A

	ld a,038h
	call DELAY_A

	xor a	
	ld (THOMAS_PROPS),a
	ld (NUM_GRIPPING),a
	ld de,POINTS + 2
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
	call PLAY_SOUND ; Legendary game's music! ;)

	call PRINT_SCORE_BOARD

	ld hl,TIME_STR
	call WRITE_TEXT

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
	call PRINT_TWO_DIGITS
	pop de	
	ld a,038h
	ld (INT_COUNTER + 1),a
l55a8h:
	call DELAY_1
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	and 003h    ; Check P1 and P2 buttons
	jr nz,l561bh    ; Jump if neither P1 nor P2 are pressed
	ld a,(PLAYER_INPUT)
	and 3 ; Bits 0 and 1: joystick pushing right and left
	jr z,l55deh
	ld a,(STEP_COUNTER)
	and a	
	jr nz,l55e2h
	ld a,00bh
	ld (STEP_COUNTER),a
	ld a,(PLAYER_INPUT)
	bit 0,a ; Bit 0: joystick pushing right
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
	ld (STEP_COUNTER),a
l55e2h:
	ld a,(PLAYER_MOVE)
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
	ld a,(INT_COUNTER + 1)
	and a	
	jr nz,l55a8h
	ld a,(0e026h)
l5600h:
	sub 001h
	daa	
	jr nz,l5596h
	ld de,0d160h
	ld c,000h
	call PRINT_TWO_DIGITS
l560dh:
	call PRINT_SCORE_BOARD_WITHOUT_HEADER
	ld a,01ch
	call DELAY_A
	ld a,000h
	call PLAY_SOUND
	ret	
l561bh:
	ld a,020h
	ld (de),a	
	jr l560dh

; Clear the screen, write the "BEST 20 PLAYERS" text, and show the
; score board.
PRINT_SCORE_BOARD: ; 5620
	call CLEAR_TILEMAP
	call CONFIG_GAME_STOP
	ld hl,BEST_20_PLAYERS_STR
	call WRITE_TEXT
; Show the score board without clearing the screen or printing the
; "BEST 20 PLAYERS". 
PRINT_SCORE_BOARD_WITHOUT_HEADER: ; 562c
	ld hl,0ea06h
	ld de,0d6a1h
	ld a,020h
l5634h:
	push af	
	ld c,0d8h
    
    ; Print position of the player
	call PRINT_NUMBER ; 5637
	ld c,015h
	inc de	
	ld a,(hl)	
	inc hl	
	and a	
	push de	
	call nz,PRINT_DIGIT ; 5641
	pop de	
	inc de	
	
    ; Print score
    ld b, 2 ; The score is 2 bytes
l5648h:
	ld a,(hl)	
	inc hl	
	call PRINT_TWO_DIGITS ; 564a
	djnz l5648h

    ; Write the trailing zero of the score
	ld a, '0' ; The '0' char. 564f
	call WRITE_CHAR_AT_SCREEN_DE
    
    ; Print player's name
	ld c,000h
	inc de	
	ld b, 3 ; The 3 initials of the player's name
l5659h:
	ld a,(hl)	
	inc hl	
	call WRITE_CHAR_AT_SCREEN_DE
	djnz l5659h

	pop af	
	sub 001h
	daa	
	ret z	    ; All scores printed, exit

	push hl	
	ld hl,0ff73h
	add hl,de	
	ex de,hl	
	pop hl
    
    ; Have we printed the last (20 ... 10) players?
	cp 010h ; 566c
	jr nz,l5634h
    
    ; Yes, change the position to go on writing on the screen
	ld de,0d691h
	jr l5634h ; Go on...
    
BEST_20_PLAYERS_STR:
	cp 0dbh		        ;5675	fe db
	defb 0fdh,0d8h,0d0h	; 5677
	defb "BEST 20 PLAYERS", 0ffh


TIME_STR:
	defb 0fdh,05ah,0d1h
	defb 0feh, 014h
	defb "TIME", 0ffh

TIME_OVER_STR: ; 5694
	defb "            TIME OVER            "

; Draws the "TIME OVER" text inside a box and wait for a while
DRAW_TIME_OVER_AND_DELAY:
	ld c,0d8h		        ;56b5	0e d8
	ld ix,TIME_OVER_STR		;56b7	dd 21 94 56
	call WRITE_TEXT_IN_BOX	;56bb	cd c3 56
	ld a,070h		        ;56be	3e 70
l56c0h:
	jp DELAY_A

; Draws a text inside a black block (as in "TIME OVER")
WRITE_TEXT_IN_BOX: ; 56c3
	ld hl,(HSCROLL_LOW_W)
	ld de,4
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
	ld a,(ix + 0) ; 56e2
	inc ix
	call WRITE_CHAR_AT_SCREEN_DE
	pop de	
	djnz l56dbh
	ld hl,l0040h
	add hl,de	
	ex de,hl	
	pop hl	
	dec h	
	jr nz,l56d8h
	ret	

; Prints a number (1 or 2 digits) without the trailing zero
PRINT_NUMBER:
	cp 010h
	jp nc, PRINT_TWO_DIGITS
	inc de	
	jp PRINT_DIGIT

CLS_CYAN_AND_PAUSE:
    ; It falls into CLEAR_TILEMAP
	call CLS_CYAN

; Set the GAME_STATE to stop and reset the horizontal scroll, thus
; preparing to start the game. It does also a very short pause.
CONFIG_GAME_STOP:
	xor a	
	ld (GAME_STATE),a
	ld hl,0
	ld (HSCROLL_LOW_W),hl

; Write A=1 to INT_COUNTER+2 and wait until it's 0
DELAY_1:
	ld a,001h
; Write A to INT_COUNTER+2 and wait until it's 0
DELAY_A:
	push hl	
	ld hl, INT_COUNTER + 2
	ld (hl),a	
l5714h:
	ld a,(hl)	
	and a	
	jr nz,l5714h
	pop hl	
	ret

; Clear a line of 26, 32 or 33 chars.
CLEAR_33_CHARS:
	push bc	
	ld b, 33
	jr l572dh
l571fh:
	call CLEAR_26_CHARS
	ld de,0d396h

CLEAR_26_CHARS:
	push bc	
	ld b, 26
	jr l572dh
ERASE_LINE:
	push bc	
	ld b, 32
l572dh:
	xor a	
l572eh:
	call WRITE_CHAR_AT_SCREEN_DE
	djnz l572eh
	pop bc	
	ret	

l5735h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	inc hl	
DRAW_HANDS_AND_PAPER:
	ld a,(hl)	
	inc hl	
	inc a	
	ret z	
	inc a	
	jr nz,l5744h
	set 5,c
	jr DRAW_HANDS_AND_PAPER
l5744h:
	inc a	
	jr z,l5735h
	sub 003h
	res 7,c
	cp 008h
	jr c,l5751h
	set 7,c
l5751h:
	call WRITE_CHAR_AT_SCREEN_DE
	jr DRAW_HANDS_AND_PAPER

DRAW_SCENARIO: ;  0x5756
	ld hl,(0e817h)
	ld a,h	
l575ah:
	push hl	
	call DRAW_SCENARIO_COL
	pop hl	
	inc h	
	ld a,h	
	cp l	
	jr nz,l575ah
	ret

; Draw a column of chars of the scenario
DRAW_SCENARIO_COL: ; 0x5765
	cp 0e0h
	ret nc ; Exit if finished

	ld (DISTANCE_TO_LEFT),a
	add a,020h
	and 03fh
	ld hl,0d180h
	or l	
	ld l,a	
	ld a,(DISTANCE_TO_LEFT)

	call DRAW_SCENARIO_COL_ROOF ; 0x5777

	ld a,(DRAGONS_LEVEL)
	and 001h
	jr nz,l5786h
	call DRAW_SCENARIO_COL_CORRIDOR
	jr l5789h
l5786h:
	call DRAW_SCENARIO_COL_BOTTOM
l5789h:
	call GET_CURRENT_LEVEL
	jr nz,l5793h
	call sub_58d3h
	jr l5796h
l5793h:
	call sub_58f1h
l5796h:
	call sub_57d4h
    
    ; Check current level
	call GET_CURRENT_LEVEL
	cp 003h ; Are we in level 4?
	ret nz	; 579e C0   No, get out
    
	ld a,(DISTANCE_TO_LEFT)
	ld bc, 8
	ld hl,SCENARIO_TILEMAP_ZONE_4
	cpdr ; CP (HL), DEC HL, DEC BC. Repeat until BC=0 or A=HL.
	ret nz

	rlc c
	rlc c
	ld a,(DRAGONS_LEVEL)
	cp 010h
	ld hl,SCENARIO_TILEMAP_ZONE_5
	jr c,l57bch
	ld hl,SCENARIO_TILEMAP_ZONE_6
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
	ld a,(DRAGONS_LEVEL)
	and 001h ; Level 2?
    ; Kind of the same, but inverted order of the column numbers
	ld hl,SCENARIO_TILEMAP_ZONE_7 ; For level 2
	jr nz,l57e1h
	ld hl,SCENARIO_TILEMAP_ZONE_8 ; For level 1
l57e1h:
	ld a,(DISTANCE_TO_LEFT)
	ld bc,000ch
	cpdr
	ret nz	
	ld hl,0x5a89
	add hl,bc	
	add hl,bc	
	ld a,(DISTANCE_TO_LEFT)
	ex de,hl	
	add a,020h
	and 03fh
	ld hl,0d380h
	or l	
	ld l,a	
	ld c,08bh
	jr l57c4h

; Draw the part of the column of the scenario which corresponds to the roof
DRAW_SCENARIO_COL_ROOF:
	ld de,SCENARIO_TILEMAP_ZONE_20
	cp 0dah
	jp nc,l5918h
	sub 0d5h
	jr c,l5818h
	push hl	
	ld hl,SCENARIO_TILEMAP_ZONE_1
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
	ld a,(DISTANCE_TO_LEFT)
	and 007h
	push hl	
	ld hl,SCENARIO_TILEMAP_ZONE_2
	ld c,a	
	add hl,bc	
	ld a,(hl)	
	pop hl	
	ld (hl),a	
	set 3,h
	ld (hl),05eh
	add hl,de	
	ret	

; Draw the part of the column of the scenario which corresponds to the bottom
DRAW_SCENARIO_COL_BOTTOM:
	ld a,(DISTANCE_TO_LEFT)
	cp 0ddh
	ret nc
    
    ; Check distance to see if the should draw the hatch already
	cp 00dh
	jr c,l5849h ; Yes, draw the hatch
	cp 0cfh
	jr c,l586dh
	ld de,SCENARIO_TILEMAP_ZONE_15
	jp l58c5h
l5849h:
	ld b,a	
	ld a,(HATCH_STATE)
	cp 1
	ld a,b	
	ld de,SCENARIO_TILEMAP_ZONE_12
	jr z,l58c5h
	ld de,SCENARIO_TILEMAP_ZONE_13
	jr nc,l58c5h
	ld de,SCENARIO_TILEMAP_ZONE_11
	jr l58c5h

; Draw the part of the column of the scenario which corresponds to the corridor
DRAW_SCENARIO_COL_CORRIDOR:
	ld a,(DISTANCE_TO_LEFT)
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
	ld hl,SCENARIO_TILEMAP_ZONE_3
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
	ld de,SCENARIO_TILEMAP_ZONE_9
	jr l58c5h
l5886h:
	ld b,a	
	ld de,SCENARIO_TILEMAP_ZONE_19
	call GET_CURRENT_LEVEL
	jr z,l589ch
	ld a,(HATCH_STATE)
	cp 1
	ld de,SCENARIO_TILEMAP_ZONE_18
	jr nc,l589ch
	ld de,SCENARIO_TILEMAP_ZONE_17
l589ch:
	ld a,b	
	jr l58c5h
l589fh:
	ld e,a	
	call GET_CURRENT_LEVEL
	cp 004h
	ld a,e	
	ld de,SCENARIO_TILEMAP_ZONE_16
	jr z,l58c5h
	ld de,SCENARIO_TILEMAP_ZONE_14
	call l5918h
	call GET_CURRENT_LEVEL
	ld a,(DISTANCE_TO_LEFT)
	jr nz,l58beh
	cp 003h
	jr nc,l58c8h
	ret

l58beh:
	cp 002h
	jr nc,l58c8h
	ld de,SCENARIO_TILEMAP_ZONE_25
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
	ld a,(DISTANCE_TO_LEFT)
	cp 0c0h
	jr nc,l58ech
	cp 020h
	jr c,l58e7h
	and 01fh
	ld de,SCENARIO_TILEMAP_ZONE_24
	jr l5918h
l58e7h:
	ld de,SCENARIO_TILEMAP_ZONE_23
	jr l5918h
l58ech:
	ld de,SCENARIO_TILEMAP_ZONE_21
	jr l5918h
sub_58f1h:
	ld a,(DISTANCE_TO_LEFT)
	ld de,SCENARIO_TILEMAP_ZONE_22
	cp 0dch
	jr nc,l5918h
	and 001h
	add a,024h
	ld c,042h
	jr sub_5909h

; Obtain the current level (starting at 0).
GET_CURRENT_LEVEL:
	ld a,(DRAGONS_LEVEL)
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
	ld c,a			;5958	4f 	O 
	jr l5927h		;5959	18 cc 	. . 
    
SELECT_GAME_FLOOR_STR: ; 595b
	defb 0feh, 015h
	defb 0fdh,0d8h,0d2h	
	defb "SELECT GAME FLOOR"

	defb 0fdh,09ah,0d3h	; 5971
	defb "HOUSE NUMBER-"
	defb 0fdh,01ah,0d4h	; 5981
	defb "FLOOR NUMBER-"
	defb 0fdh,098h,0d4h	; 5991
	defb "PUNCH-UP KICK-DOWN", 0ffh

PANEL_TEXT_STR:
	defb 0feh, 015h
	defb 0fdh, 011h, 0d0h	; 59a9
	defb "1P-"
	defb 0fdh,026h,0d0h	; 59af
	defb "2P-"
	defb 0feh,000h
	defb 0fdh,01bh,0d0h	; 59b7
	defb "TOP-"
	defb 0fEh,014h ;59be
	defb 0fdh,0aah,0d0h	;59c0
	defb "TIME"
	defb 0feh, 094h ;59c7

	defb 0fdh,091h,0d0h	;59c9
	defb 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0xfe, 0x95,0fdh,011h,0d1h
	defb 0x9d, 0x9e, 0x9f, 0xa0, 0xff ; ... 59da
    ; End of PANEL_TEXT_STR
    
    
; Most probably this is data to draw the char columns of the scenario
; Each byte is 2 chars of the column.
include 'scenario_tilemap.asm'

; Service mode
;l7666h:
SERVICE_MODE:
	ld a, GAME_STATE_SERVICE_MODE
	ld (GAME_STATE),a
	ei	
	call DELAY_1
	call CLEAR_TILEMAP
	di	
l7673h:
	ld ix,0
	ld b,000h
	ld a,000h
l767bh:
	ld e,a	
	ld d,00dh
	ld c,010h
	ld hl,GAME_STATE
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
	ld hl,GAME_STATE
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
	ld hl,M62_TILERAM
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
	ld hl,M62_TILERAM
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
	call CLEAR_TILEMAP
    
    ; Clear game variables
	ld hl,GAME_STATE
	ld de,GAME_STATE+1
	ld bc, 4095
	ld (hl), 0
	ldir

	ld hl,SPRITE_BUFFER
	ld (SPRITE_BUFFER_PTR),hl

	ld a, GAME_STATE_SERVICE_MODE
	ld (GAME_STATE),a

	ld de,0
	call sub_7c10h
	ld bc,(006ah)
	xor a	
	sbc hl,bc
	jr z,l7712h
	inc a	
l7712h:
	call sub_7c10h
	ld bc,(006ch)
	sbc hl,bc
	jr z,l771fh
	set 1,a
l771fh:
	push af	
	ld b,a	
	ld c,014h
	ld de,0d1d5h
	ld a,031h
	call PRINT_ROM_TEST_RESULT
	ld de,0d255h
	ld a,032h
	call PRINT_ROM_TEST_RESULT
	push ix
	pop hl	
	ld a,l	
	or h	
	ld de,0d155h
	ld hl,RAM_NG_str
	jr nz,l7743h
	ld hl,RAM_OK_str
l7743h:
	call WRITE_TEXT
	ei	
	ld a,070h
	call DELAY_A
	ld a,b	
	and a	
	call nz,WAIT_P2_BUTTON_PRESSED_AND_RELEASED
l7751h:
	call CLEAR_TILEMAP
	ld hl,MAIN_MENU_SERVICE_MODE_STR
	call WRITE_TEXT
	xor a	
	ld (INT_COUNTER + 2),a
	ld a,(0e81dh)
l7761h:
	ld (0e81dh),a
	ld c,000h
	call sub_7bd7h
l7769h:
	ld a,(PLAYER_INPUT)
	and 3 ; Bits 0 and 1: joystick pushing right and left
	ld hl,INT_COUNTER + 2
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
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 0,a ; bit #0: P1 pressed
	jr z,l7769h
	call CLEAR_TILEMAP
	ld hl,l7751h
	push hl	
	ld a,(0e81dh)
	ld hl,l77b1h
	jp l1f26h
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
	ld de,GAME_STATE
	ld hl,0d155h
	ld bc,0x0020
	ldir
	ld de,EXT_TICKS
	ld hl,0d955h
	ld bc,0x0020
	ldir
	ld ix,l77dbh
	jr l77fch
l77dbh:
	exx	
	ld hl,GAME_STATE
	ld de,0d155h
	ld bc,0x0020
	ldir
	ld hl,EXT_TICKS
	ld de,0d955h
	ld bc,0x0020
	ldir
	exx	
	jp l76d4h
l77f6h:
	ld ix,l769dh
	ex af,af'	
	exx	
l77fch:
	ld hl,0d155h
	ld de,RAM_NG_str
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
	InSystem
	bit 0,a
	jp z,l76e7h
	bit 1,a
	jr nz,l7844h
	ld bc,0x1000
l7852h:
	dec bc	
	ld a,c	
	or b	
	jr nz,l7852h
l7857h:
	InSystem
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
RAM_NG_str:
    defb "RAM  NG", 0ffh
RAM_OK_str:
    defb "RAM  OK", 0ffh
	ld hl,DIP_SW_STR
	call WRITE_TEXT
	call sub_7bc1h
	call WRITE_TEXT
l78a5h:
	ld de,0d199h
	InDSW1
	call sub_7bb2h
	ld de,0d1d9h
	InDSW2
	call sub_7bb2h
	InDSW2
	bit 1,a ; Check bit 1: cabinet setting (upright / cocktail)
	ld hl,TABLE_STR
	jr nz,l78c1h
	ld hl,UPRIGHT_STR
l78c1h:
	ld de,0d35dh
	call WRITE_TEXT
	InDSW1
	and 001h    ; Check bit 0: difficulty
	ld hl,EASY_STR
	jr nz,l78d3h
	ld hl,DIFFICULT_STR
l78d3h:
	ld de,0d39eh
	call WRITE_TEXT

	InDSW1
	and 002h ; Check bit 1: energy loss speed

	ld hl,SLOW_STR
	jr nz,l78e5h
	ld hl,FAST_STR
l78e5h:
	ld de,0d3deh
	call WRITE_TEXT
	call GET_LIVES_FROM_DSW1
	ld de,0d41fh
	call PRINT_DIGIT
	call GET_COINS_PER_CREDITS_FROM_DSWs
	ld b,c	
	ld de,0d29ah
	ld hl,(COINS_PER_CREDITS_A)
	ld a,l	
	and a	
	jr z,l792ah
	cp h	
	push af	
	ld a,020h
	jr z,l790ah
	ld a, 'A' ; Coin mode
l790ah:
	call WRITE_CHAR_AT_SCREEN_DE
	call PRINT_X_COINS_Y_PLAYERS
	pop af	
	ld de,0d2d0h
	jr z,l7933h
	push hl	
	ld hl,COIN_MODE_STR
	call WRITE_TEXT
	inc de	
	ld a, 'B' ; Coin mode
	call WRITE_CHAR_AT_SCREEN_DE
	pop hl	
	ld l,h	
	call PRINT_X_COINS_Y_PLAYERS
	jr l7936h
l792ah:
	ld hl,FREE_PLAY_STR
	call WRITE_TEXT
	ld de,0d2d0h
l7933h:
	call CLEAR_33_CHARS
l7936h:
	InSystem
	bit 1,a
	jp nz,l78a5h
	ret	
	ld bc,00314h
	ld de,0d455h
l7944h:
	push bc	
	ld hl,INTERFACE_STR
	call WRITE_TEXT
	push hl	
	inc de	
	ld a,b	
	call PRINT_DIGIT
	call sub_7bc1h
	ld hl,002ch
	add hl,de	
	ex de,hl	
	pop hl	
	call WRITE_TEXT
	ld hl,0feb6h
	add hl,de	
	ex de,hl	
	pop bc	
	djnz l7944h
	ld hl,TIMING_STR
	call WRITE_TEXT
	ld hl,09999h
	ld (TIME),hl
l7971h:
	ld a,038h
	ld (INT_COUNTER + 2),a
	ld hl,TIME
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
	call PRINT_TWO_DIGITS_DEC_HL
	call PRINT_TWO_DIGITS_DEC_HL
l798dh:
	InSystem
	ld de,0d2a2h
	call sub_7bb2h
	InP1Controls
	ld de,0d3a2h
	call sub_7bb2h
	InP2Controls
	ld de,0d4a2h
	call sub_7bb2h
	ld a,(INT_COUNTER + 2)
	and a	
	jr z,l7971h
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 1,a ; but #1: P2 pressed
	jr z,l798dh
	ld a,(PLAYER_INPUT)
	bit 1,a ; Bit 1: joystick pushing left
	jr z,l798dh
	ret	
	xor a	
	ld (INT_COUNTER + 2),a
l79beh:
	push af	
	ld hl,l7a61h
	ld e,a	
	ld d,000h
	add hl,de	
	add hl,de	
l79c7h:
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 0,a ; bit #0: P1 pressed
	jr nz,l79c7h
	ld a,(hl)	
	ld (STEP_COUNTER),a
	ld (0e81fh),a
	inc hl	
	ld a,000h
	call PLAY_SOUND
	ld a,(hl)	
	call PLAY_SOUND
	ld hl,LIST_OF_SOUNDS_SERVICE_MODE_STR
	call WRITE_TEXT
	pop af	
l79e6h:
	ld (0e81eh),a
	ld c,000h
	call sub_7bceh
l79eeh:
	ld a,(PLAYER_INPUT)
	and 3 ; Bits 0 and 1: joystick pushing right and left
	ld hl,INT_COUNTER + 2
	jr z,l7a26h
	ld b,a	
	ld a,(hl)	
	and a	
	jr nz,l79eeh
	ld a,000h
	call PLAY_SOUND
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
	ld a,(STEP_COUNTER)
	and a	
	jr z,l7a46h
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	and 003h    ; Check P1 and P2 buttons
	jr z,l79eeh ; Jump of neither P1 nor P2 are pressed
	bit 1,a
	jr nz,l7a5bh
l7a40h:
	ld a,(0e81eh)
l7a43h:
	jp l79beh
l7a46h:
	ld a,b	
	cp 0bah
	ld (STEP_COUNTER),a
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
	call PLAY_SOUND
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
	ld de,122dh
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
	ld de,0x0021
	ret po	
	ld (hl),0feh
l7a93h:
	ld a,(PLAYER_INPUT)
	and 3 ; Bits 0 and 1: joystick pushing right and left
	jr z,l7aa4h
	bit 1,a
	jr z,l7aa2h
	ld (hl),0fdh
	jr l7aa4h
l7aa2h:
	ld (hl),0feh
l7aa4h:
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 1,a ; bit #1: P2 pressed
	jr z,l7a93h
	ld (hl),0ffh
	ret

sub_7aaeh:
	ld c,000h
	inc a	
	jr nz,l7ae5h
	ld hl,l0110h
	ld de,l00e0h
	ld a,000h
	call sub_7adch
	ld hl,l0110h
	ld de,l0120h
	ld a,040h
	call sub_7adch
	ld hl,00d0h
	ld de,l00e0h
	ld a,080h
	call sub_7adch
	ld hl,00d0h
	ld de,l0120h
	ld a,0c0h
sub_7adch:
	ld (KNIFE_STATUS),hl
	ld hl,SCENARIO_TILEMAP_ZONE_35
	jp l0e20h
l7ae5h:
	ld hl,0x00c0
	ld (KNIFE_STATUS),hl
	ld de,00d0h
	ld hl,SCENARIO_TILEMAP_ZONE_31
	call sub_7b0ch
	ld de,00f0h
	ld hl,SCENARIO_TILEMAP_ZONE_32
	call sub_7b0ch
	ld de,l0110h
	ld hl,06e7dh
	call sub_7b0ch
	ld de,0130h
	ld hl,SCENARIO_TILEMAP_ZONE_33

sub_7b0ch:
	xor a	
	jp l0e20h
	ld de,0d1d0h
	ld c,014h
	ld a,041h
	ld b,01ah
	call sub_7bc7h
	ld de,0d210h
	ld a,030h
	ld b,00ah
	call sub_7bc7h
	call WAIT_P2_BUTTON_PRESSED_AND_RELEASED
	ld a,004h
	ld de,4
	call CLEAR_TILEMAP_WITH_DE
	call WAIT_P2_BUTTON_PRESSED_AND_RELEASED
	ld e,001h
	call CLEAR_TILEMAP_WITH_DE
	call WAIT_P2_BUTTON_PRESSED_AND_RELEASED
	ld e,002h
	call CLEAR_TILEMAP_WITH_DE
	call WAIT_P2_BUTTON_PRESSED_AND_RELEASED
	ld bc,0200h
	ld e,006h
	call CLEAR_TILEMAP_WITH_DE_BC
	ld bc,00400h
	ld e,000h
	call l1165h
	ld bc,0200h
	ld e,007h
	call l1165h
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
	ld de,0x0020
	add hl,de	
	dec c	
	jr nz,l7b61h
	jp WAIT_P2_BUTTON_PRESSED_AND_RELEASED
	ld c,000h
	ld de,SCREEN_ADDR
	ld a,00bh
	ld l,020h
l7b81h:
	push hl	
	ld b,010h
l7b84h:
	call WRITE_CHAR_AT_SCREEN_DE
	dec a	
	call WRITE_CHAR_AT_SCREEN_DE
	inc a	
	djnz l7b84h
	ld hl,0x0020
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
	jp WAIT_P2_BUTTON_PRESSED_AND_RELEASED

; SEGUIR
sub_7bb2h:
	cpl	
	ld l,a	
	ld b,008h
l7bb6h:
	xor a	
	rrc l
	rl a
	call PRINT_DIGIT
	djnz l7bb6h
	ret	

;SEGUIR
sub_7bc1h:
	inc de	
	inc de	
	ld a,031h
	ld b,008h
;SEGUIR
sub_7bc7h:
	call WRITE_CHAR_AT_SCREEN_DE
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

; Waits until the P2 button if pressed and released
WAIT_P2_BUTTON_PRESSED_AND_RELEASED:
    ; Wait until P2 is pressed
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 1,a ; bit #1: P2 pressed
	jr z,WAIT_P2_BUTTON_PRESSED_AND_RELEASED
l7befh:
    ; Wait until P2 is released
	ld a,(PLAYER_INPUT_COINS_P1P2_BUTTONS)
	bit 1,a
	jr nz,l7befh
	ret	

; Prints the ROM check result: "OK" or "NG" (not good)
; Input: the result of the test at bin #0 of reg. B (1: NG, 0: OK).
PRINT_ROM_TEST_RESULT:
	push af	
	ld hl,ROM_STR
	call WRITE_TEXT
	pop af	
	call WRITE_CHAR_AT_SCREEN_DE
	inc de	
	ld hl,NG_STR
	rrc b ; check bit #0 of B (test result)
	jr c,l7c0dh ; 1 ==> NG, 0 ==> OK
	ld hl,OK_STR
l7c0dh:
	jp WRITE_TEXT

sub_7c10h:
	push af	
	ld bc,sub_4000h
	ld hl,0
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

OK_STR:
    defb "OK", 0ffh
NG_STR:
    defb "NG", 0ffh
ROM_STR:
    defb "ROM", 0ffh
DIP_SW_STR:
	defb 0xfe, 0x14, 0fdh,050h,0d1h ;7c30
    defb "DIP SW ", 0ffh
    
	defb 0fdh,094h,0d1h ; 7c3d
    defb "DSW1"
    defb 0fdh,0d4h,0d1h
    defb "DSW2"
    defb 0fdh,0a3h,0d1h
    defb "1.ON"
    defb 0fdh,0e3h,0d1h
    defb "0.OFF"
	defb 0fdh,050h,0d3h
    defb "BODY TYPE"
	defb 0fdh,090h,0d3h
    defb "DIFFICULTY"
	defb 0fdh,0d0h,0d3h
    defb "DECREASE"
	defb 0fdh,010h,0d4h
    defb "FIGHTERS"
	defb 0fdh,090h,0d2h
COIN_MODE_STR:
    defb "COIN MODE", 0ffh
TABLE_STR:
    defb "TABLE  ", 0ffh
UPRIGHT_STR:
    defb "UPRIGHT", 0ffh
EASY_STR:
    defb "EASY     ", 0ffh
DIFFICULT_STR:
    defb "DIFFICULT", 0ffh
SLOW_STR:
    defb "SLOW", 0ffh
FAST_STR:
    defb "FAST", 0ffh
FREE_PLAY_STR:
    defb "     FREE   PLAY   ", 0ffh
INTERFACE_STR:
    defb "INTERFACE", 0ffh
    defb "READ DATA", 0ffh ; 7ce2
TIMING_STR:
	defb 0fdh,057h,0d5h
    defb "TIMMING", 0ffh ; (sic)
MAIN_MENU_SERVICE_MODE_STR:
	defb 0xfe, 0x14, 0fdh,050h,0d1h	;7cf7
    defb "01 DIP SWITCH"    
	defb 0fdh,090h,0d1h
    defb "02 I/O PORT"
	defb 0fdh,0d0h,0d1h
    defb "03 SOUND"
	defb 0fdh,010h,0d2h
    defb "04 CHARACTER"
	defb 0fdh,050h,0d2h
    defb "05 COLOR"
	defb 0fdh,090h,0d2h
    defb "06 CROSS HATCH PATTERN", 0ffh
LIST_OF_SOUNDS_SERVICE_MODE_STR:
	defb 0xfe, 0x14, 0fdh,015h,0d1h ;7d56
    defb "SOUND"
	defb 0fdh,050h,0d1h
    defb "01 YELL OF PLAYER(JUMP-KICKS)"
	defb 0fdh,093h,0d1h
    defb "CREDIT ADDING SOUND"
	defb 0fdh,0d0h,0d1h
    defb "02 YELL OF PLAYER(PUNCHES,KICKS)"
	defb 0fdh,010h,0d2h
    defb "03 GROAN OF PLAYER OR ENEMY"
	defb 0fdh,050h,0d2h
    defb "04 LAUGHING VOICE OF ENEMIES-1"
    defb 0fdh,090h,0d2h
    defb "05 LAUGHING VOICE OF ENEMIES-2"
    defb 0fdh,0d0h,0d2h
    defb "06 BURSTING OF PAPER BALL"
	defb 0fdh,013h,0d3h
    defb "BURSTING OF DRAGON'S EGG"
	defb 0fdh,050h,0d3h
    defb "07 SHRIEK OF PLAYER"
	defb 0fdh,090h,0d3h
    defb "08 PLAYER RUNNING"
	defb 0fdh,0d0h,0d3h
    defb "09 HITTING SOUND"
	defb 0fdh,010h,0d4h
    defb "10 SWISHING SOUND"
	defb 0fdh,050h,0d4h
    defb "11 BURSTING OF SNAKE POT"
	defb 0fdh,090h,0d4h
    defb "12 BITING SOUND"
	defb 0fdh,0d0h,0d4h
    defb "13 SOUND OF KNIVES,BOOMERANGS"
	defb 0fdh,010h,0d5h
    defb "14 COUNTING POINTS"
	defb 0fdh,050h,0d5h
    defb "15 GAME START"
	defb 0fdh,090h,0d5h
    defb "16 BGM"
	defb 0fdh,0d0h,0d5h
    defb "17 COMPLETION OF EACH PATTERN"
	defb 0fdh,010h,0d6h
    defb "18 COMPLETION OF GAME"
	defb 0fdh,050h,0d6h
    defb "19 GAME OVER"
	defb 0fdh,090h,0d6h
    defb "20 TIME UP WARNING"
	defb 0fdh,0d0h,0d6h
    defb "21 ADDITIONAL FIGHTER"
	defb 0fdh,016h,0d7h
    defb "MUSIC END", 0ffh

	; 7f9dh: The ROM finishes with 99 bytes of value 0c7h
	defs 99, 0c7h
