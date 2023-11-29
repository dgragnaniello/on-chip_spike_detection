// 2nd level module

module ShiftReg   (clk, rst, cntr, en, neurons_out, l_out);

`include "parameters.txt"

parameter   n_num = 32;

input wire                                              clk;            // clock
input wire                                              rst;            // reset
input wire                                              en;           	// enables the passing of RELU
input wire  [4:0]                       		        cntr;       	// counter that chooses weights
input wire  [(DataWidth * n_num) - 1 : 0]         		neurons_out;    // neurons' outputs
output wire	[DataWidth - 1 : 0]                         l_out;          // neuron output 

wire		[(DataWidth * (n_num - 1)) - 1 : 0]			n_out;			// 
reg         [(DataWidth * (n_num - 1)) - 1 : 0]			shift_r_ff;		// 
wire													cg_en;		// clock gate enable

wire ck_gated;
reg q;

assign cg_en	= ((cntr >= 5'b00000) && (cntr < n_num))?(1'b1):(1'b0);
assign n_out	= (en)?(neurons_out[(DataWidth * n_num) - 1 : DataWidth])	: (shift_r_ff >> {DataWidth});
assign l_out	= (en)?(neurons_out[DataWidth - 1 : 0])						: (shift_r_ff[DataWidth - 1 : 0]);

always @ (posedge ck_gated)
begin
/*    if(rst || !cg_en)
        shift_r_ff	<=  {(DataWidth * (n_num - 1)){1'b0}};
    else
		shift_r_ff	<=	n_out;
*/
	shift_r_ff	<=	n_out;
end

assign ck_gated = clk & q;

always @ (clk)
begin
    if(!clk)
        q <= cg_en;
end


endmodule