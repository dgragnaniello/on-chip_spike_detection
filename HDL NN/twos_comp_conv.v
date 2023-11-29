// 3rd level module

module twos_comp_conv   (sign, x, y);

`include "parameters.txt"

input wire						sign;	// sign
input wire	[DataWidth - 1 : 0]	x;		// neuron output 
output wire	[DataWidth - 1 : 0]	y;		// neuron output 

assign y = (sign)?(~x + 1'b1):(x);

endmodule