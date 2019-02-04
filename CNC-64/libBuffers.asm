;===============================================================================
;* Simple buffers in 6502 asm                                                  *
;===============================================================================

*=$C000

;*******************************************************************************
;* Circular buffer, using 256 bytes as gives automatic wrap around when inc'ing
; Tail = Head -> buffer empty
; Tail = (Head + 1) -> buffer full (i.e. inc head would hit tail)
; 
; outBufFlag = 0 -> partial, outBufFlag = 1 -> empty, outBufFlad = 2 -> full
;*******************************************************************************

outBuf          bytes 256       ; Circular output byte buffer

;*******************************************************************************
; *OutBufInit,  initialize pointerrs used by outBuf
; pointers in zero page, defined in memoryMap.asm
;*******************************************************************************
OutBufInit
        lda #$00                ; $00 = head at start
        sta outBufHead          ; head points to next free byte
        lda #$00                ; $00 = tail at start
        sta outBufTail          ; tail points to next byte to read
        rts


;*******************************************************************************
; *OutBufFull may not need eventually
; returns X/Z=0 if buffer is full
;*******************************************************************************
OutBufFull
        ldx #$00                ; (2) preload fail return code
        ldy outBufHead          ; (3) get current value of head pointer
        iny                     ; (2) increment it one
        cpy outBufTail          ; (3) compare to tail pointer
        beq @done               ; (3) if new value same as tail = already full
        ldx #$01                ; (2) X=1 means not full
@done
        rts                     ; (6) 21 cycles total

;*******************************************************************************
; *OutBufWrite read next byte from outBuf, value to save passed in A,
; X=0, Z=1 returned if buffer full (fail), caller can branch on state of X/Z
; could have used C flag but VICE seems to have a bug in debug mode
; Only uses 255 out of 256 bytes, 1 byte padding between head and tail
;*******************************************************************************
defm    OutBufWrite
        ldx outBufHead          ; (3) get current value of head pointer
        inx                     ; (2) increment it one, does not affect C
        cpx outBufTail          ; (3) compare to tail pointer
        beq wdone               ; (3) tail=head is full, if Z=0 then C=1
        dex                     ; (2) need X back to where it was
        sta outBuf,x            ; (6) store value, index to X
        inx                     ; (2) increment it one, again!
        stx outBufHead          ; (3) save incremented head pointer
;        ldx #$01                ; (2) so BNE/BEQ can be used
;wdone                           ; (24 if a macro)
        endm


;*******************************************************************************
; *OutBufRead, uses register A, X
; read next byte from outBuf, value returned in A,
; X=0, Z=1 returned buffer empty (fail), X=1 success
; could have used C flag but VICE seems to have a bug in debug mode
;*******************************************************************************
defm    OutBufRead
        ldx outBufTail          ; (3) grap the tail pointer
        cpx outBufHead          ; (3) comapre to head pointer
        beq rdone               ; (3) Z=0 empty, if Z=0 then C=1
        lda outBuf,x            ; (6) laod value, X indexed
        inx                     ; (2) inc tail pointer, does not affect C
        stx outBufTail          ; (3) save inremented tail pointer
;        ldx #$01                ; (2) so BNE/BEQ can be used
;rdone                           ; (20 if a macro)
        endm


;*******************************************************************************
;* C=code buffer
; #n byte buffer to store pre-calcualted c=Code lines
; each line is 9 bytes that describe a line segment up to 65536 steps long
; all unit vales are in steps
;*******************************************************************************

*=$C200

Reps    = $00
Steps   = $01
daLSB   = $02
daMSB   = $03
dbLSB   = $04
dbMSB   = $05
frLSB   = $06
frMSB   = $07
acl     = $08
dir     = $09
mod     = $0A
                ;   Mode 1 (X master) Astepbit = $01, Bstepbit = $04 (A=X, B-Y) 
                ;   Mode 2 (Y master) Bstepbit = $01, Astepbit = $04 (A=Y, B=X)
                ;   #rep#step, daLSBMSB, dbLSBMSB, frLSBMSB, vel, dir, mod
cCodeBuf        byte $01, $FF, $FE, $01, $80, $00, $81, $FF, $00, $00, $01 ;(0,0)->(255,64)      $C209
                byte $10, $FF, $FE, $01, $80, $00, $81, $FF, $00, $02, $01 ;(255,64)->(510,128)  $C212
                byte $01, $FF, $04, $00, $00, $00, $FE, $FF, $00, $00, $00 ;(510,128)->(512,128) $C21B
;cCodeBufEnd     byte $FF        ; if we get to here we are done with lines

cCodeLiLenLSB   byte $0B        ; LSB of line length of cCodeBuf
cCodeLiLenMSB   byte $00        ; LSB of line length of cCodeBuf

cCodeStartLSB   byte $00        ; LSB of start of cCodeBuf location 
cCodeStartMSB   byte $C2        ; MSB of start of cCodeBuf location

cCodeLinesLSB   byte $01         ; count down to zero
cCodeLinesMSB   byte $00

cCodeEndFlag    byte $00        ; if =1 at last line of cCode

;*******************************************************************************
; *C=Code Macros
; 
;*******************************************************************************

; Returns A=0 if C=Code is at last line
defm    CCODEATEND
        lda cCodeEndFlag        ; more logic later, i.e. mask diff conditions
        endm

;*******************************************************************************
; *Initalize cCodeCur pointers
; ** add init code enb flag and code lines index
;*******************************************************************************
cCodeCurInit
        lda cCodeStartLSB       ; set up cCodeCurr pointer LSB
        sta cCodeCurrLSB        ; defined in memoryMap.asm
        lda cCodeStartMSB       ; set up cCodeCurr pointer MSB
        sta cCodeCurrMSB        ; defined in memoryMap.asm
        lda #$01                ; max # C=Code lines (count down)
        sta cCodeLinesLSB
        lda #$00
        sta cCodeLinesMSB       ;
        lda #$01                ; !=0 means not at last line
        sta cCodeEndFlag        ; initi C=Code end flag
        rts


;*******************************************************************************
; *Increment cCodeCurr pointer to next line of code
; First check that we not at last line already, then increment array pointer
; by array width (9), and dec line count. Set last line flag on last line.
; returns A = 0 last line, A!=0 not last line
;*******************************************************************************
cCodeCurInc
        lda cCodeEndFlag        ; if we are already pointing at last line
        beq @done               ; then just return
        LIBMATH_ADD16_AAAAAA cCodeCurrLSB, cCodeCurrMSB, cCodeLiLenLSB, cCodeLiLenMSB, cCodeCurrLSB, cCodeCurrMSB             
        LIBMATH_DEC16_AA cCodeLinesLSB, cCodeLinesMSB           ; dec line cnt
        LIBMATH_CMP16TOZERO_AA cCodeLinesLSB, cCodeLinesMSB     ; cmp to zero
        bne @done               ; CMP16 returns A!=0 if 16bit value != zero         
        sta cCodeEndFlag        ; set the last line flag
        lda #$00                ; 0= at last line
@done
        rts





