module add_sub_logic(
    input logic[1:0] op,
    input logic[15:0] a,
    input logic[15:0] b,
    output logic[15:0] r
);
    logic[15:0] adder_a, adder_b;
    logic adder_cin;
    logic[16:0] adder_r;

    always_comb begin
        case(op)
        0:  begin adder_a = a;    adder_b = b;    adder_cin = 0; end
        1:  begin adder_a = a;    adder_b = ~b;   adder_cin = 1; end
        2:  begin adder_a = 0;    adder_b = ~b;    adder_cin = 0; end
        3:  begin adder_a = a;    adder_b = ~b;   adder_cin = 1; end
        endcase
    end

    add16 adder(
        .x(adder_a),
        .y(adder_b),
        .cin(adder_cin),
        .r(adder_r)
    );

    assign r = (op==3) ? adder_r[16] : adder_r[15:0];

endmodule