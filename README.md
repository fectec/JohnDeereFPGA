# John Deere FPGA

John Deere tractor driving simulator via Unity game engine. The vehicle is controlled through the DE10-Lite FPGA board programmed in VHDL. The accelerometer represents the Steering, the switches the Gear Selection and the buttons the Throttle and Brake. This information is sent via TTL/USB to the simulation running on a desktop or personal computer, which displays the corresponding tractor behavior on the monitor. Likewise, if an object is picked up in the video game, this data is sent via the above-mentioned channel to the board, which then shows the number of items picked up so far on a 7-segment display.


