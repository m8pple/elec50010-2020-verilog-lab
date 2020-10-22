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

    logic[15:0] regs[3:0];

    /*  Can be useful to bring array signals out - allows us to view them in waveforms.
        Will be optimised out for synthesis.
    */
    logic[15:0] reg_0, reg_1;
    assign reg_0 = regs[0];
    assign reg_1 = regs[1];

    assign read_data_a = reset==1 ? 0 : regs[read_index_a];

    integer index;
    always @(posedge clk) begin
        if (reset==1) begin
            for (index=0; index<4; index=index+1) begin
                regs[index]<=0;
            end
        end
        else if (write_enable==1) begin
            regs[write_index] <= write_data;
        end
    end

endmodule