`timescale 1ns / 1ps

module tb_fixed_point_adder_combo;

    // Parameters (Configured for Q1.15)
    parameter INT_WIDTH  = 1;
    parameter FRAC_WIDTH = 15;
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH;

    // Signals (No clock needed)
    reg signed [TOTAL_WIDTH-1:0] a;
    reg signed [TOTAL_WIDTH-1:0] b;
    reg val;
    
    wire done;
    // 17-bit wire to catch the overflow (Q2.15 format)
    wire signed [TOTAL_WIDTH:0] sum; 

    // Instantiate the Device Under Test (DUT)
    fixed_point_adder #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .a(a),
        .b(b),
        .val(val),
        .sum(sum),
        .done(done)
    );

    // ---------------------------------------------------------
    // Output Monitoring
    // Triggers whenever 'sum' changes, but only prints if 'done' is valid
    // ---------------------------------------------------------
    always @(a,b) begin
        if (done) begin
            $display("Time=%0t | a = %8.4f (0x%4h) | b = %8.4f (0x%4h) | sum = %8.4f (0x%5h)", 
                     $time, 
                     $itor(a) / 32768.0, a, 
                     $itor(b) / 32768.0, b, 
                     $itor(sum) / 32768.0, sum);
        end
    end

    // ---------------------------------------------------------
    // Main Test Sequence
    // ---------------------------------------------------------
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        val = 0;
        
        // Wait 100 ns for global reset
        #100;
        
        $display("Starting Combinational Q1.15 -> Q2.15 Adder Simulation...");
        $display("===========================================================================");

        // Test Case 1
        a = 16'h0180; b = 16'h0280; val = 1; #10;
        val = 0; #10; // De-assert val to test combinational clear
        
        // Test Case 2
        a = 16'hfe80; b = 16'h0080; val = 1; #10;
        val = 0; #10;

        // Test Case 3: Max positive overflow (Caught by 17th bit)
        a = 16'h7fff; b = 16'h7fff; val = 1; #10;
        val = 0; #10;

        // Test Case 4: Max negative overflow (Caught by 17th bit)
        a = 16'h8000; b = 16'h8000; val = 1; #10;
        val = 0; #10;

        // Test Case 5: Zero Crossing
        a = 16'h03e8; b = 16'hfc18; val = 1; #10;
        val = 0; #10;


        $display("Simulation complete.");
        $finish;
    end

endmodule