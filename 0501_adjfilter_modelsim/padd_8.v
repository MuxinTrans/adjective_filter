// megafunction wizard: %PARALLEL_ADD%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: parallel_add 

// ============================================================
// File Name: padd_8.v
// Megafunction Name(s):
// 			parallel_add
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.0.0 Build 595 04/25/2017 SJ Standard Edition
// ************************************************************


//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel MegaCore Function License Agreement, or other 
//applicable license agreement, including, without limitation, 
//that your use is for the sole purpose of programming logic 
//devices manufactured by Intel and sold by Intel or its 
//authorized distributors.  Please refer to the applicable 
//agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module padd_8 (
	data0x,
	data1x,
	data2x,
	data3x,
	data4x,
	data5x,
	data6x,
	data7x,
	result);

	input	[29:0]  data0x;
	input	[29:0]  data1x;
	input	[29:0]  data2x;
	input	[29:0]  data3x;
	input	[29:0]  data4x;
	input	[29:0]  data5x;
	input	[29:0]  data6x;
	input	[29:0]  data7x;
	output	[32:0]  result;

	wire [32:0] sub_wire9;
	wire [29:0] sub_wire8 = data7x[29:0];
	wire [29:0] sub_wire7 = data6x[29:0];
	wire [29:0] sub_wire6 = data5x[29:0];
	wire [29:0] sub_wire5 = data4x[29:0];
	wire [29:0] sub_wire4 = data3x[29:0];
	wire [29:0] sub_wire3 = data2x[29:0];
	wire [29:0] sub_wire2 = data1x[29:0];
	wire [29:0] sub_wire0 = data0x[29:0];
	wire [239:0] sub_wire1 = {sub_wire8, sub_wire7, sub_wire6, sub_wire5, sub_wire4, sub_wire3, sub_wire2, sub_wire0};
	wire [32:0] result = sub_wire9[32:0];

	parallel_add	parallel_add_component (
				.data (sub_wire1),
				.result (sub_wire9)
				// synopsys translate_off
				,
				.aclr (),
				.clken (),
				.clock ()
				// synopsys translate_on
				);
	defparam
		parallel_add_component.msw_subtract = "NO",
		parallel_add_component.pipeline = 0,
		parallel_add_component.representation = "UNSIGNED",
		parallel_add_component.result_alignment = "LSB",
		parallel_add_component.shift = 0,
		parallel_add_component.size = 8,
		parallel_add_component.width = 30,
		parallel_add_component.widthr = 33;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: MSW_SUBTRACT STRING "NO"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "0"
// Retrieval info: CONSTANT: REPRESENTATION STRING "UNSIGNED"
// Retrieval info: CONSTANT: RESULT_ALIGNMENT STRING "LSB"
// Retrieval info: CONSTANT: SHIFT NUMERIC "0"
// Retrieval info: CONSTANT: SIZE NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH NUMERIC "30"
// Retrieval info: CONSTANT: WIDTHR NUMERIC "33"
// Retrieval info: USED_PORT: data0x 0 0 30 0 INPUT NODEFVAL "data0x[29..0]"
// Retrieval info: USED_PORT: data1x 0 0 30 0 INPUT NODEFVAL "data1x[29..0]"
// Retrieval info: USED_PORT: data2x 0 0 30 0 INPUT NODEFVAL "data2x[29..0]"
// Retrieval info: USED_PORT: data3x 0 0 30 0 INPUT NODEFVAL "data3x[29..0]"
// Retrieval info: USED_PORT: data4x 0 0 30 0 INPUT NODEFVAL "data4x[29..0]"
// Retrieval info: USED_PORT: data5x 0 0 30 0 INPUT NODEFVAL "data5x[29..0]"
// Retrieval info: USED_PORT: data6x 0 0 30 0 INPUT NODEFVAL "data6x[29..0]"
// Retrieval info: USED_PORT: data7x 0 0 30 0 INPUT NODEFVAL "data7x[29..0]"
// Retrieval info: USED_PORT: result 0 0 33 0 OUTPUT NODEFVAL "result[32..0]"
// Retrieval info: CONNECT: @data 0 0 30 0 data0x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 30 data1x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 60 data2x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 90 data3x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 120 data4x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 150 data5x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 180 data6x 0 0 30 0
// Retrieval info: CONNECT: @data 0 0 30 210 data7x 0 0 30 0
// Retrieval info: CONNECT: result 0 0 33 0 @result 0 0 33 0
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL padd_8_bb.v FALSE
// Retrieval info: LIB_FILE: altera_mf