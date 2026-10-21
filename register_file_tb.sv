`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 20:17:34
// Design Name: 
// Module Name: register_file_tb
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



module register_file_tb;
    logic Clock, nReset;
    logic WB;
    logic [3:0] Rd, Ra, Rb;
    logic [7:0] Data;
    logic [7:0] A, B;
    logic [7:0] LED0, LED1;
    
    // Instantiate register file
    register_file dut (
        .Clock(Clock),
        .nReset(nReset),
        .WB(WB),
        .Rd(Rd),
        .Ra(Ra),
        .Rb(Rb),
        .Data(Data),
        .A(A),
        .B(B),
        .LED0(LED0),
        .LED1(LED1)
    );
    
    // Clock generation: 10ns period 
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock;
    end
    
    // test sequence
    initial begin
        // Initialize signals
        nReset = 0;
        WB = 0;
        Rd = 4'd0;
        Ra = 4'd0;
        Rb = 4'd0;
        Data = 8'd0;
        
        // Apply reset
        #20;
        nReset = 1;
        #10;
        
        // Test 1: Write to R2 and read back
        WB = 1;
        Rd = 4'd2;
        Data = 8'd42;
        #10;
        WB = 0;
        Ra = 4'd2;
        Rb = 4'd0;   // R0 should always be hardcoded to 0
        #10;
        
        // Test 2: Write to R3 and R4, then read both
        WB = 1;
        Rd = 4'd3; Data = 8'd100; #10;
        Rd = 4'd4; Data = 8'd200; #10;
        WB = 0;
        Ra = 4'd3; Rb = 4'd4; #10;
        
        // Test 3: Attempt to write to R0 
        WB = 1;
        Rd = 4'd0; Data = 8'd255; #10;
        WB = 0;
        Ra = 4'd0; #10; // Should still be 0
        
        // Test: LED registers
        WB = 1;
        Rd = 4'd14; Data = 8'hAA; #10; // LED0
        Rd = 4'd15; Data = 8'h55; #10; // LED1
        WB = 0;
        Ra = 4'd14; Rb = 4'd15; #10;   // Read LED values
        
        // Reset again and confirm cleared
        nReset = 0; #20; nReset = 1; #10;
        Ra = 4'd2; Rb = 4'd14; #10;   // Should be reset to 0
    end
endmodule
