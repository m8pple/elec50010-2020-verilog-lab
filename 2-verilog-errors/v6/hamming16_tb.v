module hamming16_tb();
    

    logic[15:0] x;
    logic[4:0]  count;

    hamming16 dut(
        .x(x),
        .count(count)
    );

    logic[15:0] i;
    logic[4:0] count_ref;
    initial begin
        $dumpfile("hamming16_tb.vcd");
        $dumpvars(0, hamming16_tb);
        count_ref = 0;
        x = 0;
        repeat (65536) begin
            /* Calculate reference count sequentially. Not synthesisable. */
            for (i=x; i>0; i>>=1 ) begin
                count_ref += i[0];
            end

            #1; /* Wait 1 time unit */
            $display("x: %b\ncount: %d\ncount_ref: %d", x, count, count_ref);

            assert(count == count_ref) else $fatal(1, "Mis-match : x=%b, count=%d, count_ref=%d", x, count, count_ref);

            x = x+1;
            count_ref=0;
        end
    end


endmodule