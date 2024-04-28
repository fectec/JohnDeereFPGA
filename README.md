# JohnDeereFPGA

Main project for undergrad course “Design with Programmable Logic”, which delves into programmable logic devices, being an FPGA the main tool in which digital designs are developed and tested.

It consists of a John Deere tractor driving simulator via Unity game engine. The vehicle is controlled through the DE10-Lite FPGA board programmed in VHDL. The accelerometer represents the steering, the switches the Gear Selection and the buttons the Throttle and Brake. This information is sent via TTL/USB to the simulation running on a desktop or personal computer, which displays the corresponding tractor behavior on the monitor. Likewise, if an object is picked up in the video game, this data is sent via the above-mentioned channel to the board, which then shows the number of items picked up so far on a 7-segment display.

![DE10-Lite Board](https://ibb.co/YW5J91h)

First implementation was done using UART, debounce, BCD to 7 segments decoder and accelerometer entities instantiated as components inside a board interface top-entity. Then, Gumnut soft core microprocessor was added so it would be possible to interact with all interfaces (accelerometer, switches, buttons, displays, serial port) via Assembly.

## Gumnut-less implementation

This part relies on a Finite State Machine. It transitions to the state of the current active input element, where it sends employing UART component a corresponding value, which is then decoded in the Unity C# script to perform the desired action.

![FSM](https://ibb.co/JWZ3gJ0)

## Gumnut implementation

Still under work.

## Game Demos

### Unity

![Game Unity Demo](https://freeimage.host/i/JUNWeVt) 

### Unity & FPGA Control

![Game Control Demo](https://freeimage.host/i/JUNVN6u)

## Bonus - VGA Interface

As a part of the coursework, board's VGA interface was used to display and move an object. Since it was a fun activity, it was decided to push this code too. The sprites for the character were generated using a Python script which scales and transforms images into a matrix of values, each one representing a coded R, G, B representation of the pixel.

<a href="https://ibb.co/yXsw8Z0"><img src="https://i.ibb.co/0cJgf6q/AMOGUS.gif" alt="VGA Among Us" border="0"></a>
