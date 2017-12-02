module Mux_3_to_1(data0, data1, data2, select, resultado, clk);
input [15:0] data0;
input [15:0] data1;
input [15:0] data2;
input [1:0] select;
output reg [15:0] resultado;
input clk;

//data0 or data1 or data2 or select

always @(posedge clk) 
begin
    if (select == 2'b00) 
    begin
        resultado = data0;
    end else if (select == 2'b01) begin
        resultado = data1;
    end else if (select == 2'b10) begin
        resultado = data2;
    end
end
endmodule