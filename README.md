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
Hector Dominguez - PPU
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

N/A

###4. PPU - The Picture Processing Unit

N/A

###5. APU - The Pseudo-Audio Processing Unit

N/A

###6. Hardware - VGA, Controller, Sound, and SD Card interfacing

N/A
