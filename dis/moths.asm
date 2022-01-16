; The moths at level #4

; Config of the moths
; Length 17: 0xE500, ... , 0xE520
DATA_MOTHS_CONFIG: EQU 0xE500
;
; Maximum number of month in the screen
MAX_NUM_MOTHS_IDX: EQU 11
VERT_SPEED_IDX: EQU 4


; Moths table
; Each entry is 21 bytes
TBL_MOTHS_LEN: EQU 0xE576
TBL_MOTHS: EQU 0xE577

; Moth vertical position
MOTH_VERT_POS_L_IDX: EQU 12
MOTH_VERT_POS_H_IDX: EQU 13

; Moth horizontal speed
MOTH_HOR_SPEED_L_IDX: EQU 16
MOTH_HOR_SPEED_H_IDX: EQU 17

; Current height
MOTH_HEIGHT_L_IDX: EQU 4
MOTH_HEIGHT_H_IDX: EQU 5

; Base height which is added to obtain the current one
MOTH_BASE_HEIGHT_L_IDX: EQU 8
MOTH_BASE_HEIGHT_H_IDX: EQU 9


; To debug the moths set E587 = 00, 00 (MOTH_HOR_SPEED = 0) and
; play with the table at 0xE577 (TBL_MOTHS).
