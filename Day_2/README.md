# Day 2 – Timing Libraries, Synthesis Approaches, and Flip-Flop Coding

## Objectives

The objective of Day 2 was to understand timing libraries, the SKY130 PDK, different synthesis approaches, flip-flop coding styles, and the complete RTL simulation and synthesis flow using Icarus Verilog, GTKWave, and Yosys.

---

## 1. Timing Libraries

### 1.1 SKY130 PDK

The SKY130 PDK contains the technology information and standard-cell libraries required to design and synthesize digital circuits using 130 nm CMOS technology.

The timing library used during the workshop was:

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

### 1.2 Understanding `tt_025C_1v80`

The library name indicates the operating conditions used for the cells:

* **tt** – Typical process corner
* **025C** – Temperature of 25°C
* **1v80** – Supply voltage of 1.8 V

### 1.3 Exploring the `.lib` File

The `.lib` file contains information about standard cells, including their timing, power characteristics, and operating conditions. This information is used during synthesis and technology mapping.

Commands used:

```bash
sudo apt install gedit
gedit sky130_fd_sc_hd__tt_025C_1v80.lib
```

**Figure 1:** SKY130 timing library file.

### Result

<img width="1744" height="890" alt="image" src="https://github.com/user-attachments/assets/ff0007e7-02cf-4d85-9d2e-5e1e4330d753" />


The SKY130 timing library was successfully opened and its library and operating-condition information was examined.

---

## 2. Hierarchical and Flattened Synthesis

### 2.1 Hierarchical Synthesis

Hierarchical synthesis keeps the original module structure of the RTL design. The individual modules remain separate, which makes the design easier to understand, organize, and debug.

<img width="1838" height="889" alt="image" src="https://github.com/user-attachments/assets/5e731921-3c68-4f90-a11f-269e4deb6836" />


**Figure 2:** Hierarchical synthesized design.

### Result

The synthesized multi-module design retained its original module structure and connections.

---

### 2.2 Flattened Synthesis

Flattened synthesis combines the different modules into a single design structure. This allows the synthesis tool to perform optimization across module boundaries.

The Yosys command used for flattening was:

```text
flatten
```
<img width="1724" height="892" alt="image" src="https://github.com/user-attachments/assets/4e640dfd-057d-44ca-affb-34b67dc737d3" />



**Figure 3:** Flattened synthesized design.

---

### 2.3 Comparison

| Feature          | Hierarchical Synthesis  | Flattened Synthesis                 |
| ---------------- | ----------------------- | ----------------------------------- |
| Module structure | Preserved               | Removed                             |
| Optimization     | Limited between modules | Possible across the complete design |
| Debugging        | Easier                  | More difficult                      |
| Design structure | Modular                 | Single structure                    |

### Result

The difference between hierarchical and flattened synthesis was studied, especially in terms of module structure, optimization, and debugging.

---

## 3. Flip-Flop Coding Styles

Flip-flops are sequential logic elements used to store binary information. During Day 2, three different D flip-flop coding styles were studied.

### 3.1 Asynchronous Reset D Flip-Flop

An asynchronous reset changes the output immediately when the reset signal becomes active, without waiting for the clock edge.

### Verilog Code

```verilog
module dff_asyncres (
    input clk,
    input async_reset,
    input d,
    output reg q
);

always @(posedge clk, posedge async_reset)
    if (async_reset)
        q <= 1'b0;
    else
        q <= d;

endmodule
```

### Result

The D flip-flop with an asynchronous reset was implemented and its behavior was verified through simulation.

---

### 3.2 Asynchronous Set D Flip-Flop

An asynchronous set forces the output to logic **1** immediately when the set signal becomes active.

### Verilog Code

```verilog
module dff_async_set (
    input clk,
    input async_set,
    input d,
    output reg q
);

always @(posedge clk, posedge async_set)
    if (async_set)
        q <= 1'b1;
    else
        q <= d;

endmodule
```

### Result

The D flip-flop with an asynchronous set operation was implemented and its behavior was studied.

---

### 3.3 Synchronous Reset D Flip-Flop

A synchronous reset changes the output only when the active clock edge occurs.

### Verilog Code

```verilog
module dff_syncres (
    input clk,
    input async_reset,
    input sync_reset,
    input d,
    output reg q
);

always @(posedge clk)
    if (sync_reset)
        q <= 1'b0;
    else
        q <= d;

endmodule
```

### Result

The D flip-flop with a synchronous reset was implemented and its operation was verified.

---

## 4. RTL Simulation and Synthesis Flow

The RTL designs were simulated using **Icarus Verilog** and **GTKWave**. The designs were then synthesized using **Yosys** and mapped to the SKY130 standard-cell library.

---

### 4.1 Simulation Using Icarus Verilog

The Verilog design and testbench were compiled using:

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
```

The compiled simulation was executed using:

```bash
./a.out
```

The generated waveform was opened using GTKWave:

```bash
gtkwave tb_dff_asyncres.vcd
```

<img width="1707" height="898" alt="image" src="https://github.com/user-attachments/assets/7eff8693-6a8a-4e64-bead-63afaddc24f5" />

**Figure 4:** D flip-flop simulation waveform in GTKWave.

### Result

The simulation was successfully completed. The GTKWave waveform was used to verify the relationship between the clock, asynchronous reset, input data, and output.

---

### 4.2 Synthesis Using Yosys

Yosys was used to synthesize the RTL design and map it to cells available in the SKY130 standard-cell library.

### Start Yosys

```bash
yosys
```

### Read the SKY130 Liberty Library

```text
read_liberty -lib /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Read the Verilog Design

```text
read_verilog /path/to/dff_asyncres.v
```

### Perform Synthesis

```text
synth -top dff_asyncres
```

### Map Flip-Flops

```text
dfflibmap -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### Perform Technology Mapping

```text
abc -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

### View the Synthesized Design

```text
show
```
<img width="1118" height="584" alt="image" src="https://github.com/user-attachments/assets/2ecc2bfb-8804-471f-ab7e-6536f5c4f697" />

**Figure 5:** Synthesized gate-level representation.

### Result

The RTL design was successfully synthesized and mapped to standard cells from the SKY130 library. The resulting gate-level design was viewed using Yosys.

---

## 5. Overall Result

During Day 2, the SKY130 timing library was explored and the meaning of its operating conditions was understood. Hierarchical and flattened synthesis approaches were studied, and different D flip-flop coding styles were implemented.

The RTL design was successfully simulated using Icarus Verilog and GTKWave. The design was then synthesized and technology-mapped using Yosys with the SKY130 standard-cell library.

---

## 6. Conclusion

Day 2 provided practical experience with timing libraries, synthesis techniques, flip-flop coding styles, RTL simulation, waveform analysis, and technology mapping. This helped in understanding how an RTL design is converted into a gate-level implementation using standard-cell libraries.

