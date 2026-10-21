`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 20:10:35
// Design Name: 
// Module Name: decoder
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


module decoder (
    input  logic [3:0] Opcode,
    output logic [2:0] ALUOp,
    output logic WB, ImmEnable, ImmType, Branch
);

    always_comb begin
        // Default values
        ALUOp = 3'b000;
        WB = 1'b0;
        ImmEnable = 1'b0;
        ImmType = 1'b0;
        Branch = 1'b0;
        
        case (Opcode)
            // B-type instruction involving Beqt
            4'b0000: begin // beqz
                ALUOp = 3'b000;      // passthrough
                WB = 1'b0;           // no write back
                ImmEnable = 1'b0;    // uses register Rb
                ImmType = 1'b0;      // don't care
                Branch = 1'b1;       // is a branch
            end
            
            // R-type instructions (0001-0111) involving the registers
            4'b0001: begin // or
                ALUOp = 3'b001;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;      // don't care
                Branch = 1'b0;
            end
            
            4'b0010: begin // add
                ALUOp = 3'b010;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b0011: begin // sub
                ALUOp = 3'b011;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b0100: begin // and
                ALUOp = 3'b100;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b0101: begin // xor
                ALUOp = 3'b101;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b0110: begin // sll (shift left logical)
                ALUOp = 3'b110;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b0111: begin // srl (shift right logical)
                ALUOp = 3'b111;
                WB = 1'b1;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            // L-type instruction (L denotes the load immediate)
            4'b1000: begin // li (load immediate)
                ALUOp = 3'b000;      // passthrough
                WB = 1'b1;           // writes to Rd
                ImmEnable = 1'b1;    // uses immediate
                ImmType = 1'b1;      // L-type encoding
                Branch = 1'b0;
            end
            
            // I-type instructions (1001-1111) (I denotes the Immediate operations) 
            4'b1001: begin // ori
                ALUOp = 3'b001;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;// I-type encoding
                Branch = 1'b0;
            end
            
            4'b1010: begin // addi
                ALUOp = 3'b010;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b1011: begin // subi
                ALUOp = 3'b011;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b1100: begin // andi
                ALUOp = 3'b100;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b1101: begin // xori
                ALUOp = 3'b101;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b1110: begin // slli
                ALUOp = 3'b110;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            4'b1111: begin // srli
                ALUOp = 3'b111;
                WB = 1'b1;
                ImmEnable = 1'b1;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
            
            default: begin // default values in case inputs arent added
                ALUOp = 3'b000;
                WB = 1'b0;
                ImmEnable = 1'b0;
                ImmType = 1'b0;
                Branch = 1'b0;
            end
        endcase
    end

endmodule
