# Day 3 – Flip-Flop Coding Styles and RTL Optimization

## Objectives

The objective of Day 3 was to study different ways of coding flip-flops, understand their synthesis and optimization, and observe how Yosys converts RTL code into an optimized hardware representation.

---

# 1. Flip-Flop Coding Styles and Optimization

Flip-flops are sequential logic circuits used to store binary data. Different coding styles are used depending on the required reset or set behavior.

During this experiment, the following flip-flop coding styles were studied:

* Asynchronous Reset D Flip-Flop
* Asynchronous Set D Flip-Flop
* Synchronous Reset D Flip-Flop

---

## 1.1 Asynchronous Reset D Flip-Flop

An asynchronous reset changes the output immediately when the reset signal becomes active. It does not have to wait for a clock edge.

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

### Working

When `async_reset` is active, the output `q` immediately becomes `0`. When the reset is inactive, the input `d` is transferred to `q` at the rising edge of the clock.

### Simulation Commands

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
./a.out
gtkwave tb_dff_asyncres.vcd
```

### Result

The asynchronous-reset D flip-flop was successfully simulated. The GTKWave waveform was used to verify the behavior of the clock, reset, input, and output signals.

<img width="1160" height="598" alt="image" src="https://github.com/user-attachments/assets/e4e26742-8e3b-4056-853f-28e74f0a5a30" />

**Figure 1:** Simulation waveform of the asynchronous-reset D flip-flop.

---

## 1.2 Asynchronous Set D Flip-Flop

An asynchronous set forces the output to logic `1` as soon as the set signal becomes active, without waiting for a clock edge.

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

### Working

When `async_set` is active, the output `q` becomes `1` immediately. When the set signal is inactive, the input `d` is captured at the rising edge of the clock.

### Result

The asynchronous-set D flip-flop was implemented and its operation was studied through simulation.

<img width="770" height="751" alt="image" src="https://github.com/user-attachments/assets/0429b814-9eb7-4415-9d54-3361713e12cd" />

**Figure 2:** Simulation waveform of the asynchronous-set D flip-flop.

---

## 1.3 Synchronous Reset D Flip-Flop

A synchronous reset affects the output only when the active clock edge occurs.

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

### Working

When `sync_reset` is active at the rising edge of the clock, the output `q` becomes `0`. Otherwise, the input `d` is transferred to the output at the clock edge.

### Result

The synchronous-reset D flip-flop was successfully simulated and its waveform behavior was observed.

<img width="1694" height="894" alt="image" src="https://github.com/user-attachments/assets/eb5c406b-a520-4028-91b7-5b425b6c9caf" />

**Figure 3:** Simulation waveform of the synchronous-reset D flip-flop.

---

## 1.4 Flip-Flop Synthesis

After simulation, the RTL flip-flop design was synthesized using Yosys. The SKY130 standard-cell library was used for technology mapping.

### Yosys Commands

Start Yosys:

```text
yosys
```

Read the SKY130 Liberty library:

```text
read_liberty -lib /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Read the Verilog design:

```text
read_verilog /path/to/dff_asyncres.v
```

Perform synthesis:

```text
synth -top dff_asyncres
```

Map the flip-flop to library cells:

```text
dfflibmap -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Perform technology mapping:

```text
abc -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

View the synthesized design:

```text
show
```

### Result

The flip-flop RTL design was successfully synthesized and mapped to cells from the SKY130 standard-cell library. The resulting gate-level representation was viewed using Yosys.

<img width="1722" height="724" alt="image" src="https://github.com/user-attachments/assets/567ea919-704c-48f4-92c0-6835be3f2f9a" />
<img width="1374" height="707" alt="image" src="https://github.com/user-attachments/assets/e829b4a2-7a52-4a02-9e21-2b5da865fb70" />


**Figure 4:** Synthesized gate-level representation of the flip-flop design.

---

