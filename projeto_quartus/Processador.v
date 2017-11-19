module Processador(CLOCK_50, reset, resetFSM, instruction);
input CLOCK_50, resetFSM;
input [15:0]instruction;
input reset;
reg [15:0] PC;
wire zero;

//Componentes unidade de controle

wire [3:0] ULA_OP;
wire aluA, bancoRW, escCondCp, escCp, escIr;
wire [1:0]aluB;  
wire [1:0]fonteCp;

wire flagimm;

Controle controle(
	.clk(CLOCK_50),
	.rst(resetFSM),
	.opcode(instruction[15:12]),
	.EscCondCP(escCondCp),
	.EscCP(escCp),
	.ULA_OP(ULA_OP),
	.ULA_A(aluA),
	.ULA_B(aluB),
	.EscIR(escIr),
	.FonteCP(fonteCp),
	.EscReg(bancoRW),
	.flagimm(flagimm)
);

//Componentes do Banco de Registradores
wire [15:0] saidaA;
wire [15:0] saidaB;
wire [15:0] resultadoALU;

Banco_registradores banco(
	.regA(instruction[7:4]), //operando $s3 está nos bits [7:4] da instrucao
	.regB(instruction[3:0]), //operando $s2 está nos bits menos significativos
	.regC(instruction[11:8]),//operando $s4 está nos bits [11:8] da instrucao
	.RW(bancoRW),
	.dado(resultadoALU),
	.flagImediato(flagimm),
	.clk(CLOCK_50),
	.regsaidaA(saidaA),
	.regsaidaB(saidaB)
);

//Componentes do MUX 2 to 1
wire [15:0] resultadoMuxAluA;

Mux_2_to_1 muxAluA(
	.select(aluA),
	.regA(saidaA),
	.pc(PC),
	.resultado(resultadoMuxAluA)
);

//Componentes do MUX 3 to 1 ALU
reg [15:0] data = 16'd1;
wire [15:0] extEndRegB;
wire [15:0] resultadoMuxAluB;

assign extEndRegB[3:0] = instruction[7:4];
assign extEndRegB[15:4] = 12'd0;

Mux_3_to_1 muxAluB(
	.data0(saidaB),
	.data1(data),
	.data2(extEndRegB),
	.select(aluB),
	.resultado(resultadoMuxAluB)
);

//Componentes da ALU


ALU alu(
	.clk(CLOCK_50),
	.codop(instruction[15:12]),
	.operando1(resultadoMuxAluA),
	.operando2(resultadoMuxAluB),
	.resultado(resultadoALU),
	.zero(zero)
);

//Componentes do ultimo Mux 3 to 1
wire [15:0] resultadoMux;

//Mux_3_to_1 muxPosAlu(
//	.data0(resultadoALU),
//	.data1(resultadoALU),
//	.data2(j_imm),
//	.select(fonteCp),
//	.resultado(resultadoMux)
//);

 
always @(posedge CLOCK_50)
begin
	
	//logica do PC
	if (reset == 1) begin 
		PC = 16'd0;
	end
	
	if(escCp == 1) begin
		if(fonteCp == 00) begin
			PC = PC + 16'd1;
		end  if(fonteCp == 01) begin //Se Branch
			PC = resultadoALU[15:0];
		end else if(fonteCp == 10) begin //Se Jump
			PC[11:0] = instruction[11:0];
			PC[15:12] = PC[15:12]; 
		end
	end
end


 
endmodule
 
 