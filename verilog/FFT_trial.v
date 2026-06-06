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
    
    localparam TOTAL_WIDTH = INT_WIDTH+FRAC_WIDTH;
    localparam STAGES = (M+1)/2;
    
    wire doneInt[0: STAGES-1] ,valInt[0:STAGES-1];
    
    wire signed [TOTAL_WIDTH-1:0] A_r[0:STAGES-1],A_i[0:STAGES-1],  B_r[0:STAGES-1],B_i[0:STAGES-1],    C_r[0:STAGES-1],C_i[0:STAGES-1],    D_r[0:STAGES-1],D_i[0:STAGES-1];
    wire signed [TOTAL_WIDTH+1:0] w1_r[0:STAGES-2],w1_i[0:STAGES-2],    w2_r[0:STAGES-2],w2_i[0:STAGES-2],  w3_r[0:STAGES-2],w3_i[0:STAGES-2];
    wire signed [TOTAL_WIDTH-1:0] a_i[0:STAGES-2],a_r[0:STAGES-1],  b_r[0:STAGES-1],b_i[0:STAGES-2],    c_r[0:STAGES-1],c_i[0:STAGES-2],    d_r[0:STAGES-1],d_i[0:STAGES-2];
    
    wire signed [TOTAL_WIDTH-1:0] W3 [0:1];
    
    
    //HARDCODED
    wire signed [(TOTAL_WIDTH+2)*6-1:0] W1douta,W2douta;
