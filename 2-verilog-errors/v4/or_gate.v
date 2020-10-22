module or_gate(
    input logic a,
    input logic b,
    output logic  r
);

    always_comb begin
        if (a==1 && b==1) begin
            r = 1;
        end
        if (a==1) begin
            r = 1;
        end
        if (b==1) begin
            r = 1;
        end
    end

endmodule