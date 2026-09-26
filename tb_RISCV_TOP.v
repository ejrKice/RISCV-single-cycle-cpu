`timescale 1ns/1ps

module tb_RISCV_TOP;


	reg clk = 0;
	reg reset = 1;
	integer errors = 0;

	RISCV_TOP dut (.clk(clk), .reset(reset));

	always #5 clk = ~clk;



	always@(posedge clk)
		if(!reset)
			$display("PC=0x%08h, instr=0x%08h, ALU_result=0x%08h", dut.PC_current, dut.instruction, dut.ALU_result);


	task check(input [4:0] r, input [31:0] expected);
		begin
			if (dut.RF.Registers[r] === expected)
				$display("PASS x%0d = 0x%08h", r, dut.RF.Registers[r]);
			else begin
				$display("Fail  x%0d = 0x%08h  (expected 0x%08h)", r, dut.RF.Registers[r], expected);
				errors = errors + 1;
			end
		end
	endtask


	initial begin
		#20 reset = 0;
		
		dut.RF.Registers[1] = 32'd5;
		dut.RF.Registers[2] = 32'd3;

		#80;
	

		check(3, 32'd8);  // add x3 x1 x2      8 in register 3
		check(4, 32'd2);  // subtract x4 x1 x2  2 in register 4
        	check(5, 32'd1);  // and x5 x1 x2     0101 & 0011 == 0001 (1)
        	check(6, 32'd7); // or x6 x1 x2      0101 | 0011 == 0111 (7) 
        	check(7, 32'd1);  // slt x7 x2 x1   3 < 5 true 1
        	check(8, 32'd0);  // slt x8 x1 x2    5 < 3  false 0
        	check(9, 32'hFFFFFFFE);  // sub x9 x2 x1  -2 hex (FFFFFFFE)
        	check(10, 32'd1);     // slt  x10 x9 x1  -2 < 5 (signed)
       		check(0, 32'd0);   // checking that register 0 stayed 0

		if (errors == 0) $display("ALL TESTS PASSED");
		else $display("%0d TESTS FAILED", errors);

		$finish;

	end



endmodule