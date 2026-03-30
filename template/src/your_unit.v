module alu_unit #(parameter WIDTH = 8) (
    input clk,
    input rst,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [2:0] alu_op,
    output reg [WIDTH-1:0] out
);

    reg [WIDTH-1:0] acc;  // for MAC

    // -------- ACCUMULATOR (sequential only for MAC) --------
    always @(posedge clk or posedge rst) begin
        if (rst)
            acc <= 0;
        else if (alu_op == 3'b110)  // MAC
            acc <= acc + (a * b);
    end

    // -------- ALU (combinational) --------
    always @(*) begin
        case (alu_op)
            3'b000: out = a + b;   // ADD
            3'b001: out = a - b;   // SUB
            3'b010: out = a & b;   // AND
            3'b011: out = a | b;   // OR
            3'b100: out = a ^ b;   // XOR
            3'b101: out = a * b;   // MUL
            3'b110: out = acc;     // MAC
            default: out = 0;
        endcase
    end

endmodule
