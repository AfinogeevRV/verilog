module FSK(
	input rst,
	input clk,
	input s,
	output signed [width-1:0] out
);
    
	parameter freq0;
	parameter freq1;
	parameter width; //width of x and y
	parameter fclk;
	localparam shift = 32'h00000001 << (width-1);
	localparam An = (shift-(width-1)/2)/1.647; //(1.647 = 1/0.607 ; 0.607 is K)
	localparam signed [64:0] step0 = 32'hFFFFFFFF*freq0/fclk;
	localparam signed [64:0] step1 = 32'hFFFFFFFF*freq1/fclk;
  
	wire signed [64:0] step;
	assign step = s ? step1:step0;
	assign out = COSout;
  
	reg signed [width-1:0] Xin, Yin;
	reg signed [33:0] angle; 
	wire signed [width-1:0] COSout, SINout; 
  
	defparam cordic.width = width;
	CORDIC cordic(rst, clk, COSout, SINout, Xin, Yin, angle);
  
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
