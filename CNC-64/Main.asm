;===============================================================================
;* Simple Interpolate 3 Test Program                                           *
;===============================================================================

; poke 56591, 1 to start timer ($DD0F)
; poke 32817, 1 to start pulse engine
; $96 head pointer, $9B tail pointer
; $BF, $C0 writes to output buffer
; $BE, $BF number of output pulses sent

;===============================================================================
; BASIC Loader

*=$0801 ; 10 SYS (2064)

        byte $0E, $08, $0A, $00, $9E, $20, $28, $32
        byte $30, $36, $34, $29, $00, $00, $00

        ; Our code starts at $0810 (2064 decimal)
        ; after the 15 bytes for the BASIC loader

source  byte $01, $02, $03, $04, $05, $06, $07, $08         ; source array

;===============================================================================


;*******************************************************************************
;* Initialization
; 
;*******************************************************************************
start   ; the following line is at $0818
        jsr cCodeCurInit        ; init pointer to current line of C=code
        jsr outBufInit          ; init pointers for output buffer
        jsr cfgStart            ; configure NMI for pulse engine

        lda #$01                ; make sure the pulse engine running
        sta CIA2_TOD_CRB        ; *** crappy way to do this, replace!

        lda #$FE                ;
        sta VelFrac             ; Default settings for velocity
        lda #$7F                ;
        sta VelInc              ;

        lda #$00                ; *** testing
        sta $B0                 ; *** count of writes to output buffer
        sta $B1                 ; *** testing
        
        lda #$01                ; *** testing
        sta run                 ; *** set to run mode for testing

        ;rts                     ; *** testing, stop here
; Start of main loop

; initial check for C=Code to run here first

;*******************************************************************************
;* C=Code line initialization
; copy next line of code to 'local' vars, doing slow indirect Y indexing once
; *** maybe use subroutinr or macro for this?
;*******************************************************************************
nxtLine ldy #Reps               ; (2) Reps    = $00
        lda (cCodeCurrLSB),y    ; (5)
        sta yIndex              ; (4)

        ldy #daLSB              ; (2) dxLSB   = $02
        lda (cCodeCurrLSB),y    ; (5) 
        sta daL                 ; (2)
        ldy #daMSB              ; dxMSB   = $03
        lda (cCodeCurrLSB),y    ; (5)
        sta daM                 ; (4)

        ldy #dbLSB              ; (2) dyLSB   = $04
        lda (cCodeCurrLSB),y    ; (5)
        sta dbL                 ; (4)
        ldy #dbMSB              ; (2) dyMSB   = $05
        lda (cCodeCurrLSB),y    ; (5)
        sta dbM                 ; (4)

        ldy #frLSB              ; (2) frLSB   = $06
        lda (cCodeCurrLSB),y    ; (5)
        sta frL                 ; (4)
        ldy #frMSB              ; (2) frMSB   = $07
        lda (cCodeCurrLSB),y    ; (5)
        sta frM                 ; (4)

        ldy #acl                ; (2) accel   = $08
        lda (cCodeCurrLSB),y    ; (5)
        sta accel               ; (4) 

        ldy #dir                ; (2) dir     = $09
        lda (cCodeCurrLSB),y    ; (5)
        sta outbyte             ; (4) set direction bits in outbyte

        ldy #mod                ; (2) mode    = $0A
        lda (cCodeCurrLSB),y    ; (5)
        ;sta mode                ; 

        ; set step bits based on iteration mode
        cmp #$01                ; (2)
        bne m2                  ; (3)
        lda #XSTEPBIT           ; (2) iteration mode $01 X=A
        sta aStepBit            ; (4) iterating over X-axis
        lda #YSTEPBIT           ; (2)
        sta bStepBit            ; (4)
        jmp mdone               ; (3)
m2
        lda #YSTEPBIT           ; (2) iteration mode $02 Y=A
        sta aStepBit            ; (4) iterating over Y-axis
        lda #XSTEPBIT           ; (2)
        sta bStepBit            ; (4)
mdone


        ; checks before starting
;        lda run                 ; check to see if we are in run mode
;        beq end                 ; if not skip to end

