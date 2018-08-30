module CLOCKER(
	input rst,
	input clk,
	output clk_usr
);

	parameter fclk;
	parameter fclk_usr;
	
	localparam size = fclk/fclk_usr/2;

	reg clk_usr_r;
	reg [31:0] cnt;
	
	assign clk_usr = clk_usr_r;

	always @(posedge rst or posedge clk) begin
		if(rst) begin
			cnt <= 0;
			clk_usr_r <= 0;
		end
		else if (clk) begin
			cnt <= cnt + 1;
			if(cnt >= size-2) begin
				cnt <= 0;
				clk_usr_r <= ~clk_usr_r;
			end
		end
	end
	
endmodule
