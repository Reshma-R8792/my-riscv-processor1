
module regfile(
    input  logic        clk,
    input  logic        we3,
    input  logic [4:0]  a1, a2, a3,
    input  logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);

    logic [31:0] registers [0:31];

    // Register x0 always reads as zero
    assign rd1 = (a1 == 5'd0) ? 32'b0 : registers[a1];
    assign rd2 = (a2 == 5'd0) ? 32'b0 : registers[a2];

    // Write data on the rising edge of the clock
    always_ff @(posedge clk) begin
        if (we3 && (a3 != 5'd0))
            registers[a3] <= wd3;
    end

endmodule
