library verilog;
use verilog.vl_types.all;
entity reset_block is
    port(
        clk             : in     vl_logic;
        reset           : out    vl_logic
    );
end reset_block;
