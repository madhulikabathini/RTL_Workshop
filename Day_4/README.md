# Day 4 – RTL Optimization and Synthesis

## Overview

Day 4 is focused on learning how synthesis tools optimize RTL designs and transform them into efficient gate-level hardware implementations.

The experiments in this session include basic logic optimization, constant propagation, optimization of D flip-flops, sequential logic optimization, and counter optimization.

Yosys is used for synthesis, and the synthesized circuits are analyzed to understand how RTL descriptions are converted into hardware structures.

---

## Table of Contents

* [Objective](#objective)
* [1. RTL Optimization](#1-rtl-optimization)
* [2. Logic Optimization](#2-logic-optimization)

  * [AND Logic](#and-logic)
  * [OR Logic](#or-logic)
  * [Three-Input AND Logic](#three-input-and-logic)
* [3. Constant Propagation](#3-constant-propagation)
* [4. D Flip-Flop Optimization](#4-d-flip-flop-optimization)

  * [DFF Constant 1](#dff-constant-1)
  * [DFF Constant 2](#dff-constant-2)
  * [DFF Constant 3](#dff-constant-3)
* [5. Counter Optimization](#5-counter-optimization)
* [6. Importance of Optimization](#6-importance-of-optimization)
* [Key Observations](#key-observations)
* [Conclusion](#conclusion)

---

## Objective

The main objectives of this session are:

* To learn why RTL optimization is required during synthesis.
* To understand how synthesis tools simplify digital circuits.
* To observe how Boolean operations are converted into hardware cells.
* To study constant propagation in both combinational and sequential circuits.
* To understand how redundant and unnecessary hardware can be removed.
* To analyze the gate-level structure generated after synthesis.
* To study optimization techniques used for sequential circuits such as counters.
* To verify sequential circuit behavior using simulation waveforms.

---

# 1. RTL Optimization

RTL optimization refers to improving the hardware implementation of an RTL design while keeping its intended functionality unchanged.

RTL describes the required behavior of a circuit, but the same functionality can often be implemented using different hardware structures. During synthesis, the tool analyzes the RTL and selects a suitable implementation according to the target technology and standard-cell library.

Some common optimization operations performed by synthesis tools include:

* Boolean expression simplification
* Constant propagation
* Elimination of redundant logic
* Removal of unused signals
* Logic restructuring
* Technology mapping
* Sequential logic optimization

The main purpose of optimization is to create an efficient hardware implementation that still performs the required operation.

Optimization can influence several important design parameters, including:

* Area
* Power consumption
* Timing
* Number of standard cells
* Switching activity

Therefore, RTL optimization plays an important role between RTL design and the final physical implementation.

---

# 2. Logic Optimization

Logic optimization involves simplifying combinational logic while ensuring that the original logical function remains unchanged.

Boolean expressions may contain constants or unnecessary terms that can be simplified before the circuit is implemented as hardware.

Some basic Boolean rules used during optimization are:

**A AND 1 = A**

**A AND 0 = 0**

**A OR 0 = A**

**A OR 1 = 1**

These Boolean identities allow synthesis tools to reduce unnecessary logic.

After optimization, the resulting logic is mapped to suitable cells available in the selected technology library.

The following experiments demonstrate the synthesis of simple combinational circuits.

---

## AND Logic

The first experiment implements a basic AND operation.

An AND gate produces a HIGH output only when all its inputs are HIGH.

For a two-input AND gate:

**Y = A · B**

The truth table is:

| **A** | **B** | **Y** |
| ----- | ----- | ----- |
| 0     | 0     | 0     |
| 0     | 1     | 0     |
| 1     | 0     | 0     |
| 1     | 1     | 1     |

The RTL design is synthesized and mapped to an appropriate logic cell from the target technology library.
### Lab 1

Below is the Verilog code for Lab 1:

```verilog
module opt_check (input a , input b , output y);
    assign y = a?b:0;
endmodule
```

**Explanation:**

- `assign y = a ? b : 0;` uses a conditional (ternary) operator.
- When `a = 1`, the output `y` gets the value of `b`.
- When `a = 0`, the output `y` becomes `0`.

### Synthesis Command

Use the following command during the Yosys synthesis flow:

```text
opt_clean -purge
```

This command removes unnecessary and unused logic from the design.

### Synthesized Result
<img width="1173" height="605" alt="image" src="https://github.com/user-attachments/assets/d63cbe2f-ca93-499f-9d3d-f453ffdce507" />


The synthesized circuit represents the hardware structure generated from the RTL description.

This experiment demonstrates how a simple Boolean operation in RTL can be converted into a corresponding standard-cell implementation.

---

## OR Logic

The second experiment implements an OR operation.

An OR gate produces a HIGH output whenever at least one of its inputs is HIGH.

For a two-input OR gate:

**Y = A + B**

The truth table is:

| **A** | **B** | **Y** |
| ----- | ----- | ----- |
| 0     | 0     | 0     |
| 0     | 1     | 1     |
| 1     | 0     | 1     |
| 1     | 1     | 1     |

During synthesis, the Boolean function is processed and mapped to the appropriate hardware cell.
### Lab 2
### Verilog Code

```verilog
module opt_check2 (input a , input b , output y);
    assign y = a?1:b;
endmodule
```




### Synthesized Result
<img width="1177" height="608" alt="image" src="https://github.com/user-attachments/assets/27fc56ce-e548-43bb-9a3b-6a0a831e4b0f" />


The synthesized output illustrates how the OR operation described in RTL is represented at the hardware level.

---

## Three-Input AND Logic

The third experiment implements an AND operation using three inputs.

The Boolean expression is:

**Y = A · B · C**

The output becomes HIGH only when all three inputs are HIGH.

The truth table is:

| **A** | **B** | **C** | **Y** |
| ----- | ----- | ----- | ----- |
| 0     | 0     | 0     | 0     |
| 0     | 0     | 1     | 0     |
| 0     | 1     | 0     | 0     |
| 0     | 1     | 1     | 0     |
| 1     | 0     | 0     | 0     |
| 1     | 0     | 1     | 0     |
| 1     | 1     | 0     | 0     |
| 1     | 1     | 1     | 1     |

The synthesis tool analyzes the required function and selects an appropriate implementation from the target technology library.
## Lab 3

Verilog code:

```verilog
module opt_check2 (input a , input b , output y);
    assign y = a?1:b;
endmodule
```


### Synthesized Result
<img width="1177" height="606" alt="image" src="https://github.com/user-attachments/assets/8e0f844a-5209-4b48-a639-c5ba36622a03" />


This experiment demonstrates how a three-input Boolean function is represented in the synthesized hardware.
## Lab 4

Verilog code:

```verilog
module opt_check4 (input a , input b , input c , output y);
    assign y = a?(b?(a & c ):c):(!c);
endmodule
```
Functionality:  

Three inputs (a, b, c), output y.  

Nested ternary logic: If a = 1, y = c.  

If a = 0, y = !c.  

Logic simplifies to:  

y = a ? c : !c
<img width="1171" height="510" alt="image" src="https://github.com/user-attachments/assets/7bb92a2f-fd3e-4406-995b-8360f0905a5c" />



---

# 3. Constant Propagation
<img width="963" height="519" alt="image" src="https://github.com/user-attachments/assets/d08c670e-63c8-401e-9b61-ffaafa983501" />


Constant propagation is an optimization method where known constant values are carried through the logic of a circuit.

When a signal is permanently fixed at either 0 or 1, the synthesis tool can use this information to simplify the connected logic.

For example:

**A AND 0 = 0**

**A AND 1 = A**

**A OR 0 = A**

**A OR 1 = 1**

If an input of an AND gate is permanently 0, the output will always be 0, so the actual AND operation is unnecessary.

Likewise, if one input of an OR gate is permanently 1, the output will always remain 1.

Constant propagation can also be applied to sequential circuits when the synthesis tool determines that a stored value remains fixed.

This optimization can reduce the amount of hardware required in the final circuit.

---

# 4. D Flip-Flop Optimization

The next experiments focus on optimizing sequential logic.

A D flip-flop is a fundamental storage element used in synchronous digital systems.

The D input contains the data that needs to be stored, while the clock determines when the data is transferred to the output.

For a positive-edge-triggered D flip-flop:

**Q(next) = D**

The transfer takes place at the active clock edge.

When the D input is permanently connected to a known constant, the synthesis tool can determine the resulting behavior of the flip-flop.

For example:

**D = 0**

means that the stored value becomes 0 after the appropriate clock event.

Similarly:

**D = 1**

means that the stored value becomes 1.

The synthesis tool can use this known information to optimize the sequential circuit.

---

## DFF Constant 1

The first experiment studies a D flip-flop whose input is connected to a constant value.
## Lab 5

Verilog code:

```verilog
module dff_const1(input clk, input reset, output reg q);
    always @(posedge clk, posedge reset) begin
        if(reset)
            q <= 1'b0;
        else
            q <= 1'b1;
    end
endmodule
```

### Synthesized Circuit
<img width="1144" height="609" alt="image" src="https://github.com/user-attachments/assets/5c68a231-7248-4d81-862d-c03c9c1ba1e0" />


### Simulation Waveform
<img width="1145" height="606" alt="image" src="https://github.com/user-attachments/assets/92048cfa-d4dc-486e-bdf8-ad733e0b8eee" />


The synthesized diagram represents the sequential hardware obtained after optimization.

This experiment demonstrates the effect of applying a constant signal to the data input of a storage element.

---

## DFF Constant 2

The second experiment examines another case of constant input applied to a D flip-flop.

When the synthesis tool detects that a signal remains unchanged, it can propagate that constant value through the surrounding circuit.
## Lab 6

Verilog code:

```verilog
module dff_const2(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b1;
    else
        q <= 1'b1;
end
endmodule
```

### Synthesized Circuit
<img width="1143" height="468" alt="image" src="https://github.com/user-attachments/assets/f76ef4c4-ae7f-4dcc-9334-b4ce94f4d7f0" />


### Simulation Waveform
<img width="1331" height="695" alt="image" src="https://github.com/user-attachments/assets/a5437154-6185-4f78-aa79-59e709076a6f" />


The waveform shows the sequential circuit's response with respect to the clock and output signals.

Simulation is used to confirm the functional behavior of the synthesized circuit.

---

## DFF Constant 3

The third experiment continues the analysis of constant propagation in sequential logic.

The effect of known constant information on the synthesized structure can be observed in this experiment.

### Synthesized Circuit
<img width="1317" height="590" alt="image" src="https://github.com/user-attachments/assets/5ac28408-87ff-432c-800b-8e22034607d7" />


### Simulation Waveform
<img width="1146" height="604" alt="image" src="https://github.com/user-attachments/assets/816e63ff-bbfa-4178-82f5-0647c419e8c8" />


The simulation waveform helps confirm that the optimized circuit still operates as expected.

This experiment highlights the importance of examining both the synthesized structure and the corresponding simulation results.

---

# 5. Counter Optimization

A counter is a sequential circuit that moves through a predefined series of states.

A binary counter generally contains multiple flip-flops along with combinational logic responsible for generating the next state.

For an N-bit binary counter, the total number of possible states is:

**2^N**

For example, a 3-bit counter follows the sequence:

**000 → 001 → 010 → 011 → 100 → 101 → 110 → 111**

After reaching the final state, it returns to:

**000**

Counters are useful for studying sequential optimization because they contain both storage elements and next-state logic.

During synthesis, the tool analyzes the counter and generates an efficient hardware implementation while maintaining the required functionality.

### Original Counter
<img width="1318" height="535" alt="image" src="https://github.com/user-attachments/assets/1451614b-1c38-45ba-b41b-184943fb4383" />


The synthesized representation shows the hardware structure generated from the original counter RTL.

### Modified Counter
<img width="1326" height="534" alt="image" src="https://github.com/user-attachments/assets/be90267b-9a07-49a7-9fea-63e14160ca9d" />


The modified design allows comparison with the original synthesized implementation.

This comparison demonstrates that even a small modification in RTL code can change the resulting hardware structure.

---

# 6. Importance of Optimization

Optimization is important because the synthesized hardware directly affects the physical characteristics of the final chip.

### Area

Removing unnecessary logic reduces the number of standard cells required.

A smaller hardware implementation can also reduce the silicon area occupied by the circuit.

### Power

Logic elements consume dynamic power when their signals switch.

Reducing unnecessary logic and switching activity can therefore help lower power consumption.

### Timing

The type and number of cells present along a signal path influence propagation delay.

Optimization can help create shorter and more efficient critical paths.

### Hardware Efficiency

Optimization allows the required functionality to be achieved using fewer or more suitable hardware resources.

Therefore, optimization is an essential step toward developing an efficient VLSI implementation.

---

# Key Observations

The experiments performed during **Day 4** provide the following observations:

1. RTL Boolean expressions can be converted into suitable hardware cells during synthesis.
2. Different Boolean functions result in different synthesized hardware structures.
3. Boolean identities can simplify combinational logic.
4. Constant values can be propagated through sequential circuits.
5. Synthesis tools can eliminate unnecessary portions of a design.
6. The synthesized structure may differ from the original RTL while preserving the intended functionality.
7. Sequential circuits need special attention because their operation depends on clock events and stored states.
8. Counters contain both storage elements and combinational next-state logic.
9. Simulation waveforms are useful for checking the behavior of optimized sequential circuits.
10. Optimization can affect area, power, timing, and overall hardware efficiency.

---

# Conclusion

**Day 4** provided practical understanding of RTL optimization and synthesis.

The combinational logic experiments showed how basic Boolean operations are converted into hardware structures. The constant propagation experiments demonstrated how known values can be used to simplify circuits, while the D flip-flop experiments showed how optimization can be applied to sequential logic.

The counter experiment further illustrated optimization in a sequential design containing storage elements and next-state logic.

Overall, these experiments demonstrated that synthesis is more than simply converting RTL into gates. The synthesis tool analyzes the design, applies different optimization techniques, and generates an efficient hardware representation while preserving the intended functionality.
