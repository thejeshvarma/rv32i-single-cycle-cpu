module cpu(
input clk,
input reset
);

wire PCSrc;
wire [1:0] ResultSrc;
wire MemWrite;
wire ALUSrc;
wire [1:0] ImmSrc;
wire RegWrite;
wire [2:0] ALUControl;

wire [31:0] Instr;
wire Zero;

controller c(
.op(Instr[6:0]),
.funct3(Instr[14:12]),
.funct7(Instr[31:25]),
.Zero(Zero),
.PCSrc(PCSrc),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.ALUControl(ALUControl)
);

datapath dp(
.clk(clk),
.reset(reset),
.PCSrc(PCSrc),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.ALUControl(ALUControl),
.Instr(Instr),
.Zero(Zero)
);

endmodule