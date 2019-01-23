;===============================================================================
;* file libPrint - print to screen library                                     *
;===============================================================================

;Constants
htlo         = $14
hthi         = $15

;Variables
NumberToPrint byte 0

;===============================================================================
;* Macros                                                                      *

defm    CLS
        lda #CHR_ClearScreen    ; Load Clear Screen Charecter
        jsr CHROUT              ; Print This Character
        endm

defm    POS_CURSOR
        clc
        ldy #/1                 ; Y = Column
        ldx #/2                 ; X = Row
        jsr Plot                ; Postion cursor at X, Y
        endm

defm    PRINT_BIN_V
        lda #/1
        jsr PrintBin
        endm

defm    PRINT_CR
        lda #CHR_Return         ; Load Return Character 
        jsr CHROUT              ; Print This Character
        endm

defm    PRINT_DECIMAL_V
        ldx #/1                 ; Load value into X
        jsr PrintDec         
        endm

defm    PRINT_DOLLAR
        lda #"$"
        jsr CHROUT
        endm

defm    PRINT_HASH
        lda #"#"
        jsr CHROUT
        endm

defm    PRINT_HEX_V
        lda #/1                 ; Number to print
        jsr PrintHex            ; Jump to decimal print routine
        endm

defm    PRINT_PERCENT
        lda #"%"
        jsr CHROUT
        endm

defm    PRINT_SPACE
        lda #" "
        jsr CHROUT
        endm

defm    PRINT_TEXT_AA
        ldy #>/1                ; Load Hi Byte to Y
        lda #</1                ; Load Lo Byte to Acc.
        jsr PrintString         ; Print The text until hit Zero
        endm

;* end Macros                                                                  *
;===============================================================================

;===============================================================================
;* Subroutines                                                                 *

;*******************************************************************************
;* PrintBin, prints A as a binary number                                       *
;   Inputs -> Accumulator : Number to print                                    *
;   Variables -> None                                                          * 
;*******************************************************************************
PrintBin
        sta NumberToPrint       ; Store Acc to temp variable
        PRINT_PERCENT           ; print "%"
        ldy #8                  ; Initialise Y Index Register
loop
        lda #"0"                ; Load "0" to print by default               
        asl NumberToPrint       ; Shift left Number to Print into Carry
        bcc zero                ; If carry clear skip
        lda #"1"                ; Load "1" to print
zero
        jsr CHROUT              ; Print it out
        dey                     ; decrement index
        bne loop                ; Done? No, get next Bit
        rts                     ; Return
;*******************************************************************************

;*******************************************************************************
;* PrintHex, Prints A as a hexadecimal number                                  *
;   Inputs -> Accumulator : Number to print                                    *
;   Variables -> None                                                          *
;*******************************************************************************
PrintHex
        sta NumberToPrint       ; Store A to temp
        PRINT_DOLLAR
        lda NumberToPrint
        ldx #$00                ; Initialise X Register with Zero
        ;jmp pbyte2              ; Jump to Hexadecimal routine
;*******************************************************************************

;*******************************************************************************
;* pbyte2, prints a four character hexadecimal number                          *
;   Inputs -> Accumulator : Lo Byte of the number to be converted              *
;             X Register  : Hi Byte of the number to be converted              *
;   Variables -> None                                                          *
;*******************************************************************************
pbyte2
    pha                     ; Push Acc to the Stack 
    txa                     ; Tansfer X register To Acc
    jsr pbyte1              ; Execute 2 digit Hexadecimal convertor
    pla                     ; Pull Acc from Stack
pbyte1
    pha                     ; Push Acc to the Stack 
                            ; Convert Acc into a nibble Top '4 bits'
    lsr                     ; Logically shift Right Acc
    lsr                     ; Logically shift Right Acc
    lsr                     ; Logically shift Right Acc
    lsr                     ; Logically shift Right Acc
    jsr pbyte               ; Execute 1 digit Hexadecimal number
    tax                     ; Transfer Acc back into X Register 
    pla                     ; Pull Acc from the Stack
    and #15                 ; AND with %00001111 to filter out lower nibble
pbyte
    clc                     ; Clear the Carry
                            ; Perform Test weather number is greater than 10
    adc #$f6                ; Add #$F6 to Acc with carry
    bcc pbyte_skip          ; Branch is carry  is still clear
    adc #6                  ; Add #$06 to Acc to align PETSCII Character 'A'
pbyte_skip
    adc #$3a                ; Add #$3A to align for PETSCII Character '0'
    jmp CHROUT              ; Jump to the Print Routine for that character
;*******************************************************************************

;*******************************************************************************
;* PrintString, Prints a string of characters terminating in a zero byte.      *
;   Shoule be in PETSCII, i.e. varname text "my text to print"                 *
;   Inputs -> Accumulator : Lo Byte Address of String                          *
;             Y Register  : Hi Byte Address of String                          *
;   Variables -> None                                                          *
;*******************************************************************************
PrintString
    sta htlo                ; Store Lo Byte Address of String
    sty hthi                ; Store Hi Byte Address of String
nxtchr
    ldy #0                  ; Initialise Index Y
    lda (htlo),y            ; Load Character at address + Y
    cmp #0                  ; Is it Zero?
    beq string_rts          ; If Zero, goto end of routine
    jsr CHROUT              ; Print this character
    clc                     ; Clear The Carry
    inc htlo                ; Increase Lo Byte
    bne nxtchr              ; Branch away if Page Not Crossed
    inc hthi                ; Increase Hi byte
    jmp nxtchr              ; Jump back to get Next Character
string_rts
    rts                     ; Return
;*******************************************************************************


;* end Subroutines                                                             *
;===============================================================================
