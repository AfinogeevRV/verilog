module PSK4(
	input rst,
	input clk, 
	input s1,
	input s2,
	output signed [width-1:0] out
);
   
	parameter freq;
	parameter width; //width of x and y
	parameter fclk;
	localparam shift = 32'h00000001 << (width-1);
	localparam An = (shift-(width-1)/2)/1.647; //(1.647 = 1/0.607 ; 0.607 is K)
	localparam signed [64:0] step = 32'hFFFFFFFF*freq/fclk;
    
	reg signed [width-1:0] Xin, Yin;
	reg signed [33:0] angle; 
	wire signed [width-1:0] COSout, SINout; 
  
	defparam cordic.width = width;
	CORDIC cordic(rst, clk, COSout, SINout, Xin, Yin, angle);

	wire signed [1:0]s1_w;
	wire signed [1:0]s2_w;
	assign s1_w = s1 ? 1:-1;
	assign s2_w = s2 ? 1:-1;
	assign out = s1_w*COSout/2 + s2_w*SINout/2;
  
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
