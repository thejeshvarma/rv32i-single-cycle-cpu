module main_decoder(
    input [6:0] opcode,
    output reg PCSrc, MemWrite, RegWrite, ALUSrc,
    output reg [1:0] ResultSrc, ImmSrc, AluOp
);

always @(*) begin

    // default values
    RegWrite  = 1'b0;
    MemWrite  = 1'b0;
    ALUSrc    = 1'b0;
    PCSrc     = 1'b0;
    ResultSrc = 2'b00;
    ImmSrc    = 2'b00;
    AluOp     = 2'b00;

    case(opcode)

        7'b0110011: begin // R-type
            RegWrite  = 1'b1;
            ALUSrc    = 1'b0;
            ResultSrc = 2'b00;
            AluOp     = 2'b10;
        end

        7'b0010011: begin // I-type (ADDI)
            RegWrite  = 1'b1;
            ALUSrc    = 1'b1;
            ImmSrc    = 2'b00;
            ResultSrc = 2'b00;
            AluOp     = 2'b10;
        end

        7'b0000011: begin // LW
            RegWrite  = 1'b1;
            ALUSrc    = 1'b1;
            ResultSrc = 2'b01;
            ImmSrc    = 2'b00;
            AluOp     = 2'b00;
        end

        7'b0100011: begin // SW
            MemWrite  = 1'b1;
            ALUSrc    = 1'b1;
            ImmSrc    = 2'b01;
            AluOp     = 2'b00;
        end

        7'b1100011: begin // BEQ
            ALUSrc    = 1'b0;
            ImmSrc    = 2'b10;
            AluOp     = 2'b01;
        end

        7'b1101111: begin // JAL
            RegWrite  = 1'b1;
            PCSrc     = 1'b1;
            ResultSrc = 2'b10;
            ImmSrc    = 2'b11;
        end

    endcase
end

endmodule