// 2nd level module
// n1 -> no spike, n4 -> type1

module MaxFinder   (clk, rst, cntr, d_in, fin_out);

`include "parameters.txt"

input wire  clk;
input wire  rst;
input wire  [(DataWidth * Out_Neurons) - 1 : 0]  d_in;
input wire  [4:0]                       		 cntr;       	// counter that chooses weights
output reg  [1 : 0]             fin_out;

reg     [DataWidth - 1 : 0]     maxValue1;
reg     [DataWidth - 1 : 0]     maxValue2;
reg                             flag1;
reg                             flag2;

wire    [DataWidth - 1 : 0]     mxVal1;
wire    [DataWidth - 1 : 0]     mxVal2;
wire                            f1;
wire                            f2;
wire    [1 : 0]					out;
wire							cg_en;		// clock gate enable
wire ck_gated;
reg q;

assign	mxVal1	= (d_in[((Out_Neurons - 1) * DataWidth) - 1 -: DataWidth] > d_in[((Out_Neurons) * DataWidth) - 1 -: DataWidth])?(d_in[((Out_Neurons - 1) * DataWidth) - 1 -: DataWidth]):(d_in[((Out_Neurons) * DataWidth) - 1 -: DataWidth]);
assign	f1		= (d_in[((Out_Neurons - 1) * DataWidth) - 1 -: DataWidth] > d_in[((Out_Neurons) * DataWidth) - 1 -: DataWidth])?(1'b1):(1'b0);

assign	mxVal2	= (d_in[((Out_Neurons - 3) * DataWidth) - 1 -: DataWidth] > d_in[((Out_Neurons - 2) * DataWidth) - 1 -: DataWidth])?(d_in[((Out_Neurons - 3) * DataWidth) - 1 -: DataWidth]):(d_in[((Out_Neurons - 2) * DataWidth) - 1 -: DataWidth]);
assign	f2		= (d_in[((Out_Neurons - 3) * DataWidth) - 1 -: DataWidth] > d_in[((Out_Neurons - 2) * DataWidth) - 1 -: DataWidth])?(1'b1):(1'b0);

assign	out[1]	= (maxValue1 >= maxValue2)?(1'b0):(1'b1);
assign	out[0]	= (maxValue1 >= maxValue2)?(flag1):(flag2);

assign cg_en	= ((cntr >= 5'b11110) && (cntr <= 5'b11111))?(1'b1):(1'b0);		// two last clock cycles are needed for the comparison
assign ck_gated = clk & q;

always @ (clk)
begin
    if(!clk)
        q <= cg_en;
end

always @(ck_gated)       // check max between output neurons 2 and 1
begin
    maxValue1   <=  mxVal1;        
end

always @(ck_gated)       // check max between output neurons 2 and 1
begin
	flag1		<=  f1;        
end

always @(ck_gated)       // check max between output neurons 4 and 3
begin
    maxValue2   <=  mxVal2;        
end

always @(ck_gated)       // check max between output neurons 4 and 3
begin
    flag2		<=  f2;        
end

always @(ck_gated)       // check max between output neurons 1,2 and 3,4
begin
    fin_out     <=  out;
end

endmodule