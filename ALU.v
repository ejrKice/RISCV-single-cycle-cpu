module ALU(a, b , zero, ALUControl_in, ALU_result);

	input [31:0] a,b;
	input [3:0] ALUControl_in;

	output reg [31:0] ALU_result;
	output reg zero;

	always@(*) begin
		case(ALUControl_in)
		4'b0000 : ALU_result = a & b; 
		4'b0001 : ALU_result = a | b; 
		4'b0010 : ALU_result = a + b; 
		4'b0110 : ALU_result = a - b; 
		4'b0111 : ALU_result = ($signed(a) < $signed(b)) ? 32'h00000001 : 32'h00000000;
		default : ALU_result = 32'h00000000;
		endcase
		
		zero = (ALU_result == 32'h00000000);
	end

endmodule