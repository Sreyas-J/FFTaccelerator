`timescale 1ns / 1ps

module tb_fixed_point_multiplier_seq;

    // Parameters (Configured for Q1.15)
    parameter INT_WIDTH  = 1;
    parameter FRAC_WIDTH = 15;
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH;

    // Signals
    reg clk;
    reg signed [TOTAL_WIDTH-1:0] a;
    reg signed [TOTAL_WIDTH-1:0] b;
    reg val;
    
    wire done;
    wire signed [TOTAL_WIDTH-1:0] prod;

    // Instantiate the Device Under Test (DUT)
    fixed_point_multiplier #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .clk(clk),
        .a(a),
        .b(b),
        .val(val),
        .done(done),
        .prod(prod)
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
    // Prints the result only when the 'done' signal is valid
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (done) begin
            $display("Time=%0t | a = %8.4f (0x%4h) | b = %8.4f (0x%4h) | prod = %8.4f (0x%4h)", 
                     $time, 
                     $itor(a) / 32768.0, a, 
                     $itor(b) / 32768.0, b, 
                     $itor(prod) / 32768.0, prod);
        end
    end

    // ---------------------------------------------------------
    // Task: Apply Synchronous Stimulus
    // ---------------------------------------------------------
    task apply_inputs(
        input signed [TOTAL_WIDTH-1:0] in_a,
        input signed [TOTAL_WIDTH-1:0] in_b
    );
        begin
            // Align stimulus to the negative edge to ensure setup times are met
            @(negedge clk); 
            a = in_a;
            b = in_b;
            val = 1'b1;
            
            // Wait one clock cycle for the DUT to process
            @(negedge clk); 
            val = 1'b0; // De-assert val to ensure 'done' goes low on next cycle
            
            // Wait one more cycle before applying the next test case
            @(negedge clk); 
        end
    endtask

    // ---------------------------------------------------------
    // Main Test Sequence
    // ---------------------------------------------------------
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        val = 0;
        
        // Wait 100 ns for global reset/startup
        #100;
        
        $display("Starting Sequential Q1.15 Multiplier Simulation...");
        $display("===========================================================================");

        // Test Case 1: 0.5 * 0.5 = 0.25
        apply_inputs(16'h4000, 16'h4000);
        
        // Test Case 2: -0.5 * 0.25 = -0.125
        apply_inputs(16'hC000, 16'h2000);

        // Test Case 3: 0.125 * 0.125 = 0.0156
        apply_inputs(16'h1000, 16'h1000);

        // Test Case 4: -0.75 * -0.75 = 0.5625
        apply_inputs(16'hA000, 16'hA000);

        // Test Case 5: -1.0 * -1.0 (Saturation Edge Case Check)
        // Expected product is 0x7FFF (+0.9999)
        apply_inputs(16'h8000, 16'h8000);

        #20;
        $display("Simulation complete.");
        $finish;
    end

endmodule