# Module 4: Timing Analysis, Clock Tree Synthesis & Physical Design

## 📌 Project Overview

This project explores the physical-implementation and timing-verification phases of an RTL-to-GDSII flow, using the PicoRV32A core, OpenLane, OpenROAD, and the SKY130A process design kit.

The module walks through:

RTL Design → Synthesis → Cell Mapping → Floorplanning → Placement → Clock Tree Synthesis → Timing Analysis → Routing → Physical Verification

It also covers core timing concepts, including:

- Setup time
- Hold time
- Data arrival time
- Data required time
- Slack
- Clock skew
- Clock latency
- Clock-tree buffering
- Crosstalk-induced delay
- Real-clock timing
- Ideal-clock timing

## 🎯 Objectives

1. Understand the RTL-to-GDSII physical-design flow.
2. Set up and run an OpenLane design flow.
3. Analyze the PicoRV32A design using the SKY130A PDK.
4. Understand synthesis and technology mapping.
5. Examine the count and variety of standard cells produced after synthesis.
6. Understand placement and how cells are physically distributed.
7. Study Clock Tree Synthesis (CTS).
8. Understand clock buffering and distribution.
9. Analyze clock skew and clock latency.
10. Understand setup and hold timing analysis.
11. Study the impact of real interconnect RC delay.
12. Understand crosstalk-induced delay and skew.
13. Analyze OpenROAD-generated timing reports.
14. Differentiate ideal-clock analysis from propagated-clock analysis.
15. Understand timing closure and how slack is improved.

## 🔧 Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| OpenLane | RTL-to-GDSII physical-design flow |
| OpenROAD | Physical implementation and timing analysis |
| Yosys | RTL synthesis and logic optimization |
| SKY130A PDK | CMOS technology and standard-cell library |
| Magic VLSI | Layout viewing and physical verification |
| PicoRV32A | RISC-V processor used as the implementation target |
| Linux Terminal | Flow execution and analysis |
| Tcl | OpenLane/OpenROAD configuration and scripting |
| Git & GitHub | Version control and documentation |

## 🔬 Project Workflow

RTL Design → OpenLane Configuration → Logic Synthesis → Technology Mapping → Design Statistics → Floorplanning → Placement → Clock Tree Synthesis → Routing → Parasitic Extraction → Static Timing Analysis → Setup/Hold Verification → Physical Verification

---

### 1. Physical-Design Coordinate / Layer Information

Displays coordinate data tied to physical-design layers such as li1, met1, met2, met3, met4, and met5. The coordinates mark the physical boundaries or positions on each routing layer, showing that physical design relies on geometric coordinates rather than logical connectivity alone.

<img width="1046" height="599" alt="image" src="https://github.com/user-attachments/assets/5eb489ff-6f00-40d0-b096-c8982f5a03d5" />

**Key concepts:**
- Local interconnect
- Metal layers
- X/Y coordinates
- Physical routing dimensions
- Layer-specific geometry

Useful for understanding where cells and nets are physically situated and routed.

### 2. Magic VLSI Layout and DRC Environment

Shows the Magic VLSI layout environment configured for SKY130A. The layout includes several physical layers — transistor regions, contacts, polysilicon, and diffusion. A Magic console is also visible, with the `grid` command reflecting the physical layout grid dimensions for SKY130A.

<img width="797" height="405" alt="image" src="https://github.com/user-attachments/assets/e2a6147c-3722-442a-a323-c68a8be929ee" />

**Demonstrates:**
- Physical layout editing
- SKY130A technology
- Layer-based representation
- Layout grid
- Design-rule-checking environment
- Interactive physical-design debugging

### 3. Standard-Cell Physical Layout

A close-up view of a single standard cell's physical layout, with colors and patterns denoting different CMOS layers.

<img width="591" height="359" alt="image" src="https://github.com/user-attachments/assets/08dbfdb6-e34e-459e-aa08-0221e28e649f" />

**Contains:**
- Metal/interconnect regions
- Diffusion regions
- Polysilicon
- Contacts
- Transistor structures
- Power/ground connections

Shows how a logical standard cell is turned into an actual geometric structure ready for placement and routing.

### 4. OpenLane Design Configuration

Shows the OpenLane configuration used for the PicoRV32A design.

<img width="792" height="457" alt="image" src="https://github.com/user-attachments/assets/652f3761-a7b7-4db7-8d43-d31d4f241aa1" />

