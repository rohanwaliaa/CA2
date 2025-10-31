`timescale 1ns / 1ps
module ifIdLatch(
    input wire clk, rst,
    input wire [31:0] pc_in, instr_in,
    output reg [31:0] pc_out, instr_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_out <= 32'b0;
            instr_out <= 32'b0;
        end else begin
            pc_out <= pc_in;
            instr_out <= instr_in;
        end
    end
endmodule
