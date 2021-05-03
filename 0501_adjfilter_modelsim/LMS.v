`include "define2LMS.v"

module LMS
(
input clk,
input rst_n,
input [`SIG_WIDTH-1:0] signal,
input [`NOS_WIDTH-1:0] noise,
output [`DATAOUT_WIDTH-1:0] err
);

parameter ORDER = 80;		//FIR滤波器阶数

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
parameter ADD_RES_WIDTH = `NOS_WIDTH+`W_INT_WIDTH+7;
wire signed [ADD_RES_WIDTH-1:0] padd_temp;
pAdd_80	pAdd_80_inst (
	.data0x ( u0[0].ytmp ),
	.data10x ( u0[1].ytmp ),
	.data11x ( u0[2].ytmp ),
	.data12x ( u0[3].ytmp ),
	.data13x ( u0[4].ytmp ),
	.data14x ( u0[5].ytmp ),
	.data15x ( u0[6].ytmp ),
	.data16x ( u0[7].ytmp ),
	.data17x ( u0[8].ytmp ),
	.data18x ( u0[9].ytmp ),
	.data19x ( u0[10].ytmp ),
	.data1x ( u0[11].ytmp ),
	.data20x ( u0[12].ytmp ),
	.data21x ( u0[13].ytmp ),
	.data22x ( u0[14].ytmp ),
	.data23x ( u0[15].ytmp ),
	.data24x ( u0[16].ytmp ),
	.data25x ( u0[17].ytmp ),
	.data26x ( u0[18].ytmp ),
	.data27x ( u0[19].ytmp ),
	.data28x ( u0[20].ytmp ),
	.data29x ( u0[21].ytmp ),
	.data2x ( u0[22].ytmp ),
	.data30x ( u0[23].ytmp ),
	.data31x ( u0[24].ytmp ),
	.data32x ( u0[25].ytmp ),
	.data33x ( u0[26].ytmp ),
	.data34x ( u0[27].ytmp ),
	.data35x ( u0[28].ytmp ),
	.data36x ( u0[29].ytmp ),
	.data37x ( u0[30].ytmp ),
	.data38x ( u0[31].ytmp ),
	.data39x ( u0[32].ytmp ),
	.data3x ( u0[33].ytmp ),
	.data40x ( u0[34].ytmp ),
	.data41x ( u0[35].ytmp ),
	.data42x ( u0[36].ytmp ),
	.data43x ( u0[37].ytmp ),
	.data44x ( u0[38].ytmp ),
	.data45x ( u0[39].ytmp ),
	.data46x ( u0[40].ytmp ),
	.data47x ( u0[41].ytmp ),
	.data48x ( u0[42].ytmp ),
	.data49x ( u0[43].ytmp ),
	.data4x ( u0[44].ytmp ),
	.data50x ( u0[45].ytmp ),
	.data51x ( u0[46].ytmp ),
	.data52x ( u0[47].ytmp ),
	.data53x ( u0[48].ytmp ),
	.data54x ( u0[49].ytmp ),
	.data55x ( u0[50].ytmp ),
	.data56x ( u0[51].ytmp ),
	.data57x ( u0[52].ytmp ),
	.data58x ( u0[53].ytmp ),
	.data59x ( u0[54].ytmp ),
	.data5x ( u0[55].ytmp ),
	.data60x ( u0[56].ytmp ),
	.data61x ( u0[57].ytmp ),
	.data62x ( u0[58].ytmp ),
	.data63x ( u0[59].ytmp ),
	.data64x ( u0[60].ytmp ),
	.data65x ( u0[61].ytmp ),
	.data66x ( u0[62].ytmp ),
	.data67x ( u0[63].ytmp ),
	.data68x ( u0[64].ytmp ),
	.data69x ( u0[65].ytmp ),
	.data6x ( u0[66].ytmp ),
	.data70x ( u0[67].ytmp ),
	.data71x ( u0[68].ytmp ),
	.data72x ( u0[69].ytmp ),
	.data73x ( u0[70].ytmp ),
	.data74x ( u0[71].ytmp ),
	.data75x ( u0[72].ytmp ),
	.data76x ( u0[73].ytmp ),
	.data77x ( u0[74].ytmp ),
	.data78x ( u0[75].ytmp ),
	.data79x ( u0[76].ytmp ),
	.data7x ( u0[77].ytmp ),
	.data8x ( u0[78].ytmp ),
	.data9x ( u0[79].ytmp ),
	.result ( padd_temp )
	);

ChagBW #(.IN_WIDTH(ADD_RES_WIDTH), .DISCARD_WIDTH(5), .OUT_WIDTH(`DATAOUT_WIDTH))CB
(
	.in(padd_temp) ,	// input [IN_WIDTH-1:0] in_sig
	.out(y) 	// output [OUT_WIDTH-1:0] out_sig
);
	
wire signed [`DATAOUT_WIDTH-1:0] y;
assign err = {{2{signal[`SIG_WIDTH-1]}},signal} - y;		//e(n)=d(n)-y(n)	//11=`SIG_WIDTH-1

endmodule
