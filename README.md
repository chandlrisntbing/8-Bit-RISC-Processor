# 8-Bit RISC Processor

A compact, educational 8-bit RISC-style processor implemented in SystemVerilog. This repository contains the core datapath building blocks, decode logic, and simulation testbenches used to model a simple CPU architecture.

## Overview

This project is designed around a minimal, 8-bit instruction set and a register-based execution model. The design is split into modular RTL blocks that emulate the main components of a processor:

- Arithmetic Logic Unit (ALU)
- Instruction decoder
- Register file
- Program counter
- Instruction memory
- Testbenches for verification

The repository is intended as a learning project and a foundation for building a larger processor or adding more instructions and pipeline stages later.

## Architecture

The processor is organized around the following core modules:

### 1. ALU (`alu.sv`)
The arithmetic logic unit supports 8 operation types:

- Pass-through (`000`)
- OR (`001`)
- ADD (`010`)
- SUB (`011`)
- AND (`100`)
- XOR (`101`)
- Shift left logical (`110`)
- Shift right logical (`111`)

The ALU produces:

- An 8-bit `result`
- A `Zero` flag when the result is zero
- A `Carry` flag for arithmetic overflow / carry out

### 2. Decoder (`decoder.sv`)
The decoder maps a 4-bit opcode to the corresponding control signals:

- `ALUOp`
- `WB` (write-back enable)
- `ImmEnable`
- `ImmType`
- `Branch`

The instruction set implemented in the decoder includes:

| Opcode | Mnemonic | Description |
| --- | --- | --- |
| `0000` | `beqz` | Branch if equal to zero |
| `0001` | `or` | Register OR |
| `0010` | `add` | Register ADD |
| `0011` | `sub` | Register SUB |
| `0100` | `and` | Register AND |
| `0101` | `xor` | Register XOR |
| `0110` | `sll` | Shift left logical |
| `0111` | `srl` | Shift right logical |
| `1000` | `li` | Load immediate |
| `1001` | `ori` | OR immediate |
| `1010` | `addi` | ADD immediate |
| `1011` | `subi` | SUB immediate |
| `1100` | `andi` | AND immediate |
| `1101` | `xori` | XOR immediate |
| `1110` | `slli` | Shift left immediate |
| `1111` | `srli` | Shift right immediate |

### 3. Register File (`register_file.sv`)
The register file contains 16 registers, each 8 bits wide.

Features:

- Synchronous write behavior
- `R0` always reads as `0`
- `R1` always reads as `1`
- Writes to `R0` and `R1` are ignored
- `LED0` and `LED1` are tied to registers `R14` and `R15`

This makes the design useful for small embedded control programs and simple LED output demonstrations.

### 4. Program Counter (`program_counter.sv`)
The program counter updates every clock cycle:

- On reset, it clears to `0`
- If `Taken` is `0`, it increments by 1
- If `Taken` is `1`, it adds the branch offset `Bamt`

This allows for simple control-flow execution and conditional branching.

### 5. Instruction Memory (`instruction_memory.sv`)
The instruction memory is modeled as an array of 256 entries, each 16 bits wide.

- Combinational read from `memory[PC]`
- Supports a simple program memory model for instruction fetch

## Repository Structure

```text
.
├── LICENSE
├── README.md
├── alu.sv
├── alu_tb.sv
├── decoder.sv
├── decoder_tb.sv
├── instruction_memory.sv
├── program_counter.sv
├── program_counter_tb.sv
├── register_file.sv
├── register_file_tb.sv
└── README.md
```

## Testbenches

The repository includes individual simulation testbenches for each major block:

- `alu_tb.sv` — validates ALU behavior across the supported operations
- `decoder_tb.sv` — checks decoder outputs for each opcode
- `program_counter_tb.sv` — exercises reset, increment, branch behavior, and offset jumps
- `register_file_tb.sv` — verifies register writes, reads, special registers, and LED outputs

These testbenches are written in SystemVerilog and are useful for verification in a simulator such as ModelSim, Questa, Vivado, or Icarus Verilog.

## Simulation Example

A typical workflow with Icarus Verilog would look like this:

```bash
iverilog -g2012 -o processor_sim \
  alu.sv \
  decoder.sv \
  instruction_memory.sv \
  program_counter.sv \
  register_file.sv \
  alu_tb.sv \
  decoder_tb.sv \
  program_counter_tb.sv \
  register_file_tb.sv

vvp processor_sim
```

You can also run the testbenches one at a time in your preferred simulator depending on your environment and project setup.

## Notes

This project is intentionally minimal and educational. It demonstrates the core ideas of a simple CPU datapath without a full assembler, pipeline, or memory controller.

Potential next improvements include:

- Full instruction fetch/decode/execute datapath integration
- A top-level CPU module
- Program loading into instruction memory
- Branch control using status flags
- More advanced instructions and addressing modes
- A compiler/assembler for the custom ISA

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Author

This repository is maintained by Shreyas Kalyanaraman and is intended for HDL learning, experimentation, and processor design exploration.
