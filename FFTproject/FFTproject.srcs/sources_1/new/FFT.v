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
    parameter FRAC_WIDTH=17,
    parameter M=7
)(
    input wire clk,
    input wire reset,
    input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] in0,in1,in2,in3,
    
    output reg signed [INT_WIDTH+FRAC_WIDTH-1:0] out0_r,out1_r,out2_r,out3_r,   out0_i,out1_i,out2_i,out3_i,
    output reg done
    );
    
    localparam TOTAL_WIDTH=INT_WIDTH+FRAC_WIDTH;
    localparam TWIDDLE_WIDTH=TOTAL_WIDTH+2;
    localparam STAGES = (M+1)/2;
    
    reg signed [TOTAL_WIDTH-1:0] a_r [0:STAGES-1], b_r[0:STAGES-1], c_r[0:STAGES-1], d_r[0:STAGES-1], a_i[1:STAGES-1],b_i[1:STAGES-1],c_i[1:STAGES-1],d_i[1:STAGES-1];
    wire signed [TOTAL_WIDTH-1:0] A_r [0:STAGES-1], B_r[0:STAGES-1], C_r[0:STAGES-1], D_r[0:STAGES-1], A_i[0:STAGES-1],B_i[0:STAGES-1],C_i[0:STAGES-1],D_i[0:STAGES-1];
    wire signed [TOTAL_WIDTH+1:0] w1_r[0:STAGES-2], w2_r[0:STAGES-2], w3_r[0:STAGES-2], w1_i[0:STAGES-2], w2_i [0:STAGES-2], w3_i [0:STAGES-2];  
    wire doneInt [0:STAGES-1];
    reg valInt [0:STAGES-1];
    
    wire [TWIDDLE_WIDTH*6+1:0] wsDout [0:STAGES-2];
    
    
    //HARDCODED
    reg [4:0] ws1Addra;
    reg [2:0] ws2Addra;
    reg ws3Addra;
    
    assign A_i[0] = 'd0;
    
    Wstage1 ws1 (
      .clka(clk),    // input wire clka
      .ena(valInt[0]),      // input wire ena
      .wea(1'b0),      // input wire [0 : 0] wea
      .addra(ws1Addra),  // input wire [4 : 0] addra
      .dina('d0),    // input wire [119 : 0] dina
      .douta(wsDout[0])  // output wire [119 : 0] douta
    );
    
    BF4real #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) bf4real (
        .clk(clk),
        .val(valInt[0]),
        .a(a_r[0]), .b(b_r[0]), .c(c_r[0]), .d(d_r[0]),
        .w1_r(w1_r[0]), .w2_r(w2_r[0]), .w3_r(w3_r[0]), 
        .w1_i(w1_i[0]), .w2_i(w2_i[0]), .w3_i(w3_i[0]),
        .A_r(A_r[0]), 
        .B_r(B_r[0]), .B_i(B_i[0]),
        .C_r(C_r[0]), .C_i(C_i[0]), 
        .D_r(D_r[0]), .D_i(D_i[0]),
        .done(doneInt[0])
    );
    
    genvar i;
    generate
        for(i=0;i<STAGES;i=i+1)begin
            assign w1_r[i]=wsDout[i][0+:TWIDDLE_WIDTH];
            assign w1_i[i]=wsDout[i][TWIDDLE_WIDTH+:TWIDDLE_WIDTH];
            
            assign w2_r[i]=wsDout[i][TWIDDLE_WIDTH*2+:TWIDDLE_WIDTH];
            assign w2_i[i]=wsDout[i][TWIDDLE_WIDTH*3+:TWIDDLE_WIDTH];
            
            assign w3_r[i]=wsDout[i][TWIDDLE_WIDTH*4+:TWIDDLE_WIDTH];
            assign w3_i[i]=wsDout[i][TWIDDLE_WIDTH*5+:TWIDDLE_WIDTH];
        end
    endgenerate
    
    always@(posedge clk)begin
        if(reset)begin
            valInt[0]<=1'b1;
            ws1Addra<=0;
        end
        
        if(valInt[0]) ws1Addra<=ws1Addra+1;
        
        //TEMP
        done<=doneInt[0];
        
        a_r[0]<=in0;
        b_r[0]<=in1;
        c_r[0]<=in2;
        d_r[0]<=in3;
    end
    
endmodule