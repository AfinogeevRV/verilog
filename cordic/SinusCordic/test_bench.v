`timescale 1ns/1ps;
module test_bench ();
  
reg clk;
wire led1;
wire [11:0] I, Q;
wire idclk, qdclk;
SinusGen SinusGen_user (
.clk(clk), .led1(led1),
.idclk(idclk), .qdclk(qdclk),
.I(I), .Q(Q)
);

initial
begin
    clk = 0;
    forever #5.208 clk = !clk;
end

endmodule