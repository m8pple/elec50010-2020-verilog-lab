module mul16 (
  input logic[15:0] a,
  input logic[15:0] b,
  output logic[31:0] r
);
  logic[15:0] out_0;
  logic[15:0] out_1;
  logic[15:0] out_2;
  logic[15:0] out_3;
  mul8 mul8_0(a[7:0], b[7:0], out_0);
  mul8 mul8_1(a[15:8], b[7:0], out_1);
  mul8 mul8_2(a[7:0], b[15:8], out_2); 
  mul8 mul8_3(a[15:8], b[15:8], out_3);
  assign r = out_0 + ((out_1 + out_2) << 16) + (out_3 << 32);
endmodule