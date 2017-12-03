module Mux_4_to_1(data0, data1, data2, data3, select, resultado, clk);
input [15:0] data0;
input [15:0] data1;
input [15:0] data2;
input [15:0] data3;
input [1:0] select;
output reg [15:0] resultado;
input clk;

//data0 or data1 or data2 or select

always @(data0 or data1 or data2 or data3 or select) 
begin
    if (select == 2'b00) 
    begin
        resultado = data0;
    end else if (select == 2'b01) begin
        resultado = data1;
    end else if (select == 2'b10) begin
        resultado = data2;
    end else if (select == 2'b11) begin
		  resultado = data3;
		  end
end
endmodule