module ff(
    input logic clock,
    input logic d,
    output logic q
);
    always @(posedge clock) begin
        q <= d;
    end

endmodule