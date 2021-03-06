;===============================================================================
;* Commodore 64 BASIC calls                                                    *
;===============================================================================

;Name           Address Descrtiption
CLDSTRT = $A000 ; Basic cold start vector ($E394) 
WRMSTRT = $A002 ; Basic warm start vector ($E37B) 
CBMTEXT = $A004 ; Text "cbmbasic" 
BSCADR  = $A00C ; Addresses of the BASIC-commands -1 (END, FOR, NEXT, ... 35 addresses of 2 byte each) 
BASFUNC = $A052 ; Addresses of the BASIC-Functions (SGN, INT, ABS, ... 23 addresses of 2 byte each) 
HCODE   = $A080 ; Hierarchy-codes and addresses of the operators -1 (10-times 1+2 Bytes) 
BASKW1  = $A09E ; BASIC key words as string in PETSCII; Bit 7 of the last character is set 
BASKW2  = $A129 ; Keywords which have no action addresses - TAB(, TO, SPC(, ...; Bit 7 of the last character is set 
BASKWOP = $A140 ; Keywords of the operands + - * etc.; also AND, OR as strings. Bit 7 of the last character is set 
BASKWF  = $A14D ; Keywords of the functions (SGN, INT, ABS, etc.) where bit 7 of the last character is set 
ERRMSG  = $A19E ; Error messages (TOO MANY FILES, FILE OPEN, ... ); 29 messages where bit 7 of the last character is set 
ERRPTR  = $A328 ; Pointer-table to the error messages 
INTMSG  = $A364 ; Messages of the interpreter (OK, ERROR IN, READY, BREAK) 
STKSRCH = $A38A ; Routine to search stack for FOR-NEXT and GOSUB 
LININS  = $A3B8 ; Called at Basic line insertion. Checks, if enough space available. After completion, $A3BF is executed 
MVEBYTE = $A3BF ; Move bytes routine 
STKSPC  = $A3FB ; Check for space on stack 
ARROVF  = $A408 ; Array area overflow check 
MSGOOM  = $A435 ; Output of error message ?OUT OF MEMORY 
OEM     = $A437 ; Output of an error message, error number in X-register; uses vector in ($0300) to jump to $E38B 
IWL     = $A480 ; Input waiting loop; uses vector in ($0302) to jump to basic warm start at $A483 
INDELLN = $A49C ; Delete or Insert program lines and tokenize them 
BASRL   = $A533 ; Relink BASIC program 
INLINE  = $A560 ; Input of a line via keyboard 
TOKCR   = $A579 ; Token crunch -> text line to interpreter code; uses vector in ($0304) to get to $A57C 
CLCSA   = $A613 ; Calculate start adress of a program line 
BASNEW  = $A642 ; BASIC-command NEW 
BASCLR  = $A65E ; BASIC-command CLR 
SETPTR  = $A68E ; Set program pointer to BASIC-start (loads $7A, $7B with $2B-1, $2C-1) 
BASLST  = $A69C ; BASIC-command LIST 
BAS2TXT = $A717 ; Convert BASIC code to clear text; uses vector (0306) to jump to $A71A 
BASFOR  = $A742 ; BASIC-command FOR: Move 18 bytes to the stack 1) Pointer to the next instruction, 2) actual line number, 3) 
                ; upper loop value, 4) step with (default value = 1), 5) name of the lop variable and 6) FOR-token. 
INTLOOP = $A7AE ; Interpreter loop, set up next statement for execution 
PGMEND  = $A7C4 ; Check for program end 
BASEXEC = $A7E1 ; execute BASIC-command; uses vector ($0308) to point to $A7E4 
BASEXKW = $A7ED ; Executes BASIC keyword 
BASREST = $A81D ; BASIC-command RESTORE: set data pointer at $41, $42 to the beginning of the actual basic text 
BASSTOP = $A82C ; BASIC-command STOP (also END and program interuption) 
BASSTP  = $A82F ; BASIC-command STOP 
BASEND  = $A831 ; BASIC-command END 
BASCONT = $A857 ; BASIC-command CONT 
BASRUN  = $A871 ; BASIC-command RUN 
BASGSUB = $A883 ; BASIC-command GOSUB: Move 5 bytes to the stack. 1) the pointer within CHRGET, 2) the actual line 
                ; number, 3) token of GOSUB; after that, GOTO ($a8a0) will be called 
