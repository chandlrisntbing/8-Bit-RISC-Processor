`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 19:19:05
// Design Name: 
// Module Name: alu
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


module alu(
    input logic [2:0] ALUOp,
    input logic [7:0] A, B,
    output logic [7:0] result,
    output logic Zero, Carry
);

    logic [8:0] temp_result;
    
    always_comb begin
        temp_result = 9'b0;
        Carry = 1'b0;
        
        case (ALUOp)
            3'b000: begin // Pass
                result = B;
                Carry = 1'b0;
            end
            
            3'b001: begin // Or
                result = A | B;
                Carry = 1'b0;
            end
            
            3'b010: begin // Add
                temp_result = {1'b0, A} + {1'b0, B};
                result = temp_result[7:0];
                Carry = temp_result[8]; // Carry out
            end
            
            3'b011: begin // Subtract
                temp_result = A-B;
                result = temp_result[7:0];
                Carry = temp_result[8]; // Inverted due to twos complement used 
            end
            
            3'b100: begin // AND
                result = A & B;
                Carry = 1'b0;
            end
            
            3'b101: begin // XOR
                result = A ^ B;
                Carry = 1'b0;
            end
            
            3'b110: begin // Shift Left
                result = A << B;
                Carry = 1'b0;
            end
            
            3'b111: begin // Shift Right
                result = A >> B;
                Carry = 1'b0;
            end
            
            default: begin
                result = 8'b0;
                Carry = 1'b0;
            end
        endcase
        
        // Zero flag: high when result is zero
        Zero = (result == 8'b0);
    end
endmodule

