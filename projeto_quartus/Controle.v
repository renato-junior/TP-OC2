module Controle(clk, opcode, EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg);
input clk;
input [3:0] opcode;
output reg EscCondCP, EscCP, ULA_OP, ULA_A, ULA_B, EscIR, FonteCP, EscReg;

always @(posedge clk)
begin
	ULA_OP = opcode;
	if ( opcode[3:0] == 4'b1011 || opcode [3:0] == 4'b1100 ) 		//Gera sinal EscCondCP
			EscCondCP = 1;
	else 
			EscCondCP = 0;
		
		
	if (opcode == 4'd11)							//Se opcode==jump ULA_B=2b'10;
		ULA_B = 2'b10;
	else
		ULA_B = 2'b00;
	
		
end

endmodule
 