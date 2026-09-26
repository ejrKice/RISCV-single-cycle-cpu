module Control_unit(OPcode, branch, MemRead, MemtoReg, MemWrite, ALUScr, RegWrite, ALUOp_out);

	input [6:0] OPcode;

	output reg branch, MemRead, MemtoReg, MemWrite, ALUScr, RegWrite;
	output reg [1:0] ALUOp_out;		

	always@(*)begin

		branch = 1'b0;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		MemWrite = 1'b0;
		ALUScr = 1'b0;
		RegWrite = 1'b0;
		ALUOp_out = 2'b00;
		
		case(OPcode) // R-Type instruction
			7'b0110011 : begin
				RegWrite = 1'b1;
				ALUOp_out = 2'b10;
			end
			 
		endcase
	end


endmodule


// repeat the same/similar later to add more instruction sets
		
		