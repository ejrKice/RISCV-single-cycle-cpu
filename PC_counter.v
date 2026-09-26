module PCplus4(fromPC, NexttoPC);

	input [31:0] fromPC;
	output [31:0] NexttoPC;

	assign NexttoPC = 4 + fromPC; 

endmodule