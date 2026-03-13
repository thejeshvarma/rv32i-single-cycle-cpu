# Single Cycle RISC-V CPU (Verilog)

A **Single-Cycle RISC-V Processor** implemented in **Verilog HDL** supporting a subset of the **RV32I instruction set architecture**.

This project demonstrates the design of a basic processor including **datapath, control unit, memory system, and simulation environment**.

---

## Processor Overview

The processor follows a **single-cycle architecture**, where every instruction completes execution in **one clock cycle**.

### Supported Instructions

| Type | Instructions |
| :--- | :--- |
| **Arithmetic** | ADD, SUB |
| **Immediate** | ADDI |
| **Memory** | LW, SW |
| **Branch** | BEQ |
| **Jump** | JAL |

---

## Architecture

The processor consists of the following components:

- **Program Counter (PC)**
- **Instruction Memory**
- **Register File**
- **Immediate Generator**
- **Arithmetic Logic Unit (ALU)**
- **Data Memory**
- **Control Unit**
- **Multiplexers**


## Instruction Execution Flow

Although the processor is single-cycle, the datapath logically follows these stages:

1. **Instruction Fetch** — PC provides instruction address; instruction is read from instruction memory
2. **Instruction Decode** — Instruction fields are decoded; register operands are read
3. **Execute** — ALU performs arithmetic or logical operation
4. **Memory Access** — Load or store operations interact with data memory
5. **Write Back** — Result is written back into the register file

---

## Control Unit

The control unit generates signals that control datapath operations.

### Control Signals

| Signal | Description |
| :--- | :--- |
| **RegWrite** | Enables register write |
| **MemWrite** | Enables memory write |
| **ALUSrc** | Selects ALU operand source |
| **ResultSrc** | Selects write-back source |
| **PCSrc** | Controls next PC selection |
| **ImmSrc** | Selects immediate type |
| **ALUControl** | Selects ALU operation |

---

## Control Signal Table

| Instruction | RegWrite | ALUSrc | MemWrite | ResultSrc | ImmSrc | PCSrc | ALUControl |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **ADD** | 1 | 0 | 0 | ALUResult | — | 0 | ADD |
| **SUB** | 1 | 0 | 0 | ALUResult | — | 0 | SUB |
| **ADDI** | 1 | 1 | 0 | ALUResult | I-Type | 0 | ADD |
| **LW** | 1 | 1 | 0 | Memory | I-Type | 0 | ADD |
| **SW** | 0 | 1 | 1 | — | S-Type | 0 | ADD |
| **BEQ** | 0 | 0 | 0 | — | B-Type | Branch | SUB |
| **JAL** | 1 | — | 0 | PC+4 | J-Type | Jump | ADD |

---

## Simulation

Simulation was performed using **Icarus Verilog** and **GTKWave**.

### 1. Compile

```bash
iverilog -o cpu src/*.v sim/*.v
```

### 2. Run Simulation

```bash
vvp cpu
```

### 3. View Waveforms

```bash
gtkwave cpu.vcd
```

---

## Test Program

The following assembly program was used to verify the processor:

```asm
ADDI x1, x0, 5
ADDI x2, x0, 10
ADD  x3, x1, x2
SW   x3, 0(x0)
LW   x4, 0(x0)
BEQ  x4, x3, label
ADDI x5, x0, 1
label:
ADDI x6, x0, 2
```

### Expected Results

| Register | Expected Value |
| :--- | :--- |
| x1 | 5 |
| x2 | 10 |
| x3 | 15 |
| x4 | 15 |
| x6 | 2 |

**Memory[0] = 15**

---

## Project Structure

```
riscv-single-cycle-cpu/
│
├── src/        # Verilog modules (ALU, RegFile, PC, etc.)
├── sim/        # Testbench and hex memory files
└── README.md   # Project documentation
```

---

## Tools Used

- Verilog HDL
- Icarus Verilog (Compiler)
- GTKWave (Waveform Viewer)
- LaTeX (Documentation)
- Git/GitHub (Version Control)

---

## Future Improvements

- Transition to a 5-stage pipelined RISC-V processor
- Implementation of a Hazard Detection Unit
- Addition of a Forwarding Unit to handle data hazards
- Physical testing on an FPGA board
- Expanding support for more RV32I instructions

---

## Author

**Thejesh Varma**  
B.Tech – Electronics and Communication Engineering  
Rajiv Gandhi University of Knowledge Technologies

---

## License

<<<<<<< HEAD
This project is licensed under the [MIT License](LICENSE).
=======
This project is licensed under the [MIT License](LICENSE).
>>>>>>> d0742d6c3aa5acd6a54086d22ce93f84eada4bb5