BASGOTO = $A8A0 ; BASIC-command GOTO 
BASRET  = $A8D2 ; BASIC-command RETURN 
BASDATA = $A8F8 ; BASIC-command DATA 
NEXSEP  = $A906 ; Find offset of the next seperator 
BASIF   = $A928 ; BASIC-command IF 
BASREM  = $A93B ; BASIC-command REM 
BASON   = $A94B ; BASIC-command ON 
GETDEC  = $A96B ; Get decimal number (0...63999, usually a line number) from basic text into $14/$15 
BASLET  = $A9A5 ; BASIC-command LET 
ASNINT  = $A9C4 ; Value assignment of integer 
ASNFLT  = $A9D6 ; Value assignment of float 
ASNSTR  = $A9D9 ; Value assignment of string 
ASNTIS  = $A9E3 ; Assigns system variable TI$ 
STRDIG  = $AA1D ; Check for digit in string, if so, continue with $AA27 
ADDPET  = $AA27 ; Add PETSCII digit in string to float accumulator 
ASNSTRV = $AA2C ; Value assignment to string variable (LET for strings) 
BASPRNT = $AA80 ; BASIC-command PRINT# 
BASCMD  = $AA86 ; BASIC-command CMD 
BASPR   = $AA9A ; Part of the PRINT-routine: Output string and continue with the handling of PRINT 
BASPR2  = $AAA0 ; BASIC-command PRINT 
VAROUT  = $AAB8 ; Outputs variable; Numbers will be converted into string first 
;$AACA ; Append $00 as end indicator of string 
;$AAD7 ; Outputs a CR/soft hyphenation (#$0D), followed by a line feed/newline (#$0A), if the channel number is 128 
;$AAF8 ; TAB( (C=1) and SPC( (C=0) 
;$AB1E ; Output string: Output string, which is indicated by accu/Y reg, until 0 byte or quote is found 
;$AB3B ; Output of cursor right (or space if Output not on screen) 
;$AB3F ; Output of a space character 
;$AB42 ; Output of cursor right 
;$AB45 ; Output of question mark (before error message) 
;$AB47 ; Output of a PETSCII character, accu must contain PETSCII value 
;$AB4D ; Output error messages dor read commands (INPUT / GET / READ) 
BASGET  = $AB7B ; BASIC-command GET 
BASINN  = $ABA5 ; BASIC-command INPUT# 
BASIN   = $ABBF ; BASIC-command INPUT 
;$ABEA ; Get line into buffer 
;$ABF9 ; Display input prompt 
BASREAD = $AC06 ; BASIC-commands READ, GET and INPUT share this routine and will be distinguished by a flag in $11 
BAASGET = $AC35 ; Input routine for GET 
;$ACFC ; Messages ?EXTRA IGNORED and ?REDO FROM START, both followed by $0D (CR) and end of string $00. 
BASNXT  = $AD1D ; BASIC-command NEXT 
;$AD61 ; Check for valid loop 
;$AD8A ; FRMNUM: Get expression (FRMEVL) and check, if numeric 
;$AD9E ; FRMEVL: Analyzes any Basic formula expression and shows syntax errors. Set type flag $0D (Number: $00, string $FF). Sety 
;        ;integer flag $0E (float: $00, integer: $80) puts values in FAC. 
;$AE83 ; EVAL: Get next element of an expression; uses vector ($030A) to jump to $AE86 
;$AEA8 ; Value for constant PI in 5 bytes float format 
;$AEF1 ; Evaluates expression within brackets 
;$AEF7 ; Check for closed bracket ")" 
;$AEFA ; Check for open bracket "(" 
;$AEFD ; Check for comma 
;$AF08 ; Outputs error message ?SYNTAX ERROR and returns to READY state 
;$AF0D ; Calculates NOT 
;$AF14 ; Check for reserved variables. Set carry flag, if FAC points to ROM. This indicates the use of one of the reserved variables 
;        ; TI$, TI, ST. 
;$AF28 ; Get variable: Searches the variable list for one of the variables named in $45, $46 
;$AF48 ; Reads clock counter and generate string, which contains TI$ 
;$AFA7 ; Calculate function: Determine type of function and evaluates it 
;$AFB1 ; String function: check for open bracket, get expression (FRMEVL), checks for comms, get string. 
;$AFD1 ; Analyze numeric function 
;$AFE6 ; BASIC-commands OR and AND, distinguished by flag $0B (= $FF at OR, $00 at AND). 
;$B016 ; Comparison (<, =, > ) 
;$B01B ; Numeric comparison 
;$B02E ; String comparison 
;$B081 ; BASIC-command DIM 
;$B08B ; Checks, if variable name valid 
;$B0E7 ; Searches variable in list, set variable pointer, create new variable, if name not found 
;$B113 ; Check for character 
;$B11D ; Create variable 
;$B194 ; Calculate pointer to first element of array 
;$B1A5 ; Constant -32768 as float (5 bytes) 
;$B1AA ; Convert FAC to integer and save it to accu/Y reg 
;$B1B2 ; Get positive integer from BASIC text 
;$B1BF ; Convert FAC to integer 
;$B1D1 ; Get array variable from BASIC text 
;$B218 ; Search for array name in pointer ($45, $46) 
;$B245 ; Output error message ?BAD SUBSCRIPT 
;$B248 ; Output error message ?ILLEGAL QUANTITY 
;$B24D ; Output error message ?REDIM\'D ARRAY 
;$B261 ; Create array variable 
;$B30E ; Calculate address of a array element, set pointer ($47) 
;$B34C ; Calculate distance of given array element to the one which ($47) points to and write the result to X reg/Y reg 
;$B37D ; BASIC-function FRE 
;$B391 ; Convert 16-bit integer in accu/Y reg to float 
;$B39E ; BASIC-function POS 
;$B3A2 ; Convert the byte in Y reg to float and return it to FAC 
;$B3A6 ; Check for direct mode: value $FF in flag $3A indicates direct mode 
;$B3AE ; Output error message ?UNDEF\'D FUNCTION 
;$B3B3 ; BASIC-command DEF FN 
;$B3E1 ; Check syntax of FN 
;$B3F4 ; BASIC-function FN 
;$B465 ; BASIC-function STR$ 
;$B475 ; Make space for inserting into string 
;$B487 ; Get string, pointer in accu/Y reg 
;$B4CA ; Store string pointer in descriptor stack 
;$B4F4 ; Reserve space for string, length in accu 
;$B526 ; Garbage Collection 
;$B606 ; Searches n variables and arrays for string which has to be saved by the next Garbace Collection 
;$B63D ; Concatenates two strings 
;$B67A ; Move String to reserved area 
;$B6A3 ; String management FRESTR 
;$B6DB ; Remove string pointer from descriptor stack 
;$B6EC ; BASIC-function CHR$ 
;$B700 ; BASIC-function LEFT$ 
;$B72C ; BASIC-function RIGHT$ 
;$B737 ; BASIC-function MID$ 
;$B761 ; String parameter from stack: Get pointer for string descriptor and write it to $50, $51 and the length to accu (also X-reg) 
;$B77C ; BASIC-function LEN 
;$B782 ; Get string parameter (length in Y-reg), switch to numeric 
;$B78B ; BASIC-function ASC 
;$B79B ; Holt Byte-Wert nach X: Read and evaluate expression from BASIC text; the 1 byte value is then stored in X-reg and in FAC+4 
;$B7AD ; BASIC-funktion VAL 
;$B7EB ; GETADR and GETBYT: Get 16-bit integer (to $14, $15) and an 8 bit value (to X-reg) - e.G. parameter for WAIT and POKE. 
;$B7F7 ; Converts FAC in 2-byte integer (scope 0 ... 65535) to $14, $15 and Y-Reg/accu 
;$B80D ; BASIC-function PEEK 
;$B824 ; BASIC-command POKE 
;$B82D ; BASIC-command WAIT 
;$B849 ; FAC = FAC + 0,5; for rounding 
;$B850 ; FAC = CONSTANT - FAC , accu and Y-register are pointing to CONSTANT (low- and high-byte) 
;$B853 ; FAC = ARG - FAC 
;$B862 ; Align exponent of FAC and ARG for addition 
;$B867 ; FAC = CONSTANT (accu/Y reg) + FAC 
;$B86A ; FAC = ARG + FAC 
;$B947 ; Invert mantissa of FAC 
;$B97E ; Output error message OVERFLOW 
;$B983 ; Multiplies with one byte 
;$B9BC ; Constant 1.00 (table of constants in Mfltp-format for LOG) 
;$B9C1 ; Constant 03 (grade of polynome, then 4th coefficient) 
;$B9C2 ; Constant 0.434255942 (1st coefficient) 
;$B9C7 ; Constant 0.576584541 (2nd coefficient) 
;$B9CC ; Constant 0.961800759 (3rd coefficient) 
;$B9D1 ; Constant 2.885390073 (4th coefficient) 
;$B9D6 ; Constant 0.707106781 = 1/SQR(2) 
;$B9DB ; Constant 1.41421356 = SQR(2) 
;$B9E0 ; Constant -0.5 
;$B9E5 ; Constant 0.693147181 = LOG(2) 
;$B9EA ; BASIC-function LOG 
;$BA28 ; FAC = constant (accu/Y reg) * FAC 
;$BA30 ; FAC = ARG * FAC 
;$BA59 ; Multiplies FAC with one byte and stores result to $26 .. $2A 
;$BA8C ; ARG = constant (accu/Y reg) 
;$BAB7 ; Checks FAC and ARG 
;$BAE2 ; FAC = FAC * 10 
;$BAF9 ; Constant 10 in Flpt 
;$BAFE ; FAC = FAC / 10 
;$BB0F ; FAC = constant (accu/Y reg) / FAC 
;$BB14 ; FAC = ARG / FAC 
;$BB8A ; Output error message ?DIVISION BY ZERO 
;$BBA2 ; Transfer constant (accu/Y reg) to FAC 
;$BBC7 ; FAC to accu #4 ($5C to $60) 
;$BBCA ; FAC to accu #3 ($57 to $5B) 
;$BBD0 ; FAC to variable (the adress, where $49 points to) 
;$BBFC ; ARG to FAC 
;$BC0C ; FAC (rounded) to ARG 
;$BC1B ; Rounds FAC 
;$BC2B ; Get sign of FAC: A=0 if FAC=0, A=1 if FAC positive, A=$FF if FAC negative 
;$BC39 ; BASIC-function SGN 
;$BC58 ; BASIC-function ABS 
;$BC5B ; Compare constant (accu/Y reg) with FAC: A=0 if equal, A=1 if FAC greater, A=$FF if FAC smaller 
;$BC9B ; FAC to integer: converts FAC to 4-byte integer 
;$BCCC ; BASIC-function INT 
;$BCF3 ; Conversion PETSCII-string to floating-point format 
;$BDB3 ; Constant 9999999.9 (3 constants for float PETSCII conversion) 
;$BDB8 ; Constant 99999999 
;$BDBD ; Constant 1000000000 
;$BDC2 ; Output of "IN" and line number (from CURLIN $39, $3A) 
;$BDCD ; Output positive integer number in accu/X reg 
;$BDDD ; Convert FAC to PETSCII string which starts with $0100 and ends with $00. Start address in accu/Y reg. 
;$BE68 ; TI to string: convert TI to PETSCII string which starts with $0100 and ends with $00 
;$BF11 ; Constant 0.5 
;$BF16 ; Constant tables for integer PETSCII conversion 
;$BF3A ; Constant tables to convert TI to TI$ 
;$BF71 ; BASIC-function SQR 
;$BF78 ; Power function FAC = ARG to the power of constant (accu/Y reg) 
;$BF7B ; Power function FAC = ARG to the power of FAC 
;$BFB4 ; Makes FAC negative 
;$BFBF ; Constant 1.44269504 = 1/LOG(2) (table of 8 constants to evaluate EXP - polynomal table) 
;$BFC4 ; Constant 07: 7 = Grade of polynome (followed by 8 coefficient constants) 
;$BFC5 ; Constant 2.149875 E-5 
;$BFCA ; Constant 1.435231 E-4 
;$BFCF ; Constant 1.342263 E-3 
;$BFD4 ; Constant 9.641017 E-3 
;$BFD9 ; Constant 5.550513 E-2 
;$BFDE ; Constant 2.402263 E-4 
;$BFE3 ; Constant 6.931471 E-1 
;$BFE8 ; Constant 1.00 
BASEXP = $BFED ; BASIC-function EXP 

