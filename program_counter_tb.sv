`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 19:58:53
// Design Name: 
// Module Name: program_counter_tb
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


`timescale 1ns/1ps

module program_counter_tb;
    logic Clock;
    logic nReset;
    logic Taken;
    logic [7:0] Bamt;
    logic [7:0] PC;
    
    program_counter dut (
        .Clock(Clock),
        .nReset(nReset),
        .Taken(Taken),
        .Bamt(Bamt),
        .PC(PC)
    );
    
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock;
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        nReset = 1;
        Taken = 0;
        Bamt = 8'd0;
        
        // check reset functionality
        nReset = 0;
        #10;
        nReset = 1;
        #10
        
        // normal increment where Taken = 0
        Taken = 0;
        repeat(5) begin
            #10;

        
        // Test 3: Branch taken with positive offset
        Taken = 1;
        Bamt = 8'd10;
        #10;
        
        // Test 4: Continue normal increment
        Taken = 0;
        repeat(3) begin
            #10;
        end
        
        // Test 5: Negative branch (using two's complement)
        Taken = 1;
        Bamt = 8'hFB; // -5 in two's complement
        #10;
        
        // Test 6: Reset during operation
        #20;
        nReset = 0;
        #10;
        nReset = 1;
        
        // Test 7: Overflow behavior
        nReset = 0;
        #10;
        nReset = 1;
        Taken = 1;
        Bamt = 8'd255;
        #10;
        Taken = 0;
        #10;
        end
    end
endmodule