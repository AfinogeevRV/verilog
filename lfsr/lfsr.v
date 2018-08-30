module LFSR(
	input rst,
	input clk,
	output out
);

	parameter init_reg = 32'h974CA351;
	
	wire next_bit;
	reg [31:0]shift_reg;
	assign out = next_bit;

	assign next_bit = 
				shift_reg[31] ^
				shift_reg[30] ^
				shift_reg[29] ^
				shift_reg[27] ^
				shift_reg[25] ^
				shift_reg[ 0];

	always @(posedge clk or posedge rst)
		if(rst) shift_reg <= init_reg;
		else shift_reg <= { next_bit, shift_reg[31:1] };

endmodule
