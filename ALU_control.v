`timescale 1ns / 1ps

module ALU_control(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [2:0] ALU_control
    );
always@(*)
begin
if(ALUOp == 2'b00) 
 
	ALU_control = 3'b010;
else if(ALUOp == 2'b01)
	ALU_control = 3'b110;
else if(ALUOp[1]) begin
	case(funct[3:0])
	4'b0000 : ALU_control = 3'b010;  //add
	4'b0010 : ALU_control = 3'b110;  //sub
	4'b0100 : ALU_control = 3'b000;  //and
	4'b0101 : ALU_control = 3'b001;  //or
	4'b1010 : ALU_control = 3'b111;  //sll
	4'b1011 : ALU_control = 3'b011;  //srl
	
	endcase
end
end
endmodule
