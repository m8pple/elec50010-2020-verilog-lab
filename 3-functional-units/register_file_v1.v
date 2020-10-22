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

    logic[15:0] reg0, reg1, reg2, reg3;

    always_comb begin
        if (reset==1) begin 
            read_data_a = 0;
        end
        else begin
            case(read_index_a)
            0:  read_data_a = reg0;
            1:  read_data_a = reg1;
            2:  read_data_a = reg2;
            3:  read_data_a = reg3;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (reset==1) begin
            reg0 <= 0;
            reg1 <= 0;
            reg2 <= 0;
            reg3 <= 0;
        end
        else if (write_enable==1) begin
            case(write_index)
                0: reg0 <= write_data;
                1: reg1 <= write_data;
                2: reg2 <= write_data;
                3: reg3 <= write_data;
            endcase
        end
    end

endmodule