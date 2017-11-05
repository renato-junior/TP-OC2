module Mux_2_to_1(regA, pc, select, resultado);
input [4:0] regA;
input [4:0] pc;
input select;
output reg [4:0] resultado;

always @(regA or pc or select) 
begin
    if (S == 1'b0) 
    begin
        resultado = pc;
    end else begin
        resultado = regA;
    end
end
endmodule