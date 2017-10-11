module conversor7segmentos(clk, dado, z);
input clk;
input [3:0] dado;
output reg [6:0] z;

always @(posedge clk)
begin
	case(dado)
		4'b0000 : z = 7'b0111111;
		4'b0001 : z = 7'b0000110;
		4'b0010 : z = 7'b1101101; 
		4'b0011 : z = 7'b1111001;
		4'b0100 : z = 7'b1100110;
		4'b0101 : z = 7'b1101101;  
		4'b0110 : z = 7'b1111101;
		4'b0111 : z = 7'b0000111;
		4'b1000 : z = 7'b1111111;
		4'b1001 : z = 7'b1101111;
		4'b1010 : z = 7'b1110111; 
		4'b1011 : z = 7'b1111100;
		4'b1100 : z = 7'b0111001;
		4'b1101 : z = 7'b1011110;
		4'b1110 : z = 7'b1111001;
		4'b1111 : z = 7'b1110001;
	endcase


end
endmodule
