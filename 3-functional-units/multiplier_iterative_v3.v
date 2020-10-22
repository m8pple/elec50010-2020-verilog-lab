
module multiplier_iterative(
    input clk,
    input logic valid_in,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic valid_out,
    output logic[63:0] r
);
    always_ff  @(posedge clk) begin
        valid_out <= valid_in;
        r <= a*b;
    end
endmodule
