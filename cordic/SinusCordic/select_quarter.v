module select_quarter (
input wire clk,
input wire rst,
input wire [12:0] Xi,
input wire [12:0] Yi,
output wire [12:0] Xo,
output wire [12:0] Yo,
input [1:0] quarter
);

wire [12:0] Xq1, Xq2;
wire [12:0] Yq1, Yq2;
assign Xq1 = Xi+13'h800;
assign Yq1 = Yi+13'h800;
assign Xq2 = 13'h800-Xi;
assign Yq2 = 13'h800-Yi;

reg[12:0] Xresult, Yresult;
always @ (posedge clk)
begin
	if(rst) begin
	Xresult <= 13'h0; Yresult <= 13'h0;
	end
	else begin
		case (quarter) 
			2'b00:begin
			Yresult <= Yq1; Xresult <= Xq1;
			end
			2'b01: begin
			Yresult <= Yq1; Xresult <= Xq2;
			end
			2'b10: begin
			Yresult <= Yq2; Xresult <= Xq2;
			end
			2'b11: begin
			Yresult <= Yq2; Xresult <= Xq1;
			end
		endcase
	end
end

assign Xo = Xresult;
assign Yo = Yresult;

endmodule