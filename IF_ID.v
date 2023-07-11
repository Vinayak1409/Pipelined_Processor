`timescale 1ns / 1ps

module IF_ID(
    input clk,
	input [31:0] PC_plus_4, instruction,
	output reg [31:0] if_id_PC_plus_4, if_id_instruction,
	input stall
	);
	
	
	always@ (negedge clk)
	begin
	if(!stall) begin
            if_id_PC_plus_4 <= PC_plus_4;
            if_id_instruction <= instruction;
    end
	end
	
endmodule