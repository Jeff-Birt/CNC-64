;===============================================================================
;* Vector Jump Table - Commodore 64 standard KERNAL functions                  *
;===============================================================================

;Name           Address Descrtiption
IOBASE = $FFF3  ; Fetch CIA #1 base address
                ; Input: –
                ; Output: X/Y = CIA #1 base address ($DC00).
                ; Used registers: X, Y.
                ; Real address: $E500.

PLOT   = $FFF0  ; BASIC plot function X Col, Y Row
                ; Input: Carry: 0 = Restore from input, 1 = Save to output; 
                ;        X = Cursor column (if Carry = 0); 
                ;        Y = Cursor row (if Carry = 0).
                ; Output: X = Cursor column (if Carry = 1); 
                ;         Y = Cursor row (if Carry = 1).
                ; Used registers: X, Y.
                ; Real address: $E50

SCREEN = $FFED  ; SCREEN. Fetch number of screen rows and columns.
                ; Input: –
                ; Output: X = Number of columns (40); Y = Number of rows (25).
                ; Used registers: X, Y.
                ; Real address: $E505.

UDTIM  = $FFEA  ; Update Time of Day, at memory address $00A0-$00A2, 
                ; and Stop key indicator, at memory address $0091.
                ; Input: –
                ; Output: –
                ; Used registers: A, X.
                ; Real address: $F69B.

CLALL  = $FFE7  ; Clear file table; call CLRCHN.
                ; Input: –
                ; Output: –
                ; Used registers: A, X.
                ; Real address: ($032C), $F32F.

GETIN  = $FFE4  ; Read byte from default input. 
                ; (If not keyboard, must call OPEN and CHKIN beforehands.)
                ; Input: –
                ; Output: A = Byte read.
                ; Used registers: A, X, Y.
                ; Real address: ($032A), $F13E.

STOP   = $FFE1  ; Query Stop key indicator, at memory address $0091; 
                ; if pressed, call CLRCHN and clear keyboard buffer.
                ; Input: –
                ; Output: Zero: 0 = Not pressed, 1 = Pressed; Carry: 1 = Pressed.
                ; Used registers: A, X.
                ; Real address: ($0328), $F6ED.

RDTIM  = $FFDE  ; Read Time of Day, at memory address $00A0-$00A2.
                ; Input: –
                ; Output: A/X/Y = Current TOD value.
                ; Used registers: A, X, Y.
                ; Real address: $F6DD.

SETTIM = $FFDB  ; Set Time of Day, at memory address $00A0-$00A2.
                ; Input: A/X/Y = New TOD value.
                ; Output: –
                ; Used registers: –
                ; Real address: $F6E4.

SAVE   = $FFD8  ; Save file. (Must call SETLFS and SETNAM beforehands.)
                ; Input: A = Address of zero page register holding start address 
                ;  of memory area to save; 
                ; X/Y = End address of memory area plus 1.
                ; Output: Carry: 0 = No errors, 1 = Error; 
                ; A = KERNAL error code (if Carry = 1).
                ; Used registers: A, X, Y.
                ; Real address: $F5DD.

LOAD   = $FFD5  ; Load or verify file. 
                ; (Must call SETLFS and SETNAM beforehands.)
                ; Input: A: 0 = Load, 1-255 = Verify; 
                ;  /Y = Load address (if secondary address = 0).
                ; Output: Carry: 0 = No errors, 1 = Error; 
                ; A = KERNAL error code (if Carry = 1); 
                ; X/Y = Address of last byte loaded/verified (if Carry = 0).
                ; Used registers: A, X, Y.
                ; Real address: $F49E.

CHROUT = $FFD2  ; Write byte to default output. 
                ; (If not screen, must call OPEN and CHKOUT beforehands.)
                ; Input: A = Byte to write.
                ; Output: –
                ; Used registers: –
                ; Real address: ($0326), $F1CA.

CHRIN  = $FFCF  ; Read byte from default input (for keyboard, read a line 
                ; from the screen). (If not keyboard, must call OPEN and 
                ; CHKIN beforehands.)
                ; Input: –
                ; Output: A = Byte read.
                ; Used registers: A, Y.
                ; Real address: ($0324), $F157.

CLRCHN = $FFCC  ; Close default input/output files 
                ; (for serial bus, send UNTALK and/or UNLISTEN); 
                ; restore default input/output to keyboard/screen.
                ; Input: –
                ; Output: –
                ; Used registers: A, X.
                ; Real address: ($0322), $F333.

CHKOUT = $FFC9  ; Define file as default output. (Must call OPEN beforehands.)
                ; Input: X = Logical number.
                ; Output: –
                ; Used registers: A, X.
                ; Real address: ($0320), $F250.

CHKIN  = $FFC6  ; Define file as default input. (Must call OPEN beforehands.)
                ; Input: X = Logical number.
                ; Output: –
                ; Used registers: A, X.
                ; Real address: ($031E), $F20E.

CLOSE  = $FFC3  ; Close file.
                ; Input: A = Logical number.
                ; Output: –
                ; Used registers: A, X, Y.
                ; Real address: ($031C), $F291.

OPEN   = $FFC0  ; Open file. (Must call SETLFS and SETNAM beforehands.)
                ; Input: –
                ; Output: –
                ; Used registers: A, X, Y.
                ; Real address: ($031A), $F34A.

