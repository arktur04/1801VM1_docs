onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb1/clk
add wave -noupdate -expand -group Pins /tb1/ad_oe
add wave -noupdate -expand -group Pins -radix octal /tb1/ad_reg
add wave -noupdate -expand -group Pins -radix octal -childformat {{{/tb1/ad[15]} -radix octal} {{/tb1/ad[14]} -radix octal} {{/tb1/ad[13]} -radix octal} {{/tb1/ad[12]} -radix octal} {{/tb1/ad[11]} -radix octal} {{/tb1/ad[10]} -radix octal} {{/tb1/ad[9]} -radix octal} {{/tb1/ad[8]} -radix octal} {{/tb1/ad[7]} -radix octal} {{/tb1/ad[6]} -radix octal} {{/tb1/ad[5]} -radix octal} {{/tb1/ad[4]} -radix octal} {{/tb1/ad[3]} -radix octal} {{/tb1/ad[2]} -radix octal} {{/tb1/ad[1]} -radix octal} {{/tb1/ad[0]} -radix octal}} -subitemconfig {{/tb1/ad[15]} {-height 15 -radix octal} {/tb1/ad[14]} {-height 15 -radix octal} {/tb1/ad[13]} {-height 15 -radix octal} {/tb1/ad[12]} {-height 15 -radix octal} {/tb1/ad[11]} {-height 15 -radix octal} {/tb1/ad[10]} {-height 15 -radix octal} {/tb1/ad[9]} {-height 15 -radix octal} {/tb1/ad[8]} {-height 15 -radix octal} {/tb1/ad[7]} {-height 15 -radix octal} {/tb1/ad[6]} {-height 15 -radix octal} {/tb1/ad[5]} {-height 15 -radix octal} {/tb1/ad[4]} {-height 15 -radix octal} {/tb1/ad[3]} {-height 15 -radix octal} {/tb1/ad[2]} {-height 15 -radix octal} {/tb1/ad[1]} {-height 15 -radix octal} {/tb1/ad[0]} {-height 15 -radix octal}} /tb1/ad
add wave -noupdate -expand -group Pins /tb1/sync
add wave -noupdate -expand -group Pins /tb1/wtbt
add wave -noupdate -expand -group Pins /tb1/dout
add wave -noupdate -expand -group Pins /tb1/din
add wave -noupdate -expand -group Pins /tb1/rply
add wave -noupdate -expand -group Pins /tb1/iako
add wave -noupdate -expand -group Pins /tb1/dmr
add wave -noupdate -expand -group Pins /tb1/sack
add wave -noupdate -expand -group Pins /tb1/bsy
add wave -noupdate -expand -group Pins /tb1/irq
add wave -noupdate -expand -group Pins /tb1/virq
add wave -noupdate -expand -group Pins /tb1/dclo
add wave -noupdate -expand -group Pins /tb1/aclo
add wave -noupdate -expand -group Pins /tb1/init
add wave -noupdate -expand -group Pins /tb1/dmgi
add wave -noupdate -expand -group Pins /tb1/dmgo
add wave -noupdate -expand -group Pins /tb1/sel
add wave -noupdate -expand -group Pins /tb1/pa
add wave -noupdate -expand -group Pins /tb1/sp
add wave -noupdate -expand -group Pins /tb1/qb_oe
add wave -noupdate -expand -group Pins /tb1/init_reg
add wave -noupdate -expand -group Pins /tb1/din_reg
add wave -noupdate -expand -group Pins /tb1/dout_reg
add wave -noupdate -expand -group Pins /tb1/wtbt_reg
add wave -noupdate -expand -group Pins /tb1/sync_reg
add wave -noupdate -expand -group Pins /tb1/rply_reg
add wave -noupdate -expand -group Pins /tb1/sack_reg
add wave -noupdate -expand -group Pins /tb1/dmr_reg
add wave -noupdate -group Reset /tb1/cpu0/core/reset
add wave -noupdate -group Reset /tb1/cpu0/core/abort
add wave -noupdate -group Reset /tb1/cpu0/core/mj_res
add wave -noupdate -group Reset /tb1/cpu0/core/init_out
add wave -noupdate -group Reset /tb1/cpu0/core/abtos
add wave -noupdate -group Exceptions -expand /tb1/cpu0/core/exc_dbl
add wave -noupdate -group Exceptions /tb1/cpu0/core/exc_err2
add wave -noupdate -group Exceptions /tb1/cpu0/core/exc_err3
add wave -noupdate -group Exceptions /tb1/cpu0/core/exc_err7
add wave -noupdate -group Exceptions /tb1/cpu0/core/exc_oat
add wave -noupdate -group Exceptions /tb1/cpu0/core/exc_uop
add wave -noupdate -group Qbus /tb1/cpu0/core/ctrl_oe
add wave -noupdate -group Qbus /tb1/cpu0/core/oe_clr
add wave -noupdate -group Qbus /tb1/cpu0/core/oe_set
add wave -noupdate -group Qbus /tb1/cpu0/core/au_astb
add wave -noupdate -group Qbus -radix octal -childformat {{{/tb1/cpu0/core/areg[15]} -radix octal} {{/tb1/cpu0/core/areg[14]} -radix octal} {{/tb1/cpu0/core/areg[13]} -radix octal} {{/tb1/cpu0/core/areg[12]} -radix octal} {{/tb1/cpu0/core/areg[11]} -radix octal} {{/tb1/cpu0/core/areg[10]} -radix octal} {{/tb1/cpu0/core/areg[9]} -radix octal} {{/tb1/cpu0/core/areg[8]} -radix octal} {{/tb1/cpu0/core/areg[7]} -radix octal} {{/tb1/cpu0/core/areg[6]} -radix octal} {{/tb1/cpu0/core/areg[5]} -radix octal} {{/tb1/cpu0/core/areg[4]} -radix octal} {{/tb1/cpu0/core/areg[3]} -radix octal} {{/tb1/cpu0/core/areg[2]} -radix octal} {{/tb1/cpu0/core/areg[1]} -radix octal} {{/tb1/cpu0/core/areg[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/areg[15]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[14]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[13]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[12]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[11]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[10]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[9]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[8]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[7]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[6]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[5]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[4]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[3]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[2]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[1]} {-height 15 -radix octal} {/tb1/cpu0/core/areg[0]} {-height 15 -radix octal}} /tb1/cpu0/core/areg
add wave -noupdate -group Qbus -group DIN /tb1/cpu0/core/din_out
add wave -noupdate -group Qbus -group DIN /tb1/cpu0/core/din_start
add wave -noupdate -group Qbus -group DIN /tb1/cpu0/core/din_done
add wave -noupdate -group Qbus -group Timer -radix octal /tb1/cpu0/core/qbus_timer
add wave -noupdate -group Qbus -group Timer /tb1/cpu0/core/qbus_tovf
add wave -noupdate -group Qbus -group Timer /tb1/cpu0/core/qbus_tena
add wave -noupdate -group Qbus -group DOUT /tb1/cpu0/core/dout_out
add wave -noupdate -group Qbus -group DOUT /tb1/cpu0/core/dout_req
add wave -noupdate -group Qbus -group DOUT /tb1/cpu0/core/dout_start
add wave -noupdate -group Qbus -group DOUT /tb1/cpu0/core/dout_done
add wave -noupdate -group Qbus -expand -group SYNC /tb1/cpu0/core/sync_ena
add wave -noupdate -group Qbus -expand -group SYNC /tb1/cpu0/core/sync_fedge
add wave -noupdate -group Qbus -expand -group SYNC /tb1/cpu0/core/sync_out
add wave -noupdate -group Qbus -expand -group SYNC /tb1/cpu0/core/sync_out_h
add wave -noupdate -group Qbus -expand -group SYNC /tb1/cpu0/core/sync_stb
add wave -noupdate -expand -group ALU -radix octal -childformat {{{/tb1/cpu0/core/alu[15]} -radix octal} {{/tb1/cpu0/core/alu[14]} -radix octal} {{/tb1/cpu0/core/alu[13]} -radix octal} {{/tb1/cpu0/core/alu[12]} -radix octal} {{/tb1/cpu0/core/alu[11]} -radix octal} {{/tb1/cpu0/core/alu[10]} -radix octal} {{/tb1/cpu0/core/alu[9]} -radix octal} {{/tb1/cpu0/core/alu[8]} -radix octal} {{/tb1/cpu0/core/alu[7]} -radix octal} {{/tb1/cpu0/core/alu[6]} -radix octal} {{/tb1/cpu0/core/alu[5]} -radix octal} {{/tb1/cpu0/core/alu[4]} -radix octal} {{/tb1/cpu0/core/alu[3]} -radix octal} {{/tb1/cpu0/core/alu[2]} -radix octal} {{/tb1/cpu0/core/alu[1]} -radix octal} {{/tb1/cpu0/core/alu[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/alu[15]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[14]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[13]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[12]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[11]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[10]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[9]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[8]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[7]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[6]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[5]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[4]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[3]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[2]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[1]} {-height 15 -radix octal} {/tb1/cpu0/core/alu[0]} {-height 15 -radix octal}} /tb1/cpu0/core/alu
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/axy
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/oxy
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/c
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/d
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/f
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/h
add wave -noupdate -expand -group ALU -radix octal -childformat {{{/tb1/cpu0/core/x[15]} -radix octal} {{/tb1/cpu0/core/x[14]} -radix octal} {{/tb1/cpu0/core/x[13]} -radix octal} {{/tb1/cpu0/core/x[12]} -radix octal} {{/tb1/cpu0/core/x[11]} -radix octal} {{/tb1/cpu0/core/x[10]} -radix octal} {{/tb1/cpu0/core/x[9]} -radix octal} {{/tb1/cpu0/core/x[8]} -radix octal} {{/tb1/cpu0/core/x[7]} -radix octal} {{/tb1/cpu0/core/x[6]} -radix octal} {{/tb1/cpu0/core/x[5]} -radix octal} {{/tb1/cpu0/core/x[4]} -radix octal} {{/tb1/cpu0/core/x[3]} -radix octal} {{/tb1/cpu0/core/x[2]} -radix octal} {{/tb1/cpu0/core/x[1]} -radix octal} {{/tb1/cpu0/core/x[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/x[15]} {-height 15 -radix octal} {/tb1/cpu0/core/x[14]} {-height 15 -radix octal} {/tb1/cpu0/core/x[13]} {-height 15 -radix octal} {/tb1/cpu0/core/x[12]} {-height 15 -radix octal} {/tb1/cpu0/core/x[11]} {-height 15 -radix octal} {/tb1/cpu0/core/x[10]} {-height 15 -radix octal} {/tb1/cpu0/core/x[9]} {-height 15 -radix octal} {/tb1/cpu0/core/x[8]} {-height 15 -radix octal} {/tb1/cpu0/core/x[7]} {-height 15 -radix octal} {/tb1/cpu0/core/x[6]} {-height 15 -radix octal} {/tb1/cpu0/core/x[5]} {-height 15 -radix octal} {/tb1/cpu0/core/x[4]} {-height 15 -radix octal} {/tb1/cpu0/core/x[3]} {-height 15 -radix octal} {/tb1/cpu0/core/x[2]} {-height 15 -radix octal} {/tb1/cpu0/core/x[1]} {-height 15 -radix octal} {/tb1/cpu0/core/x[0]} {-height 15 -radix octal}} /tb1/cpu0/core/x
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/y
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_b
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_c
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_d
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_e
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_s
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_u
add wave -noupdate -expand -group ALU -group alu_* /tb1/cpu0/core/alu_x
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/clk
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_alsl
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_alsh
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_ard
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_astb
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_csely
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_dzh
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_dzl
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_is0
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_is1
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_mhl0
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_mhl1
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_pswx
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_pswy
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_qrdd
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_qstbd
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_qstbx
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_qsx
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_qsy
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_rsx0
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_rsx1
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_rsy0
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_rsy1
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_ta0
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_vsely
add wave -noupdate -expand -group ALU -expand -group au_* /tb1/cpu0/core/au_xyu
add wave -noupdate -expand -group ALU -expand -group au_* -expand /tb1/cpu0/core/rs
add wave -noupdate -expand -group ALU /tb1/cpu0/core/nx
add wave -noupdate -expand -group ALU -radix octal -childformat {{{/tb1/cpu0/core/xreg[15]} -radix octal} {{/tb1/cpu0/core/xreg[14]} -radix octal} {{/tb1/cpu0/core/xreg[13]} -radix octal} {{/tb1/cpu0/core/xreg[12]} -radix octal} {{/tb1/cpu0/core/xreg[11]} -radix octal} {{/tb1/cpu0/core/xreg[10]} -radix octal} {{/tb1/cpu0/core/xreg[9]} -radix octal} {{/tb1/cpu0/core/xreg[8]} -radix octal} {{/tb1/cpu0/core/xreg[7]} -radix octal} {{/tb1/cpu0/core/xreg[6]} -radix octal} {{/tb1/cpu0/core/xreg[5]} -radix octal} {{/tb1/cpu0/core/xreg[4]} -radix octal} {{/tb1/cpu0/core/xreg[3]} -radix octal} {{/tb1/cpu0/core/xreg[2]} -radix octal} {{/tb1/cpu0/core/xreg[1]} -radix octal} {{/tb1/cpu0/core/xreg[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/xreg[15]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[14]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[13]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[12]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[11]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[10]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[9]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[8]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[7]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[6]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[5]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[4]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[3]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[2]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[1]} {-height 15 -radix octal} {/tb1/cpu0/core/xreg[0]} {-height 15 -radix octal}} /tb1/cpu0/core/xreg
add wave -noupdate -expand -group ALU -radix octal /tb1/cpu0/core/qreg
add wave -noupdate -expand -group ALU -radix octal -childformat {{{/tb1/cpu0/core/yreg[15]} -radix octal} {{/tb1/cpu0/core/yreg[14]} -radix octal} {{/tb1/cpu0/core/yreg[13]} -radix octal} {{/tb1/cpu0/core/yreg[12]} -radix octal} {{/tb1/cpu0/core/yreg[11]} -radix octal} {{/tb1/cpu0/core/yreg[10]} -radix octal} {{/tb1/cpu0/core/yreg[9]} -radix octal} {{/tb1/cpu0/core/yreg[8]} -radix octal} {{/tb1/cpu0/core/yreg[7]} -radix octal} {{/tb1/cpu0/core/yreg[6]} -radix octal} {{/tb1/cpu0/core/yreg[5]} -radix octal} {{/tb1/cpu0/core/yreg[4]} -radix octal} {{/tb1/cpu0/core/yreg[3]} -radix octal} {{/tb1/cpu0/core/yreg[2]} -radix octal} {{/tb1/cpu0/core/yreg[1]} -radix octal} {{/tb1/cpu0/core/yreg[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/yreg[15]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[14]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[13]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[12]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[11]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[10]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[9]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[8]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[7]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[6]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[5]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[4]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[3]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[2]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[1]} {-height 15 -radix octal} {/tb1/cpu0/core/yreg[0]} {-height 15 -radix octal}} /tb1/cpu0/core/yreg
add wave -noupdate -expand -group ALU -radix hexadecimal /tb1/cpu0/core/vsel
add wave -noupdate -group PLI /tb1/cpu0/core/pli
add wave -noupdate -group PLI /tb1/cpu0/core/pli_nrdy
add wave -noupdate -group PLI /tb1/cpu0/core/pli_req
add wave -noupdate -group PLI /tb1/cpu0/core/pli_ena
add wave -noupdate -group PLI /tb1/cpu0/core/pli_ena_h
add wave -noupdate -group PLI /tb1/cpu0/core/pli_lat
add wave -noupdate -group PLI /tb1/cpu0/core/pli_stb
add wave -noupdate -group PLI /tb1/cpu0/core/pli_stb_h
add wave -noupdate -group PLI /tb1/cpu0/core/plir
add wave -noupdate -group PLM -radix octal -childformat {{{/tb1/cpu0/core/plx[33]} -radix octal} {{/tb1/cpu0/core/plx[32]} -radix octal} {{/tb1/cpu0/core/plx[31]} -radix octal} {{/tb1/cpu0/core/plx[30]} -radix octal} {{/tb1/cpu0/core/plx[29]} -radix octal} {{/tb1/cpu0/core/plx[28]} -radix octal} {{/tb1/cpu0/core/plx[27]} -radix octal} {{/tb1/cpu0/core/plx[26]} -radix octal} {{/tb1/cpu0/core/plx[25]} -radix octal} {{/tb1/cpu0/core/plx[24]} -radix octal} {{/tb1/cpu0/core/plx[23]} -radix octal} {{/tb1/cpu0/core/plx[22]} -radix octal} {{/tb1/cpu0/core/plx[21]} -radix octal} {{/tb1/cpu0/core/plx[20]} -radix octal} {{/tb1/cpu0/core/plx[19]} -radix octal} {{/tb1/cpu0/core/plx[18]} -radix octal} {{/tb1/cpu0/core/plx[17]} -radix octal} {{/tb1/cpu0/core/plx[16]} -radix octal} {{/tb1/cpu0/core/plx[15]} -radix octal} {{/tb1/cpu0/core/plx[14]} -radix octal} {{/tb1/cpu0/core/plx[13]} -radix octal} {{/tb1/cpu0/core/plx[12]} -radix octal} {{/tb1/cpu0/core/plx[11]} -radix octal} {{/tb1/cpu0/core/plx[10]} -radix octal} {{/tb1/cpu0/core/plx[9]} -radix octal} {{/tb1/cpu0/core/plx[8]} -radix octal} {{/tb1/cpu0/core/plx[7]} -radix octal} {{/tb1/cpu0/core/plx[6]} -radix octal} {{/tb1/cpu0/core/plx[5]} -radix octal} {{/tb1/cpu0/core/plx[4]} -radix octal} {{/tb1/cpu0/core/plx[3]} -radix octal} {{/tb1/cpu0/core/plx[2]} -radix octal} {{/tb1/cpu0/core/plx[1]} -radix octal} {{/tb1/cpu0/core/plx[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/plx[33]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[32]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[31]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[30]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[29]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[28]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[27]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[26]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[25]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[24]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[23]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[22]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[21]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[20]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[19]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[18]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[17]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[16]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[15]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[14]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[13]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[12]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[11]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[10]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[9]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[8]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[7]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[6]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[5]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[4]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[3]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[2]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[1]} {-height 15 -radix octal} {/tb1/cpu0/core/plx[0]} {-height 15 -radix octal}} /tb1/cpu0/core/plx
add wave -noupdate -group PLM -radix octal -childformat {{{/tb1/cpu0/core/plm[33]} -radix octal} {{/tb1/cpu0/core/plm[32]} -radix octal} {{/tb1/cpu0/core/plm[31]} -radix octal} {{/tb1/cpu0/core/plm[30]} -radix octal} {{/tb1/cpu0/core/plm[29]} -radix octal} {{/tb1/cpu0/core/plm[28]} -radix octal} {{/tb1/cpu0/core/plm[27]} -radix octal} {{/tb1/cpu0/core/plm[26]} -radix octal} {{/tb1/cpu0/core/plm[25]} -radix octal} {{/tb1/cpu0/core/plm[24]} -radix octal} {{/tb1/cpu0/core/plm[23]} -radix octal} {{/tb1/cpu0/core/plm[22]} -radix octal} {{/tb1/cpu0/core/plm[21]} -radix octal} {{/tb1/cpu0/core/plm[20]} -radix octal} {{/tb1/cpu0/core/plm[19]} -radix octal} {{/tb1/cpu0/core/plm[18]} -radix octal} {{/tb1/cpu0/core/plm[17]} -radix octal} {{/tb1/cpu0/core/plm[16]} -radix octal} {{/tb1/cpu0/core/plm[15]} -radix octal} {{/tb1/cpu0/core/plm[14]} -radix octal} {{/tb1/cpu0/core/plm[13]} -radix octal} {{/tb1/cpu0/core/plm[12]} -radix octal} {{/tb1/cpu0/core/plm[11]} -radix octal} {{/tb1/cpu0/core/plm[10]} -radix octal} {{/tb1/cpu0/core/plm[9]} -radix octal} {{/tb1/cpu0/core/plm[8]} -radix octal} {{/tb1/cpu0/core/plm[7]} -radix octal} {{/tb1/cpu0/core/plm[6]} -radix octal} {{/tb1/cpu0/core/plm[5]} -radix octal} {{/tb1/cpu0/core/plm[4]} -radix octal} {{/tb1/cpu0/core/plm[3]} -radix octal} {{/tb1/cpu0/core/plm[2]} -radix octal} {{/tb1/cpu0/core/plm[1]} -radix octal} {{/tb1/cpu0/core/plm[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/plm[33]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[32]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[31]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[30]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[29]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[28]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[27]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[26]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[25]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[24]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[23]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[22]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[21]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[20]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[19]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[18]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[17]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[16]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[15]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[14]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[13]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[12]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[11]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[10]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[9]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[8]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[7]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[6]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[5]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[4]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[3]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[2]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[1]} {-height 15 -radix octal} {/tb1/cpu0/core/plm[0]} {-height 15 -radix octal}} /tb1/cpu0/core/plm
add wave -noupdate -group PLM -radix octal -childformat {{{/tb1/cpu0/core/mj[14]} -radix octal} {{/tb1/cpu0/core/mj[13]} -radix octal} {{/tb1/cpu0/core/mj[12]} -radix octal} {{/tb1/cpu0/core/mj[11]} -radix octal} {{/tb1/cpu0/core/mj[10]} -radix octal} {{/tb1/cpu0/core/mj[9]} -radix octal} {{/tb1/cpu0/core/mj[8]} -radix octal} {{/tb1/cpu0/core/mj[7]} -radix octal} {{/tb1/cpu0/core/mj[6]} -radix octal} {{/tb1/cpu0/core/mj[5]} -radix octal} {{/tb1/cpu0/core/mj[4]} -radix octal} {{/tb1/cpu0/core/mj[3]} -radix octal} {{/tb1/cpu0/core/mj[2]} -radix octal} {{/tb1/cpu0/core/mj[1]} -radix octal} {{/tb1/cpu0/core/mj[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/mj[14]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[13]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[12]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[11]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[10]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[9]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[8]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[7]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[6]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[5]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[4]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[3]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[2]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[1]} {-height 15 -radix octal} {/tb1/cpu0/core/mj[0]} {-height 15 -radix octal}} /tb1/cpu0/core/mj
add wave -noupdate -group PLM /tb1/cpu0/core/ma
add wave -noupdate -group PLM /tb1/cpu0/core/mj_res
add wave -noupdate -group PLM /tb1/cpu0/core/mj_stb1
add wave -noupdate -group PLM /tb1/cpu0/core/mj_stb2
add wave -noupdate -group PLM /tb1/clk
add wave -noupdate -group PLM /tb1/cpu0/core/plm_stb
add wave -noupdate -group PLM /tb1/cpu0/core/sop_up
add wave -noupdate -group PLM /tb1/cpu0/core/alu_nrdy
add wave -noupdate -group PLM /tb1/cpu0/core/qbus_nrdy
add wave -noupdate -group PLM /tb1/cpu0/core/sop_out
add wave -noupdate -group PLM /tb1/cpu0/core/mj_res
add wave -noupdate -group PLM -radix octal /tb1/cpu0/core/plr
add wave -noupdate -group PLM /tb1/cpu0/core/plm1x
add wave -noupdate -group PLM /tb1/cpu0/core/plm2x
add wave -noupdate -group PLM /tb1/cpu0/core/plm1x_hl
add wave -noupdate -group PLM /tb1/cpu0/core/plm23
add wave -noupdate -group PLM /tb1/cpu0/core/plm_ena
add wave -noupdate -group PLM /tb1/cpu0/core/plm_ena_hl
add wave -noupdate -group PLM /tb1/cpu0/core/ustb1_hl
add wave -noupdate -group PLM -radix binary /tb1/cpu0/core/plop
add wave -noupdate -group PLM /tb1/cpu0/core/plr18r
add wave -noupdate -group PLM /tb1/cpu0/core/plr33r
add wave -noupdate -group PLM /tb1/cpu0/core/plrt
add wave -noupdate -group PLM /tb1/cpu0/core/plrtz
add wave -noupdate -group Instruction -radix octal -childformat {{{/tb1/cpu0/core/ir[15]} -radix octal} {{/tb1/cpu0/core/ir[14]} -radix octal} {{/tb1/cpu0/core/ir[13]} -radix octal} {{/tb1/cpu0/core/ir[12]} -radix octal} {{/tb1/cpu0/core/ir[11]} -radix octal} {{/tb1/cpu0/core/ir[10]} -radix octal} {{/tb1/cpu0/core/ir[9]} -radix octal} {{/tb1/cpu0/core/ir[8]} -radix octal} {{/tb1/cpu0/core/ir[7]} -radix octal} {{/tb1/cpu0/core/ir[6]} -radix octal} {{/tb1/cpu0/core/ir[5]} -radix octal} {{/tb1/cpu0/core/ir[4]} -radix octal} {{/tb1/cpu0/core/ir[3]} -radix octal} {{/tb1/cpu0/core/ir[2]} -radix octal} {{/tb1/cpu0/core/ir[1]} -radix octal} {{/tb1/cpu0/core/ir[0]} -radix octal}} -subitemconfig {{/tb1/cpu0/core/ir[15]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[14]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[13]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[12]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[11]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[10]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[9]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[8]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[7]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[6]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[5]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[4]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[3]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[2]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[1]} {-height 15 -radix octal} {/tb1/cpu0/core/ir[0]} {-height 15 -radix octal}} /tb1/cpu0/core/ir
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_clr
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_seq
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_set
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_stb1
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_stb2
add wave -noupdate -group Instruction /tb1/cpu0/core/ir_stop
add wave -noupdate -group Instruction -radix octal /tb1/cpu0/core/ira
add wave -noupdate -group Interrupt -radix octal -childformat {{{/tb1/cpu0/core/rq[19]} -radix octal} {{/tb1/cpu0/core/rq[18]} -radix octal} {{/tb1/cpu0/core/rq[17]} -radix octal} {{/tb1/cpu0/core/rq[16]} -radix octal} {{/tb1/cpu0/core/rq[15]} -radix octal} {{/tb1/cpu0/core/rq[14]} -radix octal} {{/tb1/cpu0/core/rq[13]} -radix octal} {{/tb1/cpu0/core/rq[12]} -radix octal} {{/tb1/cpu0/core/rq[11]} -radix octal} {{/tb1/cpu0/core/rq[10]} -radix octal} {{/tb1/cpu0/core/rq[9]} -radix octal} {{/tb1/cpu0/core/rq[8]} -radix octal} {{/tb1/cpu0/core/rq[7]} -radix octal} {{/tb1/cpu0/core/rq[6]} -radix octal} {{/tb1/cpu0/core/rq[5]} -radix octal} {{/tb1/cpu0/core/rq[4]} -radix octal} {{/tb1/cpu0/core/rq[3]} -radix octal} {{/tb1/cpu0/core/rq[2]} -radix octal} {{/tb1/cpu0/core/rq[1]} -radix octal} {{/tb1/cpu0/core/rq[0]} -radix octal}} -expand -subitemconfig {{/tb1/cpu0/core/rq[19]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[18]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[17]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[16]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[15]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[14]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[13]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[12]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[11]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[10]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[9]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[8]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[7]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[6]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[5]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[4]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[3]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[2]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[1]} {-height 15 -radix octal} {/tb1/cpu0/core/rq[0]} {-height 15 -radix octal}} /tb1/cpu0/core/rq
add wave -noupdate -group Interrupt /tb1/cpu0/core/start_irq
add wave -noupdate -group Interrupt /tb1/cpu0/core/aclo
add wave -noupdate -group Interrupt /tb1/cpu0/core/acok
add wave -noupdate -group Interrupt /tb1/cpu0/core/aclo_ack
add wave -noupdate -group USTB /tb1/clk
add wave -noupdate -group USTB /tb1/cpu0/core/alu_nrdy
add wave -noupdate -group USTB /tb1/cpu0/core/alu_nrdy_h
add wave -noupdate -group USTB /tb1/cpu0/core/ustb
add wave -noupdate -group USTB /tb1/cpu0/core/ustb0
add wave -noupdate -group USTB /tb1/cpu0/core/ustb1
add wave -noupdate -group USTB /tb1/cpu0/core/ustb1_h
add wave -noupdate -group USTB /tb1/cpu0/core/ustb1_hl
add wave -noupdate -group USTB /tb1/cpu0/core/ustb2
add wave -noupdate -group USTB /tb1/cpu0/core/ustb4
add wave -noupdate -group USTB /tb1/cpu0/core/ustb_h
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {262988 ps} 0}
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
WaveRestoreZoom {81986 ps} {671360 ps}
