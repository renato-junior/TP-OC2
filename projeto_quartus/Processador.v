module Processador(CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
input CLOCK_50;
input [3:0] KEY;
input [17:0] SW;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;
output [6:0] HEX6;
output [6:0] HEX7;

//Componentes do Banco de Registradores
reg bancoRW;
reg [4:0] endRegA;
reg [4:0] endRegB;
reg [4:0] endRegC;
reg [15:0] dadoBanco;
wire [15:0] saidaA;
wire [15:0] saidaB;

Banco_registradores banco(
	.regA(endRegA),
	.regB(endRegB),
	.regC(endRegC),
	.RW(bancoRW),
	.dado(dadoBanco),
	.clk(CLOCK_50),
	.regsaidaA(saidaA),
	.regsaidaB(saidaB)
);

//Componentes da ALU
reg [4:0] codop;
reg [15:0] imm;
wire [15:0] resultadoALU;

ALU alu(
	.clk(CLOCK_50),
	.codop(codop),
	.operando1(saidaA),
	.operando2(saidaB),
	.resultado(resultadoALU)
);


conversor7segmentos conversor7(
	.clk(CLOCK_50),
	.dado(saidaA[7:4]),
	.z(HEX7)
);
conversor7segmentos conversor6(
	.clk(CLOCK_50),
	.dado(saidaA[3:0]),
	.z(HEX6)
);
conversor7segmentos conversor5(
	.clk(CLOCK_50),
	.dado(saidaB[7:4]),
	.z(HEX5)
);
conversor7segmentos conversor4(
	.clk(CLOCK_50),
	.dado(saidaB[3:0]),
	.z(HEX4)
);
conversor7segmentos conversor3(
	.clk(CLOCK_50),
	.dado(resultadoALU[15:12]),
	.z(HEX3)
);
conversor7segmentos conversor2(
	.clk(CLOCK_50),
	.dado(resultadoALU[11:8]),
	.z(HEX2)
);
conversor7segmentos conversor1(
	.clk(CLOCK_50),
	.dado(resultadoALU[7:4]),
	.z(HEX1)
);
conversor7segmentos conversor0(
	.clk(CLOCK_50),
	.dado(resultadoALU[3:0]),
	.z(HEX0)
);

always @(posedge CLOCK_50)
begin
	if(KEY[0] == 1) begin
		endRegA = SW[11:8];
		endRegB = SW[7:4];
		bancoRW = 0;
	end
	if(KEY[3] == 1) begin
		bancoRW = 0;
		codop = SW[15:12];
		if(codop == 4'd0) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd1) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd2) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd3) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd4) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd5) begin
			endRegC = SW[11:8];
			endRegA = SW[7:4];
			endRegB = SW[3:0];
		end else if(codop == 4'd6) begin
			endRegC = SW[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = SW[7:4];
			endRegB = SW[3:0];
		end
//		end else if(codop == 4'd7) begin
//			endRegC = SW[11:8];
//			saidaA[15:4] = 12'd0;
//			saidaA[3:0] = SW[7:4];
//			endRegB = SW[3:0];
//		end else if(codop == 4'd8) begin
//			endRegC = SW[11:8];
//			saidaA[15:4] = 12'd0;
//			saidaA[3:0] = SW[7:4];
//			endRegB = SW[3:0];
//		end else if(codop == 4'd9) begin
//			endRegC = SW[11:8];
//			saidaA[15:4] = 12'd0;
//			saidaA[3:0] = SW[7:4];
//			endRegB = SW[3:0];
//		end else if(codop == 4'd10) begin
//			endRegC = SW[11:8];
//			saidaA[15:4] = 12'd0;
//			saidaA[3:0] = SW[7:4];
//			endRegB = SW[3:0];
//		end
		
		dadoBanco = resultadoALU;
		bancoRW = 1;
	end


end
 
endmodule
 