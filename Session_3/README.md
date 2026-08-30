# Session 3 – MUX and BabySoC Synthesis and Verification

## Introduction

In Session 3, we worked on the synthesis and verification of digital
designs using open-source EDA tools.

The session was divided into two major parts:

1. Multiplexer (`good_mux`) synthesis and verification
2. BabySoC (`vsdbabysoc`) synthesis and verification

The main tools used during the session were Yosys for synthesis, Graphviz
for circuit visualization, and GTKWave for waveform analysis.

The complete flow helped us understand how RTL code is converted into a
technology-specific gate-level implementation and how the synthesized
design can be verified using simulation.

---

# Part 1 – MUX Design

## 1. MUX RTL Simulation

The first screenshot shows the RTL simulation waveform of the `good_mux`
design.

A multiplexer is a combinational digital circuit that selects one input
from multiple inputs based on a select signal.

The `good_mux` design contains two input signals, `i0` and `i1`, a select
signal `sel`, and an output `y`.

The output changes according to the value of the select signal. When the
select signal changes, the corresponding input is passed to the output.

The waveform is viewed using GTKWave, which allows us to observe the signal
transitions with respect to time.

### What I learned

- Working principle of a multiplexer.
- Relationship between input, select and output signals.
- How to simulate an RTL design.
- How to observe digital signals using GTKWave.

<img width="961" height="529" alt="image" src="https://github.com/user-attachments/assets/7795d0b6-9a52-4f15-9049-6ad0c9da72da" />


---

# 2. MUX Synthesized Representation

The second screenshot shows the synthesized representation of the
`good_mux` design.

After synthesis, the RTL description of the multiplexer is converted into
a hardware representation using cells from the target standard-cell
library.

The input signals `i0` and `i1` and the select signal `sel` are connected
to the synthesized multiplexer cell, which produces the output `y`.

This shows how a simple RTL design is transformed into a
technology-specific hardware implementation.

### What I learned

- How RTL logic is converted into hardware cells.
- How technology mapping is performed.
- How synthesized designs can be represented graphically.

<img width="949" height="534" alt="image" src="https://github.com/user-attachments/assets/6ea1b552-f68f-47b9-9d44-5c9b6046394c" />


---

# 3. MUX Netlist and Simulation Flow

The third screenshot shows the terminal commands and the simulation flow
used for the `good_mux` design.

The synthesized netlist is used as an input for gate-level simulation.
The terminal shows commands used to generate and simulate the required
files.

The technology library is also required because the synthesized design
contains technology-specific standard-cell instances.

This step connects the synthesis process with post-synthesis verification.

### What I learned

- How to work with synthesized netlists.
- How gate-level simulation is performed.
- How technology libraries are used during simulation.
- How synthesis and simulation are connected in the design flow.

<img width="948" height="535" alt="image" src="https://github.com/user-attachments/assets/f9ed4477-ddc7-4c06-a9ac-744b48ed8d19" />


---

# 4. MUX Gate-Level Waveform

The fourth screenshot shows the waveform obtained during the gate-level
simulation of the synthesized MUX.

The input signals and select signal change with time, and the output
responds according to the selected input.

GTKWave is used to observe the different signal transitions and verify
whether the synthesized circuit is behaving as expected.

### What I learned

Gate-level simulation helps verify that the synthesized implementation
maintains the intended functionality of the original RTL design.

<img width="956" height="540" alt="image" src="https://github.com/user-attachments/assets/8f023685-52b5-4e56-8c89-29b09f19415e" />


---

# 5. Detailed MUX Waveform Verification

The fifth screenshot shows a detailed view of the MUX waveform.

The different signal transitions can be observed with respect to time.
By comparing the input signals, select signal and output, the operation of
the multiplexer can be verified.

The waveform confirms the relationship between the select signal and the
output of the MUX.

### What I learned

- How to analyze individual signal transitions.
- How to verify combinational logic using waveforms.
- How GTKWave can be used for debugging.
- How to verify the synthesized MUX.



---

# Part 2 – BabySoC Design

## 6. BabySoC Block Diagram

After completing the MUX example, we worked on a larger SoC-level design
called `vsdbabysoc`.

The BabySoC contains different functional blocks, including the RISC-V
core, clock and reset related logic, and PLL-related circuitry.

The block diagram provides a high-level view of the architecture and shows
how the major blocks are connected to each other.

A block-level representation makes it easier to understand a complex
design before examining its detailed gate-level implementation.

### What I learned

- How an SoC is divided into functional blocks.
- How different hardware blocks communicate.
- How block diagrams represent complex digital systems.
- How the RISC-V core and other supporting blocks are connected.




---

# 7. BabySoC Synthesis and Optimization

The seventh screenshot shows the Yosys synthesis and optimization process
for the BabySoC design.

Yosys is an open-source RTL synthesis tool. It processes the Verilog RTL
and converts it into an internal representation that can be optimized and
mapped to hardware cells.

Several optimization passes are performed during synthesis. These passes
help remove unnecessary logic and simplify the design.

Examples of optimization operations include:

- Constant propagation
- Removal of unused logic
- Multiplexer optimization
- Flip-flop optimization
- Removal of unused wires and cells

### What I learned

- How Yosys performs RTL synthesis.
- Why optimization is required.
- How redundant logic can be removed.
- How synthesis improves the hardware implementation.
<img width="709" height="513" alt="image" src="https://github.com/user-attachments/assets/dea5d254-ee3b-49cb-a544-e6ef9fbaf288" />

---

# 8. BabySoC Synthesis Statistics

