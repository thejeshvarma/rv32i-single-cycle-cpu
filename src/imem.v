module imem(
input [31:0] PC,
output [31:0] Instr
);

reg [31:0] memory [0:255];

initial begin
    $readmemh("program.mem", memory);
end

assign Instr = memory[PC[9:2]];

endmodule