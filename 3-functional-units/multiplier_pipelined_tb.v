

module multiplier_pipelined_tb(
);
    logic clk;
    logic[31:0] a, b;
    logic[63:0] r;

    localparam integer STEPS = 10000;

    initial begin
        $dumpfile("multiplier_pipelined_tb.vcd");
        $dumpvars(0, multiplier_pipelined_tb);

        clk = 0;
        #5;
        forever begin
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    /* Inject stimulus into test-bench */
    initial begin
        a = 0;
        b = 0;

        repeat (STEPS) begin
            @(posedge clk)

            // Inject stimulus 1ns before clock edge
            #9;
            a = a+32'h23456789;
            b = b+32'h34567891;
        end
    end

    logic[31:0] a_d1, b_d1;
    logic[31:0] a_d2, b_d2;

    /* Delay inputs by two cycles */
    always_ff @(posedge clk) begin
        a_d1 <= a;
        b_d1 <= b;
        a_d2 <= a_d1;
        b_d2 <= b_d1;
    end

    /* Check output of test-bench */
    initial begin
        @(posedge clk);

        repeat (STEPS) begin
            @(posedge clk)
            // Collect output 1ns after clock edge
            #1;
            $display("a=%d, b=%d, r=%d", a, b, r);
            assert( r == a_d2 * b_d2 ) else $fatal(2, "Wrong output.");
        end

        $finish;
    end

    multiplier_pipelined m(
        .clk(clk), .a(a), .b(b), .r(r)
    );
endmodule
