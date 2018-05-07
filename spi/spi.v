module SPI_SLAVE(rst, ss, sck, miso, mosi, tx, rx);

parameter size = 8;

input rst;
input ss, sck;
output miso;
input mosi;
input [size-1:0] tx;
output [size-1:0] rx;

reg [size-1:0] rx_r;
reg [size-1:0] rx_tmp_r;

assign rx = rx_r;

reg miso_r;
assign miso = miso_r;

reg [$clog2(size)-1:0] cnt; //[5:0] cnt;


always @(posedge rst or posedge sck)
begin
	if(rst)
		cnt <= 0;
	else if(!ss)
	begin
		cnt <= cnt + 1;
		rx_tmp_r <= {rx_tmp_r[size-2:0], mosi};
		if(cnt>=size-1)
		begin
			cnt <= 0;
			rx_r <= {rx_tmp_r[size-2:0], mosi};
		end
	end
	else if(ss)
		cnt <= 0;
end

always @(posedge rst or negedge sck)
begin
	if(rst)
		miso_r <= tx[size-1];
	else if(!ss)
	begin
		miso_r <= tx[size-1-cnt-1];
		if(cnt>=size-1)
			miso_r <= tx[size-1];
	end
	else if(ss)
		miso_r <= tx[size-1];
end

endmodule

module SPI_MASTER(rst, clk, start, ss, sck, miso, mosi, tx, rx);

parameter size = 8;
parameter fclk = 50000000; //96000;
parameter baudrate = 9600;

localparam clk_size = (fclk/baudrate)/2-1;

input rst;
input clk;
input start;
output ss;
output sck;
input miso;
output mosi;
input [size-1:0] tx;
output [size-1:0] rx;

reg [$clog2(clk_size)-1:0] clk_cnt; //[31:0] clk_cnt;
reg sck_r;
assign sck = sck_r;
reg [5:0] sck_cnt;
reg [5:0] cnt;

reg [size-1:0] rx_r;
reg [size-1:0] rx_tmp_r;

assign rx = rx_r;

reg mosi_r;
assign mosi = mosi_r;
reg ss_r;
assign ss = ss_r;

reg prev_start;
  
always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		sck_r <= 0;
		clk_cnt <= 0;
		sck_cnt <= size*2;
		prev_start <= 0;
		ss_r <= 1;
	end
	else if(clk)
	begin
		if(sck_cnt<size*2)
		begin
			clk_cnt <= clk_cnt + 1;
			if(clk_cnt>=clk_size)
			begin
				sck_r <= ~sck_r;
				clk_cnt <= 0;
				sck_cnt <= sck_cnt + 1;
			end
		end	
		else
		begin
			if(!prev_start && start)
			begin
				sck_r <= 0;
				clk_cnt <= 0;
				sck_cnt <= 0;
				ss_r <= 0;
			end
			else
				ss_r <= 1;
			prev_start <= start;
		end
	end
end

always @(posedge rst or posedge sck)
begin
	if(rst)
		cnt <= 0;
	else if(sck_cnt<size*2)
	begin
		cnt <= cnt + 1;
		rx_tmp_r <= {rx_tmp_r[size-2:0], miso};
		if(cnt>=size-1)
		begin
			cnt <= 0;
			rx_r <= {rx_tmp_r[size-2:0], miso};
		end
	end
	else if(sck_cnt>=size*2)
		cnt <= 0;
end

always @(posedge rst or negedge sck)
begin
	if(rst)
		mosi_r <= tx[size-1];
	else if(sck_cnt<size*2)
		mosi_r <= tx[size-1-cnt];
	else if(sck_cnt>=size*2)
		mosi_r <= tx[size-1];
end
endmodule
