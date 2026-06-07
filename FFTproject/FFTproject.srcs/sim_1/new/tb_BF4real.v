`timescale 1ns / 1ps

module tb_BF4real_stream;

    // Parameters matching your DUT
    parameter INT_WIDTH  = 1;
    parameter FRAC_WIDTH = 17;
    
    localparam DATA_WIDTH = INT_WIDTH + FRAC_WIDTH;     // 18 bits
    localparam TWID_WIDTH = INT_WIDTH + FRAC_WIDTH + 2; // 20 bits
    
    // Set this to match your DUT latency!
    localparam PIPE_DEPTH = 3; 

    // Inputs
    reg clk;
    reg val;
    reg signed [DATA_WIDTH-1:0] a, b, c, d; // Purely real inputs!
    reg signed [TWID_WIDTH-1:0] w1_r, w2_r, w3_r, w1_i, w2_i, w3_i;
    
    // Outputs
    wire signed [DATA_WIDTH-1:0] A_r; // A_i was optimized away!
    wire signed [DATA_WIDTH-1:0] C_r, C_i;
    wire signed [DATA_WIDTH-1:0] B_r, B_i, D_r, D_i;
    wire done;

    // Instantiate DUT
    BF4real #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .clk(clk),
        .val(val),
        .a(a), .b(b), .c(c), .d(d),
        .w1_r(w1_r), .w2_r(w2_r), .w3_r(w3_r), 
        .w1_i(w1_i), .w2_i(w2_i), .w3_i(w3_i),
        .A_r(A_r), 
        .C_r(C_r), .C_i(C_i),
        .B_r(B_r), .B_i(B_i), 
        .D_r(D_r), .D_i(D_i),
        .done(done)
    );

    // ---------------------------------------------------------
    // Clock Generation (100 MHz)
    // ---------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ---------------------------------------------------------
    // Testbench Delay Pipelines 
    // ---------------------------------------------------------
    reg signed [DATA_WIDTH-1:0] a_d [1:PIPE_DEPTH];
    reg signed [DATA_WIDTH-1:0] b_d [1:PIPE_DEPTH];
    reg signed [DATA_WIDTH-1:0] c_d [1:PIPE_DEPTH];
    reg signed [DATA_WIDTH-1:0] d_d [1:PIPE_DEPTH];
    
    integer i;
    always @(posedge clk) begin
        a_d[1] <= a; b_d[1] <= b; c_d[1] <= c; d_d[1] <= d; 
        for (i = 2; i <= PIPE_DEPTH; i = i + 1) begin
            a_d[i] <= a_d[i-1]; b_d[i] <= b_d[i-1]; c_d[i] <= c_d[i-1]; d_d[i] <= d_d[i-1]; 
        end
    end

    // ---------------------------------------------------------
    // Output Monitoring
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (done) begin
            $display("\nTime=%0t | Real-Input Radix-4 Butterfly Result:", $time);
            $display("  --- Inputs (Recovered from %0d cycles ago) ---", PIPE_DEPTH);
            $display("  a = %8.4f", $itor(a_d[PIPE_DEPTH])/131072.0);
            $display("  b = %8.4f", $itor(b_d[PIPE_DEPTH])/131072.0);
            $display("  c = %8.4f", $itor(c_d[PIPE_DEPTH])/131072.0);
            $display("  d = %8.4f", $itor(d_d[PIPE_DEPTH])/131072.0);
            $display("  --- Outputs (Scaled by /4) ---");
            $display("  A = %8.4f + j  0.0000", $itor(A_r)/131072.0);
            $display("  B = %8.4f + j%8.4f", $itor(B_r)/131072.0, $itor(B_i)/131072.0);
            $display("  C = %8.4f + j%8.4f", $itor(C_r)/131072.0, $itor(C_i)/131072.0);
            $display("  D = %8.4f + j%8.4f", $itor(D_r)/131072.0, $itor(D_i)/131072.0);
            $display("---------------------------------------------------");
        end
    end

    // ---------------------------------------------------------
    // Main Test Sequence (Continuous Streaming)
    // ---------------------------------------------------------
    initial begin
        a=0; b=0; c=0; d=0;
        w1_r=0; w1_i=0; w2_r=0; w2_i=0; w3_r=0; w3_i=0;
        val = 0;
        
        #100;
        $display("Starting BF4real Streaming Pipeline Simulation...");
        $display("Twiddle factors staggered by 1 clock cycle!");
        $display("===================================================");
        
        // =========================================================
        // PUSH CYCLE 1: DC Input (Inputs Only)
        // =========================================================
        @(negedge clk);
        a = 18'h10000; b = 18'h10000; c = 18'h10000; d = 18'h10000; // 0.5
        val = 1'b1;
        
        // =========================================================
        // PUSH CYCLE 2: Impulse Input 
        // =========================================================
        @(negedge clk);
        a = 18'h10000; b = 18'h00000; c = 18'h00000; d = 18'h00000;
        val = 1'b1; 
        
        // APPLY TWIDDLES FOR CYCLE 1: w1=1.0, w2=1.0, w3=1.0
        w1_r=20'h20000; w1_i=20'h00000;
        w2_r=20'h20000; w2_i=20'h00000;
        w3_r=20'h20000; w3_i=20'h00000;

        // =========================================================
        // PUSH CYCLE 3: Alternating Pattern 
        // =========================================================
        @(negedge clk);
        a = 18'h10000; b = 18'h30000; c = 18'h10000; d = 18'h30000; // 0.5, -0.5, 0.5, -0.5
        val = 1'b1; 
        
        // APPLY TWIDDLES FOR CYCLE 2: w1=-j, w2=-1, w3=j
        // -1.0 in 20-bit Q3.17 is 20'hE0000
        w1_r=20'h00000; w1_i=20'hE0000; // -j
        w2_r=20'hE0000; w2_i=20'h00000; // -1
        w3_r=20'h00000; w3_i=20'h20000; // j
        
        // =========================================================
        // PUSH CYCLE 4: STOP STREAMING DATA, PUSH LAST TWIDDLES
        // =========================================================
        @(negedge clk);
        val = 1'b0;
        a = 0; b = 0; c = 0; d = 0;
        
        // APPLY TWIDDLES FOR CYCLE 3: 45-degree fractional rotations
        // 0.7071 in Q3.17 is ~92682 (20'h16A0A)
        // -0.7071 in Q3.17 is ~ -92682 (20'hE95F6)
        w1_r=20'h16A0A; w1_i=20'hE95F6; // 0.707 - j0.707
        w2_r=20'h00000; w2_i=20'hE0000; // -j
        w3_r=20'hE95F6; w3_i=20'hE95F6; // -0.707 - j0.707

        // Clean up twiddles on the next clock
        @(negedge clk);
        w1_r=0; w1_i=0; w2_r=0; w2_i=0; w3_r=0; w3_i=0;

        // Wait for the pipeline to flush
        #100;
        $display("Streaming complete.");
        $finish;
    end
endmodule