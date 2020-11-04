module add_sub_logic_tb();
    logic[1:0] op;
    logic[15:0] a;
    logic[15:0] b;
    logic[15:0] r;

    initial begin
        $dumpfile("add_sub_logic_tb.vcd");
        $dumpvars(0, add_sub_logic_tb);

        /* op==0 */
        /* a + b */

        op=0; a=2; b=3;
        #1;
        assert(r==a+b);

        op=0; a=100; b=200;
        #1;
        assert(r==a+b);

        /* op==1 */
        /* a - b */

        op=1; a=10; b=5;
        #1;
        assert(r==a-b);

        op=1; a=100; b=200;
        #1;
        assert(r==a-b);

        /* op==2    */
        /* invert b */

        op=2; a=7;  b=11;
        #1;
        assert(r ^ b == 0);

        op=2; a=11; b=7;
        #1;
        assert(r ^ b == 0);

        /* op==3           */
        /* Overflow Detect */

        //This seems to be the opposite of what it should be?

        op=3; a=3; b=10;
        #1;
        assert(r==b<a);

        op=3; a=10; b=3;
        #1;
        assert(r==b<a);
    end

    add_sub_logic dut(
        .op(op),
        .a(a),
        .b(b),
        .r(r)
    );

endmodule