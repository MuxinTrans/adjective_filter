`include "define2LMS.v"
//filter_in/latch_data | err | filter_out | filter_coe 均为有符号数
//递推公式：y(n)=w(n)x(n);	e(n)=d(n)-y(n);【隔壁.v】	w(n+1)=w(n)+2ue(n)x(n);
module LMScircle
(
input clk,
input rst_n,
input signed [`NOS_WIDTH-1:0] filter_in,		//自适应滤波器输入信号~x(n)
input signed [`DATAOUT_WIDTH-1:0] err,			//e(n)=d(n)-y(n)
output reg signed [`NOS_WIDTH-1:0] latch_data,		//锁存输入信号，作为下一次迭代的输入
output signed [`NOS_WIDTH+`W_INT_WIDTH-1:0] filter_out	//自适应滤波输出信号~y(n)=w(n)*x(n)
);

reg signed [`W_WHO_WIDTH-1:0] filter_coe;		//自适应滤波器系数~w(n)~~w(n+1)=w(n)+2ue(n)*x(n)

//信号锁存
always @(posedge clk)
begin
	latch_data <= filter_in;
end

//2ue(n)*x(n)~用来更新filter_coe
//参数设置：令2u=1, 但u实际值为0.5/(2^小数位数)~定点数运算
wire [`DATAOUT_WIDTH+`NOS_WIDTH-1:0] delt_coe;
mult_s_1314	u_en_xn (	// change to 1214
	.dataa ( filter_in ),
	.datab ( err ),
	.result ( delt_coe )
	);
always @(negedge clk)
begin
	filter_coe <= filter_coe + delt_coe;
end

//y(n)=w(n)*x(n)
mult_s_1318	u_wn_xn (	//change to 1218
	.dataa ( filter_in ),
	.datab ( filter_coe[`W_WHO_WIDTH-1:`W_WHO_WIDTH-`W_INT_WIDTH] ),
	.result ( filter_out )
	);


endmodule
