// Top Level

module NN   (clk, rst, data_in, NN_out);

`include "parameters.txt"

input wire                          				clk;			// clock
input wire                          				rst;			// reset
input wire  [DataWidth - 1 : 0]     				data_in;		// 1 8-bit input at a time 
output wire [1 : 0]                 				NN_out;			// 2 bits indicating type of spike if there is one

wire		[4 : 0]                 				counter;		// chooses the correct weights
wire                                				enable;			// enables bias addition
reg			[DataWidth - 1 : 0]     				d_in_pl;		// delayed input

wire        [(DataWidth * L1_Neurons) - 1 : 0]      n_out_1;        // layer 1 output
wire        [(DataWidth * L2_Neurons) - 1 : 0]      n_out_2;        // layer 2 output
wire        [(DataWidth * Out_Neurons)- 1 : 0]      n_out_3;        // layer 3 output

wire        [DataWidth - 1 : 0]                     l2_in;          // layer 2 input
wire        [DataWidth - 1 : 0]                     l3_in;          // layer 3 input


////////////////////////////////   INPUT REG   ////////////////////////////////
always @(posedge clk)
begin
    if(rst)
        d_in_pl   <=  {DataWidth {1'b0}};
    else
        d_in_pl   <=  data_in;
end

////////////////////////////////    COUNTER    ////////////////////////////////
counter		#(.logNrns(5))	count	(.clk(clk), .rst(rst), .cntr(counter), .en(enable));

////////////////////////////////    LAYER 1    ////////////////////////////////
Neuron		#(.w_max(32))	nl1_1	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N1 [(DataWidth-1):0]), .w_in(WnB_L1_N1 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 0 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_2	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N2 [(DataWidth-1):0]), .w_in(WnB_L1_N2 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 1 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_3	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N3 [(DataWidth-1):0]), .w_in(WnB_L1_N3 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 2 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_4	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N4 [(DataWidth-1):0]), .w_in(WnB_L1_N4 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 3 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_5	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N5 [(DataWidth-1):0]), .w_in(WnB_L1_N5 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 4 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_6	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N6 [(DataWidth-1):0]), .w_in(WnB_L1_N6 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 5 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_7	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N7 [(DataWidth-1):0]), .w_in(WnB_L1_N7 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 6 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_8	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N8 [(DataWidth-1):0]), .w_in(WnB_L1_N8 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 7 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_9	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N9 [(DataWidth-1):0]), .w_in(WnB_L1_N9 [(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 8 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_10	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N10[(DataWidth-1):0]), .w_in(WnB_L1_N10[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 9 ) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_11	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N11[(DataWidth-1):0]), .w_in(WnB_L1_N11[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 10) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_12	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N12[(DataWidth-1):0]), .w_in(WnB_L1_N12[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 11) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_13	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N13[(DataWidth-1):0]), .w_in(WnB_L1_N13[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 12) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_14	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N14[(DataWidth-1):0]), .w_in(WnB_L1_N14[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 13) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_15	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N15[(DataWidth-1):0]), .w_in(WnB_L1_N15[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 14) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_16	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N16[(DataWidth-1):0]), .w_in(WnB_L1_N16[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 15) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_17	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N17[(DataWidth-1):0]), .w_in(WnB_L1_N17[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 16) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_18	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N18[(DataWidth-1):0]), .w_in(WnB_L1_N18[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 17) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_19	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N19[(DataWidth-1):0]), .w_in(WnB_L1_N19[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 18) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_20	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N20[(DataWidth-1):0]), .w_in(WnB_L1_N20[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 19) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_21	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N21[(DataWidth-1):0]), .w_in(WnB_L1_N21[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 20) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_22	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N22[(DataWidth-1):0]), .w_in(WnB_L1_N22[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 21) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_23	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N23[(DataWidth-1):0]), .w_in(WnB_L1_N23[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 22) - 1 -: DataWidth]));
Neuron		#(.w_max(32))	nl1_24	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(d_in_pl), .b_in(WnB_L1_N24[(DataWidth-1):0]), .w_in(WnB_L1_N24[(DataWidth * (In_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_1[DataWidth * (L1_Neurons - 23) - 1 -: DataWidth]));

////////////////////////////////    L1<=>L2    ////////////////////////////////
ShiftReg	#(.n_num(24))	SR1		(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .neurons_out(n_out_1), .l_out(l2_in));

////////////////////////////////    LAYER 2    ////////////////////////////////
Neuron		#(.w_max(24))	nl2_1	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N1 [(DataWidth - 1):0]), .w_in(WnB_L2_N1 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 0 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_2	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N2 [(DataWidth - 1):0]), .w_in(WnB_L2_N2 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 1 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_3	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N3 [(DataWidth - 1):0]), .w_in(WnB_L2_N3 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 2 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_4	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N4 [(DataWidth - 1):0]), .w_in(WnB_L2_N4 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 3 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_5	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N5 [(DataWidth - 1):0]), .w_in(WnB_L2_N5 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 4 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_6	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N6 [(DataWidth - 1):0]), .w_in(WnB_L2_N6 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 5 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_7	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N7 [(DataWidth - 1):0]), .w_in(WnB_L2_N7 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 6 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_8	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N8 [(DataWidth - 1):0]), .w_in(WnB_L2_N8 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 7 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_9	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N9 [(DataWidth - 1):0]), .w_in(WnB_L2_N9 [(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 8 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_10	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N10[(DataWidth - 1):0]), .w_in(WnB_L2_N10[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 9 ) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_11	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N11[(DataWidth - 1):0]), .w_in(WnB_L2_N11[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 10) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_12	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N12[(DataWidth - 1):0]), .w_in(WnB_L2_N12[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 11) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_13	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N13[(DataWidth - 1):0]), .w_in(WnB_L2_N13[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 12) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_14	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N14[(DataWidth - 1):0]), .w_in(WnB_L2_N14[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 13) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_15	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N15[(DataWidth - 1):0]), .w_in(WnB_L2_N15[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 14) - 1 -: DataWidth]));
Neuron		#(.w_max(24))	nl2_16	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l2_in), .b_in(WnB_L2_N16[(DataWidth - 1):0]), .w_in(WnB_L2_N16[(DataWidth * (L1_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_2[DataWidth * (L2_Neurons - 15) - 1 -: DataWidth]));

////////////////////////////////    L2<=>L3    ////////////////////////////////
ShiftReg	#(.n_num(16))	SR2		(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .neurons_out(n_out_2), .l_out(l3_in));

////////////////////////////////    LAYER 3    ////////////////////////////////
Neuron		#(.w_max(16))	nl3_1	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l3_in), .b_in(WnB_L3_N1 [(DataWidth - 1):0]), .w_in(WnB_L3_N1 [(DataWidth * (L2_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_3[DataWidth * (Out_Neurons- 0 ) - 1 -: DataWidth]));
Neuron		#(.w_max(16))	nl3_2	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l3_in), .b_in(WnB_L3_N2 [(DataWidth - 1):0]), .w_in(WnB_L3_N2 [(DataWidth * (L2_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_3[DataWidth * (Out_Neurons- 1 ) - 1 -: DataWidth]));
Neuron		#(.w_max(16))	nl3_3	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l3_in), .b_in(WnB_L3_N3 [(DataWidth - 1):0]), .w_in(WnB_L3_N3 [(DataWidth * (L2_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_3[DataWidth * (Out_Neurons- 2 ) - 1 -: DataWidth]));
Neuron		#(.w_max(16))	nl3_4	(.clk(clk), .rst(rst), .cntr(counter), .en(enable), .d_in(l3_in), .b_in(WnB_L3_N4 [(DataWidth - 1):0]), .w_in(WnB_L3_N4 [(DataWidth * (L2_Neurons + 1)) - 1 : DataWidth]), .n_out(n_out_3[DataWidth * (Out_Neurons- 3 ) - 1 -: DataWidth]));

////////////////////////////////    HARDMAX    ////////////////////////////////
MaxFinder					HM3		(.clk(clk), .rst(rst), .cntr(counter), .d_in(n_out_3), .fin_out(NN_out));

endmodule