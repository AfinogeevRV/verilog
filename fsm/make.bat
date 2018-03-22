cd  /d d:\projects\iverilog\fsm

iverilog -o qqq testbench.v main.v reset.v delay_ms.v
vvp qqq
gtkwave out.vcd

@pause