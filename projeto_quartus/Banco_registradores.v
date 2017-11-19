module Banco_registradores(regA, regB, dado, regC, RW, clk, regsaidaA, regsaidaB);
input [3:0] regA;
input [3:0] regB;
input [15:0] dado;
input [3:0] regC;
input RW; //0 - leitura / 1 - escrita
input clk;
output reg [15:0] regsaidaA;
output reg [15:0] regsaidaB;

reg [15:0] registradores [15:0];

integer i;

initial begin
	for(i = 0; i < 16; i=i+1) begin
		registradores[i] <= 16'b0;
	end
end



always @(regA or regB or regC or dado or RW or clk)
begin

		regsaidaA <= registradores[regA][15:0];
		
		regsaidaB <= registradores[regB][15:0];

end


always @(negedge clk) 			// fas a escrita na borda de descida, depois da leitura
		begin
		
			if (RW==1) begin
		registradores[regC] = dado;
			end
			
		end

endmodule
