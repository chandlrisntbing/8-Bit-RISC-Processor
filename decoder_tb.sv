`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 20:10:55
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb;
    logic [3:0] Opcode;
    logic [2:0] ALUOp;
    logic WB, ImmEnable, ImmType, Branch;
    
    // Instantiate decoder
    decoder dut (
        .Opcode(Opcode),
        .ALUOp(ALUOp),
        .WB(WB),
        .ImmEnable(ImmEnable),
        .ImmType(ImmType),
        .Branch(Branch)
    );
    
    initial begin
        // Test B-type instruction
        Opcode = 4'b0000; #10; // beqz
        
        // Test R-type instructions
        Opcode = 4'b0001; #10; // or
        Opcode = 4'b0010; #10; // add
        Opcode = 4'b0011; #10; // sub
        Opcode = 4'b0100; #10; // and
        Opcode = 4'b0101; #10; // xor
        Opcode = 4'b0110; #10; // sll
        Opcode = 4'b0111; #10; // srl
        
        // Test L-type instructions
        Opcode = 4'b1000; #10; // li
        
        // Test I-type instructions
        Opcode = 4'b1001; #10; // ori
        Opcode = 4'b1010; #10; // addi
        Opcode = 4'b1011; #10; // subi
        Opcode = 4'b1100; #10; // andi
        Opcode = 4'b1101; #10; // xori
        Opcode = 4'b1110; #10; // slli
        Opcode = 4'b1111; #10; // srli
        
        #10;
    end
endmodule

