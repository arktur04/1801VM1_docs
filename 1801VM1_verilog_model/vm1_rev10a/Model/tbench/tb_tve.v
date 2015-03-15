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
module tve();

reg			clk;
reg			ena;
reg			reset;
reg			sp;

reg [15:0]  keep;
reg [15:0]	din;
wire [15:0]	dout;

reg			csr_oe;
reg			cnt_oe;
reg			lim_oe;
reg			csr_wr;
reg			lim_wr;

reg			sp_ena;
reg			sp_capt;
//_____________________________________________________________________________
//
// Clock generator
//
initial
begin
	clk = 0;
	forever 
		begin
			clk = 0;
			#(`SIM_CONFIG_CLOCK_HPERIOD);
			clk = 1;
			#(`SIM_CONFIG_CLOCK_HPERIOD);
		end
end

initial
begin
	sp = 0;
	forever 
		begin
			if (sp_ena)
				sp = 0;
			#(`SIM_CONFIG_CLOCK_HPERIOD*2*5);
			if (sp_ena)
				sp = 1;
			#(`SIM_CONFIG_CLOCK_HPERIOD*2*5);
		end
end

initial
begin
	sp = 0;
	forever 
		begin
			if (sp_capt)
				sp = 0;
			#(`SIM_CONFIG_CLOCK_HPERIOD*2*17);
			if (sp_capt)
				sp = 1;
			#(`SIM_CONFIG_CLOCK_HPERIOD*2*17);
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

	ena 		= 1;
	reset 	= 1;
	sp			= 0;
	din		= 16'h0000;

	csr_oe	= 0;
	cnt_oe	= 0;
	lim_oe	= 0;
	csr_wr	= 0;
	lim_wr 	= 0;

	sp_ena	= 0;
	sp_capt	= 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*5);
	reset 	= 0;
	
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
	write_lim(16'h0005);
	write_csr(16'h0010);


#(`SIM_CONFIG_CLOCK_HPERIOD*2*128*7);
	write_lim(16'h0007);
	write_csr(16'h001C);

#(`SIM_CONFIG_CLOCK_HPERIOD*2*128*7);
	read_csr();
	write_csr(16'h001C);
	
	@ (posedge timer.tve_csr[7]);
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	

	write_lim(16'h0008);
	write_csr(16'h0054);
	@ (posedge timer.tve_csr[7]);
	
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	
	sp_ena = 1;
	write_lim(16'h0008);
	write_csr(16'h0051);
	
#(`SIM_CONFIG_CLOCK_HPERIOD*2*10*50);
	write_csr(16'h0055);
	@ (posedge timer.tve_csr[7]);
	sp_ena = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	reset 	= 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*2*3);
	write_lim(16'h0008);
	write_csr(16'h0016);
	sp_capt = 1;
	@ (posedge timer.tve_csr[7]);
	
	$display("Success completion");
	$stop;
end

task write_csr(input [15:0]  data);
begin
	din = data;
@ (negedge clk);
	csr_wr = 1;
@ (negedge clk);
	csr_wr = 0;
end
endtask

task write_lim(input [15:0]  data);
begin
		din = data;
	@ (negedge clk);
		lim_wr = 1;
	@ (negedge clk);
		lim_wr = 0;
end
endtask

task read_csr();
begin
	@ (negedge clk);
		csr_oe = 1;
	@ (negedge clk);
		keep = dout;
		csr_oe = 0;
end
endtask

task read_lim();
begin
	@ (negedge clk);
		lim_oe = 1;
	@ (negedge clk);
		keep = dout;
		lim_oe = 0;
end		
endtask

task read_cnt();
begin
	@ (negedge clk);
		cnt_oe = 1;
	@ (negedge clk);
		keep = dout;
		cnt_oe = 0;
end		
endtask

//_____________________________________________________________________________
//
vm1_timer timer
(
	.tve_clk(clk),
	.tve_ena(ena),	
	.tve_reset(reset),
	.tve_sp(sp),
	.tve_din(din),
	.tve_dout(dout),
	.tve_csr_oe(csr_oe),
	.tve_cnt_oe(cnt_oe),
	.tve_lim_oe(lim_oe),
	.tve_csr_wr(csr_wr),
	.tve_lim_wr(lim_wr)
);

endmodule

