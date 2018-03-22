module spi_master(
	input wire clk,
	input wire rst,
	input wire ms,
	output wire sck,
	input wire sdin,
	output wire sdout,
	output reg [7:0]rdata,
	input wire [7:0]tdata
);

reg [7:0]rdata_r = 8'h00;
reg [7:0]rreg = 8'h00;
reg [3:0]nbo = 4'b0;
reg [3:0]nbi = 4'b0;
reg [7:0]treg = 8'h00;

assign sdout = treg[7];

reg sck_r;
reg [31:0] counter;
assign sck = sck_r;
reg [4:0]nbc = 5'b0;

always @(posedge clk or posedge rst)
begin
	if(rst) begin counter <= 32'b0; sck_r <= 1'b0; nbc <= 5'b0; end
	else if(!ms && nbc<16)
		begin 
		counter <= {counter[30:0], 1'b1};
		if(counter[31]==1'b1)
			begin
				counter <= 32'b0;
				sck_r <= ~sck_r;
				nbc <= nbc +1;
			end
		end
	else if(ms) begin counter <= 32'b0; sck_r <= 0; nbc <= 5'b0; end
end

always @(posedge sck or posedge rst)
begin
	if(rst) begin rreg <= 8'h00; nbi <= 4'b0; end
	else if(!ms)
	begin
		nbi = nbi+1;
		rreg ={rreg[6:0],sdin};  
		if(nbi>7) begin
			nbi<=4'b0;
			rdata <= rreg[7:0];
		end
	end
	else if(ms) begin rreg <= 8'h00; nbi <= 4'b0; end
end

always @(negedge sck or posedge rst)
begin
	if(rst) begin treg <= tdata; nbo <= 4'b0; end
	else if(!ms)
	begin
		nbo = nbo+1;
		if(nbo>7) begin
			nbo<=4'b0;
			treg <= tdata;
		end
		else begin           
			treg = {treg[6:0],1'b0};
		end
	end 
	else if(ms) begin treg <= tdata; nbo <= 4'b0; end
end
  
endmodule