`timescale 1ns / 1ps

module testbench();
reg clk;
reg reset;

wire [31:0] aluout;
wire [31:0] Instruction;
wire [31:0] ALU_A;
wire [31:0] ALU_B;

wire memread;               
wire memtoreg;              
wire [1:0] aluop;           
wire memwrite;              
wire alusrc;                
wire regdst;                
//wire [31:0] writedata;      
wire regwrite;              
wire [4:0] writereg;        
wire [31:0] Read_reg_data_2;
wire [31:0] Readdata;  
wire [2:0] alucontrol;
    

top uut (
.clk (clk),
.reset (reset),
.aluout (aluout),
.Instruction(Instruction),
.ALU_A(ALU_A),
.ALU_B(ALU_B),

.memread(memread),
.memtoreg(memtoreg),
.aluop(aluop),
.memwrite(memwrite),
.alusrc(alusrc),
.regdst(regdst),
.regwrite(regwrite),
.writereg(writereg),
.Read_reg_data_2(Read_reg_data_2),
.Readdata(Readdata),
.alucontrol(alucontrol)
);

initial begin

forever
begin
    clk = 1;
#50;
    clk = 0;
#50;
end 
end
initial begin

reset = 0;
#150;
reset = 1;
#10000;
$finish;
end
endmodule