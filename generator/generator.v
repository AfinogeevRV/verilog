module GENERATOR(
	input rst,
	input clk,
	input [31:0] freq, 
	output signed [width-1:0] out
);
    
	parameter width; //width of x and y
	parameter fclk;
	localparam shift = 32'h00000001 << (width-1);
	localparam An = (shift-(width-1)/2)/1.647; //(1.647 = 1/0.607 ; 0.607 is K)
  
	assign out = COSout;
  
	reg signed [width-1:0] Xin, Yin;
	reg signed [33:0] angle; 
	reg signed [64:0] step;
	wire signed [width-1:0] COSout, SINout; 
  
	defparam cordic.width = width;
	CORDIC cordic(rst, clk, COSout, SINout, Xin, Yin, angle);
  
	always @(posedge clk)
		step <= 32'hFFFFFFFF*freq/fclk;
  
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			angle <= 34'b0;
			Xin <= An;
			Yin <= 0;
		end
		else if(clk)
			if(angle >= 32'hFFFFFFFF) angle <= angle - 32'hFFFFFFFF + step;
			else angle <= angle + step;
	end  
  
endmodule
