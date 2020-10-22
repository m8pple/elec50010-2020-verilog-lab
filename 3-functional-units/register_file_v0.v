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

    always_comb begin
        if (reset==1)               read_data_a = 0;
        else if(read_index_a==0)    read_data_a = reg0;
        else if(read_index_a==1)    read_data_a = reg1;
        else if(read_index_a==2)    read_data_a = reg2;
        else if(read_index_a==3)    read_data_a = reg3;
        else                        read_data_a = 16'hxxxx;
    end

    logic[15:0] value;
    assign value = reset==1 ? 0 : write_data;

    always @(posedge clk) begin
        if (reset==1 || (write_index==0 && write_enable==1)) reg0 <= value;
        if (reset==1 || (write_index==1 && write_enable==1))  reg1 <= value;
        if (reset==1 || (write_index==2 && write_enable==1))  reg2 <= value;
        if (reset==1 || (write_index==3 && write_enable==1))  reg3 <= value;
    end

endmodule