module main(clk, out);

	input clk;
	output [7:0] out;

	wire rst;
	RESET reset(rst,clk);
	
	reg [31:0] freq;
	defparam generator.width = 8;
	defparam generator.fclk = 32'd50000000;
	GENERATOR generator(rst,clk,freq,out);
	
	always @(posedge rst) 
			freq <= 1000;

endmodule