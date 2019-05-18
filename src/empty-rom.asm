.include   "telestrat.inc"
.include   "fcntl.inc"
.include   "build.inc"

userzp := $80 ; FIXME

.org $c000

.code
rom_start:
        rts

rom_signature:
	.ASCIIZ   "Empty rom V0.2 - __DATE__"

_command1:
        rts

command1_str:
        .ASCIIZ "command1"

commands_text:
        .addr command1_str
commands_address:
        .addr _command1
commands_version:
        .ASCIIZ "0.0.1"
parse_routine:
        ; A & Y contains the string to execute
        ; for example, if you want to execute the program hello in your rom :
        ; exec hello
        ; exec command will call your "parse_routine" with "hello" string pointer in A & Y 
        ; BUFEDT contains your command without exec word
        ; if you want to call any program in your rom, you can do :
        ; lda #<mystring_to_execute ; mystring_to_execute must be in ram because rom which contains the command needs to access  this string in order execute it
        ; lda #>mystring_to_execute
        ; BRK_ORIX($63)
        ; 
        ; To test your command
        ; Type :
        ; exec mycommand
        rts


	
; ----------------------------------------------------------------------------
; Copyrights address

        .res $FFF1-*
        .org $FFF1
; $fff1
parse_vector:
        .addr parse_routine        
; fff3
adress_commands:
        .addr commands_address   
; fff5        
list_commands:
        .addr commands_text        
; $fff7
number_of_commands:
        .byt 1
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
empty_rom_irq_vector:
        .addr   IRQVECTOR ; from telestrat.inc (cc65)
end:
