; Grippers, knifers, and tom-toms

; TBL_GUYS: each entry is 16 bytes
; Setting a large number in TBL_GUYS_LEN will prevent adding more guys
TBL_GUYS_LEN: EQU 0xE261
TBL_GUYS: EQU 0xE262

; Side of the screen where the new guy (gripper of knifer) will appear
; 00: nothing
; 08  (bit #3): new enemy on the left
; 20: (bit #5): new enemy on the right
NEW_GUY_SIDE: EQU 0xE260

; Entry 0
; Bit 0: guy is a gripper (0) or a knifer (1)
; Bit 1: unused for guys? It's 1 when it's a boss, but in TBL_ENEMIES
; Bit 2: guy is a kid
; Bit 3: 1=avoid adding guys behind this one on the left
; Bit 4: guy is alive (not falling). A falling guy will still use its place in TBL_GUYS
; Bit 5: 1=avoid adding guys behind this one on the right
; Bit 6: moving direction of the guy (0 to the right, 1 to the left)
ENEMY_IS_A_GRIPPER_BIT: EQU 0
ENEMY_IS_A_BOSS_BIT: EQU 1
ENEMY_IS_A_KID_BIT: EQU 2
TRAILING_LEFT_BIT: EQU 3
ENEMY_IS_ALIVE_BIT: EQU 4
TRAILING_RIGHT_BIT: EQU 5
ENEMY_MOVE_RIGHT_BIT: EQU 6



;ENEMY_PROPS_IDX: EQU 0
;ENEMY_STATE_IDX: EQU 1
;ENEMY_STATE: EQU TBL_ENEMIES + ENEMY_STATE_IDX ; Enemy's state
;
;ENEMY_POS_L_IDX: EQU 2
;ENEMY_POS_H_IDX: EQU 3

;ENEMY_HEIGHT_L_IDX: EQU 4
;ENEMY_HEIGHT_H_IDX: EQU 5 ; Height of boss when falling after being defeated

;ENEMY_FRAME_IDX: EQU 6 ; Enemy's displayed frame

;ENEMY_FRAME_COUNTER_IDX: EQU 7

; Step counter to decrease the energy. It's related to the configuration
; of DSW1 (energy loss slow/fast).
; I guess this was added afterwards, since it's weird to have this
; variable and also ENEMY_ATTACK_STEP_IDX to the same.
GRIPPING_ENERGY_DECREASE_DSW_STEP: EQU 7


;ENEMY_MOVE_COUNTER_L_IDX: EQU 8
;ENEMY_MOVE_COUNTER_H_IDX: EQU 9

;ENEMY_ENERGY_IDX: EQU 10

; This controls the time left the enemy is standing without moving.
; For grippers, it's the number of shakes for the gripper before
; releasing Thomas.
;ENEMY_STEADY_COUNTER_IDX: EQU 11

;ENEMY_FRAMESEQ_PTR_L_IDX: EQU 12
;ENEMY_FRAMESEQ_PTR_H_IDX: EQU 13

; ENEMY_ATTACK_STEP_IDX: EQU 14


; This variable stores the last move Thomas did in order to get
; released from a gripper.
; The code checks that indeed the moves are different to perform an
; effective shake.
;
; This variable with index 15 is "ENEMY_BOOMERANG_TYPE_IDX" in the case of
; the boomerang guy at level 2.
THOMAS_LAST_SHAKE_MOVE: EQU 15


TBL_GUYS_ENTRY_2: EQU TBL_GUYS + 2*16

; These are used in the intro only
TBL_GUYS_ENTRY_4: EQU TBL_GUYS + 4*16
TBL_GUYS_ENTRY_5: EQU TBL_GUYS + 5*16
