.include   "telestrat.inc"
.include   "fcntl.inc"

userzp := $80 ; FIXME

.org $c000

.code
rom_start:
        rts

rom_signature:
	.ASCIIZ   "Empty rom V0.1 - __DATEBUILT__"


	
; ----------------------------------------------------------------------------
; Copyrights address

        .res $FFF8-*
        .org $FFF8

signature_address:
        .word   rom_signature

; ----------------------------------------------------------------------------
; Version + ROM Type
ROMDEF: 
        .addr rom_start

; ----------------------------------------------------------------------------
; RESET
rom_reset:
        .addr   rom_start
; ----------------------------------------------------------------------------
; IRQ Vector
teleass_irq_vector:
        .addr   IRQVECTOR ; from telestrat.inc (cc65)
end:
