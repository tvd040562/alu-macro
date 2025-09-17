module top (
	input [7:0] a,
	input [7:0] b,
	output signed [19:0] result
);
	wire signed [19:0] add_out_17, sub_out_17;
	wire signed [9:0] add_out;
	wire signed [9:0] sub_out;

	assign add_out = add_out_17;
	assign sub_out = sub_out_17;

	ALU i1 ({2'b00, a}, {2'b00, b}, 2'b01, add_out_17);
	ALU i2 ({2'b00, a}, {2'b00, b}, 2'b10, sub_out_17);
	ALU i3 (add_out, sub_out, 2'b11, result);
	always @(*) begin
		$monitor("add_out_17 = %d; sub_out_17 = %d; result = %d", add_out_17, sub_out_17, result);
	end
endmodule
