# JohnDeereFPGA

Main project in collaboration with *John Deere* for the undergrad course “**Design with Programmable Logic**”, which delves into programmable logic devices, with an FPGA as the main tool in which digital designs were developed and tested.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/c16ad87a-b44f-4f33-8b6f-cad34f7cb0b8" alt = "DE10-Lite" width="518" height="291"/>
</p>

It consists of a **John Deere tractor driving simulator via the Unity game engine**. The vehicle is controlled through the **DE10-Lite FPGA board programmed in VHDL**. The *accelerometer* represents the steering, the *switches* represent the Gear Selection and the *buttons* represent the Throttle and Brake. This information is sent via TTL/USB to the simulation running on a desktop or personal computer, which displays the corresponding tractor behavior on the monitor. Likewise, if an object is picked up in the video game, this data is sent via the above-mentioned channel to the board, which then shows the number of items picked up so far on a *7-segment display*.

First implementation was done using *UART*, *debounce*, *BCD to 7 segments decoder* and *accelerometer* entities instantiated as components inside a board interface top-entity. Then, a *Gumnut* soft-core microprocessor was added so it would be possible to interact with all the interfaces (accelerometer, switches, buttons, displays, serial port) via *Gumnut Assembly* (*Gasm*).

## Gumnut-less implementation

This part relies on a *Moore's Finite State Machine*. It transitions to the state of the current active input element, where it sends employing UART component a corresponding value, which is then decoded in the *Unity C#* script to perform the desired action.

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
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/ae6841e3-69f3-4d1b-80a4-29260a26c19c" alt = "State machine process for selection and transmission of information" width="600" height="200"/>
</p>

## Gumnut implementation

### RTL level design

First, the Gumnut component was added to the top-entity, so the RTL diagram differs from the one shown above.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/57bee814-b5d4-4f72-bd50-35e1b577f223" alt = "RTL design diagram complete and broken down by entities" width="518" height="291"/>
  
### Gumnut component signals

Gumnut has an *I/O interface* with which it receives / sends information from / to the top-entity and therefore from / to the interfaces. We want to introduce to the processor the data from *RX* (item counter in Unity), *switches*, *keys* and *accelerometer*.  It will perform the relevant operations and return the action code for each element, that is, the one interpreted by Unity, to be transmitted, as well as the transmission enable bit. In the case of RX, it will send the BCD code of the item counter to the 7-segment decoder that allows the display of that number.

First, it is connected to the following input signals: *clk_i*, synchronization signal obtained from the internal clock of the board; *rst_i*, reset bit of the component.

As part of the described bus are *port_ack_i* and *port_dat_i*. The first, a status signal indicating that the I/O port acknowledges the completion of an operation, which is set to a fixed value of one. The second, the 8-bit data read from the port, the latter addressed by an *inp instruction* in Gasm.

On the other hand, the output signals are: port_cyc_o, a “cycle” control signal that indicates that a sequence of I/O port operations is in progress; port_stb_o, a “strobe” control signal that shows that an I/O port operation is occurring; port_we_o, a “write enable” control signal that indicates that the operation is an I/O port write; port_addr_o, the 8-bit I/O port address; port_dat_o, the 8-bit data written to the I/O port addressed by an *out instruction* in Gasm.

### Inp and out operations

Thus, in a Gasm **inp** operation, the first attribute is the register in which you want to store the data received by Gumnut from the top-entity and the second is the address of the receive port determined by the location of a byte in data memory.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/0dafd3f8-28f2-4d35-a309-0900c9204364" alt = "Operation of inp operation in Gasm" width="300" height="280"/>
</p>

When an inp is performed, Gumnut places on the rising edge of the clock signal the address in port_adr_o of the I/O port, will turn on port_cyc_o and port_stb_o, clear port_we_o to note that this is a port read, and receive the information from port_dat_i to be stored in the corresponding register. 

In a Gasm **out** operation, the first attribute is the register from which the data Gumnut sends to the top-entity is retrieved and the second is the address of the sending port determined by the location of a byte in the data memory.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/13b5e513-8913-446b-abc7-288dfbbbe1c5" alt = "Operation of out operation in Gasm" width="400" height="280"/>
</p>

When an out is performed, Gumnut places on the rising edge of the clock signal the address in port_adr_o of the I/O port, will turn on port_cyc_o, port_stb_o and port_we_o, the latter to warn that it is a port write, and will send to information in port_dat_o to be fetched by the top-entity.

### VHDL interfaces with Gumnut

It is then necessary to define processes that recognize the meaning of such signals and perform the required interaction with the processor.

The input processes to Gumnut can be described as follows: Its sensitivity list is composed of the internal clock of the board and the rst_i signal of the Gumnut component. If rst_i is 1, the signal destined to enter the component is cleared. Otherwise, and as there is a rising edge in the synchronization signal, the value of the port_adr_o, port_cyc_o, port_stb_o and port_we_o signals are checked. 

