`timescale 1ns / 1ps
module fetch_tb;

    // Testbench signals
    reg clk = 0;
    reg rst;
    reg ex_mem_pc_src;
    reg [31:0] ex_mem_npc;
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;

    // Debug wires to catch internal signals
    wire [31:0] pc_out_dbg;
    wire [31:0] next_pc_dbg;
    wire [31:0] instr_data_dbg;

    // Instantiate the IF stage
    fetch dut (
        .clk(clk),
        .rst(rst),
        .ex_mem_pc_src(ex_mem_pc_src),
        .ex_mem_npc(ex_mem_npc),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .pc_out_dbg(pc_out_dbg),
        .next_pc_dbg(next_pc_dbg),
        .instr_data_dbg(instr_data_dbg)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        //Initialize signals
        rst = 1;
        ex_mem_pc_src = 0;
        ex_mem_npc = 32'h00000000;

        //reset
        #15;
        rst = 0;

        // --- Step through a few clock cycles ---
        repeat (5) begin
            #10;
        end

        //Simulate branch
        ex_mem_pc_src = 1;
        ex_mem_npc = 32'h00000020; // branch target address
        #10;

        ex_mem_pc_src = 0;
        #50;

        $stop;
    end

    initial begin
        $monitor("Time: %0t | pc_out: %h | next_pc: %h | instr_data: %h | if_id_npc: %h | if_id_instr: %h",
                  $time, pc_out_dbg, next_pc_dbg, instr_data_dbg, if_id_npc, if_id_instr);
    end

endmodule
