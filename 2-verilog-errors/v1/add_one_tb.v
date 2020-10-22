

module add_one_tb(
);

    logic [8:0] x;
    logic [8:0] y_expected;
    wire logic [8:0] y;

    initial begin
        $dumpfile("add_one_tb.vcd");
        $dumpvars(0, add_one_tb);


        x = 0;
        y_expected = 1;
        repeat (256) begin
            #1;
            assert(y==y_expected) else $fatal(1, "x = %d, got %d", x, y);

            #1;
            x = x + 17;
            y_expected = x + 1;
        end

    end

    
    add_one dut(
        .x(x),
        .y(y)
    );

endmodule