module or_gate(
    input logic a,
    input logic b,
    output logic r
);

    always_comb begin
      r = 0;
      if(a==1) r = 1;
      if(b==1) r = 1;
    end

endmodule