module main(
	input clk,
	output [7:0] out
);

	localparam fclk = 32'd50000000;
	localparam width = 8;

	wire rst;
	RESET reset(rst,clk);
	
	wire signed [width-1:0] genout;
	assign out = genout + (8'h01 << (width-1));
	
	reg [31:0] freq;
	defparam generator.width = width;
	defparam generator.fclk = fclk;
	GENERATOR generator(rst,clk,freq,genout);
	
	always @(posedge rst) 
		freq <= 10000;

endmodule