SETNAM = $FFBD  ; Set file name parameters.
                ; Input: A = File name length; X/Y = Pointer to file name.
                ; Output: –
                ; Used registers: –
                ; Real address: $FDF9.

SETLFS = $FFBA  ; Set file parameters.
                ; Input: A = Logical number; X = Device number; 
                ;        Y = Secondary address.
                ; Output: –
                ; Used registers: –
                ; Real address: $FE00.

READST = $FFB7  ; Fetch status of current input/output device, value of 
                ; ST variable. (For RS232, status is cleared.)
                ; Input: –
                ; Output: A = Device status.
                ; Used registers: A.
                ; Real address: $FE07.

TALK   = $FFB4  ; Send TALK command to serial bus.
                ; Input: A = Device number.
                ; Output: –
                ; Used registers: A.
                ; Real address: $ED09.

LISTEN  = $FFB1 ; Send LISTEN command to serial bus.
                ; Input: A = Device number.
                ; Output: –
                ; Used registers: A.
                ; Real address: $ED0C.

UNLSTN  = $FFAE ; Send UNLISTEN command to serial bus.
                ; Input: –
                ; Output: –
                ; Used registers: A.
                ; Real address: $EDFE.

UNTALK  = $FFAB ; Send UNTALK command to serial bus.
                ; Input: –
                ; Output: –
                ; Used registers: A.
                ; Real address: $EDEF.

CIOUT_IECOUT  = $FFA8 ; Write byte to serial bus. 
                ; (Must call LISTEN and LSTNSA beforehand)
                ; Input: A = Byte to write.
                ; Output: –
                ; Used registers: –
                ; Real address: $EDDD.

ACPTR_IECIN   = $FFA5 ; Read byte from serial bus. 
                ; (Must call TALK and TALKSA beforehand)
                ; Input: –
                ; Output: A = Byte read.
                ; Used registers: A.
                ; Real address: $EE13.

SETTMO  = $FFA2 ; Unknown. Set serial bus timeout flag.
                ; Input: A = Timeout value.
                ; Output: –
                ; Used registers: –
                ; Real address: $FE21.

SCNKEY  = $FF9F ; Query keyboard; put current matrix code into memory
                ; address $00CB, current status of shift keys into memory address 
                ; $028D and PETSCII code into keyboard buffer.
                ; Input: –
                ; Output: –
                ; Used registers: A, X, Y.
                ; Real address: $EA87.

MEMTOP  = $FF9C ; Save or restore end address of BASIC work area.
                ; Input: Carry: 0 = Restore from input, 1 = Save to output
                ;        X/Y = Address (if Carry = 0).
                ; Output: X/Y = Address (if Carry = 1).
                ; Used registers: X, Y.
                ; Real address: $FE34.

MEMBOT  = $FF99 ; Save or restore start address of BASIC work area.
                ; Input: Carry: 0 = Restore from input, 1 = Save to output
                ;       X/Y = Address (if Carry = 0).
                ; Output: X/Y = Address (if Carry = 1).
                ; Used registers: X, Y.
                ; Real address: $FE25.

TALKSA  = $FF96 ; Send TALK secondary address to serial bus. 
                ; (Must call TALK beforehands.)
                ; Input: A = Secondary address.
                ; Output: –
                ; Used registers: A.
                ; Real address: $EDC7.

SECOND_LSTNSA  = $FF93 ; Send LISTEN secondary address to serial bus. 
                ; (Must call LISTEN beforehands.)
                ; Input: A = Secondary address.
                ; Output: –
                ; Used registers: A.
                ; Real address: $EDB9.

SETMSG  = $FF90 ; Set system error display switch at memory address $009D.
                ; Input: A = Switch value.
                ; Output: –
                ; Used registers: –
                ; Real address: $FE18.

VECTOR  = $FF8D ; Copy vector table at memory addresses $0314-$0333 from 
                ; or into user table.
                ; Input: Carry: 0 = Copy user table into vector table, 
                ;        1 = Copy vector table into user table; 
                ;        X/Y = Pointer to user table.
                ; Output: –
                ; Used registers: A, Y.
                ; Real address: $FD1A.

RESTOR  = $FF8A ; Fill vector table at memory addresses $0314-$0333 
                ; with default values.
                ; Input: –
                ; Output: –
                ; Used registers: –
                ; Real address: $FD15.

RAMTAS  = $FF87 ; Clear memory addresses $0002-$0101 and $0200-$03FF run
                ; memory test and set start and end address of BASIC work area
                ; accordingly; set scrn mem. to $0400 and datasette buff. to $033C
                ; Input: –
                ; Output: –
                ; Used registers: A, X, Y.
                ; Real address: $FD50.

IOINIT  = $FF84 ; Initialize CIA's, SID volume; setup memory configuration
                ; set and start interrupt timer.
                ; Input: –
                ; Output: –
                ; Used registers: A, X.
                ; Real address: $FDA3.

CINT_SCINIT  = $FF81 ; Initialize VIC; restore default input/output to keyboard
                ; /screen; clear screen; set PAL/NTSC switch and interrupt timer
                ; Input: –
                ; Output: –
                ; Used registers: A, X, Y.
                ; Real address: $FF5B.

PrintDec        = $BDCD ; BASIC decimal print routine
GetLine         = $A560 ; BASIC line input routine?

