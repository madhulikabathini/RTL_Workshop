# Session 2 – RTL Synthesis, Netlist Generation and Verification

## Introduction

In Session 2, we worked on RTL synthesis and verification using open-source
EDA tools. The main tool used was Yosys, along with GTKWave and Graphviz.

The session helped us understand how an RTL design written in Verilog is
processed, optimized, converted into a gate-level netlist, and verified
through simulation.

The major steps performed were:

1. RTL simulation
2. Synthesis using Yosys
3. Technology mapping
4. Use of standard-cell library files
5. Netlist generation
6. Graphviz representation
7. Gate-level simulation
8. Waveform analysis

---

# 1. RTL Simulation Waveform

The first screenshot shows a GTKWave waveform for the RTL design.

GTKWave is a waveform viewer used to observe the behavior of digital
signals with respect to time.

The signals shown include inputs such as `i0`, `i1`, `sel` and the output
`y`.

By changing the input signals, we can observe the corresponding changes
in the output.

### What I learned

- How to view RTL simulation waveforms.
- How inputs and outputs change with time.
- How waveform analysis helps verify RTL functionality.
- How GTKWave can be used for debugging digital designs.

### Screenshot

<img width="933" height="592" alt="image" src="https://github.com/user-attachments/assets/6d8afbcc-4970-4b66-ad5c-31802dc7a21e" />

---

# 2. Standard Cell Library – Liberty File

The second screenshot shows a portion of a Liberty (`.lib`) standard-cell
library file.

A Liberty file contains information about standard cells used during
technology mapping and synthesis.

It contains information such as:

- Cell characteristics
- Input/output pins
- Timing information
- Capacitance
- Power information
- Leakage power
- Operating conditions

The screenshot shows `leakage_power()` entries with different logic
conditions.

### What I learned

The standard-cell library provides the information required by synthesis
tools to map RTL logic into actual technology-specific cells.

### Screenshot

<img width="407" height="619" alt="image" src="https://github.com/user-attachments/assets/db2596cc-0c8d-455e-b217-40cec6a23ee9" />

---

# 3. Yosys Synthesis and Optimization

The third screenshot shows the Yosys synthesis process in the terminal.

Yosys is an open-source synthesis tool used to convert RTL designs into
gate-level representations.

During synthesis, Yosys performs several optimization passes.

The screenshot shows optimization passes such as:

- OPT
- FSM optimization
- Memory optimization
- DFF optimization
- CLEAN
- Design hierarchy analysis
- Statistics generation
- CHECK

These passes simplify the design and remove unnecessary logic.

### What I learned

- How Yosys processes RTL code.
- How synthesis optimization works.
- How unused cells and wires can be removed.
- How Yosys reports design statistics.

### Screenshot

<img width="344" height="613" alt="image" src="https://github.com/user-attachments/assets/71eb1ba4-3e88-4fd9-983a-6a7838d95e03" />

---

# 4. Loading the Standard Cell Library

The fourth screenshot shows the standard-cell library being accessed during
the synthesis flow.

The library contains technology-specific information required for mapping
generic logic into physical standard cells.

For example, the library includes cells for:

- Multiplexers
- Logic gates
- Flip-flops
- Buffers
- Other digital building blocks

The library also contains timing and power-related information.

### What I learned

The synthesis tool needs a technology library to understand which
standard cells are available and what their characteristics are.

### Screenshot

<img width="1119" height="597" alt="image" src="https://github.com/user-attachments/assets/126ee03e-7d99-4361-8561-5d421dfab078" />


---

# 5. Technology Mapping of a Multiplexer

The fifth screenshot shows the synthesized representation of a `good_mux`
design.

The original RTL multiplexer has inputs `i0`, `i1` and a select signal
`sel`, with output `y`.

After synthesis, the multiplexer is mapped to a technology-specific
standard cell.

The diagram shows the input signals connected to the mapped multiplexer
cell.

### What I learned

RTL logic does not remain as high-level Verilog after synthesis. It is
converted into technology-specific standard cells.

### Screenshot

<img width="635" height="491" alt="image" src="https://github.com/user-attachments/assets/4b7e10ca-3deb-4a87-a7e8-d2ff34b9b336" />

---

# 6. Synthesized Counter Representation

The sixth screenshot shows the synthesized representation of the
`good_counter` design.

The design contains sequential elements such as flip-flops along with
combinational logic.

The counter uses a clock and reset and contains logic that controls the
state of the counter.

After synthesis, the RTL description is converted into flip-flops and
logic cells from the standard-cell library.

### What I learned

- How sequential RTL is converted into hardware.
- How flip-flops are represented after synthesis.
- How combinational logic connects with sequential elements.
- How a counter is implemented using hardware cells.

