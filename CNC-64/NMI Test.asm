;===============================================================================
;* Interupt Test Program                                                     *
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

; $DD0F set bit 0 to 1 to start timer B, set bit 3 to 0 to auto-restart
;       set bit 5-6: %00 so timer counts sys clock
; poke 56591, 1 to start timer $DD0F
start
        sei
        php
        pha
        lda #<myNMI
        sta $318
        lda #>myNMI
        sta $319
        ; timer set up here
        lda #$00
        sta $DD0F               ; set timer B control register
        lda #$00                
        sta $DD01               ; clear data lines
        lda #$ff                
        sta $DD03               ; set DDR to all outputs
        lda #$E8
        sta $DD06               ; timer B low byte
        lda #$03
        sta $DD07               ; timer B high byte
        lda #$82
        sta $DD0D               ; NMI on timer B underflow
        lda $DD0D               ; ack any NMI?
        pla
        plp
        cli
        rts

myNMI
        sei                     ; disable all interupts
        pha                     ; save registers on stack
        tya
        pha
        txa
        pha
        lda $DD0D               ; clear interrupt, so it will fire again!
        lda $C000               ; copy $C000 (49152) to top left screen
        sta $0400

        pla                     ; pop registers off stack
        tax
        pla
        tay
        pla
        cli                     ; reenable interrupts
        rti                     ; all done


