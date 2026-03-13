module tb_cpu();

reg clk;
reg reset;

cpu uut(
.clk(clk),
.reset(reset)
);

initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb_cpu);
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    #10;
    reset = 0;

    #200;
    $finish;
end

endmodule