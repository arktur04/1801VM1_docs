onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb1/clk
add wave -noupdate /tb1/psw
add wave -noupdate /tb1/plir
add wave -noupdate /tb1/uerr
add wave -noupdate /tb1/virq
add wave -noupdate /tb1/irq
add wave -noupdate /tb1/qbto
add wave -noupdate /tb1/dble
add wave -noupdate /tb1/aclo
add wave -noupdate /tb1/acok
add wave -noupdate /tb1/iato
add wave -noupdate /tb1/pli
add wave -noupdate /tb1/rq
add wave -noupdate /tb1/irq2_rearm
add wave -noupdate /tb1/irq3_rearm
add wave -noupdate /tb1/aclo_rearm
add wave -noupdate /tb1/uop_rearm
add wave -noupdate -radix octal -childformat {{{/tb1/vect[15]} -radix octal} {{/tb1/vect[14]} -radix octal} {{/tb1/vect[13]} -radix octal} {{/tb1/vect[12]} -radix octal} {{/tb1/vect[11]} -radix octal} {{/tb1/vect[10]} -radix octal} {{/tb1/vect[9]} -radix octal} {{/tb1/vect[8]} -radix octal} {{/tb1/vect[7]} -radix octal} {{/tb1/vect[6]} -radix octal} {{/tb1/vect[5]} -radix octal} {{/tb1/vect[4]} -radix octal} {{/tb1/vect[3]} -radix octal} {{/tb1/vect[2]} -radix octal} {{/tb1/vect[1]} -radix octal} {{/tb1/vect[0]} -radix octal}} -subitemconfig {{/tb1/vect[15]} {-height 15 -radix octal} {/tb1/vect[14]} {-height 15 -radix octal} {/tb1/vect[13]} {-height 15 -radix octal} {/tb1/vect[12]} {-height 15 -radix octal} {/tb1/vect[11]} {-height 15 -radix octal} {/tb1/vect[10]} {-height 15 -radix octal} {/tb1/vect[9]} {-height 15 -radix octal} {/tb1/vect[8]} {-height 15 -radix octal} {/tb1/vect[7]} {-height 15 -radix octal} {/tb1/vect[6]} {-height 15 -radix octal} {/tb1/vect[5]} {-height 15 -radix octal} {/tb1/vect[4]} {-height 15 -radix octal} {/tb1/vect[3]} {-height 15 -radix octal} {/tb1/vect[2]} {-height 15 -radix octal} {/tb1/vect[1]} {-height 15 -radix octal} {/tb1/vect[0]} {-height 15 -radix octal}} /tb1/vect
add wave -noupdate /tb1/tvgen/vsel
add wave -noupdate /tb1/mpli/p
add wave -noupdate /tb1/vstate
add wave -noupdate /tb1/wcpu
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {315394 ps} 0}
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
WaveRestoreZoom {228680 ps} {411626 ps}
