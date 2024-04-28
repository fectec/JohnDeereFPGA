# JohnDeereFPGA

Main project for undergrad course “**Design with Programmable Logic**”, which delves into programmable logic devices, being an FPGA the main tool in which digital designs are developed and tested.

![132318264_TerasicTechnologies_DE10-LiteBoard-TerasicTechnologies](https://github.com/fectec/JohnDeereFPGA/assets/127822858/c16ad87a-b44f-4f33-8b6f-cad34f7cb0b8)

It consists of a **John Deere tractor driving simulator via Unity game engine**. The vehicle is controlled through the **DE10-Lite FPGA board programmed in VHDL**. The *accelerometer* represents the steering, the *switches* the Gear Selection and the *buttons* the Throttle and Brake. This information is sent via TTL/USB to the simulation running on a desktop or personal computer, which displays the corresponding tractor behavior on the monitor. Likewise, if an object is picked up in the video game, this data is sent via the above-mentioned channel to the board, which then shows the number of items picked up so far on a *7-segment display*.

First implementation was done using *UART*, *debounce*, *BCD to 7 segments decoder* and *accelerometer* entities instantiated as components inside a board interface top-entity. Then, *Gumnut* soft core microprocessor was added so it would be possible to interact with all interfaces (accelerometer, switches, buttons, displays, serial port) via *Assembly*.

## Gumnut-less implementation

This part relies on a *Finite State Machine*. It transitions to the state of the current active input element, where it sends employing UART component a corresponding value, which is then decoded in the Unity *C#* script to perform the desired action.

![Screenshot-from-2024-04-27-23-45-13-removebg-preview](https://github.com/fectec/JohnDeereFPGA/assets/127822858/c63962ac-0404-47f9-9ca1-4f194da40d04)

## Gumnut implementation

Still under work.

## Game Demos

### Unity

![Game Demo](https://github.com/fectec/JohnDeereFPGA/assets/127822858/4d428feb-667c-4045-84e7-b67829407e78)

### Unity & FPGA Control

![a](https://github.com/fectec/JohnDeereFPGA/assets/127822858/6a690e65-00ae-4835-879f-19182e60e8d9)

## Bonus - VGA Interface

As a part of the coursework, board's *VGA* interface was used to display and move an object. Since it was a fun activity and a first approach to the accelerometer, it was decided to push this code too. The sprites for the character were generated using a *Python* script which scales and transforms images into a matrix of values, each one representing a coded *R, G, B* representation of the pixel.

<img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/a2bd6ac9-bb7d-48b2-89cb-583ef9889255" alt = "VGA Among Us" width="518" height="291"/>
