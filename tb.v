`timescale 1ns/10ps
module tb;
	reg [7:0] in_a, in_b;
	wire signed [19:0] out_res;
	reg clk, rstb;
	wire done;
	
	top dut(
		clk, rstb, in_a, in_b, done, out_res
	);

	initial begin
		clk = 0;
		forever
			#(`PERIOD/2) clk = ~clk;
	end
	
	initial begin
		in_a = 0;
		in_b = 0;
		rstb = 0;
		@(posedge clk);
		rstb = 1;
		while (!done)
			@(negedge clk);
		@(posedge clk);
		for (integer i=0; i<256; i=i+1) begin
			//@(posedge clk);
			in_a = $random % 256;
			in_b = $random % 256;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(negedge clk) $display("in_a = %d; in_b = %d; expected = %d; actual = %d;", in_a, in_b, int'((in_a+in_b)*(in_a-in_b)), out_res);
		end
		$finish();
	end
endmodule
