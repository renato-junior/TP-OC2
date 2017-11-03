module Controle(clk, opcode, EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg);
input clk;
input [3:0] opcode;
output reg EscCondCP, EscCP, [3:0] ULA_OP, ULA_A, [1:0] ULA_B, EscIR, FonteCP, EscReg;

always @(posedge clk)
begin
	ULA_OP = opcode;
	if (opcode == 4b'1011 || opcode == 4b'1100) 		//Gera sinal EscCondCP
		4b'1011: EscCondCP = 1;
	else EscCondCP = 0;
		
	if (opcode == 4d'11) 								//Se opcode==jump ULA_B=2b'10;
		ULA_B = 2b'10;
	else
		ULA_B = 2b'00;
		
end

endmodule
 