Key parameters:
- `DESIGN_NAME = picorv32a`
- `CLOCK_PERIOD = 5.000`
- `CLOCK_PORT = clk`

Also specifies the RTL source and SDC timing-constraint file.

**Establishes:**
- Design name
- RTL source
- SDC constraints
- Clock period
- Clock port
- OpenLane environment
- Standard-cell setup

A 5 ns clock period corresponds to a nominal 200 MHz operating frequency.

### 5. OpenLane Initialization

Shows OpenLane being launched from a Linux terminal.

Version shown: **rc2**

<img width="974" height="227" alt="image" src="https://github.com/user-attachments/assets/a567a5cb-b6db-487a-80f2-1ba5bb6e9094" />

**Demonstrates:**
- OpenLane startup
- Docker-based execution
- Version information
- Terminal-based workflow

OpenLane automates the pipeline connecting synthesis, floorplanning, placement, CTS, routing, and physical verification.

### 6. Logic Synthesis and Cell Mapping

Shows synthesis output for PicoRV32A, including mapping of generic flip-flops onto SKY130 standard cells — e.g., `mapped 1634 $DFF_P cells`.

<img width="949" height="615" alt="image" src="https://github.com/user-attachments/assets/c1b80c48-1b98-468f-9a99-079481535c19" />

**Design statistics reported:**
- Wire count
- Wire-bit count
- Public wire count
- Cell count
- Logic-gate distribution
- Technology-mapped flip-flops

Synthesis converts RTL logic into a gate-level netlist built from technology-specific cells.

### 7. Post-Synthesis Design Statistics

Additional synthesis stats after technology mapping, listing SKY130 cell types used:

- AND gates
- OR gates
- NAND gates
- NOR gates
- Inverters
- Buffers
- Flip-flops

Also reports the computed chip area for the `picorv32a` module.

<img width="950" height="755" alt="image" src="https://github.com/user-attachments/assets/d61bf20b-c1b1-48be-97a9-8da2a51230f8" />

**Key parameters:**
- Cell count
- Standard-cell mix
- Wire count
- Chip area
- Technology-mapped cells

These numbers help gauge design complexity and physical footprint.

### 8. Static Timing Analysis — Slack Violation

A timing report from the physical-design flow, showing:

- Data arrival time
- Data required time
- Library setup time
- Clock information
- Clock network delay
- Slack

Result: **slack (VIOLATED)**

<img width="680" height="727" alt="image" src="https://github.com/user-attachments/assets/1b21ed85-6de8-4f1a-8f53-4774c4db6726" />

Negative slack means the analyzed path fails to meet its timing budget — illustrating why STA is essential during implementation. Fixes typically involve cell sizing, buffer insertion, placement tuning, clock optimization, or routing adjustments.

### 9. Power-Aware Clock Tree Synthesis

Illustrates Power-Aware CTS with two buffering levels (Level 1, Level 2) and delay tables indexed by input slew and output load.

<img width="679" height="315" alt="image" src="https://github.com/user-attachments/assets/fb642853-4762-408e-a35c-1acec0e2b9c8" />

The tables capture how buffer delay varies with different transition/capacitance combinations, showing that clock-tree design must balance **timing** against **power**. The network is built so sequential elements see the clock with controlled delay and balanced loading.

### 10. Complete Physical Layout View

A large-scale layout view showing dense placement of standard cells and routing structures — illustrating the shift from logical design to physical cell placement.

<img width="685" height="385" alt="image" src="https://github.com/user-attachments/assets/df8c5569-664b-4f65-9d0e-21c2e12d4da7" />

Useful for evaluating:
- Cell density
- Placement quality
- Routing resource usage
- Physical utilization
- Overall floorplan organization

### 11. Detailed Standard-Cell Placement and Connectivity

A closer view of placed standard cells and their connections, including D flip-flops, NAND, NOR, AND gates, and other combinational cells, plus clock- and power-related structures — showing how individual cells are arranged and wired after placement.

<img width="686" height="437" alt="image" src="https://github.com/user-attachments/assets/699c6619-f1ea-475b-bc80-27997e93796f" />

### 12. Clock Tree Synthesis

Illustrates two flip-flops (FF1, FF2) receiving a shared clock via a distribution network.

Skew is defined as: `Skew = t2 − t1`, with a target of **Skew ≈ 0 ps**.

