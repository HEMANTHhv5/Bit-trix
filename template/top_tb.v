# your testbench to ensure functionality...


`timescale 1ns/1ps
module top_tb;

reg clk, rst;
reg [7:0] instr;

top u_top(
    .clk(clk),
    .rst(rst),
    .instr(instr)
);

always #5 clk = ~clk;

localparam OPCODE_LOAD_IMM = 4'b0111;
localparam OPCODE_ADD      = 4'b0001;
localparam OPCODE_STORE    = 4'b0110;
localparam OPCODE_LOAD     = 4'b0101;

initial begin
    clk = 0; rst = 1; instr = 0; #10;
    rst = 0;

    $display("\n--- START TEST ---\n");

    // R0 = 5
    instr = {OPCODE_LOAD_IMM, 2'b00, 2'b01}; #10;
    // R1 = 3
    instr = {OPCODE_LOAD_IMM, 2'b01, 2'b11}; #10;
    // R2 = R0 + R1
    instr = {OPCODE_ADD, 2'b10, 2'b01}; #10;
    // Store R2 -> RAM[0]
    instr = {OPCODE_STORE, 2'b10, 2'b00}; #10;
    // Load RAM[0] -> R3
    instr = {OPCODE_LOAD, 2'b11, 2'b00}; #10;

    #10;
    $display("\n--- TEST COMPLETE ---\n");
    $display("RAM[0] = %0d", u_top.u_ram.mem[0]);
    $display("R0 = %0d", u_top.rf.reg_mem[0]);
    $display("R1 = %0d", u_top.rf.reg_mem[1]);
    $display("R2 = %0d", u_top.rf.reg_mem[2]);
    $display("R3 = %0d", u_top.rf.reg_mem[3]);

    $finish;
end

endmodule
