module ALU (
	input clk,
	input [7:0] a,
	input [7:0] b,
	input [1:0] op,
	output reg signed [16:0] result);
	reg [7:0] reg_a, reg_b;
	reg [1:0] reg_op;
	
	always @(posedge clk) begin
		reg_a <= a;
		reg_b <= b;
		reg_op <= op;
	end
	
	always @(*) begin
		case (reg_op)
			2'b01: result <= reg_a + reg_b;
			2'b10: result <= reg_a - reg_b;
			2'b11: result <= reg_a * reg_b;
			default: result <= 0;
		endcase
	end
endmodule