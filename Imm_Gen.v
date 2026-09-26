module Imm_Gen(instr, ImmSrc, imm_out);

	input [31:0] instr; //instruction [31:20]
	input [1:0] ImmSrc;
	output reg [31:0] imm_out;

//assign first bit of immediate to [31:12] immediate_out then place immediate onto [11:0] immediate_out  

	always@(*) begin
		case(ImmSrc)
			2'b00 : imm_out = {{20{instr[31]}}, instr[31:20]};  // I-type instructions  addi, lw
			2'b01 : imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};  //s-type
			2'b10 : imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};  // B-type
			default : imm_out = 32'h00000000;
		endcase
	end

endmodule