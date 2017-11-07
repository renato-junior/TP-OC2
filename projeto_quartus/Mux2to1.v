module Mux_2_to_1(regA, pc, select, resultado);
input [3:0] regA;
input [3:0] pc;
input select;
output reg [15:0] resultado;
reg [15:0] extData;

always @(regA or pc or select) 
begin
    if (select == 1'b0) 
    begin
        extData[3:0] = pc;
        extData[15:4] = 12'd0;
        resultado = extData;
    end else begin
        resultado = regA;
    end
end
endmodule