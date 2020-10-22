`timescale 1ns/100ps

module register_file_tb(
);
    logic clk;
    logic reset;

    logic[1:0] write_index, read_index_a;
    logic[15:0] write_data, read_data_a;
    logic write_enable;

    /* The number of cycles we want to actually test. Increasing the number will make the test-bench
        take longer, but may also uncover edge-cases. */
    localparam TEST_CYCLES = 100;

    /* Constant used to track how many cycles we want to run for before declarating a timeout. */
    localparam TIMEOUT_CYCLES = TEST_CYCLES + 10;

    /* Clock generation process. Starts at the beginning of simulation. */
    initial begin
        $timeformat(-9, 1, " ns", 20);
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0, register_file_tb);

        /* Send clock low right at the start of the simulation. */
        clk = 0;

        /* Delay by 5 timeunits (5ns) -> hold clock low for 5 timeunits */
        #5;

        /* Generate clock for at most TIMEOUT_CYCLES cycles. */
        repeat (2*TIMEOUT_CYCLES) begin
            /* Delay by 5 timeunits (5ns) then toggle clock -> 10ns = 100MHz clock. */
            #5 clk = !clk;
        end

        $fatal(1, "Testbench timed out rather than exiting gracefully.");
    end

    /* Shadow copy of what we _expect_ the register file to contain. We will update this
        as necessary in order to keep track of how the entries are expected to change. */
    logic[15:0] shadow[3:0];

    /* Input stimulus and checking process. This starts at the beginning of time, and   
        is synchronised to the same clock as DUT. */
    integer i;
    initial begin

        reset = 0;

        @(posedge clk)
        #1;
        /* Pulse the reset for one cycle, in order to get register file into known state. */
        reset=1;

        @(posedge clk)
        #1;

        /* reset==1 -> Initialise shadow copy to all zeros. */
        for(i=0; i<4; i++) begin
            shadow[i]=0;
        end


        /* Run as many test cycles as were requested. */
        repeat (TEST_CYCLES) begin
            /* Generate random samplings of input to apply in next cycle. */
            write_index = $urandom_range(0,3);
            write_data = $urandom();
            write_enable = $urandom_range(0,1);     /* Write enable is toggled randomly. */
            read_index_a = $urandom_range(0,3);
            reset = $urandom_range(0,100)==0;       /* 1% chance of reset in each cycle. */

            @(posedge clk)
            #1;

            /* Update the shadow regsiters according to the commands given to the register file. */
            if (reset==1) begin
                for(i=0; i<4; i++) begin
                    shadow[i]=0;
                end
            end
            else begin
                if (write_enable==1) begin
                    shadow[write_index] = write_data;
                end
            end

            /* Verify the returned results against the expected output from the shadow registers. */
            if (reset==1) begin
                assert (read_data_a==0) else $error("read_data_a not zero during reset.");
            end
            else begin
                assert( read_data_a == shadow[read_index_a] )
                else $error("At time %t, read_index=%d, got=%h, ref=%h", $time, read_index_a, read_data_a, shadow[read_index_a]);
            end
        end

        /* Exit successfully. */
        $finish;
    end

    register_file regs(
        .clk(clk),
        .reset(reset),
        .read_data_a(read_data_a), .write_data(write_data),
        .read_index_a(read_index_a), .write_index(write_index),
        .write_enable(write_enable)
    );
endmodule
