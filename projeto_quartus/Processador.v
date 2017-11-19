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
wire [15:0] resH;
wire [15:0] resL;


wire	[3:0]  endRegC = memi_out[11:8];
wire	[3:0]  endRegA = memi_out[7:4];
wire	[3:0]  endRegB = memi_out[3:0];
wire	[15:0] imm;
wire flagimm;
assign 		 imm[15:4] = 12'd0;
assign   	 imm[3:0] = memi_out[7:4];

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
	.EscReg(bancoRW),
	.flagimm(flagimm),
	.mul (mul_enable)
);


Memoria memoria_inst(
	
	.address(PC),
	.clock(CLOCK_50),
	.q (memi_out)
);


//Componentes do Banco de Registradores

wire [15:0] resultadoALU;
wire [15:0] saidaA;
wire [15:0] saidaB;

Banco_registradores banco(
	.regA(endRegA),
	.regB(endRegB),
	.regC(endRegC),
	.RW(bancoRW),
	.dado(resultadoALU),
	.imediato(imm),
	.flagImediato(flagimm),
	.clk(CLOCK_50),
	.regsaidaA(saidaA),
	.regsaidaB(saidaB)
);

//Componentes do MUX 2 to 1
wire [15:0] resultadoMuxAluA;
wire [15:0] resultadoMuxAluB;

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
wire [15:0] resultadoMux;

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


ALU alu(
	.clk(CLOCK_50),
	.codop(codeop),
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
	.enable (mul_enable)
);


assign j_imm[11:0] = memi_out[11:0];

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
		PC = 12'd0;
	end
	
	if(escCp == 1) begin
		if(fonteCp == 00) begin
			PC = PC + 12'd1;
		end  if(fonteCp == 01) begin //Se Branch
			PC = resultadoALU[11:0];
		end else if(fonteCp == 10) begin //Se Jump
			PC = j_imm[11:0];
		end
	end

end


 
endmodule
 
 