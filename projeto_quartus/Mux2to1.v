module Mux_2_to_1(data1, data2, select, resultado);
input [15:0] data1;
input [15:0] data2;
input select;
output reg [15:0] resultado;
reg [15:0] extData;

//regA or pc or select

always @(data1 or data2 or select) 
begin
    if (select == 1'b0) 
    begin
        resultado = data1;
    end else begin
        resultado = data2;
    end
end
endmodule