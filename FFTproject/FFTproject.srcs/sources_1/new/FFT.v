`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2026 06:40:59 PM
// Design Name: 
// Module Name: FFT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FFT #(
    parameter INT_WIDTH=1,
    parameter FRAC_WIDTH=15,
    parameter M=7
)(
    input wire clk,
    input wire val,
    input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] in0,in1,in2,in3,
    
    output reg signed [INT_WIDTH+FRAC_WIDTH-1:0] out0,out1,out2,out3,
    output reg done
    );
    
    localparam TOTAL_WIDTH=INT_WIDTH+FRAC_WIDTH;
endmodule
