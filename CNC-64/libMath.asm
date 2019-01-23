;===============================================================================
;* Math functions in 6502 asm                                                  *
;===============================================================================

;*******************************************************************************
;* ADD16 - add two 16bit numbers no overlow checking
; /1 = 1st Number Low Byte (Address), /2 = 1st Number High Byte (Address)
; /3 = 2nd Number Low Byte (Address), /4 = 2nd Number High Byte (Address)
; /5 = Sum Low Byte (Address), ; /6 = Sum High Byte (Address)
; 
;*******************************************************************************
defm    LIBMATH_ADD16_AAAAAA
        clc             ; (2) Clear carry before first add
        lda /1          ; (4) Get LSB of first number           (3 ZP)
        adc /3          ; (4) Add LSB of second number
        sta /5          ; (4) Store in LSB of sum               (3 ZP)
        lda /2          ; (4) Get MSB of first number           (3 ZP)
        adc /4          ; (4) Add carry and MSB of NUM2
        sta /6          ; (4) Store sum in MSB of sum           (3 ZP)
        endm            ; 26 cycles total                       (22 cycles)

;*******************************************************************************
;* INC16 - increment a 16 bit number
; /1 = Number Low Byte (Address), /2 = Number High Byte (Address)
; 
;*******************************************************************************
defm    LIBMATH_INC16_AA
        clc             ; (2) Clear carry before first add
        lda /1          ; (4) Get LSB of number
        adc #$01        ; (4) Add one
        sta /1          ; (4) SaveLSB of sum
        lda /2          ; (4) Get MSB of number
        adc #$00        ; (4) Add carry
        sta /2          ; (4) Save MSB of sum
        endm            ; 26 cycles total


;*******************************************************************************
;* SUB16 - subtract two 16bit numbers no underflow checking
; /1 = 1st Number Low Byte (Address), /2 = 1st Number High Byte (Address)
; /3 = 2nd Number Low Byte (Address), /4 = 2nd Number High Byte (Address)
; /5 = Sum Low Byte (Address), ; /6 = Sum High Byte (Address)
; 
;*******************************************************************************
defm    LIBMATH_SUB16_AAAAAA
        sec             ; (2) sec is the same as clear borrow
        lda /1          ; (4) Get LSB of first number           (3 ZP)
        sbc /3          ; (4) Subtract LSB of second number
        sta /5          ; (4) Store in LSB of sum               (3 ZP)
        lda /2          ; (4) Get MSB of first number           (3 ZP)
        sbc /4          ; (4) Subtract borrow and MSB of NUM2)
        sta /6          ; (4) Store sum in MSB of sum           (3 ZP)
        endm            ; 26 cycles total                       (22 cycles)


;*******************************************************************************
;* DEC16 - decremtn a 16 bit number
; /1 = Number Low Byte (Address), /2 = Number High Byte (Address)
; 
;*******************************************************************************
defm    LIBMATH_DEC16_AA
        sec             ; sec is the same as clear borrow
        lda /1          ; Get LSB of number
        sbc #$01        ; Subtract $01
        sta /1          ; Save it back
        lda /2          ; Get MSB of first number
        sbc #$00        ; Subtract borrow 
        sta /2          ; Save it back
        endm


;*******************************************************************************
;* CMP16 - compare two 16 bit numbers
; /1 = 1st Number Low Byte (Address), /2 = 1st Number High Byte (Address)
; /3 = 2nd Number Low Byte (Address), /4 = 2nd Number High Byte (Address)
; /5 temp byte storage (zero page)
; returns zero flag and A set to indicate equality, i.e. A/z=0 is equality
; 
;*******************************************************************************
defm    LIBMATH_CMP16_AAAA
        lda /2  ; xor MSBs,
        eor /4  ; if A != 0 then they were not equal
        sta /5  ; same to temp zero page byte
        lda /1  ; xor LSBs,
        eor /3  ; if A != 0 then they were not equal
        ora /5  ; or with MSB result, if A != 0 then not equal
        endm

;*******************************************************************************
;* CMP16TOZERO - compare 16 bit number to Zero
; /1 = Number Low Byte (Address), /2 = 1st Number High Byte (Address)
; returns A=0 if 16bit number is zero
; 
;*******************************************************************************
defm    LIBMATH_CMP16TOZERO_AA
        lda /1
        ora /2
        endm

;code d+ ( d1 d2 -- dnum )
;clc, inx,
;lsb lda,x
;inx, inx,
;lsb adc,x
;lsb sta,x
;dex, dex,
;msb lda,x
;inx, inx,
;msb adc,x
;msb sta,x
;dex, dex, dex,
;lsb lda,x
;inx, inx,
;lsb adc,x
;lsb sta,x
;dex, dex,
;msb lda,x
;inx, inx,
;msb adc,x
;msb sta,x
;;code

;code d- ( d1 d2 -- dnum )
;sec, inx,
;lsb lda,x
;inx, inx,
;lsb sbc,x
;lsb sta,x
;dex, dex,
;msb lda,x
;inx, inx,
;msb sbc,x
;msb sta,x
;dex, dex, dex,
;lsb lda,x
;inx, inx,
;lsb sbc,x
;lsb sta,x
;dex, dex,
;msb lda,x
;inx, inx,
;msb sbc,x
;msb sta,x
;;code