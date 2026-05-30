`timescale 1ns / 1ps

module tb_complexMult;

    // Parameters matching your DUT
    parameter INT_WIDTH  = 3;
    parameter FRAC_WIDTH = 15;
    localparam IN_WIDTH  = INT_WIDTH + FRAC_WIDTH; // 18 bits
    localparam OUT_WIDTH = IN_WIDTH - 2;           // 16 bits

    // Inputs
    reg clk;
    reg signed [IN_WIDTH-1:0] a_r, b_r, a_i, b_i;
    reg val;

    // Outputs
    wire signed [OUT_WIDTH-1:0] prod_r, prod_i;
    wire done;

    // Instantiate the Device Under Test (DUT)
    complexMult #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .clk(clk),
        .a_r(a_r), .b_r(b_r), .a_i(a_i), .b_i(b_i),
        .val(val),
        .prod_r(prod_r), .prod_i(prod_i),
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
    // Divides by 32768.0 to cast 15 fractional bits back to float
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (done) begin
            $display("Time=%0t | A = %6.3f + j%6.3f | B = %6.3f + j%6.3f | Scaled Prod (A*B/4) = %6.3f + j%6.3f", 
                     $time, 
                     $itor(a_r)/32768.0, $itor(a_i)/32768.0, 
                     $itor(b_r)/32768.0, $itor(b_i)/32768.0, 
                     $itor(prod_r)/32768.0, $itor(prod_i)/32768.0);
        end
    end

    // ---------------------------------------------------------
    // Task: Apply Synchronous Complex Stimulus
    // ---------------------------------------------------------
    task apply_inputs(
        input signed [IN_WIDTH-1:0] in_ar,
        input signed [IN_WIDTH-1:0] in_ai,
        input signed [IN_WIDTH-1:0] in_br,
        input signed [IN_WIDTH-1:0] in_bi
    );
        begin
            // Apply on negative edge for clean setup times
            @(negedge clk); 
            a_r = in_ar; a_i = in_ai;
            b_r = in_br; b_i = in_bi;
            val = 1'b1;
            
            @(negedge clk); 
            val = 1'b0; 
            
            // Stall the task until the 'done' signal ripples through the pipeline
            wait(done == 1'b1);
            @(negedge clk); 
        end
    endtask

    // ---------------------------------------------------------
    // Main Test Sequence
    // ---------------------------------------------------------
    initial begin
        // Initialize Inputs
        a_r = 0; a_i = 0; 
        b_r = 0; b_i = 0; 
        val = 0;
        
        #100; // Wait for global reset
        $display("Starting Sequential 2-Cycle Complex Multiplier Simulation...");
        $display("=========================================================================================");

        // ---------------------------------------------------------
        // Test Case 1: Pure Real Multiplication
        // A = 2.0 + j0.0, B = 1.5 + j0.0 
        // Expected True Math: 3.0 + j0.0
        // Expected Scaled Output (/4): 0.75 + j0.0
        // ---------------------------------------------------------
        // 2.0 * 32768 = 65536 (0x10000)
        // 1.5 * 32768 = 49152 (0x0C000)
        apply_inputs(18'sh10000, 18'sh00000, 18'sh0C000, 18'sh00000);
        
        // ---------------------------------------------------------
        // Test Case 2: Full Complex Math
        // A = 1.0 + j1.0, B = 1.0 + j1.0
        // Expected True Math: 0.0 + j2.0
        // Expected Scaled Output (/4): 0.0 + j0.5
        // ---------------------------------------------------------
        // 1.0 * 32768 = 32768 (0x08000)
        apply_inputs(18'sh08000, 18'sh08000, 18'sh08000, 18'sh08000);

        // ---------------------------------------------------------
        // Test Case 3: Negative Math 
        // A = 1.5 + j0.0, B = -1.5 + j0.0
        // Expected True Math: -2.25 + j0.0
        // Expected Scaled Output (/4): -0.5625 + j0.0
        // ---------------------------------------------------------
        // -1.5 * 32768 = -49152 (0x34000 in 18-bit two's complement)
        apply_inputs(18'sh0C000, 18'sh00000, 18'sh34000, 18'sh00000);

        #50;
        $display("Simulation complete.");
        $finish;
    end

endmodule