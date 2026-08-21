# Day 6: Optimization in Synthesis

Welcome to Day 6 of the RTL Workshop! This session focuses on optimization techniques used during Verilog synthesis. The experiments cover `if-else` statements, `case` statements, `for` loops, generate blocks, and the conditions that can result in unintended latch inference. Practical labs are included to understand how different RTL coding styles are interpreted during synthesis.

---

## Contents

* [1. If-Else Statements in Verilog](#1-if-else-statements-in-verilog)
* [2. Inferred Latches in Verilog](#2-inferred-latches-in-verilog)
* [3. Labs for If-Else and Case Statements](#3-labs-for-if-else-and-case-statements)

  * [Lab 1: Incomplete If Statement](#lab-1-incomplete-if-statement)
  * [Lab 2: Synthesis Result of Lab 1](#lab-2-synthesis-result-of-lab-1)
  * [Lab 3: Nested If-Else](#lab-3-nested-if-else)
  * [Lab 4: Synthesis Result of Lab 3](#lab-4-synthesis-result-of-lab-3)
  * [Lab 5: Complete Case Statement](#lab-5-complete-case-statement)
  * [Lab 6: Synthesis Result of Lab 5](#lab-6-synthesis-result-of-lab-5)
  * [Lab 7: Incomplete Case Handling](#lab-7-incomplete-case-handling)
  * [Lab 8: Partial Assignments in Case](#lab-8-partial-assignments-in-case)
* [4. For Loops in Verilog](#4-for-loops-in-verilog)
* [5. Generate Blocks in Verilog](#5-generate-blocks-in-verilog)
* [6. What is an RCA (Ripple Carry Adder)?](#6-what-is-an-rca-ripple-carry-adder)
* [7. Labs on Loops and Generate Blocks](#7-labs-on-loops-and-generate-blocks)

  * [Lab 9: 4-to-1 MUX Using For Loop](#lab-9-4-to-1-mux-using-for-loop)
  * [Lab 10: 8-to-1 Demux Using Case](#lab-10-8-to-1-demux-using-case)
  * [Lab 11: 8-to-1 Demux Using For Loop](#lab-11-8-to-1-demux-using-for-loop)
  * [Lab 12: 8-bit Ripple Carry Adder with Generate Block](#lab-12-8-bit-ripple-carry-adder-with-generate-block)
* [Summary](#summary)

---

## 1. If-Else Statements in Verilog

An **if-else statement** is used to implement conditional behaviour in Verilog. It is generally written inside procedural blocks such as `always`, `initial`, tasks, or functions.

### Syntax

```verilog
if (condition) begin
    // Statements executed when condition is true
end else begin
    // Statements executed when condition is false
end
```

* **Condition:** An expression that evaluates to either true or false.
* **begin ... end:** Used to group multiple statements together.
* The `else` section is optional when no action is required for the false condition.

### Nested If-Else

Multiple conditions can be checked by using nested or chained `if-else` statements.

```verilog
if (condition1) begin
    // Statements for condition1
end else if (condition2) begin
    // Statements for condition2
end else begin
    // Statements when neither condition is true
end
```

Nested conditional statements are useful when different outputs are required for different input conditions.

---

## 2. Inferred Latches in Verilog

An **inferred latch** can occur when combinational logic does not assign an output value for every possible condition.

When an output is left unassigned for some input combinations, synthesis may create a latch so that the previous value is retained.

### Example of Latch Inference

```verilog
module ex (
    input wire a, b, sel,
    output reg y
);
    always @(a, b, sel) begin
        if (sel == 1'b1)
            y = a;
    end
endmodule
```

In this example, `y` receives a value only when `sel` is HIGH.

When `sel` is LOW, there is no assignment to `y`. Therefore, the synthesis tool can infer a latch.

### Solution: Add Else or Default Case

A default assignment or an `else` branch can be used to ensure that the output is assigned in every possible condition.

```verilog
module ex (
    input wire a, b, sel,
    output reg y
);
    always @(a, b, sel) begin
        case(sel)
            1'b1 : y = a;
            default : y = 1'b0;
        endcase
    end
endmodule
```

This ensures that `y` receives a defined value for every possible value of `sel`.

---

## 3. Labs for If-Else and Case Statements

### Lab 1: Incomplete If Statement

```verilog
module incomp_if (input i0, input i1, input i2, output reg y);
always @(*) begin
    if (i0)
        y <= i1;
end
endmodule
```

This example contains an incomplete `if` statement. Since there is no assignment to `y` when `i0` is LOW, latch inference can occur during synthesis.

**Lab 1 Result:**

<img width="1157" height="600" alt="image" src="https://github.com/user-attachments/assets/068c17a5-c245-4261-8c50-c439a5fe7916" />


---

### Lab 2: Synthesis Result of Lab 1

The synthesis result of Lab 1 demonstrates how the incomplete conditional assignment can lead to latch inference.

**Lab 2 Result:**

<img width="1158" height="606" alt="image" src="https://github.com/user-attachments/assets/100f0838-cce3-45d3-bb79-c75b06e5c898" />


---

### Lab 3: Nested If-Else

```verilog
module incomp_if2 (input i0, input i1, input i2, input i3, output reg y);
always @(*) begin
    if (i0)
        y <= i1;
    else if (i2)
        y <= i3;
end
endmodule
```

This experiment uses multiple conditional branches. Since there is no final `else` branch, some input combinations may leave `y` without an assignment, which can result in latch inference.

**Lab 3 Result:**

<img width="1685" height="895" alt="image" src="https://github.com/user-attachments/assets/39bc0a8c-831e-42c1-a9b6-4472e0d7e01b" />

---

### Lab 4: Synthesis Result of Lab 3

The synthesis output illustrates the hardware inferred from the nested conditional logic.

**Lab 4 Result:**

<img width="1144" height="604" alt="image" src="https://github.com/user-attachments/assets/b296d1f5-9b79-42ff-be1a-5e192cf4a1fc" />
<img width="1131" height="603" alt="image" src="https://github.com/user-attachments/assets/8e6d0bad-07e9-4505-b821-bff4a3c5c2e1" />
<img width="1143" height="603" alt="image" src="https://github.com/user-attachments/assets/8c8ec155-706a-48fd-ad9c-1f29bb976657" />

---

### Lab 5: Complete Case Statement

```verilog
module comp_case (input i0, input i1, input i2, input [1:0] sel, output reg y);
always @(*) begin
    case(sel)
        2'b00 : y = i0;
        2'b01 : y = i1;
        default : y = i2;
    endcase
end
endmodule
```

The `case` statement provides different output selections based on the value of `sel`.

The `default` branch ensures that the output receives a value for the remaining selection combinations.

**Lab 5 Result:**

<img width="1145" height="610" alt="image" src="https://github.com/user-attachments/assets/2cc98b63-1236-4cae-b7b5-38921a6caed5" />



---

### Lab 6: Synthesis Result of Lab 5

The synthesis result shows the hardware generated from the complete `case` statement.

Because all possible selection conditions are covered, the combinational logic can be synthesized without requiring an unintended latch.

**Lab 6 Result:**

<img width="1138" height="601" alt="image" src="https://github.com/user-attachments/assets/18db359c-122c-4b04-9880-37230f18603b" />

---

### Lab 7: Incomplete Case Handling

```verilog
module bad_case (
    input i0, input i1, input i2, input i3,
    input [1:0] sel,
    output reg y
);
always @(*) begin
    case(sel)
        2'b00: y = i0;
        2'b01: y = i1;
        2'b10: y = i2;
        2'b1?: y = i3;
    endcase
end
endmodule
```

This experiment demonstrates the importance of carefully defining `case` conditions.

Wildcard expressions such as `?` must be used carefully because they can match multiple input combinations.

**Lab 7 Result:**

<img width="1148" height="608" alt="image" src="https://github.com/user-attachments/assets/447f9589-983c-4e37-957c-5656fdf91a6b" />

---

### Lab 8: Partial Assignments in Case

```verilog
module partial_case_assign (
    input i0, input i1, input i2,
    input [1:0] sel,
    output reg y, output reg x
);
always @(*) begin
    case(sel)
        2'b00: begin
            y = i0;
            x = i2;
        end
        2'b01: y = i1;
        default: begin
            x = i1;
            y = i2;
        end
    endcase
end
endmodule
```

In this example, both `y` and `x` are not assigned in every branch of the `case` statement.

This type of partial assignment can result in latch inference for the signal that is not assigned in a particular branch.

**Lab 8 Result:**

<img width="1530" height="758" alt="image" src="https://github.com/user-attachments/assets/84822196-e998-459e-bd90-924df66bd89a" />
<img width="1144" height="612" alt="image" src="https://github.com/user-attachments/assets/3b415c6c-06ff-434d-879d-a6c75dcb3352" />
<img width="1142" height="609" alt="image" src="https://github.com/user-attachments/assets/5a0d00b3-82ba-4b57-bf94-a1580ec2f3ee" />


> **Note:** The basic steps required to perform these labs are covered in Day 1 of the workshop.

---

## 4. For Loops in Verilog

A **for loop** is used inside procedural blocks to repeat a set of statements multiple times.

### Syntax

```verilog
for (initialization; condition; increment) begin
    // Statements to be repeated
end
```

A `for` loop can be synthesized when the number of iterations is known and fixed during compilation.

### Example: 4-to-1 MUX Using a For Loop

```verilog
module mux_4to1_for_loop (
    input wire [3:0] data,
    input wire [1:0] sel,
    output reg y
);
    integer i;
    always @(data, sel) begin
        y = 1'b0;
        for (i = 0; i < 4; i = i + 1) begin
            if (i == sel)
                y = data[i];
        end
    end
endmodule
```

The loop checks the selection value and assigns the corresponding input bit to the output.

---

## 5. Generate Blocks in Verilog

A **generate block** is used to create repeated hardware structures during elaboration or compile time.

Generate constructs are commonly combined with `for` loops and the `genvar` keyword.

### Example

```verilog
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : gen_loop
        and_gate and_inst (.a(in[i]), .b(in[i+1]), .y(out[i]));
    end
endgenerate
```

The generate loop creates multiple instances of the required hardware structure automatically.

---

## 6. What is an RCA (Ripple Carry Adder)?

An **RCA (Ripple Carry Adder)** is a binary addition circuit formed by connecting multiple full adders in sequence.

For an `n`-bit RCA, `n` full-adder stages are required. The carry generated by one stage is passed to the next stage.

The carry therefore propagates or "ripples" from the least significant bit toward the most significant bit.

---

## 7. Labs on Loops and Generate Blocks

### Lab 9: 4-to-1 MUX Using For Loop

```verilog
module mux_generate (
    input i0, input i1, input i2, input i3,
    input [1:0] sel,
    output reg y
);
wire [3:0] i_int;
assign i_int = {i3, i2, i1, i0};
integer k;
always @(*) begin
    for (k = 0; k < 4; k = k + 1) begin
        if (k == sel)
            y = i_int[k];
    end
end
endmodule
```

This implementation uses a loop to examine the selection value and choose the corresponding input.

**Lab 9 Result:**

<img width="1163" height="607" alt="image" src="https://github.com/user-attachments/assets/a4b31e4f-a32d-42ee-9522-e374265f6ccb" />


---

### Lab 10: 8-to-1 Demux Using Case

```verilog
module demux_case (
    output o0, output o1, output o2, output o3,
    output o4, output o5, output o6, output o7,
    input [2:0] sel,
    input i
);
reg [7:0] y_int;
assign {o7, o6, o5, o4, o3, o2, o1, o0} = y_int;
always @(*) begin
    y_int = 8'b0;
    case(sel)
        3'b000 : y_int[0] = i;
        3'b001 : y_int[1] = i;
        3'b010 : y_int[2] = i;
        3'b011 : y_int[3] = i;
        3'b100 : y_int[4] = i;
        3'b101 : y_int[5] = i;
        3'b110 : y_int[6] = i;
        3'b111 : y_int[7] = i;
    endcase
end
endmodule
```

The `case` statement routes the input to the output selected by the 3-bit `sel` signal. All other outputs remain LOW.

**Lab 10 Result:**

<img width="1690" height="896" alt="image" src="https://github.com/user-attachments/assets/5b43d8dc-6700-41d8-bd03-abe5101c61b1" />


---

### Lab 11: 8-to-1 Demux Using For Loop

```verilog
module demux_generate (
    output o0, output o1, output o2, output o3,
    output o4, output o5, output o6, output o7,
    input [2:0] sel,
    input i
);
reg [7:0] y_int;
assign {o7, o6, o5, o4, o3, o2, o1, o0} = y_int;
integer k;
always @(*) begin
    y_int = 8'b0;
    for (k = 0; k < 8; k = k + 1) begin
        if (k == sel)
            y_int[k] = i;
    end
end
endmodule
```

This version implements the demultiplexer using a `for` loop instead of explicitly listing every selection condition.

**Lab 11 Result:**
<img width="1134" height="609" alt="image" src="https://github.com/user-attachments/assets/ab443a65-a98a-478c-b963-54a1aa34ad2e" />



---

### Lab 12: 8-bit Ripple Carry Adder with Generate Block

```verilog
module rca (
    input [7:0] num1,
    input [7:0] num2,
    output [8:0] sum
);
wire [7:0] int_sum;
wire [7:0] int_co;

genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin
        fa u_fa_1 (.a(num1[i]), .b(num2[i]), .c(int_co[i-1]), .co(int_co[i]), .sum(int_sum[i]));
    end
endgenerate

fa u_fa_0 (.a(num1[0]), .b(num2[0]), .c(1'b0), .co(int_co[0]), .sum(int_sum[0]));

assign sum[7:0] = int_sum;
assign sum[8] = int_co[7];
endmodule
```

### Full Adder Module

```verilog
module fa (input a, input b, input c, output co, output sum);
    assign {co, sum} = a + b + c;
endmodule
```

The generate block is used to instantiate the required full-adder stages for the 8-bit ripple carry adder.

Each full adder receives the carry output from the previous stage, allowing the carry to propagate through the complete adder chain.

**Lab 12 Result:**

<img width="1148" height="606" alt="image" src="https://github.com/user-attachments/assets/0633f909-ae9b-487a-8209-14bc4df6d9c7" />


> **Note:** The basic procedure for running the above labs is already covered in Day 1.

---

## Summary

* Complete `if-else` and `case` constructs help prevent unintended latch inference.
* Every output in combinational logic should be assigned for all possible execution conditions.
* `for` loops provide a convenient way to describe repeated and scalable hardware structures.
* Generate blocks are useful for creating multiple hardware instances during elaboration.
* Ripple Carry Adders can be constructed by connecting multiple full-adder modules.
* Practical synthesis experiments help demonstrate how different Verilog coding styles are converted into hardware.
* The labs provided hands-on understanding of conditional statements, loops, generate constructs and synthesis behaviour.
