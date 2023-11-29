// testbench

`timescale 1ns/1ps

module tb_NN();

`include "parameters.txt"

localparam	period	= 1000;

integer							scan_file_in;				//file handler
integer							scan_file_out;				//file handler 

reg		[DataWidth - 1 : 0]		X;							// input
reg		[DataWidth - 1 : 0]		captured_data_X;			// input
reg		[1 : 0]					Y_originalNN;				// input
reg		[1 : 0]					Y_groundTruth;				// input
reg		[1 : 0]					captured_data_Y_originalNN;	// input
reg		[1 : 0]					captured_data_Y_groundTruth;// input
reg								CLK;						// input
reg								RST;						// input

wire	[1 : 0]					NN_OUT;						// output

always
begin
  CLK=1'b0;
  # (period/2);
  CLK=1'b1;
  # (period/2);
end


NN
  UUT(.clk(CLK),
    .rst(RST),
    .data_in(X),
    .NN_out(NN_OUT)
    );




initial
begin
  
  RST = 1'b1;

  # (period/2);
  # (period);
  RST = 1'b0;

  scan_file_in	= $fopen("./input.txt","r");
  scan_file_out	= $fopen("./output.txt","w");	

  while (!$feof(scan_file_in))	
  begin
    
    if ($fscanf(scan_file_in, "%b \t %b \t %b \n", captured_data_X, captured_data_Y_originalNN, captured_data_Y_groundTruth) == -1)
      $display("ERROR: fseek failed");
    X = captured_data_X;
    Y_originalNN = captured_data_Y_originalNN;
    Y_groundTruth = captured_data_Y_groundTruth;
		
		#(period);
		if (UUT.count.en)
			$fwrite(scan_file_out, "%b \t %b \t %b \n", NN_OUT, Y_originalNN, Y_groundTruth);
		

	end

	$fclose(scan_file_in);
	$fclose(scan_file_out);	
	$stop;

end
					
endmodule
