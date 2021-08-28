; This file contains all the hardware related constants. Consult the wiki for more details

porta_c: equ %00000010  ; Port A of the PIO; d for data and c for control
porta_d: equ %00000000 

portb_c: equ %00000011  ; Port B of the PIO; d for data and c for control
portb_d: equ %00000001

pio_out: equ %00001111  ; Out mode control word for the PIO
pio_bit: equ %11001111  ; Bit mode control word for the PIO

lcd_enable: equ %00001100 ; Enable byte for the LCD
lcd_rs:     equ %00001001 ; LCD register select byte
lcd_rw:     equ %00001010 ; LCD r/w control byte

snd_we_off: equ %00001000 ; Sound chip /WE off
snd_we_on:  equ %00000000 ; Sound chip /WE on

ch0_off:    equ %10011111
ch1_off:    equ %10111111
ch2_off:    equ %11011111
ch3_off:    equ %11111111