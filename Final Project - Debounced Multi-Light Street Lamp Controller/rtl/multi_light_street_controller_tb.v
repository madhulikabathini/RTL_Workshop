`timescale 1ns/1ps

module multi_light_street_controller_tb;

reg clk = 1'b0;
reg reset;
reg dark;
wire [3:0] lights;

integer errors = 0;
integer checks = 0;

multi_light_street_controller #(.N(4)) uut (
    .clk(clk),
    .reset(reset),
    .dark(dark),
    .lights(lights)
);

// 5 ns clock period = 200 MHz
always #2.5 clk = ~clk;

// Apply one input value, wait for the next rising edge, then settle 1 ns
task step(input d);
begin
    dark = d;
    @(posedge clk);
    #1;
end
endtask

task check(input [3:0] expected, input [8*48:1] name);
begin
    checks = checks + 1;
    if (lights !== expected) begin
        errors = errors + 1;
        $display("FAIL: %0s | time=%0t expected=%b got=%b", name, $time, expected, lights);
    end else begin
        $display("PASS: %0s | time=%0t lights=%b", name, $time, lights);
    end
end
endtask

initial begin
    $dumpfile("multi_light_street_controller.vcd");
    $dumpvars(0, multi_light_street_controller_tb);

    // A. Async reset at power-up with dark=1, held across clock edges
    reset = 1'b1;
    dark  = 1'b1;
    #1;
    check(4'b0000, "A1 async reset at power-up, dark=1");
    @(posedge clk);
    @(posedge clk);
    #1;
    check(4'b0000, "A2 reset held across clock edges");
    reset = 1'b0;

    // B. Day: lamps stay off
    step(1'b0); check(4'b0000, "B1 day after reset, lamps off");
    step(1'b0); check(4'b0000, "B2 day continues, lamps off");

    // C. One-cycle glitch is ignored
    step(1'b1); check(4'b0000, "C1 1-cycle glitch: no switch");
    step(1'b0); check(4'b0000, "C2 glitch ended: still off");

    // D. N-1 = 3 cycle pulse is ignored
    step(1'b1); check(4'b0000, "D1 pulse edge 1: off");
    step(1'b1); check(4'b0000, "D2 pulse edge 2: off");
    step(1'b1); check(4'b0000, "D3 pulse edge 3: off");
    step(1'b0); check(4'b0000, "D4 pulse ended after 3: still off");

    // E. Sustained night: lamps switch on exactly on the 4th edge
    step(1'b1); check(4'b0000, "E1 night edge 1: off");
    step(1'b1); check(4'b0000, "E2 night edge 2: off");
    step(1'b1); check(4'b0000, "E3 night edge 3: off");
    step(1'b1); check(4'b1111, "E4 night edge 4: all four ON");

    // F. Lamps stay on while dark persists
    step(1'b1); check(4'b1111, "F1 night continues: ON");
    step(1'b1); check(4'b1111, "F2 night continues: ON");

    // G. Day glitches while on are ignored
    step(1'b0); check(4'b1111, "G1 day edge 1 while on: still ON");
    step(1'b0); check(4'b1111, "G2 day edge 2 while on: still ON");
    step(1'b0); check(4'b1111, "G3 day edge 3 while on: still ON");
    step(1'b1); check(4'b1111, "G4 back to night: still ON");

    // H. Sustained day: lamps switch off exactly on the 4th edge
    step(1'b0); check(4'b1111, "H1 day edge 1: ON");
    step(1'b0); check(4'b1111, "H2 day edge 2: ON");
    step(1'b0); check(4'b1111, "H3 day edge 3: ON");
    step(1'b0); check(4'b0000, "H4 day edge 4: all four OFF");

    // I. Async reset in the middle of counting, counter must clear
    step(1'b1); check(4'b0000, "I1 counting edge 1: off");
    step(1'b1); check(4'b0000, "I2 counting edge 2: off");
    reset = 1'b1;
    #1;
    check(4'b0000, "I3 reset mid-count, no clock edge");
    @(posedge clk);
    #1;
    reset = 1'b0;
    step(1'b1); check(4'b0000, "I4 after reset edge 1: off");
    step(1'b1); check(4'b0000, "I5 after reset edge 2: off");
    step(1'b1); check(4'b0000, "I6 after reset edge 3: off (counter cleared)");
    step(1'b1); check(4'b1111, "I7 after reset edge 4: ON");

    // J. Async reset while lamps are on
    reset = 1'b1;
    #1;
    check(4'b0000, "J1 async reset clears lamps while ON");
    reset = 1'b0;
    dark  = 1'b0;

    // K. Reset has priority over dark
    reset = 1'b1;
    step(1'b1); check(4'b0000, "K1 reset priority edge 1");
    step(1'b1); check(4'b0000, "K2 reset priority edge 2");
    step(1'b1); check(4'b0000, "K3 reset priority edge 3");
    step(1'b1); check(4'b0000, "K4 reset priority edge 4");
    reset = 1'b0;
    step(1'b0);

    $display("--------------------------------------------");
    $display("Checks run: %0d | Errors: %0d", checks, errors);
    if (errors == 0)
        $display("RESULT: ALL TESTS PASSED");
    else
        $display("RESULT: TESTS FAILED");
    $display("--------------------------------------------");
    $finish;
end

// Safety timeout
initial begin
    #5000;
    $display("TIMEOUT");
    $finish;
end

endmodule
