module MAIN (clk);

input  wire clk;
	
wire rst;
RESET reset(.rst(rst),.clk(clk));

reg delay_enable;
wire delay_done;
reg [31:0] delay_time;
DELAY_MS delay_ms(.rst(rst),.clk(clk),.enable(delay_enable),.done(delay_done),.ms(delay_time));

reg led1_r, led2_r, led3_r;

reg [3:0] state;

always @(posedge rst or posedge clk)
begin
	if(rst)
	begin
		led1_r = 0; led2_r = 0; led3_r = 0; state = 0;
	end
	else if(clk)
	begin
		case(state)
		0:
		begin
			led1_r <= ~led1_r;
			state <= state + 1;
		end
		1:
		begin
			delay_time <= 10;
			delay_enable <= 1;
			if(delay_done)
			begin
				delay_enable <= 0;
				state <= state + 1;
			end
		end
		2:
		begin
			led2_r <= ~led2_r;
			state <= state + 1;
		end
		3:
		begin
			delay_time <= 10;
			delay_enable <= 1;
			if(delay_done)
			begin
				delay_enable <= 0;
				state <= state + 1;
			end
		end
		4:
		begin
			led3_r <= ~led3_r;
			state <= state + 1;
		end
		5:
		begin
			delay_time <= 10;
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

endmodule