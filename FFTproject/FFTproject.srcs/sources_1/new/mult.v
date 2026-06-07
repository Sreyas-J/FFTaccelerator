`timescale 1ns / 1ps
// 1 DELAY
module fixed_point_multiplier #(
    parameter INT_WIDTH  = 1,  // Number of integer bits (including sign bit)
    parameter FRAC_WIDTH = 15  // Number of fractional bits
)(
    input wire clk,
    input  wire signed [INT_WIDTH + FRAC_WIDTH - 1 : 0] a,
    input  wire signed [INT_WIDTH + FRAC_WIDTH - 1 : 0] b,
    input wire val,
    
    // Output is kept at the same width as the inputs for pipeline consistency
    output reg done,
    output reg signed [INT_WIDTH + FRAC_WIDTH - 1 : 0] prod
);

    // Calculate total input width
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH;
    
    // Define the dynamic Min and Max saturation values for any width
    // MIN_VAL = 1000...000 (e.g., 0x8000 for 16-bit)
    // MAX_VAL = 0111...111 (e.g., 0x7FFF for 16-bit)
    localparam [TOTAL_WIDTH-1:0] MIN_VAL = {1'b1, {(TOTAL_WIDTH-1){1'b0}}};
    localparam [TOTAL_WIDTH-1:0] MAX_VAL = {1'b0, {(TOTAL_WIDTH-1){1'b1}}};
    
    // The raw product of two N-bit numbers requires 2N bits to prevent overflow
    wire signed [2*TOTAL_WIDTH - 1 : 0] full_product;
    wire signed [TOTAL_WIDTH - 1 : 0] truncated_product;

    // Perform the full-precision signed multiplication.
    assign full_product = a * b;

    // ---------------------------------------------------------
    // Radix Point Realignment
    // ---------------------------------------------------------
    assign truncated_product = full_product[TOTAL_WIDTH + FRAC_WIDTH - 1 : FRAC_WIDTH];

    // ---------------------------------------------------------
    // Saturation Logic for the -1.0 * -1.0 Edge Case
    // ---------------------------------------------------------
    // If both inputs are exactly the minimum negative value, clamp the output 
    // to the maximum positive value. Otherwise, pass the truncated product.
    always@(posedge clk)begin
        if(val)begin
            prod <= (a == MIN_VAL && b == MIN_VAL) ? MAX_VAL : truncated_product;
            done<=1'b1;
        end
        else done<=1'b0;
    end

endmodule