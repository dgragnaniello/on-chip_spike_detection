// 3rd level module

module multiplier   (a, b, y);

`include "parameters.txt"

input wire  [DataWidth - 1 : 0] a;
input wire  [DataWidth - 1 : 0] b;
output wire [DataWidth - 1 : 0] y;

wire        [2*DataWidth - 1 : 0] mult;



assign mult = (a) * (b);




//assign y    = mult[12:5];		// for 8 bit signals
//assign y    = mult[15:6];		// for 10 bit signals
assign y    = mult[19:8];		// for 12 bit signals

endmodule