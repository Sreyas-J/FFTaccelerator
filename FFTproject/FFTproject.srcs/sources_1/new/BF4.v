`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2026 03:14:33 PM
// Design Name: 
// Module Name: BF4
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


module BF4 # (
    parameter INT_WIDTH  = 1,  // Number of integer bits (including sign bit)
    parameter FRAC_WIDTH = 15  // Number of fractional bits
)(
        input wire clk,
        input wire [(INT_WIDTH+FRAC_WIDTH)*2-1:0] a,b,c,d,w1,w2,w3,
        input wire val,
        
        output reg [(INT_WIDTH+FRAC_WIDTH)*2-1:0] A,B,C,D,
        output reg done
    );
    
    localparam TOTAL_WIDTH = INT_WIDTH+FRAC_WIDTH;
    
    wire sVal,preVal;
    reg sDone,preDone;
    reg [TOTAL_WIDTH*2+1:0] s0,s1,s2,s3;
    reg [TOTAL_WIDTH*2+3:0] A_pre,B_pre,C_pre,D_pre;
    
    assign s0Val=val;
    assign preVal=sDone;
    
    //s0_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds0r (
        .a(a[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .b(b[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .val(sVal),
        .done(),
        .sum(s0[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1])
    );
    
    // s0_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds0i (
        .a(a[TOTAL_WIDTH-1:0]),
        .b(b[TOTAL_WIDTH-1:0]),
        .val(sVal),
        .done(sDone),
        .sum(s0[TOTAL_WIDTH:0])
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s1_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds1r (
        .a(a[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .b({~c[TOTAL_WIDTH*2-1],c[TOTAL_WIDTH*2-2:TOTAL_WIDTH]}),
        .val(sVal),
        .done(),
        .sum(s1[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1])
    );
    
    // s1_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds1i (
        .a(a[TOTAL_WIDTH-1:0]),
        .b({~c[TOTAL_WIDTH-1],c[TOTAL_WIDTH-2:0]}),
        .val(sVal),
        .done(),
        .sum(s1[TOTAL_WIDTH:0])
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s2_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds2r (
        .a(b[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .b(d[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .val(sVal),
        .done(),
        .sum(s2[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1])
    );
    
    // s2_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds2i (
        .a(b[TOTAL_WIDTH-1:0]),
        .b(d[TOTAL_WIDTH-1:0]),
        .val(sVal),
        .done(),
        .sum(s2[TOTAL_WIDTH:0])
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s3_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds3r (
        .a(b[TOTAL_WIDTH*2-1:TOTAL_WIDTH]),
        .b({~d[TOTAL_WIDTH*2-1],d[TOTAL_WIDTH*2-2:TOTAL_WIDTH]}),
        .val(sVal),
        .done(),
        .sum(s3[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1])
    );
    
    // s3_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds3i (
        .a(b[TOTAL_WIDTH-1:0]),
        .b({~d[TOTAL_WIDTH-1],d[TOTAL_WIDTH-2:0]}),
        .val(sVal),
        .done(),
        .sum(s3[TOTAL_WIDTH:0])
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Apre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addAp_r (
        .a(s0[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1]),
        .b(s2[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1]),
        .val(preVal),
        .done(preDone),
        .sum(A_pre[TOTAL_WIDTH*2+3:TOTAL_WIDTH+2])
    );
    
    // Apre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addAp_i (
        .a(s0[TOTAL_WIDTH:0]),
        .b(s2[TOTAL_WIDTH:0]),
        .val(preVal),
        .done(),
        .sum(A_pre[TOTAL_WIDTH+1:0])
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Bpre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addBp_r (
        .a(s1[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1]),
        .b({~s3[TOTAL_WIDTH],s3[TOTAL_WIDTH-1:0]}),
        .val(preVal),
        .done(preDone),
        .sum(A_pre[TOTAL_WIDTH*2+3:TOTAL_WIDTH+2])
    );
    
    // Apre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addBp_i (
        .a(s0[TOTAL_WIDTH:0]),
        .b(s2[TOTAL_WIDTH*2+1:TOTAL_WIDTH+1]),
        .val(preVal),
        .done(),
        .sum(A_pre[TOTAL_WIDTH+1:0])
    );
    
    
    
endmodule
