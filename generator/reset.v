module RESET (rst,clk);

output rst;
input clk;

reg [3:0] count_rst = 4'h0;
reg rst;
always @ (posedge clk)
begin
	if (count_rst<=4'd10) begin
		rst<=1'b1;
		count_rst<=count_rst+1'b1; 
	end
	else begin
		rst<=1'b0;
		count_rst<=4'd15; 
	end
end

endmodule