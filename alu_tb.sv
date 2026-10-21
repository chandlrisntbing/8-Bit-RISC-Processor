`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 19:45:36
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    logic [2:0] ALUOp;
    logic [7:0] A, B;
    logic [7:0] result;
    logic Zero, Carry;
    
    // Instantiate ALU
    alu dut (
        .ALUOp(ALUOp),
        .A(A),
        .B(B),
        .result(result),
        .Zero(Zero),
        .Carry(Carry)
    );
    
    initial begin
        // Initialize
        ALUOp = 3'b000;
        A = 8'd0;
        B = 8'd0;
        #10;
        
        // Test 1: PASS operation (ALUOp = 000)
        ALUOp = 3'b000;
        A = 8'd42;
        B = 8'd100;
        #10;
        
        A = 8'd255;
        B = 8'd0;
        #10;
        
        // Test 2: OR operation (ALUOp = 001)
        ALUOp = 3'b001;
        A = 8'b11110000;
        B = 8'b10101010;
        #10;
        
        A = 8'd15;
        B = 8'd240;
        #10;
        
        A = 8'd0;
        B = 8'd0;
        #10;
        
        // Test 3: ADD operation (ALUOp = 010)
        ALUOp = 3'b010;
        A = 8'd10;
        B = 8'd20;
        #10;
        
        A = 8'd100;
        B = 8'd50;
        #10;
        
        // ADD with overflow (carry test)
        A = 8'd255;
        B = 8'd1;
        #10;
        
        A = 8'd200;
        B = 8'd100;
        #10;
        
        // ADD resulting in zero
        A = 8'd0;
        B = 8'd0;
        #10;
        
        // Test 4: SUBTRACT operation (ALUOp = 011)
        ALUOp = 3'b011;
        A = 8'd50;
        B = 8'd30;
        #10;
        
        A = 8'd100;
        B = 8'd100;
        #10;
        
        A = 8'd10;
        B = 8'd20;
        #10;
        
        A = 8'd255;
        B = 8'd1;
        #10;
        
        A = 8'd128;
        B = 8'd64;
        #10;
        
        // Test 5: AND operation (ALUOp = 100)
        ALUOp = 3'b100;
        A = 8'b11110000;
        B = 8'b10101010;
        #10;
        
        A = 8'd255;
        B = 8'd15;
        #10;
        
        A = 8'd170;
        B = 8'd85;
        #10;
        
        A = 8'd255;
        B = 8'd0;
        #10;
        
        // Test 6: XOR operation (ALUOp = 101)
        ALUOp = 3'b101;
        A = 8'b11110000;
        B = 8'b10101010;
        #10;
        
        A = 8'd255;
        B = 8'd255;
        #10;
        
        A = 8'd170;
        B = 8'd85;
        #10;
        
        A = 8'd0;
        B = 8'd0;
        #10;
        
        // Test 7: SHIFT LEFT operation (ALUOp = 110)
        ALUOp = 3'b110;
        A = 8'd1;
        B = 8'd0;
        #10;
        
        A = 8'd1;
        B = 8'd1;
        #10;
        
        A = 8'd1;
        B = 8'd4;
        #10;
        
        A = 8'd5;
        B = 8'd2;
        #10;
        
        A = 8'd15;
        B = 8'd3;
        #10;
        
        A = 8'd128;
        B = 8'd1;
        #10;
        
        // Test 8: SHIFT RIGHT operation (ALUOp = 111)
        ALUOp = 3'b111;
        A = 8'd128;
        B = 8'd0;
        #10;
        
        A = 8'd128;
        B = 8'd1;
        #10;
        
        A = 8'd64;
        B = 8'd2;
        #10;
        
        A = 8'd255;
        B = 8'd4;
        #10;
        
        A = 8'd1;
        B = 8'd1;
        #10;
        
        A = 8'd240;
        B = 8'd3;
        #10;
        
        // Test 9: Comprehensive test - all operations with same inputs
        A = 8'd42;
        B = 8'd10;
        
        ALUOp = 3'b000; #10; // Pass
        ALUOp = 3'b001; #10; // OR
        ALUOp = 3'b010; #10; // ADD
        ALUOp = 3'b011; #10; // SUB
        ALUOp = 3'b100; #10; // AND
        ALUOp = 3'b101; #10; // XOR
        ALUOp = 3'b110; #10; // SLL
        ALUOp = 3'b111; #10; // SRL
        
        // Test 10: Edge cases
        A = 8'd0;
        B = 8'd255;
        
        ALUOp = 3'b000; #10;
        ALUOp = 3'b001; #10;
        ALUOp = 3'b010; #10;
        ALUOp = 3'b011; #10;
        ALUOp = 3'b100; #10;
        ALUOp = 3'b101; #10;
        ALUOp = 3'b110; #10;
        ALUOp = 3'b111; #10;
        
        // Test 11: Maximum values
        A = 8'd255;
        B = 8'd255;
        
        ALUOp = 3'b000; #10;
        ALUOp = 3'b001; #10;
        ALUOp = 3'b010; #10;
        ALUOp = 3'b011; #10;
        ALUOp = 3'b100; #10;
        ALUOp = 3'b101; #10;
        
        // Test 12: Zero flag testing
        ALUOp = 3'b011; // Subtract to get zero
        A = 8'd50;
        B = 8'd50;
        #10;
        
        ALUOp = 3'b100; // AND to get zero
        A = 8'd170;
        B = 8'd85;
        #10;
        
        ALUOp = 3'b101; // XOR to get zero
        A = 8'd100;
        B = 8'd100;
        #10;

    end
endmodule
