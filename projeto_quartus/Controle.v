module Controle(clk, opcode, EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg);
input clk;
input [3:0] opcode;
output reg EscCondCP, EscCP, ULA_A, EscIR, EscReg;
output reg [3:0]ULA_OP;
output reg [1:0]ULA_B;  
output reg [1:0]FonteCP;


integer estado;

initial begin
	estado = 2'd0;
end

always @(posedge clk)
begin
	if(opcode != ULA_OP) begin
		estado = 0;
	end
	ULA_OP = opcode;
	
	if (opcode == 4'd0 || opcode == 4'd1 || opcode == 4'd3 || opcode == 4'd4 || opcode == 4'd5)
		begin
			if(estado == 0) begin
				EscCondCP = 0;
				EscCP = 0;
				ULA_A = 1;
				ULA_B = 00;
				EscIR = 0;
				FonteCP = 00;
				EscReg = 0;
				estado = estado + 1;
			end else if(estado == 5) begin 
				EscReg = 1;
				estado = estado + 1;
			end else if(estado == 7) begin 
				EscCP = 1;
				EscReg = 0;
				estado = 0;
			end else begin
				estado = estado + 1;
			end	
		end
		
	if (opcode == 4'd2 || opcode == 4'd6 || opcode == 4'd7 || opcode == 4'd8 || opcode == 4'd9 || opcode == 4'd10)	
		begin
			if(estado == 0) begin
				EscCondCP = 0;
				EscCP = 0;sim:/Processador/escIr

				ULA_A = 1;
				ULA_B = 00;   //operador imediato
				EscIR = 0;
				FonteCP = 00;
				EscReg = 0;
				estado = estado + 1;
			end else if(estado == 5) begin 
				EscReg = 1;
				estado = estado + 1;
			end else if(estado == 7) begin 
				EscCP = 1;
				EscReg = 0;
				estado = 0;
			end else begin
				estado = estado + 1;
			end
		end
		
	if (opcode == 4'd11)	//jump
		begin
			if(estado == 0) begin
				EscCondCP = 0;
				EscCP = 0;
				ULA_A = 0;
				ULA_B = 10; //operador imediato
				EscIR = 0;	//nao escreve na memoria
				FonteCP = 10;
				EscReg = 0;  //nao escreve no banco
				estado = estado + 1;
			end else if(estado == 2) begin 
				EscCP = 1;
				estado = estado + 1;
			end else begin
				estado = estado + 1;
			end
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
 