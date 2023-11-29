// 2nd level module

module Neuron   (clk, rst, cntr, en, d_in, b_in, w_in, n_out);

`include "parameters.txt"

parameter   w_max	= 5;									// if counter more than w_max, weights are zeroed

input wire                                      clk;        // clock
input wire                                      rst;        // reset
input wire                                      en;			// enables the bias addition to the first product. Next products are accumulated
input wire  [4:0]                               cntr;       // counter that chooses weights
input wire  [DataWidth - 1 : 0]                 d_in;       // neuron input data (one input at a time)
input wire  [DataWidth - 1 : 0]                 b_in;       // neuron bias
input wire  [(DataWidth * In_Neurons) - 1 : 0]  w_in;       // neuron weights
output wire [DataWidth - 1 : 0]                 n_out;      // neuron output 

reg         [DataWidth - 1 : 0]                 weight;     // weight
wire		[DataWidth - 1 : 0]                 d_in_new;   // neuron input data turned positive (one input at a time)
wire		[DataWidth - 1 : 0]                 weight_new; // weight data turned positive
wire											s;			// multiplication desired sign
wire        [DataWidth - 1 : 0]                 pr;         // product
wire        [DataWidth - 1 : 0]                 pr_new;		// product turned signed again
wire        [DataWidth - 1 : 0]                 pr_acc;     // accumulated products
//wire        [DataWidth - 1 : 0]                 pr_acc_sat; // accumulated products
reg         [DataWidth - 1 : 0]                 pr_acc_pl;  // accumulated products register
wire        [DataWidth - 1 : 0]                 feedback;	// to be added to current product

always @(cntr)
begin
if(cntr >= w_max)
	weight <=  8'b0;
else
	case(cntr)
		5'b11111 : weight = w_in[31* DataWidth +: DataWidth];
		5'b11110 : weight = w_in[30* DataWidth +: DataWidth];
		5'b11101 : weight = w_in[29* DataWidth +: DataWidth];
		5'b11100 : weight = w_in[28* DataWidth +: DataWidth];
		5'b11011 : weight = w_in[27* DataWidth +: DataWidth];
		5'b11010 : weight = w_in[26* DataWidth +: DataWidth];
		5'b11001 : weight = w_in[25* DataWidth +: DataWidth];
		5'b11000 : weight = w_in[24* DataWidth +: DataWidth];
		5'b10111 : weight = w_in[23* DataWidth +: DataWidth];
		5'b10110 : weight = w_in[22* DataWidth +: DataWidth];
		5'b10101 : weight = w_in[21* DataWidth +: DataWidth];
		5'b10100 : weight = w_in[20* DataWidth +: DataWidth];
		5'b10011 : weight = w_in[19* DataWidth +: DataWidth];
		5'b10010 : weight = w_in[18* DataWidth +: DataWidth];
		5'b10001 : weight = w_in[17* DataWidth +: DataWidth];
		5'b10000 : weight = w_in[16* DataWidth +: DataWidth];
		5'b01111 : weight = w_in[15* DataWidth +: DataWidth];
		5'b01110 : weight = w_in[14* DataWidth +: DataWidth];
		5'b01101 : weight = w_in[13* DataWidth +: DataWidth];
		5'b01100 : weight = w_in[12* DataWidth +: DataWidth];
		5'b01011 : weight = w_in[11* DataWidth +: DataWidth];
		5'b01010 : weight = w_in[10* DataWidth +: DataWidth];
		5'b01001 : weight = w_in[9 * DataWidth +: DataWidth];
		5'b01000 : weight = w_in[8 * DataWidth +: DataWidth];
		5'b00111 : weight = w_in[7 * DataWidth +: DataWidth];
		5'b00110 : weight = w_in[6 * DataWidth +: DataWidth];
		5'b00101 : weight = w_in[5 * DataWidth +: DataWidth];
		5'b00100 : weight = w_in[4 * DataWidth +: DataWidth];
		5'b00011 : weight = w_in[3 * DataWidth +: DataWidth];
		5'b00010 : weight = w_in[2 * DataWidth +: DataWidth];
		5'b00001 : weight = w_in[1 * DataWidth +: DataWidth];
		5'b00000 : weight = w_in[0 * DataWidth +: DataWidth];
	endcase
end

twos_comp_conv inpt_conv (.sign(d_in[DataWidth - 1]),   .x(d_in),   .y(d_in_new)  ); 
twos_comp_conv wght_conv (.sign(weight[DataWidth - 1]), .x(weight), .y(weight_new)); 

multiplier  mult    (.a(d_in_new), .b(weight_new), .y(pr));

//assign  s = d_in[DataWidth - 1] ^ weight[DataWidth - 1];
assign  s = (d_in == {DataWidth {1'b0}} || weight == {DataWidth {1'b0}})?(1'b0):(d_in[DataWidth - 1] ^ weight[DataWidth - 1]);


twos_comp_conv prdt_conv (.sign(s), .x(pr), .y(pr_new)); 

assign  pr_acc		= pr_new + feedback;
//assign  pr_acc_sat = (!pr_new[DataWidth - 1] && !feedback[DataWidth - 1] && pr_acc[DataWidth - 1])?(8'b0111_1111):((pr_new[DataWidth - 1] && feedback[DataWidth - 1] && !pr_acc[DataWidth - 1])?(8'b1000_0000):(pr_acc));

assign  feedback	= (en)?(b_in):(pr_acc_pl);

always @(posedge clk)
begin
    if(rst)
        pr_acc_pl   <=  {DataWidth {1'b0}};
    else
        pr_acc_pl   <=  pr_acc;
//		pr_acc_pl   <=  pr_acc_sat;
end

// activation function
assign n_out = (pr_acc_pl[DataWidth - 1] == 1)?({DataWidth {1'b0}}):(pr_acc_pl);

endmodule