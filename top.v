`timescale 1ns / 1ps

module top(
    input clk,
    input reset,
    output [31:0] aluout,
    output [31:0] Instruction,
    output [31:0] ALU_A,
    output [31:0] ALU_B,
    
    output memread,
    output memtoreg,
    output [1:0] aluop,
    output [2:0] alucontrol,
    output memwrite,
    output alusrc,
    output regdst,
    output regwrite,
    output [4:0] writereg,
    output [31:0] Read_reg_data_2,
    output [31:0] Readdata
    
    );    
wire [31:0] instruction;
wire [31:0] PC_plus_4;
wire [31:0] PC;
wire Jump;
wire jr;
wire reg1;
wire jal;
wire Branch;
wire bne;
wire MemRead;
wire MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALSrc;
wire RegDst;
wire [31:0] write_data;
wire RegWrite;
wire [4:0] write_reg;
wire [31:0]read_reg_data_1;
wire [31:0]read_reg_data_2;
wire [31:0] extended;
wire zero;
wire [31:0] ALU_out;
wire [2:0] ALU_control;
wire [31:0] read_data;
wire signed [31:0] shifted;
wire [31:0] adder2_result;
wire [31:0] mux4_result;
wire [27:0] Out;
wire [31:0] jr_address;
wire [4:0] read_reg_1;
wire [31:0] jal_address;
wire [4:0] write_reg_1;
wire [31:0] write_data_1; 

wire  ex_mem_Branch, ex_mem_MemRead, ex_mem_MemWrite, ex_mem_RegWrite, ex_mem_MemtoReg, ex_mem_zero;
wire [31:0] ex_mem_read_reg_data_2, ex_mem_ALU_out, ex_mem_adder2_result;
wire  [4:0] ex_mem_write_reg;

wire [2:0] stall;
    
instruction_fetch if1(
.clk(clk),
.reset(reset),
.Jump(Jump),
.jr(jr),
.jal(jal),
.Branch(Branch),
.bne(bne),
.zero(zero),
.shifted(shifted),
.Jump_address(Out),
.jr_address(jr_address),
.jal_address(jal_address),
.instruction(instruction),
.PC(PC),
.stall(stall)
);

wire [31:0] read_address;
wire [31:0] in;

mux m0(
    .A(PC_plus_4),
    .B(ex_mem_adder2_result),
    .sel(ex_mem_Branch & ex_mem_zero),
    .Out(in)   
);

PC pc (
    .clk(clk),
    .reset(reset),
    .in(in),
    .PC(PC)
);


wire [31:0] if_id_instruction;
wire [31:0] if_id_PC_plus_4;


IF_ID if_id_uut(
    .clk(clk),
	.PC_plus_4(PC_plus_4), 
	.instruction(instruction),
	.if_id_PC_plus_4(if_id_PC_plus_4), 
	.if_id_instruction(if_id_instruction),
	.stall(stall[2])
);

wire  id_ex_Branch, id_ex_MemRead, id_ex_MemWrite, id_ex_RegWrite, id_ex_MemtoReg, id_ex_RegDst, id_ex_ALUSrc;
wire  [1:0] id_ex_ALUOp;
wire [4:0] id_ex_read_reg_1;
wire  [31:0] id_ex_PC_plus_4, id_ex_read_reg_data_1, id_ex_read_reg_data_2, id_ex_extended, id_ex_instruction;

ID_EX id_ex_uut (
    .clk(clk),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
    .if_id_PC_plus_4(if_id_PC_plus_4),
    .read_reg_data_1(read_reg_data_1),
    .read_reg_1(read_reg_1),
    .read_reg_data_2(read_reg_data_2),
    .extended(extended),
    .if_id_instruction(if_id_instruction),
    .id_ex_ALUSrc(id_ex_ALUSrc),
    .id_ex_RegDst(id_ex_RegDst),
    .id_ex_MemtoReg(id_ex_MemtoReg),
    .id_ex_Branch(id_ex_Branch),
    .id_ex_MemRead(id_ex_MemRead),
    .id_ex_MemWrite(id_ex_MemWrite),
    .id_ex_RegWrite(id_ex_RegWrite),
    .id_ex_ALUOp(id_ex_ALUOp),
    .id_ex_PC_plus_4(id_ex_PC_plus_4),
    .id_ex_read_reg_data_1(id_ex_read_reg_data_1),
    .id_ex_read_reg_1(id_ex_read_reg_1),
    .id_ex_read_reg_data_2(id_ex_read_reg_data_2),
    .id_ex_extended(id_ex_extended),
    .id_ex_instruction(id_ex_instruction),
    .stall(stall[2])
        
);


EX_MEM ex_mem_uut (
    .clk(clk),
    .id_ex_Branch(id_ex_Branch),
    .id_ex_MemRead(id_ex_MemRead),
    .id_ex_MemWrite(id_ex_MemWrite),
    .id_ex_RegWrite(id_ex_RegWrite),
    .id_ex_MemtoReg(id_ex_MemtoReg),
    .zero(zero),
    .ALU_out(ALU_out),
    .id_ex_read_reg_data_2(id_ex_read_reg_data_2),
    .adder2_result(adder2_result),
    .write_reg(write_reg),
    .ex_mem_Branch(ex_mem_Branch),
    .ex_mem_MemRead(ex_mem_MemRead),
    .ex_mem_MemWrite(ex_mem_MemWrite),
    .ex_mem_RegWrite(ex_mem_RegWrite),
    .ex_mem_MemtoReg(ex_mem_MemtoReg),
    .ex_mem_zero(ex_mem_zero),
    .ex_mem_ALU_out(ex_mem_ALU_out),
    .ex_mem_read_reg_data_2(ex_mem_read_reg_data_2),
    .ex_mem_adder2_result(ex_mem_adder2_result),
    .ex_mem_write_reg(ex_mem_write_reg),
    .stall(stall[2])
);

wire mem_wb_MemtoReg, mem_wb_RegWrite;
wire [4:0] mem_wb_write_reg;
wire [31:0] mem_wb_read_data, mem_wb_ALU_out, mem_wb_write_data;

MEM_WB mem_wb_uut (
    .clk(clk),
    .ex_mem_RegWrite(ex_mem_RegWrite),
    .ex_mem_MemtoReg(ex_mem_MemtoReg),
    .ex_mem_ALU_out(ex_mem_ALU_out),
    .read_data(read_data),
    .ex_mem_write_reg(ex_mem_write_reg),
    .mem_wb_RegWrite(mem_wb_RegWrite),
    .mem_wb_MemtoReg(mem_wb_MemtoReg),
    .mem_wb_write_reg(mem_wb_write_reg),
    .mem_wb_ALU_out(mem_wb_ALU_out),
    .mem_wb_read_data(mem_wb_read_data),
    .stall(stall[2])     
);

control c1(
    .opcode(if_id_instruction[31:26]),
    .RegDst(RegDst),
    .Jump(Jump),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .jr(jr),
    .reg1(reg1),
    .jal(jal),
    .bne(bne),
    .stall(stall[0]),
    .clk(clk)
);


adder a1(
.A(PC),
.B(4),
.sum(PC_plus_4)
);

mux m1(
    .A(id_ex_instruction[20:16]),
    .B(id_ex_instruction[15:11]),
    .sel(id_ex_RegDst),
    .Out(write_reg)   
);

mux m6(
    .A(if_id_instruction[25:21]),
    .B(if_id_instruction[4:0]),
    .sel(reg1),
    .Out(read_reg_1)   
);

mux m7(
    .A(mem_wb_write_reg),
    .B(5'b11111),
    .sel(jal),
    .Out(write_reg_1)   
);

mux m8(
    .A(mem_wb_write_data),
    .B(jal_address),
    .sel(jal),
    .Out(write_data_1)   
);

mux m3(
    .A(mem_wb_ALU_out),
    .B(mem_wb_read_data),
    .sel(mem_wb_MemtoReg),
    .Out(mem_wb_write_data)
);

data_memory d1(
    .address(ex_mem_ALU_out),
    .write_data(ex_mem_read_reg_data_2),
    .read_data(read_data),
    .mem_read(ex_mem_MemRead),
    .mem_write(ex_mem_MemWrite),
    .clk(clk)
);

register_file r1(
    .read_reg_1(read_reg_1),
    .read_reg_2(if_id_instruction[20:16]),
    .write_reg(write_reg_1),
    .write_data(write_data_1),
    .read_reg_data_1(read_reg_data_1),
    .read_reg_data_2(read_reg_data_2),
    .RegWrite(mem_wb_RegWrite),
    .clk(clk)
);

assign jr_address = read_reg_data_1;

sign_extender ex1(
    .A(if_id_instruction[15:0]),
    .OUT(extended)
);

mux m2(
    .A(id_ex_read_reg_data_2),
    .B(id_ex_extended),
    .sel(id_ex_ALUSrc),
    .Out(ALU_B) 
);

ALU_control ALUc(
    .ALUOp(id_ex_ALUOp),
    .funct(id_ex_instruction[5:0]),
    .ALU_control(ALU_control)
);

wire [1:0] forwardA, forwardB;

forwarding_unit fu (
    .ex_mem_RegWrite(ex_mem_RegWrite),
    .mem_wb_RegWrite(mem_wb_RegWrite),
    .clk(clk),
    .id_ex_read_reg_1(id_ex_read_reg_1),
    .id_ex_read_reg_2(if_id_instruction[20:16]),
    .ex_mem_write_reg(ex_mem_write_reg),
    .mem_wb_write_reg(write_reg_1),
    .forwardA(forwardA),
    .forwardB(forwardB)
);
wire [31:0] alu_a, alu_b;

mux2 m01 (
    .A(id_ex_read_reg_data_1),
    .B(write_data_1),
    .C(ex_mem_ALU_out),
    .sel(forwardA),
    .Out(alu_a) 
);
mux2 m02 (
    .A(ALU_B),
    .B(write_data_1),
    .C(ex_mem_ALU_out),
    .sel(forwardB),
    .Out(alu_b) 
);


ALU alu1(
    .ALU_src_1(alu_a),
    .ALU_src_2(alu_b),
    .ALU_control(ALU_control),
    .shamt(id_ex_instruction[10:6]),
    .ALU_out(ALU_out),
    .zero(zero),
    .clk(clk)
);

shifter s1(
    .A(id_ex_extended),
    .Out(shifted)   
);

adder a2(
    .A(id_ex_PC_plus_4),
    .B(shifted),
    .sum(adder2_result)
);





shifter2 s2(
    .A(instruction[25:0]),
    .Out(Out)  
);



stalling_unit su (
    .clk(clk),
    .id_ex_MemRead(id_ex_MemRead),
    .if_id_Rs(read_reg_1),
    .if_id_Rt(if_id_instruction[20:16]),
    .id_ex_Rt(id_ex_instruction[20:16]),
    .stall(stall)
);

assign aluout = ALU_out;
assign Instruction = instruction; 
assign ALU_A = read_reg_data_1;


assign memread = MemRead;
assign memtoreg = MemtoReg;              
assign aluop = ALUOp;            
assign memwrite = MemWrite;              
assign alusrc =ALUSrc;                 
assign regdst = RegDst;                
assign writedata = write_data;       
assign regwrite = RegWrite;               
assign writereg = write_reg;     
assign Read_reg_data_2 = read_reg_data_2; 
assign Readdata = read_data;
assign alucontrol = ALU_control;         

endmodule