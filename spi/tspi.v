module tspi;

reg clk;
reg rst;

wire mas_sck;
wire mas_sdin;
wire mas_sdout;
wire sl_sck;
wire sl_sdin;
wire sl_sdout;
wire led1;
wire led2;
wire led3;
reg button;

//assign mas_sck = sl_sck;
//assign mas_sdout = sl_sdin;
//assign mas_sdin = sl_sdout;


main m(
	clk,
	rst,
	//spi_master//
	mas_sck,
	mas_sdin,
	mas_sdout,
	//spi_slave//
	mas_sck,
	mas_sdout,
	mas_sdin,
	//leds//
	led1,
	led2,
	led3,
	//key//
	button
);

 always
	#1 clk  = ~clk;
	

initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,tspi);
  clk<=0;
  rst<=0;
  button<=1;
  
  #5
  rst <= 1;
  #5
  rst <= 0;
  #10
  
  button<=0;
  #100
  button<=1;
  #10
  
	
	$finish;
end

endmodule