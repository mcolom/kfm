; Bosses, moths, and other enemies

TBL_ENEMIES: EQU 0xE2D8

; The meaning of these indices seems to be mainly shared with TBL_GUYS too.
; ToDo: put them as common variables, perhaps in a separate file.

; Enemy's properties
; Bit 6: looking (and moving!) direction. 0 = look left and 1 = look right
; Bit 5: set to 1 when the enemy is attacked
; Bit 4: enemy is alive
; Bit 1: 1 if it's a boss
ENEMY_PROPS_IDX: EQU 0

; 0: enemy advances towards Thomas
; 1: enemy disappears dies
; 2, 3: enemy waits that Thomas approaches before attacking
; 4: enemy goes back, without turning back
; 5: enemy goes back, turning back
; 8: enemy stops and replica appears
; 9: enemy is gripping
ENEMY_STATE_IDX: EQU 1
ENEMY_STATE: EQU TBL_ENEMIES + ENEMY_STATE_IDX ; Enemy's state

ENEMY_POS_L_IDX: EQU 2
ENEMY_POS_H_IDX: EQU 3
ENEMY_POS: EQU TBL_ENEMIES + ENEMY_POS_L_IDX ; Position of the enemy

ENEMY_HEIGHT_L_IDX: EQU 4
ENEMY_HEIGHT_H_IDX: EQU 5 ; Height of boss when falling after being defeated

ENEMY_FRAME_IDX: EQU 6 ; Enemy's displayed frame
ENEMY_FRAME: EQU TBL_ENEMIES + ENEMY_FRAME_IDX

ENEMY_FRAME_COUNTER_IDX: EQU 7
ENEMY_FRAME_COUNTER: EQU TBL_ENEMIES + ENEMY_FRAME_COUNTER_IDX ; Ticks the enemy stays in its current frame

; If ENEMY_MOVE_COUNTER_L_IDX !=0, the enemy won't do anything.
; For example, this is the time the knifers wait before throwing.
; Also, when the boss moves forward and backwards.
ENEMY_MOVE_COUNTER_L_IDX: EQU 8
ENEMY_MOVE_COUNTER_H_IDX: EQU 9
ENEMY_MOVE_COUNTER: EQU TBL_ENEMIES + ENEMY_MOVE_COUNTER_L_IDX

; The energy of an boss or a knifer.
; In the case of a knifer it's set to 2.
; This way you need to attack twice to defeat him.
ENEMY_ENERGY_IDX: EQU 10
ENEMY_ENERGY: EQU TBL_ENEMIES + ENEMY_ENERGY_IDX ; Enemy's energy


; This controls the time left the enemy is standing without moving.
; For grippers, it's the number of shakes for the gripper before
; releasing Thomas.
ENEMY_STEADY_COUNTER_IDX: EQU 11
ENEMY_STEADY_COUNTER: EQU TBL_ENEMIES + ENEMY_STEADY_COUNTER_IDX 
;
; This controls how Mr. X reacts to attacks
; 7A: low kick, that he avoids by jumping
; 6A: attack that he can't avoid
;
; For the stick guy: 27: punch, kick

; For grippers/knifers:
;   56, 1C: about to start falling because of kick/punch or un-gripped
;   58, 1C: falling
;   5A, 1C: normal
;   5C, 1C: knifer attacked
;   5E, 1C: knifer falling

ENEMY_FRAMESEQ_PTR_L_IDX: EQU 12
ENEMY_FRAMESEQ_PTR_H_IDX: EQU 13
ENEMY_FRAMESEQ_PTR: EQU TBL_ENEMIES + ENEMY_FRAMESEQ_PTR_L_IDX

; When the action of the gripper is to remove energy, the
; energy decrease rate is also governed by this counter.
ENEMY_ATTACK_STEP_IDX: EQU 14
ENEMY_ATTACK_STEP: EQU TBL_ENEMIES + ENEMY_ATTACK_STEP_IDX ; Enemy attack step
;
; Enemy attack type
; 0: boomerang goes up, returns up
; 1: boomerang goes up, returns down
; 2: boomerang goes down, returns down
; 3: boomerang goes down, returns up
ENEMY_BOOMERANG_TYPE_IDX: EQU 15
ENEMY_BOOMERANG_TYPE: EQU TBL_ENEMIES + ENEMY_BOOMERANG_TYPE_IDX


; *******************************************************************

; In the 4th floor, the magician can make a replica of himself appear.
; The code addresses the variables of the replica in two different ways:
;   - With the same indices, but with base address TBL_ENEMIES + 16 = 0xE2E8 or
;   - with the same base address, but adding 16 to the index.

TBL_REPLICA: EQU TBL_ENEMIES + 16 ; 0xE2E8

; Downcount counter for the replica to appear or disappear, when this
; counter reaches zero.
REPLICA_APPEAR_COUNTER: EQU 0xE2F8

