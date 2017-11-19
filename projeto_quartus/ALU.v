module ALU(clk, codop, operando1, operando2, resultado, neg, zero, overflow, mulH, mulL);
input clk;
input [3:0] codop;
input [15:0] operando1;
input [15:0] operando2;
input mulH;
input mulL;
output reg [15:0] resultado;
output reg neg;
output reg zero;
output reg overflow;

always @(codop or operando1 or operando2 or clk)
begin
	zero = 0;
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
			resultado = operando2 - operando1;
			neg <= resultado[15];
         overflow <= (operando2[15] & ~operando1[15] & ~resultado[15]) | (~operando2[15] & operando1[15] & resultado[15]);
		end
		4'd11: begin
			resultado = operando1;
		end
		4'd12: begin
			if (operando1 == 0) begin
				resultado = operando2;
				zero = 1;
			end
		end
		4'd13: begin
			resultado = mulH;
		end
		4'd14: begin
			resultado = mulL;
		end		
	endcase
end

endmodule
