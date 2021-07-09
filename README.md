# <img src="https://github.com/VladThodo/minZ80/blob/main/zilog_inside.png" width="50" height="50"/> Min-Z80
Min-Z80 is a minimal single-board computer based on the Z80 microprocessor. The project was originally inspired by Ben Eater and his series on building a simple 6502 based computer, but, since I wasn't able to find any 6502 processor for following along, I decided to go my own way and build something similar based on the Z80. Like most single-board computers based on retro chips, the goal of this project is entirely educational. However, I think getting a basic idea on how computers work at a very low level is just awsome!

## Basic specs

* Z80 processor running at maximum 1MHz
* 32K ROM
* 32K RAM
* 4 column LCD display
* SN76489 sound chip

## Before you begin

An EEPROM programmer is required in order to burn the machine code to the EEPROm chip. There are comercially available products that do the job perfectly, but for a useless DIY project like this, I followed <a href="https://github.com/nathsou/EEPROM-Burner#readme">this</a> tutorial and built my own using an Arduino Nano and a couple of shift registers. I do have to mention that for some reason that I do not understand, it does not work perfectly and sometimes requires multiple attempts in order to get the code properly uploaded on the EEPROM. Nonetheless, I did manage to get along only with this.

## The end result

Well, there's no such thing as an end result in this case since there's always room for improvement, either hardware or software. But this is what the board looks like after adding all of the main components. Ben Eater built his on breadboards, but since high-quality breadboards are expensive and there's no way to get this working on cheap breadboards (trust me, there's no way), I deciced that perfboard and solder are the way to go. I tried to keep it tidy, at least on the top side, since the bottom side is just a big mess of wires. For easier serviceability, I do recommend trying to think it through more than I did when it comes to managing those wires.

The board is powered via a USB cable @ 5V.

<img src="https://github.com/VladThodo/minZ80/blob/main/board.jpeg"/>
