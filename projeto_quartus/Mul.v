module Mul (op1, op2, resH, resL, enable, clk);
input [15:0] op1;
input [15:0] op2;
input  enable, clk;
output reg [15:0] resH;
output reg [15:0] resL;
reg [31:0] result;

always @ (clk) begin

	if (enable == 1) begin
		
	result = op1*op2;
	resH[15:0] = result [31:16];
	resL[15:0] = result [15:0];
	
	end

end

endmodule