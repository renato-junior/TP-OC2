module Mux_2_to_1(regA, pc, select, resultado, clk);
input [3:0] regA;
input [3:0] pc;
input select, clk;
output reg [15:0] resultado;
reg [15:0] extData;

//regA or pc or select

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