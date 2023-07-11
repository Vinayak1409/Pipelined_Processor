`timescale 1ns / 1ps

module adder(
input [31:0] A,
input [31:0] B,
output [31:0] sum
);

assign sum = A+B;


endmodule