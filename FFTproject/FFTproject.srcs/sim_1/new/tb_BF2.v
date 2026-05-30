`timescale 1ns / 1ps

module tb_BF2;

    // Parameters matching your DUT
    parameter INT_WIDTH  = 1;
    parameter FRAC_WIDTH = 15;
    localparam DATA_WIDTH = INT_WIDTH + FRAC_WIDTH; // 16 bits

    // Inputs
    reg clk;
    reg val;
    reg signed [DATA_WIDTH-1:0] a_r, b_r, a_i, b_i;
    
    // Outputs
    wire signed [DATA_WIDTH-1:0] Areg_r, Breg_r, Areg_i, Breg_i;
    wire done;

    // Instantiate DUT
    BF2 #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH)
    ) dut (
        .clk(clk),
        .val(val),
        .a_r(a_r), .b_r(b_r), .a_i(a_i), .b_i(b_i),
        .Areg_r(Areg_r), .Breg_r(Breg_r), .Areg_i(Areg_i), .Breg_i(Breg_i),
        .doneReg(done)
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
    // Triggers when the pipeline pushes out 'done'
    // ---------------------------------------------------------
    always @(posedge clk) begin
        if (done) begin
            $display("\nTime=%0t | Radix-2 Finisher Result:", $time);
            $display("  --- Inputs ---");
            $display("  a = %8.4f + j%8.4f", $itor(a_r)/32768.0, $itor(a_i)/32768.0);
            $display("  b = %8.4f + j%8.4f", $itor(b_r)/32768.0, $itor(b_i)/32768.0);
            $display("  --- Outputs (Scaled by /2) ---");
            $display("  A = %8.4f + j%8.4f", $itor(Areg_r)/32768.0, $itor(Areg_i)/32768.0);
            $display("  B = %8.4f + j%8.4f", $itor(Breg_r)/32768.0, $itor(Breg_i)/32768.0);
            $display("---------------------------------------------------");
        end
    end

    // ---------------------------------------------------------
    // Stimulus Task
    // ---------------------------------------------------------
    task apply_inputs(
        input signed [DATA_WIDTH-1:0] in_ar, input signed [DATA_WIDTH-1:0] in_ai,
        input signed [DATA_WIDTH-1:0] in_br, input signed [DATA_WIDTH-1:0] in_bi
    );
        begin
            @(negedge clk);
            a_r = in_ar; a_i = in_ai;
            b_r = in_br; b_i = in_bi;
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
        // Initialize inputs
        a_r=0; a_i=0; b_r=0; b_i=0; val=0;
        
        #100; // Wait for global reset
        $display("Starting BF2 Pipeline Simulation...");
        $display("===================================================");
        
        // Test Case 1: DC Input
        // a = 0.5 + j0.0, b = 0.5 + j0.0
        // Expected True Math: A = 1.0, B = 0.0
        // Expected Scaled Output (/2): A = 0.5, B = 0.0
        apply_inputs(16'h4000, 16'h0000, 16'h4000, 16'h0000);
        
        // Test Case 2: Impulse Input
        // a = 0.5 + j0.0, b = 0.0 + j0.0
        // Expected True Math: A = 0.5, B = 0.5
        // Expected Scaled Output (/2): A = 0.25, B = 0.25
        apply_inputs(16'h4000, 16'h0000, 16'h0000, 16'h0000);

        // Test Case 3: Complex Out-of-Phase
        // a = 0.5 + j0.5, b = -0.5 - j0.5
        // Expected True Math: A = 0.0, B = 1.0 + j1.0
        // Expected Scaled Output (/2): A = 0.0, B = 0.5 + j0.5
        apply_inputs(16'h4000, 16'h4000, 16'hC000, 16'hC000);

        #50;
        $display("Simulation complete.");
        $finish;
    end
endmodule