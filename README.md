# Nibble CPU – 8-bit Instruction Based ALU System

## Overview

This project implements a simple custom **8-bit CPU system** using Verilog.
The design follows a **hardware–software co-design approach**, where operations are driven through encoded instructions (ISA).

The CPU supports:

* Basic ALU operations (ADD, SUB, AND, OR, XOR, MUL)
* Memory operations (LOAD, STORE)
* Register operations (LOAD_REG, STORE_REG)
* MAC (Multiply-Accumulate via ALU)

All operations are executed using a fixed **8-bit instruction format**.

---

## Instruction Format (ISA)

Each instruction is 8 bits:

```
[7:4]  → Opcode
[3:2]  → Register (rd / rs1)
[1:0]  → Register (rs2)
```

### Execution Model

```
R[rd] = R[rd] op R[rs2]
```

---

## Supported Instructions

| Opcode | Instruction | Description               |
| ------ | ----------- | ------------------------- |
| 0000   | NOP         | No operation              |
| 0001   | MAC         | Multiply-Accumulate       |
| 0010   | LOAD        | Load from RAM to register |
| 0011   | STORE       | Store register to RAM     |
| 0100   | LOAD_REG    | Copy register             |
| 0101   | STORE_REG   | Copy register             |
| 0110   | ADD         | Addition                  |
| 0111   | SUB         | Subtraction               |
| 1000   | AND         | Bitwise AND               |
| 1001   | OR          | Bitwise OR                |
| 1010   | XOR         | Bitwise XOR               |
| 1011   | MUL         | Multiplication            |

---

## Architecture

### Components

* **Instruction Decoder**

  * Decodes 8-bit instruction into control signals

* **Register File**

  * 4 registers (R0–R3), each 8-bit

* **ALU Unit**

  * Performs arithmetic and logic operations
  * Includes MAC functionality

* **RAM**

  * 8-bit data memory
  * Used for LOAD and STORE operations

* **Top Module**

  * Integrates all components
  * Handles data flow and write-back

---

## Data Flow

1. Instruction is decoded
2. Registers provide operands
3. ALU performs operation
4. Result is written back to register or RAM

---

## Testbench

* Drives instructions using `opcode_gen`
* Simulates execution of:

  * Memory operations
  * ALU operations
  * Register transfers
* Includes:

  * Self-checking mechanism
  * Debug register prints
  * PASS/FAIL reporting

---

## Features

* Simple and compact ISA
* Modular Verilog design
* Self-checking testbench
* Supports both combinational and sequential operations
* Easy to extend with new instructions

---

## File Structure

```
instr_decoder.v   → Instruction decoding logic
alu_unit.v        → ALU + MAC implementation
register.v        → Register file
ram.v             → Memory module
top.v             → CPU integration
opcode_gen.v      → Instruction generator
tb.v              → Testbench
Makefile          → Build and run automation
```

---

## How to Run

```bash
make run
```

---

## Notes

* Register file and RAM modules are fixed (not modified)
* Testbench injects initial memory values
* Execution is cycle-based (clock-driven)

---

## Conclusion

This project demonstrates a minimal CPU design with a custom ISA, integrating ALU, memory, and control logic into a unified system suitable for instruction-driven computation.
