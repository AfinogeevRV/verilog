library verilog;
use verilog.vl_types.all;
entity select_quarter is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Xi              : in     vl_logic_vector(12 downto 0);
        Yi              : in     vl_logic_vector(12 downto 0);
        Xo              : out    vl_logic_vector(12 downto 0);
        Yo              : out    vl_logic_vector(12 downto 0);
        quarter         : in     vl_logic_vector(1 downto 0)
    );
end select_quarter;
