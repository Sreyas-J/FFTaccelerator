`timescale 1ns / 1ps

module FFT_Stage1_to_2 #(
    parameter INT_WIDTH=1,
    parameter FRAC_WIDTH=17,
    parameter M=7
)(
    input wire clk,
    input wire reset,
    input wire signed [INT_WIDTH+FRAC_WIDTH-1:0] in0, in1, in2, in3,
    
    output wire signed [(INT_WIDTH+FRAC_WIDTH)*2-1:0] out0, out1, out2, out3,
    output reg done
);
    
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH;
    localparam TWIDDLE_WIDTH = TOTAL_WIDTH + 2;
    
    // ==========================================
    // STAGE 1 VARIABLES (Scalarized)
    // ==========================================
    reg signed [TOTAL_WIDTH-1:0] a_r, b_r, c_r, d_r;
    wire signed [TOTAL_WIDTH-1:0] A_r, B_r, C_r, D_r, A_i, B_i, C_i, D_i;
    wire signed [TOTAL_WIDTH+1:0] w1_r, w2_r, w3_r, w1_i, w2_i, w3_i;  
    
    wire doneInt;
    reg valInt;
    reg [1:0] dReset;
    wire [TWIDDLE_WIDTH*6+1:0] wsDout;
    
    // ==========================================
    // COMMUTATOR VARIABLES (Scalarized)
    // ==========================================
    wire we1, we2_0, we2_1;
    
    // Data going INTO Pre-FIFOs (From Stage 1)
    reg [TOTAL_WIDTH*2-1:0] din_w0_pre;
    reg [TOTAL_WIDTH*2-1:0] din_w1_pre;
    reg [TOTAL_WIDTH*2-1:0] din_w2_pre;
    reg [TOTAL_WIDTH*2-1:0] dout_w3_pre; // No delay on W3 pre-switch
    
    // Data coming OUT of Pre-FIFOs (Going to Switch)
    wire [TOTAL_WIDTH*2-1:0] dout_w0_pre;
    wire [TOTAL_WIDTH*2-1:0] dout_w1_pre;
    wire [TOTAL_WIDTH*2-1:0] dout_w2_pre;
    
    // Data going INTO Post-FIFOs (From Switch)
    reg [TOTAL_WIDTH*2-1:0] din_w0_post;
    reg [TOTAL_WIDTH*2-1:0] din_w1_post;
    reg [TOTAL_WIDTH*2-1:0] din_w2_post;
    reg [TOTAL_WIDTH*2-1:0] dout_w3_post; 
    
    // Data coming OUT of Post-FIFOs (Going to Stage 2)
    wire [TOTAL_WIDTH*2-1:0] dout_w0_post;
    wire [TOTAL_WIDTH*2-1:0] dout_w1_post;
    wire [TOTAL_WIDTH*2-1:0] dout_w2_post;
    
    // Wire 2 Shift Registers (Depth 8)
    reg [TOTAL_WIDTH*2-1:0] buff_w2_pre  [0:7];
    reg [TOTAL_WIDTH*2-1:0] buff_w2_post [0:7];
    
    // RAM Addresses
    reg [4:0] ws1Addra, addr1w0_w, addr2w0_w, addr1w0_r, addr2w0_r;
    reg [3:0] addr1w1_w, addr2w1_w, addr1w1_r, addr2w1_r;
    
    // Control
    reg [5:0] cnt;
    wire [1:0] fsm;

    // ==========================================
    // DATAPATH ASSIGNMENTS
    // ==========================================
//    assign done = doneInt;
    assign we1 = doneInt;
    assign we2_0 = doneInt;
    assign we2_1 = (cnt > 7) ? 1'b1 : 1'b0;
    assign fsm = cnt / 8;
    
    // Twiddle Extractor
    assign w1_r = wsDout[0 +: TWIDDLE_WIDTH];
    assign w1_i = wsDout[TWIDDLE_WIDTH +: TWIDDLE_WIDTH];
    assign w2_r = wsDout[TWIDDLE_WIDTH*2 +: TWIDDLE_WIDTH];
    assign w2_i = wsDout[TWIDDLE_WIDTH*3 +: TWIDDLE_WIDTH];
    assign w3_r = wsDout[TWIDDLE_WIDTH*4 +: TWIDDLE_WIDTH];
    assign w3_i = wsDout[TWIDDLE_WIDTH*5 +: TWIDDLE_WIDTH];
    
    // Shift Register Outputs
    assign dout_w2_pre  = buff_w2_pre[7];
    assign dout_w2_post = buff_w2_post[7];
    
    assign A_i = 'd0;
    
    assign out0 = dout_w0_post;
    assign out1 = dout_w1_post;
    assign out2 = dout_w2_post;
    assign out3 = dout_w3_post;

    // ==========================================
    // MODULE INSTANTIATIONS
    // ==========================================
    Wstage1 ws1 (
      .clka(clk),       
      .ena(1'b1),       
      .wea(1'b0),       
      .addra(ws1Addra), 
      .dina('d0),       
      .douta(wsDout)    
    );
    
    BF4real #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) bf4real (
        .clk(clk),
        .val(valInt),
        .a(a_r), .b(b_r), .c(c_r), .d(d_r),
        .w1_r(w1_r), .w2_r(w2_r), .w3_r(w3_r), 
        .w1_i(w1_i), .w2_i(w2_i), .w3_i(w3_i),
        .A_r(A_r), 
        .B_r(B_r), .B_i(B_i),
        .C_r(C_r), .C_i(C_i), 
        .D_r(D_r), .D_i(D_i),
        .done(doneInt)
    );
    
    // Pre-Switch Delay Blocks
    BUFF1A buff11w0 (
      .clka(clk), .wea(we1), .addra(addr1w0_w), .dina(din_w0_pre),     
      .clkb(clk), .addrb(addr1w0_r), .doutb(dout_w0_pre)  
    );
    
    BUFF1B buff11w1 (
      .clka(clk), .wea(we1), .addra(addr1w1_w), .dina(din_w1_pre),     
      .clkb(clk), .addrb(addr1w1_r), .doutb(dout_w1_pre)  
    );
    
    // Post-Switch Delay Blocks
    BUFF1A buff12w0 (
      .clka(clk), .wea(we2_0), .addra(addr2w0_w), .dina(din_w0_post),     
      .clkb(clk), .addrb(addr2w0_r), .doutb(dout_w0_post)  
    );
    
    BUFF1B buff12w1 (
      .clka(clk), .wea(we2_1), .addra(addr2w1_w), .dina(din_w1_post),     
      .clkb(clk), .addrb(addr2w1_r), .doutb(dout_w1_post)  
    );
    
    // ==========================================
    // COMBINATIONAL SWITCH (No loops needed)
    // ==========================================
    always @(*) begin
        // 1. Pack Stage 1 output into Pre-Delay Wires
        din_w0_pre  = {D_i, D_r};
        din_w1_pre  = {C_i, C_r};
        din_w2_pre  = {B_i, B_r};
        dout_w3_pre = {A_i, A_r};

        // 2. Default Post-Switch Values
        din_w0_post  = 'd0;
        din_w1_post  = 'd0;
        din_w2_post  = 'd0;
        dout_w3_post = 'd0;
            
        // 3. The 4x4 Commutator Switch
        case(fsm)
            2'd0: begin
                din_w0_post  = dout_w3_pre;
                din_w1_post  = dout_w0_pre;
                din_w2_post  = dout_w1_pre;
                dout_w3_post = dout_w2_pre;
            end
            2'd1: begin
                din_w0_post  = dout_w2_pre;
                din_w1_post  = dout_w3_pre;
                din_w2_post  = dout_w0_pre;
                dout_w3_post = dout_w1_pre;
            end
            2'd2: begin
                din_w0_post  = dout_w1_pre;
                din_w1_post  = dout_w2_pre;
                din_w2_post  = dout_w3_pre;
                dout_w3_post = dout_w0_pre;
            end
            2'd3: begin
                din_w0_post  = dout_w0_pre;
                din_w1_post  = dout_w1_pre;
                din_w2_post  = dout_w2_pre;
                dout_w3_post = dout_w3_pre;
            end
        endcase
    end
    
    // ==========================================
    // SEQUENTIAL LOGIC
    // ==========================================
    integer j; // Used strictly for the shift registers
    
    always @(posedge clk) begin
        if(reset) begin
            ws1Addra <= 0;
            dReset <= 1;
            
            addr1w0_w <= 0; addr1w0_r <= 0;
            addr1w1_w <= 0; addr1w1_r <= 0;
            addr2w0_w <= 0; addr2w0_r <= 0;
            addr2w1_w <= 0; addr2w1_r <= 0;
            
            cnt <= 0;
            valInt <= 0;
            done<=1'b0;
            
        end else begin 
            
            if(dReset==1) valInt <= 1'b1;
            if(dReset && dReset!=3) dReset <= dReset + 1;              
            if(dReset) ws1Addra <= ws1Addra + 1;
            
            // Push Stage 1 Inputs
            a_r <= in0;
            b_r <= in1;
            c_r <= in2;
            d_r <= in3;
            
            // Write Pointers Update
            if(doneInt) begin
                if(addr1w0_w == 23) addr1w0_w <= 0; else addr1w0_w <= addr1w0_w + 1;
                if(addr1w1_w == 15) addr1w1_w <= 0; else addr1w1_w <= addr1w1_w + 1;
                
                if(!cnt) cnt <= 1;
            end
            
            if(we2_0) begin
                if(addr2w0_w == 23) addr2w0_w <= 0; else addr2w0_w <= addr2w0_w + 1;
            end
            if(we2_1) begin
                if(addr2w1_w == 15) addr2w1_w <= 0; else addr2w1_w <= addr2w1_w + 1;
            end
            
            // Counter Update
            if(cnt) cnt <= cnt + 1;
                    
            // W2 Shift Registers (Depth 8)
            buff_w2_pre[0]  <= din_w2_pre;    
            buff_w2_post[0] <= din_w2_post;    
            
            for(j=1; j<8; j=j+1) begin
                buff_w2_pre[j]  <= buff_w2_pre[j-1];
                buff_w2_post[j] <= buff_w2_post[j-1];
            end
            
            // Read Pointers Update
            if(cnt >= 14) begin
                addr1w1_r <= cnt - 13;
            end
            
            if(cnt >= 45) begin
                addr1w0_r <= cnt - 45;
                addr2w0_r <= cnt - 45;
                addr2w1_r <= cnt - 21;
            end
            else if(cnt >= 22) begin
                addr1w0_r <= cnt - 21;
                addr2w1_r <= cnt - 21;
                addr2w0_r <= cnt - 21;
            end
            
            if(cnt==23) done<=1'b1;
        end
    end
    
endmodule