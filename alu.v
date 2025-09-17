module ALU (
	input signed [9:0] a,
	input signed [9:0] b,
	input [1:0] op,
	output reg signed [19:0] result);
	
	always @(*) begin
		case (op)
			2'b01: result <= a + b;
			2'b10: result <= a - b;
			2'b11: result <= a * b;
			default: result <= 0;
		endcase
	end
endmodule
