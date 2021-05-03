`include "define2LMS.V"
module adjusted_filter
 (
	input 			CLK_50M,					
	input				CLK_IN,	      
	output 			CLK_OUT,
	input 			RST_N,	      

	output [3:0]	LED, 
	
	inout [15:0]	GPIO_PA,     
	inout [15:0]	GPIO_PB,
	inout [15:0]	GPIO_PC,
	inout [15:0]	GPIO_PD,
	inout [15:0]	GPIO_PE,
	inout [15:0]	GPIO_PF
);
	assign LED = 4'b0;
	
	////////////////////////////////PLL//////////////////////////////////////////////////////
	
	wire CLK_100M;
	wire CLK_20M;
	wire CLK_10M;
	wire CLK_1M;
	wire CLK_10k;
	
	pll_1	pll_1_inst (
		.inclk0 ( CLK_50M ),
		.c0 ( CLK_100M ),
		.c1 ( CLK_20M ),
		.c2 ( CLK_10M ),
		.c3 ( CLK_1M ),
		.c4 ( CLK_10k )
	);

	////////////////////////////////LMS//////////////////////////////////////////////////////	
	
	wire [`NOS_WIDTH-1:0] noise_in;
	wire [`NOS_WIDTH-1:0] s_noise_in;
	wire [`SIG_WIDTH-1:0] sig_in;
	wire [`SIG_WIDTH-1:0] s_sig_in;
	wire signed [`DATAOUT_WIDTH:0] s_err_out;
	
//	assign s_sig_in = sig_in + 12'd2048;
//	assign s_noise_in = noise_in + 12'd2048;

	LMS LMS_inst
	(
		.clk(ADC_CLK) ,	// input  clk_sig
		.rst_n(RST_N) ,	// input  rst_n_sig
		.signal(s_sig_in) ,	// input [11:0] signal_sig
		.noise(s_noise_in) ,	// input [11:0] noise_sig
		.err(s_err_out) 	// output [13:0] err_sig
	);

	///////////////////////////////AD&&DA///////////////////////////////////////////////////

	wire ADC_CLK;
	wire DAC_CLK;
	wire [13:0] dac_out;	
	wire [13:0] dac_out_tmp;
	wire [11:0] addata1;			//noise~x[n]
	wire [11:0] addata2;			//noise+signal~d[n]
	
	assign addata2[11:0] = GPIO_PB[15:4];
	assign addata1[11:0] = GPIO_PD[13:2];
	assign GPIO_PF[14:1] = dac_out;
	assign CLK_OUT = ADC_CLK;
	
//	assign dac_out_tmp = s_err_out + 14'd8192;
//	assign dac_out = {dac_out_tmp[12:0],1'b0};
	assign dac_out = s_err_out + 14'd8192;
	
	ADS805 u1_noise
	(
		.CLK_SAMPLE(CLK_10M) ,	// input  CLK_SAMPLE_sig
		.data_in(addata1) ,		// input [11:0] data_in_sig
		.ADC_CLK(ADC_CLK) ,		// output  ADC_CLK_sig
		.s_data_out(s_noise_in) ,	// output [11:0] s_data_out_sig
		.data_out(noise_in) 		// output [11:0] data_out_sig
	);
	
	ADS805 u2_signal
	(
		.CLK_SAMPLE(CLK_10M) ,	// input  CLK_SAMPLE_sig
		.data_in(addata2) ,		// input [11:0] data_in_sig
		.ADC_CLK() ,				// output  ADC_CLK_sig
		.s_data_out(s_sig_in) ,	// output [11:0] s_data_out_sig
		.data_out(sig_in) 		// output [11:0] data_out_sig
	);



endmodule
