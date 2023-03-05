# <img src="https://github.com/VladThodo/minZ80/blob/main/zilog_inside.png" width="50" height="50"/> Min-Z80
Min-Z80 is a minimal single-board computer based on the Z80 microprocessor. The project was originally inspired by Ben Eater and his series on building a simple 6502 based computer, but, since I wasn't able to find any 6502 processor for following along, I decided to go my own way and build something similar based on the Z80. Like most single-board computers based on retro chips, the goal of this project is entirely educational. However, I believe that getting an idea about the building blocks of modern computers is fascinating.

This readme file is just a quick overview of the project. For more details on how this SBC works, please consult the project's [wiki](https://github.com/VladThodo/minZ80/wiki).

## Basic specs

* Z80 processor running at maximum 1MHz
* 32K ROM
* 32K RAM
* 4 row LCD display
* SN76489 sound chip

## Before you begin

An EEPROM programmer is required in order to burn the machine code to the EEPROM chip. There are comercially available products that do the job perfectly, but for a useless DIY project like this, I followed <a href="https://github.com/nathsou/EEPROM-Burner#readme">this</a> tutorial and built my own using an Arduino Nano and a couple of shift registers (it is worth noting though that the provided PC software requires node version 7.10.1 in order to run without any errors). I do have to mention that for some reason that I do not understand, it does not work perfectly and sometimes requires multiple attempts in order to get the code properly uploaded on the EEPROM. Nonetheless, I did manage to get along only with this.

## The code

The computer is programmed entirely in Z80 Assembly. There's a lot of documentation available online (with http://z80-heaven.wikidot.com being particularly useful) as well as datasheets from the manufacturer that explain each possible instruction in detail.

The code is assembled using `z80asm`, a generic Z80 assembler available in the main Ubuntu repository. Similar alternatives for Windows probably exist as well.

If you are using Ubuntu, this simple command is all you need to run in order to get started:

```   
sudo apt-get install z80asm
```

The assembler is also availabile for Arch Linux users. To install the assembler on Arch, you need to clone the source code and build it locally (make sure you have git installed on your system first, as it is required).

```
git clone https://aur.archlinux.org/z80asm.git
```

```
cd z80asm
makepkg -si
```

The documentation for the assembler can be found [here](https://www.nongnu.org/z80asm/).

If you want to test your code before uploading it to the EEPROM or just experiment with Z80 Assembly in general, this [emulator](https://github.com/sklivvz/z80) can be a useful resource depending on what you're trying to achieve. It can run simple Z80 assembly programs and display the memory contents/CPU flags etc.

## The end result

There's no such thing as an end result in this case since there's always room for improvement, either hardware or software. However, this is what the board looks like after adding all of the main components. Ben Eater built his on breadboards, but since high-quality breadboards are expensive and there's no way to get this working on cheap breadboards (loose connections are your worst nightmare in this case), I deciced that perfboard and solder are the way to go. I tried to keep it tidy, at least on the top side, since the bottom side is just a big mess of wires. For easier serviceability, I do recommend trying to think it through more than I did when it comes to managing those wires.

The board is powered via a USB cable @ 5V.

<img src="https://github.com/VladThodo/minZ80/blob/main/board.jpeg"/>