port_cyc_o and port_stb_o must be 1 and port_we_o is 0, because an operation is being carried out and this is input. As specified, when Gumnut requests an input through the respective instruction, it places an address signal that depends on what is to be read, whether it is the RX data, the switches, the keys or the accelerometer, since all of them have different memory spaces.

Also, each of these elements has its own input process, the difference being the port_adr_o condition. If port_adr_o is equal, together with the above signal specifications, to the address that corresponds to the element, it means that Gumnut wants to recover its value, and therefore the conditional allows its signal to be the one placed in port_dat_i, in other words, to be read by the processor.

It should be noted that the same port_dat_i signal would have to be written from different processes, which is not allowed. So intermediate signals are used, of which one is selected to be assigned to port_dat_i depending on port_adr_o, or the element that Gumnut requires.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/25522978-cb10-46ce-a7e5-048a31f39717" alt = "Input interface" width="400" height="500"/>
</p>

On the other hand, the output processes from Gumnut differ from the previous ones only in the verification of the port_we_o signal, which must now be 1 because it is a write operation.

When Gumnut performs an output through the respective instruction, it places a address signal that depends on what is to be output, either the TX data, the TX enable or the BCD code.

In line with the above, each of these elements has its own output process. The distinction being the port_adr_o condition. If port_adr_o is equal, together with the above signal specifications, to the address that corresponds to the element, it means that Gumnut wants to return its value, and therefore the conditional allows its signal or port_dat_o to be the one placed in a signal of the top-entity

Since the writing is to different signals, despite being carried out in different processes, it is not necessary to use a selection statute.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/e4317e48-9c64-4870-adde-1302f0b7d02d" alt = "Input interface" width="450" height="500"/>
</p>

### Code in Gumnut Assembly

Once this is established, the code requests the input of all the user interaction elements and verifies which one is the active one using an AND operation between the entered value and a mask specifically selected to achieve this purpose.

For example, the 8-bit data representing the state of the switches is read by Gumnut and stored in r1. An AND is performed on this register with all the binary positions of the switches (1, 2, 4, 8, 16 and 32 in decimal or 00000001, 00000010, 00000100, 00001000, 00010000 and 00100000 in binary).

If any of these operations does not turn on the flag Z (zero) flag, it means that its result was 1, so the current value of the switches and that of the mask is the same, resulting in the detection of the active switch, as the mask indicates its position.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/001c63f9-13d1-457f-97eb-77857bfa31c0" alt = "Identification of the active switch in Gasm" width="400" height="400"/>
</p>

The same applies for the accelerometer vector, where the masks represent all possible combinations, some being pigeonholed on the right and the remaining ones on the right.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/c3525645-80aa-4116-a1fc-3b52ac3c3852" alt = "Identifying the accelerometer orientation in Gasm" width="400" height="400"/>
</p>

As for the buttons, the mask is simply 1, because of the 8 bits received by Gumnut, only LSB has the information whether it is pressed or not. This is because port_dat_i is assigned seven zeros concatenated to the debounce signal value.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/450375db-0d08-499d-b45b-d60d94000e5a" alt = "Identification of the active button in Gasm" width="300" height="100"/>

If all operations cause the Z flag to be set, i.e. their results are zero, it means that no element is being activated (no switch closed, no button pressed or accelerometer in the center), so it jumps to an IDLE tag that transmits on UART 0x00 through outputs on TX_Data_o and TX_Start_o, eventually received and interpreted by the top-entity. It should be noted, the enable/disable is a common tag to all transmissions.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/43c8d27e-aa95-4055-a019-93a0a8106059" alt = "IDLE and En_D_Tx tag" width="380" height="100"/>

On the other hand, any operation that does not result in zero will jump to a label where the respective value will be transmitted to the active element, i.e. the one decoded by the Unity engine.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/46dcc057-f8a5-4d44-b85b-1d9e00e291e0" alt = "Transfer of the respective value to the active element" width="400" height="400"/>

For the RX data or item counter, it will be received and sent back to the top-entity for decoding.

## Game Demos

### Unity

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/4d428feb-667c-4045-84e7-b67829407e78" alt = "Game Demo" width="518" height="291"/>
</p>

### Unity & FPGA Control

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/52809685-ae9e-471b-bf5a-7fce4017ce11" alt = "Game Control Demo" width="518" height="291"/>
</p>

### Unity & FPGA Control with Gumnut

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/e7303f89-ab9c-4b49-8891-f81590358c2c" alt = "Game Control Demo with Gumnut" width="518" height="291"/>
</p>

## Bonus - VGA Interface

As a part of the coursework, the board's *VGA* interface was used to display and move an object. Since it was a fun activity and a first approach to the accelerometer, it was decided to push this code too. The sprites for the character were generated using a *Python* script that scales and transforms images into a matrix of values, each one representing a coded *R, G & B* representation of the pixel.

<p align="center">
  <img src="https://github.com/fectec/JohnDeereFPGA/assets/127822858/a2bd6ac9-bb7d-48b2-89cb-583ef9889255" alt = "VGA Among Us" width="518" height="291"/>
</p>

## Link to Unity Game Repository

https://github.com/Cook131/Proyecto-JohnDeere
