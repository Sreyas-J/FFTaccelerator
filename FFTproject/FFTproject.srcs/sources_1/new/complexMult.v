`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2026 04:02:05 PM
// Design Name: 
// Module Name: complexMult
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


module complexMult# (
    parameter INT_WIDTH  = 3,  // Number of integer bits (including sign bit)
    parameter FRAC_WIDTH = 15  // Number of fractional bits
)(
        input wire clk,
        input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] a_r,b_r,a_i,b_i,
        input wire val,
        
        output reg signed [INT_WIDTH+FRAC_WIDTH-3:0] prod_r,prod_i,
        output reg done
    );
    
    localparam TOTAL_WIDTH =INT_WIDTH+FRAC_WIDTH;
    
    wire mulVal,addVal,mulDone,addDone;
    
    wire signed [TOTAL_WIDTH-1:0] PRErr,PREri,PREir,PREii;
    wire signed [TOTAL_WIDTH-3:0] rr,ri,ir,ii;
    wire signed [TOTAL_WIDTH-2:0] preProd_r,preProd_i;
    
    
    assign addVal=mulDone;
    assign mulVal=val;
    
    assign rr = PRErr[TOTAL_WIDTH-1 : 2];
    assign ri = PREri[TOTAL_WIDTH-1 : 2];
    assign ir = PREir[TOTAL_WIDTH-1 : 2];
    assign ii = PREii[TOTAL_WIDTH-1 : 2];
    
    always@(posedge clk)begin
        prod_r<=preProd_r[TOTAL_WIDTH-3:0];
        prod_i<=preProd_i[TOTAL_WIDTH-3:0];
        
        done<=addDone;
    end
    
    // RR    
    fixed_point_multiplier #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) mulRR (
        .clk(clk),
        .a(a_r),
        .b(b_r),
        .val(mulVal),
        .done(mulDone),
        .prod(PRErr)
    );
    
    // RI
    
    fixed_point_multiplier #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) mulRI (
        .clk(clk),
        .a(a_r),
        .b(b_i),
        .val(mulVal),
        .done(),
        .prod(PREri)
    );
    
    //IR
    
    fixed_point_multiplier #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) mulIR (
        .clk(clk),
        .a(a_i),
        .b(b_r),
        .val(mulVal),
        .done(),
        .prod(PREir)
    );
    
    //II
    
    fixed_point_multiplier #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) mulII (
        .clk(clk),
        .a(a_i),
        .b(b_i),
        .val(mulVal),
        .done(),
        .prod(PREii)
    );
    
    // REAL 
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH-2),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addR (
        .a(rr),
        .b(-ii),
        .val(addVal),
        .sum(preProd_r),
        .done(addDone)
    );
    
    //IMAG 
    
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH-2),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addI (
        .a(ri),
        .b(ir),
        .val(addVal),
        .sum(preProd_i),
        .done()
    );
    
endmodule
