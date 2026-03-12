module datapath(
input clk, reset,

input PCSrc,
input [1:0] ResultSrc,
input MemWrite,
input ALUSrc,
input [1:0] ImmSrc,
input RegWrite,
input [2:0] ALUControl,

output [31:0] Instr,
output Zero
);


wire [31:0] PC, PCNext;
wire [31:0] PCPlus4;
wire [31:0] PCTarget;

wire [31:0] RD1, RD2;
wire [31:0] ImmExt;

wire [31:0] SrcB;
wire [31:0] ALUResult;

wire [31:0] ReadData;
wire [31:0] Result;

pc pcounter(
.clk(clk),
.reset(reset),
.PCNext(PCNext),
.PC(PC)
);

imem imem_unit(
.PC(PC),
.Instr(Instr)
);

regfile rf(
.clk(clk),
.RegWrite(RegWrite),
.A1(Instr[19:15]),
.A2(Instr[24:20]),
.A3(Instr[11:7]),
.WriteData(Result),
.RD1(RD1),
.RD2(RD2)
);

extender ext(
.instr(Instr[31:7]),
.ImmSrc(ImmSrc),
.ImmExt(ImmExt)
);


mux2 alumux(
    .A(RD2),
    .B(ImmExt),
    .sel(ALUSrc),
    .Y(SrcB)
);

ALU alu_unit(
.SrcA(RD1),
.SrcB(SrcB),
.ALUControl(ALUControl),
.ALUResult(ALUResult),
.Zero(Zero)
);

data_memory dm(
.A(ALUResult),
.WriteData(RD2),
.clk(clk),
.WE(MemWrite),
.ReadData(ReadData)
);

mux3 ResultMux(
    .A(ALUResult),
    .B(ReadData),
    .C(PCPlus4),
    .sel(ResultSrc),
    .Y(Result)
);

pc_adder addpcdef(
.PC(PC),
.PCPlus4(PCPlus4)
);

branch_adder addbranch(
.PC(PC),
.ImmExt(ImmExt),
.PCTarget(PCTarget)
);

mux2 pcmux(
    .A(PCPlus4),
    .B(PCTarget),
    .sel(PCSrc),
    .Y(PCNext)
);
endmodule
