`timescale 1ns / 1ps

module tb_FFT_staggered;

    // Parameters matching your DUT
    parameter INT_WIDTH = 1;
    parameter FRAC_WIDTH = 17;
    localparam TOTAL_WIDTH = INT_WIDTH + FRAC_WIDTH; // 18 bits
    
    // DUT Inputs
    reg clk;
    reg reset;
    reg signed [TOTAL_WIDTH-1:0] in0, in1, in2, in3;
    
    // DUT Outputs
    wire signed [TOTAL_WIDTH-1:0] out0_r, out1_r, out2_r, out3_r;
    wire signed [TOTAL_WIDTH-1:0] out0_i, out1_i, out2_i, out3_i;
    wire done;

    // Instantiate the Top-Level FFT Module
    FFT #(
        .INT_WIDTH(INT_WIDTH),
        .FRAC_WIDTH(FRAC_WIDTH),
        .M(7) // 128-point configuration
    ) dut (
        .clk(clk),
        .reset(reset),
        .in0(in0), .in1(in1), .in2(in2), .in3(in3),
        .out0_r(out0_r), .out1_r(out1_r), .out2_r(out2_r), .out3_r(out3_r),
        .out0_i(out0_i), .out1_i(out1_i), .out2_i(out2_i), .out3_i(out3_i),
        .done(done)
    );

    // Testbench Memory to hold the full 128-point signal
    reg signed [TOTAL_WIDTH-1:0] signal_mem [0:127];

    // ---------------------------------------------------------
    // Clock Generation (100 MHz)
    // ---------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ---------------------------------------------------------
    // Staggered Data Injection Task
    // ---------------------------------------------------------
    integer i;
    initial begin
        // 1. Load the generated Hex file into TB memory
        $readmemh("/home/dell/Desktop/projects/20cred/FFTaccelerator/PySim/input_signal.mem", signal_mem);
        
        // 2. Initialize inputs and apply reset
        in0 = 0; in1 = 0; in2 = 0; in3 = 0;
        
        // Assert reset at t=0
        reset = 1;
        
        // Wait for exactly one positive edge to capture the reset
        @(posedge clk);
        
        // Drop the reset on the very next negative edge 
        // This ensures the pipeline only resets for 1 cycle
        @(negedge clk);
        reset = 0;
        
        $display("Starting Staggered Data Injection (Distance = 32)...");
        $display("===================================================");
        
        // 3. Stream the 32 clock cycles of staggered data into the pipeline
        for (i = 0; i < 32; i = i + 1) begin
            // Offset exactly by N/4 = 32 for Radix-4 Stage 1
            in0 = signal_mem[i];
            in1 = signal_mem[i + 32];
            in2 = signal_mem[i + 64];
            in3 = signal_mem[i + 96];
            @(negedge clk);
        end
        
        // 4. Zero out inputs after the data frame has been pushed
        in0 = 0; in1 = 0; in2 = 0; in3 = 0;
        
        // 5. Wait for the pipeline processing delay to finish
        // The DUT 'done' signal will go high when valid data reaches the end
        wait(done == 1'b1);
        
        // Allow time for the final outputs to flush out of the pipeline
        #200;
        
        $display("Simulation Complete.");
        $finish;
    end
    
    // ---------------------------------------------------------
    // Output Monitoring
    // ---------------------------------------------------------
//    always @(posedge clk) begin
//        if (done) begin
//            $display("Time=%0t | Output Data:", $time);
//            $display("  Out0 = %8.4f + j%8.4f", $itor(out0_r)/131072.0, $itor(out0_i)/131072.0);
//            $display("  Out1 = %8.4f + j%8.4f", $itor(out1_r)/131072.0, $itor(out1_i)/131072.0);
//            $display("  Out2 = %8.4f + j%8.4f", $itor(out2_r)/131072.0, $itor(out2_i)/131072.0);
//            $display("  Out3 = %8.4f + j%8.4f", $itor(out3_r)/131072.0, $itor(out3_i)/131072.0);
//            $display("---------------------------------------------------");
//        end
//    end

endmodule