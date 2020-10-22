
module multiplier_pipelined(
    input clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic[63:0] r
);

    logic [31:0] a_reg, b_reg;

    always_ff @(posedge clk) begin
        a_reg <= a;
        b_reg <= b;
        r <= a_reg * b_reg;
    end

endmodule
