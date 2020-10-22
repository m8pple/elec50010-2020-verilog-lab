module ff(input logic clk, output logic q, input logic d);
    always_ff @(posedge clk) begin  
        q <= d;
    end
endmodule

module ff_tb();
    logic clk, d, q;

    /* Clock generator */
    initial begin 
        $dumpfile("ff_tb.vcd");
        $dumpvars(0, ff_tb);

        clk=0;
        repeat (10) begin
            #2;
            clk=!clk;
        end
        $finish(0);
    end

    /* Module under test */
    ff dut(.clk(clk), .d(d), .q(q));

    /* Non-synthesisable test-bench */
    initial begin 
        d=0;
        @(posedge clk);
        #1;
        assert(q==0);
        #2;

        d=1;
        @(posedge clk);
        #1;
        assert(q==1);
        #2;

        d=0;
        @(posedge clk);
        #1;
        assert(q==0);
    end

    
endmodule
