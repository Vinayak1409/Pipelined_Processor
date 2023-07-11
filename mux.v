`timescale 1ns / 1ps

module mux(
    input [31:0] A,
    input [31:0] B,
    input sel,
    output  [31:0] Out
);

assign Out = sel? B:A;
endmodule