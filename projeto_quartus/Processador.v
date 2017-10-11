module Processador(CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
input CLOCK_50;
input [3:0] KEY;
input [17:0] SW;
output reg [6:0] HEX0;
output reg [6:0] HEX1;
output reg [6:0] HEX2;
output reg [6:0] HEX3;
output reg [6:0] HEX4;
output reg [6:0] HEX5;
output reg [6:0] HEX6;
output reg [6:0] HEX7;

reg [16:0] saidaA;
reg [16:0] saidaB;

Banco_registradores banco(
	.regA(SW[11:8]),
	.regB(SW[7:4]),
	.RW(0),
	.clk(CLOCK_50),
	.regsaidaA(saidaA),
	.regsaidaB(saidaB)
);
conversor7segmentos conversor1(
	.clk(CLOCK_50),
	.dado(saidaA[7:4]),
	.z(HEX7)
);
conversor7segmentos conversor2(
	.clk(CLOCK_50),
	.dado(saidaA[3:0]),
	.z(HEX6)
);
conversor7segmentos conversor3(
	.clk(CLOCK_50),
	.dado(saidaB[7:4]),
	.z(HEX5)
);
conversor7segmentos conversor4(
	.clk(CLOCK_50),
	.dado(saidaB[3:0]),
	.z(HEX6)
);

always @(posedge CLOCK_50)
begin
	if(KEY[0] == 1) begin
		
	end


end
 
endmodule
 