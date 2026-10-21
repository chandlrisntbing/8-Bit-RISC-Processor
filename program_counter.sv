`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 19:56:15
// Design Name: 
// Module Name: program_counter
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


module program_counter (
input logic Clock , nReset ,
input logic Taken ,
input logic [7:0] Bamt ,
output logic [7:0] PC
);
    always_ff @(posedge Clock or negedge nReset)
    begin
        if (!nReset)
            PC <= 8'b00000000;
        else if (Taken)
            PC <= PC+Bamt;
        else
            PC <= PC+ 1;
    end

endmodule

