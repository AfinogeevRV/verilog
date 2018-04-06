module MAIN (clk, ss_s, sck_s, miso_s, mosi_s, sck_m, miso_m, mosi_m, ss_m);

input clk;
input ss_s;
input sck_s;
output miso_s;
input mosi_s;
output sck_m;
input miso_m;
output mosi_m;
output ss_m;
	
wire rst;
RESET reset(.rst(rst),.clk(clk));

reg [7:0] tx_s = 8'h55;
wire [7:0] rx_s;
reg [7:0] tx_m = 8'h55;
wire [7:0] rx_m;

reg en_m_r;
wire en_m = en_m_r;
assign ss_m = ~en_m_r;


reg led_r;
assign led = led_r;

//assign tx_w = tx;

defparam spi_s.size = 8;
SPI_SLAVE spi_s(rst, ss_s, sck_s, miso_s, mosi_s, tx_s, rx_s);

SPI_MASTER spi_m(rst, clk, en_m, sck_m, miso_m, mosi_m, tx_m, rx_m);

reg delay_enable;
wire delay_done;
reg [31:0] delay_time;
DELAY_MS delay_ms(.rst(rst),.clk(clk),.enable(delay_enable),.done(delay_done),.ms(delay_time));

reg [3:0] state;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		en_m_r <= 0; state <= 0;
	end
	else if(clk)
	begin
		case(state)
		0:
		begin
			en_m_r <= 0;
			state <= state + 1;
		end
		1:
		begin
			delay_time <= 5;
			delay_enable <= 1;
			if(delay_done)
			begin
				delay_enable <= 0;
				state <= state + 1;
			end
		end
		2:
		begin
			en_m_r <= 1;
			state <= state + 1;
		end
		3:
		begin
			delay_time <= 1;
			delay_enable <= 1;
			if(delay_done)
			begin
				delay_enable <= 0;
				state <= state + 1;
			end
		end
		4:
		begin
			en_m_r <= 0;
			state <= state + 1;
		end
		5:
		begin
			delay_time <= 5;
			delay_enable <= 1;
			if(delay_done)
			begin
				delay_enable <= 0;
				state <= state + 1;
			end
		end
		default:
			state <= 0;
		endcase
	end
end

always @(clk)
begin
	if(rx_s==tx_m)
		led_r <= 1'b1;
	else 
		led_r <= 1'b0;
end

always @(posedge rst or posedge ss_s)
begin
	if(rst)
		tx_s <= 8'h41;
	else if(ss_s)
	begin
			tx_s <= tx_s + 1'b1;
			if(tx_s>=8'h7E)
				tx_s <= 8'h41;
	end
end

always @(posedge rst or posedge en_m)
begin
	if(rst)
		tx_m <= 8'h30;
	else if(en_m)
	begin
			tx_m <= tx_m + 1'b1;
			if(tx_m>=8'h39)
				tx_m <= 8'h30;
	end
end


endmodule
