module hamming16_tb();
    

    logic[15:0] x;
    logic[4:0]  count;

    hamming16 dut(
        .x(x),
        .count(count)
    );

    integer i;
    logic[3:0] count_ref;
    initial begin
        $dumpfile("hamming16_tb.vcd");
        $dumpvars(0, hamming16_tb);
        
        x = 0;
        repeat (65535) begin
            /* Calculate reference count sequentially. Not synthesisable. */
            count_ref=0;
            for (i=0; i<16; i++) begin
                count_ref = count_ref + x[i];
            end

            #1; /* Wait 1 time unit */

            assert(count == count_ref) else begin
                $fatal(1, "Mis-match : x=%b, count=%d, count_ref=%d", x, count, count_ref);
            end

            x = x+1;
        end
    end


endmodule