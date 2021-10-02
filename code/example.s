;***************************************************** 
 ; 
 ; Firmware for the Z80 SBC. Assembled with the generic z80asm from
 ; the main Ubuntu repository. The memory map is explained below.
 ;
 ; Total memory: 64KB divided into 32KB ROM and 32KB RAM.
 ; ROM: 0x0000 - 0x7FFF
 ; RAM: 0x8000 - 0xFFFF
 ; 
 ; I/O addresses are accessed separately with the IN/OUT  commands
 ;
 ; PIO: 0x00 - 0x03
 ; SN76489 PSG: 0x04 - 0x 
 ;*****************************************************

PORT_A_C:  equ %00000010    ; PORTA control register addr
PORT_A_D:  equ %00000000    ; PORTA data register addr
PORT_B_C:  equ %00000011    ; PORTB control register
PORT_B_D:  equ %00000001    ; PORTB data register addr

OUT_WORD:  equ %00001111    ; Configuration word for the PIO (output mode). Write this to the control register of any port to get it into output mode
BIT_MODE:  equ %11001111    ; Configuration word for the PIO (bit mode). This sets the port in bit mode. Important! This requires another byte to be sent to the PIO
                            ; Each bit of the next byte configures the specific port bit as input/output (0 for output, 1 for input)

ENABLE:    equ %00001100    ; Control bytes for the LCD display. These are mainly written to 
RS:        equ %00001001    ; the PORTA of the PIO because that's where the control lines of the
RW:        equ %00001010    ; LCD are connected. PORTB is mainly used for data transfer to the LCD and reading the keyboard
CGRAM_ADDR:equ %01000000
 
ADDR_ON:   equ 80h          ; Not used right now
ADDR_OFF:  equ 90h  

SND_WE_OFF:    equ %00001000    ; Sound chip /WE 
SND_WE_ON:     equ %00000000  


 ; Main setup. We need to initialize the PIO and make that sound chip shut up

SETUP:

 LD SP, 0xFF00      ; Set stackpointer at adddress FF00
 DI                 ; Disable interrupts
 LD A, BIT_MODE
 OUT (PORT_A_C),A   ; Port A is used in bit mode
 LD A, %00000000    ; Therefore it requires some extra setup
 OUT (PORT_A_C),A
 LD A, OUT_WORD     
 OUT (PORT_B_C),A
 LD C, %10000000
 
 CALL LCD_SETUP
 CALL CLEAR_DISPLAY
 
 LD A, SND_WE_OFF
 OUT (PORT_A_D), A
 
 CALL CHIP_SHUT_UP
 
 LD HL, 0x130       ; Hello Z80! 
 CALL PRINT_STRING 
 LD A, 30
 CALL WAIT

 CALL NEXT_LINE
 LD HL, 0x140
 CALL PRINT_STRING
 CALL PLAY_SOME_SOUND

 CALL NEXT_LINE
 LD HL, 0x150
 CALL PRINT_STRING
 JP LOOP


LCD_SETUP:
 
 LD A, ENABLE  		; Function set
 OUT (PORT_A_D), A
 LD A, %00111000
 OUT (PORT_B_D), A
 LD A, 0
 OUT (PORT_A_D), A 
 
 LD A, ENABLE		; Display on, cursor blinking
 OUT (PORT_A_D), A
 LD A, %00001111
 OUT (PORT_B_D), A
 LD A, 0
 OUT (PORT_A_D), A

 LD A, ENABLE		; Entry mode set	
 OUT (PORT_A_D), A
 LD A, %00000110
 OUT (PORT_B_D), A
 LD A, 0
 OUT (PORT_A_D), A

 RET
 
CLEAR_DISPLAY: 

 LD A, ENABLE          ; Clear display        
 OUT (PORT_A_D), A
 LD A, %00000001
 OUT (PORT_B_D), A
 LD A, %00001000
 OUT (PORT_A_D), A

 RET

 
PRINT_STRING:	       ; Prints the string located at ADDR until a zero	

 LD A, %00001101
 OUT (PORT_A_D), A     ; The aim is to store the string we want to print
 LD A, (HL)	           ; somewhere in memory and use HL to point to that address.		
 CP 0
 RET Z
 OUT (PORT_B_D), A     ; Then we increment HL and keep printing until until we find a zero
 LD A, RS 	       ; In which case we jump to our infinite loop
 OUT (PORT_A_D), A
 INC HL
 JP PRINT_STRING

NEXT_LINE:
 LD A, C
 CP 128
 JP Z, SECOND_LINE
 CP 192
 JP Z, THIRD_LINE
 CP 212
 JP Z, FOURTH_LINE

WRITE_TO_LCD:
 LD A, ENABLE         
 OUT (PORT_A_D), A
 LD A, C
 OUT (PORT_B_D), A
 LD A, %00001000
 OUT (PORT_A_D), A

 RET

SECOND_LINE:
 LD C, 192
 CALL WRITE_TO_LCD
 RET

THIRD_LINE:
 LD C, 148 
 CALL WRITE_TO_LCD 
 RET

FOURTH_LINE:
 LD C, 212
 CALL WRITE_TO_LCD
 RET

PLAY_SOME_SOUND:
 
 LD A, SND_WE_OFF
 OUT (PORT_A_D), A

 LD A, %11010111        ; Channel 2 volume
 CALL WRITE_TO_SOUND_CHIP

 LD A, %11001100        ; Channel 2 tone
 CALL WRITE_TO_SOUND_CHIP

 LD A, %01010001       ; Channel 2 tone second register. Now we should generate approximately 440 Hz on ch 2
 CALL WRITE_TO_SOUND_CHIP

 LD A, 20
 CALL WAIT

 LD A, %10000100        ; Channel 0 tone
 CALL WRITE_TO_SOUND_CHIP

 LD A, %01001101       ; Channel  tone second register. Now we should generate approximately 587 Hz on ch 0
 CALL WRITE_TO_SOUND_CHIP

 LD A, %10010111        ; Channel 0 volume
 CALL WRITE_TO_SOUND_CHIP

 LD A, 20
 CALL WAIT

 LD A, %10101101        ; Channel 1 tone
 CALL WRITE_TO_SOUND_CHIP

 LD A, %01001011      ; Channel  tone second register. Now we should generate approximately 659 Hz on ch 1
 CALL WRITE_TO_SOUND_CHIP

 LD A, %10110111        ; Channel 1 volume
 CALL WRITE_TO_SOUND_CHIP

 LD A, 30
 CALL WAIT

 CALL CHIP_SHUT_UP

 RET

CHIP_SHUT_UP:

 LD A, SND_WE_OFF
 OUT (PORT_A_D), A

 LD A, %10011111
 CALL WRITE_TO_SOUND_CHIP

 LD A, %10111111
 CALL WRITE_TO_SOUND_CHIP

 LD A, %11111111
 CALL WRITE_TO_SOUND_CHIP

 LD A, %11011111
 CALL WRITE_TO_SOUND_CHIP

 RET

WRITE_TO_SOUND_CHIP: ; Input: A register - the byte to write to the sound chip
 OUT (PORT_B_D), A
 LD A, SND_WE_ON
 OUT (PORT_A_D), A
 LD A, SND_WE_OFF
 OUT (PORT_A_D), A

 RET

WAIT:   ; Input: A register - how many times to execute this loop
 NOP
 DEC A
 CP 0
 RET Z
 JP WAIT

LOOP:
 JP LOOP
  
 defs 9
 defm 'Hello Z80!'
 defs 6
 defm 'Testing sound..'
 defs 1
 defm 'Boot complete!'
 defb 0x00
 

