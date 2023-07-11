`timescale 1ns / 1ps

module mux2(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [1:0] sel,
    output  [31:0] Out
);

assign Out = sel[1]? C:(sel[0]? B:A);
endmodule