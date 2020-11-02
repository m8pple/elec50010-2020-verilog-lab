module mul2 (
  input logic[1:0] a,
  input logic[1:0] b,
  output logic[3:0] r
);
  wire out_0;
  wire out_1;
  wire out_2;
  wire out_3;
  assign out_0 = a[0] & b[0];
  assign out_1 = a[0] & b[1];
  assign out_2 = a[1] & b[0];
  assign out_3 = a[1] & b[1];
  assign r = out_0 + out_1 + out_2 << 1 + out_3 << 2;
endmodule