<img width="680" height="627" alt="image" src="https://github.com/user-attachments/assets/0305f78f-b4b9-4bc6-9677-de53a56a9e4c" />

CTS aims to keep clock arrival times at sequential elements as closely aligned as possible, since skew impacts setup timing, hold timing, maximum frequency, and overall timing closure.

### 13. Clock Tree Buffering

Shows the clock network split into branches with buffers driving different loads, along with buffer RC behavior and propagation delay.

<img width="673" height="305" alt="image" src="https://github.com/user-attachments/assets/e8c1ced3-6f7b-4def-b1ce-3d11503a90c2" />

Buffering is necessary because a single clock source can't efficiently drive many sequential elements directly. Buffers:
- Boost drive strength
- Control transition time
- Limit excessive delay
- Distribute the clock signal
- Balance arrival times

### 14. Crosstalk Delta Delay and Clock Skew

Explains how crosstalk-induced delta delay affects clock skew, driven by coupling capacitance between adjacent wires.

<img width="672" height="310" alt="image" src="https://github.com/user-attachments/assets/c0698102-53a1-458c-b69b-594ced4b831e" />

Compares:
- Before crosstalk: `Delay = D`
- After crosstalk: `Delay = D + Δ`

Relationship: `L1 = L2 + Δ`, and `SKEW = L1 − (L2 + Δ)`

Crosstalk can alter signal delay and therefore skew — an important consideration in advanced interconnect-aware timing analysis.

### 15. Placement Analysis and Legality Checks

Placement-stage report showing:
- Total cells
- Fixed cells
- Total nets
- Design area
- Utilization
- Row count

Placement metrics:
- Average / maximum displacement
- HPWL
- Displacement per site / per row

Legality checks all pass:
```
row_check      ==> PASS
site_check     ==> PASS
power_check    ==> PASS
edge_check     ==> PASS
placed_check   ==> PASS
overlap_check  ==> PASS
```

### 16. Hold Analysis with Real Clocks

Hold-time analysis with real clock propagation, tracing the path: Launch Flip-Flop → Combinational Logic → Capture Flip-Flop, with multiple buffers in the clock path.

<img width="666" height="305" alt="image" src="https://github.com/user-attachments/assets/2120bb56-6509-4669-b6c3-e5482f33137b" />

Defines:
- Data arrival time
- Data required time
- Clock uncertainty
- Hold time
- Clock propagation delay
- Slack

Hold condition: `θ + Δ₁ > H + Δ₂ + HU`

Example: Clock frequency = 1 GHz, Clock period = 1 ns — showing how real clock propagation shapes timing results.

### 17. Hold Analysis Using Flip-Flop Internal Structure

A deeper look at hold timing via the flip-flop's internal master/slave multiplexer structure (Mux1, Mux2), with a waveform relating Clock, D, internal node Q_M, and output Q.

<img width="666" height="304" alt="image" src="https://github.com/user-attachments/assets/f78cfe42-431a-453b-8711-f07c83c0446d" />

Explains why data needs a finite amount of time to propagate through the internal flip-flop structure — contributing to overall hold-time requirements.

### 18. Real-Clock Timing Paths

Timing analysis using real clocks and real interconnect delays, covering paths between input ports, flip-flops, buffers, combinational logic, output ports, and the clock network.

<img width="665" height="299" alt="image" src="https://github.com/user-attachments/assets/f5fb9aa0-c98b-4037-9f9c-f3d2d041275d" />

Delay = **real wire RC delay + buffer delay**, so total delay includes both cell and interconnect contributions.

Hold condition: `θ + Δ₁ > H + Δ₂ + HU`

More realistic than ideal-clock analysis since it factors in actual physical delays.

### 19. Clock Propagation and Timing Report

<img width="658" height="300" alt="image" src="https://github.com/user-attachments/assets/c918d03b-a509-4034-9c8e-66dd240e2fe5" />

An OpenROAD timing report with detailed clock propagation info:
- Clock source
- Clock network delay
- Clock buffer delays
- Clock reconvergence pessimism
- Library setup time
- Data required time
- Data arrival time
- Slack

Result: **slack (VIOLATED)** — negative slack indicating the path fails to meet its constraint, useful for pinpointing violation sources.

### 20. Clock Skew Report and CTS Buffer Configuration

Shows post-propagation timing results with **slack (MET)** — the path satisfies its constraint.

