module Instruction_memory(read_address, instruction_out);

	input [31:0] read_address;

	output [31:0] instruction_out;

//memory

	reg [31:0] memory [63:0]; // 64 registers with 32bits
	wire [5:0] word_addr = read_address[7:2];

	assign instruction_out = memory[word_addr]; // pull from memory address and give to instruction


	initial begin	
		$readmemh("program.mem", memory);
	end

endmodule