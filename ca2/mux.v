`timescale 1ns / 1ps
module mux(
    input wire [31:0] a_true, b_false,
    input wire sel,
    output wire [31:0] y
);
    assign y = (sel) ? a_true : b_false;
endmodule
