# Files to embed Gumnut into the project.

Add this files to the Intel Quartus Prime project for Gumnut to work.

Gasm is a simple assembler for the Gumnut soft-core processor. The Gumnut is a simple 8-bit processor with separate instruction and data memories. 

Gasm translates a program written in assembly language (gumnut.gsm) into the binary encoding required by the Gumnut core. 

The program text (the instructions) are encoded and written to a text memory image file (gasm_text.dat), and the initial values for the program data are binary encoded and written to a data memory image file (gasm_data.dat). 