The eighth screenshot shows the design statistics generated by Yosys.

Yosys provides information about the size and complexity of the synthesized
design.

The statistics include information such as:

- Number of wires
- Number of wire bits
- Number of public wires
- Number of ports
- Number of cells
- Number of processes
- Number of memories
- Number of sequential elements

These statistics provide a quantitative view of the hardware generated
from the RTL.

### What I learned

Design statistics help us understand the complexity of a synthesized
circuit and can also be used to compare different synthesis results.

<img width="289" height="536" alt="image" src="https://github.com/user-attachments/assets/35361a94-8788-43f9-af42-d50f4823c575" />

---

# 9. BabySoC Graphviz Representation

The ninth screenshot shows a large Graphviz representation of the
BabySoC design.

Graphviz is used to generate a graphical representation of the synthesized
circuit.

The design is represented as a graph containing nodes and connections.
Each hardware block or cell is represented as part of the graph, while
the connecting lines represent signal connections.

Since BabySoC is a much larger design than the MUX example, the generated
graph contains a very large number of connections.

### What I learned

- How to visualize a synthesized circuit.
- How Graphviz represents hardware connectivity.
- How large digital designs contain many internal connections.
- How graphical representations help in understanding netlists.
<img width="413" height="445" alt="image" src="https://github.com/user-attachments/assets/a8ca1edf-18e8-474b-920c-de17dbc06138" />

---

# 10. BabySoC Cell Statistics

The tenth screenshot shows information about the cells used in the
synthesized BabySoC design.

During technology mapping, generic logic is converted into
technology-specific standard cells available in the selected library.

The design may contain different types of cells such as:

- AND gates
- OR gates
- NAND gates
- NOR gates
- Multiplexers
- Buffers
- Flip-flops
- Other standard logic cells

The cell statistics show how the original RTL functionality is implemented
using actual hardware cells.

### What I learned

Technology mapping connects the synthesized RTL representation to a
specific semiconductor technology and its available standard-cell library.

<img width="1040" height="535" alt="image" src="https://github.com/user-attachments/assets/5ead077f-0090-41ba-b7bd-23c7ab044fbd" />

---

# 11. Generated BabySoC Gate-Level Verilog Netlist

The eleventh screenshot shows the generated gate-level Verilog netlist.

After synthesis and technology mapping, the original RTL code is converted
into a lower-level representation containing technology-specific
standard-cell instances.

The cells are connected using internal nets to implement the required
functionality of the BabySoC.

This gate-level Verilog represents the hardware structure generated by the
synthesis process.

### What I learned

- How RTL is converted into gate-level Verilog.
- How standard-cell instances appear in a netlist.
- How hardware cells are connected using nets.
- How the synthesized design differs from the original RTL.

<img width="1065" height="531" alt="image" src="https://github.com/user-attachments/assets/94ef0294-883f-4e8c-b662-96f8bf006402" />

---

# 12. BabySoC Synthesized Circuit Representation

The twelfth screenshot shows a graphical representation of the synthesized
BabySoC circuit.

The diagram contains multiple hardware blocks and their interconnections.
It provides a lower-level view of how the different components of the SoC
are connected after synthesis.

The graphical representation makes it easier to understand the structure
and signal flow of the synthesized design.

### What I learned

- How synthesized hardware can be represented graphically.
- How different cells are interconnected.
- How the RTL structure is transformed after synthesis.

---

# 13. BabySoC Simulation Waveform

The thirteenth screenshot shows the BabySoC simulation waveform in
GTKWave.

The waveform contains important signals such as clock, reset and other
internal or output signals.

The clock acts as the timing reference for the sequential elements in the
design. The other signals change according to the operation of the
different blocks in the SoC.

GTKWave allows the signals to be observed over time and helps verify the
behavior of the synthesized design.

### What I learned

- How to analyze SoC-level waveforms.
- How clock signals control sequential circuits.
- How reset affects the design.
- How GTKWave is used for hardware verification.

<img width="1584" height="744" alt="image" src="https://github.com/user-attachments/assets/107173e1-a452-4ef7-8f33-2c5213f8d346" />


---

# 14. Final BabySoC Waveform Analysis

The fourteenth screenshot shows a detailed waveform containing several
internal BabySoC signals.

The large number of waveforms represents the internal activity of the
synthesized SoC.

By observing the clock, reset and internal signals, we can analyze how the
different parts of the design operate with respect to time.

Waveform analysis is an important step in verifying that the synthesized
implementation behaves as expected.

### What I learned

- How to analyze multiple digital signals.
- How to observe internal signal transitions.
- How clock and reset signals affect sequential logic.
- How to use GTKWave for final verification.
- How to verify the synthesized SoC design.

<img width="1584" height="744" alt="image" src="https://github.com/user-attachments/assets/063abe4a-ab2c-42f3-9e11-ded267165ea1" />


---

# Overall Session 3 Flow

The complete flow performed during Session 3 can be summarized as:

```text
MUX RTL Design
      ↓
RTL Simulation
      ↓
MUX Synthesis
      ↓
Technology Mapping
      ↓
Gate-Level Simulation
      ↓
GTKWave Verification
      ↓
BabySoC RTL Design
      ↓
Yosys Synthesis
      ↓
Optimization
      ↓
Technology Mapping
      ↓
Standard-Cell Netlist
      ↓
Design Statistics
      ↓
Graphviz Visualization
      ↓
Gate-Level Simulation
      ↓
GTKWave Waveform Analysis
      ↓
Final Verification
 
