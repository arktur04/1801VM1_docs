//
// Copyright (c) 2014 by 1801BM1@gmail.com
//
// Testbench for the 1801BM1 replica, native QBUS version
//______________________________________________________________________________
//
`include "config.v"

//______________________________________________________________________________
//
// Primary testbench top module
//
module tb1();
                        //
reg         clk;        // processor clock
reg         ena;        // enable clock
reg         sp;         // peripheral timer input
reg [1:0]   pa;         // processor number
reg         dclo;       // processor reset
reg         aclo;       // power fail notoficaton
reg [3:1]   irq;        // radial interrupt requests
reg         virq;       // vectored interrupt request
                        //
tri1        init;       // peripheral reset
reg         init_reg;   //
                        //
tri1 [15:0] ad;         // inverted address/data bus
reg  [15:0] ad_reg;     //
reg         ad_oe;      //
                        //
reg         qb_oe;      //
reg         dmgi;       //
wire        dmgo;       // bus granted output
tri1        din;        // data input strobe
tri1        dout;       // data output strobe
tri1        wtbt;       // write/byte status
tri1        sync;       // address strobe
tri1        rply;       // transaction reply
tri1        dmr;        // bus request shared line
tri1        sack;       // bus acknowlegement
tri1        iako;       // interrupt vector input
tri1        bsy;        //
tri1 [2:1]  sel;        //
                        //
reg         din_reg;    //
reg         dout_reg;   //
reg         wtbt_reg;   //
reg         sync_reg;   //
reg         rply_reg;   //
reg         sack_reg;   //
reg         dmr_reg;    //

//_____________________________________________________________________________
//
assign      ad    = ad_oe     ? ad_reg    : 16'hZZZZ;
assign      din   = qb_oe     ? din_reg   : 1'bZ;
assign      dout  = qb_oe     ? dout_reg  : 1'bZ;
assign      wtbt  = qb_oe     ? wtbt_reg  : 1'bZ;
assign      sync  = qb_oe     ? sync_reg  : 1'bZ;
assign      iako  = 1'bZ;

assign      rply  = rply_reg  ? 1'bZ      : 1'b0;
assign      sack  = sack_reg  ? 1'bZ      : 1'b0;
assign      sack  = sack_reg  ? 1'bZ      : 1'b0;
assign      dmr   = dmr_reg   ? 1'bZ      : 1'b0;

//_____________________________________________________________________________
//
// Clock generator
//
initial
begin
   ena = 1;
   clk = 0;
   forever
      begin
         #(`SIM_CONFIG_CLOCK_HPERIOD);
         clk = 0;
         #(`SIM_CONFIG_CLOCK_HPERIOD);
         clk = 1;
      end
end

//_____________________________________________________________________________
//
// Simulation time limit (first breakpoint)
//
initial
begin
   #`SIM_CONFIG_TIME_LIMIT $stop;
end

//_____________________________________________________________________________
//
initial
begin
   sp       = 1;
   pa       = 2'b11;
   dmgi     = 1;
   dclo     = 0;
   aclo     = 0;
   irq      = 3'b111;
   virq     = 1;
   init_reg = 1;
   ad_reg   = ~16'h0000;
   ad_oe    = 0;
   qb_oe    = 0;
   din_reg  = 1;
   dout_reg = 1;
   wtbt_reg = 1;
   sync_reg = 1;
   rply_reg = 1;
   sack_reg = 1;
   dmr_reg  = 1;

//
// CPU start
//
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
   dclo     = 1;
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
@ (posedge clk);
   aclo     = 1;
   $display("Processor ACLO and DCLO deasserted");


//$stop;
end

//_____________________________________________________________________________
//
vm1 cpu0
(
   .pin_clk(clk),             // processor clock
   .pin_ena(ena),             // processor clock enable
   .pin_pa_n(pa),             // processor number
   .pin_init_n(init),         // peripheral reset
   .pin_dclo_n(dclo),         // processor reset
   .pin_aclo_n(aclo),         // power fail notoficaton
   .pin_irq_n(irq),           // radial interrupt requests
   .pin_virq_n(virq),         // vectored interrupt request
                              //
   .pin_ad_n(ad),             // inverted address/data bus
   .pin_dout_n(dout),         // data output strobe
   .pin_din_n(din),           // data input strobe
   .pin_wtbt_n(wtbt),         // write/byte status
   .pin_sync_n(sync),         // address strobe
   .pin_rply_n(rply),         // transaction reply
   .pin_dmr_n(dmr),           // bus request shared line
   .pin_sack_n(sack),         // bus acknowlegement
   .pin_dmgi_n(dmgi),         // bus granted input
   .pin_dmgo_n(dmgo),         // bus granted output
   .pin_iako_n(iako),         // interrupt vector input
   .pin_sp_n(sp),             // peripheral timer input
   .pin_sel_n(sel),           // register select outputs
   .pin_bsy_n(bsy)            // bus busy flag
);
endmodule

