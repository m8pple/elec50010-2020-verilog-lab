module hamming2(
    input logic[1:0] x,
    output logic[1:0] count
);
    always_comb begin
        case(x)
        0:  count=0;
        1:  count=1;
        2:  count=1;
        3:  count=2;
        endcase
    end
endmodule