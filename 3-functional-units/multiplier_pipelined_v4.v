
module multiplier_pipelined(
    input clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic[63:0] r
);

    logic [63:0] pp_q0_q0, pp_q0_q1, pp_q0_q2;
    logic [63:0] pp_q1_q0, pp_q1_q1, pp_q1_q2;
    logic [63:0] pp_q2_q0, pp_q2_q1, pp_q2_q2;

    logic[11:0] a_q2, a_q1, a_q0;
    logic[11:0] b_q2, b_q1, b_q0;
    
    assign a_q2 = a[31:22];
    assign a_q1 = a[21:11];
    assign a_q0 = a[10:0];
    assign b_q2 = b[31:22];
    assign b_q1 = b[21:11];
    assign b_q0 = b[10:0];

    always_ff @(posedge clk) begin
        pp_q0_q0 <= a_q0 * b_q0;    pp_q0_q1 <= a_q0 * b_q1;    pp_q0_q2 <= a_q0 * b_q2;
        pp_q1_q0 <= a_q1 * b_q0;    pp_q1_q1 <= a_q1 * b_q1;    pp_q1_q2 <= a_q1 * b_q2;
        pp_q2_q0 <= a_q2 * b_q0;    pp_q2_q1 <= a_q2 * b_q1;    pp_q2_q2 <= a_q2 * b_q2;

        r <=    pp_q0_q0 +
                ((pp_q0_q1 + pp_q1_q0)<<11) +
                ((pp_q0_q2 + pp_q1_q1 + pp_q2_q0)<<22) +
                ((pp_q1_q2 + pp_q2_q1)<<33) +
                ((pp_q2_q2)<<44);
    end
    
endmodule
