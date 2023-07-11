`timescale 1ns / 1ps

module ALU(
    input [31:0] ALU_src_1,
    input [31:0] ALU_src_2,
    input [2:0] ALU_control,
    input [4:0] shamt,
    output reg [31:0] ALU_out,
    output reg zero,
    input clk
    );
	 
always @(*) begin
	case(ALU_control)
	3'b000 : ALU_out = ALU_src_1 & ALU_src_2;
	3'b001 : ALU_out = ALU_src_1 | ALU_src_2;
	3'b010 : ALU_out = ALU_src_1 + ALU_src_2;
	3'b110 : ALU_out = ALU_src_1 - ALU_src_2;
	3'b111 : ALU_out = ALU_src_1 << shamt;
	3'b011 : ALU_out = ALU_src_1 >> shamt;
	default: ALU_out = 32'b 0;
	endcase
end 	

always@(*)
begin
if(ALU_out == 0)
	zero = 1; 
else 
	zero = 0;
end

endmodule
