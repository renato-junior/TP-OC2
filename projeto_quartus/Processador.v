module Processador(CLOCK_50, reset);
input CLOCK_50;
wire [15:0] memi_out;
reg [11:0] PC;
reg [15:0] extPC;
wire zero;
integer aux;
input reset;

//Componentes unidade de controle

wire [3:0] codeop;
wire [3:0] ULA_OP;
assign codeop = memi_out[15:12];
wire aluA, bancoRW, escCondCp, escCp, escIr;
wire [1:0]aluB;  
wire [1:0]fonteCp;

Controle controle(
	.clk(CLOCK_50),
	.opcode(codeop),
	.EscCondCP(escCondCp),
	.EscCP(escCp),
	.ULA_OP(ULA_OP),
	.ULA_A(aluA),
	.ULA_B(aluB),
	.EscIR(escIr),
	.FonteCP(fonteCp),
	.EscReg(bancoRW)
);


Memoria memoria_inst(
	
	.address(PC),
	.clock(CLOCK_50),
	.q (memi_out)
);


//Componentes do Banco de Registradores
reg [3:0] endRegA;
reg [3:0] endRegB;
reg [3:0] endRegC;
reg [15:0] dadoBanco;
reg [15:0] imm;
reg flagimm;
wire [15:0] saidaA;
wire [15:0] saidaB;

Banco_registradores banco(
	.regA(endRegA),
	.regB(endRegB),
	.regC(endRegC),
	.RW(bancoRW),
	.dado(dadoBanco),
	.imediato(imm),
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
wire [15:0] j_imm;
wire [15:0] resultadoMuxAluB;

assign extEndRegB[3:0] = endRegB[3:0];
assign extEndRegB[15:4] = 12'd0;

Mux_3_to_1 muxAluB(
	.data0(saidaB),
	.data1(data),
	.data2(extEndRegB),
	.select(aluB),
	.resultado(resultadoMuxAluB)
);

//Componentes da ALU
wire [15:0] resultadoALU;

ALU alu(
	.clk(CLOCK_50),
	.codop(codeop),
	.operando1(resultadoMuxAluA),
	.operando2(resultadoMuxAluB),
	.resultado(resultadoALU),
	.zero(zero)
);

//Componentes do ultimo Mux 3 to 1
wire [15:0] resultadoMux;

assign j_imm[11:0] = memi_out[11:0];
assign j_imm[15:12] = 4'b0;

Mux_3_to_1 muxPosAlu(
	.data0(resultadoALU),
	.data1(resultadoALU),
	.data2(j_imm),
	.select(fonteCp),
	.resultado(resultadoMux)
);

 
 always @(posedge CLOCK_50)
begin
	
	//logica do PC
	if (reset) begin 
	PC = 15'b0;
	end
	
	if (escCp || (escCondCp && zero )) begin
		PC = resultadoMux;
	end else begin
		PC = PC + 1'b1;
	end

		flagimm = 0;

		
		if(codeop == 4'd0) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd1) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd2) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd3) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd4) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd5) begin
			endRegC = memi_out[11:8];
			endRegA = memi_out[7:4];
			endRegB = memi_out[3:0];
		end else if(codeop == 4'd6) begin
			endRegC = memi_out[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = memi_out[7:4];
			endRegB = memi_out[3:0];
			flagimm = 1;
		end else if(codeop == 4'd7) begin
			endRegC = memi_out[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = memi_out[7:4];
			endRegB = memi_out[3:0];
			flagimm = 1;
		end else if(codeop == 4'd8) begin
			endRegC = memi_out[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = memi_out[7:4];
			endRegB = memi_out[3:0];
			flagimm = 1;
		end else if(codeop == 4'd9) begin
			endRegC = memi_out[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = memi_out[7:4];
			endRegB = memi_out[3:0];
			flagimm = 1;
		end else if(codeop == 4'd10) begin
			endRegC = memi_out[11:8];
			imm[15:4] = 12'd0;
			imm[3:0] = memi_out[7:4];
			endRegB = memi_out[3:0];
			flagimm = 1;
		end
		dadoBanco = resultadoALU;
end


 
endmodule
 
 