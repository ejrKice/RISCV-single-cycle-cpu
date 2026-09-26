module ALUControl(ALUOp_in, func7, func3, ALUControl_out);

input [1:0] ALUOp_in;
input [6:0] func7;
input [2:0] func3;

output reg [3:0] ALUControl_out;

always@(*)begin
	casex({ALUOp_in, func7, func3}) //R-Type
		12'b00_xxxxxxx_xxx : ALUControl_out = 4'b0010; // lw/sw/addi
		12'b01_xxxxxxx_xxx : ALUControl_out = 4'b0110; // beq - subtract
		12'b10_0000000_000 : ALUControl_out = 4'b0010; // add
		12'b10_0100000_000 : ALUControl_out = 4'b0110; // sub
		12'b10_0000000_111 : ALUControl_out = 4'b0000; // and
		12'b10_0000000_110 : ALUControl_out = 4'b0001; // or
		12'b10_0000000_010 : ALUControl_out = 4'b0111; //slt (adder)
		default : ALUControl_out = 4'b0010;
	endcase

end

endmodule