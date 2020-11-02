module mul8 (
  input logic[7:0] a,
  input logic[7:0] b,
  output logic[15:0] r
);
  logic[7:0] out_0;
  logic[7:0] out_1;
  logic[7:0] out_2;
  logic[7:0] out_3;
  mul4 mul4_0(a[3:0], b[3:0], out_0);
  mul4 mul4_1(a[7:4], b[3:0], out_1);
  mul4 mul4_2(a[3:0], b[7:4], out_2); 
  mul4 mul4_3(a[7:4], b[7:4], out_3);
  assign r = out_0 + ((out_1 + out_2) << 4) + (out_3 << 8);
endmodule