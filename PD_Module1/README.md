# Physical Design: RTL to GDSII using OpenLane

## Overview

This module introduced the fundamentals of Physical Design and the complete RTL-to-GDSII ASIC implementation flow.

The session covered the transformation of an RTL design into a physical chip layout using open-source EDA tools and the Sky130 PDK.

The major topics covered were RISC-V architecture, ASIC design flow, OpenLane, floorplanning, placement, clock tree synthesis, routing, static timing analysis, antenna rule checking, and design sign-off.

The PicoRV32 RISC-V processor core was used as an example design for understanding the practical OpenLane physical design flow.

---

## Table of Contents

1. [Introduction to Physical Design](#1-introduction-to-physical-design)
2. [RISC-V Architecture](#2-risc-v-architecture)
3. [RTL to GDSII Flow](#3-rtl-to-gdsii-flow)
4. [Open-Source ASIC Design](#4-open-source-asic-design)
5. [ASIC Physical Design Stages](#5-asic-physical-design-stages)
6. [Floorplanning and Power Planning](#6-floorplanning-and-power-planning)
7. [Placement](#7-placement)
8. [Clock Tree Synthesis](#8-clock-tree-synthesis)
9. [Routing](#9-routing)
10. [OpenLane](#10-openlane)
11. [Sky130 PDK](#11-sky130-pdk)
12. [PicoRV32 Implementation](#12-picorv32-implementation)
13. [OpenLane Setup](#13-openlane-setup)
14. [OpenLane Configuration](#14-openlane-configuration)
15. [Running the OpenLane Flow](#15-running-the-openlane-flow)
16. [Synthesis Results](#16-synthesis-results)
17. [Physical Design Reports](#17-physical-design-reports)
18. [Static Timing Analysis](#18-static-timing-analysis)
19. [Antenna Rule Violations](#19-antenna-rule-violations)
20. [Layout and Final Results](#20-layout-and-final-results)
21. [Summary](#21-summary)

---

# 1. Introduction to Physical Design

Physical Design is the process of converting a synthesized gate-level netlist into a physical layout that can be manufactured as an integrated circuit.

The main objective of physical design is to implement the logical design while satisfying constraints related to:

* Area
* Timing
* Power
* Routing
* Design rules
* Signal integrity

The physical design flow consists of several stages including floorplanning, placement, clock tree synthesis, routing, and sign-off.

---

# 2. RISC-V Architecture

RISC-V is an open Instruction Set Architecture (ISA) based on the Reduced Instruction Set Computer (RISC) concept.

Unlike proprietary processor architectures, RISC-V is an open standard that allows processor implementations to be designed and customized.

In this module, the PicoRV32 RISC-V processor core was used as an example RTL design.

The implementation process can be divided into three major parts:

* Part 1 – RISC-V Instruction Set Architecture
* Part 2 – RTL Design and Synthesis
* Part 3 – Physical Design and Implementation

<img width="1218" height="728" alt="Screenshot 2026-09-04 172444" src="https://github.com/user-attachments/assets/494d4c14-0aff-433d-8d44-c9a838589b6d" />

---

# 3. RTL to GDSII Flow

The ASIC design flow starts with an RTL description of the hardware and ends with a physical layout represented by a GDSII file.

The simplified flow is:

```text
RTL
 ↓
Synthesis
 ↓
Floorplanning
 ↓
Power Planning
 ↓
Placement
 ↓
Clock Tree Synthesis
 ↓
Routing
 ↓
Sign-Off
 ↓
GDSII
```

Each stage transforms and improves the design while checking different physical and timing constraints.

<img width="1919" height="1079" alt="Screenshot 2026-09-04 175020" src="https://github.com/user-attachments/assets/5a6ccbca-64a2-4f7b-a7ab-89161de45812" />

---

# 4. Open-Source ASIC Design

Open-source ASIC design uses freely available tools, RTL designs, and process design information.

The three major components are:

### EDA Tools

Open-source EDA tools are used for synthesis, physical design, timing analysis, routing, and verification.

Examples include:

* Yosys
* OpenROAD
* OpenLane
* OpenSTA
* Magic
* KLayout

### RTL Designs

The digital hardware is described using RTL languages such as Verilog.

### PDK Data

A Process Design Kit (PDK) provides technology-specific information required for implementing the design.

The Sky130 PDK is an important open-source PDK used in this flow.

<img width="1919" height="1079" alt="Screenshot 2026-09-04 175334" src="https://github.com/user-attachments/assets/44f35ffe-1c47-446e-b3b1-5c467ce5ed80" />

---

# 5. ASIC Physical Design Stages

The major stages of the physical design flow are:

```text
Synthesis
    ↓
Floorplanning
    ↓
Placement
    ↓
Clock Tree Synthesis
    ↓
Routing
    ↓
Sign-Off
```

### Synthesis

RTL code is converted into a gate-level netlist using standard cells.

### Floorplanning

The dimensions of the chip and core are determined, and macros and I/O locations are planned.

### Placement

Standard cells are physically placed inside the core area.

### Clock Tree Synthesis

A clock distribution network is created to distribute the clock signal to sequential elements.

### Routing

Physical interconnections are created between the placed cells.

### Sign-Off

The final design is checked for timing and physical correctness before GDSII generation.

<img width="1917" height="1079" alt="Screenshot 2026-09-04 175630" src="https://github.com/user-attachments/assets/26e4ff5f-1596-40e6-8ce5-1e71fc8d545e" />


---

# 6. Floorplanning and Power Planning

Floorplanning determines how the major components of the chip are arranged within the available die area.

Important considerations include:

* Die area
* Core area
* Macro placement
* I/O placement
* Routing resources
* Power distribution

Power planning provides power and ground connections throughout the chip.

A well-designed floorplan helps reduce congestion and improve timing and routing efficiency.
<img width="1919" height="1078" alt="Screenshot 2026-09-04 175719" src="https://github.com/user-attachments/assets/d6f675c1-7c0e-4b60-935d-77f1c77d0311" />


---

# 7. Placement

Placement is the process of determining the physical locations of standard cells within the floorplan.

The synthesized netlist contains cells such as:

* NAND gates
* NOR gates
* AND gates
* OR gates
* Buffers
* Flip-flops

These cells are placed in rows while following the rules of the target technology.

The objectives of placement include:

* Efficient area utilization
* Reduced routing congestion
* Improved timing
* Shorter interconnections

<img width="1916" height="1072" alt="Screenshot 2026-09-04 175815" src="https://github.com/user-attachments/assets/3bdb9f4b-f5ec-4f3d-bbe1-1a5461f80d0a" />

---

# 8. Clock Tree Synthesis

Clock Tree Synthesis (CTS) creates a clock distribution network that delivers the clock signal to all required sequential elements.

The clock network must be designed to control:

* Clock skew
* Clock latency
* Clock transition
* Timing constraints

CTS is an important stage because clock-related timing affects the overall performance of the design.

<img width="1562" height="916" alt="Screenshot 2026-09-05 222831" src="https://github.com/user-attachments/assets/9a98db6b-507a-4a71-b40f-54e0d5a921ee" />

---

# 9. Routing

Routing creates the physical interconnections between the placed standard cells.

The router uses the available metal layers and vias to connect different parts of the design.

Routing considers:

* Metal layers
* Routing tracks
* Via connections
* Design rules
* Routing congestion
* Signal integrity

The final routed design contains physical connections between the standard cells.

<img width="1919" height="1079" alt="Screenshot 2026-09-04 180055" src="https://github.com/user-attachments/assets/abcae225-cab2-43e1-9c84-be24d38e0708" />
<img width="1417" height="866" alt="Screenshot 2026-09-05 223414" src="https://github.com/user-attachments/assets/95a42212-283a-4081-9835-bf21892d0d82" />


---

# 10. OpenLane

OpenLane is an open-source automated ASIC implementation flow.

It integrates multiple open-source EDA tools to convert an RTL design into a GDSII layout.

A simplified OpenLane flow is:

```text
RTL
 ↓
RTL Synthesis
 ↓
Floorplanning
 ↓
Placement
 ↓
CTS
 ↓
Routing
 ↓
Sign-Off
 ↓
GDSII
```

OpenLane can be used with open-source PDKs such as Sky130.

<img width="1408" height="844" alt="Screenshot 2026-09-05 224211" src="https://github.com/user-attachments/assets/c4e5f2f4-a232-4181-bc16-5bafe335f482" />
<img width="1334" height="813" alt="Screenshot 2026-09-05 224223" src="https://github.com/user-attachments/assets/8ae5afcf-0a8f-4b6b-abac-53561417aa3c" />



---

# 11. Sky130 PDK

The Sky130 PDK provides the technology information required to implement ASIC designs using the SkyWater 130 nm process.

The PDK contains different types of technology and cell information including:

* Standard-cell libraries
* LEF files
* Liberty files
* GDS files
* Technology files
* Design rules
* Layer information

Standard cells provide predefined logic functions that can be used during synthesis and physical implementation.

Examples include:

* Inverters
* NAND gates
* NOR gates
* XOR gates
* Buffers
* Flip-flops

<img width="1919" height="1064" alt="Screenshot 2026-09-05 214951" src="https://github.com/user-attachments/assets/13819171-7c98-422b-85ea-480ce7cc556b" />

---

# 12. PicoRV32 Implementation

PicoRV32 is a small RISC-V processor core implemented in Verilog.

It was used as the example design for demonstrating the OpenLane physical design flow.

The RTL design was processed through:

```text
RTL
 ↓
Synthesis
 ↓
Floorplanning
 ↓
Placement
 ↓
CTS
 ↓
Routing
 ↓
Timing Analysis
 ↓
Physical Verification
```

The resulting implementation contains standard cells, interconnections, and physical layout information.

<img width="1562" height="916" alt="Screenshot 2026-09-05 222831" src="https://github.com/user-attachments/assets/d30df6c5-ee7b-4ce8-b090-6d9748605d12" />
<img width="1396" height="867" alt="Screenshot 2026-09-05 224449" src="https://github.com/user-attachments/assets/503c0b31-288e-4e0d-b9d1-f1d3310669a6" />


---

# 13. OpenLane Setup

The OpenLane working environment contains the required tools, PDK information, design files, and configuration files.

The working environment contains different components required for running the flow.

A typical structure is:

```text
openlane/
├── designs/
├── pdks/
├── scripts/
├── configuration/
└── results/
```

The design-specific directory contains the RTL and configuration files required for the PicoRV32 implementation.

<img width="1408" height="844" alt="Screenshot 2026-09-05 224211" src="https://github.com/user-attachments/assets/86574a67-5bfd-49b3-b50b-2b4fcbe9c0af" />

---

# 14. OpenLane Configuration

The OpenLane flow uses configuration files to specify the design and implementation parameters.

Important configuration variables include:

* `DESIGN_NAME`
* `VERILOG_FILES`
* `CLOCK_PORT`
* `CLOCK_PERIOD`
* `CLOCK_NET`

The configuration specifies the RTL source files, clock information, and other implementation parameters.

For the PicoRV32 design, the required configuration was prepared before running the physical design flow.

<img width="1430" height="872" alt="Screenshot 2026-09-05 225221" src="https://github.com/user-attachments/assets/a899e2f7-e02f-48c2-9a1c-5375c08a1681" />

---

# 15. Running the OpenLane Flow

The OpenLane flow was executed using the PicoRV32 design and the Sky130 PDK.

During execution, OpenLane performs multiple stages automatically.

The flow generates separate results and reports for different stages such as:

* Synthesis
* Floorplanning
* Placement
* CTS
* Routing
* LVS

The generated run directory contains logs, reports, configuration files, and results.

<img width="1413" height="841" alt="Screenshot 2026-09-05 225418" src="https://github.com/user-attachments/assets/a2de3057-6d9b-4e3b-ba29-ae3a601d8aeb" />

---

# 16. Synthesis Results

The synthesis stage converts the RTL description into a gate-level netlist using cells from the Sky130 standard-cell library.

The synthesis report provides statistics about the resulting design.

Important information includes:

* Number of wires
* Number of wire bits
* Number of public wires
* Number of memories
* Number of processes
* Number of cells
* Standard-cell types and their counts

The synthesis results help understand the complexity and cell usage of the design.
<img width="1373" height="879" alt="Screenshot 2026-09-05 230042" src="https://github.com/user-attachments/assets/6218b3dc-03f0-45a2-a2f3-1b2cb345be06" />




---

# 17. Physical Design Reports

OpenLane generates reports for different stages of the implementation flow.

Important result directories include:

```text
results/
├── synthesis
├── floorplan
├── placement
├── cts
├── routing
└── lvs
```

Reports and logs are generated to analyze the progress and correctness of each stage.

These reports are useful for debugging and evaluating the physical implementation.

<img width="1353" height="850" alt="Screenshot 2026-09-05 225300" src="https://github.com/user-attachments/assets/6ea7a324-dc68-4834-8a38-42b7d5dca084" />


---

# 18. Static Timing Analysis

Static Timing Analysis (STA) is used to verify whether the design satisfies its timing requirements.

OpenSTA is used within the OpenLane flow for timing analysis.

Important timing parameters include:

* Clock period
* Data arrival time
* Data required time
* Cell delay
* Net delay
* Slack
* Setup time
* Hold time

A typical timing path can be represented as:

```text
Startpoint
    ↓
Logic Cells
    ↓
Interconnect
    ↓
Endpoint
```

The timing reports generated during the flow show the delay and timing characteristics of critical paths.

<img width="1389" height="859" alt="Screenshot 2026-09-05 225626" src="https://github.com/user-attachments/assets/68dbcabf-1aaf-4c6a-9c3f-42ad135a809b" />
<img width="1455" height="892" alt="Screenshot 2026-09-05 230742" src="https://github.com/user-attachments/assets/1a1544fc-779c-46b4-8999-54ff9c2f4067" />
<img width="1402" height="835" alt="Screenshot 2026-09-05 230901" src="https://github.com/user-attachments/assets/58f44918-09f0-45d6-9b1d-b53b5c490af1" />
<img width="1379" height="865" alt="Screenshot 2026-09-05 231057" src="https://github.com/user-attachments/assets/e8240dd9-9aa0-420d-b039-a7b0d14fbe51" />


---

# 19. Antenna Rule Violations

Antenna violations can occur during semiconductor manufacturing because long metal connections may accumulate electrical charge.

The physical design flow checks for antenna violations after routing.

A preventive technique is to add an antenna diode near the affected cell input.

The flow can identify antenna violations and perform appropriate repairs.

<img width="1919" height="1078" alt="Screenshot 2026-09-04 180508" src="https://github.com/user-attachments/assets/ec7b75d7-64cd-4c27-a908-41646e08e119" />


---

# 20. Layout and Final Results

After completing the physical design stages, the design is represented as a physical chip layout.

The final layout contains:

* Standard cells
* Macros
* Metal interconnections
* Power connections
* I/O structures

The physical implementation can be viewed using layout visualization tools.

The final output of the ASIC flow is a GDSII layout file that represents the physical geometry of the chip.

<img width="1919" height="943" alt="Screenshot 2026-09-04 180443" src="https://github.com/user-attachments/assets/14b25f24-9ff8-40bf-b96e-4fa145f7aba1" />


---

# 21. Summary

In this module, I learned:

* Fundamentals of Physical Design
* RISC-V architecture and the PicoRV32 processor core
* The complete RTL-to-GDSII ASIC flow
* The role of open-source EDA tools
* The importance of the Sky130 PDK
* Floorplanning and power planning
* Standard-cell placement
* Clock Tree Synthesis
* Routing using different metal layers
* OpenLane automated ASIC implementation
* OpenLane configuration and execution
* Synthesis statistics and reports
* Static Timing Analysis
* Antenna rule checking
* Physical design reports and results
* Generation and visualization of the final chip layout

Overall, this module provided practical exposure to the complete Physical Design flow, from RTL and synthesis to placement, routing, timing analysis, and final GDSII generation using open-source ASIC tools.
