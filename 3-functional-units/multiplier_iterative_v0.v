
module multiplier_iterative(
    input clk,
    input logic valid_in,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic valid_out,
    output logic[63:0] r
);
    logic[31:0] mp, mp_next;
    logic[63:0] mc, mc_next;
    logic[63:0] acc, acc_next;
    logic[5:0] i, i_next;

    // Note: using @(*) to get around reported bug in iverilog:
    //  multiplier_iterative_v0.v:15: sorry: constant selects in always_* processes are not currently supported (all bits will be included).
    always @(*) begin
        if (valid_in == 1) begin
            mp_next = a;
            mc_next = b;
            acc_next = 0;
            i_next = 0;
        end
        else if (i != 32) begin
            acc_next = acc + ( mp[0] ? mc : 0 );
            mp_next = mp>>1;
            mc_next = mc<<1;
            i_next = i + 1;
        end
    end

    always_ff @(posedge clk) begin
        mp <= mp_next;
        mc <= mc_next;
        acc <= acc_next;
        i <= i_next;
        if (i_next==32) begin
            r <= acc_next;
            valid_out <= 1;
        end
        else begin
            valid_out <= 0;
        end
    end
endmodule
