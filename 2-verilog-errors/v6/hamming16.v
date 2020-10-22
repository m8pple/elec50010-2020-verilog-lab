module hamming16(
    input[15:0] x,
    output[4:0] count
);
    logic[3:0] count_lo;
    logic[3:0] count_hi;
    logic [3:0] count_sum;

    hamming8 lo(x[7:0], count_lo[3:0]);
    hamming8 hi(x[15:8], count_hi[3:0]);

    always_comb begin
        count_sum = count_lo + count_hi;
    end

    assign count = count_sum;
endmodule