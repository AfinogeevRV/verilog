module GENERATOR(rst, clk, freq, out);
    
  parameter width = 8; //width of x and y  min = 8
  parameter fclk = 32'd50000000;
  localparam shift = 32'h00000001 << (width-1);
  localparam An = shift/1.647-width;//32000

  input rst;
  input clk;
  input [31:0] freq; 
  output [width-1:0] out;

  reg [width-1:0] Xin, Yin;
  reg [33:0] angle; 
  reg [63:0] step;
  
  reg [width:0] outreg;
  
  reg [1:0] delay_q [0:width-1];
  wire [1:0] quadrant;
  wire [1:0] quadrant_last;
  
  assign quadrant = angle[31:30];

  wire signed [width-1:0] COSout, SINout;
  
  assign out = outreg[width-1:0];
  
  defparam cordic.width = width;
  CORDIC cordic(rst, clk, COSout, SINout, Xin, Yin, angle);
  
  always @(posedge clk) begin
	step <= 32'hFFFFFFFF*freq/fclk;
	delay_q[0] <= angle[31:30];
  end
  
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      angle <= 33'b0;
      Xin <= An;
      Yin <= 0;
    end
    else if(clk) begin
      if(angle >= 32'hFFFFFFFF) angle <= angle - 32'hFFFFFFFF + step;
		else angle <= angle + step;
    end
  end  
  
  always @(posedge clk or posedge rst) begin
	if(rst)
      outreg <= 33'b0;
   else if(clk) begin
	   case(quadrant_last)
			2'b00,
			2'b11:
				outreg <= COSout + shift;
			2'b01,
			2'b10:
				outreg <= COSout - shift;
	   endcase
	end
  end
  
  genvar i;
  generate
  for (i=0; i < (width-1); i=i+1)
  begin: del_q
    always @(posedge clk)
			delay_q[i+1] <= delay_q[i];
  end
  endgenerate
  
  assign quadrant_last = delay_q[width-1];
  
endmodule