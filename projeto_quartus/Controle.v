/*

	Barramento de controle 16 bits:
	
	
		0: EscCondCP
		1: EscCP
		2: ULA_A[0]
	 3-4: ULA_B
		5: EscIR
    6-7: FonteCP [1:0]
		8: EscReg
		9: ULA_A[1]
	  10: Mul
  11-14: ULA_OP
     15: reservado
	  
	O bloco de controle mantem os sinais de controle da instrução atual e das duas últimas.
	No pipeline alguns blocos usam os sinais de controle atual e outros usam os sinais das instruções passdas.
  
		
*/

module Ctrl(clk, inst, controle_a, controle_b, controle_c, regs_a, regs_b, regs_c, pc);
input clk;
input [15:0] inst;
output reg [15:0]controle_a ;
output reg [11:0]regs_a  ;
output reg [15:0]controle_b ;
output reg [11:0]regs_b  ;
output reg [15:0]controle_c ;
output reg [11:0]regs_c  ;
input [11:0] pc;

initial begin

	regs_a[11:0] = 12'b0;
	regs_b[11:0] = 12'b1;
	
end

always @(posedge clk) begin
	
	controle_c [15:0] = controle_b [15:0];
	controle_b [15:0] = controle_a [15:0];

	regs_c [11:0] = regs_b [11:0];
	regs_b [11:0] = regs_a [11:0];
	
	
end


always @(inst)
begin

	controle_a [14:11] = inst [15:12];	
	regs_a [11:0] = inst [11:0];
	
	
	if (inst[15:12] == 4'd0 || inst[15:12] == 4'd1 || inst[15:12] == 4'd3 || inst[15:12] == 4'd4 || inst[15:12] == 4'd5 || inst[15:12] == 4'd13 || inst[15:12] == 4'd14 || inst[15:12] == 4'd15 )
		begin
		

	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[9] = 0;
	controle_a[10] = 0;			//Mul	
	controle_a[15] = 0;
	
		end
		
	if (inst[15:12] == 4'd2 || inst[15:12] == 4'd6 || inst[15:12] == 4'd7 || inst[15:12] == 4'd8 || inst[15:12] == 4'd9 || inst[15:12] == 4'd10)	
		begin
				
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b10;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[9] = 0;	
	controle_a[10] = 0;			//Mul							
	controle_a[15] = 0;	
				
		end
		
	if (inst[15:12] == 4'd11)	//jump
		begin
		
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b10;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b10;	//FonteCP
	controle_a[8] = 0;			//EscReg
	controle_a[9] = 0;	
	controle_a[10] = 0;			//Mul		
	controle_a[15] = 0;
		end
		
	if (inst[15:12] == 4'd12)	//branch
		begin
		
	controle_a[0] = 1;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b01;	//FonteCP
	controle_a[8] = 0;			//EscReg
	controle_a[9] = 0;	
	controle_a[10] = 0;			//Mul
	controle_a[15] = 0;	
		
			
		end
	

		if (inst[15:12] == 4'd15) begin
		
		
	controle_a[0] = 0;			//EscCondCP
	controle_a[1] = 1;			//EscCP
	controle_a[2] = 1;			//ULA_A
	controle_a[4:3] = 2'b00;	//ULA_B
	controle_a[5] = 0;			//EscIR
	controle_a[7:6] = 2'b00;	//FonteCP
	controle_a[8] = 1;			//EscReg
	controle_a[9] = 0;	
	controle_a[10] = 1;			//Mul		
	controle_a[15] = 0;
	
		end

	if (pc != 12'b0) begin
		
		if (inst[15:0] == 16'b0) begin			//Tratamento do nop
		controle_a[15:0] = 16'b10;					//EscCP = 1
		
		end
		
		if (regs_a[7:4] == regs_b[11:8]) begin	 //encaminhamento ALU_A	
			controle_a[9] = 1;
			controle_a[2] = 0;
			end	
			
		if (regs_a[3:0] == regs_b[11:8]) begin	//encaminhamento ALU_B	
			controle_a[4:3] = 2'b11;
			end	
		end
		
		
end

endmodule
 