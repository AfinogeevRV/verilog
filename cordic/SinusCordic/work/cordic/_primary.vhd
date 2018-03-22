library verilog;
use verilog.vl_types.all;
entity cordic is
    generic(
        width_data      : integer := 12;
        width_angle     : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        x_i             : in     vl_logic_vector;
        y_i             : in     vl_logic_vector;
        theta_i         : in     vl_logic_vector;
        x_o             : out    vl_logic_vector;
        y_o             : out    vl_logic_vector;
        theta_o         : out    vl_logic_vector;
        quarter_in      : in     vl_logic_vector(1 downto 0);
        quarter_out     : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width_data : constant is 1;
    attribute mti_svvh_generic_type of width_angle : constant is 1;
end cordic;
