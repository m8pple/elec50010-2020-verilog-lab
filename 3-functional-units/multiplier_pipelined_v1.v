
module multiplier_pipelined(
    input clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic[63:0] r
);

    logic [32+8-1:0] acc0;
    logic [32+8-1:0] acc1;
    logic [32+8-1:0] acc2;
    logic [32+8-1:0] acc3;

    always_ff @(posedge clk) begin
        acc0 <= a * b[7:0];
        acc1 <= a * b[15:8];
        acc2 <= a * b[23:16];
        acc3 <= a * b[31:24];

        r <= { 24'h000000, acc0 }
            +
            { 16'h0000, acc1, 8'h00 }
            +
            { 8'h00, acc2, 16'h0000 }
            +
            { acc3, 24'h000000 };
    end
    
endmodule
