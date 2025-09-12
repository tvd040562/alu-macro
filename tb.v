`timescale 1ns/10ps
module tb;
	reg [7:0] in_a, in_b;
	reg [1:0] in_op;
	wire signed [16:0] out_res;
	reg clk;
	
	ALU dut(
		in_a, in_b, in_op, out_res
	);

	initial begin
		clk = 0;
		forever
			#(`PERIOD/2) clk = ~clk;
	end
	
	initial begin
		in_a = 0;
		in_b = 0;
		in_op = 0;
		for (integer i=0; i<256; i=i+1) begin
			@(posedge clk);
			in_a = $random % 256;
			in_b = $random % 256;
			in_op = $random % 4;
			@(negedge clk) $display("in_op = %d; in_a = %d; in_b = %d; out_res = %d;", in_op, in_a, in_b, out_res);
		end
		$finish();
	end
endmodule