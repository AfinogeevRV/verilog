vlog test_bench.v SinusGen.v cordic.v step_control.v reset_block.v select_quarter.v rotator.v
vsim work.test_bench

#add wave -r /*

add wave -noupdate -format Logic /test_bench/clk

add wave -noupdate -format Logic /test_bench/SinusGen_user/reset_block_user/reset

add wave -noupdate -group Top_Module_SinusGen -color Cyan -format Logic \
{/test_bench/SinusGen_user/idclk} 

add wave -noupdate -expand -group Top_Module_SinusGen -color Cyan -format Analog-Step \
-height 150 -max 4092.0 -radix unsigned /test_bench/SinusGen_user/I

add wave -noupdate -group Top_Module_SinusGen -color {SteelBlue} -format Logic \
{/test_bench/SinusGen_user/qdclk}

add wave -noupdate -group Top_Module_SinusGen -color {SteelBlue} -format Analog-Step \
-height 150 -max 4092.0 -radix unsigned /test_bench/SinusGen_user/Q

add wave -noupdate -group Top_Module_SinusGen -color Green -format Analog-Step \
-height 50 -max 3216.0 -radix unsigned /test_bench/SinusGen_user/step_control_user/Angle

add wave -noupdate -group Top_Module_SinusGen -color Green -format Logic \
{/test_bench/SinusGen_user/step_control_user/quarter_in}

add wave -noupdate -group Top_Module_SinusGen -color Green -format Analog-Step \
-height 50 -max 3216.0 -radix unsigned /test_bench/SinusGen_user/step_control_user/count_ang

add wave -noupdate -group Top_Module_SinusGen -color Green -format Logic \
{/test_bench/SinusGen_user/step_control_user/state}


#Rotator 0
add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Logic \
{/test_bench/SinusGen_user/cordic_user/rot[0]/U/z_i}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Analog-Step \
-height 50 -max 2048.0 {/test_bench/SinusGen_user/cordic_user/rot[0]/U/x_i}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Logic \
{/test_bench/SinusGen_user/cordic_user/rot[0]/U/y_i}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Logic \
{/test_bench/SinusGen_user/cordic_user/rot[0]/U/z_o}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Analog-Step \
-height 50 -max 2048.0 {/test_bench/SinusGen_user/cordic_user/rot[0]/U/x_o}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Logic \
{/test_bench/SinusGen_user/cordic_user/rot[0]/U/y_o}

add wave -noupdate -expand -group Cordic -group Rotator0 -color Green -format Logic \
{/test_bench/SinusGen_user/cordic_user/rot[0]/U/quarter_o}


#Add quarter module
#add wave -noupdate -group Select Quarter -color Green -format Logic \
#/test_bench/Sinus10kHz_user/select_quarter_user/Xi \
#/test_bench/Sinus10kHz_user/select_quarter_user/Yi \
#/test_bench/Sinus10kHz_user/select_quarter_user/Xo \
#/test_bench/Sinus10kHz_user/select_quarter_user/Yo \
#/test_bench/Sinus10kHz_user/select_quarter_user/quarter

run 200 us