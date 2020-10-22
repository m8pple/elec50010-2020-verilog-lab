
module multiplier_pipelined(
    input logic clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic[63:0] r
);
    // Declare an array of 33 signals for each intermediate stage
    logic [33][63:0] acc;
    logic [33][63:0] mp;
    logic [33][31:0] mc;

    // Setup the first stage of the chain
    always_ff @(posedge clk) begin
        mp[0] <= a;
        mc[0] <= b;
    end
    assign acc[0]=0;

    /* genvar is a more advanced technique used to create a compile-time loop. All uses
        of the variable i turn into compile-time constants.
    */
    genvar i;
    for(i=0; i<32; i++) begin
        assign acc[i+1] = acc[i] + ((mc[i]&1) ? mp[i] : 0);
        assign mp[i+1] = mp[i]<<1;
        assign mc[i+1] = mc[i]>>1;
    end

    // Capture the last stage of the chain
    always_ff @(posedge clk) begin
        r <= acc[32];
    end
    
endmodule
