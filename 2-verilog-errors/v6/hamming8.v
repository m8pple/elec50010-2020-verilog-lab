module hamming8(
    input logic[7:0] x,
    output logic[3:0] count
);
    logic[2:0] count_lo;
    logic[2:0] count_hi;

    hamming4 lo(x[3:0], count_lo);
    hamming4 hi(x[7:4], count_hi);

    assign count = {1'b0,count_lo} + {1'b0,count_hi};
endmodule