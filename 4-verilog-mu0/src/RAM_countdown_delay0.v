/*  Implements a program that implements the "countdown" program
    in direct logic, without a backing RAM. So it is hard-coded
    to return instructions, and returns an error if any other
    addresses are accessed. Any attempts to write also cause
    an error.
*/
module RAM_countdown_delay0(
    input logic clk,
    input logic[11:0] address,
    input logic write,
    input logic read,
    input logic[15:0] writedata,
    output logic[15:0] readdata
);
    always_comb begin
        case(address)
        0 : readdata = 16'h0004;
        1 : readdata = 16'h2005;
        2 : readdata = 16'h6001;
        3 : readdata = 16'h7000;
        4 : readdata = 16'h000A;
        5 : readdata = 16'hFFFF;
        default : readdata = 16'hXXXX;
        endcase
    end

    always @(posedge clk) begin
        if (write) begin
            $fatal(2, "CPU attempted to write to RAM.");
        end
        if (address > 5) begin
            $fatal(2, "CPU attempted to access unexpected address.");
        end
    end
endmodule