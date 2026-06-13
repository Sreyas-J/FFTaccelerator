`timescale 1ns / 1ps

module FFT #(
    parameter INT_WIDTH=1,
    parameter FRAC_WIDTH=17,
    parameter M=7
)(
    input wire clk,
    input wire reset,
    input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] in0,in1,in2,in3,
    
    output reg signed [INT_WIDTH+FRAC_WIDTH-1:0] out0_r,out1_r,out2_r,out3_r,   out0_i,out1_i,out2_i,out3_i,
    output wire done
    );
    
    localparam TOTAL_WIDTH=INT_WIDTH+FRAC_WIDTH;
    localparam TWIDDLE_WIDTH=TOTAL_WIDTH+2;
    localparam STAGES = (M+1)/2;
    
    reg signed [TOTAL_WIDTH-1:0] a_r [0:STAGES-1], b_r[0:STAGES-1], c_r[0:STAGES-1], d_r[0:STAGES-1], a_i[1:STAGES-1],b_i[1:STAGES-1],c_i[1:STAGES-1],d_i[1:STAGES-1];
    wire signed [TOTAL_WIDTH-1:0] A_r [0:STAGES-1], B_r[0:STAGES-1], C_r[0:STAGES-1], D_r[0:STAGES-1], A_i[0:STAGES-1],B_i[0:STAGES-1],C_i[0:STAGES-1],D_i[0:STAGES-1];
    wire signed [TOTAL_WIDTH+1:0] w1_r[0:STAGES-2], w2_r[0:STAGES-2], w3_r[0:STAGES-2], w1_i[0:STAGES-2], w2_i [0:STAGES-2], w3_i [0:STAGES-2];  
    wire doneInt [0:STAGES-1];
    reg valInt [0:STAGES-1];
    reg [1:0] dReset;
    
    wire [TWIDDLE_WIDTH*6+1:0] wsDout [0:STAGES-2];
    
    wire we1 [0:STAGES-2],we2_0 [0:STAGES-2],we2_1[0:STAGES-2];
    
    // =========================================================================
    // Split 2D arrays into distinct 1D arrays to avoid XSim bug
    // =========================================================================
    reg [TOTAL_WIDTH*2-1:0] din1w0_0 [0:STAGES-2];
    reg [TOTAL_WIDTH*2-1:0] din1w0_1 [0:STAGES-2];
    
    reg [TOTAL_WIDTH*2-1:0] din1w1_0 [0:STAGES-2];
    reg [TOTAL_WIDTH*2-1:0] din1w1_1 [0:STAGES-2];
    
    reg [TOTAL_WIDTH*2-1:0] din1w2_0 [0:STAGES-2];
    reg [TOTAL_WIDTH*2-1:0] din1w2_1 [0:STAGES-2];
    
    reg [TOTAL_WIDTH*2-1:0] dout1w3_0 [0:STAGES-2];
    reg [TOTAL_WIDTH*2-1:0] dout1w3_1 [0:STAGES-2];
    
    reg [TOTAL_WIDTH*2-1:0] buff1w2 [0:STAGES-2][0:1][0:7];
    // =========================================================================

    wire [TOTAL_WIDTH*2-1:0] dout1w0[0:STAGES-2][0:1],dout1w1[0:STAGES-2][0:1],dout1w2[0:STAGES-2][0:1];
    
    //HARDCODED
    reg [4:0] ws1Addra,addr1w0_w[0:STAGES-2],addr2w0_w[0:STAGES-2],addr1w0_r[0:STAGES-2],addr2w0_r[0:STAGES-2];
    reg [3:0] addr1w1_w[0:STAGES-2],addr2w1_w[0:STAGES-2],addr1w1_r[0:STAGES-2],addr2w1_r[0:STAGES-2];
    reg [2:0] ws2Addra;
    reg ws3Addra;
    
    reg [5:0] cnt [0:STAGES-2];
    wire [1:0] fsm [0:STAGES-2];
    
    // STAGE1 TWIDDLE FACTORS
    Wstage1 ws1 (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(1'b0),      // input wire [0 : 0] wea
      .addra(ws1Addra),  // input wire [4 : 0] addra
      .dina('d0),    // input wire [119 : 0] dina
      .douta(wsDout[0])  // output wire [119 : 0] douta
    );
    
    // COMMUTATOR1 1-2
    BUFF1A buff11w0 (
      .clka(clk),    
      .wea(we1[0]),      
      .addra(addr1w0_w[0]),  
      .dina(din1w0_0[0]),     // UPDATED VAR  
      .clkb(clk),    
      .addrb(addr1w0_r[0]),  
      .doutb(dout1w0[0][0])  
    );
    
    BUFF1B buff11w1 (
      .clka(clk),    
      .wea(we1[0]),      
      .addra(addr1w1_w[0]),  
      .dina(din1w1_0[0]),     // UPDATED VAR    
      .clkb(clk),    
      .addrb(addr1w1_r[0]),  
      .doutb(dout1w1[0][0])  
    );
    
    //COMMUTATOR2 1-2
    BUFF1A buff12w0 (
      .clka(clk),    
      .wea(we2_0[0]),      
      .addra(addr2w0_w[0]),  
      .dina(din1w0_1[0]),     // UPDATED VAR    
      .clkb(clk),    
      .addrb(addr2w0_r[0]),  
      .doutb(dout1w0[0][1])  // CRITICAL FIX: Was incorrectly dout1w1
    );
    
    BUFF1B buff12w1 (
      .clka(clk),    
      .wea(we2_1[0]),      
      .addra(addr2w1_w[0]),  
      .dina(din1w1_1[0]),     // UPDATED VAR    
      .clkb(clk),    
      .addrb(addr2w1_r[0]),  
      .doutb(dout1w1[0][1])  
    );
    
    
    // STAGE 1
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
    
    assign dout1w2[0][0]=buff1w2[0][0][7];
    assign dout1w2[0][1]=buff1w2[0][1][7];
    
    assign A_i[0] = 'd0;
    
    // =========================================================================
    // CRITICAL FIX: Separate loop integers to prevent race conditions
    // =========================================================================
    integer j_comb;
    integer j_seq;

    always@(*)begin
        // Map Stage 1 outputs to the strictly 1D variables
        din1w0_0[0] = {D_i[0],D_r[0]};
        din1w1_0[0] = {C_i[0],C_r[0]};
        din1w2_0[0] = {B_i[0],B_r[0]};
        dout1w3_0[0] = {A_i[0],A_r[0]};

        // Use j_comb for the combinatorial block
        for(j_comb=0; j_comb<STAGES-2; j_comb=j_comb+1)begin
             // Default assignments to prevent inferred latches
             din1w0_1[j_comb] = 'd0;
             din1w1_1[j_comb] = 'd0;
             din1w2_1[j_comb] = 'd0;
             dout1w3_1[j_comb] = 'd0;
                
             case(fsm[j_comb])
                 // State 0
                 2'd0: begin
                     din1w0_1[j_comb] = dout1w3_0[j_comb];
                     din1w1_1[j_comb] = dout1w0[j_comb][0];
                     din1w2_1[j_comb] = dout1w1[j_comb][0];
                     dout1w3_1[j_comb] = dout1w2[j_comb][0];
                 end
                 // State 1
                 2'd1: begin
                     din1w0_1[j_comb] = dout1w2[j_comb][0];
                     din1w1_1[j_comb] = dout1w3_0[j_comb];
                     din1w2_1[j_comb] = dout1w0[j_comb][0];
                     dout1w3_1[j_comb] = dout1w1[j_comb][0];
                 end
                 // State 2
                 2'd2: begin
                     din1w0_1[j_comb] = dout1w1[j_comb][0];
                     din1w1_1[j_comb] = dout1w2[j_comb][0];
                     din1w2_1[j_comb] = dout1w3_0[j_comb];
                     dout1w3_1[j_comb] = dout1w0[j_comb][0];
                 end
                 // State 3
                 2'd3: begin
                     din1w0_1[j_comb] = dout1w0[j_comb][0];
                     din1w1_1[j_comb] = dout1w1[j_comb][0];
                     din1w2_1[j_comb] = dout1w2[j_comb][0];
                     dout1w3_1[j_comb] = dout1w3_0[j_comb];
                 end
             endcase
        end
    end
        
    //TEMP
    assign done=doneInt[0];
    
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
        
        for(i=0; i<STAGES-1; i=i+1) begin
            assign we1[i] = doneInt[i];  
            assign fsm[i] = cnt[i] / 8; 
            
            assign we2_0[i] = doneInt[i];
            assign we2_1[i]= (cnt[i]>7) ? 1'b1:1'b0;
        end
        
    endgenerate
    
    always@(posedge clk)begin
        if(reset)begin
            ws1Addra<=0;
            dReset<=1;
            
            // Use j_seq for the sequential block
            for(j_seq=0; j_seq<STAGES-2; j_seq=j_seq+1)begin
                addr1w0_w[j_seq]<=0;
                addr1w0_r[j_seq]<=0;
                addr1w1_w[j_seq]<=0;
                addr1w1_r[j_seq]<=0;
                
                addr2w0_w[j_seq]<=0;
                addr2w0_r[j_seq]<=0;
                addr2w1_w[j_seq]<=0;
                addr2w1_r[j_seq]<=0;
            end
            
            for(j_seq=0; j_seq<STAGES-1; j_seq=j_seq+1)begin
                cnt[j_seq]<=0;
            end
            
        end else begin // CRITICAL FIX: Use else block to prevent synchronous logic running during reset
            
            if(dReset==1) valInt[0]<=1'b1;
            if(dReset && dReset!=3) dReset<=dReset+1;              
            if(dReset) ws1Addra<=ws1Addra+1;
            
            // STAGE1
            a_r[0]<=in0;
            b_r[0]<=in1;
            c_r[0]<=in2;
            d_r[0]<=in3;
            
            if(doneInt[0])begin
                if(addr1w0_w[0]==23) addr1w0_w[0]<=0;
                else addr1w0_w[0]<=addr1w0_w[0]+1;
                
                if(addr1w1_w[0]==15) addr1w1_w[0]<=0;
                else addr1w1_w[0]<=addr1w1_w[0]+1;
                
                if(!cnt[0]) cnt[0]<=1; // Safer logic check
            end
            
            for(j_seq=0; j_seq<STAGES-1; j_seq=j_seq+1)begin
                if(we2_0[j_seq])begin
                    if(addr2w0_w[j_seq]==23) addr2w0_w[j_seq]<=0;
                    else addr2w0_w[j_seq]<=addr2w0_w[j_seq]+1;
                end
                if(we2_1[j_seq])begin
                    if(addr2w1_w[j_seq]==15) addr2w1_w[j_seq]<=0;
                    else addr2w1_w[j_seq]<=addr2w1_w[j_seq]+1;
                end
            end
            
            // COMMUTATOR1 1-2
            if(cnt[0]) cnt[0]<=cnt[0]+1;
                    
            buff1w2[0][0][0]<=din1w2_0[0];    
            buff1w2[0][1][0]<=din1w2_1[0];    
            
            // HARDCODED
            for(j_seq=1; j_seq<8; j_seq=j_seq+1)begin
                buff1w2[0][0][j_seq]<=buff1w2[0][0][j_seq-1];
                buff1w2[0][1][j_seq]<=buff1w2[0][1][j_seq-1];
            end
            
            if(cnt[0]>=14)begin
                addr1w1_r[0]<=cnt[0]-13;
            end
            
            if(cnt[0]>=45)begin
                addr1w0_r[0]<=cnt[0]-45;
                addr2w0_r[0]<=cnt[0]-45;
                
                addr2w1_r[0]<=cnt[0]-21;
            end
            else if(cnt[0]>=22)begin
                addr1w0_r[0]<=cnt[0]-21;
                addr2w1_r[0]<=cnt[0]-21;
                
                addr2w0_r[0]<=cnt[0]-21;
            end
        end
    end
    
endmodule