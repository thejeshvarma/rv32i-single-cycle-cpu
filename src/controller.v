module controller(
input [6:0] op,
input [2:0] funct3,
input [6:0] funct7,
input Zero,

output PCSrc,MemWrite,ALUSrc,RegWrite,
output [1:0] ResultSrc,ImmSrc,
output [2:0] ALUControl
);

wire [1:0] ALUOp;
wire Branch;

main_decoder md(
    .opcode(op),
    .PCSrc(Branch),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .AluOp(ALUOp)
);

// alu decoder
alu_decoder ad(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .op(op),
    .ALUControl(ALUControl)
);

// branch decision
assign PCSrc = Branch & Zero;

endmodule