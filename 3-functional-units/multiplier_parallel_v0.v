module mul2 (
  input logic[1:0] a,
  input logic[1:0] b,
  output logic[3:0] r
);
  logic[1:0] out_0;
  logic[1:0] out_1;
  logic[1:0] out_2;
  logic[1:0] out_3;
  assign out_0 = a[0] & b[0];
  assign out_1 = a[0] & b[1];
  assign out_2 = a[1] & b[0];
  assign out_3 = a[1] & b[1];
  always @ * begin
    r <= ((((out_3 << 1) + out_1 + out_2) << 1) + out_0);
  end
endmodule

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
  always @ * begin
    r <= ((((out_3 << 2) + out_1 + out_2) << 2) + out_0);
  end
endmodule

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
  always @ * begin
    r <= ((((out_3 << 4) + out_1 + out_2) << 4) + out_0);
  end
endmodule

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
  always @ * begin
    r <= ((((out_3 << 8) + out_1 + out_2) << 8) + out_0);
  end
endmodule

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