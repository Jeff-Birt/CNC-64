;===============================================================================
; $00-$FF  PAGE ZERO (256 bytes)
 
                ; $00-$01   Reserved for IO
ZeroPageTemp    = $02
basicFP2IntL    = $03
basicFP2IntH    = $04
basicInt2FPL    = $05
basicInt2FPH    = $06
                ; $03-$8F   Reserved for BASIC
                ; using $73-$8A CHRGET as BASIC
                ; $90-$FA   Reserved for Kernal
VelCur          = $92 ; Current Velocity, the current velocity of the machine
VelReq          = $93 ; requested velocity
VelFrac         = $96 ; Velocity fraction, counter of fractions velocity sums
VelInc          = $97 ; Velocity increment, amount to inc VelFrac each loop
AcclFrac        = $9B ;
AcclInc         = $9C ; was used for tape loading
outBufHead      = $9E ; 
outBufTail      = $9F ; was used for tape loading
tempForX        = $A5 ; temp storage for X register (kernal)
xIndex          = $A6 ; was used for tape loading
yIndex          = $A7 ; was used for tape loading
daL             = $A8 ; was used for tape loading
daM             = $A9 ; was used for tape loading
dbL             = $AA ; was used for tape/RS232
dbM             = $AB ; was used for tape/RS232
frL             = $AC ; was used for tape/RS232
frM             = $AD ; was used for tape/RS232
zpA             = $AE ; was used for tape/RS232
zpX             = $AF ; was used for tape/RS232
zpY             = $B0 ; was used for tape/RS232
;notused4        = $AF ; was used for tape/RS232
;notused5        = $B0 ; was used for tape loading
notused6        = $B1 ; was used for tape loading
notused7        = $B2 ; was used for tape loading
notused8        = $B3 ; was used for tape loading
notused9        = $B4 ; was used for tape loading
notused10       = $B5 ; was used for tape loading
notused11       = $BD ; was used for tape loading
outbyte         = $BE ; was used for tape loading
notused12       = $BF ; temp using for buf save cnt
notused13       = $C0 ; temp using for buf save cnt

notused14       = $F7 ; was used for tape/RS232
notused15       = $F8 ; was used for tape/RS232
notused16       = $F9 ; was used for tape/RS232
notused17       = $FA ; was used for tape/RS232
cCodeCurrLSB    = $FB           ; LSB of current cCodeBuf location 
cCodeCurrMSB    = $FC           ; MSB of current cCodeBuf location     
ZeroPageLow2    = $FD
ZeroPageHigh2   = $FE
                ; $FF       Reserved for Kernal

;===============================================================================
; $0100-$01FF  STACK (256 bytes)


;===============================================================================
; $0200-$7FFF  RAM (32K)

SCREENRAM       = $0400

; $0801
; Program code is placed here by using the *=$0801 directive 
; in Main.asm 

;===============================================================================
; $8000-$9FFF  RAM (8K)
;cCodeBuffer     = $8000

;===============================================================================
; $A000-$BFFF  BASIC ROM (8K)


;===============================================================================
; $C000-$CFFF  RAM (4K)
OutputBuffer    = $C000
cCodeBuffer     = $C200
;===============================================================================
; $D000-$DFFF  IO (4K)

; These are some of the C64 registers that are mapped into
; IO memory space
; Names taken from 'Mapping the Commodore 64' book

SP0X            = $D000
SP0Y            = $D001
MSIGX           = $D010
RASTER          = $D012
SPENA           = $D015
SCROLX          = $D016
VMCSB           = $D018
SPBGPR          = $D01B
SPMC            = $D01C
SPSPCL          = $D01E
EXTCOL          = $D020
BGCOL0          = $D021
BGCOL1          = $D022
BGCOL2          = $D023
BGCOL3          = $D024
SPMC0           = $D025
SPMC1           = $D026
SP0COL          = $D027
FRELO1          = $D400 ;(54272)
FREHI1          = $D401 ;(54273)
PWLO1           = $D402 ;(54274)
PWHI1           = $D403 ;(54275)
VCREG1          = $D404 ;(54276)
ATDCY1          = $D405 ;(54277)
SUREL1          = $D406 ;(54278)
FRELO2          = $D407 ;(54279)
FREHI2          = $D408 ;(54280)
PWLO2           = $D409 ;(54281)
PWHI2           = $D40A ;(54282)
VCREG2          = $D40B ;(54283)
ATDCY2          = $D40C ;(54284)
SUREL2          = $D40D ;(54285)
FRELO3          = $D40E ;(54286)
FREHI3          = $D40F ;(54287)
PWLO3           = $D410 ;(54288)
PWHI3           = $D411 ;(54289)
VCREG3          = $D412 ;(54290)
ATDCY3          = $D413 ;(54291)
SUREL3          = $D414 ;(54292)
SIGVOL          = $D418 ;(54296)      
COLORRAM        = $D800
CIAPRA          = $DC00
CIAPRB          = $DC01

;===============================================================================
; $E000-$FFFF  KERNAL ROM (8K) 


;===============================================================================
