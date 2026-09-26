module Program_Counter(clk, reset, PC_in, PC_out);

	input clk, reset;
	input [31:0] PC_in; //32bits 

	output reg [31:0] PC_out; 


	always@(posedge clk) begin
		if (reset)
			PC_out <= 32'h00000000;
		else 
			PC_out <= PC_in;
	end

endmodule