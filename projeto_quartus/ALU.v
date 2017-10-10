module ALU(clk, codop, operando1, operando2, resultado, neg, zero, overflow);
input clk;
input [3:0] codop;
input [15:0] operando1;
input [15:0] operando2;
output reg [15:0] resultado;
output reg neg;
output reg zero;
output reg overflow;

always @(posedge clk)
begin
	case (codop)
		4'd0: begin
			resultado = operando1 + operando2;
			neg <= resultado[15];
         overflow <= (~operando1[15] & ~operando2[15] & resultado[15]) | (operando1[15] & operando2[15] & ~resultado[15]);
		end
		4'd1: begin
			resultado = operando1 - operando2;
			neg <= resultado[15];
         overflow <= (operando1[15] & ~operando2[15] & ~resultado[15]) | (~operando1[15] & operando2[15] & resultado[15]);
		end
		4'd2: begin
			if(operando1 > operando2) begin
				resultado = 16'd1;
			end else begin
				resultado = 16'd0;
			end
		end
		4'd3: begin
			resultado = operando1 & operando2;
		end
		4'd4: begin
			resultado = operando1 | operando2;
		end
		4'd5: begin
			resultado = operando1 ^ operando2;
		end
		4'd6: begin
			resultado = operando1 & operando2;
		end
		4'd7: begin
			resultado = operando1 | operando2;
		end
		4'd8: begin
			resultado = operando1 ^ operando2;
		end
		4'd9: begin
			resultado = operando1 + operando2;
			neg <= resultado[15];
         overflow <= (~operando1[15] & ~operando2[15] & resultado[15]) | (operando1[15] & operando2[15] & ~resultado[15]);
		end
		4'd10: begin
			resultado = operando1 - operando2;
			neg <= resultado[15];
         overflow <= (operando1[15] & ~operando2[15] & ~resultado[15]) | (~operando1[15] & operando2[15] & resultado[15]);
		end
	endcase
end

endmodule
