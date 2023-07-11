`timescale 1ns / 1ps

module control(
    input [5:0] opcode,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg jr,
    output reg reg1,
    output reg jal,
    output reg bne,
    input stall,
    input clk
    );
always@(*)
begin
case(opcode)
	6'b000000 : begin       //	R - type
						RegDst = 1;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 1;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 1;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b100011 : begin			//LW
						RegDst = 0;
						ALUSrc = 1;
						MemtoReg = 1;
						RegWrite = 1;
						MemRead = 1;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b101011 : begin			//SW
						RegDst = 0;
						ALUSrc = 1;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 1;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b000100 : begin			//beq
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 1;
						ALUOp[1] = 0;
						ALUOp[0] = 1;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b100000 : begin			//bne
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						bne = 1;
						ALUOp[1] = 0;
						ALUOp[0] = 1;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						end
	6'b000001 : begin			//addi
						RegDst = 0;
						ALUSrc = 1;
						MemtoReg = 0;
						RegWrite = 1;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b000010 : begin			//j
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 1;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
	6'b000011 : begin			//jr
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 1;
						reg1 = 1;
						jal = 0;
						bne = 0;
						end
	6'b000111 : begin			//jal
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 1;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 1;
						jr = 0;
						reg1 = 0;
						jal = 1;
						bne = 0;
						end		
	6'b001111 : begin			//jalr
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 1;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 1;
						reg1 = 1;
						jal = 1;
						bne = 0;
						end					
	default : begin			
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						Jump = 0;
						jr = 0;
						reg1 = 0;
						jal = 0;
						bne = 0;
						end
endcase

end

/*always@(*)
begin
if(stall) begin
	Branch = 0; 
    MemRead = 0;
    MemWrite = 0;
    RegWrite = 0;
    MemtoReg = 0;
    RegDst = 0;
    ALUSrc = 0;
    ALUOp = 0;
end
end*/


endmodule
