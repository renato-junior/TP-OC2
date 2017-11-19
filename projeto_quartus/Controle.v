module Controle(clk, rst, opcode, EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg, flagimm);
input clk, rst;
input [3:0] opcode;
output reg EscCondCP, EscCP, ULA_A, EscIR, EscReg, flagimm;
output reg [3:0]ULA_OP;
output reg [1:0]ULA_B;  
output reg [1:0]FonteCP;

//Registrador do estado
reg [1:0] state;

//Declaração dos estados
parameter S0 = 0, S1 = 1; //inserir s2 caso multiplicação utilize dois ciclos

always @(posedge clk or posedge rst) begin	
	if (rst)
		state <= S0;
	else
		case(state)
			S0:	//Estado de execute, inclui Banco de Reg e ALU
				state <= S1;
			S1:	//Estado de WB
				state <= S0;	
		endcase
end

always @(state or opcode) begin
	ULA_OP = opcode;
	case(state)
		S0: begin
			if (opcode == 4'd0 || opcode == 4'd1 || opcode == 4'd3 || opcode == 4'd4 || opcode == 4'd5) begin //instruções com dois operandos
				EscCondCP = 0;
				EscCP = 0;
				ULA_A = 1;
				ULA_B = 00;
				FonteCP = 00;
				EscReg = 0;
				flagimm = 0;
			end
			
			if (opcode == 4'd2 || opcode == 4'd6 || opcode == 4'd7 || opcode == 4'd8 || opcode == 4'd9 || opcode == 4'd10) begin //imediatos
				EscCondCP = 0;
				EscCP = 0;
				ULA_A = 1;
				ULA_B = 10;   //operador imediato
				FonteCP = 00;
				EscReg = 0;
				flagimm = 1;
			end
			
			if(opcode == 4'd11) begin //jump - nao passa na alu
				EscCondCP = 0;	
				EscCP = 0;
				ULA_A = 1;		//irrelevante para jump
				ULA_B = 10;  //irrelevante para jump
				FonteCP = 10;
				EscReg = 0;
			end
			
			if(opcode == 4'd12) begin //branch
				EscCondCP = 1;
				EscCP = 0;	
				ULA_A = 0;
				ULA_B = 00;
				FonteCP = 01;
				EscReg = 0; //nao escreve no banco
			end
		end
			
		S1: begin
			if (opcode == 4'd0 || opcode == 4'd1 || opcode == 4'd3 || opcode == 4'd4 || opcode == 4'd5) begin //instruções com dois operandos
				EscCondCP = 0;
				EscCP = 1;
				FonteCP = 00;
				EscReg = 1;
			end
			
			if (opcode == 4'd2 || opcode == 4'd6 || opcode == 4'd7 || opcode == 4'd8 || opcode == 4'd9 || opcode == 4'd10) begin //imediatos
				EscCondCP = 0;
				EscCP = 1;
				FonteCP = 00;
				EscReg = 1;
			end
			
			if(opcode == 4'd11) begin //jump - nao passa na alu
				EscCondCP = 0;	
				EscCP = 1;
				FonteCP = 10;
				EscReg = 0;	
			end
			
			if(opcode == 4'd12) begin //branch
				EscCondCP = 1;
				EscCP = 1;
				FonteCP = 01;
				EscReg = 0; //nao escreve no banco
			end
		end
	endcase
end

endmodule
 