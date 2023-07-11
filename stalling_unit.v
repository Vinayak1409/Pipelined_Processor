`timescale 1ns / 1ps



module stalling_unit(
	input clk, id_ex_MemRead,
	input [4:0] if_id_Rs, if_id_Rt, id_ex_Rt,
	output reg [2:0] stall
	);
	
	always@ (posedge clk) begin
		if(id_ex_MemRead & ((id_ex_Rt == if_id_Rs) | (id_ex_Rt == if_id_Rt)))
			stall <= 1;
		else
			stall <= 0;
	end
	
	
	
endmodule
