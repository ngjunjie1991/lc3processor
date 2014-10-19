ORIGIN 4x0000
    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)
SEGMENT  CodeSegment:
    ;; R0 is assumed to contain zero, because of the construction
    ;; of the register file.  (After reset, all registers contain
    ;; zero.)

    ;; Note that the comments in this file should not be taken as
    ;; an example of good commenting style!!  They are merely provided
    ;; in an effort to help you understand the assembly style.

    LDR  R1, R0, ONE    ; R1 <= 1
    LDR  R2, R0, TWO    ; R2 <= 2
    LDR  R3, R0, EIGHT  ; R3 <= 8
	NOP
	NOP
    ADD R4, R3, R2      ; R4 <= R3 + R2
	BRnzp	LOOP1
	NOP
	NOP
	NOP

ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
EIGHT:  DATA2 4x0008
RESULT: DATA2 4x0000
GOOD:   DATA2 4x600D

LOOP1:
    ADD R3, R3, R3      ; R3 <= R3 + R3
    NOT R5, R2          ; R5 <= not(R2)
	NOP
	NOP
    ADD R5, R5, R1      ; R5 <= R5 + R1
	NOP
	NOP
    ADD R4, R4, R5      ; R4 <= R4 + R5
    BRzp LOOP1          ; Branch if last result was zero or positive.
	NOP
	NOP
	NOP

    AND R7, R3, R4
	NOP
	NOP
    STR R7, R0, RESULT
    LDR R1, R0, RESULT
    NOT R0, R7
	NOP
	NOP
    AND R0, R1, R0
	NOP
	NOP
    STR R0, R0, RESULT
    LDR R1, R0, GOOD

HALT:                   ; Infinite loop to keep the processor
    BRnzp HALT          ; from trying to execute the data below.
    NOP					; Your own programs should also make use
   	NOP                 ; of an infinite loop at the end.
	NOP