loopy   ; first load #steps ( must do again each rep)
        ldy #Steps              ; (2) Steps   = $01
        lda (cCodeCurrLSB),y    ; (5) initis loopX
        sta xIndex

        ldy yIndex              ; (4) use Y as loop index
        bne doLoop              ; (3) if !=0 then keep looping              
        jmp doneXY              ; (3) jump to end if done with this line
doLoop 
        dey                     ; (2) dec the index
        sty yIndex              ; (4) and store

loopx   ldx xIndex              ; (4) use X as loop index
        beq doneX               ; (3) branch if done with this line
        dex                     ; (2) dec the index
        stx xIndex              ; (4) and store (3 for zero page)

        lda frM                 ; (4) get fraction MSB to test for negitive
        bmi @skipB              ; (3) skip if fraction < 0, else do ystep
        
        ; Toggle YStep
        LIBMATH_SUB16_AAAAAA frL, frM, daL, daM, frL, frM
        LIBMATH_ADD16_AAAAAA frL, frM, dbL, dbM, frL, frM
        lda outByte             ; (4) outByte^=0x04, toggle yStep for each step
        eor bStepBit            ; (4) XOR in ysstep bit (toggle it)
        jmp xsteps              ; (3)

@skipB  LIBMATH_ADD16_AAAAAA frL, frM, dbL, dbM, frL, frM
        lda outByte             ; (4) outByte ^= 01, toggle xStep for each step
       
xsteps  eor aStepBit            ; (4) XOR in xstep bit (toggle it)
        sta outByte             ; (4) save it

;        ; Toggle YStep
;        lda outByte             ; (4) outByte^=0x04, toggle yStep for each step
;        eor bStepBit            ; (4) XOR in ysstep bit (toggle it)
;        sta outByte             ; (4) save it 
;        LIBMATH_SUB16_AAAAAA frL, frM, daL, daM, frL, frM
;@skipB  LIBMATH_ADD16_AAAAAA frL, frM, dbL, dbM, frL, frM

;        ; Toggle XStep
;xsteps  lda outByte             ; (4) outByte ^= 01, toggle xStep for each step
;        eor aStepBit            ; (4) XOR in xstep bit (toggle it)
;        sta outByte             ; (4) save it

wdone   OutBufWrite             ; (24) implic. 'wdone beq' if buff full in macro
        LIBMATH_INC16_AA $BF, $C0 ; *** testing, inc buffer write count 

        ; AcclInc is two's compliment'
;        lda VelInc              ; (3) get current vel
;        cmp VelReq              ; (3) at correct velocity now?
;        beq velSet              ; (3) is equal so skip accel/decel
;        clc                     ; (2) clear carry before adding
;        lda AcclFrac            ; (3) VelFrac += VelInc
;        adc AcclInc             ; (3) if no overlfow, add a 'pause'
;        sta AcclFrac            ; (3) store updated value           
;        bcc velSet              ; (3) carry clear, no velocity update
;        inc VelInc              ; (5) incremetn current velocity setting

        ; velocity 'pause' insertion
velSet  clc                     ; (2) clear carry before adding
        lda VelFrac             ; (3) VelFrac += VelInc
        adc VelInc              ; (3) if no overlfow, add a 'pause'
        sta VelFrac             ; (3) store updated value           
        bcs loopx               ; (3) carry set so calc next outbyte
        lda outByte             ; (4) else, load current outbyte
        jmp wdone               ; (3) and insert as a 'pause'
        
doneX   jmp loopy               ; (3)

doneXY  jsr cCodeCurInc         ; increment line pointer, A=0 at last line
        beq end                 ; (3) if A=0 returned then at last line
        jmp nxtLine             ; (3)

end    
        rts                     ; done


;*******************************************************************************
;* Variables
; *** this really needs to go elsewhere
;*******************************************************************************
run             byte $00        ; $00=stop, $01=run
accel           byte $00        ; acceleration setting
direct          byte $00        ; direction bits
mode            byte $00        ; iteration mode, $01 X=A, $02 Y=A 
aStepBit        byte $00
bStepBit        byte $00






