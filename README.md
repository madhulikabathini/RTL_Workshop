# RTL_Workshop

Learning VLSI RTL Design, Simulation, Synthesis, and Physical Design using open-source tools.

## Table of Contents

- [Day 1 - RTL Design Through Simulation](#day-1)
- [Day 2 - Timing Libraries and Synthesis](#day-2)
- [Day 3 - Flip-Flop Coding and RTL Optimization](#day-3)
- [Day 4 - RTL Simulation and Debugging](#day-4)
- [Day 5 - Synthesis and Netlist Analysis](#day-5)
- [Day 6 - Timing Analysis and Optimization](#day-6)
- [Physical Design](#physical-design)
  - [PD Module 1](#pd-module-1)
  - [PD Module 2](#pd-module-2)
  - [PD Module 3](#pd-module-3)
  - [PD Module 4](#pd-module-4)
  - [PD Module 5](#pd-module-5)
- [Tools Used](#tools-used)
- [Repository Structure](#repository-structure)
- [Author](#author)

---

## Day 1

### RTL Design Through Simulation

Introduction to Verilog RTL design, simulation, and waveform analysis using Verilog and GTKWave.

[View Day 1](./Day_1)

---

## Day 2

### Timing Libraries and Synthesis

Study of the Sky130 timing library, hierarchical and flattened synthesis, flip-flop coding styles, RTL simulation, and synthesis using Yosys.

[View Day 2](./Day_2)

---

## Day 3

### Flip-Flop Coding and RTL Optimization

Study of different flip-flop coding styles, synthesis, and RTL optimization using Yosys.

[View Day 3](./Day_3)

---

## Day 4

### RTL Simulation and Debugging

Study of RTL simulation, testbench creation, waveform generation, and debugging of Verilog designs using simulation tools.

[View Day 4](./Day_4)

---

## Day 5

### Synthesis and Netlist Analysis

Study of RTL synthesis, generated gate-level netlists, analysis of synthesized circuits, and understanding the relationship between RTL code and the resulting hardware.

[View Day 5](./Day_5)

---

## Day 6

### Timing Analysis and Optimization

Study of timing concepts, delay analysis, setup and hold requirements, and basic techniques used to optimize digital designs for better timing performance.

[View Day 6](./Day_6)

---

# Physical Design

The Physical Design section covers the implementation of a digital design from synthesized RTL to physical layout using open-source EDA tools and the Sky130 PDK.

## PD Module 1

### Physical Design: RTL to GDSII using OpenLane

Introduction to the Physical Design flow and the complete RTL-to-GDSII implementation process.

Topics covered include:

- ASIC Physical Design Flow
- OpenLane
- Sky130 PDK
- Floorplanning
- Placement
- Clock Tree Synthesis
- Routing
- GDSII Generation

[View PD Module 1](./PD_Module1)

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

[View PD Module 2](./PD_Module2)

---

## PD Module 3

### Physical Design: Advanced Implementation

Study of advanced concepts in the Physical Design flow and implementation of synthesized designs using open-source EDA tools.

Topics covered include:

- Physical Design Flow
- Floorplanning
- Power Planning
- Placement
- Clock Tree Synthesis
- Routing
- Timing Analysis
- Physical Verification

[View PD Module 3](./PD_Module3)

---

## PD Module 4

### Physical Design: Timing Analysis, Clock Tree Synthesis & Physical Design

This module explores the physical-implementation and timing-verification phases of an RTL-to-GDSII flow using the PicoRV32A core, OpenLane, OpenROAD, and the SKY130A PDK.

Topics covered include:

- RTL-to-GDSII Flow
- Synthesis and Technology Mapping
- Floorplanning
- Placement
- Clock Tree Synthesis (CTS)
- Clock Buffering
- Clock Skew
- Clock Latency
- Setup and Hold Timing
- Data Arrival Time
- Data Required Time
- Slack Analysis
- Real and Ideal Clock Analysis
- Crosstalk-Induced Delay
- Timing Closure
- Physical Layout
- Standard-Cell Placement
- Physical Verification

[View PD Module 4](./PD_Module4)

---

## PD Module 5

### Physical Design: Routing, DRC, Parasitic Extraction & TritonRoute

This module focuses on routing and post-routing verification using the SKY130 open-source PDK and OpenLane-based tools.

Topics covered include:

- Global Routing
- Detailed Routing
- Maze Routing using Lee's Algorithm
- Design Rule Checking (DRC)
- Wire-Width Verification
- Via-Spacing Verification
- Parasitic Extraction
- SPEF Generation
- TritonRoute
- Route Guide Preprocessing
- Intra-Layer Routing
- Inter-Layer Routing
- Connectivity Handling
- Routing Topology Optimization
- OpenLane Routing Results
- Post-Layout Timing Analysis

[View PD Module 5](./PD_Module5)

---

# Tools Used

- Verilog
- Yosys
- GTKWave
- Icarus Verilog
- OpenLane
- OpenROAD
- OpenSTA
- Sky130 PDK
- Magic VLSI
- TritonRoute
- KLayout
- LEF
- DEF
- SPEF
- Linux
- Docker
- Oracle VM VirtualBox
- Tcl
- Git & GitHub

---

# Repository Structure

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
├── PD_Module2/
│   └── README.md
│
├── PD_Module3/
│   └── README.md
│
├── PD_Module4/
│   └── README.md
│
├── PD_Module5/
│   └── README.md
│
└── README.md





```
## Author

**B. Madhulika**  
B.Tech – Electronics and Communication Engineering  
Anurag University
