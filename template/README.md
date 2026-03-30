# Bit-Trix 2026 – Our Implementation

## Objective

Design an **8-bit instruction-based CPU system** to execute operations via a custom ISA using Verilog.

---

## Architecture Summary

* **Registers**: 4 registers (R0–R3), 8-bit each
* **RAM**: Used for LOAD/STORE operations
* **Instruction Width**: 8-bit

```text
[7:4] Opcode | [3:2] rd | [1:0] rs2
```

---

## Execution Model

```text
R[rd] = R[rd] op R[rs2]
```

---

## Supported Instructions

* **ALU**: ADD, SUB, AND, OR, XOR, MUL, MAC
* **Memory**: LOAD, STORE
* **Register**: LOAD_REG, STORE_REG
* **Control**: NOP

---

## Design Components

* **Instruction Decoder** → Generates control signals
* **ALU Unit** → Performs arithmetic/logic + MAC
* **Register File** → 4×8-bit registers
* **RAM** → Data storage
* **Top Module** → Integrates full datapath

---

## Data Flow

1. Instruction → Decoder
2. Registers → Provide operands
3. ALU → Compute result
4. Write-back → Register or RAM

---

## Key Design Choices

* Compact **2-operand ISA** (fits 8-bit instruction)
* ALU supports both **combinational ops + MAC (accumulator)**
* RAM used for **data storage and transfer**
* Testbench acts as **instruction driver (software layer)**

---

## Files

```text
instr_decoder.v
alu_unit.v
register.v
ram.v
top.v
opcode_gen.v
tb.v
Makefile
```

---

## Run

```bash
make run
```

---

## Note

* Design follows given constraints (4 registers, limited instructions)
* Focus is on **instruction-driven computation and modular hardware design**
