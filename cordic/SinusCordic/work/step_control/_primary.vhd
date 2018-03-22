library verilog;
use verilog.vl_types.all;
entity step_control is
    generic(
        first           : integer := 0;
        second          : integer := 1;
        third           : integer := 2;
        fourth          : integer := 3;
        freq_factor     : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        acc_decr        : vl_notype;
        angle_90        : vl_logic_vector(0 to 11) := (Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        step_s          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        step_l          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        Angle           : out    vl_logic_vector(12 downto 0);
        quarter_in      : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of first : constant is 1;
    attribute mti_svvh_generic_type of second : constant is 1;
    attribute mti_svvh_generic_type of third : constant is 1;
    attribute mti_svvh_generic_type of fourth : constant is 1;
    attribute mti_svvh_generic_type of freq_factor : constant is 1;
    attribute mti_svvh_generic_type of acc_decr : constant is 3;
    attribute mti_svvh_generic_type of angle_90 : constant is 1;
    attribute mti_svvh_generic_type of step_s : constant is 1;
    attribute mti_svvh_generic_type of step_l : constant is 1;
end step_control;
