module top (
	input clk,
	input rstb,
	input [7:0] a,
	input [7:0] b,
	output done,
	output reg signed [19:0] result
);
	parameter ADD = 3'b001;
	parameter SUB = 3'b010;
	parameter MUL = 3'b100;
	reg [2:0] c_st, n_st;

	wire signed [19:0] alu_out;
	reg signed [19:0] add_out;
	reg signed [19:0] sub_out;
	reg [1:0] op;
	reg signed [9:0] alu_in_a, alu_in_b;
	reg o_add_en, o_sub_en, o_mul_en;

	assign done = o_mul_en;
	always @(posedge clk or negedge rstb) begin
		if (!rstb) begin
			c_st <= ADD;
			add_out <= 0;
			sub_out <= 0;
			result <= 0;
		end else begin
			c_st <= n_st;
			if (o_add_en)
				add_out <= alu_out;
			if (o_sub_en)
				sub_out <= alu_out;
			if (o_mul_en)
				result <= alu_out;
		end
	end

	ALU i_alu (alu_in_a, alu_in_b, op, alu_out);

	always @(*) begin
		o_add_en = 0;
		o_sub_en = 0;
		o_mul_en = 0;
		alu_in_a = {2'b00, a};
		alu_in_b = {2'b00, b};
		case (c_st)
			ADD: begin
					n_st = SUB;
					op = 2'b01;
					o_add_en = 1;
				 end
			SUB: begin
					n_st = MUL;
					op = 2'b10;
					o_sub_en = 1;
				 end
			MUL: begin
					n_st = ADD;
					op = 2'b11;
					o_mul_en = 1;
					alu_in_a = add_out;
					alu_in_b = sub_out;
				 end
		endcase
	end
//	always @(*) begin
//		$monitor("add_out_17 = %d; sub_out_17 = %d; result = %d", add_out_17, sub_out_17, result);
//	end
endmodule
