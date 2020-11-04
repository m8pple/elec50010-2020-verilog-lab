module ff(
    input logic ce,
    input c,
    input logic d,
    output logic q
);
    always_ff @(posedge c) if(ce==1) begin
      q = d;
    end

endmodule