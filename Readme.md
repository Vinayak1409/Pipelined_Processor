# Pipelined-processor

In this assignment, a pipelined processor that follows MIPS ISA is designed using Verilog on Xilinx Vivado. The modules used in this project are:

1.ALU.
2. ALU Control Unit.
3. Control Unit.
4. Program Counter.
5. Instruction Fetch Unit.
6. Instruction Memory Unit.
7. Register File.
8. Data Memory Unit.
9. Pipeline registers - IF/ID, ID/EX, EX/MEM, MEM/WB.
10. Stalling Unit.
11. Forwarding Unit.
12. Adders, Shifters, Multiplexers, Sign Extender.

<img width="500" alt="image" src="https://github.com/Vinayak1409/Pipelined_Processor/assets/83897602/e659bcc8-10e0-48ee-88cb-81f9ed1dd86f">

It also contains a testbench that instantiates all the modules listed above to make connections that result in the processor.

The “.mem” files are text-based files representing the initial values for the register file, instruction, and data memory. For this project, we loaded all the values in hexadecimal format.

## ALU (Arithmetic Logic Unit):
This acts as a calculator that performs arithmetic operations, logical operations, and even bitwise operations by taking ALU-control as input along with the data bits that is selectively sent. We incorporated addition, subtraction, multiplication, shift-left, shift-right, Bitwise AND, and Bitwise OR operations for this particular processor.

## ALU Control Unit:
This is a typical brain-like module that commands the ALU by inferring the data from the first 6 bits from the instruction that is fetched, also known as the opcode and a signal from Control Unit known as ALUop, which in turn produces ALU-control as output.

## Control Unit:
This segment of the processor sends different control signals to other modules. The signals are, namely; RegDst, Branch, PCSrc, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, and RegWrite. It takes input from the bits of the instruction opcode.

## Program Counter (PC):
It contains the address of the instruction in the program to be executed. As soon as this instruction is fetched, the PC is incremented by 4 to the address of the next instruction. So, (PC+4) is attained using an adder in the instruction fetch unit.

## Instruction Memory:
The instructions are read continuously from the instruction_mem.mem file from their respective memory locations which are byte-organized and sent as 32-bit instruction to the instruction fetch unit.

## Instruction Fetch Unit:
The instruction, when received from the instruction memory along with control signals from the control unit and the stalling unit, will manipulate the PC to fetch forthcoming instruction or branch or even stall the instruction.

## Register File:
This element contains a set of registers; it is an organized array of registers that allows read and write operations to different registers. It takes the register names embedded in a 5-bit opcode of the instruction, which is translated to the 32-bit register read/write port.

## Data Memory Unit:
This is the part that contains the data to be loaded/read from, stored/written to it. It takes the address calculated by the ALU as its input to return the location where the said data is present. 

## Stalling Unit:
This unit creates stall signals which halt further instruction fetch and also the movement of information/data within the processor. It is used to overcome various hazards.

## Forwarding Unit:
It makes the data available to the input of the ALU for subsequent instructions, even though the generating instruction hasn't gotten to write the memory or registers. 

## Pipeline Registers:
There are 4 types of pipeline registers that bridge the Instruction Fetch, Instruction Decode, Execute Memory Access and Write Back steps. They are namely; IF/ID, ID/EX, EX/MEM, MEM/WB. 

## Waveform generated:
<img width="425" alt="image" src="https://github.com/Vinayak1409/Pipelined_Processor/assets/83897602/b3c649fc-cd08-46de-bbec-157dae2adbe9">





