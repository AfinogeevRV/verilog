module tlfsr;

reg clk;
reg rst;
reg en;
wire [31:0]wrandom1;
wire [7:0]wrandom_lb1;

wire [31:0]wrandom2;
wire [7:0]wrandom_lb2;

lfsr u_lfsr1(
  rst,
  clk,
  en,
  wrandom1,
  wrandom_lb1,
  32'h974CA351
  );
  
  lfsr u_lfsr2(
  rst,
  clk,
  en,
  wrandom2,
  wrandom_lb2,
  32'h5829487A
  );
  
  always
	#1 clk  = ~clk;
  
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,tlfsr);
  clk <= 0;
  #10;
  rst <= 1'b1;
  #5 rst <= 1'b0;
  #10;
  en <= 1'b1;
  #100;
  $finish;
end

endmodule