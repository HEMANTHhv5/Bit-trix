module reg_file (
    input clk,
    input rst,
    input wr_en,
    input [1:0] rd_addr,
    input [1:0] rs1_addr,
    input [1:0] rs2_addr,
    input [7:0] wr_data,
    output [7:0] rs1_data,
    output [7:0] rs2_data
);

reg [7:0] reg_mem [0:3];
integer i;

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 4; i = i + 1)
            reg_mem[i] <= 0;
    end
    else if (wr_en) begin
        reg_mem[rd_addr] <= wr_data;
    end
end

assign rs1_data = reg_mem[rs1_addr];
assign rs2_data = reg_mem[rs2_addr];

endmodule
