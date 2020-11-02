module multiplier_parallel(
  input clk,
  input logic valid_in,
  input logic[31:0] a,
  input logic[31:0] b,
  output logic valid_out,
  output logic[63:0] r
);
  logic[31:0] out_0;
  logic[31:0] out_1;
  logic[31:0] out_2;
  logic[31:0] out_3;
  mul16 mul16_0(a[15:0], b[15:0], out_0);
  mul16 mul16_1(a[31:16], b[15:0], out_1);
  mul16 mul16_2(a[15:0], b[31:16], out_2); 
  mul16 mul16_3(a[31:16], b[31:16], out_3);
  always @ * begin
    r <= out_0 + ((out_1 + out_2) << 16) + (out_3 << 32);
    valid_out <= valid_in;
  end
endmodule