//    wire signed [TOTAL_WIDTH+1:0] stage1w1_r,stage1w1_i,stage1w2_r,stage1w2_i,stage1w3_r,stage1w3_i;
    reg [5:0] W1addra;
    reg [2:0] W2addra;
    
    reg signed [TOTAL_WIDTH-1:0] buff1A_r[0:23], buff1A_i[0:23],   buff1B_r[0:15], buff1B_i[0:15],  buff1C_r[0:7],buff1C_i[0:7];
    reg signed [TOTAL_WIDTH-1:0] buff2A_r[0:5], buff2A_i[0:5],  buff2B_r[0:3],buff2B_i[0:3],   buff2C_r[0:1], buff2C_i[0:1];
    reg signed [TOTAL_WIDTH-1:0] buff3A_r, buff3A_i,   buff3C_r,buff3C_i;
    
    assign a_r[0]=in0;
    assign b_r[0]=in1;
    assign c_r[0]=in2;
    assign d_r[0]=in3;
    
    assign a_r[1]=buff1A_r[23];
    assign a_i[1]=buff1A_i[23];
    assign b_r[1]=buff1B_r[15];
    assign b_i[1]=buff1B_i[15];
    assign c_r[1]=buff1C_r[7];
    assign c_i[1]=buff1C_i[7];
    assign d_r[1]=D_r[0];
    assign d_i[1]=D_i[0];
    
    assign a_r[2]=buff2A_r[5];
    assign a_i[2]=buff2A_i[5];
    assign b_r[2]=buff2B_r[3];
    assign b_i[2]=buff2B_i[3];
    assign c_r[2]=buff2C_r[1];
    assign c_i[2]=buff2C_i[1];
    assign d_r[2]=D_r[1];
    assign d_i[2]=D_i[1];
    
    assign a_r[3]=buff3A_r[1];
    assign b_r[3]=B_r[2];
    assign c_r[3]=buff3C_r[1];
    assign d_r[3]=D_r[2];
    
    assign A_i[0]=0;
    
    // STAGE-1
    assign w1_r[0]=W1douta[TOTAL_WIDTH+1:0];
    assign w1_i[0]=W1douta[(TOTAL_WIDTH*2+3)-:TOTAL_WIDTH+1];
    assign w2_r[0]=W1douta[(TOTAL_WIDTH*3+5)-:TOTAL_WIDTH+1];
    assign w2_i[0]=W1douta[(TOTAL_WIDTH*4+7)-:TOTAL_WIDTH+1];
    assign w3_r[0]=W1douta[(TOTAL_WIDTH*5+9)-:TOTAL_WIDTH+1];
    assign w3_i[0]=W1douta[(TOTAL_WIDTH*6+11)-:TOTAL_WIDTH+1];
    
    // STAGE-2
    assign w1_r[1]=W2douta[TOTAL_WIDTH+1:0];
    assign w1_i[1]=W2douta[(TOTAL_WIDTH*2+3)-:TOTAL_WIDTH+1];
    assign w2_r[1]=W2douta[(TOTAL_WIDTH*3+5)-:TOTAL_WIDTH+1];
    assign w2_i[1]=W2douta[(TOTAL_WIDTH*4+7)-:TOTAL_WIDTH+1];
    assign w3_r[1]=W2douta[(TOTAL_WIDTH*5+9)-:TOTAL_WIDTH+1];
    assign w3_i[1]=W2douta[(TOTAL_WIDTH*6+11)-:TOTAL_WIDTH+1];
    
    // STAGE-3
    
    
    W1 w1 (
      .clka(clk),    // input wire clka
      .wea(1'b0),      // input wire [0 : 0] wea
      .addra(W1addra),  // input wire [5 : 0] addra
      .dina(128'd0),    // input wire [143 : 0] dina
      .douta(W1douta)  // output wire [143 : 0] douta
    );
    
    W2 w2 (
      .clka(clk),    // input wire clka
      .wea(1'b0),      // input wire [0 : 0] wea
      .addra(W2addra),  // input wire [2 : 0] addra
      .dina(128'd0),    // input wire [107 : 0] dina
      .douta(W2douta)  // output wire [107 : 0] douta
    );
    
//    assign W3={'h000008000000008000000008000,'hE95FBA57EE00000000E95F85A82};
    
    //HARDCODED
    integer j;
    always @(posedge clk) begin
        // =========================================================
        // STAGE 1 to STAGE 2 DELAY PIPELINES
        // =========================================================
        
        // Shift data down the pipeline (Indices N down to 1)
        for (j = 23; j > 0; j = j - 1) begin
            buff1A_r[j] <= buff1A_r[j-1];
            buff1A_i[j] <= buff1A_i[j-1];
        end
        for (j = 15; j > 0; j = j - 1) begin
            buff1B_r[j] <= buff1B_r[j-1];
            buff1B_i[j] <= buff1B_i[j-1];
        end
        for (j = 7; j > 0; j = j - 1) begin
            buff1C_r[j] <= buff1C_r[j-1];
            buff1C_i[j] <= buff1C_i[j-1];
        end
        
        // Feed new inputs into the head of the FIFOs (Index 0)
        // (Assuming stage1_outA_r is the wire coming from Stage 1's BF4 'A' port, etc.)
        buff1A_r[0] <= A_r[0]; buff1A_i[0] <= A_i[0];
        buff1B_r[0] <= B_r[0]; buff1B_i[0] <= B_i[0];
        buff1C_r[0] <= C_r[0]; buff1C_i[0] <= C_i[0];

        // =========================================================
        // STAGE 2 to STAGE 3 DELAY PIPELINES
        // =========================================================
        
        // Shift data down the pipeline (Indices N down to 1)
        for (j = 5; j > 0; j = j - 1) begin
            buff2A_r[j] <= buff2A_r[j-1];
            buff2A_i[j] <= buff2A_i[j-1];
        end
        for (j = 3; j > 0; j = j - 1) begin
            buff2B_r[j] <= buff2B_r[j-1];
            buff2B_i[j] <= buff2B_i[j-1];
        end
        for (j = 1; j > 0; j = j - 1) begin
            buff2C_r[j] <= buff2C_r[j-1];
            buff2C_i[j] <= buff2C_i[j-1];
        end
        
        // Feed new inputs into the head of the FIFOs (Index 0)
        buff2A_r[0] <= A_r[1]; buff2A_i[0] <= A_i[1];
        buff2B_r[0] <= B_r[1]; buff2B_i[0] <= B_i[1];
        buff2C_r[0] <= C_r[1]; buff2C_i[0] <= C_i[1];
        
    end
    
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
        .C_r(C_r[0]), .C_i(C_i[0]),
        .B_r(B_r[0]), .B_i(B_i[0]), 
        .D_r(D_r[0]), .D_i(D_i[0]),
        .done(doneInt[0])
    );
    
    generate    
        genvar i;
        
        for(i=1;i<STAGES-1;i=i+1)begin
            BF4 #(
                .INT_WIDTH(INT_WIDTH),
                .FRAC_WIDTH(FRAC_WIDTH)
            ) bf4 (
                .clk(clk),
                .a_r(a_r[i]), .b_r(b_r[i]), .c_r(c_r[i]), .d_r(d_r[i]),
                .a_i(a_i[i-1]), .b_i(b_i[i-1]), .c_i(c_i[i-1]), .d_i(d_i[i-1]),
                .w1_r(w1_r[i]), .w2_r(w2_r[i]), .w3_r(w3_r[i]), 
                .w1_i(w1_i[i]), .w2_i(w2_i[i]), .w3_i(w3_i[i]),
                .val(valInt[i]),
                .A_r(A_r[i]), .B_r(B_r[i]), .C_r(C_r[i]), .D_r(D_r[i]),
                .A_i(A_i[i]), .B_i(B_i[i]), .C_i(C_i[i]), .D_i(D_i[i]),
                .done(doneInt[i])
            );
            
            assign valInt[i]= doneInt[i-1];
        end
    
    endgenerate
    
    BF2 #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) bf2ab (
        .clk(clk),
        .val(valInt[STAGES-1]),
        .a_r(a_r[STAGES-1]), .b_r(b_r[STAGES-1]), .a_i(a_i[STAGES-2]), .b_i(b_i[STAGES-2]),
        .Areg_r(A_r[STAGES-1]), .B_r(B_r[STAGES-1]), .Areg_i(A_i[STAGES-1]), .Breg_i(B_i[STAGES-1]),
        .doneReg(doneInt[STAGES-1])  
    );
    
    BF2 #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) bf2cd (
        .clk(clk),
        .val(valInt[STAGES-1]),
        .a_r(c_r[STAGES-1]), .b_r(d_r[STAGES-1]), .a_i(c_i[STAGES-2]), .b_i(d_i[STAGES-2]),
        .Areg_r(C_r[STAGES-1]), .B_r(D_r[STAGES-1]), .Areg_i(C_i[STAGES-1]), .Breg_i(D_i[STAGES-1]),
        .doneReg()  
    );
    
endmodule