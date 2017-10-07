module ALU(codop, operando1, operando2, resultado);
input [3:0] codop;
input [15:0] operando1;
input [15:0] operando2;
input [15:0] resultado;

always @(posedge clk)
begin
	if(codop == 4'd0){
		resultado = operando1 + operando2;
	} else if(codop == 4'd1){
		resultado = operando1 - operando2;
	} else if(codop == 4'd2){
		if(operando1 > operando2){
			resultado = 16'd1;
		} else {
			resultado = 16'd0;
		}
	}
		
	endcase
end

endmodule
