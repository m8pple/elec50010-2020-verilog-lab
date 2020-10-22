module or_tb();

    logic a, b, r;

    initial begin
        $dumpfile("or.vcd");
        $dumpvars(0, or_tb);

        a=1;
        b=1;
        #1;
        assert(r==1);

        a=1;
        b=0;
        #1;
        assert(r==1);

        a=0;
        b=1;
        #1;
        assert(r==1);

        a=0;
        b=0;
        #1;
        assert(r==0);
    end

    or_gate dut(a,b,r);

endmodule