;===============================================================================
;* CIA and Jiffy Clock Timer utilities                                         *
;===============================================================================

;===============================================================================
; CIA Timer stuff
;===============================================================================

;===============================================================================
;* Macros                                                                      *

defm    CIA2TMRA_START
        lda #$01                ; need to add in proper bit masking
        sta $DD0E               ; store to CIA TimerA register
        endm

defm    CIA2TMRA_STOP
        lda #$00                ; need to add in proper bit masking
        sta $DD0E               ; store to CIA TimerA register
        endm

defm    CIA2TMRA_READ           ; return timer A in A, X
        lda $DD04               ;LSB
        ldx $DD05               ;MSB
        endm

defm    CIA2TMRB_START
        lda #%00100001          ; need to add in proper bit masking
        sta $DD0F               ; store to CIA TimerA register
        endm

defm    CIA2TMRB_STOP
        lda #%00100000          ; need to add in proper bit masking
        sta $DD0F               ; store to CIA TimerA register
        endm

defm    CIA2TMRB_READ           ; return timer B in A, X
        lda $DD06               ;LSB
        ldx $DD07               ;MSB
        endm

;* end Macros                                                                  *
;===============================================================================


;===============================================================================
;* Subroutines                                                                 *

; instead of jify clock use CIA2 timer A, 
; Set control reg $DD0E to $00 (stop, src=sysclk)
; set registers to $FFFF counts $DD04 LSB, $DD05 MSB
; lDA $DD0D to clear any flags
; set $DD0E to $01 to start, set again to $00 to stop
; read $DD04 LSB, $DDO5 MSB for elapsed time
; up to 65ms, other wise need to cascade timers

;*******************************************************************************
;* CIA2TmrA_Cfg , configute CIA2 Timer A                                       *
;   Counts down from $FFFF using sysclk, max 65.536ms                          *
;   Variables -> None                                                          * 
;*******************************************************************************
CIA2TmrA_Cfg       
        sei
        php
        pha
        ; timer set up here
        lda #$00                ; set timer B control register
        sta $DD0E               ; stop, use sysclk source
        lda #$FF                ; timer A
        sta $DD04               ; set LSB
        lda #$FF                ; timer A
        sta $DD05               ; set MSB
        lda $DD0D               ; ack any NMI/flags?
        pla
        plp
        cli
        rts

;* end Subroutines                                                             *
;===============================================================================

;*******************************************************************************
;* CIA2TmrB_Cfg , configute CIA2 Timer B                                       *
;   Counts down from $FFFF using Timer A underflow, max 65.536ms               *
;   Variables -> None                                                          *
; start with lda #%00100001, sta $DD0F                                         * 
; stop  with lda #%00100000, sta $DD0F                                         * 
;*******************************************************************************
CIA2TmrB_Cfg       
        sei
        php
        pha
        ; timer set up here
        lda #%00100000          ; set timer B control register
        sta $DD0F               ; stop, use tmr A underflow
        lda #$FF                ; timer A
        sta $DD06               ; set LSB
        lda #$FF                ; timer A
        sta $DD07               ; set MSB
        lda $DD0D               ; ack any NMI/flags?
        pla
        plp
        cli
        rts

;* end Subroutines                                                             *
;===============================================================================


