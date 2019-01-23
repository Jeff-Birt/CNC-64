;===============================================================================
;* Bit Bashing User Port Test Program                                          *
;===============================================================================

;===============================================================================
; BASIC Loader

*=$0801 ; 10 SYS (2064)

        byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader

source  byte $01, $02, $03, $04, $05, $06, $07, $08         ; source array

;===============================================================================

start
        lda #$00                
        sta $DD01               ; clear user port B data lines
        lda #$ff                
        sta $DD03               ; set DDR to all outputs Port B

        ldx #$FF
loopA   ldy #$FF
loopB   lda #$FF
        sta $DD01               ; set all user port B pins
        nop
        nop
        nop
        nop
        nop
        lda #$00
        sta $DD01               ; clear all user port B pins
        dey
        bne loopB               ; dec/repeat inner loop
        dex
        bne loopA               ; dec/repeat outer loopA
        rts




