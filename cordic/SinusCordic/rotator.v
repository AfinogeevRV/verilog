module rotator (
clk, rst,
x_i, y_i, z_i,
x_o, y_o, z_o,
quarter_i, quarter_o
);
parameter width_data = 12;
parameter width_angle = 16; 
parameter integer iteration = 0;
parameter signed [width_angle:0] tangle = 0;
input wire clk;
input wire rst;
input wire signed [width_data:0] x_i;
input wire signed [width_data:0] y_i;
input wire signed [width_angle:0] z_i;
output wire signed [width_data:0] x_o;
output wire signed [width_data:0] y_o;
output wire signed [width_angle:0] z_o;
input wire [1:0] quarter_i;
output reg [1:0] quarter_o;

reg signed [width_data:0] x_1 = 0;
reg signed [width_data:0] y_1 = 0;
reg signed [width_angle:0] z_1 = 0;

/*function signed[width_data:0] Delta; 
  input signed[width_data:0] Arg;
	input integer cnt;
	integer k;
	begin
		Delta = Arg;
		for(k=0;k<cnt;k=k+1)
		begin
			Delta[width_data-1:0]=Delta[width_data:1];
			Delta[width_data]=Arg[width_data];
		end
	end
endfunction*/

wire signed [width_data:0] Xd, Yd;
assign Xd = x_i >>> iteration;//Delta(x_i,iteration);
assign Yd = y_i >>> iteration;//Delta(y_i,iteration);
always @ (posedge clk)
	if(rst) begin
		x_1 <= 0;
		y_1 <= 0;
		z_1 <= 0;
	end
	else begin
	if(z_i < 0) begin
		x_1 <= x_i + Yd; 
		y_1 <= y_i - Xd; 
		z_1 <= z_i + tangle; 
	end
	else begin
		x_1 <= x_i - Yd; 
		y_1 <= y_i + Xd; 
		z_1 <= z_i - tangle; 
	end
end

assign x_o = x_1;
assign y_o = y_1;
assign z_o = z_1;

always @ (posedge clk) 
	if(rst) quarter_o <= 1'b0; 
	else quarter_o[1:0] <= quarter_i[1:0];
	  
endmodule  

