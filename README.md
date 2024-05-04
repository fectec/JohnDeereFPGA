# JohnDeereFPGA

Main project in collaboration with *John Deere* for the undergrad course “**Design with Programmable Logic**”, which delves into programmable logic devices, with an FPGA as the main tool in which digital designs were developed and tested.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/c16ad87a-b44f-4f33-8b6f-cad34f7cb0b8" alt = "DE10-Lite" width="518" height="291"/>
</p>

It consists of a **John Deere tractor driving simulator via the Unity game engine**. The vehicle is controlled through the **DE10-Lite FPGA board programmed in VHDL**. The *accelerometer* represents the steering, the *switches* represent the Gear Selection and the *buttons* represent the Throttle and Brake. This information is sent via TTL/USB to the simulation running on a desktop or personal computer, which displays the corresponding tractor behavior on the monitor. Likewise, if an object is picked up in the video game, this data is sent via the above-mentioned channel to the board, which then shows the number of items picked up so far on a *7-segment display*.

First implementation was done using *UART*, *debounce*, *BCD to 7 segments decoder* and *accelerometer* entities instantiated as components inside a board interface top-entity. Then, a *Gumnut* soft-core microprocessor was added so it would be possible to interact with all the interfaces (accelerometer, switches, buttons, displays, serial port) via *Assembly*.

## Gumnut-less implementation

This part relies on a *Moore's Finite State Machine*. It transitions to the state of the current active input element, where it sends employing UART component a corresponding value, which is then decoded in the Unity *C#* script to perform the desired action.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/c63962ac-0404-47f9-9ca1-4f194da40d04" alt = "FSM" width="518" height="291"/>
</p>

### RTL-level design

Five entities are handled, *interface* as the top-entity, *UART*, *Decoder_BCDTo7Seg*,
*debounce* and *accelerometer*.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/ea600568-abfe-430e-8470-184ec55b596f" alt = "RTL design diagram complete and broken down by entities" width="518" height="291"/>

### Top-entity

The *top-entity* is an *interface* to the device, so the port consists of the clock, buttons, switches and GPIO 24, which acts as RX, as inputs; and GPIO 25, which acts as TX, LEDs and display segments as outputs. Additionally, there are definitions for the operation of the accelerometer.

### Top-entity components

Next, the components to be used are declared. The first one, “UART”, is responsible for the serial connection between the board and the personal computer. The second, “debounce”, debounces any button. The third one, “Decoder_BCDTo7Seg” is a 7-segment decoder. Finally, “accelerometer”, delivers the x-axis orientation data of the board.

Therefore, the components (one UART, two debounce, one decoder and one accelerometer) are instantiated and a port map is made in such a way as to ensure their correct functionality. With the exception of the decoder, all are connected to CLOCK_50 of the interface port.

### Signals on debounce components

The debounce components receive the inputs from the bounced buttons, *KEY(1:0)*, and debounce them. *key0_db* and *key1_db* capture the output of these components, and thus represent the state of the buttons after debouncing, so they will be used instead of their port equivalent.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/cf3fac4e-f706-4f3e-b888-6e2863d6ffcf" alt = "Signals on debounce components" width="400" height="150"/>
</p>

### Signals on UART component

*reset_n_de10* is the reset signal of the UART entity, it is set to '1' to keep the protocol operating. *tx_ena_de10* enables data transmission. *tx_data_de10* contains the information to be transmitted. The *UART TX serial output* is connected to *GPIO_25* of the port. On the other hand, the *serial input RX* is connected to *GPIO_24*. *rx_data_de10* holds the received data.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/6c34f5a3-9c36-48dc-af37-9619b49c2507" alt = "Signals on UART component" width="400" height="150"/>
</p>

### Signals on accelerometer component

The vector with the x-orientation of the board provided by the accelerometer is connected to *LEDR* of the port, i.e. to the LEDs of the device. However, LEDR is a buffer signal so its content can be read by the program. So it is assigned to the *acc_data_de10* signal, which is converted to unsigned integer and stored in *acc_data_de10_integer*. This way we obtain a number that represents the location of the DE10-lite.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/ae713323-710a-4f90-88d9-205f2ac1d15a" alt = "Signals on accelerometer component" width="300" height="290"/>
</p>

### Signals on decoder component

Finally, the decoder receives the 4 least significant bits of *rx_data_of10*, that is, of the vector with the data received by serial communication, sent by Unity. When an object is collected, a counter is incremented and the latter is sent serially in hexadecimal format. The board receives it, connects it to the entity just mentioned, and carries out the decoding to show the number on the 7-segment displays, this with a dataflow model.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/161080d0-0a56-415e-96be-476c35e9aa33" alt = "Signals on decoder component" width="400" height="360"/>
</p>

### Process of converting accelerometer data to a current orientation signal

Now, the first clock-sensitive process pigeonholes the signal *acc_data_de10_integer* into a range and turns on a signal with the corresponding board orientation. In other words, a meaning is given to the orientation vector provided by the accelerometer, knowing that the accelerometer behaves in such a way that one or two LEDs move laterally depending on the rotation of the DE10-lite.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/1117d752-2fe4-40f6-913e-a8be95fba7c5" alt = "Process of converting accelerometer data to a current orientation signal" width="300" height="250"/>
</p>

### State machine process for selection and transmission of information

The second process, a Moore FSM, uses the signals just analyzed. There are eleven states, each representing a tractor action: No motion, first, second, third, fourth and fifth gears, reverse, acceleration, braking, right and left turns.

It starts from the IDLE state, and from this state it is possible to transition to any other state if the respective signal on the interface is activated.

For example, if you want to use the first gear, assigned to the switch in the zero position of the board, you only need to turn it on. Thus there will be a transition to the FIRST_GEAR state, which will be maintained as long as the switch is not turned off.

The action corresponding to all states excluding IDLE is to turn off the signal *tx_ena_de10 signal*, which activates the serial communication. Then, each state places a particular value in *tx_data_de10*, the data to be transmitted. In the case of FIRST_GEAR this is 0x01, which will be interpreted by Unity so that the tractor performs the corresponding action.

In conclusion, no data is transmitted during the IDLE state. 

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/ae6841e3-69f3-4d1b-80a4-29260a26c19c" alt = "State machine process for selection and transmission of information" width="400" height="150"/>
</p>

## Gumnut implementation

Still under work.

## Game Demos

### Unity

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/4d428feb-667c-4045-84e7-b67829407e78" alt = "Game Demo" width="518" height="291"/>
</p>

### Unity & FPGA Control

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/52809685-ae9e-471b-bf5a-7fce4017ce11" alt = "Game Control Demo" width="518" height="291"/>
</p>

## Bonus - VGA Interface

As a part of the coursework, the board's *VGA* interface was used to display and move an object. Since it was a fun activity and a first approach to the accelerometer, it was decided to push this code too. The sprites for the character were generated using a *Python* script that scales and transforms images into a matrix of values, each one representing a coded *R, G & B* representation of the pixel.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/a2bd6ac9-bb7d-48b2-89cb-583ef9889255" alt = "VGA Among Us" width="518" height="291"/>
</p>

## Link to Unity Game Repository

https://github.com/Cook131/Proyecto-JohnDeere
