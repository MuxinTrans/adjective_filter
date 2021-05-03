module ADS805
(
	input CLK_SAMPLE,
	input [11:0] data_in,	
	output ADC_CLK,			//将ADC_CLK作为DAC的输入
	output signed [11:0] s_data_out,
	output [11:0] data_out
);

reg [11:0] adc_in;
reg [11:0] adc_delay1;
reg [11:0] adc_delay2;

always @(posedge CLK_SAMPLE)
begin
	adc_delay1 <= data_in;
	adc_delay2 <= adc_delay1;
	adc_in <= adc_delay2;
end

assign data_out = adc_in;
assign s_data_out = data_out + 12'd2048;
assign ADC_CLK= (!CLK_SAMPLE);

endmodule