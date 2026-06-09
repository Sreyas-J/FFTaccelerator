`timescale 1ns / 1ps


module commutator8#(
    parameter TOTAL_WIDTH=18
)(
    input wire clk,
    input wire [TOTAL_WIDTH*4-1:0] in,
    input wire we,
    
    output reg [TOTAL_WIDTH*4-1:0] out
    );
    
    
endmodule
