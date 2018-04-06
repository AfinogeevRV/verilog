module testbench ();
  
reg clk;

MAIN main(.clk(clk));

initial
begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);
	clk = 0;
end

always #1 clk = !clk;

initial
begin
	#1000000 $finish;
end

endmodule