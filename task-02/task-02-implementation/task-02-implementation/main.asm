;
; task-02-implementation.asm
;
; Created: 31/10/2021 22:58:33
; Author : augus
;


.cseg                   ; just to remember that we are writing code into flash memory (code/program memory)
.org 0x0				; set the assembler writing to the top of the flash memory (cseg locality counter)

.def count = r16		; defining the counter register
.def temp = r17			; defining temporary register to set the in/out configuration of port registers

rjmp RESET              ; in case of microcontroller reset, goes to this label

RESET:
	ldi temp,  0xFF		; loads 1111 1111 in temp register
	out DDRB,  temp		; configure all port b pins as output
	ldi temp,  0x00		; loads 0000 0000 in temp register
	out DDRD,  temp		; configure all port d pins as input
	ldi count, 0x00		; initialize count register to zer0

loop:
	sbic PIND, 0        ; skip if bit 0 of PIND is clear, ie there is no click in button 0
	inc  count			; increment counter if bit 0 of PIND is clear
	out  PORTB, count	; OUTPUT the counter in PORTB
	rjmp loop			; just loop to read PIND again