<img width="649" height="304" alt="image" src="https://github.com/user-attachments/assets/f71f30de-e0b9-44b3-9f57-1236b073fe31" />

Also shows:
```
report_clock_skew -hold
report_clock_skew -setup
```

Reported skew: **0.28**

The lower section shows the CTS clock-buffer list being configured — demonstrating how buffer-cell selection can be adjusted for CTS.

### 21. Placement Results After Configuration

Another placement-analysis snapshot for PicoRV32A, reporting total cells, fixed cells, total nets, design area, utilization, row count, HPWL, and placement displacement.

<img width="650" height="305" alt="image" src="https://github.com/user-attachments/assets/9b8a8a89-6c4d-4f96-b927-0db39ce77391" />

Legality checks again all pass:
```
row_check      ==> PASS
site_check     ==> PASS
power_check    ==> PASS
edge_check     ==> PASS
placed_check   ==> PASS
overlap_check  ==> PASS
```

Confirms a physically valid placement ahead of later stages.

### 22. Timing Analysis with Ideal Clocks

Illustrates timing analysis under an idealized clock, covering paths through flip-flops, buffers, combinational logic, clock networks, and decoupling structures, with paths between sequential elements highlighted.

<img width="680" height="440" alt="image" src="https://github.com/user-attachments/assets/0afc681f-de35-4a5a-9abe-8aba5e6304fa" />

Ideal-clock analysis assumes an idealized clock distribution before actual clock-tree delays are applied — useful for separating data-path effects from clock-network effects.

### 23. Setup Analysis with Ideal Clocks

Explains setup-time analysis under an ideal clock, using the flip-flop's internal Mux1/Mux2 structure and a waveform relating Clock, D, internal node Q_M, and Q.

Key idea: data must reach the internal capture point with enough margin before the active clock edge — this internal delay contributes to the flip-flop's setup time.

---

## 📊 Key Timing Concepts

**Setup Time** — the minimum time input data must remain stable *before* the active clock edge. A setup violation happens when data arrives too late.

**Hold Time** — the minimum time data must remain stable *after* the active clock edge. A hold violation happens when data changes too soon after the edge.

<img width="674" height="259" alt="image" src="https://github.com/user-attachments/assets/69abefb1-c7b6-4a51-9fd0-e16496d754ce" />

**Data Arrival Time** — when data reaches the capture element; depends on cell delay, interconnect delay, buffer delay, and routing parasitics.

**Data Required Time** — the latest acceptable moment for data to arrive while still meeting the timing constraint.

**Slack** — the margin between required and actual timing.

For setup analysis: `Slack = Data Required Time − Data Arrival Time`

- Positive slack → constraint met
- Zero slack → borderline
- Negative slack → violation

##  Real Clock vs. Ideal Clock

| Parameter | Ideal Clock | Real / Propagated Clock |
|---|---|---|
| Clock network | Idealized | Physically implemented |
| Clock buffer delay | Not fully modeled | Included |
| Clock skew | Idealized | Included |
| Wire RC delay | Simplified | Included |
| CTS effects | Not fully modeled | Represented |
| Timing accuracy | Preliminary | More realistic |

##  Clock Tree Synthesis Flow

Clock Source → Clock Buffering → Clock Branching → Clock Distribution → Sequential Elements

**Goals:**
- Minimize clock skew
- Control clock latency
- Keep slew within bounds
- Manage capacitive load
- Distribute the clock efficiently
- Meet setup and hold requirements

##  Timing Closure

Timing closure is the iterative process of adjusting the physical implementation until all timing constraints are satisfied.

**Common techniques:**
- Cell sizing
- Buffer insertion / resizing
- Placement optimization
- Clock-tree optimization
- Routing optimization
- Reducing excess wire delay
- Reducing clock skew
- Optimizing critical paths

Goal: acceptable slack across all timing paths.

##  Conclusion

Module 4 traces the journey from a synthesized RTL design to a physically implemented, timing-verified one — connecting Synthesis → Placement → Clock Tree Synthesis → Routing → Parasitic Extraction → Static Timing Analysis → Timing Closure.

Using the PicoRV32A design on the SKY130A/OpenLane-OpenROAD flow, the module highlights how physical implementation shapes timing through cell delays, wire RC delays, clock latency, clock skew, crosstalk, buffer delays, and setup/hold requirements.

Successful physical design ultimately demands both **geometric correctness** and **timing correctness**.
