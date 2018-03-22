library verilog;
use verilog.vl_types.all;
entity SinusGen is
    generic(
        Width_Data      : integer := 12;
        Width_Angle     : integer := 16;
        Koef_Mash       : vl_logic_vector(0 to 12) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1);
        Step_S          : vl_logic_vector(0 to 11) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0);
        Freq_Factor     : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        Step_L          : vl_notype
    );
    port(
        clk             : in     vl_logic;
        led1            : out    vl_logic;
        idclk           : out    vl_logic;
        qdclk           : out    vl_logic;
        I               : out    vl_logic_vector;
        Q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Width_Data : constant is 1;
    attribute mti_svvh_generic_type of Width_Angle : constant is 1;
    attribute mti_svvh_generic_type of Koef_Mash : constant is 1;
    attribute mti_svvh_generic_type of Step_S : constant is 1;
    attribute mti_svvh_generic_type of Freq_Factor : constant is 1;
    attribute mti_svvh_generic_type of Step_L : constant is 3;
end SinusGen;
