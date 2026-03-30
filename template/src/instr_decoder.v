module instr_decoder (
    input  [7:0] instr,
    output reg [3:0] opcode,
    output reg [1:0] rd,
    output reg [1:0] rs1,
    output reg [1:0] rs2,
    output reg [1:0] imm,
    output reg reg_wr_en,
    output reg alu_en,
    output reg mem_wr_en,
    output reg mem_rd_en,
    output reg [2:0] alu_op
);

always @(*) begin
    opcode = instr[7:4];
    rd     = instr[3:2];
    rs1    = instr[3:2]; // For simplicity, rs1 = rd
    rs2    = instr[1:0]; // source or memory addr
    imm    = instr[1:0]; // immediate value

    // default signals
    reg_wr_en   = 0;
    alu_en      = 0;
    mem_wr_en   = 0;
    mem_rd_en   = 0;
    alu_op      = 3'b000;

    case(opcode)
        4'b0001: begin // ADD
            alu_en    = 1;
            alu_op    = 3'b000;
            reg_wr_en = 1;
        end
        4'b0010: begin // SUB
            alu_en    = 1;
            alu_op    = 3'b001;
            reg_wr_en = 1;
        end
        4'b0101: begin // LOAD
            mem_rd_en = 1;
            reg_wr_en = 1;
        end
        4'b0110: begin // STORE
            mem_wr_en = 1;
        end
        4'b0111: begin // LOAD_IMM
            reg_wr_en = 1;
        end
    endcase
end

endmodule
