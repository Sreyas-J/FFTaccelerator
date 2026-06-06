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
    parameter FRAC_WIDTH = 17  // Number of fractional bits
)(
        input wire clk,
        input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] a_r,b_r,c_r,d_r,a_i,b_i,c_i,d_i,
        input wire signed [INT_WIDTH+FRAC_WIDTH+1:0] w1_r,w2_r,w3_r,w1_i,w2_i,w3_i,
        input wire val,
        
        output reg signed [INT_WIDTH+FRAC_WIDTH-1:0] A_r, A_i,
        output wire signed [INT_WIDTH+FRAC_WIDTH-1:0] B_r, C_r, D_r, B_i, C_i, D_i,
        output wire done
    );
    
    localparam TOTAL_WIDTH = INT_WIDTH+FRAC_WIDTH;
    
    wire sVal,preVal;
    reg cMulVal;
    wire sDone,preDone;
    wire signed [TOTAL_WIDTH:0] s0_r,s1_r,s2_r,s3_r,s0_i,s1_i,s2_i,s3_i;
    wire signed [TOTAL_WIDTH+1:0] Apre_r,Bpre_r,Cpre_r,Dpre_r,Apre_i,Bpre_i,Cpre_i,Dpre_i;
    reg signed [TOTAL_WIDTH+1:0] ApreReg_r,BpreReg_r,CpreReg_r,DpreReg_r,ApreReg_i,BpreReg_i,CpreReg_i,DpreReg_i;
    reg signed [TOTAL_WIDTH-1:0] Aprev_r,Aprev_i;
    
    assign sVal=val;
    assign preVal=sDone;
    
    always@(posedge clk)begin
        cMulVal<=preDone;
    end
    
    always@(posedge clk)begin
        ApreReg_r<=Apre_r;
        BpreReg_r<=Bpre_r;
        CpreReg_r<=Cpre_r;
        DpreReg_r<=Dpre_r;
        
        ApreReg_i<=Apre_i;
        BpreReg_i<=Bpre_i;
        CpreReg_i<=Cpre_i;
        DpreReg_i<=Dpre_i;
    end
    
    //s0_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds0r (
        .a(a_r),
        .b(b_r),
        .val(sVal),
        .done(),
        .sum(s0_r)
    );
    
    // s0_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds0i (
        .a(a_i),
        .b(b_i),
        .val(sVal),
        .done(sDone),
        .sum(s0_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s1_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds1r (
        .a(a_r),
        .b(-c_r),
        .val(sVal),
        .done(),
        .sum(s1_r)
    );
    
    // s1_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds1i (
        .a(a_i),
        .b(-c_i),
        .val(sVal),
        .done(),
        .sum(s1_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s2_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds2r (
        .a(b_r),
        .b(d_r),
        .val(sVal),
        .done(),
        .sum(s2_r)
    );
    
    // s2_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds2i (
        .a(b_i),
        .b(d_i),
        .val(sVal),
        .done(),
        .sum(s2_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //s3_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds3r (
        .a(b_r),
        .b(-d_r),
        .val(sVal),
        .done(),
        .sum(s3_r)
    );
    
    // s3_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) adds3i (
        .a(b_i),
        .b(d_i),
        .val(sVal),
        .done(),
        .sum(s3_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Apre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addAp_r (
        .a(s0_r),
        .b(s2_r),
        .val(preVal),
        .done(preDone),
        .sum(Apre_r)
    );
    
    // Apre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addAp_i (
        .a(s0_i),
        .b(s2_i),
        .val(preVal),
        .done(),
        .sum(Apre_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Bpre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addBp_r (
        .a(s1_r),
        .b(s3_i),
        .val(preVal),
        .done(),
        .sum(Bpre_r)
    );
    
    // Bpre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addBp_i (
        .a(s1_i),
        .b(-s3_r),
        .val(preVal),
        .done(),
        .sum(Bpre_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Cpre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addCp_r (
        .a(s0_r),
        .b(-s2_r),
        .val(preVal),
        .done(),
        .sum(Cpre_r)
    );
    
    // Cpre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addCp_i (
        .a(s0_i),
        .b(-s2_i),
        .val(preVal),
        .done(),
        .sum(Cpre_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Dpre_r
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addDp_r (
        .a(s1_r),
        .b(-s3_i),
        .val(preVal),
        .done(),
        .sum(Dpre_r)
    );
    
    // Cpre_i
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH+1),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) addDp_i (
        .a(s1_i),
        .b(s3_r),
        .val(preVal),
        .done(),
        .sum(Dpre_i)
    );
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // A
    always@(posedge clk)begin
        Aprev_r<=ApreReg_r[TOTAL_WIDTH+1:2];
        Aprev_i<=ApreReg_i[TOTAL_WIDTH+1:2];
        
        A_r<=Aprev_r;
        A_i<=Aprev_i;
    end
    
    // B
    complexMult #(
        .INT_WIDTH(INT_WIDTH+2),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) cMulB (
        .clk(clk),
        .a_r(BpreReg_r), .b_r(w1_r), .a_i(BpreReg_i), .b_i(w1_i),
        .val(cMulVal),
        .prod_r(B_r), .prod_i(B_i),
        .done(done)
    );
    
    // C
    
    complexMult #(
        .INT_WIDTH(INT_WIDTH+2),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) cMulC (
        .clk(clk),
        .a_r(CpreReg_r), .b_r(w2_r), .a_i(CpreReg_i), .b_i(w2_i),
        .val(cMulVal),
        .prod_r(C_r), .prod_i(C_i),
        .done()
    );
    
    //D 
    // C
    
    complexMult #(
        .INT_WIDTH(INT_WIDTH+2),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) cMulD (
        .clk(clk),
        .a_r(DpreReg_r), .b_r(w3_r), .a_i(DpreReg_i), .b_i(w3_i),
        .val(cMulVal),
        .prod_r(D_r), .prod_i(D_i),
        .done()
    );
    
endmodule
