// 2nd level module

module counter   (clk, rst, en, cntr);

parameter   logNrns = 5;				// number of bits needed to represent input neurons [ ceil(log(32)) = 5 ]

input wire						clk;	// clock
input wire          			rst;	// reset
output reg  [logNrns - 1:0]		cntr;	// helps choose weights
output wire         			en;		// enables the bias addition

always @(posedge clk)
begin
    if(rst)
        cntr    <=  {logNrns{1'b1}};
    else
        cntr    <=  cntr + 1'b1;
end

assign en	= !(cntr);			// en goes high when the counter is zeroed.

endmodule