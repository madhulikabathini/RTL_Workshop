# Day 1: Verilog RTL Design and Simulation

## Overview

Welcome to Day 1 of my RTL Design learning journey. In this session, I explored the fundamentals of Verilog HDL, digital circuit simulation, and RTL synthesis. The main objective was to understand how hardware is described using Verilog, verified through simulation, and synthesized into a gate-level representation.

---

## Table of Contents

1. Simulator, Design and Testbench
2. Getting Started with Icarus Verilog
3. Lab: Simulating a 2-to-1 Multiplexer
4. Verilog Code Analysis
5. Introduction to Yosys
6. Summary

---
# 1. What is a Simulator, Design, and Testbench?

## Simulator

A simulator is a software application that executes Verilog code and verifies whether a digital circuit behaves as expected before it is implemented on hardware. It helps identify and correct design errors at an early stage.

## Design

The design is the Verilog module that represents the required digital circuit. It defines the inputs, outputs, and the logic that determines how the circuit functions.
<img width="534" height="264" alt="image" src="https://github.com/user-attachments/assets/1ef9f0d0-e38e-4522-85fe-f36c0a4b8811" />

## Testbench

A testbench is a separate Verilog program used to apply different input values to the design and observe the output. It is mainly used to verify that the design works correctly under different test conditions.
<img width="1122" height="608" alt="image" src="https://github.com/user-attachments/assets/17b11740-8316-418e-96c0-a6a26f9f8a7e" />

---
# 2. Getting Started with Icarus Verilog

## What is Icarus Verilog?

Icarus Verilog is a free and open-source Verilog compiler and simulator. It allows users to compile Verilog source files, execute simulations, and generate waveform files for analyzing the behavior of digital circuits.

### Basic Simulation Flow

<img width="1854" height="956" alt="image" src="https://github.com/user-attachments/assets/a44facda-404c-476c-85dc-90bd76710edb" />

---
# 3. Lab: 2-to-1 Multiplexer Simulation

## Installing the Required Tools

Install Icarus Verilog:

```bash
sudo apt install iverilog
```

Install GTKWave:

```bash
sudo apt install gtkwave
```

## Compiling the Design

Compile the Verilog design and testbench:

```bash
iverilog good_mux.v tb_good_mux.v
```

## Running the Simulation

Execute the compiled output file:

```bash
./a.out
```

## Viewing the Waveform

Open the generated waveform using GTKWave:

```bash
gtkwave tb_good_mux.vcd
```

## Simulation Result

The generated waveform verifies that the 2-to-1 multiplexer functions correctly. The output changes according to the select signal and follows the selected input.

<img width="1841" height="904" alt="image" src="https://github.com/user-attachments/assets/d9d2451c-b813-4243-9fac-30975fde12b1" />


---
# 4. Verilog Code Analysis

## Multiplexer Code 


<img width="635" height="232" alt="image" src="https://github.com/user-attachments/assets/5a55fb4b-5e43-41dd-9745-11dbee06016f" />

### Working

- The multiplexer has two inputs (`i0` and `i1`), one select line (`sel`), and one output (`y`).
- The `always @(*)` block continuously monitors the input signals for any changes.
- When `sel = 0`, the output `y` is assigned the value of `i0`.
- When `sel = 1`, the output `y` is assigned the value of `i1`.
- Thus, the select line determines which input is passed to the output.

# 5. Introduction to Yosys and Gate Libraries

## Theory

Yosys is an open-source synthesis tool that converts Verilog RTL descriptions into gate-level netlists. It analyzes and optimizes the design before mapping the logic to cells from a selected technology library.

A Liberty (`.lib`) file describes the characteristics of standard cells used by the technology. It contains information such as cell functionality, timing, area, power, and drive strength. Yosys uses this information during technology mapping to select suitable standard cells.

In this experiment, the `good_mux` design was synthesized using the Sky130 standard cell library. The RTL was processed, optimized, technology-mapped, and represented as a gate-level netlist.

---

## Synthesis Lab with Yosys

### Step 1: Start Yosys

```bash
yosys
```

### Step 2: Load the Liberty Library

```bash
read_liberty -lib /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Step 3: Load the Verilog Design

```bash
read_verilog /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/verilog_files/good_mux.v
```

### Step 4: Run RTL Synthesis

```bash
synth -top good_mux
```

### Step 5: Perform Technology Mapping

```bash
abc -liberty /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Step 6: Display the Synthesized Design

```bash
show
```

---
<img width="1117" height="629" alt="image" src="https://github.com/user-attachments/assets/4d12e119-d464-47eb-aea5-721577b6a9d0" />


## Result

- The `good_mux` Verilog design was synthesized successfully.
- The Sky130 Liberty library was loaded for technology mapping.
- The RTL logic was optimized during synthesis.
- Technology mapping was performed using the selected Sky130 standard cells.
- The resulting gate-level representation was generated and viewed using Yosys.

---


---
# 6. Summary

- Learned the fundamentals of Verilog HDL.
- Understood the roles of a simulator, design module, and testbench.
- Simulated a 2-to-1 multiplexer using Icarus Verilog.
- Verified the output using GTKWave.
- Analyzed the Verilog code and understood the multiplexer operation.
- Learned the basics of RTL synthesis using Yosys.
- Understood the purpose of Liberty (`.lib`) files and standard-cell libraries.
- Performed technology mapping using the Sky130 standard cell library.
- Gained an introduction to RTL synthesis using Yosys.
