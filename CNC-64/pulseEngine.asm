;===============================================================================
;* NMI Pulse Engine Library                                                   *
;===============================================================================

;Constants
XSTEPBIT     = $01      ; bit position of X axis step line
XDIRBIT      = $02      ; bit position of X axis direction line
YSTEPBIT     = $04      ; bit position of Y axis step line
YDIRBIT      = $08      ; bit position of Y axis direction line
ZSTEPBIT     = $10      ; bit position of Z axis step line
ZDIRBIT      = $20      ; bit position of Z axis direction line
PULSERATE    = $03FF    ; # clock ticks between steps ($03FF, 1023 = 1kHz)
;PULSERATE    = $2F76    ; 100Hz (1/rateHz)/(1/1,023,000Hz)=ticks

NMI_VEC_LSB  = $0318
NMI_VEC_MSB  = $0319

CIA2_PrtADat = $DD00
CIA2_PrtBDat = $DD01    ; POKE 56577,x
CIA2_DDRA    = $DD02
CIA2_DDRB    = $DD03    ; 56579
CIA2_TmrA_L  = $DD04
CIA2_TmrA_H  = $DD05
CIA2_TmrB_L  = $DD06
CIA2_TmrB_H  = $DD07
CIA2_TOD_Ten = $DD08
CIA2_TOD_Sec = $DD09
CIA2_TOD_Min = $DD0A
CIA2_TOD_Hr  = $DD0B
CIA2_TOD_SDR = $DD0C
CIA2_TOD_ICR = $DD0D
CIA2_TOD_CRA = $DD0E
CIA2_TOD_CRB = $DD0F    ; 56591


*=$8000 ; temp starting address for pulse engine

;*******************************************************************************
;* Configure NMI
; $DD0F set bit 0 to 1 to start timer B, 
;       set bit 3 to 0 to auto-restart
;       set bit 5-6: %00 so timer counts sys clock
; poke 56591, 1 to start timer ($DD0F)
;*******************************************************************************

cfgStart
        sei
        php
        pha

        ; plug our NMI handler address into NMI vector
        lda #<PulseEng
        sta NMI_VEC_LSB
        lda #>PulseEng
        sta NMI_VEC_MSB

        ; set up CIA2 timer B
        lda #$00
        sta CIA2_TOD_CRB        ; set timer B control register
        sta CIA2_PrtBDat        ; clear data lines
        lda #$FF                
        sta CIA2_DDRB           ; set DDR to all outputs
        lda #<PULSERATE
        sta CIA2_TmrB_L         ; timer B low byte
        lda #>PULSERATE
        sta CIA2_TmrB_H         ; timer B high byte
        lda #$82
        sta CIA2_TOD_ICR        ; NMI on timer B underflow
        lda CIA2_TOD_ICR        ; ack any NMI?
        
;        lda #$00                ; *** testing
;        sta $BE                 ; *** count of output pulses
;        sta $BF                 ; *** testing

        pla
        plp
        cli
cfgEnd  rts


;*******************************************************************************
;* NMI Pulse Eninge
; Read byte from step buffer (if asvailable) , and update User Port B
; *** need to lock buffer manipulation to prevent NMI from stomping on
; *** a libBuffer change. Pulse engine already has SEI/cli wrapper. Could
; *** add a SEI/CLI wrapper macro for libBUffer functions for general use?
; ; poke 56591, 1 to start timer $DD0F
;*******************************************************************************

PortBMask byte 0

PulseEng
        ;php                     ; (3) push status register to stack
        sta zpA                 ; (3) save A register to zero page
        stx zpX                 ; (3) save X register to zero page
        ;stY zpY                 ; (3) save X register to zero page (not using)
                                ; (16 cycles total, saved 12)

        lda CIA2_TOD_ICR        ; clear interrupt, so it will fire again!

;        lda PortBMask           ; (4) *** testing
;        eor #$05                ; (4) *** toggle screen to show NMI running
;        sta PortBMask           ; (4) *** testing
;        sta $0400               ; (4) *** testing

        OutBufRead              ; implicit beq to rdone if no data (in macro)
                                ; saves 5 cycles, only A, X registers used
        ;beq rdone                ; if X=0 buffer empty so skip
;        sta CIA2_PrtBDat        ; update PortB outputs
        sta $0401               ; *** testing, visual hint data was output

;        LIBMATH_INC16_AA $BE, $BF ; *** testing, increment pulse out counter
;        lda PortBMask           ; *** testing
;        sta $0402               ; testing, visual hint data was output
rdone
        ;ldy zpY                 ; (3) grab old Y val from zero page (not used)
        ldx zpX                 ; (3) grab old X val from zero page
        lda zpA                 ; (3) grab old A val from zero page
        ;plp                     ; (4) pop status register off stack
        rti                     ; (6) all done
                                ; (12 cycles total, saved 14)



