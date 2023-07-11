`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:58 03/20/2023 
// Design Name: 
// Module Name:    data_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_memory(
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data,
    input mem_read,
    input mem_write,
    input clk
    );
	 
reg [7:0] dataMem [127:0];
initial begin
	$readmemh("data_mem.mem", dataMem);
	end
	
always@(posedge clk)
begin
	if(mem_write)
	begin
		{dataMem[address+3], dataMem[address+2], dataMem[address+1], dataMem[address]} <= write_data;
	end
	
	if(mem_read)
	begin
		read_data <= {dataMem[address+3], dataMem[address+2], dataMem[address+1], dataMem[address]};
	end
		
end

endmodule