### Screenshot

<img width="937" height="539" alt="image" src="https://github.com/user-attachments/assets/f316ef4b-55cc-42e3-85e5-93ea26cdee0c" />


---

# 7. Detailed Synthesized Counter Netlist

The seventh screenshot provides another view of the synthesized
`good_counter` design.

The diagram shows the interconnection between flip-flops, logic gates,
multiplexers and other standard cells.

This representation is called a gate-level netlist.

A netlist describes how individual hardware cells are connected to form
the complete circuit.

### What I learned

The gate-level netlist gives a lower-level view of the hardware generated
from RTL.

### Screenshot

<img width="1062" height="557" alt="image" src="https://github.com/user-attachments/assets/7d7ea202-7620-4e8e-8871-d0979e5ef65c" />

---

## 8. Multiple-Module Design

The design was divided into multiple Verilog modules. One module can
perform a specific operation and its output can be connected to another
module.

This demonstrates hierarchical RTL design, where complex designs are
constructed using smaller reusable modules.

<img width="1050" height="591" alt="image" src="https://github.com/user-attachments/assets/90c330be-5d2f-4899-9bea-b6663da0ddbb" />


## 9. Synthesized Multiple-Module Design

After synthesis, the multiple-module RTL design is represented using
hardware cells and their interconnections.

The diagram shows how the individual modules are connected after synthesis.

<img width="320" height="505" alt="image" src="https://github.com/user-attachments/assets/4dc9f752-bbcc-4b4d-a433-d79f4592bb1f" />

<img width="1051" height="581" alt="image" src="https://github.com/user-attachments/assets/4a29fafa-cccd-4ca0-b124-1e6d45aa966a" />


## 10. Graphviz Representation

Yosys can generate a Graphviz representation of the synthesized circuit.
This provides a graphical view of the modules, cells and connections.

Graphical representation makes it easier to understand the structure and
signal flow of the synthesized circuit.


## 11. Pre-Synthesis Simulation

Before synthesis, the RTL design was simulated to verify its functional
behavior.

The simulation waveform shows the changes in the clock, reset, inputs and
outputs with respect to time. This provides an initial verification of the
RTL design before converting it into a gate-level implementation.

<img width="1059" height="597" alt="image" src="https://github.com/user-attachments/assets/fabf5732-9862-4f13-bb33-64cddca51248" />



## 12. Detailed Waveform Analysis

The waveform was examined in GTKWave at a more detailed time scale.

Different signal transitions can be observed, allowing us to understand the
relationship between the clock and the other signals.

GTKWave helps in identifying the exact time at which signals change and
checking whether the design behaves as expected.

<img width="996" height="600" alt="image" src="https://github.com/user-attachments/assets/e844e72a-ba1f-41d3-a035-34b698cd3c47" />



## 13. Post-Synthesis / Gate-Level Simulation

After synthesis, the generated gate-level netlist was simulated again.

The waveform obtained from the synthesized design can be compared with the
RTL simulation waveform. This helps verify that the synthesis process has
preserved the intended functionality of the original RTL design.

<img width="1061" height="595" alt="image" src="https://github.com/user-attachments/assets/0aafe99a-b97b-41af-a531-bfed38c2836a" />



## 14. Final Waveform Verification

The final GTKWave screenshot shows multiple internal and output signals
changing over time.

The clock provides the timing reference, while the other signals show the
internal state transitions of the synthesized circuit.

By examining these waveforms, the functionality of the synthesized design
can be verified.

### What I learned

- How to open and analyze simulation waveforms.
- How to observe clock and signal transitions.
- How to verify RTL behavior before synthesis.
- How to verify the synthesized design after synthesis.
- How waveform comparison helps confirm functional correctness.

<img width="1065" height="598" alt="image" src="https://github.com/user-attachments/assets/965d06a3-14da-4389-93ee-b02e3b226a19" />


---

# Overall Flow

The complete Session 2 flow can be summarized as:

RTL Verilog Code
        ↓
RTL Simulation
        ↓
Yosys Synthesis
        ↓
Optimization
        ↓
Technology Mapping
        ↓
Standard Cell Library
        ↓
Gate-Level Netlist
        ↓
Graphviz Visualization
        ↓
Gate-Level Simulation
        ↓
GTKWave Verification

---

# Conclusion

In Session 2, I learned how an RTL design is converted into a
technology-specific gate-level implementation using Yosys.

I also learned about standard-cell Liberty files, synthesis optimization,
technology mapping, gate-level netlists, hierarchical modules, Graphviz
visualization and waveform analysis using GTKWave.

This session helped me understand the complete flow from Verilog RTL to a
synthesized digital hardware implementation and its verification.
