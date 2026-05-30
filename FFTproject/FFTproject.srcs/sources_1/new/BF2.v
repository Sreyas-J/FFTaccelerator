`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2026 06:24:02 PM
// Design Name: 
// Module Name: BF2
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


module BF2 #(
    parameter INT_WIDTH = 1,
    parameter FRAC_WIDTH =15
)(
        input wire clk,
        input wire val,
        input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] a_r,b_r,a_i,b_i,
        
        output reg signed [INT_WIDTH+FRAC_WIDTH-1:0] Areg_r,Breg_r,Areg_i,Breg_i,
        output reg doneReg
    );
    
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH;
    
    wire signed [TOTAL_WIDTH:0] A_r,A_i,B_r,B_i;
    wire done;
    
    always@(posedge clk)begin
        Areg_r<=A_r[TOTAL_WIDTH:1];
        Breg_r<=B_r[TOTAL_WIDTH:1];
        Areg_i<=A_i[TOTAL_WIDTH:1];
        Breg_i<=B_i[TOTAL_WIDTH:1];
        
        doneReg<=done;
    end
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) s0r (
        .a(a_r),
        .b(b_r),
        .val(val),
        .sum(A_r),
        .done(done)
    );
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) s0i (
        .a(a_i),
        .b(b_i),
        .val(val),
        .sum(A_i),
        .done()
    );
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) s1r (
        .a(a_r),
        .b(-b_r),
        .val(val),
        .sum(B_r),
        .done()
    );
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) s1i (
        .a(a_i),
        .b(-b_i),
        .val(val),
        .sum(B_i),
        .done()
    );

endmodule
