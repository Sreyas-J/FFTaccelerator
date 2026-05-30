`timescale 1ns / 1ps

module tb_BF4;

    // Parameters matching your DUT
    parameter INT_WIDTH  = 1;
    parameter FRAC_WIDTH = 15;
    
    localparam DATA_WIDTH = INT_WIDTH + FRAC_WIDTH;     // 16 bits
    localparam TWID_WIDTH = INT_WIDTH + FRAC_WIDTH + 2; // 18 bits

    // Inputs
    reg clk;
    reg signed [DATA_WIDTH-1:0] a_r,b_r,c_r,d_r, a_i,b_i,c_i,d_i;
    reg signed [TWID_WIDTH-1:0] w1_r,w2_r,w3_r, w1_i,w2_i,w3_i;
    reg val;
    
    // Outputs
    wire signed [DATA_WIDTH-1:0] A_r, A_i;
    wire signed [DATA_WIDTH-1:0] B_r, C_r, D_r, B_i, C_i, D_i;
    wire done;

    // Instantiate DUT
    BF4 #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .clk(clk),
        .a_r(a_r), .b_r(b_r), .c_r(c_r), .d_r(d_r),
        .a_i(a_i), .b_i(b_i), .c_i(c_i), .d_i(d_i),
        .w1_r(w1_r), .w2_r(w2_r), .w3_r(w3_r), 
        .w1_i(w1_i), .w2_i(w2_i), .w3_i(w3_i),
        .val(val),
        .A_r(A_r), .B_r(B_r), .C_r(C_r), .D_r(D_r),
        .A_i(A_i), .B_i(B_i), .C_i(C_i), .D_i(D_i),
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
    // Output Monitoring
    // Triggers ONLY when the pipeline pushes out 'done'
    // ---------------------------------------------------------
    // ---------------------------------------------------------
    // Output Monitoring
    // Triggers ONLY when the pipeline pushes out 'done'
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (done) begin
            $display("\nTime=%0t | Radix-4 Butterfly Result:", $time);
            $display("  --- Inputs ---");
            $display("  a = %8.4f + j%8.4f", $itor(a_r)/32768.0, $itor(a_i)/32768.0);
            $display("  b = %8.4f + j%8.4f", $itor(b_r)/32768.0, $itor(b_i)/32768.0);
            $display("  c = %8.4f + j%8.4f", $itor(c_r)/32768.0, $itor(c_i)/32768.0);
            $display("  d = %8.4f + j%8.4f", $itor(d_r)/32768.0, $itor(d_i)/32768.0);
            $display("  --- Outputs ---");
            $display("  A = %8.4f + j%8.4f", $itor(A_r)/32768.0, $itor(A_i)/32768.0);
            $display("  B = %8.4f + j%8.4f", $itor(B_r)/32768.0, $itor(B_i)/32768.0);
            $display("  C = %8.4f + j%8.4f", $itor(C_r)/32768.0, $itor(C_i)/32768.0);
            $display("  D = %8.4f + j%8.4f", $itor(D_r)/32768.0, $itor(D_i)/32768.0);
            $display("---------------------------------------------------");
        end
    end

    // ---------------------------------------------------------
    // Stimulus Task
    // ---------------------------------------------------------
    task apply_inputs(
        input signed [DATA_WIDTH-1:0] in_a, input signed [DATA_WIDTH-1:0] in_b, 
        input signed [DATA_WIDTH-1:0] in_c, input signed [DATA_WIDTH-1:0] in_d
    );
        begin
            @(negedge clk);
            // Apply real data, zero out imaginary for clean testing
            a_r = in_a; a_i = 0;
            b_r = in_b; b_i = 0;
            c_r = in_c; c_i = 0;
            d_r = in_d; d_i = 0;
            
            // Standard trivial twiddles (W^0 = 1.0)
            // Note: 1.0 mathematically maps to ~0.9999 (0x07FFF in 18-bit)
            w1_r = 18'h07FFF; w1_i = 18'h00000;
            w2_r = 18'h07FFF; w2_i = 18'h00000;
            w3_r = 18'h07FFF; w3_i = 18'h00000;
            
            val = 1'b1;
            
            @(negedge clk);
            val = 1'b0;
            
            // Wait for the pipeline latency to finish
            wait(done == 1'b1);
            @(negedge clk);
        end
    endtask

    // ---------------------------------------------------------
    // Main Test Sequence
    // ---------------------------------------------------------
    initial begin
        // Initialize everything to zero
        a_r=0; b_r=0; c_r=0; d_r=0;
        a_i=0; b_i=0; c_i=0; d_i=0;
        w1_r=0; w1_i=0; w2_r=0; w2_i=0; w3_r=0; w3_i=0;
        val = 0;
        
        #100;
        $display("Starting BF4 Pipeline Simulation...");
        $display("===================================================");
        
        // Test Case 1: DC Input 
        // All inputs are 0.5 (0x4000). 
        // A should accumulate to 2.0. The pipeline divides by 4.
        // Expected A = 0.5. B, C, D should completely cancel out to 0.0.
        apply_inputs(16'h4000, 16'h4000, 16'h4000, 16'h4000);
        
        // Test Case 2: Impulse Input
        // A = 0.5, Rest = 0.0
        // A, B, C, D should all equally share the energy.
        // Expected A, B, C, D = 0.125 scaled (0.5 / 4).
        apply_inputs(16'h4000, 16'h0000, 16'h0000, 16'h0000);

        #50;
        $display("Simulation complete.");
        $finish;
    end
endmodule