
.text	

  *=$C000
VIRQ  
start
  lda #$11 
  sta $bb80+20
loop
  jmp loop
copy 
.asc "Hello",0   
  
free_bytes ; 26 bytes
    .dsb $ffff-free_bytes-7,0 ; 5 because we have 5 bytes after

    
   
; fffa
END_ROM
copyright
  .byt <copy
  .byt >copy
version_bank
    .byt $00
;$fffb
status_bank
    .byt %00101000 ;
; fffc
RESET:
    .byt <start,>start
; fffe
BRK_IRQ:	
    .byt <VIRQ,>VIRQ	
	
	
