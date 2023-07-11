`timescale 1ns / 1ps

module ID_EX(
	input Branch, MemRead, MemWrite, RegWrite, MemtoReg, RegDst, ALUSrc, clk,
	input [1:0] ALUOp,
	input [31:0] if_id_PC_plus_4, read_reg_data_1, read_reg_data_2, extended, if_id_instruction,
	input [4:0] read_reg_1,

	output reg id_ex_Branch, id_ex_MemRead, id_ex_MemWrite, id_ex_RegWrite, id_ex_MemtoReg, id_ex_RegDst, id_ex_ALUSrc,
	output reg [1:0] id_ex_ALUOp,
	output reg [4:0] id_ex_read_reg_1,
	output reg [31:0] id_ex_PC_plus_4, id_ex_read_reg_data_1, id_ex_read_reg_data_2, id_ex_extended, id_ex_instruction,
	input stall
	
	);
	
	
	always@ (negedge clk) begin
        if(!stall) begin
            id_ex_Branch <= Branch;
            id_ex_MemRead <= MemRead;
            id_ex_MemWrite <= MemWrite;
            id_ex_RegWrite <= RegWrite;
            id_ex_MemtoReg <= MemtoReg;
            id_ex_RegDst <= RegDst;
            id_ex_ALUSrc <= ALUSrc;
            id_ex_ALUOp <= ALUOp;
            id_ex_PC_plus_4 <= if_id_PC_plus_4;
            id_ex_read_reg_data_1 <= read_reg_data_1;
            id_ex_read_reg_1 <= read_reg_1;
            id_ex_read_reg_data_2 <= read_reg_data_2;
            id_ex_extended <= extended;
            id_ex_instruction <= if_id_instruction;
            end
         else
            begin
                id_ex_Branch <= 0;
                id_ex_MemRead <= 0;
                id_ex_MemWrite <= 0;
                id_ex_RegWrite <= 0;
                id_ex_MemtoReg <= 0;
                id_ex_RegDst <= 0;
                id_ex_ALUSrc <= 0;
                id_ex_ALUOp <= 0;
                id_ex_PC_plus_4 <= if_id_PC_plus_4;
                id_ex_read_reg_data_1 <= read_reg_data_1;
                id_ex_read_reg_1 <= read_reg_1;
                id_ex_read_reg_data_2 <= read_reg_data_2;
                id_ex_extended <= extended;
                id_ex_instruction <= if_id_instruction;
            end

	end
	
endmodule