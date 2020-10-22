module add4_tb();

    logic[3:0] a, b, sum;
    logic cin, cout;
    logic [4:0] true_sum;

    logic[8:0] i;
    initial begin
        $dumpfile("add4.vcd");
        $dumpvars(0, add4_tb);

        /* Loop over every possible input pattern */
        
        i=0;
        repeat (512) begin
            a=(i>>5)&15;
            b=(i>>1)&15;
            cin=i&1;
            true_sum = (a+b+cin);
            #1;
            
            assert( (true_sum & 15) == sum );
            assert( (true_sum >> 4) == cout );

            i=i+1;
        end
    end

    add4 dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

endmodule