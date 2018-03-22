module reset_block (
clk, reset
);
input clk;
output reset;

reg [3:0] count_reset = 4'h0;
reg reset;
always @ (posedge clk)
begin
	if (count_reset<=4'd10) begin
		reset<=1'b1;
		count_reset<=count_reset+1'b1; 
	end
	else begin
		reset<=1'b0;
		count_reset<=4'd15; 
	end
end

endmodule