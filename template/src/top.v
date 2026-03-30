module top(
    input clk,
    input rst,
    input [7:0] instr
);

wire [3:0] opcode;
wire [1:0] rd, rs1, rs2, imm;
wire reg_wr_en, alu_en, mem_wr_en, mem_rd_en;
wire [2:0] alu_op;
wire [7:0] rs1_data, rs2_data, alu_result, mem_data_out;
reg  [7:0] reg_wr_data;

// ---------------- DECODER ----------------
instr_decoder u_decoder (
    .instr(instr),
    .opcode(opcode),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .imm(imm),
    .reg_wr_en(reg_wr_en),
    .alu_en(alu_en),
    .mem_wr_en(mem_wr_en),
    .mem_rd_en(mem_rd_en),
    .alu_op(alu_op)
);

// ---------------- REGISTER FILE ----------------
reg_file rf(
    .clk(clk),
    .rst(rst),
    .wr_en(reg_wr_en),
    .rd_addr(rd),
    .rs1_addr(rs1),
    .wr_data(reg_wr_data),
    .rs1_data(rs1_data)
);

// ---------------- ALU ----------------
alu alu1(
    .a(rs1_data),
    .b(rs2_data),
    .alu_op(alu_op),
    .result(alu_result)
);

assign rs2_data = rf.reg_mem[rs2]; // Proper second register operand

// ---------------- RAM ----------------
ram u_ram(
    .clk(clk),
    .wr_en(mem_wr_en),
    .addr({6'b0, rs2}),
    .wr_data(rs1_data),
    .rd_data(mem_data_out)
);

// ---------------- WRITE BACK ----------------
always @(*) begin
    if(mem_rd_en)
        reg_wr_data = mem_data_out;
    else if(alu_en)
        reg_wr_data = alu_result;
    else if(opcode == 4'b0111)
        reg_wr_data = {6'b0, imm};
    else
        reg_wr_data = 8'd0;
end

// ---------------- DISPLAY ----------------
always @(posedge clk) begin
    if(reg_wr_en)
        $display("WRITE REG: R%0d = %0d", rd, reg_wr_data);
    if(alu_en)
        $display("ALU OP: a=%0d b=%0d result=%0d", rs1_data, rs2_data, alu_result);
    if(mem_wr_en)
        $display("RAM WRITE: ADDR=%0d DATA=%0d", rs2, rs1_data);
    if(mem_rd_en)
        $display("RAM READ: ADDR=%0d DATA=%0d", rs2, mem_data_out);
end

endmodule

// ---------------- REGISTER FILE ----------------
module reg_file(
    input clk,
    input rst,
    input wr_en,
    input [1:0] rd_addr,
    input [1:0] rs1_addr,
    input [7:0] wr_data,
    output reg [7:0] rs1_data
);
reg [7:0] reg_mem[0:3];
integer i;

always @(posedge clk) begin
    if(rst)
        for(i=0;i<4;i=i+1) reg_mem[i]<=0;
    else if(wr_en)
        reg_mem[rd_addr] <= wr_data;
end

always @(*) rs1_data = reg_mem[rs1_addr];

endmodule

// ---------------- RAM ----------------
module ram#(
    parameter DEPTH=256,
    parameter ADDR_WIDTH=8
)(
    input clk,
    input wr_en,
    input [ADDR_WIDTH-1:0] addr,
    input [7:0] wr_data,
    output reg [7:0] rd_data
);
reg [7:0] mem[0:DEPTH-1];
always @(posedge clk) begin
    if(wr_en) mem[addr] <= wr_data;
    rd_data <= mem[addr];
end
endmodule
