module hamming4(
    input logic[3:0] x,
    output logic[2:0] count
);
    logic[2:0] count_lo;
    logic[2:0] count_hi;

    assign count_lo[2]=0;
    assign count_hi[2]=0;
    hamming2 lo(x[1:0], count_lo[1:0]);
    hamming2 hi(x[3:2], count_hi[1:0]);

    assign count = count_lo + count_hi;
endmodule