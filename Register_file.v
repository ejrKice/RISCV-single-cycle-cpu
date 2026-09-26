module Register_file(clk, reset, rr1, rr2, wr, wdata, regWrite, rd1, rd2);

	input clk, reset, regWrite; 

	input [4:0] rr1, rr2, wr; // 5 bit 
	input [31:0] wdata; //32bit

	output [31:0] rd1, rd2; // 32bit out

	reg [31:0] Registers [31:0]; //32 registers with 32bits

	assign rd1 = Registers [rr1];
	assign rd2 = Registers [rr2];  

	integer k;

	always@(posedge clk)begin
		if(reset)begin
			for(k = 0; k<32; k = k+1)
				Registers[k] <= 32'h00000000;
		end
		else if(regWrite && wr != 5'd0)
			Registers[wr] <= wdata;
	end

endmodule
	

