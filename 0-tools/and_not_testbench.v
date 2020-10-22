module and_not_testbench();
    logic a;
    logic b;
    logic c;
    logic d;

    initial begin
        /* INSERT WAVEFORM COMMANDS */

        a=0;
        b=0;
        #1; // Delay one timeunit
        /* INSERT $display HERE */
        /* INSERT assert HERE */
        $display("a=%d, b=%d, r=%d", a, b, d);
        assert(d==1);
        
        a=0;
        b=1;
        #1; // Delay one timeunit
        assert(d==1);

        a=1;
        b=0;
        #1; // Delay one timeunit
        assert(d==1);

        a=1;
        b=1;
        #1; // Delay one timeunit
        assert(d==0);
    end

    and_gate n1(.a(a), .b(b), .r(c));
    not_gate n2(.a(c), .r(d));
endmodule
