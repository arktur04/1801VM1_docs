onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb1/clk
add wave -noupdate -group Pins /tb1/sp
add wave -noupdate -group Pins /tb1/pa
add wave -noupdate -group Pins /tb1/dclo
add wave -noupdate -group Pins /tb1/aclo
add wave -noupdate -group Pins /tb1/irq
add wave -noupdate -group Pins /tb1/virq
add wave -noupdate -group Pins /tb1/init
add wave -noupdate -group Pins /tb1/init_reg
add wave -noupdate -group Pins -radix octal /tb1/ad
add wave -noupdate -group Pins -radix octal /tb1/ad_reg
add wave -noupdate -group Pins /tb1/ad_oe
add wave -noupdate -group Pins /tb1/qb_oe
add wave -noupdate -group Pins /tb1/dmgi
add wave -noupdate -group Pins /tb1/dmgo
add wave -noupdate -group Pins /tb1/din
add wave -noupdate -group Pins /tb1/dout
add wave -noupdate -group Pins /tb1/wtbt
add wave -noupdate -group Pins /tb1/sync
add wave -noupdate -group Pins /tb1/rply
add wave -noupdate -group Pins /tb1/dmr
add wave -noupdate -group Pins /tb1/sack
add wave -noupdate -group Pins /tb1/iako
add wave -noupdate -group Pins /tb1/bsy
add wave -noupdate -group Pins /tb1/sel
add wave -noupdate -group Pins /tb1/din_reg
add wave -noupdate -group Pins /tb1/dout_reg
add wave -noupdate -group Pins /tb1/wtbt_reg
add wave -noupdate -group Pins /tb1/sync_reg
add wave -noupdate -group Pins /tb1/rply_reg
add wave -noupdate -group Pins /tb1/sack_reg
add wave -noupdate -group Pins /tb1/dmr_reg
add wave -noupdate -expand -group Reset /tb1/cpu0/core/reset
add wave -noupdate -expand -group Reset /tb1/cpu0/core/abort
add wave -noupdate -expand -group Reset /tb1/cpu0/core/mj_res
add wave -noupdate -expand -group Reset /tb1/cpu0/core/init_out
add wave -noupdate -expand -group Reset /tb1/cpu0/core/abtos
add wave -noupdate -expand -group Exceptions -expand /tb1/cpu0/core/exc_dbl
add wave -noupdate -expand -group Exceptions /tb1/cpu0/core/exc_err2
add wave -noupdate -expand -group Exceptions /tb1/cpu0/core/exc_err3
add wave -noupdate -expand -group Exceptions /tb1/cpu0/core/exc_err7
add wave -noupdate -expand -group Exceptions /tb1/cpu0/core/exc_oat
add wave -noupdate -expand -group Exceptions /tb1/cpu0/core/exc_uop
add wave -noupdate -expand -group Qbus /tb1/cpu0/core/au_astb
add wave -noupdate -expand -group Qbus -radix octal /tb1/cpu0/core/areg
add wave -noupdate -expand -group Qbus -expand -group DIN /tb1/cpu0/core/din_out
add wave -noupdate -expand -group Qbus -expand -group DIN /tb1/cpu0/core/din_start
add wave -noupdate -expand -group Qbus -expand -group DIN /tb1/cpu0/core/din_done
add wave -noupdate -expand -group Qbus -group Timer -radix octal /tb1/cpu0/core/qbus_timer
add wave -noupdate -expand -group Qbus -group Timer /tb1/cpu0/core/qbus_tovf
add wave -noupdate -expand -group Qbus -group Timer /tb1/cpu0/core/qbus_tena
add wave -noupdate -expand -group Qbus -group DOUT /tb1/cpu0/core/dout_out
add wave -noupdate -expand -group Qbus -group DOUT /tb1/cpu0/core/dout_req
add wave -noupdate -expand -group Qbus -group DOUT /tb1/cpu0/core/dout_start
add wave -noupdate -expand -group Qbus -group DOUT /tb1/cpu0/core/dout_done
add wave -noupdate -expand -group Alu -radix octal /tb1/cpu0/core/alu
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_b
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_c
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_d
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_e
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_s
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_u
add wave -noupdate -expand -group Alu /tb1/cpu0/core/alu_x
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {665000 ps} 0}
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
WaveRestoreZoom {0 ps} {4754816 ps}
