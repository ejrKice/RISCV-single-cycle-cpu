module Data_Memory(clk, reset, MemWrite, MemRead, Address, Write_data, Read_data);

	input clk, reset, MemWrite, MemRead;
	input [31:0] Address, Write_data;
	output [31:0] Read_data;

	reg[31:0] Dmemory[63:0]; // 64 registers of 32 bits
	
	wire [5:0] word_addr = Address[7:2];


	assign Read_data = MemRead ? Dmemory[word_addr] : 32'h00000000;

	integer k;

	always@(posedge clk)begin
		if(reset)begin
			for(k=0; k<64; k=k+1)
				Dmemory[k] <= 32'h00000000;
		end
		else if(MemWrite)
			Dmemory[word_addr] <= Write_data;
			
	end

endmodule