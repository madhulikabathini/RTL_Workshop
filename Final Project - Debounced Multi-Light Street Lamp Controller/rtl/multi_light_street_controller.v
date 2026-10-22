// Debounced Multi-Light Street Lamp Controller
// One registered control bit drives all four streetlight outputs.
// The lamps change state only after 'dark' has differed from the
// current lamp state for N consecutive clock edges (sensor debounce).

module multi_light_street_controller #(
    parameter N = 4                 // stable cycles required before switching
) (
    input  wire       clk,          // clock
    input  wire       reset,        // active-high reset (asynchronous)
    input  wire       dark,         // 1 = night, 0 = day (raw sensor)
    output wire [3:0] lights        // four streetlight outputs
);

    reg       light_on;             // lamp state flip-flop
    reg [3:0] count;                // consecutive-difference counter

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            light_on <= 1'b0;
            count    <= 4'd0;
        end else begin
            if (dark == light_on) begin
                count <= 4'd0;                  // no change requested / glitch ended
            end else if (count == N-1) begin
                light_on <= dark;               // stable long enough: switch
                count    <= 4'd0;
            end else begin
                count <= count + 4'd1;          // still counting
            end
        end
    end

    // One control bit drives all four lamps, so they can never disagree.
    assign lights = {4{light_on}};

endmodule
