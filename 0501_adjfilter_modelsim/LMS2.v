`include "define2LMS.v"

module LMS2
(
input clk,
input rst_n,
input [`SIG_WIDTH-1:0] signal,
input [`NOS_WIDTH-1:0] noise,
output [`DATAOUT_WIDTH-1:0] err
);

parameter ORDER = 8;		//FIR滤波器阶数

//wire signed [`NOS_WIDTH-1:0] latch_data;
//wire signed [`NOS_WIDTH+`W_INT_WIDTH-1:0] ytmp;

genvar i;
generate 
	for( i = 0; i < ORDER; i=i+1) begin :  u0
		wire signed [`NOS_WIDTH-1:0] latch_data;
		wire signed [`NOS_WIDTH+`W_INT_WIDTH-1:0] ytmp;
		if(i==0)
		begin
		LMScircle LMScircle_inst
		(
			.clk(clk) ,				// input  clk_sig
			.rst_n(rst_n) ,		// input  rst_n_sig
			.filter_in(noise) ,	// input [11:0] filter_in_sig
			.err(err) ,				// input [13:0] err_sig
			.latch_data(latch_data) ,	// output [11:0] latch_data_sig
			.filter_out(ytmp) 		// output [29:0] filter_out_sig
		);
		end
		else
		begin
		LMScircle LMScircle_inst
		(
			.clk(clk) ,				// input  clk_sig
			.rst_n(rst_n) ,		// input  rst_n_sig
			.filter_in(u0[i-1].latch_data) ,	// input [11:0] filter_in_sig
			.err(err) ,				// input [13:0] err_sig
			.latch_data(latch_data) ,	// output [11:0] latch_data_sig
			.filter_out(ytmp) 		// output [29:0] filter_out_sig
		);
		end
	end
endgenerate 

//e(n)=d(n)-y(n)	y(n)=sum(ytmp[...])
parameter ADD_RES_WIDTH = `NOS_WIDTH+`W_INT_WIDTH+3;
wire signed [ADD_RES_WIDTH-1:0] padd_temp;
padd_8	padd_8_inst (
	.data0x ( u0[0].ytmp ),
	.data1x ( u0[1].ytmp ),
	.data2x ( u0[2].ytmp ),
	.data3x ( u0[3].ytmp ),
	.data4x ( u0[4].ytmp ),
	.data5x ( u0[5].ytmp ),
	.data6x ( u0[6].ytmp ),
	.data7x ( u0[7].ytmp ),
	.result ( padd_temp )
	);

ChagBW #(.IN_WIDTH(ADD_RES_WIDTH), .DISCARD_WIDTH(5), .OUT_WIDTH(`DATAOUT_WIDTH))CB
(
	.in(padd_temp) ,	// input [IN_WIDTH-1:0] in_sig
	.out(y) 	// output [OUT_WIDTH-1:0] out_sig
);
	
wire signed [`DATAOUT_WIDTH-1:0] y;
assign err = {{signal[`SIG_WIDTH-1]},signal} - y;		//e(n)=d(n)-y(n)

endmodule
