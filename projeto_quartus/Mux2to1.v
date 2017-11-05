module Mux_2_to_1(regA, pc, select, saida);
input [4:0] regA;
input [4:0] pc;
input select;
output reg [4:0] saida;

always @(regA or pc or select) 
begin
    if (S == 1'b0) 
    begin
        saida = pc;
    end else begin
        saida = regA;
    end
end
endmodule