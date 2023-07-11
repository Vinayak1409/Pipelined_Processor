`timescale 1ns / 1ps

module EX_MEM(
	input id_ex_Branch, id_ex_MemRead, id_ex_MemWrite, id_ex_RegWrite, id_ex_MemtoReg, clk, zero,
	input [31:0] id_ex_read_reg_data_2, ALU_out, adder2_result,
	input [4:0] write_reg,
	output reg ex_mem_Branch, ex_mem_MemRead, ex_mem_MemWrite, ex_mem_RegWrite, ex_mem_MemtoReg, ex_mem_zero,
	output reg [31:0] ex_mem_read_reg_data_2, ex_mem_ALU_out, ex_mem_adder2_result,
	output reg [4:0] ex_mem_write_reg,
	input stall
	);
	
	
	always@ (negedge clk) begin

            ex_mem_Branch <= id_ex_Branch;
            ex_mem_MemRead <= id_ex_MemRead;
            ex_mem_MemWrite <= id_ex_MemWrite;
            ex_mem_RegWrite <= id_ex_RegWrite;
            ex_mem_MemtoReg <= id_ex_MemtoReg;
            ex_mem_zero <= zero;
	       	ex_mem_write_reg <= write_reg;
            ex_mem_read_reg_data_2 <= id_ex_read_reg_data_2;
            ex_mem_ALU_out <= ALU_out;
            ex_mem_adder2_result <= adder2_result;

	end
	
endmodule