NES-FPGA
========


Overview
--------

This is our attempt at creating an NES emulator on a DE2i-150 board, which
consists of an Altera Cyclone IV FPGA with VGA, SD card, and GPIO support.


Table of Contents
-----------------

1. Who Are We?
2. Summary
3. CPU
4. PPU
5. APU
6. Hardware


###1. Who Are We?
We are a group of Computer Engineering students from University of California, Riverside. As part of our Senior Design class in our Summer Study Abroad course in Lausanne, Switzerland, we decided to tackle something that deals with both hardware and software interfacing. Naturally, we chose to work with an FPGA. What better way to explore FPGAs with writing an entire NES emulator from scratch!

The team is currently split up into the following tasks:


Sergio Morales - CPU

Hector Dominguez - PPU, Reading from SD Card to RAM

Omar Torres - SD Card interface, hardware

Randy Truong - Hardware

Kevin Mitton - APU interface, hardware


###2. Summary
We decided to set up the emulator as follows:

- Backed-up games will be loaded up through an SD card onto the FPGA's RAM.
- Video will be output through VGA format
- Controllers will be set up on GPIO, as well as audio.
- The entire software interface will be on the FPGA itself, written in Verilog through Quartus II/ModelSim.

###3. CPU - The Ricoh 2A03 Processor

The Ricoh 2A03 Processor consists of:

- 8-bit MOS 6502 Microprocessor lacking BCD mode.
- 22 I/O registers (memory-mapped)
- psedu-APU
- Controller support


#####Current development status:
Instruction decoding and execution.

###4. PPU - The Picture Processing Unit

         **Short Summary of PPU Research - FUll Research Document will be release soon**

  - The Picture Processing Unit is controlled via eight Registers($2000 - $2007) which are visible from the CPU.
  - These registers hold the data and information such as the Game Sprites, Background and Color palettes.
  
  Color Palettes
    - The NES has two color Palettes which they both have 16 entries (16-bytes reserved for SPrites and 16-bytes             reserved for Bacground. However, Mirror occurs every four bytee. 
      - Because of this the total number of bytes available for Sprites is 13-Bytes and 12-Bytes for Backgrounds.
 
  Tile Sets(Pattern Tables) 
    - Pattern Tables hold 8x8 Pixles we is what is going to be output to the screen. 
    - Each set is capable of holding 256 tiles which is equivaent of 4K or 4096-Bytes.
    - Since each pixels needs 2 pixel, this gives you a total of 16 bytes per tile (8x8 pixels= 64 Pixels x 2 bits =          16-Bytes.)
    - PPU has two 4096-Byte Pattern Tables stored in memory location $0000 and $1000
        -Background
        -SPrites
    - Pattern tables stored the 2 most sigificatn bits to identify the image being drawn to the screen.
      for example:
          00b is pallete entry 0
          01b is pallete entry 1
    
  NameTables/Attribute Table
    - A NameTable is pretty much a matrix of tiles that point to the location where the tiles are stored in the              Tile-Sets.
    - NameTables Hold 32x30 tiles, where one tile is 8x8 Pixels. Therefore, one Nametable is 256x240 Pixels.
    - Each NameTable has an Attribute table(list) that hold 2-bits of the color for the tile. 
    - Each byte in the Attribute list represents a 4x4 Group of tiles. 
    For more information about Nametables and diagrams of how it works. please wait future detailed Document.
    
  Sprites
    - Sprites are characters to be drawn to the screen.
    - They can be either 8x8 Pixels or 8x16 Pixles 
    - Most of characters are composed of multiple sprites.
    - Sprite data, as explained earlier, is stored in the pattern tables.
      - Attributes are stored in SPR-RAM
    - There is a maximum of 64 Sprites where each is 4Bytes long in SPR-RAM
    
    - For 8x16 Pixel Sprites, they work a little differenlty. They use different Pattern Tables Based on an Index            Number.
      - If the index number is even, the sprite data is in the first pattern table at $0000.
      - Else it is in the other Pattern Tale located in memory $1000.
    - Sprites can be read or written to it one at a time by first writting the requred address to #2003 and then reading      or writting to #2004.
    
    - Sprites are given Priority on their position in SPR-RAN
    - The first sprite is known as sprite  and has higher priority. 
    - on each line the system calculates which sprite are on that line and draws them. 
      - Lowest priorities first to ensure High Priority sprites are drawn on top.
    - Only allowed to write 8 Sprites per scanline. 
      - if it reaches 8, sets bit 5 of I/O register $2002 on.
      
      **More Detailed document with Diagrams of the PPU will be release soon**

###5. APU - The Pseudo-Audio Processing Unit

N/A

###6. Hardware - VGA, Controller, Sound, and SD Card interfacing

N/A
