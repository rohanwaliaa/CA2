`timescale 1ns / 1ps
module pc(
    input wire clk, rst,
    input wire [31:0] pc_in,
    output reg [31:0] pc_out
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_out <= 32'b0;
        else
            pc_out <= pc_in;
    end
endmodule
