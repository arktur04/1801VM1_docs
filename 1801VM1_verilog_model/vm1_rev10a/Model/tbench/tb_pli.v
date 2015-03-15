//
// Copyright (c) 2014 by 1801BM1@gmail.com
//
// Testbench for the 1801BM1 replica, native QBUS version
//______________________________________________________________________________
//
`include "config.h"

//______________________________________________________________________________
//
// Primary testbench top module
//
module tb1();

reg			clk;
reg [11:4]	psw;
reg			plir;
reg			uerr;
reg			virq;
reg [3:1]	irq;
reg			qbto;
reg			dble;
reg			aclo;
reg			wcpu;
reg			acok;
reg			iato;
wire [10:0]	pli;
wire [19:0]	rq;
wire [2:0]	vstate;

wire			irq2_rearm;
wire			irq3_rearm;
wire			aclo_rearm;
wire			uop_rearm;
wire [15:0]	vect;

assign		irq2_rearm =  pli[10] &  pli[8] & ~pli[6];
assign		irq3_rearm =  pli[10] & ~pli[8] & ~pli[6];
assign		aclo_rearm = ~pli[10] & ~pli[8] &  pli[6];
assign		uop_rearm  = ~pli[10] & ~pli[8] & ~pli[6];
assign 			vstate	  = {pli[5], pli[7], pli[9]};

assign rq[0]	= psw[10];
assign rq[1]	= plir;
assign rq[2]	= psw[11];
assign rq[3]	= uerr;
assign rq[4]	= psw[7];
assign rq[5]	= 1'bx;
assign rq[6]	= 1'bx;
assign rq[7]	= 1'bx;
assign rq[8]	= virq;
assign rq[9]	= qbto;
assign rq[10]	= dble;
assign rq[11]	= aclo;
assign rq[12]	= wcpu;
assign rq[13]	= acok;
assign rq[14]	= irq[1];
assign rq[15]	= psw[4];
assign rq[16]	= irq[2];
assign rq[17]	= iato;
assign rq[18]	= irq[3];
assign rq[19]	= 1'bx;

//_____________________________________________________________________________
//
// Clock generator
//
initial
begin
	clk = 0;
	plir = 0;
	forever 
		begin
			#(`SIM_CONFIG_CLOCK_HPERIOD);
			clk = 0;
			#(`SIM_CONFIG_CLOCK_HPERIOD);
			clk = 1;
			//
			// Process the feedback (rearm and pli4r)
			//
			rearm();
		end
end

//_____________________________________________________________________________
//
// Simulation time limit (first breakpoint)
//
initial
begin
	#`SIM_CONFIG_TIME_LIMIT	$stop;
end

//_____________________________________________________________________________
//
initial
begin
	psw 	= 12'h0;
	irq 	= 3'h0;
	plir	= 0;
	uerr	= 0;
	virq	= 1;
	qbto	= 0;
	dble	= 0;
	aclo 	= 0;
	wcpu	= 0;
	acok	= 0;
	iato	= 0;
	
@ (negedge clk);
	acok  = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("acok(%6O, %d)", vect, vstate);
	
@ (negedge clk);
@ (negedge clk);
//
// check the iato + qbto
//
	wcpu		= 0;
	psw[11] 	= 0;
	psw[10]	= 0;
	psw[7]	= 0;
	qbto     = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("qbto(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	qbto		= 0;
	
@ (negedge clk);
	psw[11] 	= 1;
	qbto     = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("qbto(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	qbto		= 0;
	
@ (negedge clk);
	psw[11] 	= 0;
	psw[10] 	= 1;
	qbto     = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("qbto(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	qbto		= 0;
	
@ (negedge clk);
	psw[11] 	= 1;
	qbto     = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("qbto(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	qbto		= 0;
@ (negedge clk);
	psw[11] 	= 0;
	psw[10] 	= 0;

@ (negedge clk);
	uerr	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("uerr(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	uerr	= 0;
	
@ (negedge clk);
	psw[4]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("psw4(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	psw[4]	= 0;

@ (negedge clk);
	acok		= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("acok(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	acok		= 0;

@ (negedge clk);
	aclo		= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("aclo(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	aclo		= 0;

@ (negedge clk);
	irq[1]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq1(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[1]	= 0;

@ (negedge clk);
	irq[2]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq2(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[2]	= 0;

@ (negedge clk);
	irq[3]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq3(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[3]	= 0;
	
@ (negedge clk);
	virq  = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("virq(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	virq  = 1;
@ (negedge clk);
	psw[7] = 1;
@ (negedge clk);
	virq  = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("virq(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	virq  = 1;
@ (negedge clk);
	psw[7] = 0;

	psw[7] = 0;
	wcpu   = 1;
	$display("wait mode active (wakeup test)");
@ (negedge clk);
	irq[1]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq1(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[1]	= 0;

@ (negedge clk);
	irq[2]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq2(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[2]	= 0;

@ (negedge clk);
	irq[3]	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("irq3(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	irq[3]	= 0;
	
@ (negedge clk);
	virq  = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD/2);
	$display("virq(%6O, %d) (psw[11]=%d, psw[10]=%d, psw[7]=%d, psw[4]=%d)", vect, vstate, psw[11], psw[10], psw[7], psw[4]);
@ (negedge clk);
	virq  = 1;
@ (negedge clk);
	
	
@ (negedge clk);
@ (negedge clk);
@ (negedge clk);
@ (negedge clk);
@ (negedge clk);
@ (negedge clk);

$display("Success completion");
$stop;
	
/*	
reg [11:10:7:4]	psw;
reg					uerr;
reg					virq;
reg [3:1]			irq;
reg					qbto;
reg					dble;
reg			aclo;
reg			wcpu;
reg			acok;
reg			iato;
*/	
end

task rearm();
begin
	plir = pli[4];
	if (irq2_rearm)
	begin
		$display("rearm irq2");
		irq[2] = 0;
	end
	if (irq3_rearm)
	begin
		$display("rearm irq3");
		irq[3] = 0;
	end
	if (aclo_rearm) 
	begin
		$display("rearm aclo");
		aclo = 0;
		acok = 0;
	end
	if (uop_rearm)
		begin
			$display("rearm uerr");
			uerr = 0;
		end
end		
endtask

//_____________________________________________________________________________
//
vm1_pli	mpli
(
	.rq(rq),
	.ena(1'b1),
	.sp(pli)
);

vm1_vgen	tvgen
(
	.ireg(16'o123456),
	.svec(16'o067123),
	.vsel({pli[3], ~pli[2], pli[1], pli[0]}),
	.csel(4'b0000),
	.vena(1'b1),
	.cena(1'b0),
	.carry(1'b0),
	.pa(2'b00),
	.value(vect)
);

endmodule

