

/*
STP 0111 stop
JNE S 0110 if ACC ≠ 0, PC := S
JGE S 0101 if ACC > 0, PC := S
JMP S 0100 PC := S
SUB S 0011 ACC := ACC – mem[S]
ADD S 0010 ACC := ACC + mem[S]
STO S 0001 mem[S] := ACC
LDA S 0000 ACC := mem[S]
OUT S 1000 print(Acc)
*/

module CPU_MU0_delay1(
    input logic clk,
    input logic rst,
    output logic running,
    output logic[11:0] address,
    output logic write,
    output logic read,
    output logic[15:0] writedata,
    input logic[15:0] readdata
    );

    /* Using an enum to define constants */
    typedef enum logic[3:0] {
        OPCODE_LDA = 4'd0,
        OPCODE_STO = 4'd1,
        OPCODE_ADD = 4'd2,
        OPCODE_SUB = 4'd3,
        OPCODE_JMP = 4'd4,
        OPCODE_JGE = 4'd5,
        OPCODE_JNE = 4'd6,
        OPCODE_STP = 4'd7,
        OPCODE_OUT = 4'd8
    } opcode_t;

    /* Another enum to define CPU states. */
    typedef enum logic[2:0] {
        FETCH_INSTR_ADDR = 3'b000,
        FETCH_INSTR_DATA = 3'b001,
        EXEC_INSTR_ADDR  = 3'b010,
        EXEC_INSTR_DATA  = 3'b011,
        HALTED =      3'b100
    } state_t;

    logic[11:0] pc, pc_next;
    logic[15:0] acc;

    logic[16:0] instr;
    opcode_t instr_opcode;
    logic[11:0] instr_constant;    

    logic[1:0] state;

    // Decide what address to put out on the bus, and whether to write
    assign address = (state==FETCH_INSTR_ADDR) ? pc : instr_constant;
    assign write = state==EXEC_INSTR_DATA ? instr_opcode==OPCODE_STO : 0;
    assign read = (state==FETCH_INSTR_ADDR) ? 1 : (state==EXEC_INSTR_ADDR && (instr_opcode==OPCODE_LDA || instr_opcode==OPCODE_ADD  || instr_opcode==OPCODE_SUB ));
    assign writedata = acc;

    // Break-down the instruction into fields
    // these are just wires for our convenience
    assign instr_opcode = instr[15:12];
    assign instr_constant = instr[11:0];

    // This is used in many places, as most instructions go forwards by one step.
    // Defining it once makes it more likely the synthesis tool will only create
    // one concrete instance.
    wire[11:0] pc_increment;
    assign pc_increment = pc + 1;

    /* We are targetting an FPGA, which means we can specify the power-on value of the
        circuit. So here we set the initial state to 0, and set the output value to
        indicate the CPU is not running.
    */
    initial begin
        state = HALTED;
        running = 0;
    end
    
    /* Main CPU sequential update logic. Where combinational logic is simple, it
        has been incorporated directly here, rather than splitting it into another
        block.

         Note: this is always rather than always_ff due to limitations in the verilog
        simulator, which can't deal with $display in always_ff blocks.
    */
    always @(posedge clk) begin
        if (rst) begin
            $display("CPU : INFO  : Resetting.");
            state <= FETCH_INSTR_ADDR;
            pc <= 0;
            acc <= 0;
            running <= 1;
        end
        else if (state==FETCH_INSTR_ADDR) begin
            $display("CPU : INFO  : Fetching (addr), address=%h.", pc);
            state <= FETCH_INSTR_DATA;
        end
        else if (state==FETCH_INSTR_DATA) begin
            $display("CPU : INFO  : Fetching (data), address=%h.", pc);
            instr <= readdata;
            state <= EXEC_INSTR_ADDR;
        end
        else if (state==EXEC_INSTR_ADDR) begin
            $display("CPU : INFO  : Executing (addr), opcode=%h, acc=%h, imm=%h, readdata=%x", instr_opcode, acc, instr_constant, readdata);
            state <= EXEC_INSTR_DATA;
        end
        else if (state==EXEC_INSTR_DATA) begin
            $display("CPU : INFO  : Executing (data), opcode=%h, acc=%h, imm=%h, readdata=%x", instr_opcode, acc, instr_constant, readdata);
            case(instr_opcode)
                OPCODE_LDA: begin
                    acc <= readdata;
                    pc <= pc_increment;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_STO: begin
                    pc <= pc_increment;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_ADD: begin
                    acc <= acc + readdata;
                    pc <= pc_increment;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_SUB: begin
                    acc <= acc - readdata;
                    pc <= pc_increment;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_JMP: begin
                    pc <= instr_constant;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_JGE: begin
                    if (acc > 0) begin
                        pc <= acc;
                    end
                    else begin
                        pc <= pc_increment;
                    end
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_JNE: begin
                    if (acc != 0) begin
                        pc <= instr_constant;
                    end
                    else begin
                        pc <= pc_increment;
                    end
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_OUT: begin
                    $display("CPU : OUT   : %d", $signed(acc));
                    pc <= pc_increment;
                    state <= FETCH_INSTR_ADDR;
                end
                OPCODE_STP: begin
                    // Stop the simulation
                    state <= HALTED;
                    running <= 0;
                end
            endcase
        end
        else if (state==HALTED) begin
            // do nothing
        end
        else begin
            $display("CPU : ERROR : Processor in unexpected state %b", state);
            $finish;
        end
    end
endmodule

