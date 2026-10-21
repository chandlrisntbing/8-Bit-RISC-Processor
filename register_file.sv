`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 20:15:59
// Design Name: 
// Module Name: register_file
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


module register_file (
    input  logic Clock, nReset,
    input  logic WB,
    input  logic [3:0] Rd, Ra, Rb,
    input  logic [7:0] Data,
    output logic [7:0] A, B,
    output logic [7:0] LED0, LED1
);

    //  register file contains 16 registers of 8 bit length
    logic [7:0] registers [0:15];
    
    // writes are synchronous
    always_ff @(posedge Clock or negedge nReset) begin
        if (!nReset) begin
            // Reset: Clear all registers to 0
            for (int i = 0; i < 16; i++) begin
                registers[i] <= 8'b0;
            end
        end
        else if (WB) begin
            // Writes data to register Rd (as mentioned in the specification) ,but not if Rd is R0 or R1
            if (Rd != 4'd0 && Rd != 4'd1) begin
                registers[Rd] <= Data;
            end
            // Writes to R0 and R1 are ignored if any hardcoded values
        end
    end
    
    // COMBINATORIAL READ 
    always_comb begin
        if (Ra == 4'd0)  // R0 always outputs 0 (hardcoded)
            A = 8'b0;
        else if (Ra == 4'd1) // R1 always outputs 1 (hardcoded)
            A = 8'd1;
        else // R2-R15 output their stored value
            A = registers[Ra];
        
        // Same logic for B
        if (Rb == 4'd0)
            B = 8'b0;
        else if (Rb == 4'd1)
            B = 8'd1;
        else
            B = registers[Rb];
    end
    
    // LED outputs always show R14 and R15
    assign LED0 = registers[14];
    assign LED1 = registers[15];

endmodule
