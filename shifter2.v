`timescale 1ns / 1ps


module shifter2(
    input [25:0] A,
    output reg [27:0] Out
    );

always@(*)
begin
Out = {2'b00,(A<<2)};
end
endmodule
