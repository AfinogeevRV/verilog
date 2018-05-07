module UART_RX(rst, clk, rx, data, ready);

parameter size = 8;
parameter fclk = 50000000; //96000;
parameter baudrate = 9600;//256000;

localparam rx_clk_size = (fclk/baudrate)/2-1;

input rst, clk, rx;
output [size-1:0] data;
output ready;

reg [size-1:0] data_r;
assign data = data_r;
reg [size+1:0] tmp_data_r;
reg ready_r;
assign ready = ready_r;
reg [4:0] rx_cnt;
reg [$clog2(rx_clk_size)-1:0] rx_clk_cnt; //[31:0] rx_clk_cnt;
reg rx_clk_r;

reg prev_rx;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		rx_clk_r <= 0;
		rx_clk_cnt <= 0;
		rx_cnt <= (size+2)*2;
		prev_rx <= 1;
		ready_r <= 0;
	end
	else if(clk)
	begin
		if(rx_cnt<(size+2)*2)
		begin
			rx_clk_cnt <= rx_clk_cnt + 1;
			if(rx_clk_cnt>=rx_clk_size)
			begin
				rx_clk_r <= ~rx_clk_r;
				rx_clk_cnt <= 0;
				rx_cnt <= rx_cnt + 1;
			end
		end
		else
		begin
			if(prev_rx && !rx)
			begin
				rx_clk_r <= 0;
				rx_clk_cnt <= 0;
				rx_cnt <= 0;
				ready_r <= 0;
			end
			else if(tmp_data_r[size+1]&(~tmp_data_r[0]))
			begin
				ready_r <= 1;
				data_r <= tmp_data_r[size:1];
			end
		end
		prev_rx <= rx;
	end	
end

always @(posedge rst or posedge rx_clk_r)
begin
	if(rst)
	begin
		tmp_data_r <= 10'b0;
	end
	else if(rx_clk_r)
		tmp_data_r <= {rx, tmp_data_r[size+1:1]};
	
end

endmodule

module UART_TX(rst, clk, tx, data, start, ready);

parameter size = 8;
parameter fclk = 50000000; //96000;
parameter baudrate = 9600;//256000;

localparam tx_clk_size = (fclk/baudrate)/2-1;

input rst, clk;
output tx;
input [size-1:0] data;
input start;
output ready;

reg [size+1:0] tmp_data_r;
reg ready_r;
assign ready = ready_r;

reg [4:0] tx_cnt;
reg [$clog2(tx_clk_size)-1:0] tx_clk_cnt; //[31:0] tx_clk_cnt;
reg tx_clk_r;
reg tx_r;
assign tx = tx_r;
reg prev_start;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		tx_clk_r <= 0;
		tx_clk_cnt <= 0;
		tx_cnt <= (size+2)*2;
		prev_start <= 0;
		tmp_data_r[0] <= 0;
		tmp_data_r[size+1] <= 1;
		tmp_data_r[size:1] <= data;
	end
	else if(clk)
	begin
		if(tx_cnt<(size+2)*2)
			begin
			tx_clk_cnt <= tx_clk_cnt + 1;
			if(tx_clk_cnt>=tx_clk_size)
			begin
				tx_clk_r <= ~tx_clk_r;
				tx_clk_cnt <= 0;
				tx_cnt <= tx_cnt + 1;
			end
		end
		else
			ready_r <= 1;
			if(!prev_start && start)
			begin
				tx_clk_r <= 0;
				tx_clk_cnt <= 0;
				tx_cnt <= 0;
				tmp_data_r[size:1] <= data;
				ready_r <= 0;
			end
			prev_start <= start;
	end	
end

always @(posedge rst or posedge tx_clk_r)
begin
	if(rst)
		tx_r <= 1'b1;
	else if(tx_clk_r)
		tx_r <= tmp_data_r[tx_cnt/2];
	
end

endmodule
