module Controle(clk, opcode, EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg);
input clk;
input [3:0] opcode;
output reg EscCondCP, EscCP, ULA_A, EscIR, EscReg;
output reg [3:0]ULA_OP;
output reg [1:0]ULA_B;  
output reg [1:0]FonteCP;


reg [1:0] estado;

initial begin
	estado = 2'd0;
end

always @(posedge clk)
begin
	ULA_OP = opcode;
	
	if (opcode == 4'd0 || opcode == 4'd1 || opcode == 4'd3 || opcode == 4'd4 || opcode == 4'd5)
		begin
			if(estado == 2'd0) begin
				EscCondCP = 0;
				EscCP = 1;
				ULA_A = 0;
				ULA_B = 00;
				EscIR = 0;
				FonteCP = 00;
				EscReg = 0;
				estado = 2'd1;
			end else if(estado == 2'd1) begin 
				EscCondCP = 0;
				EscCP = 1;
				ULA_A = 0;
				ULA_B = 00;
				EscIR = 0;
				FonteCP = 00;
				EscReg = 1;
				estado = 2'd2;
			end else if(estado == 2'd2) begin 
				estado = 2'd0;
			end
		end
		
	if (opcode == 4'd2 || opcode == 4'd6 || opcode == 4'd7 || opcode == 4'd8 || opcode == 4'd9 || opcode == 4'd10)	
		begin
			if(estado == 2'd0) begin
				EscCondCP = 0;
				EscCP = 1;
				ULA_A = 0;
				ULA_B = 10;   //operador imediato
				EscIR = 0;
				FonteCP = 00;
				EscReg = 0;
			end else if(estado == 2'd1) begin 
				EscCondCP = 0;
				EscCP = 1;
				ULA_A = 0;
				ULA_B = 10;   //operador imediato
				EscIR = 0;
				FonteCP = 00;
				EscReg = 1;
			end else if(estado == 2'd2) begin 
				estado = 2'd0;
			end
		end
		
	if (opcode == 4'd11)	//jump
		begin
			EscCondCP = 0;
			EscCP = 1;
			ULA_A = 0;
			ULA_B = 10; //operador imediato
			EscIR = 0;	//nao escreve na memoria
			FonteCP = 00;
			EscReg = 0;  //nao escreve no banco
		end
		
	if (opcode == 4'd12)	
		begin
			EscCondCP = 1;
			EscCP = 1;
			ULA_A = 0;
			ULA_B = 00;
			EscIR = 0;
			FonteCP = 01;
			EscReg = 0; //nao escreve no banco
		end	
		
end

endmodule
 