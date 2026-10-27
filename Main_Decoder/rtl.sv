
module maindec(
    input  logic [6:0] op,
    output logic [1:0] ResultSrc,
    output logic       MemWrite,
    output logic       Branch,
    output logic       ALUSrc,
    output logic       RegWrite,
    output logic       Jump,
    output logic [1:0] ImmSrc,
    output logic [1:0] ALUOp
);

always_comb begin
    // Default control signals
    ResultSrc = 2'b00;
    MemWrite  = 1'b0;
    Branch    = 1'b0;
    ALUSrc    = 1'b0;
    RegWrite  = 1'b0;
    Jump      = 1'b0;
    ImmSrc    = 2'b00;
    ALUOp     = 2'b00;

    case (op)
        // R-type instructions
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUOp    = 2'b10;
        end

        // I-type arithmetic instructions
        7'b0010011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b10;
        end

        // Load instructions
        7'b0000011: begin
            ResultSrc = 2'b01;
            ALUSrc    = 1'b1;
            RegWrite  = 1'b1;
        end

        // Store instructions
        7'b0100011: begin
            ImmSrc   = 2'b01;
            ALUSrc   = 1'b1;
            MemWrite = 1'b1;
        end

        // Branch instructions
        7'b1100011: begin
            ImmSrc = 2'b10;
            Branch = 1'b1;
            ALUOp  = 2'b01;
        end

        // JAL instruction
        7'b1101111: begin
            ResultSrc = 2'b10;
            RegWrite  = 1'b1;
            Jump      = 1'b1;
            ImmSrc    = 2'b11;
        end

        // JALR instruction
        7'b1100111: begin
            ResultSrc = 2'b10;
            RegWrite  = 1'b1;
            Jump      = 1'b1;
            ALUSrc    = 1'b1;
        end

        default: begin
            // Keep default values
        end
    endcase
end

endmodule
