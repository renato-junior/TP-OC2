module Processador(CLOCK_50, reset);
input CLOCK_50;
wire [15:0] memi_out;
reg [11:0] PC;
wire zero;
input reset;

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
	.clk(CLOCK_50),
	.inst(memi_out),
	.controle_a(controle_a),
	.regs_a (regs_a),
	.controle_b(controle_b),
	.regs_b (regs_b),
	.controle_c(controle_c),
	.regs_c (regs_c),
	.pc(PC)
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
wire [15:0] j_imm;
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
	.clk(CLOCK_50),
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
	.enable (controle_b[10])
);


assign j_imm[11:0] = memi_out[11:0];



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
		if(controle_a[7:6] == 00) begin
			PC = PC + 12'd1;
		end  if(controle_a[7:6] == 01) begin //Se Branch
			PC = resultadoALU[11:0];
		end else if(controle_a[7:6] == 10) begin //Se Jump
			PC = j_imm[11:0];
		end
	end

end


 
endmodule
 
 