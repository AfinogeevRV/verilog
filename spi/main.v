module main(
	input wire clk,
	//spi_master//
	output wire mas_sck,
	input wire mas_sdin,
	output wire mas_sdout,
	//spi_slave//
	input wire sl_sck,
	input wire sl_sdin,
	output wire sl_sdout,
	//leds//
	output wire led1,
	output wire led2,
	output wire led3,
	//key//
	input wire button
);

reg reset;
assign led1 = button;
reg led2_r, led3_r;
assign led2 = led2_r;
assign led3 = led3_r; 
reg [7:0] data;

//spi_master//
wire [7:0] mas_rdata;
reg [7:0] mas_tdata;
wire mas_ms = button;
spi_master mas(
	clk,
	reset,
	mas_ms,
	mas_sck,
	mas_sdin,
	mas_sdout,
	mas_rdata,
	mas_tdata
);
////////////

//spi slave//
wire [7:0] sl_rdata;
reg [7:0] sl_tdata;
wire sl_ss = button;
spi_slave sl(	
	reset,
	sl_ss,
	sl_sck,
	sl_sdin,
	sl_sdout,
	sl_rdata,
	sl_tdata
);
//////////////

//reset//
reg [31:0]rst_delay = 0;
always @(posedge clk)
rst_delay <= { rst_delay[30:0], 1'b1 };
always @*
reset = ~rst_delay[31];

always @(posedge reset)
begin
	sl_tdata <= 8'h23;
	mas_tdata <= 8'hf1;
	data <= 8'h23;
end
//////////

always @(posedge button)
begin
	if(mas_rdata==8'h23) led2_r <= ~led2_r;
	if(sl_rdata==8'hf1) led3_r <= ~led3_r;
end

endmodule