module CPU_MU0_delay1_tb;
    timeunit 1ns / 10ps;

    parameter RAM_INIT_FILE = "test/01-binary/countdown.hex.txt";
    parameter TIMEOUT_CYCLES = 10000;

    logic clk;
    logic rst;

    logic running;

    logic[11:0] address;
    logic write;
    logic read;
    logic[15:0] writedata;
    logic[15:0] readdata;

    RAM_16x4096_delay1 #(RAM_INIT_FILE) ramInst(clk, address, write, read, writedata, readdata);
    
    CPU_MU0_delay1 cpuInst(clk, rst, running, address, write, read, writedata, readdata);

    // Generate clock
    initial begin
        clk=0;

        repeat (TIMEOUT_CYCLES) begin
            #10;
            clk = !clk;
            #10;
            clk = !clk;
        end

        $fatal(2, "Simulation did not finish within %d cycles.", TIMEOUT_CYCLES);
    end

    initial begin
        rst <= 0;

        @(posedge clk);
        rst <= 1;

        @(posedge clk);
        rst <= 0;

        @(posedge clk);
        assert(running==1)
        else $display("TB : CPU did not set running=1 after reset.");

        while (running) begin
            @(posedge clk);
        end

        $display("TB : finished; running=0");

        $finish;
        
    end

    

endmodule