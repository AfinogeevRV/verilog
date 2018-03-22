module SinusGen (clk, led1, idclk, qdclk, I, Q);
parameter Width_Data = 12;
parameter Width_Angle = 16;
parameter Koef_Mash = 13'h4DB; 

parameter Step_S = 12'd50; //(x/7462,687)      7462 = f/3216/4      3216 = 45*2/16    45 = 25736
parameter Freq_Factor = 16'd3400;
parameter Step_L = Step_S + 1;

input clk;
output led1;
output idclk, qdclk; 
output [Width_Data-1:0] I; 
output [Width_Data-1:0] Q; 

wire led1, clk;
wire reset;
wire [Width_Data:0] Xi_cordic, Yi_cordic;
wire [Width_Data:0] Xo_cordic, Yo_cordic; 
wire [Width_Data:0] Xq, Yq;
wire [Width_Data:0] Angle_i, Angle_o;
wire [1:0] quarter_in, quarter_out;
wire idclk, qdclk;

assign led1 = 1'b1;

assign I[Width_Data-1:0] = Xq[Width_Data-1:0];
assign Q[Width_Data-1:0] = Yq[Width_Data-1:0];

assign idclk = clk;
assign qdclk = clk;

assign Xi_cordic = Koef_Mash;
assign Yi_cordic = 13'h000;

reset_block reset_block_user ( .clk(clk), .reset(reset) );

defparam step_control_user.freq_factor = Freq_Factor;
defparam step_control_user.step_s = Step_S;
defparam step_control_user.step_l = Step_L;
step_control step_control_user ( .clk(clk), .Angle(Angle_i), 
.quarter_in(quarter_in));

defparam cordic_user.width_data = Width_Data;
defparam cordic_user.width_angle = Width_Angle;
cordic cordic_user ( .clk(clk), .rst(reset), 
.x_i(Xi_cordic), .y_i(Yi_cordic), .theta_i(Angle_i),
.x_o(Xo_cordic), .y_o(Yo_cordic), .theta_o(Angle_o),
.quarter_in(quarter_in), .quarter_out(quarter_out));

select_quarter quarter_user (
.clk(clk), .rst(reset), 
.Xi(Xo_cordic), .Yi(Yo_cordic), 
.Xo(Xq), .Yo(Yq), 
.quarter (quarter_out));

endmodule