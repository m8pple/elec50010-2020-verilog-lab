


module multiplier_parallel_tb(
);
    logic clk;
    logic[31:0] a, b;
    logic[63:0] r;
    logic valid_in, valid_out;

    initial begin
        $dumpfile("multiplier_parallel.vcd");
        $dumpvars(0, multiplier_parallel_tb);
        clk = 0;

        #5;

        repeat (3700) begin
            #10 clk = !clk;
        end

        $finish;
    end

    initial begin
        a = 0;
        b = 0;

        repeat (100) begin
            @(negedge clk)
            $display("a=%d, b=%d, r=%d", a, b, r);
            assert(a*b == r) else $fatal(1, "Product is wrong.");

            a = a+32'h23456789;
            b = b+32'h34567891;
        end

        $finish;
    end

    multiplier_parallel m(
        .clk(clk),
        .a(a), .b(b), .r(r)
    );
endmodule
