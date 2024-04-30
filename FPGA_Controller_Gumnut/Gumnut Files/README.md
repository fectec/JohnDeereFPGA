# Files to embed Gumnut soft-core.

Add this files to the Intel Quartus Prime project for Gumnut to work. 

Gasm is a simple assembler for the Gumnut soft-core processor. Gasm translates a program written in assembly code (gumnut.gasm) into the binary encoded required by the Gumnut core. So the program text (the instructions) are encoded and written to a text memory image file (gasm_text.dat), and the initial values for the program data are binary encoded and written to a data memory image file (gasm_data.dat).