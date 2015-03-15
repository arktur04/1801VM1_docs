onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb1/ena
add wave -noupdate /tb1/reset
add wave -noupdate /tb1/sp
add wave -noupdate -radix hexadecimal /tb1/keep
add wave -noupdate -radix hexadecimal /tb1/din
add wave -noupdate -radix hexadecimal /tb1/dout
add wave -noupdate /tb1/csr_oe
add wave -noupdate /tb1/cnt_oe
add wave -noupdate /tb1/lim_oe
add wave -noupdate /tb1/csr_wr
add wave -noupdate /tb1/lim_wr
add wave -noupdate /tb1/timer/tve_clk
add wave -noupdate /tb1/timer/tve_ena
add wave -noupdate /tb1/timer/tve_reset
add wave -noupdate -radix octal -childformat {{{/tb1/timer/tve_pre[6]} -radix octal} {{/tb1/timer/tve_pre[5]} -radix octal} {{/tb1/timer/tve_pre[4]} -radix octal} {{/tb1/timer/tve_pre[3]} -radix octal} {{/tb1/timer/tve_pre[2]} -radix octal} {{/tb1/timer/tve_pre[1]} -radix octal} {{/tb1/timer/tve_pre[0]} -radix octal}} -subitemconfig {{/tb1/timer/tve_pre[6]} {-height 15 -radix octal} {/tb1/timer/tve_pre[5]} {-height 15 -radix octal} {/tb1/timer/tve_pre[4]} {-height 15 -radix octal} {/tb1/timer/tve_pre[3]} {-height 15 -radix octal} {/tb1/timer/tve_pre[2]} {-height 15 -radix octal} {/tb1/timer/tve_pre[1]} {-height 15 -radix octal} {/tb1/timer/tve_pre[0]} {-height 15 -radix octal}} /tb1/timer/tve_pre
add wave -noupdate -radix octal /tb1/timer/tve_div
add wave -noupdate /tb1/timer/tve_tclk4
add wave -noupdate /tb1/timer/tve_tclk128
add wave -noupdate /tb1/timer/tve_sp
add wave -noupdate /tb1/timer/tve_tclk
add wave -noupdate -radix hexadecimal /tb1/timer/tve_csr
add wave -noupdate -radix hexadecimal /tb1/timer/tve_limit
add wave -noupdate /tb1/clk
add wave -noupdate -radix hexadecimal /tb1/timer/tve_count
add wave -noupdate /tb1/timer/tve_csr_oe
add wave -noupdate /tb1/timer/tve_lim_oe
add wave -noupdate /tb1/timer/tve_cnt_oe
add wave -noupdate /tb1/timer/tve_csr_wr
add wave -noupdate /tb1/timer/tve_lim_wr
add wave -noupdate -radix hexadecimal /tb1/timer/tve_din
add wave -noupdate -radix hexadecimal /tb1/timer/tve_dout
add wave -noupdate /tb1/timer/tve_edge
add wave -noupdate /tb1/timer/tve_intrq
add wave -noupdate /tb1/timer/tve_load
add wave -noupdate /tb1/timer/tve_back
add wave -noupdate /tb1/timer/tve_zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115825000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {111062572 ps} {116465128 ps}
