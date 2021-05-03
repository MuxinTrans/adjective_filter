//change a signed data's bit width
//save sign bit , trunct the assigned bits following the sign bit
module ChagBW
( in , out );

parameter  IN_WIDTH = 21;
parameter  DISCARD_WIDTH=0;
parameter  OUT_WIDTH = 20;

input [ IN_WIDTH-1 : 0] in;
output [ OUT_WIDTH-1 : 0] out;

//wire outReg
assign out = { in[IN_WIDTH-1] , in[IN_WIDTH-DISCARD_WIDTH-2 : IN_WIDTH-DISCARD_WIDTH-OUT_WIDTH] };

endmodule 