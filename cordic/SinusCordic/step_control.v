module step_control ( clk, Angle, quarter_in );
parameter first = 0;
parameter second = 1;
parameter third = 2;
parameter fourth = 3;
parameter freq_factor = 16'd3400;
parameter acc_decr = 16'd10000 - freq_factor;
parameter angle_90 = 12'd3216;
parameter step_s = 12'd1;
parameter step_l = 12'd2;

input clk;
output reg[12:0] Angle = 13'd0;
output reg[1:0] quarter_in = 2'b00;

reg [15:0] M = freq_factor; // 16'd3400
reg ena_incr = 1'b0; 
reg [15:0] Acc = 16'd0;
reg reset_acc = 1'b0;
reg [1:0] state = first;
reg [11:0] count_ang = 12'd0;

always @ (posedge clk)
begin
	if(reset_acc == 1'b1) Acc <= 16'd0;
	else begin  
	 if(Acc >= 16'd10000) begin
	   ena_incr <= 1'b1;
		 Acc <= Acc - acc_decr;
	 end
	 else begin
	   ena_incr <= 1'b0;
	   Acc <= Acc + M;
	 end
	end
end

always @ (posedge clk)
begin
	case(state)
		first:  
			if(count_ang >= angle_90) begin
					state <= second;
					count_ang <= 12'd0; 
					quarter_in <= 2'b01;
			end
			else begin
					state <= first; 
					quarter_in <= 2'b00;
					if(ena_incr) begin
						Angle <= Angle + step_l;
						count_ang <= count_ang+step_l; 
					end
					else begin
						Angle <= Angle + step_s;
						count_ang <= count_ang+step_s; 
					end
			end
		second: 
			if(count_ang >= angle_90) begin
					state <= third;
					count_ang <= 12'd0; 
					quarter_in <= 2'b10;
			end
			else begin
					state <= second; 
					quarter_in <= 2'b01;
					if(ena_incr) begin
						Angle <= Angle - step_l;
						count_ang <= count_ang+step_l; 
					end
					else begin
						Angle <= Angle - step_s;
						count_ang <= count_ang+step_s; 
					end
			end
		third:  
			if(count_ang >= angle_90) begin
					state <= fourth;
					count_ang <= 12'd0; 
					quarter_in <= 2'b11;
			end
			else begin
					state <= third; 
					quarter_in <= 2'b10;
					if(ena_incr) begin
						Angle <= Angle + step_l;
						count_ang <= count_ang+step_l; 
					end
					else begin
						Angle <= Angle + step_s;
						count_ang <= count_ang+step_s; 
					end
			end
		fourth:  
			if(count_ang >= angle_90) begin
					state <= first;
					count_ang <= 12'd0; 
					quarter_in <= 2'b00;
			end
			else begin
					state <= fourth; 
					quarter_in <= 2'b11;
					if(ena_incr) begin
						Angle <= Angle - step_l;
						count_ang <= count_ang+step_l; 
					end
					else begin
						Angle <= Angle - step_s;
						count_ang <= count_ang+step_s; 
					end
			end
	endcase
end

always @ (posedge clk)
begin
	if(count_ang == angle_90) reset_acc <= 1'b1;
	else reset_acc <= 1'b0;
end

endmodule