
module multiplier_pipelined(
    input clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic[63:0] r
);

    logic [31:0] pp_lo_lo;
    logic [31:0] pp_hi_lo;
    logic [31:0] pp_lo_hi;
    logic [31:0] pp_hi_hi;

    logic[15:0] a_hi, a_lo, b_hi, b_lo;
    
    assign a_hi = a[31:16];
    assign a_lo = a[15:0];
    assign b_hi = b[31:16];
    assign b_lo = b[15:0];

    always_ff @(posedge clk) begin
        pp_lo_lo <= a_lo * b_lo;
        pp_hi_lo <= a_hi * b_lo;
        pp_lo_hi <= a_lo * b_hi;
        pp_hi_hi <= a_hi * b_hi;

        r <= { pp_hi_hi , 32'h00000000}
             + 
             { 32'h00000000, pp_lo_lo}
             +
             { 16'h0000, pp_hi_lo, 16'h0000}
             +
             { 16'h0000, pp_lo_hi, 16'h0000};
    end
    
endmodule
