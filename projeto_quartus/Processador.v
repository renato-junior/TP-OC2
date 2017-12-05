module Processador(CLOCK_50, reset, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
input CLOCK_50;
input reset;
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
reg [11:0] PC;
wire zero;
wire inv = ~KEY[3];


//Componentes unidade de controle

wire [15:0] resH;
wire [15:0] resL;


wire [15:0]controle_a ;
wire [11:0]regs_a  ;
wire [15:0]controle_b ;
wire [11:0]regs_b  ;
wire [15:0]controle_c ;
wire [11:0]regs_c  ;



Ctrl ctrl(
	.clk(inv),
	.inst(SW[15:0]),
	.controle_a(controle_a),
	.regs_a (regs_a),
	.controle_b(controle_b),
	.regs_b (regs_b),
	.controle_c(controle_c),
	.regs_c (regs_c)
);


//Componentes do Banco de Registradores

wire [15:0] resultadoALU;
wire [15:0] saidaA;
wire [15:0] saidaB;

Banco_registradores banco(
	.regA(regs_b[7:4]),
	.regB(regs_b[3:0]),
	.regC(regs_c[11:8]),
	.RW(controle_c[8]),
	.dado(resultadoALU[15:0]),
	.clk(CLOCK_50),
	.regsaidaA(saidaA),
	.regsaidaB(saidaB)
);

//Componentes do MUX 3 to 1
wire [15:0] resultadoMuxAluA;
wire [15:0] resultadoMuxAluB;
wire [1:0] select_muxAluA;
assign select_muxAluA[0] = controle_b[2];
assign select_muxAluA[1] = controle_b[9];

Mux_3_to_1 muxAluA(

	.select(select_muxAluA),
	.data2(resultadoALU),
	.data1(saidaA),
	.data0(PC),
	.resultado(resultadoMuxAluA)
);

//Componentes do MUX 3 to 1 ALU
reg [15:0] data = 16'd1;
wire [15:0] extEndRegB;
wire [11:0] j_imm;
wire [15:0] resultadoMux;

assign extEndRegB[3:0] = regs_b[3:0];
assign extEndRegB[15:4] = 12'd0;

Mux_4_to_1 muxAluB(
	.data0(saidaB),
	.data1(data),
	.data2(extEndRegB),
	.data3(resultadoALU),
	.select(controle_b[4:3]),
	.resultado(resultadoMuxAluB)
);

//Componentes da ALU




ALU alu(
	.clk(inv),
	.codop(controle_b[14:11]),
	.operando1(resultadoMuxAluA),
	.operando2(resultadoMuxAluB),
	.resultado(resultadoALU),
	.zero(zero),
	.mulH (resH),
	.mulL (resL)
);
//Componentes do ultimo Mux 3 to 1


Mul Mul(

	.op1 (resultadoMuxAluA),
	.op2 (resultadoMuxAluB),
	.resH (resH),
	.resL (resL),
	.enable (controle_b[10]),
	.clk (inv)
);


//Conversores 7-segmentos
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



assign j_imm[11:0] = SW[11:0];


initial begin

PC = 12'd0;
end

 
 always @(posedge CLOCK_50)
begin
	//logica do PC
	if (reset == 1) begin 
		PC = 12'd0;
	end
	
	if(controle_a[1] == 1) begin
	
	  if(controle_a[7:6] == 2'b01) begin //Se Branch
			
			if (saidaA == 0) begin
				PC [11:0] = saidaB[11:0];
			end
			
		end else if(controle_a[7:6] == 2'b10) begin //Se Jump
			PC = regs_a[11:0];
			
			end else begin
				PC = PC + 12'd1;
		 
			end

		
	end
end


endmodule
 
 