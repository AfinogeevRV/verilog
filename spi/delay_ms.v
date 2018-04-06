module DELAY_MS(rst, clk, enable, done, ms);

input wire rst, clk, enable;
output wire done;
input wire [31:0] ms;


localparam fclk = 50000000;
localparam ms1 = fclk/1000;

reg [31:0] cnt_clk;
reg [31:0] cnt_ms;
reg done_r;

assign done = done_r;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		cnt_clk = 32'b0;
		cnt_ms = 3'b0;
		done_r = 0;
	end
	else if(clk)
	begin
		if(enable)
		begin
			cnt_clk <= cnt_clk + 1;
			if(cnt_clk >= ms1)
			begin
				cnt_ms = cnt_ms + 1;
				cnt_clk <= 0;
			end
			if(cnt_ms >= ms)
				done_r = 1;
		end
		else 
		begin
			cnt_clk = 32'b0;
			cnt_ms = 3'b0;
			done_r = 0;
		end
			
	end
end

endmodule