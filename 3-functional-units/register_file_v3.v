`timescale 1ns/100ps

module register_file(
    input logic clk,
    input logic reset,

    input logic[1:0]    read_index_a,
    output logic[15:0]  read_data_a,

    input logic[1:0]    write_index,
    input logic         write_enable,
    input logic[15:0]   write_data
);

    logic[15:0] reg0;
    logic[15:0] reg1;
    logic[15:0] reg2;
    logic[15:0] reg3;

    assign read_data_a = (reset==1) ? 0 :
                         (read_index_a==0) ? reg0 :
                         (read_index_a==1) ? reg1 : 
                         (read_index_a==2) ? reg2 :
                         (read_index_a==3) ? reg3 : 
                         16'hxxxx;

    always @(posedge clk) begin
        reg0 <= reset ? 0 : (write_enable && write_index==0) ? write_data : reg0;
        reg1 <= reset ? 0 : (write_enable && write_index==1) ? write_data : reg1;
        reg2 <= reset ? 0 : (write_enable && write_index==2) ? write_data : reg2;
        reg3 <= reset ? 0 : (write_enable && write_index==3) ? write_data : reg3;
    end

endmodule