module mul4 (
  input logic[3:0] a,
  input logic[3:0] b,
  output logic[7:0] r
);
  logic[3:0] out_0;
  logic[3:0] out_1;
  logic[3:0] out_2;
  logic[3:0] out_3;
  mul2 mul2_0(a[1:0], b[1:0], out_0);
  mul2 mul2_1(a[3:2], b[1:0], out_1);
  mul2 mul2_2(a[1:0], b[3:2], out_2); 
  mul2 mul2_3(a[3:2], b[3:2], out_3);
  assign r = out_0 + ((out_1 + out_2) << 2) + out_3 << 4;
endmodule