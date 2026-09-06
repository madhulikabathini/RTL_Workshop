# RTL_Workshop

Learning Verilog RTL Design, Simulation, Synthesis, and Physical Design using open-source tools.

## Table of Contents

- [Day 1 – RTL Design Through Simulation](#day-1)
- [Day 2 – Timing Libraries and Synthesis](#day-2)
- [Day 3 – Flip-Flop Coding and RTL Optimization](#day-3)
- [Day 4 – RTL Simulation and Debugging](#day-4)
- [Day 5 – Synthesis and Netlist Analysis](#day-5)
- [Day 6 – Timing Analysis and Optimization](#day-6)
- [Physical Design](#physical-design)
  - [PD Module 1](#pd-module-1)
  - [PD Module 2](#pd-module-2)
- [Tools Used](#tools-used)
- [Repository Structure](#repository-structure)
- [Author](#author)

---

## Day 1

### RTL Design Through Simulation

Introduction to Verilog RTL design, simulation, and waveform analysis using Verilog and GTKWave.

[View Day 1](Day_1/README.md)

---

## Day 2

### Timing Libraries and Synthesis

Study of the SKY130 timing library, hierarchical and flattened synthesis, flip-flop coding styles, RTL simulation, and synthesis using Yosys.

[View Day 2](Day_2/README.md)

---

## Day 3

### Flip-Flop Coding and RTL Optimization

Study of different flip-flop coding styles, synthesis, and RTL optimization using Yosys.

[View Day 3](Day_3/README.md)

---

## Day 4

### RTL Simulation and Debugging

Studied RTL simulation, testbench execution, waveform generation, and debugging of Verilog designs using simulation tools.

[View Day 4](Day_4/README.md)

---

## Day 5

### Synthesis and Netlist Analysis

Studied RTL synthesis, generated gate-level netlists, analyzed synthesized circuits, and understood the relationship between RTL code and the resulting hardware.

[View Day 5](Day_5/README.md)

---

## Day 6

### Timing Analysis and Optimization

Studied timing concepts, delay analysis, setup and hold requirements, and basic techniques used to optimize digital designs for better timing performance.

[View Day 6](Day_6/README.md)

---

# Physical Design

The Physical Design modules cover the implementation of a digital design from synthesized netlist to physical layout using open-source EDA tools and the Sky130 PDK.

## PD Module 1

### Physical Design: RTL to GDSII using OpenLane

Introduction to the Physical Design flow and the complete RTL-to-GDSII implementation process.

Topics covered include:

- ASIC Physical Design Flow
- OpenLane
- Sky130 PDK
- Floorplanning
- Placement
- CTS
- Routing
- GDSII

[View PD Module 1](PD_Module1/README.md)

---

## PD Module 2

### Physical Design: Library Characterization and Timing Analysis

Study of standard-cell library characterization and timing analysis used in the Physical Design flow.

Topics covered include:

- Standard Cell Libraries
- Library Characterization
- Liberty Files
- PVT Conditions
- Setup and Hold
- Delay and Slew
- Timing Analysis

[View PD Module 2](PD_Module2/README.md)

---

## Tools Used

- Verilog
- Yosys
- GTKWave
- OpenLane
- Sky130 PDK
- Magic
- OpenROAD
- ngspice
- Linux
- Docker

---

## Repository Structure

```text
RTL_Workshop/
│
├── Day_1/
│   └── README.md
│
├── Day_2/
│   └── README.md
│
├── Day_3/
│   └── README.md
│
├── Day_4/
│   └── README.md
│
├── Day_5/
│   └── README.md
│
├── Day_6/
│   └── README.md
│
├── PD_Module1/
│   └── README.md
│
└── PD_Module2/
    └── README.md
```
## Author

**B. Madhulika**  
B.Tech – Electronics and Communication Engineering  
Anurag University