# 2. Interesting Optimization – Part 1

RTL synthesis tools optimize a design while maintaining its required functionality. Yosys can simplify arithmetic operations and produce an optimized hardware representation.

In this section, multiplication by constant values was used to observe how Yosys performs optimization.

---

## 2.1 `mul2` Optimization

The following RTL design multiplies the input by a constant value.

### Verilog Code

```verilog
module mul2 (
    input [2:0] a,
    output [3:0] y
);

assign y = a * 2;

endmodule
```

Here, the input `a` is multiplied by `2`, and the result is assigned to the output `y`.

### Yosys Commands

```text
yosys
```

```text
read_verilog mul2.v
```

```text
prep -top mul2
```

```text
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

```text
show
```

Generate the synthesized netlist:

```text
write_verilog -noattr mul2_net.v
```

Open the generated netlist:

```text
gvim mul2_net.v
```

### Result

The `mul2` design was successfully synthesized. Yosys optimized the multiplication operation and generated the corresponding synthesized Verilog netlist.
<img width="1742" height="898" alt="image" src="https://github.com/user-attachments/assets/8e358b84-c928-46c0-bf9f-a778f4f21916" />


**Figure 5:** Yosys synthesis and optimization result for `mul2`.

---

## 2.2 `mult8` Optimization

Another multiplication example was used to study the optimization performed by Yosys.

### Verilog Code

```verilog
module mult8 (
    input [2:0] a,
    output [5:0] y
);

assign y = a * 9;

endmodule
```

Here, the input `a` is multiplied by `9`, and the result is assigned to the output `y`.

### Yosys Commands

```text
yosys
```

```text
read_verilog mult8.v
```

```text
prep -top mult8
```

```text
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

```text
show
```

Generate the synthesized netlist:

```text
write_verilog -noattr mult8_net.v
```

Open the generated netlist:

```text
gvim mult8_net.v
```

### Result

The `mult8` design was successfully synthesized and optimized. The generated netlist shows the optimized hardware representation obtained from the original RTL code.

<img width="1741" height="893" alt="image" src="https://github.com/user-attachments/assets/4a6e0b5f-4593-4b66-860e-a8c459f2fb7f" />

**Figure 6:** Yosys synthesis and optimization result for `mult8`.

---

## 2.3 Generated Synthesized Netlist

After synthesis, Yosys can generate a Verilog file containing the synthesized version of the RTL design.

For `mul2`:

```text
write_verilog -noattr mul2_net.v
```

For `mult8`:

```text
write_verilog -noattr mult8_net.v
```

The generated files can be opened using:

```text
gvim mul2_net.v
```

```text
gvim mult8_net.v
```

### Result

The synthesized Verilog netlists were successfully generated and examined to understand how the original RTL code was converted into an optimized hardware representation.

<img width="1731" height="895" alt="image" src="https://github.com/user-attachments/assets/38ec40fb-813f-444a-9e2c-0501a0047cd4" />

**Figure 7:** Generated synthesized Verilog netlist.

---

# 3. Overall Results

The following observations were made during Day 3:

* Different D flip-flop coding styles were studied.
* Asynchronous reset behavior was verified through simulation.
* Asynchronous set behavior was studied.
* Synchronous reset behavior was verified through simulation.
* Flip-flop designs were synthesized using Yosys.
* The synthesized designs were mapped to SKY130 standard cells.
* Constant multiplication operations were synthesized and optimized.
* Yosys generated optimized hardware representations from the RTL.
* Synthesized Verilog netlists were generated and examined.

---

# 4. Conclusion

Day 3 provided practical experience with different flip-flop coding styles, RTL synthesis, and hardware optimization. The flip-flop designs were simulated and synthesized using Yosys, while multiplication operations were optimized during synthesis.

The simulation waveforms, synthesized circuits, and generated netlists helped in understanding how RTL code is transformed into an optimized gate-level hardware representation.
