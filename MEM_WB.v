`timescale 1ns / 1ps

module MEM_WB(
	input ex_mem_RegWrite, ex_mem_MemtoReg, clk,
	input [31:0] ex_mem_ALU_out, read_data,
	input [4:0] ex_mem_write_reg, 
	output reg mem_wb_MemtoReg, mem_wb_RegWrite,
	output reg [4:0] mem_wb_write_reg,
	output reg [31:0] mem_wb_read_data, mem_wb_ALU_out,
	input stall
	);
	
	
	always@ (negedge clk) 
	  begin

            mem_wb_RegWrite <= ex_mem_RegWrite;
            mem_wb_MemtoReg <= ex_mem_MemtoReg;
            mem_wb_read_data <= read_data;
            mem_wb_ALU_out <= ex_mem_ALU_out;
            mem_wb_write_reg <= ex_mem_write_reg;
	  end
endmodule
