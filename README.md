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
- [Workshop Sessions](#workshop-sessions)
  - [Session 1](#session-1)
  - [Session 2](#session-2)
  - [Session 3](#session-3)
- [VSDBabySoC Physical Design and STA](#vsdbabysoc-physical-design-and-sta)
- [Learning Video](#learning-video)
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

The Physical Design section covers the implementation of digital designs from RTL and synthesis toward physical layout using open-source EDA tools and the SkyWater SKY130 PDK.

## PD Module 1

### Physical Design: RTL to GDSII using OpenLane

Introduction to the Physical Design flow and the RTL-to-GDSII implementation process.

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

Study of Physical Design concepts and implementation stages using open-source EDA tools.

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

### Physical Design: Timing Analysis, Clock Tree Synthesis and Physical Design

This module explores physical implementation and timing verification using the PicoRV32A core, OpenLane, OpenROAD, and the SKY130A PDK.

Topics covered include:

- RTL-to-GDSII Flow
- Synthesis and Technology Mapping
- Floorplanning
- Placement
- Clock Tree Synthesis (CTS)
- Clock Buffering
- Clock Skew and Clock Latency
- Setup and Hold Timing
- Data Arrival and Required Times
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

### Physical Design: Routing, DRC, Parasitic Extraction and TritonRoute

This module focuses on routing and post-routing verification using the SKY130 PDK and OpenLane-based tools.

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
- Intra-Layer and Inter-Layer Routing
- Connectivity Handling
- Routing Topology Optimization
- OpenLane Routing Results
- Post-Layout Timing Analysis

[View PD Module 5](./PD_Module5)

---

# Workshop Sessions

## Session 1

Documentation and exercises completed during the first workshop session.

[View Session 1](./Session_1)

---

## Session 2

Documentation and exercises completed during the second workshop session.

[View Session 2](./Session_2)

---

## Session 3

### MUX and BabySoC Synthesis and Verification

This session documents MUX design and simulation, synthesis and netlist analysis, and VSDBabySoC synthesis and verification.

Topics covered include:

- MUX RTL Simulation
- Synthesized Circuit Representation
- Gate-Level Netlist and Simulation
- BabySoC Architecture
- Yosys Synthesis and Optimization
- Synthesis Statistics
- Circuit Visualization using Graphviz
- Simulation Waveform Analysis using GTKWave

[View Session 3](./Session_3)

---

# VSDBabySoC Physical Design and STA

This section contains additional documentation focused on VSDBabySoC physical design concepts and multi-corner Static Timing Analysis (STA), complementing the synthesis and verification material in Session 3.

Topics covered include:

- VSDBabySoC and the SKY130 HD Standard-Cell Library
- Physical Design Flow
- Multi-Corner Static Timing Analysis
- Process, Voltage, and Temperature (PVT) Corners
- Setup and Hold Timing
- Worst Negative Slack (WNS)
- Total Negative Slack (TNS)
- Timing Report Analysis
- Timing Results and Observations

### Multi-Corner STA Results

The updated STA report covers 16 PVT corners under an 11 ns clock constraint.

The report lists:

- 16 timing corners evaluated
- 10 corners with positive setup WNS
- 6 corners with negative setup WNS
- Best reported setup WNS: +8.22 ns
- Worst reported setup WNS: -31.85 ns

Negative setup slack indicates timing violations at the affected corners. The updated report states that the values have not been independently verified by rerunning the full STA flow; therefore, they should be treated as documented report results rather than independently confirmed sign-off results.

[View VSDBabySoC Physical Design and STA](./VSDBabySoC-Physical-Design)

---

# Learning Video

The `5minlearning-video` folder contains the link to my workshop learning video.

[View Learning Video Folder](./5minlearning-video)

---
## Final Project – Debounced Multi-Light Street Lamp Controller

A Verilog HDL-based street lamp controller for automatic dusk-to-dawn switching using a four-clock-edge debounce mechanism.

**Project Documentation:** [View Final Project](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller)

**Project Demonstration Video:** [Watch the 5-Minute Video](PASTE_YOUR_GOOGLE_DRIVE_VIDEO_LINK_HERE)

### Project Contents
- [RTL Design](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/rtl)
- [GDSII Layout](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/gds)
- [Reports](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/reports)
- [Screenshots](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/screenshots)
- [Static Timing Analysis Reports](https://github.com/madhulikabathini/RTL_Workshop/tree/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/sta_all_corners)
- [OpenLane Configuration](https://github.com/madhulikabathini/RTL_Workshop/blob/main/Final%20Project%20-%20Debounced%20Multi-Light%20Street%20Lamp%20Controller/config.tcl)
# Tools Used

The tools and technologies documented across the repository include:

- Verilog HDL
- Yosys
- GTKWave
- Icarus Verilog
- OpenLane
- OpenROAD
- OpenSTA
- SkyWater SKY130 PDK
- Magic VLSI
- TritonRoute
- KLayout
- LEF and DEF
- SPEF
- Linux
- Docker
- Oracle VM VirtualBox
- Tcl
- Git and GitHub

Individual modules and sessions may use different subsets of these tools.

---

# Repository Structure

```text
RTL_Workshop/
│
├── 5minlearning-video/
│
├── Day_1/
│   └── README.md
├── Day_2/
│   └── README.md
├── Day_3/
│   └── README.md
├── Day_4/
│   └── README.md
├── Day_5/
│   └── README.md
├── Day_6/
│   └── README.md
│
├── PD_Module1/
│   └── README.md
├── PD_Module2/
│   └── README.md
├── PD_Module3/
│   └── README.md
├── PD_Module4/
│   └── README.md
├── PD_Module5/
│   └── README.md
│
├── Session_1/
│   └── README.md
├── Session_2/
│   └── README.md
├── Session_3/
│   └── README.md
│
├── VSDBabySoC-Physical-Design/
│   └── README.md
│
├── README.md
└── README1.md
```

---

# Author

**B. Madhulika**

B.Tech – Electronics and Communication Engineering  
Anurag University






