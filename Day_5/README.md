# Day 5 - RTL Design, Synthesis and Gate-Level Simulation

## Overview

Day 5 of the VSD RTL Design Workshop continued the study of RTL design, synthesis and Gate-Level Simulation. The session focused on understanding how Verilog RTL code is converted into synthesized hardware and how the synthesized implementation can be verified using Gate-Level Simulation.

The experiments provided hands-on practice with Verilog coding, RTL simulation, Yosys synthesis, technology mapping, standard-cell based netlist generation and waveform analysis.

The main topics covered during this session were:

* Ternary operator based MUX
* RTL simulation
* Logic synthesis using Yosys
* Standard-cell technology mapping
* Gate-level netlist generation
* Gate-Level Simulation
* Incomplete sensitivity lists
* Blocking assignments
* RTL and Gate-Level waveform comparison
* Simulation-synthesis mismatch

## Table of Contents

1. [RTL to Gate-Level Simulation Flow](#1-rtl-to-gate-level-simulation-flow)
2. [Ternary Operator MUX](#2-ternary-operator-mux)

   * [Working Principle](#21-working-principle)
   * [RTL Simulation](#22-rtl-simulation)
   * [Synthesis](#23-synthesis)
   * [Gate-Level Simulation](#24-gate-level-simulation)
3. [Bad MUX - Incomplete Sensitivity List](#3-bad-mux---incomplete-sensitivity-list)

   * [Problem](#31-problem)
   * [RTL Simulation](#32-rtl-simulation)
   * [Synthesis and Gate-Level Simulation](#33-synthesis-and-gate-level-simulation)
   * [Correct Coding Style](#34-correct-coding-style)
4. [Blocking Assignment Caveat](#4-blocking-assignment-caveat)

   * [Blocking Assignment](#41-blocking-assignment)
   * [RTL Simulation](#42-rtl-simulation)
   * [Synthesis](#43-synthesis)
   * [Gate-Level Simulation](#44-gate-level-simulation)
5. [Blocking vs Non-Blocking Assignments](#5-blocking-vs-non-blocking-assignments)
6. [Importance of `always @(*)`](#6-importance-of-always-)
7. [Simulation-Synthesis Mismatch](#7-simulation-synthesis-mismatch)
8. [RTL Simulation vs Gate-Level Simulation](#8-rtl-simulation-vs-gate-level-simulation)
9. [Tools Used](#9-tools-used)
10. [Key Observations](#10-key-observations)
11. [Learning Outcomes](#11-learning-outcomes)
12. [Conclusion](#12-conclusion)

---

# 1. RTL to Gate-Level Simulation Flow

The Day 5 experiments followed the complete RTL-to-Gate-Level verification process:

```text
RTL Verilog Code
       |
       v
RTL Simulation
       |
       v
Yosys Synthesis
       |
       v
Technology Mapping
       |
       v
Gate-Level Netlist
       |
       v
Gate-Level Simulation
       |
       v
GTKWave
       |
       v
Waveform Analysis
```

RTL simulation is performed first to check whether the Verilog design produces the expected functionality. The RTL is then synthesized using Yosys and mapped to cells from the SKY130 standard-cell library. The resulting gate-level netlist can be simulated again to verify the behaviour of the synthesized hardware.

---

# 2. Ternary Operator MUX

## 2.1 Working Principle

A multiplexer is a combinational circuit that selects one of several input signals and passes the selected signal to its output.

For a 2:1 MUX:

```text
i0 --------\
            \
             >---- y
            /
i1 --------/
         |
        sel
```

The selection operation is:

```text
sel = 0  ->  y = i0
sel = 1  ->  y = i1
```

In Verilog, this behaviour can be expressed compactly using the ternary operator:

```verilog
assign y = sel ? i1 : i0;
```

The ternary operator makes the conditional selection operation easy to describe in RTL.

## 2.2 RTL Simulation

The MUX design was first tested through RTL simulation.

The important signals observed during simulation were:

```text
i0
i1
sel
y
```

When `sel` is LOW, the output follows `i0`.

When `sel` is HIGH, the output follows `i1`.

### RTL Waveform

<img width="1563" height="736" alt="image" src="https://github.com/user-attachments/assets/020fe83f-47cd-4015-9327-56df8fe61ec3" />


The RTL waveform verifies that the output changes according to the selected input.

## 2.3 Synthesis

After confirming the RTL functionality, the MUX was synthesized using Yosys.

During synthesis, the RTL description was transformed into a hardware implementation using cells available in the SKY130 standard-cell library.

The MUX was mapped to the following standard cell:

```text
sky130_fd_sc_hd__mux2_1
```

### Synthesized Netlist

<img width="1147" height="602" alt="image" src="https://github.com/user-attachments/assets/1e25ce89-3dc0-4d39-baf1-82885737b8ff" />


The synthesized netlist shows how the simple RTL description is converted into a standard-cell based hardware structure.

The RTL statement:

```verilog
assign y = sel ? i1 : i0;
```

is transformed by the synthesis tool into the corresponding library-cell implementation.

## 2.4 Gate-Level Simulation

The synthesized netlist was then used for Gate-Level Simulation.

The testbench applied different input combinations, and the resulting output behaviour was observed using GTKWave.

### Gate-Level Waveform

<img width="1491" height="758" alt="image" src="https://github.com/user-attachments/assets/a8ee4cc3-e1a7-484f-8043-6a5e37125011" />


The RTL and Gate-Level waveforms can be compared to confirm that the synthesized circuit maintains the intended MUX functionality.

The complete process can be summarized as:

```text
RTL MUX
   |
   v
Ternary Operator
   |
   v
Yosys Synthesis
   |
   v
sky130_fd_sc_hd__mux2_1
   |
   v
Gate-Level Simulation
```

---

# 3. Bad MUX - Incomplete Sensitivity List

## 3.1 Problem

A MUX can also be implemented using an `always` block.

An incorrect implementation is:

```verilog
always @(sel)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

The issue with this implementation is that only `sel` is present in the sensitivity list.

However, the output depends on `sel`, `i0` and `i1`.

Therefore, when `sel` changes, the block executes normally. But when either `i0` or `i1` changes while `sel` remains unchanged, the block may not be triggered.

This can cause the RTL simulation output to remain unchanged even though an input has changed.

## 3.2 RTL Simulation

The Bad MUX was simulated to demonstrate the effect of using an incomplete sensitivity list.

### RTL Waveform

<img width="1139" height="598" alt="image" src="https://github.com/user-attachments/assets/010d128b-a869-4006-b76e-6d59b1c5f34b" />


The waveform shows that changes in `i0` or `i1` may not immediately appear at the output if `sel` does not change.

This occurs because the simulator executes the `always` block only when a signal listed in its sensitivity list changes.

## 3.3 Synthesis and Gate-Level Simulation

The sensitivity list is mainly related to simulation behaviour and does not represent a physical hardware element.

During synthesis, Yosys examines the actual logic described inside the procedural block and determines the corresponding hardware.

As a result, an incomplete sensitivity list can create a difference between the behaviour seen in RTL simulation and the behaviour of the synthesized circuit.

### Gate-Level Waveform

<img width="981" height="509" alt="image" src="https://github.com/user-attachments/assets/e618d644-59dc-4232-bc62-893cb0b1ba55" />


The Gate-Level Simulation waveform can be compared with the RTL waveform to identify the difference between the simulated RTL behaviour and the synthesized hardware behaviour.

This experiment demonstrates how an incorrectly written sensitivity list can contribute to a simulation-synthesis mismatch.

## 3.4 Correct Coding Style

For combinational logic, the following coding style is preferred:

```verilog
always @(*)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

The `@(*)` construct automatically includes the signals referenced inside the procedural block in the sensitivity list.

Instead of manually writing:

```verilog
always @(sel)
```

the preferred form is:

```verilog
always @(*)
```

This helps ensure that changes in all relevant input signals cause the combinational block to execute.

---

# 4. Blocking Assignment Caveat

## 4.1 Blocking Assignment

Verilog commonly uses two procedural assignment operators:

```text
Blocking assignment       =
Non-blocking assignment   <=
```

A blocking assignment updates the left-hand side immediately during procedural execution.

For example:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

Here, the first statement is evaluated before the second statement.

Therefore, the updated value of `x` is available when the next statement executes.

This means that the order of statements can be important when blocking assignments are used.

## 4.2 RTL Simulation

The blocking assignment example was simulated at the RTL level.

The logic can be represented as:

```text
a ----\
       OR ---- x ----\
b ----/              AND ----> d
                     /
c ------------------/
```

### RTL Waveform

<img width="1145" height="586" alt="image" src="https://github.com/user-attachments/assets/db472b24-bb71-4bc6-bd5e-a450a2d70a3e" />


The waveform shows the behaviour of the intermediate signal and the final output during RTL simulation.

Because blocking assignments take effect immediately, the updated intermediate value can be used by the following statement.

## 4.3 Synthesis

The design was synthesized using Yosys.

The RTL was converted into logic using cells from the SKY130 standard-cell library.

The synthesized logic includes:

```text
sky130_fd_sc_hd__o21a_1
```

### Synthesized Netlist

<img width="1135" height="601" alt="image" src="https://github.com/user-attachments/assets/720ae5b2-0a56-46aa-b657-06dcfb9ae628" />


The synthesized netlist illustrates how the procedural RTL statements are converted into connections between standard cells.

## 4.4 Gate-Level Simulation

The synthesized netlist was subsequently simulated at the gate level.

### Gate-Level Waveform
<img width="1142" height="611" alt="image" src="https://github.com/user-attachments/assets/737470e3-d09a-48f7-a18f-82147cb27aee" />




The Gate-Level Simulation waveform represents the operation of the synthesized circuit.

By comparing the RTL and GLS waveforms, the relationship between procedural RTL execution and the resulting hardware implementation can be understood more clearly.

The main concept is:

```text
Blocking Assignment
        |
        v
Sequential RTL Execution
        |
        v
Intermediate Value Updated
        |
        v
Next Statement Uses Updated Value
```

This experiment highlights why the order of blocking assignments should be considered carefully when writing combinational RTL.

---

# 5. Blocking vs Non-Blocking Assignments

## Blocking Assignment

The blocking assignment operator is:

```verilog
=
```

Example:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

The statements execute in sequence, and the new value of `x` is available immediately to the next statement.

Blocking assignments are commonly used when describing combinational procedural logic.

## Non-Blocking Assignment

The non-blocking assignment operator is:

```verilog
<=
```

Example:

```verilog
always @(posedge clk)
begin
    q <= d;
end
```

Non-blocking assignments schedule the update for later in the current simulation time step.

They are commonly used for sequential logic such as registers and flip-flops.

| **Blocking `=`**                               | **Non-Blocking `<=`**                              |
| ---------------------------------------------- | -------------------------------------------------- |
| Updates immediately                            | Update is scheduled                                |
| Statements execute in sequence                 | Updates occur after evaluation                     |
| Commonly used for combinational logic          | Commonly used for sequential logic                 |
| Statement order can affect intermediate values | Useful for modelling simultaneous register updates |

---

# 6. Importance of `always @(*)`

When combinational logic is implemented using an `always` block, every signal that can influence the output should be considered in the sensitivity list.

For example, the following incomplete sensitivity list:

```verilog
always @(sel)
```

can cause incorrect RTL simulation behaviour.

A safer approach is:

```verilog
always @(*)
```

For example:

```verilog
always @(*)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

Using `always @(*)` allows changes in `sel`, `i0` and `i1` to trigger the block.

Therefore, using the complete sensitivity mechanism reduces the possibility of simulation-synthesis mismatches caused by missing input signals.

---

# 7. Simulation-Synthesis Mismatch

A simulation-synthesis mismatch occurs when the behaviour observed during RTL simulation does not match the behaviour represented by the synthesized hardware.

The Day 5 experiments demonstrated this concept using the Bad MUX example and the blocking assignment experiment.

### Incomplete Sensitivity List

```verilog
always @(sel)
```

The RTL simulator responds only when `sel` changes, even though `i0` and `i1` also influence the output.

The synthesizer, however, determines the hardware from the logic relationship described by the RTL.

### Blocking Assignment

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

Blocking assignments execute sequentially during RTL simulation.

Therefore, the order of statements can influence the intermediate values observed during simulation.

The overall process can be represented as:

```text
RTL Coding Issue
       |
       v
Unexpected RTL Behaviour
       |
       v
    Synthesis
       |
       v
Hardware Implementation
       |
       v
RTL vs GLS Comparison
```

This highlights the importance of using proper RTL coding practices to ensure predictable simulation and synthesis results.

---

# 8. RTL Simulation vs Gate-Level Simulation

| **Feature**     | **RTL Simulation**      | **Gate-Level Simulation**        |
| --------------- | ----------------------- | -------------------------------- |
| Input           | RTL Verilog             | Synthesized netlist              |
| Stage           | Before synthesis        | After synthesis                  |
| Main purpose    | Functional verification | Post-synthesis verification      |
| Representation  | RTL description         | Standard-cell implementation     |
| Timing          | Mainly functional       | Can include cell and gate delays |
| Simulator       | Icarus Verilog          | Icarus Verilog                   |
| Waveform viewer | GTKWave                 | GTKWave                          |

RTL simulation is mainly used to verify the intended functionality of the Verilog design.

Gate-Level Simulation is performed after synthesis to check the behaviour of the generated hardware implementation.

Comparing the two waveforms provides useful information about whether the synthesized circuit preserves the intended functionality of the original RTL.

---

# 9. Tools Used

| **Tool**       | **Purpose**                                  |
| -------------- | -------------------------------------------- |
| Yosys          | RTL synthesis and netlist generation         |
| Icarus Verilog | Verilog compilation and simulation           |
| GTKWave        | Waveform visualization and analysis          |
| SKY130 PDK     | Standard-cell library for technology mapping |

---

# 10. Key Observations

### Ternary Operator MUX

```text
RTL Description
      |
      v
assign y = sel ? i1 : i0;
      |
      v
Yosys Synthesis
      |
      v
sky130_fd_sc_hd__mux2_1
      |
      v
Gate-Level Simulation
```

The ternary operator offers a concise method for describing the selection logic of a 2:1 MUX.

### Bad MUX

```verilog
always @(sel)
```

The sensitivity list does not contain every input signal that can affect the output.

The recommended combinational form is:

```verilog
always @(*)
```

### Blocking Assignment

```verilog
x = a | b;
d = x & c;
```

Blocking assignments execute in procedural order during RTL simulation.

Consequently, the sequence of statements can influence intermediate signal values.

### Gate-Level Simulation

```text
RTL
 |
 v
Synthesis
 |
 v
Gate-Level Netlist
 |
 v
Gate-Level Simulation
 |
 v
Waveform Analysis
```

Gate-Level Simulation provides an additional verification stage after synthesis.

---

# 11. Learning Outcomes

After completing Day 5, I developed an understanding of:

* The RTL-to-Gate-Level Simulation process
* Designing a MUX using the ternary operator
* RTL simulation and functional verification
* Logic synthesis using Yosys
* Standard-cell technology mapping
* Generation of gate-level netlists
* Gate-Level Simulation
* Waveform analysis using GTKWave
* Sensitivity lists in Verilog
* The purpose of `always @(*)`
* Blocking and non-blocking assignments
* Simulation-synthesis mismatches
* Good coding practices for combinational RTL
* Differences between RTL simulation and synthesized hardware behaviour

The experiments helped connect the theoretical concepts of RTL design and synthesis with the actual results observed through waveforms and synthesized netlists.

---

# 12. Conclusion

Day 5 provided practical experience with the complete process of converting RTL code into synthesized hardware and verifying the resulting implementation through Gate-Level Simulation.

The ternary MUX experiment demonstrated how a simple Verilog statement can be synthesized into a standard-cell implementation. The Bad MUX experiment highlighted the problems caused by an incomplete sensitivity list and showed how RTL simulation can differ from synthesized hardware behaviour. The blocking assignment experiment demonstrated the importance of statement ordering during procedural RTL simulation.

By studying RTL waveforms, synthesized netlists and Gate-Level Simulation waveforms, I gained a better understanding of how Verilog descriptions are transformed into actual hardware structures.

The session also provided hands-on experience with Yosys, Icarus Verilog, GTKWave and the SKY130 standard-cell library. Overall, Day 5 strengthened my understanding of RTL coding, synthesis, technology mapping and post-synthesis verification, while emphasizing the importance of writing accurate and synthesizable RTL code.
