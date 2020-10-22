module add16(
    input logic[15:0] x,
    input logic[15:0] y,
    input logic cin,
    output logic[16:0] r
);

   assign r = x + y + cin;

endmodule