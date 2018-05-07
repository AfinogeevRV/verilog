module testbench ();
  
reg rst;  
reg clk;
reg rx;
wire tx;

MAIN main(.rst(rst), .clk(clk), .rx(rx), .tx(tx));

initial
begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);
	clk = 0;
	rx = 1;
end

always #1 clk = !clk;

initial
begin
	rst <= 0;
	#10
	rst <= 1;
	#10
	rst <=0;
	#10;
	
	#20 rx=0;
	#20 rx=1;
	#20 rx=1;
	#20 rx=1;
	#20 rx=0;
	#20 rx=0;
	#20 rx=0;
	#20 rx=1;
	#20 rx=0;
	#20 rx=1;
	
	#100
	
	#20 rx=0;
	#20 rx=1;
	#20 rx=1;
	#20 rx=1;
	#20 rx=0;
	#20 rx=0;
	#20 rx=0;
	#20 rx=1;
	#20 rx=0;
	#20 rx=1;
	
	
	#600
	//#10000 
	$finish;
end

endmodule