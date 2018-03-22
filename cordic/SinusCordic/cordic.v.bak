module cordic (
clk, rst, 
x_i, y_i, theta_i,
x_o, y_o, theta_o,
quarter_in, quarter_out
);
parameter width_data = 12;
parameter width_angle = 16;
input wire clk;
input wire rst;
input wire signed[width_data:0] x_i;
input wire signed[width_data:0] y_i;
input wire signed[width_data:0] theta_i;
output wire signed[width_data:0] x_o;
output wire signed[width_data:0] y_o;
output wire signed[width_data:0] theta_o; 
input wire [1:0] quarter_in;
output wire [1:0] quarter_out;

function [width_angle:0] tanangle; 
input [3:0] i;
	begin
		case(i)
			4'b0000: tanangle = 17'd25736;  // 1/1
			4'b0001: tanangle = 17'd15192;  // 1/2
			4'b0010: tanangle = 17'd8028;  // 1/4
			4'b0011: tanangle = 17'd4074;  // 1/8
			4'b0100: tanangle = 17'd2045;  // 1/16
			4'b0101: tanangle = 17'd1024;  // 1/32
			4'b0110: tanangle = 17'd512;  // 1/64
			4'b0111: tanangle = 17'd256;  // 1/128
			4'b1000: tanangle = 17'd128;  // 1/256
			4'b1001: tanangle = 17'd64;  // 1/512
			4'b1010: tanangle = 17'd32;  // 1/1024
			4'b1011: tanangle = 17'd16;  // 1/2048
			4'b1100: tanangle = 17'd8;  // 1/4096
			4'b1101: tanangle = 17'd4;  // 1/8192
			4'b1110: tanangle = 17'd2;  // 1/16384
			4'b1111: tanangle = 17'd1;  // 1/32768
		endcase
	end
endfunction

wire signed [width_data:0] x [width_angle:0];
wire signed [width_data:0] y [width_angle:0];
wire signed [width_angle:0] z [width_angle:0];
wire [1:0] q [width_angle:0];

assign x[0] = x_i;
assign y[0] = y_i;
assign q[0] = quarter_in;
assign x_o = x[width_angle];
assign y_o = y[width_angle];
assign quarter_out = q[width_angle];

wire [width_angle:0] inbuf_ang;
wire [width_angle:0] outbuf_ang;
assign inbuf_ang[width_angle] = 1'b0;
assign inbuf_ang[width_angle-1:width_angle-width_data] = theta_i [width_data-1:0];
assign inbuf_ang[3:0] = 4'h0;
assign z[0] = inbuf_ang;
assign outbuf_ang = z[width_angle];
assign theta_o = outbuf_ang[width_data-1];

genvar i;
generate for(i=0; i<width_angle; i=i+1) begin: rot
	rotator U (
	.clk(clk), .rst(rst),
	.x_i(x[i]), .y_i(y[i]), .z_i(z[i]),
	.x_o(x[i+1]), .y_o(y[i+1]), .z_o(z[i+1]),
	.quarter_i(q[i]), .quarter_o(q[i+1]));
		defparam U.iteration = i;
		defparam U.tangle = tanangle(i);
		defparam U.width_data = width_data;
		defparam U.width_angle = width_angle;
	end
endgenerate

endmodule
