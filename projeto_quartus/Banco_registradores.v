module Banco_registradores(regA, regB, dado, regC, RW, clk, regsaidaA, regsaidaB);
input [4:0] regA;
input [4:0] regB;
input [15:0] dado;
input [4:0] regC;
input RW; //0 - leitura / 1 - escrita
input clk;
output reg [15:0] regsaidaA;
output reg [15:0] regsaidaB;

reg [15:0] registradores [31:0];

always @(posedge clk)
begin
	if(RW == 0) begin
		regsaidaA <= registradores[regA][15:0];
		regsaidaB <= registradores[regB][15:0];
	end else begin
		registradores[regC] <= dado;
	end
end

endmodule
