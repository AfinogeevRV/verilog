module MAIN (rst,clk, rx, tx);

input rst;
input clk;
input rx;
output tx;
output led1, led2, led3;
output [7:0] data;
	
//wire rst;
//RESET reset(.rst(rst),.clk(clk));


wire [7:0] data_rx;
wire ready_rx;
reg [7:0] data_tx;
wire ready_tx;
wire start_tx = ready_rx;

assign data = data_rx;

UART_RX uart_rx(rst, clk, rx, data_rx, ready_rx);
UART_TX uart_tx(rst, clk, tx, data_tx, start_tx, ready_tx);

reg led1_r, led2_r, led3_r;
assign led1 = led1_r, led2 = led2_r, led3 = led3_r;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		led1_r <= 1; led2_r <= 1; led3_r <= 1;
	end
	else if(clk)
	begin
		data_tx <= data_rx;
		led1_r <= data_rx==8'h41 ? 0:1;
		led2_r <= data_rx==8'h47 ? 0:1;
		led3_r <= data_rx==8'h55 ? 0:1;
	end
end

endmodule
