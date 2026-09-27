`default_nettype none

module RISCV_TOP(clk, reset);
	
	input wire clk, reset;

	wire [31:0] PC_current, PC_next, instruction;
	wire [31:0] read_data1, read_data2, ALU_result, Read_data_mem;
	wire [3:0] ALUControl;
	wire [1:0] ALUOp;
	wire branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, zero;
	wire [31:0] imm_out, ALU_b;
	wire [1:0] ImmSrc;
	wire [31:0] WriteBack;


	Program_Counter PC_reg (
		.clk(clk), 
		.reset(reset), 
		.PC_in(PC_next), 
		.PC_out(PC_current)
	);

	PCplus4 PC_incr(
		.fromPC(PC_current),
		.NexttoPC(PC_next)
	);

	Instruction_memory IMEM(
		.read_address(PC_current), 
		.instruction_out(instruction)
	);

	Control_unit Control_unit(
		.OPcode(instruction[6:0]), 
		.branch(branch), 
		.MemRead(MemRead), 
		.MemtoReg(MemtoReg), 
		.MemWrite(MemWrite), 
		.ALUScr(ALUSrc), 
		.RegWrite(RegWrite), 
		.ALUOp_out(ALUOp),
		.ImmSrc(ImmSrc)
	);
	
	Imm_Gen IMMGEN(
	   .instr(instruction),
	   .ImmSrc(ImmSrc),
	   .imm_out(imm_out)
	);
	
	assign ALU_b = ALUSrc ? imm_out : read_data2;



	Register_file RF (
		.clk(clk), 
		.reset(reset),
		.rr1(instruction[19:15]), 
		.rr2(instruction[24:20]), 
		.wr(instruction[11:7]), 
		.wdata(WriteBack), 
		.regWrite(RegWrite), 
		.rd1(read_data1), 
		.rd2(read_data2)
	);


	ALUControl ALUCTRL(
		.ALUOp_in(ALUOp), 
		.func7(instruction[31:25]), 
		.func3(instruction[14:12]), 
		.ALUControl_out(ALUControl)
	);



	ALU ALU_inst(
		.a(read_data1), 
		.b(ALU_b) , 
		.zero(zero), 
		.ALUControl_in(ALUControl), 
		.ALU_result(ALU_result)
	);


	Data_Memory Data_Memory(
		.clk(clk), 
		.reset(reset), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.Address(ALU_result), 
		.Write_data(read_data2), 
		.Read_data(Read_data_mem)
	);

    assign WriteBack = MemtoReg ? Read_data_mem : ALU_result;




endmodule

`default_nettype wire