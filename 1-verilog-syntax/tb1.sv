module testbench();
    logic x;

    initial begin
        x=0;
        #4;   /* Delay for 4 timeunits */
        x=1;
        #3;   /* Delay for 3 timeunits */
        x=0;
        #2; /* Delay for 2 timeunits */
        x=1;
        #1; /* Delay for 1 timeunit */
        x=0;
    end

    initial begin
        @(posedge x);
        $display("x went high at time %t", $time);

        @(negedge x);
        $display("x went low at time %t", $time);

        @(posedge x);
        $display("x went high at time %t", $time);

        @(negedge x);
        $display("x went low at time %t", $time);
    end
endmodule
